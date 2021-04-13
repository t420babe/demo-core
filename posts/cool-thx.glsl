// Music: Memories by @edenprincemusic, @nonoofficial
// #ifndef T4B_ARRIVAL_09, lib/t420babe/arrival/arrival-09.glsl
void cool_thx(vec3 p3, float time) {
  hp *= 2.0;
  lp *= 2.0;
  notch *= 10.5;
  vec3 color = vec3(1.0);
  vec2 st = p3.xy * 2.0;
  st *= rotate2d(tan(time) * 3.14 / 1.0);
  float flower_size = 2.5 * notch;
  float flower = flower_fn(vec2(st.x + flower_size / 2.0, st.y + flower_size / 2.0) / flower_size, 100);
  float rhombus = rhombus_fn(st, 1.0);
  float hex = hexagon_fn(st, wrap_time(time * 0.5, 15.0) + 5.0, notch * 40.0 + 1.0);
  float bri = sharp(flower) - sin(hex);
  bri /= rhombus * 1.0;
  color = 1.5 - color;
  color = vec3(bri * hp, bri * notch, bri * lp);
  color.r *= abs(sin(time));
  color.g *= abs(cos(time));
  color.b *= abs(tan(time));
  color = color.bgr;
  gl_FragColor = vec4(color, bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy / 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}

#shaders #shader #livecode #glsl #gpu #programming #algorithms #frequency #vj #vjing #art #procedural #creativecode #creativecoding #nyc #bushwick #brooklyn #memories #edenprince #nono
