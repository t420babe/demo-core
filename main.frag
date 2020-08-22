#ifdef GL_ES
precision mediump float;
#endif
//
// #ifndef T420BABE_RIDGE
// #include "lib/t420babe/ridge.glsl"
// #endif
//
// #ifndef COMMON_MATH_CONSTANTS
// #include "lib/common/math-constants.glsl"
// #endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

float heartSDF(vec2 st) {
    st -= vec2(.5,.8);
    float r = length(st)*5.;
    st = normalize(st);
    return r - 
         ((st.y*pow(abs(st.x),0.67))/ 
         (st.y+1.5)-(2.)*st.y+1.26);
}

void main() {
  vec3 color = vec3(full_ave, sin(u_time), cos(u_time));
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // pos.y *= u_resolution.y / u_resolution.x; // fix resolution x-axis strFtching
  pos.x += 0.5;
  pos.y +=0.5;
  float pct = heartSDF(pos);
  color = pct *color + pct *vec3(0.5, 0.1, 0.5);
  gl_FragColor = vec4(color, 1.0);
}
