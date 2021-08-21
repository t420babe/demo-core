#ifndef T4B_BF_17
#define T4B_BF_17

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_POLYGON
#include "lib/pxl/polygon-sdf.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
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
      }
      col[int(j)] = -1.0 * (pos.x * pos.y);
  }
  

  vec3 bg = vec3(1.,1.,1.);
  color = mix(
    col,
    bg,
    1.0-smoothstep(10.0,(sin(time*0.05)*3.0), map(pos))
  );   

  return color;
}

void bf_17(vec3 p3, float time, peakamp audio) {
  time = wrap_time(time, 30.0);
  vec2 pos = p3.xy;
  pos *= 10.0;
  // vec3 color = vec3(0.5, 0.0, 1.0);
  vec3 color = vec3(audio.highpass * 1.5, audio.notch * 1.5, audio.lowpass * 1.5);
  // pos = rotate2d(time * 5.0 * 10.0) * pos;
  // float poly = sharp(polygon(pos, 5, 5.0 * audio.bandpass));
  // color *= poly;
  color *= party_starter(pos, time, audio);
  // color = flash_add(color, time, 0.0 + abs(audio.notch));

  gl_FragColor = vec4(color.bgr - 0.5, 1.0);
  // gl_FragColor = vec4(color, 1.0);
  // gl_FragColor -= texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(abs(sin(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - audio.notch * 0.1;
  gl_FragColor += texture2D(u_fb, vec2(abs(tan(p3.yx/ (PI * 0.60) + PI)) + 0.10) + vec2(0.001, 0.001)) - 0.005;
}
#endif
