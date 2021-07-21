#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

vec2 mirror_tile(vec2 _p2, float _zoom){
    _p2 *= _zoom;
    if (fract(_p2.y * 0.5) < 0.5){
        _p2.x = _p2.x+0.5;
        _p2.y = _p2.y * 0.1;
    }
    return log(_p2);
}

float fillY(vec2 _p2, float _pct,float _antia){
  return  smoothstep( _pct-_antia, _pct, _p2.y);
}

float _zigzag(vec2 p2, float time, peakamp audio) {

  float zoom = 20.0;
  p2 = mirror_tile(p2*vec2(1.,2.), zoom);
  float x = p2.x*2.;
  float a = sin(1.+sin(x*3.14));
  float b = sin(1.+sin((x+1.)*3.14 * sin(time)));
  float f = sin(x);

  return fillY(p2,mix(a,b,f),0.01) ;
}
void zigzag(vec2 p2, float time, peakamp audio, inout vec3 color){
  color = vec3( _zigzag(p2, time, audio));
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

void lathe_01(vec2 p2, float time, peakamp audio, inout vec3 color) {
  color = vec3(0.435, 0.9854, 0.9208);

  float c_pct = circle_1(p2, abs(audio.notch) / 2.5);

  // color.r = _zigzag(p2, time, audio);
  vec3 zz_color = vec3(1.0);
  zigzag(p2, time, audio, zz_color);
  // color.g *= 0.5 * abs(audio.bandpass) + zz_color.b;
  // color.r = abs(tan(audio.bandpass)) + zz_color.r * 0.5;
  // color.b = ;
  // color.b *= zz_color.r + audio.bandpass;
  // color += sharp(c_pct);
  // color /= c_pct;
  // color /= zz_color;

}

vec3 lathe_01_1(vec2 p2, float time, peakamp audio) {
  vec3 color = vec3(1.0);

  float c_pct = circle_1(p2, abs(audio.notch) / 2.5);

  // color.r = _zigzag(p2, time, audio);
  vec3 zz_color = vec3(1.0);
  zigzag(p2, time, audio, zz_color);
  color.g *= 0.5 * abs(audio.bandpass) + zz_color.b;
  color.r = abs(tan(audio.bandpass)) + zz_color.r * 0.5;
  color.b = abs(sin(time));
  // color.b *= zz_color.r + audio.bandpass;
  // color += sharp(c_pct);
  // color /= c_pct;
  color /= zz_color;
  return color;

}

void lathe_01(vec3 p3, float time, peakamp audio) {
  vec3 color = lathe_01_1(p3.xy, time, audio);

  // gl_FragColor = vec4( 1.0 / color.grb, 1.0);
  // gl_FragColor = vec4( 1.0 / color.rbg, 1.0);

  // gl_FragColor = vec4( color.grb, 1.0);

  // gl_FragColor = vec4( 1.0 - color, 1.0);
  // gl_FragColor = vec4( 1.0 / color, 1.0);
  gl_FragColor = vec4( color.brg, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor -= texture2D(u_fb, vec2(p3.xy/1.+.5) + vec2(0.001, 0.10));
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));

}


