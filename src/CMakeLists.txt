set_pack_icon(blocks/stone/stonebrick.xcf) 
install(FILES "pack.mcmeta" DESTINATION "pack")

add_subdirectory(blocks)
add_subdirectory(environment)
add_subdirectory(equipment)
add_subdirectory(gui)
add_subdirectory(items)
add_subdirectory(redstone)
add_subdirectory(utilities)

add_simple_texture(particles particles.xcf particle/particles.png)
