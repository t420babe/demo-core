#ifndef COMMON_EASING_FUNCTIONS
#include "./lib/common/easing-functions.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "lib/common/math-constants.glsl"
#endif

float plot(vec2 pos, float pct, float width){
  float upper = smoothstep( pct - width, pct, pos.y);
  float lower = smoothstep( pct, pct + width, pos.y);
  return upper - lower;
}

vec3 scene(in vec2 fragCoord, float song_time) {
  vec3 color = vec3(0.0);
  float ratio = u_resolution.x / u_resolution.y;
  vec2 uv = (2.0 * fragCoord.xy - u_resolution.xy) / u_resolution.y *2.25 + 0.1;
  float norm = (uv.x / ratio + 1.0) / 2.0;
  float wave = texelFetch(iChannel0, ivec2(norm * 512.0, 1), 0).x;
   

  float mod_time = mod(song_time * 0.2, uv.x);
  float y = ease_in_out_quart(mod_time);

  y+= ease_in_out_cubic(pow(uv.x, uv.y));
  float func2 = plot(vec2(wave), y, 1.08);

  float pct = 0.0;
  return (1.0 - func2) * color * wave + func2 * vec3(1.0, 0.0, 1.0);
}

vec3 when_im_alone(vec2 pos, float u_time, peakamp audio) {
    vec3 color = vec3(0.0);
    float song_duration = 268.5;
    float song_time = mod(iTime, song_duration);
    color = scene(fragCoord, song_time);
    fragColor = vec4(color,1.0);
}

