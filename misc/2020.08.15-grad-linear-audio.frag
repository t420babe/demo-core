#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

#include "lib/common/easing-functions.glsl"

#define CURVE(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))

#define DEMO_EASE(u_t) abs(fract(u_t * 0.5) * 2.0 - 1.0)
#define DEMO_COLOR(pct) vec3(mix(colorA, colorB, pct))

const vec3 colorA = vec3(0.149,0.141,0.912);
const vec3 colorB = vec3(1.000,0.833,0.224);

float plot(vec2 st, float pct){
    return  smoothstep( pct-0.02, pct, st.y) -
                smoothstep( pct, pct+0.02, st.y);
}
// Test lib/common/easing-functions.glsl -> linear
// Expect alternating blue and yellow
vec3 tt(vec2 pos) {
    // return DEMO_COLOR(linear(DEMO_EASE(u_time)));
    return vec3(CURVE(linear(DEMO_EASE(u_time))));
}

// Test lib/common/easing-functions.glsl -> exp_in
// Expect mainly blue with quick yellow flash
vec3 test_easing_functions_exp_in(vec2 pos) {
    return DEMO_COLOR(exp_in(DEMO_EASE(u_time)));
}

vec3 bos(vec2 st) {
  // Smooth interpolation between 0.1 and 0.9
    float y = smoothstep(0.1,0.9,st.x);

    vec3 color = vec3(y);

    float pct = plot(st,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);
    return color;
}


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.1);
  // float y = smoothstep(0.0, 0.5, pos.x);
  float y = linear(pos.x);
  color = vec3(y);
  float pct = plot(pos, y) * full_ave;
  color = (1.0 - pct) * color * full_ave + pct * vec3(0.0, 1.0, 0.0);
  // color = tt(pos);

  // [> BEGIN TESTS <]
  //
  // // Test 0: float linear(float t), alternate blue yellow
  // color = test_easing_functions_linear(pos);
  //
  // // Test 1: float exp_in(float t), blue with quick yellow flash
  // color = test_easing_functions_exp_in(pos);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}
