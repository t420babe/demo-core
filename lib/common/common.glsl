#ifndef COMMON_COMMON
#define COMMON_COMMON

// Book of Shaders
float random(in float x) {
  return fract(sin(x) * 43758.0);
}
//
// // bos_pos
// vec2 custom_position(vec2 frag_coord, vec2 u_res) {
//   vec2 pos = frag_coord.xy / u_res;
//
//   pos = (pos - 0.5) * 1.1912 + 0.5;
//
//   if (u_res.y > u_res.x) {
//     pos.y *= u_res.y / u_res.x;
//     pos.y -= (u_res.y * 0.5 - u_res.x * 0.5) / u_res.x;
//   } else {
//     pos.x *= u_res.x / u_res.y;
//     pos.x -= (u_res.x * 0.5 - u_res.y * 0.5) / u_res.y;
//   }
//
//   return (pos - 0.5) * 1.1 + 0.5;
// }
//
#endif
