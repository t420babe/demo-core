#ifndef COMMON_HASH
#define COMMON_HASH

// https://www.shadertoy.com/view/lsf3WH
float hash(vec2 pos) {
  pos = 50.0 * fract(pos * 0.3183099 + vec2(0.71, 0.113));
  return -1.0 + 2.0 * fract( pos.x * pos.y * (pos.x + pos.y) );
}
#endif
