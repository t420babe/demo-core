// #effect #fav5 #shadershoot
#ifndef T420BABE_FUR_10
#define T420BABE_FUR_10

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

vec2 tile(vec2 _pos, float zoom){
  _pos *= zoom;
  return cos(_pos);
}

float jail(vec2 _pos, float radius){
  vec2 pos = vec2(0.5) - _pos;
  radius *= 5.75 * abs(audio.highpass);
  return 1.0 - smoothstep(
      1.0 - (radius * abs(audio.notch)),
      radius + (radius * 0.5),
      dot(fract(pos), pos.yx) * 10.0
      );
}

float circle(vec2 _pos, float radius){
  radius *= 0.45;
  float mul_0 = abs(sin(u_time));
  float mul_1 = abs(cos(u_time));
  return 1.0 - smoothstep(
      radius - (radius * mul_0), 
      radius + (radius * mul_1),
      dot(_pos, _pos) * 4.0
      );
}

float rectangle(in vec2 pos, in vec2 origin, in vec2 dim) {
  vec2 aa = origin - dim / 2.0;
  vec2 bb = 1.0 - (origin + dim / 2.0);

  vec2 onblock = step(aa, pos);
  vec2 offblock = step(bb, 1.0 - pos);
  return onblock.x * onblock.y * offblock.x * offblock.y;
}

void fur_10(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  audio.lowpass   *= 1.5;
  audio.highpass  *= 1.5;
  audio.bandpass  *= 1.5;
  audio.notch     *= 1.5;

  vec2 jail_pos = tile(pos, 20.0);
  color = vec3(jail(jail_pos, 5.2));
  color *= vec3(circle(pos, 7.0 * abs(audio.bandpass)));
  vec2 dim = vec2(1.5);
  dim *= abs(audio.notch);
  color /= vec3(rectangle(pos, vec2(0.0), dim));

  color.r *= abs(audio.bandpass) * 1.5;
  color.g -= abs(audio.notch) * 0.5;
	
  color.g *= abs(sin(u_time * audio.notch * 0.5));
  color.b *= abs(cos(u_time * audio.highpass * 0.5));

  // color = 1.0 - color;

}

#endif

