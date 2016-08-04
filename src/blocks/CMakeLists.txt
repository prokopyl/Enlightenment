
add_subdirectory(ores) 
add_subdirectory(stone) 
add_subdirectory(wood) 
add_subdirectory(glass) 
add_subdirectory(sand)

add_simple_texture(coal_block coal_block.xcf blocks/coal_block.png)
add_simple_texture(dirt dirt.xcf blocks/dirt.png)
add_simple_texture(obsidian obsidian.xcf blocks/obsidian.png)
add_simple_texture(cobblestone cobblestone.png blocks/cobblestone.png)

add_texture(TARGET grass
    SOURCE grass_side.xcf grass_side_overlay.png grass_top.png
    DESTINATION blocks/grass_side.png blocks/grass_side_overlay.png blocks/grass_top.png)

add_texture_variants(TARGET brick 
    SOURCE bricks.xcf 
    VARIANTS ^$ nether$ redbrick$
    DESTINATION blocks/brick.png blocks/nether_brick.png blocks/red_nether_brick.png)
    
add_random_texture(TARGET random_brick
    PROPERTIES_FILE bricks.properties
    SOURCE bricks.xcf
    VARIANTS ^bricks1$ ^bricks2$ ^bricks3$ ^bricks4$ ^bricks5$
    REMOVE_LAYERS nether$ redbrick$)

add_random_texture(TARGET random_brick_nether
    PROPERTIES_FILE bricks_nether.properties
    SOURCE bricks.xcf
    VARIANTS ^bricks1$ ^bricks2$ ^bricks3$ ^bricks4$ ^bricks5$
    ADD_LAYERS nether$
    REMOVE_LAYERS redbrick$)

add_random_texture(TARGET random_brick_nether_red
    PROPERTIES_FILE bricks_nether_red.properties
    SOURCE bricks.xcf
    VARIANTS ^bricks1$ ^bricks2$ ^bricks3$ ^bricks4$ ^bricks5$
    ADD_LAYERS redbrick$
    REMOVE_LAYERS nether$)
