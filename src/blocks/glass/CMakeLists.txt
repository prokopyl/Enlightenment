add_simple_texture(glass glass.xcf blocks/glass.png)

add_ctm_texture(TARGET glass_clear
    SOURCE glass.xcf
    PROPERTIES_FILE ctm/glass.properties
    BORDER_BOTTOM ^border_bottom
    BORDER_LEFT ^border_left
    BORDER_RIGHT ^border_right
    BORDER_TOP ^border_top
    CORNER_BOTTOMLEFT ^corner_bottomleft
    CORNER_BOTTOMRIGHT ^corner_bottomright
    CORNER_TOPLEFT ^corner_topleft
    CORNER_TOPRIGHT ^corner_topright
    VARIANTS "reflection_a$" "reflection_b$" "reflection_c$" "reflection_d$"
)
    
