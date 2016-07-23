add_texture(TARGET ores
    SOURCE 
        coal_ore.xcf 
        diamond_ore.xcf 
        emerald_ore.xcf 
        gold_ore.xcf 
        iron_ore.xcf 
        lapis_ore.xcf
        redstone_ore.xcf
    DESTINATION 
        blocks/coal_ore.png
        blocks/diamond_ore.png
        blocks/emerald_ore.png
        blocks/gold_ore.png
        blocks/iron_ore.png
        blocks/lapis_ore.png
        blocks/redstone_ore.png
)  

add_blockstates(
    blockstates/coal_ore.json 
    blockstates/diamond_ore.json 
    blockstates/emerald_ore.json 
    blockstates/gold_ore.json 
    blockstates/iron_ore.json 
    blockstates/lapis_ore.json 
    blockstates/redstone_ore.json)
    
add_models(block
    models/coal_ore_mirrored.json 
    models/diamond_ore_mirrored.json 
    models/emerald_ore_mirrored.json 
    models/gold_ore_mirrored.json 
    models/iron_ore_mirrored.json 
    models/lapis_ore_mirrored.json 
    models/redstone_ore_mirrored.json)
