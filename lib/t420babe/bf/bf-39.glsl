// minor sunrise by elderflower
// escape
// #trippy #thisisjustfuckingnicetolookat
#ifndef T4B_BF_39
#define T4B_BF_39

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

// Forked: https://www.shadertoy.com/view/7sf3z2
float map(vec2 p) {
    return length(p) + 0.2;
}

vec3 party_starter(vec2 pos, float time, peakamp audio) {
  time *= 0.5;
  // pos = pos.yx;

  // pos /= 2.5;
  vec3 col;
  vec3 color = vec3(1.,1.,1.);

  for(float j = 1.0; j < 3.0; j++){
      for(float i = 0.0; i < 2.0; i++){
          // pos.x += (1.0 * (0.2 / (i + j) * sin(i * atan(time) * 2.0 * pos.y + (time * 0.1) + i * j)));
          // pos.y+= (1.0 * (1.0 / (i + j) * cos(i * 0.6 * pos.x + (time * 0.25) + i * j)));

          pos.x += sin(time) * i;
          // pos.y += sin(time) * j;
          // pos.y += tan(time) * i * j;
          // pos.x += 2.0 * (0.2 / (i + j) * sin(i * atan(time) * 2.0 * pos.y + (time * 0.1) + i * j));
          // pos.y += 2.0 * (1.0 / (i + j) * cos(i * 0.6 * pos.x + (time * 0.25) + i * j));
          // pos.x += (1.0 * (0.2 / (i + j) * sin(i * atan(time) * 3.0 * pos.y + (time * 0.1) + i * j)));
          // pos.y+= (1.0 * (1.0 / (i + j) * cos(j * 0.6 * pos.x + (time * 0.25) + i * j)));

          col[int(j)] = 0.5 * (pos.x);
      }
      // col[int(i)] = 1.0 * pos.y;
  }
  
  vec3 bg = vec3(0.5, abs(sin(time)) + 0.2, 0.8);
  // vec3 bg = vec3(1.0);
  // color = mix( col, bg, smoothstep(0.0, sin(time), 0.0));
  color = mix( col, bg, sin(time) + PI / 3.0); 

      // color = col;
  // vec3 bg = vec3(1.5, 2.0 * abs(audio.bandpass), 2.0 * abs(audio.notch));
  // color = mix(
  //   col,
  //   bg,
  //   1.0-smoothstep(0.0,abs(sin(time*0.05)*3.0 / abs(audio.bandpass)), map(pos * abs(audio.notch) * 4.0))
  // );

  return color;
}

void bf_39(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // float w_time = wrap_time(time, t2s(0.0, 4.0, 23.0)/ 2.0);
  // float w_time = wrap_time(time, 30.0) + 10.0;
  float w_time = time;
  // pos.x -= 0.5;
  // pos *= 1.5;
  pos *= 1.25;
  vec3 color = vec3(0.0);
  // pos = rotate2d(time * 1.0) * pos;
  // float poly = sharp(polygon(pos, 5, 5.0 * audio.bandpass));
  // color *= poly;
  color = party_starter(pos.yx, w_time, audio) * 2.5;
  // color = 0.5 * flash_add(color, time, 1.0 * abs(audio.notch));

  vec3 hsv_color = rgb2hsv(color);
  // color.r = hsv_color.r;
  // color.b = hsv_color.b;
  // color.g = hsv_color.g;
  // return color.grb;
  // return color.rbg;
  gl_FragColor = vec4(color, 1.0);
  gl_FragColor -= texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor = vec4(1.0 - 1.0 / color, 1.0);
  // gl_FragColor -= texture2D(u_fb, vec2(p3.y, p3.x + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - audio.notch * 0.1;
  // gl_FragColor += texture2D(u_fb, vec2(abs(tan(p3.xy/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - 0.005;
}
#endif
