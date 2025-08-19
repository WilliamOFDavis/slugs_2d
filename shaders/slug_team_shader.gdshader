shader_type canvas_item;

uniform vec4 team_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 skin_color : source_color = vec4(0.6, 0.898, 0.314, 1.0);
uniform float color_tolerance : hint_range(0.0, 1.0) = 0.1;

void fragment() {
    COLOR = texture(TEXTURE, UV);
    
    if(distance(COLOR.rgb, skin_color.rgb) < color_tolerance){
        COLOR = team_color;
    }
}
