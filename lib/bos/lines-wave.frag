// Author @patriciogv - 2015 - patricio.io
#ifndef BOS_LINES_WAVE
#define BOS_LINES_WAVE
#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

vec2 wave(vec2 pos, float freq) {
	pos.y += cos(pos.x * freq);
	return pos;
}

vec2 zigzag(vec2 pos, float freq) {
	pos.y += mix( abs( floor( sin(pos.x * PI) ) ), abs( floor( sin( (pos.x + 1.0) * PI) ) ), fract(pos.x * freq) );
	return pos;
}

float line(vec2 pos, float width) {
    return step( width, 1.0 - smoothstep( 0.0, 1.0, abs( sin(pos.y * PI) ) ) );
}

void bos_lines_wave(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
   	pos *= 10.0;
   	pos = wave(pos, 3.0);
    color = vec3( line(pos, 0.5) );
}
#endif
