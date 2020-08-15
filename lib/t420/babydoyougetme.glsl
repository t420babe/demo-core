#ifndef FRAG_BABYDOYOUGETME
#define FRAG_BABYDOYOUGETME

#include "umbrella.glsl"

float plot_babydoyougetme(vec2 st, float pct){
    return  smoothstep( pct-2.1, pct, st.y) - smoothstep( pct, pct+1.1, st.y);
}

vec3 babydoyougetme(vec2 pos, float iTime) {
  float move_it = tan(1.14 + iTime);
  pos.y += move_it;
  float pct = fract(plot_babydoyougetme(pos, ONE_MINUS_ABS_POW(pos.y, 5.5))) * iTime * 5.0;
  vec3 color = vec3(pct);
  color =  vec3(color.y + 0.3, 0.1, color.x);
  color *= umbrella(pos, pct);
  return fract(color);
}

vec3 babydoyougetme_raw(vec2 pos, float iTime) {
  float pct = fract(plot_babydoyougetme(pos, ONE_MINUS_ABS_POW(pos.x, 1.0))) * iTime * 5.0;
  vec3 color = vec3(pct);
  color =  vec3(1.0, color.y, color.x);
  color *= umbrella(pos, pct);
  return fract(color);
}
#endif
