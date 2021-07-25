// #effect #fav1 #shadershoot
#ifndef T4B_AB_03
#define T4B_AB_03

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

vec2 mirror_tile(vec2 _pos, float _zoom){
    _pos *= _zoom;
    if (fract(_pos.y * 0.5) < 0.5){
        _pos.x = _pos.x+0.5;
        _pos.y = _pos.y * 0.1;
    }
    return fract(_pos);
    // return exp(_pos);
}

float fillY(vec2 _pos, float _pct,float _antia){
  return  smoothstep( _pct-_antia, _pct, _pos.y);
  // return  smoothstep( _pct-_antia, _pct, _pos.y);
}

float _zigzag(vec2 pos, float time, peakamp audio) {

  float zoom = 35.0;
  pos = mirror_tile(pos*vec2(1.,2.), zoom);
  float x = pos.x*2.;
  float a = sin(1.+sin(x*0.14));
  float b = sin(1.+cos((x+1.)*3.14 * sin(time)));
  float f = sin(x * time);

  return fillY(pos,mix(a,b,f),0.01) ;
}
void zigzag(vec2 pos, float time, peakamp audio, inout vec3 color){
  color = vec3( _zigzag(pos, time, audio));
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

void ab_03(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  pos /= 1.5;
  pos.y -= 0.5;
  color = vec3(0.435, 0.9854, 0.9208);

  float c_pct = circle_1(pos, abs(audio.notch) / 2.5);

  // color.r = _zigzag(pos, time, audio);
  vec3 zz_color = vec3(1.0);
  zigzag(pos, time, audio, zz_color);
  color.g *= 0.5 * abs(audio.bandpass) + zz_color.b;
  color.r = abs(tan(audio.bandpass)) + zz_color.r * 0.5;
  color.b = abs(sin(time));
  color.b *= zz_color.r + audio.bandpass;
  // color += sharp(c_pct);
  // color /= c_pct;
  // color /= zz_color;

  gl_FragColor = vec4(color, 1.0);
}


#endif
