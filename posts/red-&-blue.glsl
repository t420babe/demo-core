// #effect #effectshape #fav4 #shadershoot
#ifndef AAY_01
#define AAY_01

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef CELLULAR_NOISE_2_X_2_X_2
#include "lib/cellular-noise/cellular-2x2x2.glsl"
#endif

float aay_01_spiral(vec2 st, float t) {
    float r = dot(st.yx, st.yx) * 0.5;
    float a = atan(st.y,st.x)  * 0.5;
    return abs(((sin(r * t)   / r)));
}

vec3 aay_01_shapes(vec2 pos, float time, peakamp audio) {
    float x = pos.x;
    float y = pos.y;

    float a0 = step(x*x + y*y, 1.0); 
    
    float y1 = 0.4*log(0.63*x+0.64)+1.8;
    float a1 = step(y, y1);

    float y2 = 0.3*log(10.0*x-2.0)+0.8;
    float a2 = step(y2, y) + step(x,0.2);

    float y3 = -0.1 * pow(x+-0.5, 2.0)+1.8;
    float a3 = step(y, y3);

    float a = max(a0, a1*a2*a3*step(0.0,y));

    vec3 col_back = vec3(1.0);
    vec3 col_fill = vec3(0.2353, 0.34580, 0.9872340);

    vec3 rgb = mix(col_back, col_fill, a) + 0.4 * vec3(a1, a2, a3);
    return rgb;
}

void aay_01(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  vec2 ux = pos;
  vec2 st = pos;
  st.y += 1.0;
  st *= 20.0;
	vec2 F = cellular2x2x2(vec3(st * 1.0, time), 1);
	float n = smoothstep(0.0, abs(sin(time * 0.05)) + 1.0, F.y) / ( abs(audio.notch * 0.015));
  // n = step(n, sin(pos.x));
  color = vec3(n);
  // pos = pos.yx;
  pos *= 5.5;
  pos.y += 1.0;
  pos.y *= 1.5 * sin(pos.y);
  pos.x *= 5.5 * sin(pos.y);
  color -= abs(sin(time * 0.1) + 2.0) + 5.0 * aay_01_spiral(abs(sin(pos.yy) * cos(pos.xy)) * 4.5 * abs(1.0 * audio.bandpass), 0.1 * wrap_time(time, 10.0) + 10.0);
  // color -= aay_01_spiral(3.0 * pos.yx * abs(audio.bandpass), 1.0 * wrap_time(time, 10.0) + 10.0);
  color.b *= 4.5 * abs(audio.lowpass);
  color.b += 5.4;
  color.r /= 1.5 * abs(audio.highpass);
  // color = color.gbr;
  // color.g /= 0.4;
  color.g *=  1.5 * abs(audio.notch);
  // color /= (0.1 - n * 0.5);
  color += (0.1 - n * 1.5);
  // color = vec3(0.1, 0.5, 1.1) * color;
  // color -= 1.5;
  ux.y -= 1.0;
  color *= 1.0 * aay_01_shapes(ux * 20.0, time, audio);
  gl_FragColor = vec4(color, 1.0);
}
#endif

