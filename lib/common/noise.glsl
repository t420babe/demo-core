#ifndef COMMON_NOISE
#define COMMON_NOISE

#ifndef COMMON_RANDOM
#include "./lib/common/random.glsl"
#endif

#ifndef COMMON_PERMUTE
#include "./lib/common/permute.glsl"
#endif

// Value noise by Inigo Quilez - iq/2013, https://www.shadertoy.com/view/lsf3WH
float noise(vec2 pos) {

  vec2 i = floor(pos);
  vec2 f = fract(pos);
  vec2 u = f * f * (3.0 - 2.0 * f);
  return mix(
      mix( random( i + vec2(0.0, 0.0) ), random( i + vec2(1.0, 0.0) ), u.x),
      mix( random( i + vec2(0.0, 1.0) ), random( i + vec2(1.0, 1.0) ), u.x),
      u.y);
}

// Lava lamp algorithm
float snoise(vec2 v) {
  // (3.0-sqrt(3.0))/6.0, 0.5*(sqrt(3.0)-1.0), -1.0 + 2.0 * C.x, 1.0 / 41.0
  const vec4 C = vec4(0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439);
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 )) + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}

float noice_fbm(vec2 x)
{    
  float G = 0.5; //exp2(-H);
  float freq = 1.0;
  float a = 1.0;
  float t = 0.0;
  for( int i=0; i<8; i++ )
  {
    t += a*snoise(freq*x);
    freq = pow(2.0, float(i));
    // f += 2.0;
    a *= G;
  }
  return t;
}

float cellular_noise(vec2 st, float abp_00_scale){
  st *= abp_00_scale;
  vec2 i_st = floor(st);
  vec2 f_st = fract(st);
  float m_dist = 100.;
  //loop through neighboring cells to check points
  for(int i=-1; i<=1; i++){
    for(int j=-1; j<=1; j++){
      //find the neighbor
      vec2 neighbor = vec2(float(i), float(j));
      //random (deterministicallly) point
      vec2 point = random2(i_st+neighbor);
      // point = 0.5 + 0.5*sin(u_time + 6.2831*point); //animate
      //vector from pixel to point 
      vec2 diff = neighbor + point - f_st;
      //dist 
      float dist = length(diff);
      //keep closer distance 
      m_dist=min(m_dist, dist);
    }
  }
  return m_dist;
}
#endif
