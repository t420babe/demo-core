#ifndef BOS_MULTI
#define BOS_MULTI
void multi(vec2 pos, sampler2D u_tex0, sampler2D u_tex1, out vec3 color) {
  vec3 color_tex_0 = texture2D(u_tex0, pos).brg;
  vec3 color_tex_1 = texture2D(u_tex1, pos).grb;

  color_tex_1.g = color_tex_0.r;
  color = color_tex_1 + (color_tex_0);
}
#endif
