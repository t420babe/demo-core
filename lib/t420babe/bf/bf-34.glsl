// Country of the Mind by Greg Gonzalez (Audio by Patti Smith)
// #trippy #rave
#ifndef T4B_BF_34
#define T4B_BF_34

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

// Forked: https://www.shadertoy.com/view/7sf3z2
float map(vec2 p) {
    return length(p) - 0.2;
}

vec3 party_starter(vec2 pos, float time, peakamp audio) {
  vec3 col;
  vec3 color = vec3(1.,1.,1.);

  for(float j = 0.0; j < 3.0; j++){
      for(float i = 1.; i < 7.0; i++){
          pos.x += (1.0 * (0.2 / (i + j) * sin(i * atan(time) * 2.0 * pos.y + (time * 0.1) + i * j)));
          pos.y+= (1.0 * (1.0 / (i + j) * cos(i * 0.6 * pos.x + (time * 0.25) + i * j)));
      col[int(j)] = -1.0 * (pos.x * tan(pos.y / time));
      col[int(j)] = -1.0 * (pos.x * tan(pos.y * time));
      }
  }
  
  vec3 bg = vec3(1.5 * audio.bandpass, 1.5 * audio.highpass, 1.5 * audio.notch);
  color = mix(
    col,
    bg,
    1.0 - smoothstep(abs(atan(time)),-abs(sin(time*0.05)*3.0 / (audio.notch)), map(pos * (audio.lowpass) * 4.0))
  );   
    // 1.0-smoothstep(0.0,-abs(sin(time*0.05)*3.0 / (audio.notch)), map(pos * (audio.lowpass) * 4.0))

  // vec3 bg = vec3(1.5, 2.0 * abs(audio.bandpass), 2.0 * abs(audio.notch));
  // color = mix(
  //   col,
  //   bg,
  //   1.0-smoothstep(0.0,abs(sin(time*0.05)*3.0 / abs(audio.bandpass)), map(pos * abs(audio.notch) * 4.0))
  // );

  return color;
}

void bf_34(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // float w_time = wrap_time(time, t2s(0.0, 4.0, 23.0)/ 2.0);
  float w_time = wrap_time(time, 30.0);
  // pos.x -= 0.5;
  pos *= 3.0;
  vec3 color = vec3(0.0);
  // pos = rotate2d(time * 1.0) * pos;
  // float poly = sharp(polygon(pos, 5, 5.0 * audio.bandpass));
  // color *= poly;
  color = party_starter(pos.yx, w_time, audio);
  // color = 0.5 * flash_add(color, time, 1.0 * abs(audio.notch));

  vec3 hsv_color = rgb2hsv(color);
  // color.r = hsv_color.r;
  // color.b = hsv_color.b;
  // color.g = hsv_color.g;
  // return color.grb;
  // return color.bgr;
  // return color.rbg;
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor /= vec4(1.0 - 1.0 / color, 1.0);
  gl_FragColor -= texture2D(u_fb, vec2(p3.y + 0.5, p3.x + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - audio.notch * 0.1;
  gl_FragColor += texture2D(u_fb, vec2(abs(tan(p3.xy/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - 0.005;
}
#endif
