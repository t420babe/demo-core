#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// http://thndl.com/square-shaped-shaders.html

vec2 square(in vec2 m) {
  return vec2(abs(m));
}

// Orange and green hazy square
vec3 square_one(in vec2 xy, in float time) {
  return vec3(square(xy * time), 0.0);
}

// Gray hazy square
vec3 square_two(in vec2 xy, in float time) {
  vec2 r = square(xy * time);
  float s = max(r.x, r.y);
  return vec3(s);
}

// Zoom way out and way back in square
vec3 square_three(in vec2 xy, in float time) {
  vec2 r = square(xy * time);
  float s = step(0.005, max(r.x, r.y));
  return vec3(s);
}

// Black and white switch squares
vec3 square_four(in vec2 xy, in float time) {
  vec2 r = square(xy * time);
  float s = max(r.x, r.y);
  return vec3( step(0.1 * time, s * time) * step(s * 0.5, 0.8));
}

// Fuzzy squares
vec3 square_five(in vec2 xy, in float time) {
  vec2 r = square(xy);
  float s = max(r.x, r.y);
  return vec3( smoothstep(0.3, 0.4, s) * smoothstep(0.6, 0.5, s * time));
}

// Blurry blob square
vec3 square_six(in vec2 xy, in float time) {
  float r = length(max(square(xy) - 0.3, 0.0));
  return vec3(r);
}

// Medallion made from blurry blob square (square_six)
vec3 medallion(in vec2 xy, in float time) {
  float r = length(max(square(xy) - 0.3 * time, 0.0));
  return vec3(r);
}

vec3 square_seven(in vec2 xy, in float time) {
  float r = step(0.4, length( max( abs(xy.xy * time * 5.5) - 0.3 * time, 0.0)));
  return vec3(r);
}

vec3 square_eight(in vec2 xy, in float time) {
  float theta = atan(xy.x, xy.y) + atan(time);
  float r = step(
      0.2 * log(0.5 * time) + 0.25, 
      cos( floor(theta * 1.636 + 0.5) * 2.57 - theta + acos(time)) * length(xy.xy)
      );
  return vec3(r);
}

vec3 square_nine(in vec2 xy, in float time) {
  int N = 50;
  float a = atan(xy.x, xy.y);
  // float b = 6.28319 / float(N);
  float b = 6.28319 / float(N);
  // return vec3( smoothstep(0.1, 0.101, sin(ceil(time*0.5 + a * time / b ) * b - a) * length(xy.xy)));
  // return vec3( smoothstep(0.1, 0.101, asin(ceil(time*0.5 + a * time / b ) * b - a) * length(xy.xy)));
  return vec3( smoothstep(0.1, 0.101, atan(ceil(time*0.5 + a * time / b ) * b - a) * length(xy.xy)));
  // return vec3( smoothstep(0.1, 0.101, cos(ceil(time*0.5 + a * time / b ) * b - a) * length(xy.xy)));          // wavy and sun rays
  //
  // return vec3( smoothstep(0.1, 0.101, tan(ceil(time*0.5 + a * time / b ) * b - a) * length(xy.xy)));

  // return vec3( smoothstep(0.1, 0.101, acos(ceil(time*0.5 + a * time / b ) * b - a) * length(xy.xy)));
}


void main(){
  vec2 pixel = gl_FragCoord.xy / u_resolution.xy;
  pixel.x *= u_resolution.x /  u_resolution.y;

  // Remap space to -1 to 1
	pixel = (pixel * 2.0 - 1.5) / 1.0;

  vec3 color = vec3(0.0);

  float time_scale = 0.5;
  float time = tan(time_scale * u_time);

  // color = square_one(pixel, time);
  // color = square_two(pixel, time);
  // color = square_three(pixel, time);
  // color = square_four(pixel, time);
  // color = square_five(pixel, time);
  // color = square_six(pixel, time);
  // color = medallion(pixel, time);
  // color = square_seven(pixel, time);
  // color = square_eight(pixel, time);
  color = square_nine(pixel, time);


  gl_FragColor = vec4(color, 1.0);
}
