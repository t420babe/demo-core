#ifndef COMMON_BLOB
#define COMMON_BLOB

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

// https://www.shadertoy.com/view/MsjSW3
float blob(vec3 p3, float time){
    p3.xz *= rotate2d(time * 0.4);
    p3.xy*= rotate2d(time * 0.3);
    vec3 q = p3 * 2.0 + time;
    float x0 = length( p3 + vec3( sin(time * 0.7) ) );
    float x1 = log( length(p3) + 1.0 );
    float x2 = sin( q.x + sin( q.z + sin(q.y) ) ) * 0.5 - 1.0;
    return x0 * x1 + x2;
}
#endif
