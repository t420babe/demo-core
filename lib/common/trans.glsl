#ifndef COMMON_TRANS
#define COMMON_TRANS

float trans(float time, float start, float end) {
  vec3 color = vec3(1.0);
  float delta = end - start;
  return clamp(end / delta - time / delta, 0.0, 1.0);
}

vec3 trans(float time, float start, float end, vec3 color_0, vec3 color_1) {
  vec3 color = vec3(1.0);
  float delta = end - start;
  if (time > start && time < end) {
    float t = clamp(end / delta - time / delta, 0.0, 1.0);
    color = mix(color_0, color_1, t);
  } else if (time < start) {
    color = color_0;
  } else {
    color = color_1;
  }

  return color;
}
#endif

