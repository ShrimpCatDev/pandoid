extern float time;

vec4 effect(vec4 color, Image texture,vec2 tCoords,vec2 sCoords){
    vec4 pixel=Texel(texture,tCoords);
    return pixel*color;
}