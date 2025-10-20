extern float time;
extern float prog;

vec4 effect(vec4 color, Image texture,vec2 tCoords,vec2 sCoords){
    vec4 pixel=Texel(texture,tCoords);

    float wavePix = sin(tCoords.x*8 + time*10)/16;

    if (tCoords.y>wavePix+prog){
        return vec4(0,0,0,1);
    }
    else {
        return pixel*color;
    }
    
}