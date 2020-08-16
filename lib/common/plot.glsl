#ifndef FNC_PLOT
#define FNC_PLOT

#define SHARP(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))
// #define SHARP(f, b) vec3(smoothstep(-b, b, (f - 0.1) / fwidth(f)))

#define DEMO_EASE(u_t) abs(fract(u_t * 0.5) * 2.0 - 1.0)
#define DEMO_COLOR(colorA, colorB, pct) vec3(mix(colorA, colorB, pct))

// Book of Shaders, Chapter 05, http://thebookofshaders.com/edit.php?log=200809234954
// Plots a line who edges can be sharper or softer depending on bound value
float plot(vec2 pos, float pct) {
  return  smoothstep(pct - 0.02, pct, pos.y) - smoothstep(pct, pct + 0.02, pos.y);
}

// Plots a line who edges can be sharper or softer depending on bound value
float plot(vec2 pos, float pct, float bound) {
  return  smoothstep(pct - bound, pct, pos.y) - smoothstep(pct, pct + bound, pos.y);
}

// Plots a line who edges can be sharper or softer depending on bound value
float plot(vec2 pos, float pct, float lower_bound, float upper_bound) {
  return  smoothstep(pct - lower_bound, pct, pos.y) - smoothstep(pct, pct + upper_bound, pos.y);
}

// Plots line and gradient according to that line
// `fx0` - f(x = x0)
// `fx1` - f(x = x1)
vec3 gradient_and_line(vec2 pos, float fx0, float fx1, vec3 color_a, vec3 color_b) {
  // Line
  float pct = plot(pos, fx0);
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(color_a, color_b, fx1);

  return color;
}

// Function of SHARP macro (reimplemented so I can overload)
// Plots a very sharp line (as opposed to plotting with smoothstep)
// If lower_bound > upper_bound then colors invert
float sharp(float f) {
  return smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f));
}

// Plots a very sharp line (as opposed to plotting with smoothstep)
// If lower_bound > upper_bound then colors invert where:
// `lower_bound = -bound` and `upper_bound = bound`
float sharp(float f, float bound) {
  return smoothstep(-bound, bound, (f - 0.1) / fwidth(f));
}

// Plots a very sharp line (as opposed to plotting with smoothstep)
// If lower_bound > upper_bound then colors invert
float sharp(float f, float lower_bound, float upper_bound) {
  return smoothstep(lower_bound, upper_bound, (f - 0.1) / fwidth(f));
}

// Plots line and gradient according to that line
// `fx0` - f(x = x0)
// `fx1` - f(x = x1)
vec3 gradient_and_sharp_line(vec2 pos, float fx0, float fx1, vec3 color_a, vec3 color_b) {
  // Line
  float pct = plot(pos, fx0);
  vec3 color = SHARP(pct);
  // vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(color_a, color_b, fx1);

  return color;
}

#endif
