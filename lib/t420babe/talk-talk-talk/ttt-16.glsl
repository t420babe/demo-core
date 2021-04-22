#ifndef T4B_TTT_16
#define T4B_TTT_16

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

  for(float j = 0.0; j < 4.0; j++){
      for(float i = 1.; i < 8.0; i++){
          pos.x += (1.0 * (0.2 / (i + j) * sin(i * atan(time) * 2.0 * pos.y + (time * 0.1) + i * j)));
          pos.y+= (1.0 * (1.0 / (i + j) * cos(i * 0.6 * pos.x + (time * 0.25) + i * j)));
      }
      col[int(j)] = -1.0 * (pos.x * pos.y);
  }
  

  vec3 bg = vec3(1.,1.,1.);
  color = mix(
    col,
    bg,
    1.0-smoothstep(0.0,abs(sin(time*0.05)*3.0),map(pos))
  );   

  return color;
}

vec3 ttt_16(vec2 pos, float time, peakamp audio) {
  vec3 color = vec3(0.5, 0.0, 1.0);
  color = flash_mul(color, time, 5.0 + abs(audio.highpass));
  // pos = rotate2d(time * 5.0 * 10.0) * pos;
  // float poly = sharp(polygon(pos, 5, 5.0 * audio.bandpass));
  // color *= poly;
  color = party_starter(pos, time, audio);

  return color;
}
#endif