include(CMakeParseArguments)

find_program(XCF2PNG "xcf2png")
if(NOT XCF2PNG)
    message(SEND_ERROR "The xcf2png program is required. Check that xcf-tools is installed")
endif()

find_program(XCFINFO "xcfinfo")
if(NOT XCFINFO)
    message(SEND_ERROR "The xcfinfo program is required. Check that xcf-tools is installed")
endif()

find_program(OPTIPNG "optipng")
if(NOT OPTIPNG)
    message(SEND_ERROR "The optipng program is required. Check that optipng is installed")
endif()

function(list_xcf_layers_raw _FILE _OUTPUT_VAR)
    
    exec_program("xcfinfo"
            ARGS "-u" "'${_FILE}'"
            OUTPUT_VARIABLE INFO_RAW
            RETURN_VALUE STATUS)
            
    if("${STATUS}")
        message(WARNING "${INFO_RAW}")
        message(FATAL_ERROR "Could not retrieve XCF info from file ${_FILE}. xcfinfo returned code (${STATUS}). Aborting.")
    endif()
    
    string(REPLACE "\n" ";" INFO_LIST ${INFO_RAW})
    
    set(LAYERS "")
    
    # To match: 
    # + 32x32+0+0 RGB-alpha Normal |Borders|border_left
    # + 32x32+0+0 RGB-alpha Normal |border_left
    # + 32x32+0+0 RGB-alpha Normal border_left
    # + 32x32+0+0 RGB-alpha Normal/50% |border_left
    
    # To ignore:
    # + 32x32+0+0 RGB-alpha Normal/group |Borders
    
    foreach(line ${INFO_LIST})
        if("${line}" MATCHES "^(\\-|\\+) ([^ ]* )([^ ]* )([^ /]*(\\/[0-9%]+)? )(\\|.*\\||\\|)?(.*)$")
            list(APPEND LAYERS "${CMAKE_MATCH_1}${CMAKE_MATCH_7}")
        endif()
        
    endforeach()
    
    
    set(LAYERS "${LAYERS}" PARENT_SCOPE)
    
endfunction()

function(request_layer_list)
    
    set(OVA OUTPUT_VARIABLE)
    set(MVA LAYER_LIST ADD REMOVE)
    
    macro(is_in_matchlist _LAYER)
                set(IN_MATCHLIST false)
        foreach(match ${ARGN})
            if("${_LAYER}" MATCHES "${match}")
                set(IN_MATCHLIST true)
                break()
            endif()
        endforeach()
    endmacro()
    
    cmake_parse_arguments(_ "" "${OVA}" "${MVA}" ${ARGN})
    
    set(OUTPUT_LAYERS "")
    
    foreach(layer ${__LAYER_LIST})
        
        if("${layer}" MATCHES "^\\-(.*)")
            set(layer "${CMAKE_MATCH_1}")
            is_in_matchlist("${layer}" ${__ADD})
            
            if(${IN_MATCHLIST})
                list(APPEND OUTPUT_LAYERS "${layer}")
            endif()
            
        elseif("${layer}" MATCHES "^\\+(.*)")
            set(layer "${CMAKE_MATCH_1}")
            
            is_in_matchlist("${layer}" ${__REMOVE})
            if(NOT "${IN_MATCHLIST}")
                list(APPEND OUTPUT_LAYERS "${layer}")
            endif()
            
        endif()
        
    endforeach()
    
    set(${__OUTPUT_VARIABLE} "${OUTPUT_LAYERS}" PARENT_SCOPE)

endfunction()

function(add_xcf_file_base _SOURCE _DESTINATION _COMMENT)
    
    list(REVERSE ARGN)
    
    add_custom_command(
        OUTPUT "${_DESTINATION}"
        COMMAND "xcf2png" ARGS "-u" "-o" "${_DESTINATION}" "${_SOURCE}" ${ARGN}
        COMMAND "optipng" ARGS "-o5" "-quiet" "${_DESTINATION}"
        DEPENDS "${_SOURCE}"
        COMMENT "${_COMMENT}")
    
endfunction()

macro(build_destination _VAR _SOURCE _EXTRA)
    
    get_filename_component("${_VAR}_SOURCE_NAME" "${_SOURCE}" NAME_WE)
    get_filename_component("${_VAR}_SOURCE_DIR" "${_SOURCE}" PATH)
    
    set(${_VAR} "${${_VAR}_SOURCE_DIR}/build-${${_VAR}_SOURCE_NAME}${_EXTRA}.png")
    
endmacro()

function(add_xcf_file _SOURCE _DESTINATION _COMMENT _EXTRA_BUILD)
    
    get_filename_component(DESTINATION_NAME "${_DESTINATION}" NAME)
    get_filename_component(DESTINATION_DIR "${_DESTINATION}" PATH)
    
    build_destination(BUILD_DESTINATION "${_SOURCE}" "${_EXTRA_BUILD}")
    
    add_xcf_file_base("${_SOURCE}" "${BUILD_DESTINATION}" "${_COMMENT}" ${ARGN})
    
    install(FILES "${BUILD_DESTINATION}" DESTINATION "pack/assets/minecraft/${DESTINATION_DIR}" RENAME "${DESTINATION_NAME}")
    
endfunction()

function(set_pack_icon _FILE)

    get_filename_component(SOURCE_NAME "${_FILE}" NAME)
    
    add_xcf_file_base("${CMAKE_CURRENT_LIST_DIR}/${_FILE}" 
        "${CMAKE_CURRENT_LIST_DIR}/pack.png" 
        "Rendering icon ${SOURCE_NAME}")
        
    add_custom_target("pack.png" ALL
                    DEPENDS "${CMAKE_CURRENT_LIST_DIR}/pack.png")
    install(FILES "${CMAKE_CURRENT_LIST_DIR}/pack.png" DESTINATION "pack")

endfunction()

function(add_texture)

    set(OVA TARGET)
    set(MVA SOURCE DESTINATION)
    
    cmake_parse_arguments(_ "" "${OVA}" "${MVA}" ${ARGN})
    
    list(LENGTH __SOURCE _SOURCE_LEN) 
    list(LENGTH __DESTINATION _DESTINATION_LEN) 
    
    if(NOT "${_SOURCE_LEN}" EQUAL "${_DESTINATION_LEN}")
        message(FATAL_ERROR "Invalid input for add_texture: SOURCE and DESTINATION lists lengths do not match.")
    endif()
    
    set(BUILD_DESTINATIONS "")
    
    
    math(EXPR _SOURCE_LEN "${_SOURCE_LEN} - 1")
    
    foreach(i RANGE ${_SOURCE_LEN})
        
        list(GET __SOURCE ${i} SRC)
        list(GET __DESTINATION ${i} DST)
        
        get_filename_component(SOURCE_NAME "${SRC}" NAME)
        get_filename_component(SOURCE_EXT "${SRC}" EXT)
        
        if("${SOURCE_EXT}" STREQUAL ".xcf")
            build_destination(BUILD_DESTINATION "${SRC}" "")
            
            add_xcf_file("${CMAKE_CURRENT_LIST_DIR}/${SRC}" "textures/${DST}" "Rendering texture ${SOURCE_NAME}" "")
            list(APPEND BUILD_DESTINATIONS "${CMAKE_CURRENT_LIST_DIR}/${BUILD_DESTINATION}")
        else()
            get_filename_component(DESTINATION_NAME "${DST}" NAME)
            get_filename_component(DESTINATION_DIR "${DST}" PATH)
            
            install(FILES "${SRC}" DESTINATION "pack/assets/minecraft/textures/${DESTINATION_DIR}" RENAME "${DESTINATION_NAME}")
        endif()
        
    endforeach()
    
    add_custom_target("${__TARGET}" ALL
                    DEPENDS ${BUILD_DESTINATIONS})

endfunction()

function(add_texture_variants)

    set(OVA TARGET SOURCE)
    set(MVA VARIANTS DESTINATION)
    
    cmake_parse_arguments(_ "" "${OVA}" "${MVA}" ${ARGN})
    
    list(LENGTH __VARIANTS _VARIANTS_LEN) 
    list(LENGTH __DESTINATION _DESTINATION_LEN) 
    
    if(NOT "${_VARIANTS_LEN}" EQUAL "${_DESTINATION_LEN}")
        message(FATAL_ERROR "Invalid input for add_texture_variants: VARIANTS and DESTINATION lists lengths do not match.")
    endif()
    
    set(BUILD_DESTINATIONS "")
    
    list_xcf_layers_raw("${CMAKE_CURRENT_LIST_DIR}/${__SOURCE}" LAYERS)
    
    math(EXPR _VARIANTS_LEN "${_VARIANTS_LEN} - 1")
    
    foreach(i RANGE ${_VARIANTS_LEN})
        
        list(GET __VARIANTS ${i} VARIANT)
        list(GET __DESTINATION ${i} DST)
        
        set(remaining_variants ${__VARIANTS})
        list(REMOVE_ITEM remaining_variants ${VARIANT})
        
        request_layer_list(OUTPUT_VARIABLE variant_layers
            LAYER_LIST ${LAYERS}
            ADD ${VARIANT}
            REMOVE ${remaining_variants})
            
        
        get_filename_component(SOURCE_NAME "${__SOURCE}" NAME)
        build_destination(BUILD_DESTINATION "${__SOURCE}" "-${i}")
        
        add_xcf_file("${CMAKE_CURRENT_LIST_DIR}/${__SOURCE}" "textures/${DST}" "Rendering texture ${SOURCE_NAME} (${VARIANT})" "-${i}" ${variant_layers})
        list(APPEND BUILD_DESTINATIONS "${CMAKE_CURRENT_LIST_DIR}/${BUILD_DESTINATION}")
        
    endforeach()
    
    add_custom_target("${__TARGET}" ALL
                    DEPENDS ${BUILD_DESTINATIONS})

endfunction()

function(add_simple_texture _TARGET _SOURCE _DESTINATION)

    add_texture(TARGET ${_TARGET} SOURCE ${_SOURCE} DESTINATION ${_DESTINATION})

endfunction()

function(add_models _SUBDIR)
    
    foreach(model ${ARGN})
        install(FILES "${CMAKE_CURRENT_LIST_DIR}/${model}" DESTINATION "pack/assets/minecraft/models/${_SUBDIR}")
    endforeach()
    
endfunction()

function(add_blockstates)

    foreach(blockstate ${ARGN})
        install(FILES "${CMAKE_CURRENT_LIST_DIR}/${blockstate}" DESTINATION "pack/assets/minecraft/blockstates")
    endforeach()

endfunction()
