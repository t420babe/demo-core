// Smalltalk (Justin Martin Remix) by Ultraista, Justin Martin
// Start time @ 0
// lib/t420babe/talk-talk-talk/ttt-03.glsl
#define SHARP(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))
float polygon(vec2 pos, int V, float size) {
    float a = atan(pos.x, pos.y) + PI;
    float r = length(pos) / size;
    float v = TAU / float(V);
    return cos(floor(0.5 + a / v ) * v - a ) * r;
}
vec3 gem(vec2 pos, float time) {
  vec3 color = vec3(0.5, 0.0, 1.0);
  color = flash_add(color, time, 5.0 + abs(hp));
  float poly_size = 10.0;
  float rot_rate = 100.0 * 5.0;
  int num_sides = int(sin(time * 0.5) * 10.0);
  pos = rotate2d(time * rot_rate) * pos;
  poly_size *= bp;
  float poly = sharp(polygon(pos, num_sides, poly_size));
  color *= poly;
  vec3 hsv_color = rgb2hsv(color);
  color.r = hsv_color.r * abs(bp) * 3.5;
  color.g = hsv_color.b * abs(notch) * 1.0 ;
  return color;
}
