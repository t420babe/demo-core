#ifndef COMMON_SHAPES
#define COMMON_SHAPES
//
// float rectangle_diagonal(in vec2 pos, in vec2 origin, in vec2 dim) {
//   vec2 aa = origin - dim / 2.0;
//   vec2 bb = 1.0 - (origin + dim / 2.0);
//
//   vec2 onblock = step(aa, pos);
//   vec2 offblock = step(bb, 1.0 - pos);
//   return onblock.x * onblock.y * offblock.x * offblock.y;
// }

float rectangle(in vec2 pos, in vec2 origin, in vec2 dim) {
  vec2 aa = origin - dim / 2.0;
  vec2 bb = 1.0 - (origin + dim / 2.0);

  vec2 onblock = step(aa, pos);
  vec2 offblock = step(bb, 1.0 - pos);
  return onblock.x * onblock.y * offblock.x * offblock.y;
}
#endif
