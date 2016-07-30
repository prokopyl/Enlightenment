add_texture(TARGET wood_log 
    SOURCE 
        log_acacia.xcf 
        log_big_oak.xcf 
        log_birch.xcf 
        log_jungle.xcf 
        log_oak.xcf 
        log_spruce.xcf
    DESTINATION 
        blocks/log_acacia.png
        blocks/log_big_oak.png 
        blocks/log_birch.png 
        blocks/log_jungle.png 
        blocks/log_oak.png 
        blocks/log_spruce.png
) 

add_texture(TARGET wood_log_top
    SOURCE 
        log_acacia_top.png 
        log_big_oak_top.png 
        log_birch_top.png 
        log_jungle_top.xcf 
        log_oak_top.xcf 
        log_spruce_top.png
    DESTINATION 
        blocks/log_acacia_top.png 
        blocks/log_big_oak_top.png 
        blocks/log_birch_top.png 
        blocks/log_jungle_top.png
        blocks/log_oak_top.png
        blocks/log_spruce_top.png
) 

add_texture_variants(TARGET wood_planks
    SOURCE planks.xcf
    VARIANTS
        _acacia$
        _bigoak$
        _birch$
        _jungle$
        _oak$
        _spruce$
    DESTINATION 
        blocks/planks_acacia.png
        blocks/planks_big_oak.png
        blocks/planks_birch.png
        blocks/planks_jungle.png
        blocks/planks_oak.png
        blocks/planks_spruce.png
) 
