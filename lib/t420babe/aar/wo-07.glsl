// #shape #shadershoot #trippy
#ifndef T420BABE_WO_07
#define T420BABE_WO_07

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

  float zoom = 4.0;
  pos = mirror_tile(pos * vec2(1.0, 8.0), zoom);
  float x = pos.x * 1.0;
  float a = tan(x / 3.14);
  float b = 1.0 * log(x * 3.14);
  float f = exp(x * 3.14);
  // float f = sin(x * u_time);

  return fillY(pos, mix(a * audio.notch, b * audio.highpass, f), 0.01) ;
}
void zigzag(vec2 pos, float u_time, peakamp audio, inout vec3 color){
  color = vec3( _zigzag(pos, u_time, audio));
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}


//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix( vec3(1.0), rgb, c.y);
}

void wo_07(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  color = vec3(0.435, 0.9854, 0.9208);

  float c_pct = circle_1(pos, abs(audio.notch) / 2.5);

  // color.r = _zigzag(pos, u_time, audio);
  vec3 zz_color = vec3(1.0);
  zigzag(pos, u_time, audio, zz_color);
  color.g *= 0.5 * abs(audio.bandpass) + zz_color.b;
  color.r = abs(tan(audio.bandpass)) + zz_color.r * 0.5;
  color.b = abs(sin(u_time));
  color.b *= zz_color.r + audio.bandpass;
  color += sharp(c_pct);
  color /= c_pct;
  // color /= zz_color;

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.0) + pos;
    float angle = atan(toCenter.x, toCenter.x);
    float radius = length(toCenter) * 1.0;

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radius
    color /= hsb2rgb(vec3((angle / TWO_PI) + 0.5, radius, 9.0));
}
#endif
