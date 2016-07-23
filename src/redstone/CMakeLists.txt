
add_texture_variants(TARGET redstone_torch
    SOURCE redstone_torch.xcf
    VARIANTS "^on" "^off"
    DESTINATION blocks/redstone_torch_on.png blocks/redstone_torch_off.png) 

add_texture_variants(TARGET redstone_repeater
    SOURCE repeater.xcf
    VARIANTS "^on" "^off"
    DESTINATION blocks/repeater_on.png blocks/repeater_off.png) 
    
add_texture(TARGET hopper
    SOURCE hopper_top.png hopper_outside.png hopper_bottom.png
    DESTINATION blocks/hopper_top.png blocks/hopper_outside.png blocks/hopper_bottom.png)
    
add_texture(TARGET redstone_dust
    SOURCE redstone_dust_cross.xcf redstone_dust_line.xcf redstone_dust_cross_overlay.png redstone_dust_line_overlay.png
    DESTINATION blocks/redstone_dust_cross.png blocks/redstone_dust_line.png blocks/redstone_dust_cross_overlay.png blocks/redstone_dust_line_overlay.png)
    
add_simple_texture(lever lever.xcf blocks/lever.png)

add_models(block hopper_down.json hopper_side.json)
