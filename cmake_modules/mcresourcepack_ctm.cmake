include(CMakeParseArguments)

set(CTM_CLASSIC_CONTENTS
    "BORDER_TOP,BORDER_LEFT,BORDER_RIGHT,BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #0
    "BORDER_TOP,BORDER_LEFT,BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #1
    "BORDER_TOP,BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #2
    "BORDER_TOP,BORDER_RIGHT,BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #3
    "BORDER_TOP,BORDER_LEFT,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #4
    "BORDER_TOP,BORDER_RIGHT,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #5
    "BORDER_LEFT,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #6
    "BORDER_TOP,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #7
    "CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT" #8
    "CORNER_BOTTOMLEFT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #9
    "CORNER_BOTTOMRIGHT,CORNER_TOPRIGHT" #10
    "CORNER_BOTTOMRIGHT,CORNER_BOTTOMLEFT" #11
    "BORDER_TOP,BORDER_LEFT,BORDER_RIGHT,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #12
    "BORDER_TOP,BORDER_LEFT,CORNER_BOTTOMLEFT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #13
    "BORDER_TOP,CORNER_TOPLEFT,CORNER_TOPRIGHT" #14
    "BORDER_TOP,BORDER_RIGHT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #15
    "BORDER_LEFT,BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #16
    "BORDER_RIGHT,BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #17
    "BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #18
    "BORDER_RIGHT,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #19
    "CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPRIGHT" #20
    "CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #21
    "CORNER_BOTTOMLEFT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #22
    "CORNER_BOTTOMLEFT,CORNER_TOPLEFT" #23
    "BORDER_LEFT,BORDER_RIGHT,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #24
    "BORDER_LEFT,CORNER_TOPLEFT,CORNER_BOTTOMLEFT" #25
    "" #26
    "BORDER_RIGHT,CORNER_TOPRIGHT,CORNER_BOTTOMRIGHT" #27
    "BORDER_LEFT,CORNER_TOPLEFT,CORNER_TOPRIGHT,CORNER_BOTTOMLEFT" #28
    "BORDER_TOP,CORNER_TOPLEFT,CORNER_TOPRIGHT,CORNER_BOTTOMLEFT" #29
    "BORDER_LEFT,CORNER_TOPLEFT,CORNER_TOPRIGHT,CORNER_BOTTOMLEFT" #30
    "BORDER_LEFT,CORNER_TOPLEFT,CORNER_TOPRIGHT,CORNER_BOTTOMLEFT" #31
    "CORNER_BOTTOMRIGHT" #32
    "CORNER_BOTTOMLEFT" #33
    "CORNER_TOPLEFT,CORNER_BOTTOMRIGHT" #34
    "CORNER_BOTTOMLEFT,CORNER_TOPRIGHT" #35
    "BORDER_BOTTOM,BORDER_LEFT,BORDER_RIGHT,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #36
    "BORDER_BOTTOM,BORDER_LEFT,CORNER_BOTTOMLEFT,CORNER_TOPLEFT,CORNER_BOTTOMRIGHT" #37
    "BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT" #38
    "BORDER_BOTTOM,BORDER_RIGHT,CORNER_BOTTOMRIGHT,CORNER_BOTTOMLEFT,CORNER_TOPRIGHT" #39
    "BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT" #40
    "BORDER_RIGHT,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPRIGHT" #41
    "BORDER_BOTTOM,CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPRIGHT" #42
    "BORDER_RIGHT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #43
    "CORNER_TOPRIGHT" #44
    "CORNER_TOPLEFT" #45
    "CORNER_BOTTOMLEFT,CORNER_BOTTOMRIGHT,CORNER_TOPLEFT,CORNER_TOPRIGHT" #46
)

set(CTM_PARTS BORDER_BOTTOM BORDER_LEFT BORDER_RIGHT BORDER_TOP CORNER_BOTTOMLEFT CORNER_BOTTOMRIGHT CORNER_TOPLEFT CORNER_TOPRIGHT)

function(add_tile_variant _TARGET _TILE_ID _FILE_ID)
    
    get_property(TILE_VARIANTS DIRECTORY PROPERTY "CTM_TILE_VARIANTS_${_TARGET}_${_TILE_ID}")
    set_property(DIRECTORY PROPERTY "CTM_TILE_VARIANTS_${_TARGET}_${_TILE_ID}" ${TILE_VARIANTS} ${_FILE_ID})
    
endfunction()

function(add_ctm_texture)

    set(OVA TARGET SOURCE PROPERTIES_FILE ${CTM_PARTS})
    set(MVA VARIANTS ADD_LAYERS REMOVE_LAYERS)
            
    cmake_parse_arguments(_ "" "${OVA}" "${MVA}" ${ARGN})
    
    list_xcf_layers_raw("${CMAKE_CURRENT_LIST_DIR}/${__SOURCE}" LAYERS)
    
    list(LENGTH __VARIANTS _VARIANTS_LEN)
    
    if("${_VARIANTS_LEN}" EQUAL 0)
        set(__VARIANTS "^$")
        set(_VARIANTS_LEN 1)
    endif()
    
    math(EXPR _VARIANTS_LEN "${_VARIANTS_LEN} - 1")
    
    set(file_id "0")
    
    
    foreach(i RANGE ${_VARIANTS_LEN})
        
        list(GET __VARIANTS ${i} VARIANT)
        
        set(remaining_variants ${__VARIANTS})
        list(REMOVE_ITEM remaining_variants ${VARIANT})
        
        add_ctm_texture_base("${LAYERS}" ${file_id}
            TARGET ${__TARGET}
            SOURCE ${__SOURCE}
            PROPERTIES_FILE ${__PROPERTIES_FILE}
            BORDER_BOTTOM ${__BORDER_BOTTOM}
            BORDER_LEFT ${__BORDER_LEFT}
            BORDER_RIGHT ${__BORDER_RIGHT}
            BORDER_TOP ${__BORDER_TOP}
            CORNER_BOTTOMLEFT ${__CORNER_BOTTOMLEFT}
            CORNER_BOTTOMRIGHT ${__CORNER_BOTTOMRIGHT}
            CORNER_TOPLEFT ${__CORNER_TOPLEFT}
            CORNER_TOPRIGHT ${__CORNER_TOPRIGHT}
            ADDLAYERS ${VARIANT} ${__ADD_LAYERS}
            REMOVELAYERS ${remaining_variants} ${__REMOVE_LAYERS}
        )
        
        math(EXPR file_id "${file_id} + 1")
        
        set(ALL_BUILD_DESTINATIONS ${ALL_BUILD_DESTINATIONS} ${BUILD_DESTINATIONS})
        
    endforeach()
    
    add_custom_target("${__TARGET}" ALL
                    DEPENDS ${ALL_BUILD_DESTINATIONS})
                    
    write_ctm_files("${__TARGET}" "${CMAKE_CURRENT_LIST_DIR}/${__PROPERTIES_FILE}")
                    
    install(FILES "${CMAKE_CURRENT_LIST_DIR}/${__PROPERTIES_FILE}" DESTINATION "pack/assets/minecraft/mcpatcher/ctm/${__TARGET}/")
    
endfunction()

function(add_ctm_texture_base _LAYERS _I)
    
    macro(part_to_variant _OUT_VARIABLE)
        set(${_OUT_VARIABLE} "")
        foreach(part ${ARGN})
            list(APPEND ${_OUT_VARIABLE} ${__${part}})
        endforeach()
    endmacro()
    
    set(OVA TARGET SOURCE PROPERTIES_FILE ${CTM_PARTS})
    set(MVA ADDLAYERS REMOVELAYERS)
            
    cmake_parse_arguments(_ "" "${OVA}" "${MVA}" ${ARGN})
    
    set(DESTINATION "${__TARGET}")
    
    set(BUILD_DESTINATIONS "")
    
    foreach(i RANGE 46)
        list(GET CTM_CLASSIC_CONTENTS ${i} tile_contents)
        math(EXPR file_id "${i} + ${_I}")
        string(REPLACE "," ";" tile_contents "${tile_contents}")
        
        set(remaining_parts ${CTM_PARTS})
        list(REMOVE_ITEM remaining_parts "" ${tile_contents})
        
        part_to_variant(tile_variants ${tile_contents})
        part_to_variant(remaining_variants ${remaining_parts})
        
        request_layer_list(OUTPUT_VARIABLE variant_layers
            LAYER_LIST ${_LAYERS}
            ADD ${tile_variants} ${__ADDLAYERS}
            REMOVE ${remaining_variants} ${__REMOVELAYERS})
        
        get_filename_component(SOURCE_NAME "${__SOURCE}" NAME)
        build_destination(BUILD_DESTINATION "${__SOURCE}" "-${file_id}" "${__TARGET}")
        add_xcf_file("${CMAKE_CURRENT_LIST_DIR}/${__SOURCE}" "mcpatcher/ctm/${DESTINATION}/${file_id}.png" "Rendering CTM texture ${SOURCE_NAME} (#${file_id})" "-${file_id}" "${__TARGET}" ${variant_layers})
        list(APPEND BUILD_DESTINATIONS "${CMAKE_CURRENT_LIST_DIR}/${BUILD_DESTINATION}")
        
        add_tile_variant(${__TARGET} ${i} ${file_id})
        
    endforeach()
    set(file_id "${file_id}" PARENT_SCOPE)
    set(BUILD_DESTINATIONS ${BUILD_DESTINATIONS} PARENT_SCOPE)
    
endfunction()

function(write_ctm_files _TARGET _FILE)

    if(NOT EXISTS "${_FILE}")
        file(WRITE "${_FILE}" 
                "matchBlocks=<MATCHING BLOCKS HERE>\n"
                "method=ctm\n"
                "tiles=0-46\n")
    endif()
                         
    get_filename_component(CTM_DIR "${_FILE}" PATH)
    get_filename_component(CTM_FILENAME "${_FILE}" NAME_WE)
    
    foreach(i RANGE 46)
        get_property(TILE_VARIANTS DIRECTORY PROPERTY "CTM_TILE_VARIANTS_${__TARGET}_${i}")
        list(LENGTH TILE_VARIANTS TILE_VARIANTS_LEN)
        
        if(${TILE_VARIANTS_LEN} GREATER 1)
            if(NOT EXISTS "${CTM_DIR}/${CTM_FILENAME}_${i}.properties")
                string(REPLACE ";" " " TILE_LIST "${TILE_VARIANTS}")
                file(WRITE "${CTM_DIR}/${CTM_FILENAME}_${i}.properties"
                    "matchTiles=~/ctm/${__TARGET}/${i}.png\n"
                    "method=random\n"
                    "tiles=${TILE_LIST}")
                
            endif()
            
            install(FILES "${CTM_DIR}/${CTM_FILENAME}_${i}.properties" DESTINATION "pack/assets/minecraft/mcpatcher/ctm/${__TARGET}/")
        endif()
        
    endforeach()
    
endfunction()

function(add_random_texture)
    
    set(OVA TARGET SOURCE PROPERTIES_FILE)
    set(MVA VARIANTS ADD_LAYERS REMOVE_LAYERS)
            
    cmake_parse_arguments(_ "" "${OVA}" "${MVA}" ${ARGN})
    
    list(LENGTH __VARIANTS _VARIANTS_LEN)
    math(EXPR _VARIANTS_LEN "${_VARIANTS_LEN} - 1")
    
    set(DESTINATIONS "")
    
    foreach(i RANGE ${_VARIANTS_LEN})
        
        list(APPEND DESTINATIONS "../mcpatcher/ctm/${__TARGET}/${i}.png")
        
    endforeach()
    
    add_texture_variants(TARGET "${__TARGET}"
        SOURCE "${__SOURCE}"
        VARIANTS ${__VARIANTS}
        DESTINATION ${DESTINATIONS}
        ADD_LAYERS ${__ADD_LAYERS}
        REMOVE_LAYERS ${__REMOVE_LAYERS}
    )
    
    install(FILES "${CMAKE_CURRENT_LIST_DIR}/${__PROPERTIES_FILE}" DESTINATION "pack/assets/minecraft/mcpatcher/ctm/${__TARGET}/")
    
endfunction()
