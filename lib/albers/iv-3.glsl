#ifndef ALBERS_IV_3
#define ALBERS_IV_3

#ifndef COMMON_SHAPES
#include "lib/common/shapes.glsl"
#endif



vec3 albers_iv_3(vec2 pos) {
  vec3 color = vec3(0.2);
  
  vec3 robins_shell = vec3(0.392157, 0.427451, 0.470588);
  vec3 green = vec3(0.501961, 0.513725, 0.337253);
  vec3 yellow = vec3(0.772549, 0.629126, 0.270588);

  color = mix(robins_shell, yellow, step(0.0, pos.y));

  // (-0.375, 0.75)   (0.375, 0.75)
  // (-0.375, 0.25)   (0.375, 0.25)
  // (h: 0.5, w: 0.75)
  vec2 dim = vec2(0.75, 0.5);
  vec2 origin = vec2(0.0, 0.5);
  float rect_upper = rectangle(pos, origin, dim);
  color = mix(color, green, rect_upper);

  int n_row = 10;
  int n_col = 6;
  vec2 grid_dim = vec2(dim.x / float(n_row + 1), dim.y / float(n_col + 1));
  vec2 origin_llc =  vec2(-dim.x / 2.0 + grid_dim.x / 2.0, dim.y / 2.0 + grid_dim.y / 2.0);
  float grid_ij = 0.0;
  vec2 origin_ij  = vec2(0.0);

  for(int i = 1; i < n_row; i++) {
    for(int j = 1; j < n_col; j++) {

      if ( mod(float(i), 2.0) == 1.0 &&  mod(float(j), 2.0) == 1.0) {

        origin_ij = origin_llc + vec2((grid_dim.x * float(i)), grid_dim.y * float(j));

        grid_ij = rectangle(pos, origin_ij, grid_dim);

        color = mix(color, robins_shell, grid_ij);
      }
    }
  }

  return color;
}


#endif
