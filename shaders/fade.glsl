extern float time;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color


    if (texture_coords.y>cos(screen_coords.x/512+time)/16+0.5){
        pixel.a = clamp(1.0 - texture_coords.y, 0.0, 1.0);
    }
    else{
        pixel.a=texture_coords.y+0.2;
    }
    
    return pixel * color;
}