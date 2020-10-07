#ifndef SQUARE_POSITION
#define SQUARE_POSITION
vec2 square_position(vec2 pos, vec2 u_resolution) {
  vec2 tmp_pos = pos;
  tmp_pos.y *= u_resolution.y / u_resolution.x;
  return tmp_pos;
}
#endif

