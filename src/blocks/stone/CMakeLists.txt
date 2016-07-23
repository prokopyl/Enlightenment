
add_simple_texture(stone stone.xcf blocks/stone.png)

add_texture(TARGET stone_slab 
    SOURCE stone_slab.xcf stone_slab_side.xcf 
    DESTINATION blocks/stone_slab_top.png blocks/stone_slab_side.png) 
    
add_texture(TARGET stonebrick
    SOURCE stonebrick.xcf stonebrick_cracked.xcf stonebrick_mossy.xcf
    DESTINATION blocks/stonebrick.png blocks/stonebrick_cracked.png blocks/stonebrick_mossy.png) 
    
add_models(block models/double_stone_top_mirrored.json)
add_blockstates(blockstates/stone.json blockstates/stone_slab.json blockstates/stone_double_slab.json)

add_simple_texture(andesite stone_andesite.png blocks/stone_andesite.png)
