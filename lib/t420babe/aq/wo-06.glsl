// #shape #shadershoot #lathe #favs
// Say or Do (feat. Benson) by Paul Harris, Benson
// All I Want To Do Is Love You - Chevals
#ifndef T420BABE_WO_06
#define T420BABE_WO_06

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
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

  float zoom = 8.0;
  pos = mirror_tile(pos*vec2(1.,2.), zoom);
  float x = pos.x * 2.0;
  float a = sin(1.+sin(x*3.14 ));
  float b = 2.0 * sin(1.+sin((x+1.)*1.14 ));
  float f = log2(x) * tan(x );
  // float f = sin(x * u_time);

  return fillY(pos, mix(a * audio.notch, b * audio.highpass, f), 0.01) ;
}
void zigzag(vec2 pos, float u_time, peakamp audio, inout vec3 color){
  color = vec3( _zigzag(pos, u_time, audio));
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

void wo_06(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  color = vec3(0.435, 0.9854, 0.9208);

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


}
#endif
