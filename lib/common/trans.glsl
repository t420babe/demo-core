#ifndef COMMON_TRANS
#define COMMON_TRANS

vec3 trans(float start, float end, vec3 color_0, vec3 color_1) {
  vec3 color = vec3(1.0);
  float delta = end - start;
  if (u_at > start && u_at < end) {
    float t = clamp(end / delta - u_at / delta, 0.0, 1.0);
    color = mix(color_0, color_1, t);
  } else if (u_at < start) {
    color = color_0;
  } else {
    color = color_1;
  }

  return color;
}
#endif

