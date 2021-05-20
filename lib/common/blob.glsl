#ifndef COMMON_BLOB
#define COMMON_BLOB
// https://www.shadertoy.com/view/MsjSW3
mat2 blob_m(float a){
  float c=cos(a), s=sin(a);
  return mat2(c,-s,s,c);
}

float blob(vec3 p3, float time){
    p3.xz *= blob_m(time * 0.4);
    p3.xy*= blob_m(time * 0.3);
    vec3 q = p3 * 2.0 + time;
    float x0 = length( p3 + vec3( sin(time * 0.7) ) );
    float x1 = log( length(p3) + 1.0 );
    float x2 = sin( q.x + sin( q.z + sin(q.y) ) ) * 0.5 - 1.0;
    return x0 * x1 + x2;
}
#endif
