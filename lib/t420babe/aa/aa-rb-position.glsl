#ifndef T4B_AA_RB_POS
#define T4B_AA_RB_POS

#ifndef COMMON_TRANSFORM
#include "lib/common/transform.glsl"
#endif

// Rainbow position
vec2 aa_rb_pos(vec2 pos, vec2 u_res, float time) {
    pos = (pos - 0.5) * 1.0011;
    pos *= 1.0;

    if (u_res.y > u_res.x) {
      pos.y *= u_res.y / u_res.x;
      pos.y -= (u_res.y * 0.5 - u_res.x * 0.5) / u_res.x;
    } else {
      pos.x *= u_res.x / u_res.y;
      pos.x -= (u_res.x * 0.5 - u_res.y * 0.5) / u_res.y;
    }
    pos = (pos - 0.5) * 1.1 + 2.0;
    pos = rotate(pos, time / 2.0, 0.5);

    return pos;
}
#endif
