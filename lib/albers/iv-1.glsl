
//
// float my_rect(in vec2 pos, in vec2 size) {
//   // vec2 sides = smoothstep(size, 2.0 * size, pos * (1.0 - pos));
//   // sides = SHARP(sides);
//   // return sides.x * sides.y;
//   //
//   // vec2 rect_sides = vec2(0.0, 0.0);
//   // // rect_sides.x = step(size.x, pos.x * ((0.8 - u_resolution.x) / u_resolution.x - pos.x));
//   // // rect_sides.y = step(size.y, pos.y * ((0.8 - u_resolution.x) / u_resolution.x - pos.y));
//   // rect_sides.x = step(size.x, pos.x * (1.0 - pos.x));
//   // rect_sides.y = step(size.y, pos.y * (1.0 - pos.y));
//   // // float blx = step(0.1, pos.x * (1.0 - pos.x));       // bottom-left
//   // // float bly = step(0.1, pos.y);       // bottom-left
//   // return rect_sides.x * rect_sides.y;
//   // return 1.0;
// }
// // vec3 albers_iv_1() {
// // }
