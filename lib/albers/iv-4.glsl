#ifndef ALBERS_IV_4
#define ALBERS_IV_4

#ifndef COMMON_TRANSFORM
#include "lib/common/transform.glsl"
#endif

#ifndef COMMON_SHAPES
#include "lib/common/shapes.glsl"
#endif

vec3 albers_iv_4(vec2 pos) {
  vec3 color = vec3(0.2);

  vec3 dark_purple = vec3(0.203922, 0.156863, 0.266667);
  vec3 mid_upper_purple = vec3(0.462745, 0.317647, 0.450980);
  vec3 red = vec3(0.803922, 0.415686, 0.258824);
  vec3 black = vec3(0.0);
  vec3 mid_lower_purple = vec3(0.384314, 0.247059, 0.388235);
  vec3 light_purple = vec3(0.572549, 0.368627, 0.505882);
  
  color = mix(light_purple, red, step(-0.4, pos.y));

  vec2 dim = vec2(0.85, 0.1);
  vec2 origin = vec2(0.00, 0.56);
  float theta = asin(0.1 / sqrt(pow(0.1, 2.0) + pow(2.0, 2.0)));
  vec2 rot_pos = rotate(pos, theta);


  // vec2 origin = vec2(dim.x + sin(degrees(15.0)), 0.70);
  // pos = rotate(pos, radians(10.0));
  float rect = rectangle(rot_pos, origin, dim);


  color = mix(color, black, step(0.4, pos.y));
  color = mix(color, dark_purple, step(0.55, pos.y));
  color = mix(color, mid_upper_purple, rect);

  return color;
}


#endif
