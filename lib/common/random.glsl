#ifndef COMMON_RANDOM
#define COMMON_RANDOM
float random (in vec2 pos) {
    return fract( sin( dot( pos, vec2(12.9898, 78.233) ) ) * 43758.5453123);
}

vec2 random2(vec2 pos) {
  pos = vec2( dot(pos, vec2(127.1, 311.7)), dot(pos, vec2(269.5, 183.3)) );
  return -1.0 + 2.0 * fract( sin(pos) * 43758.5453123 );
}

// Book of Shaders
float random(in float x) {
  return fract(sin(x) * 43758.0);
}

// https://www.shadertoy.com/view/Ndt3z7
float rand(float x){
  return fract(sin(12.59585855*PI*x)+4102200.398383);
}
#endif
