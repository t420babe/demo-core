#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

#include "lib/common/easing-functions.glsl"

#define CURVE(f) smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f))

#define DEMO_EASE(u_t) abs(fract(u_t * 0.5) * 2.0 - 1.0)
#define DEMO_COLOR(pct) vec3(mix(colorA, colorB, pct))

const vec3 colorA = vec3(0.149,0.141,0.912);
const vec3 colorB = vec3(1.000,0.833,0.224);


float plot(vec2 st, float pct){
    return  smoothstep( pct-0.001 * full_ave, pct, st.y) -
                smoothstep( pct, pct+0.001 *full_ave, st.y);
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

float create_line(vec2 pos) {
  float y = linear(pos.x);
  return plot(pos, y) * full_ave;
}

vec2 rotate_k(vec2 pos, float a) {
  pos = mat2(cos(a), -sin(a), sin(a), cos(a)) * (pos - 0.5);
  return pos + 0.5;
}


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  pos *=0.005;
  vec3 color = vec3(0.1);
  float pct = create_line(pos);

  vec2 pos_1 = vec2(-pos.x, pos.y);
  pct += create_line(pos_1);
  pct = CURVE(pct);
  color =  0.0+pct *  color + pct * vec3(0.8989, 0.2234, 0.0);
  color.b = color.x * full_ave * 0.25;

  gl_FragColor = vec4(color, 1.0);
}
