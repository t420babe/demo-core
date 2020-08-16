#ifndef FRAG_UMBRELLA
#define FRAG_UMBRELLA

#ifndef FNC_MATH_FUNCTIONS
#include "../common/math-functions.glsl"
#endif

float plot_umbrella(vec2 st, float pct){
    return  smoothstep( pct-1.8, pct, st.y) - smoothstep( pct, pct+0.01, st.y);
}


vec3 umbrella(vec2 pos, float iTime) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution) / u_resolution.y;
  float pct = fract(plot_umbrella(pos, ONE_MINUS_ABS_POW(pos.x, 0.5)) * iTime * 1.0);
  vec3 color = vec3(pct);
  return vec3(color.x + 0.3, 0.635, 0.8783);
  // gl_FragColor = vec4(color.x, 0.635, 0.8783, 1.0);
}
#endif
