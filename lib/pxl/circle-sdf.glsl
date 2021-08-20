#ifndef PXL_CIRCLE
#define PXL_CIRCLE
float circle_0(vec2 st, float u_full_ave) {
    return length(st-.5) * 1.5;
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

float circle_1a(vec2 st, float u_notch) {
    return length(st) * 1.0 * u_notch;
}

float circle_sdf(vec2 pos, float radius) {
    return length(pos) / radius;
}

float circle_sdf(vec2 st) {
    return length(st-.5)*2.;
}

// https://www.shadertoy.com/view/Ndt3z7
float circle(in vec2 st, in vec2 center, float r, float smoothing_factor) {
  //*sin(atan(st.y,st.x))); //*TWO_PI*6.) + smoothstep(0.,1.,fract(st.x))));
  return 1.0 - smoothstep(r - smoothing_factor, r + smoothing_factor, distance(st, center));
}

// https://www.shadertoy.com/view/Ndt3z7
float circle_outline(in vec2 st, in vec2 center, float r, float stroke_weight){
  return smoothstep(r - stroke_weight, r + stroke_weight, distance(st, center)) * (1.0 - smoothstep(r, r + stroke_weight, distance(st, center)));
}
#endif
