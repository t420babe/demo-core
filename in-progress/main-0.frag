#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

uniform sampler2D u_tex0;
uniform sampler2D u_tex1;

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

// #ifndef T420BABE_SHARP_HEART
// #include "./lib/t420babe/doppler-heart.glsl"
// #endif

// #ifndef T420BABE_CASH
// #ifndef PXL_HEXAGON
// #include "./lib/pxl/hex-sdf.glsl"
// #endif
//
// #ifndef BOS_CLOUDS_HA
// #include "./lib/bos/clouds-ha.glsl"
// #endif
//
// #ifndef BOS_2D_CNOISE_2X2X2_FUCK_WIT
// #include "./lib/bos/2d-cnoise-2x2x2-fuck-wit.glsl"
// #endif

#ifndef T420BABE_2D_RANDOM_TRUCHET

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

float flower_sdf(vec2 st, int N, peakamp audio) {
    // st = st*2.-1.;
    float r = length(st)*2.;
    float a = atan(st.y,st.x);
    float v = float(N)*5.0 * audio.bandpass;
    return 1.-(abs(cos(a*v))*.5+.5)/r;
}

// wood_brother_louie
float geo_hexagon(vec2 pos, float size, peakamp audio) {
  pos = abs(pos * 1.0);
  pos /= size;
  float hexagon = 1.0;
  // if (audio.notch * 100.0 > 100.0) {
  // if (audio.bandpass > 0.9) {
  // if (audio.bandpass > 0.5) {
  // if (audio.notch > 0.5) {
  if (audio.notch > 0.4) {
  // if (full_max > 100.0) {
    hexagon =  max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.5);
  }  else {
    hexagon =  max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.0);
  }
  return hexagon;
}

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
	vec3 color = vec3(1.0);

  // float n = cnoise_2d_2x2x2_fuck_wit(pos, u_time, audio);
  // color = vec3(n * sin(u_time), n, n * audio.lowpass);
  // main_2d_random_truchet(pos, u_time, audio, color);

  // float flower = sharp(flower_sdf(pos, 5, audio));
  float flower = sharp(geo_hexagon(pos, audio.lowpass * 10.0, audio));
  // float flower = sharp(hexagon_wood(pos, audio.lowpass));
  float truchet = float_2d_random_truchet(pos, u_time, audio);
  
  color.b = (flower * audio.lowpass);
  color.b -= truchet;
  
  // color.b = truchet;
  // color.b *= (flower * audio.lowpass);

  // color -= vec3(flower * audio.lowpass);

  // vec3 flower_color = vec3(flower);
  //
  vec3 truchet_color = vec3(1.0);
  // main_2d_random_truchet(pos, u_time, audio, truchet_color);

  // color *= flower;
  color.g *= audio.notch;
  // color += truchet_color;
  gl_FragColor = vec4( color , 1.0);
}
