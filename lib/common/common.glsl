#ifndef FNC_COMMON
#define FNC_COMMON



// float plot(float x) {
//   return smoothstep(0.02, 0.0, x);
//
// }
// float plot(vec2 st, float pct){
//     return  smoothstep( pct-0.02, pct, st.y) - smoothstep( pct, pct+0.02, st.y);
// }

// Chapter 05, http://thebookofshaders.com/edit.php?log=200809234954
// float plot(vec2 pos, float pct){
//   return  smoothstep(pct - 0.02, pct, pos.y) - smoothstep(pct, pct + 0.02, pos.y);
// }
//

float random(in float x) {
  return fract(sin(x) * 43758.0);
}

vec2 bos_pos(vec2 frag_coord, vec2 u_res) {
  vec2 pos = frag_coord.xy / u_res;

  pos = (pos - 0.5) * 1.1912 + 0.5;

  if (u_res.y > u_res.x) {
    pos.y *= u_res.y / u_res.x;
    pos.y -= (u_res.y * 0.5 - u_res.x * 0.5) / u_res.x;
  } else {
    pos.x *= u_res.x / u_res.y;
    pos.x -= (u_res.x * 0.5 - u_res.y * 0.5) / u_res.y;
  }

  return (pos - 0.5) * 1.1 + 0.5;
}

#endif
