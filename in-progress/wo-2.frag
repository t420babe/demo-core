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


uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

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

  float zoom = 80.0;
  pos = mirror_tile(pos*vec2(1.,2.), zoom);
  float x = pos.x * 2.0;
  float a = sin(1.+tan(x*3.14));
  float b = sin(1.+sin((x+1.)*3.14 * sin(u_time)));
  float f = sin(x);

  return fillY(pos,mix(a,b,f),0.01) ;
}
void zigzag(vec2 pos, float u_time, peakamp audio, inout vec3 color){
  color = vec3( _zigzag(pos, u_time, audio));
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  // vec3 color = vec3(1.0);
  vec3 color = vec3(0.435, 0.9854, 0.9208);

  float c_pct = circle_1(pos, abs(audio.notch) / 2.5);

  // color.r = _zigzag(pos, u_time, audio);
  vec3 zz_color = vec3(1.0);
  zigzag(pos, u_time, audio, zz_color);
  color.g *= 0.5 * abs(audio.bandpass) + zz_color.b;
  color.r = abs(tan(audio.bandpass)) + zz_color.r * 0.5;
  color.b = abs(sin(u_time));
  // color.b *= zz_color.r + audio.bandpass;
  // color += sharp(c_pct);
  // color /= c_pct;
  // color /= zz_color;

  gl_FragColor = vec4(color,1.0);
}
