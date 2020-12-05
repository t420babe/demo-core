#ifdef GL_ES
precision mediump float;
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif


float random (in float x) { return fract(sin(x)*1e4);}
float random (in vec2 pos) { return fract(1e4 * sin(17.0 * pos.x + pos.y * 0.1) * (0.1 + abs(sin(pos.y * 13.0 + pos.x)))); }

float pattern(vec2 pos, vec2 v, float t) {
    vec2 p = floor(pos+v);
    return step(t, random(100.+p*.000001)+random(p.x)*0.5 );
}

void ikeda_03(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
    vec2 grid = vec2(35.0, 15.0);
    pos *= grid;

    vec2 ipos = floor(pos.yx);  // integer
    vec2 fpos = fract(pos);  // fraction

    vec2 vel = vec2(u_time * 0.1 * max(grid.x, grid.y)); // time
    vel *= vec2(-1.0, 0.0) * random(1.0 + ipos.y); // direction

    // Assign a random value base on the integer coord
    vec2 offset = vec2(0.8, 0.0);
    float pct = 0.5;    //u_mouse.x/u_resolution.x;

    color.r = pattern(pos + offset, vel, 0.5 + pct);
    color.g = pattern(pos, vel, 0.5 + pct);
    color.b = pattern(pos - offset, vel, 0.5 + pct);

    // Margins
    color *= step(0.8, fpos.y);
}

// void fn(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(0.0);
  ikeda_03(pos, u_time, audio, color);
  color = 1.0 - color;

  gl_FragColor = vec4(color, 1.0);
}
