// #effectshape #shadershoot #fav #needsong
#ifndef T4B_ABN_00
#define T4B_ABN_00

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
    if (fract(_pos.y * 0.5) > 0.5){
        _pos.x = _pos.x+0.5;
        _pos.y = 1.0-_pos.y;
    }
    return fract(_pos);
}

float fillY(vec2 _pos, float _pct,float _antia){
  return  smoothstep( _pct-_antia, _pct, _pos.y);
}

float _zigzag(vec2 pos, float time, peakamp audio) {

  float zoom = 2.0;
  pos = mirror_tile(pos*vec2(1.,2.), zoom);
  float x = pos.x*2.;
  float a = sin(1.+sin(x*3.14));
  float b = sin(1.+sin((x+1.)*3.14 * sin(time)));
  float f = sin(x);

  return fillY(pos,mix(a,b,f),0.01) ;
}
void zigzag(vec2 pos, float time, peakamp audio, inout vec3 color){
  color = vec3( _zigzag(pos, time, audio));
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

void abn_00(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(0.0);
  vec2 pos = p3.xy;
  color = vec3(0.435, 0.9854, 0.9208);

  float c_pct = circle_1(pos, abs(audio.notch) / 3.0);

  // color.r = _zigzag(pos, time, audio);
  vec3 abn_color = vec3(1.0);
  zigzag(pos, time, audio, abn_color);
  color.b *= audio.bandpass;
  // color.r /= abs(sin(time));
  color.g /= abn_color.g;
  color.r *= abn_color.r + audio.bandpass;
  color += sharp(c_pct);
  color -= abn_color;
  color = 1.0 - color;
  color /= color.grb;

  gl_FragColor = vec4(color, 1.0);
}
#endif
