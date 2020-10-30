#ifndef T420BABE_2D_RANDOM_TRUCHET
#define T420BABE_2D_RANDOM_TRUCHET

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

float random (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

vec2 truchet_pattern(in vec2 _st, in float _index){
    _index = fract(((_index-0.5)*2.0));
    if (_index > 0.75) {
        _st = vec2(1.0) - _st;
    } else if (_index > 0.5) {
        _st = vec2(1.0-_st.x,_st.y);
    } else if (_index > 0.25) {
        _st = 1.0-vec2(1.0-_st.x,_st.y);
    }
    return _st;
}

float float_2d_random_truchet(vec2 pos, float u_time, peakamp audio) {
    // vec2 st = gl_FragCoord.xy/u_resolution.xy;
    pos *= 10.0;
    // pos = (pos-vec2(5.0))*(abs(sin(u_time*0.2))*5.);
    // pos.x += u_time*3.0;

    vec2 ipos = floor(pos);  // integer
    vec2 fpos = fract(pos);  // fraction

    vec2 tile = truchet_pattern(fpos, random( ipos ));

    float truchet = 0.0;

    // Maze
    truchet = smoothstep(tile.x-0.3,tile.x,tile.y)-
            smoothstep(tile.x,tile.x+0.3,tile.y);

    // Circles
    truchet = (step(length(tile),0.6) -
             step(length(tile),0.4) ) +
            (step(length(tile-vec2(1.)),0.6) -
             step(length(tile-vec2(1.)),0.4) );

    // Truchet (2 triangles)
    // truchet = step(tile.x, tile.y);
    return truchet;
}
void main_2d_random_truchet(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
    // vec2 st = gl_FragCoord.xy/u_resolution.xy;
    pos *= 10.0;
    // pos = (pos-vec2(5.0))*(abs(sin(u_time*0.2))*5.);
    // pos.x += u_time*3.0;

    vec2 ipos = floor(pos);  // integer
    vec2 fpos = fract(pos);  // fraction

    vec2 tile = truchet_pattern(fpos, random( ipos ));

    float truchet = 0.0;

    // Maze
    truchet = smoothstep(tile.x-0.3,tile.x,tile.y)-
            smoothstep(tile.x,tile.x+0.3,tile.y);

    // Circles
    truchet *= (step(length(tile),0.6) -
             step(length(tile),0.4) ) +
            (step(length(tile-vec2(1.)),0.6) -
             step(length(tile-vec2(1.)),0.4) );

    // Truchet (2 triangles)
    // truchet = step(tile.x, tile.y);
    color = vec3(truchet);
}

#endif
