#ifndef COMMON_RANDOM
#define COMMON_RANDOM
float random (in vec2 pos) {
    return fract( sin( dot( pos, vec2(12.9898, 78.233) ) ) * 43758.5453123);
}
#endif
