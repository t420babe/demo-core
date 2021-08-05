// #shape #shadershoot #trippy #seizure #circle #favs
#ifndef T420BABE_WO_10
#define T420BABE_WO_10

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef BOS_TURBULENCE
#include "./lib/bos/turbulence.glsl"
#endif

vec2 mirror_tile(vec2 _pos, float _zoom){
    _pos *= _zoom;
    if (fract(_pos.y * 0.5) < 0.5){
        _pos.x = _pos.x+0.5;
        _pos.y = _pos.y * 0.1;
    }
    return log(_pos);
}

float fillY(vec2 _pos, float _pct,float _antia){
  return  smoothstep( _pct-_antia, _pct, _pos.y);
}

float _zigzag(vec2 pos, float u_time, peakamp audio) {

  float zoom = 105.0;
  pos = mirror_tile(pos * vec2(1.0, 8.0), zoom);
  float x = pos.y * 1.0;
  float a = tan(x / 3.14) + 0.5;
  float b = 1.0 * log(x * 3.14);
  float f = exp(x * 3.14);
  // float f = sin(x * u_time);

  return fillY(pos, mix(a * abs(audio.bandpass), b * abs(audio.bandpass), f), 0.01) ;
}
void zigzag(vec2 pos, float u_time, peakamp audio, inout vec3 color){
  color = vec3( _zigzag(pos, u_time, audio));
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius * 0.5;
}


//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(
        abs( mod( c.x * 6.0 + vec3(0.0, -1.5, 2.0), 6.0 ) - 2.0 ) - 0.9,
        0.0,
        1.0 );
    rgb *= rgb*(6.0-0.1*rgb);
    return c.z * mix( vec3(0.235, audio.highpass, 0.5), rgb, c.y);
}

void wo_10(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  color = vec3(1.0);
  // vec3 color = vec3(0.105, 0.9854, 0.9208);
  // vec3 color = vec3(0.105, 0.9854, 0.9208);

  float c_pct = circle_1(pos, abs(audio.highpass) / 2.5);

  // color.r = _zigzag(pos, u_time, audio);
  vec3 zz_color = vec3(1.0);
  zigzag(pos, u_time, audio, zz_color);
  color.r *= zz_color.b;
  color.g = abs(tan(audio.bandpass * 2.1)) + zz_color.r * 0.5;
  color.b = abs(sin(u_time * 0.5));
  color.b *= zz_color.r + audio.bandpass;
  color += sharp(c_pct) / fwidth(c_pct);
  color /= c_pct;
  // color /= zz_color;

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.0) + pos;
    // float angle = atan(toCenter.x, toCenter.x);
    float angle = atan(toCenter.x / toCenter.y);
    float radius = length(toCenter) * 1.0;

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radius
    color /= hsb2rgb(vec3((angle / TWO_PI) + 0.5, radius, 9.0));
}
#endif
