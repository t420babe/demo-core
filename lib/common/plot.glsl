#ifndef FNC_PLOT
#define FNC_PLOT

#define DEMO_EASE(u_t) abs(fract(u_t * 0.5) * 2.0 - 1.0)
#define DEMO_COLOR(colorA, colorB, pct) vec3(mix(colorA, colorB, pct))

// Book of Shaders, Chapter 05, http://thebookofshaders.com/edit.php?log=200809234954
float plot(vec2 pos, float pct) {
  return  smoothstep(pct - 0.02, pct, pos.y) - smoothstep(pct, pct + 0.02, pos.y);
}

float plot(vec2 pos, float pct, float lower_bound, float upper_bound) {
  return  smoothstep(pct - lower_bound, pct, pos.y) - smoothstep(pct, pct + upper_bound, pos.y);
}

float plot(vec2 pos, float pct, float bound) {
  return  smoothstep(pct - bound, pct, pos.y) - smoothstep(pct, pct + bound, pos.y);
}

// x -> f(x), func -> f(x=DEMO_EASE)
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


#endif
