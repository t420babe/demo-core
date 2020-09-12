#ifndef PRACTICE_LINE_GRADIENT
#define PRACTICE_LINE_GRADIENT

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif


const vec3 colorA = vec3(0.149,0.141,0.912);
const vec3 colorB = vec3(1.000,0.833,0.224);
#define CURVE(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))
//
// #define DEMO_EASE(u_t) abs(fract(u_t * 0.5) * 2.0 - 1.0)
#define DEMO_COLOR_A(pct) vec3(mix(colorA, colorB, pct))

// float plot(vec2 st, float pct){
//     return  smoothstep( pct-0.02, pct, st.y) -
//                 smoothstep( pct, pct+0.02, st.y);
// }
// Test lib/common/easing-functions.glsl -> linear
// Expect alternating blue and yellow
vec3 tt(vec2 pos, float u_time) {
    // return DEMO_COLOR_A(linear(DEMO_EASE(u_time)));
    return vec3(CURVE(linear(DEMO_EASE(u_time))));
}

// Test lib/common/easing-functions.glsl -> exp_in
// Expect mainly blue with quick yellow flash
vec3 test_easing_functions_exp_in(vec2 pos, float u_time) {
    return DEMO_COLOR_A(exp_in(DEMO_EASE(u_time)));
}

vec3 bos(vec2 st) {
  // Smooth interpolation between 0.1 and 0.9
    float y = smoothstep(0.1,0.9,st.x);

    vec3 color = vec3(y);

    float pct = plot(st,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);
    return color;
}


void line_gradient_main(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // float y = smoothstep(0.0, 0.5, pos.x);
  float y = linear(pos.x);
  color = vec3(y);
  float pct = plot(pos, y) * audio.bandpass * 10.0;
  color = (1.0 - pct) * color * audio.bandpass  * 10.0+ pct * vec3(0.0, 1.0, 0.0);
}
#endif

