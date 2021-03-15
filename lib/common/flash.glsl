#ifndef COMMON_FLASH
#define COMMON_FLASH
vec3 flash_add(vec3 color, float time, float rate) {
  float on_flash = step(sin(time * rate), 0.0);
  vec3 c = color + on_flash;
  return c;
}

vec3 flash_mul(vec3 color, float time, float rate) {
  float on_flash = step(sin(time * rate), 0.0);
  vec3 c = color * on_flash;
  return c;
}
#endif
