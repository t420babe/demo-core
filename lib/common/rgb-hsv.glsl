#ifndef COMMON_RGB_HSV
#define COMMON_RGB_HSV
vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec4 mulHsv(vec4 c, vec3 hsv) {
  return vec4(hsv2rgb(rgb2hsv(c.rgb) * hsv), c.a);
}

vec4 addHsv(vec4 c, vec3 add) {
  vec3 hsv = rgb2hsv(c.rgb);
  hsv[0] += add[0];
  hsv[1] = min(hsv[1], hsv[1] + add[1]);
  hsv[2] += add[2];
  return vec4(hsv2rgb(hsv), c.a);
}

vec4 hsv(float h, float s, float v) {
  return vec4(hsv2rgb(vec3(h, s, v)), 1.);
}

void from_255(inout vec3 rgb) {
  rgb /= 255.0;
}

#endif
