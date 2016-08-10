add_texture(TARGET enchanting_table
    SOURCE enchanting_table_top.png enchanting_table_bottom.xcf enchanting_table_side.png enchanting_table_book.png
    DESTINATION blocks/enchanting_table_top.png blocks/enchanting_table_bottom.png blocks/enchanting_table_side.png entity/enchanting_table_book.png)

add_texture_variants(TARGET chest
    SOURCE chest_normal.xcf
    VARIANTS ^$ ^trapped
    DESTINATION entity/chest/normal.png entity/chest/trapped.png)

add_texture_variants(TARGET chest_double
    SOURCE chest_double.xcf
    VARIANTS ^$ ^trapped
    DESTINATION entity/chest/normal_double.png entity/chest/trapped_double.png)
