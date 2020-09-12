#ifndef T420BABE_WOOD_BB
#define T420BABE_WOOD_BB

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL_PXL
#include "../pxl/00-pxl.glsl"
#endif


// Inspiration from: Author @patriciogv - 2015
// http://patriciogonzalezvivo.com
float random (in vec2 pos) {
    return fract(sin(dot(pos.xy,
                         vec2(12.9898,78.233)))
                * 43758.5453123);
}


// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float noise(vec2 pos, float u_time) {
    vec2 i = floor(pos);
    vec2 f = fract(pos);
    vec2 u = f*f*(3.0-2.0*f);
		// return mix( mix( random( i * sin(u_time * 0.5) + vec2(0.0,0.0) ),
		//                  random( i * sin(u_time * 0.5) + vec2(1.0,0.0) ), u.x),
		//             mix( random( i * sin(u_time * 0.5) + vec2(0.0,1.0) ),
		//                  random( i * sin(u_time * 0.5) + vec2(1.0,1.0) ), u.x), u.y);
		// return mix( mix( random( i * sin(u_time * 0.5) + vec2(0.0,0.0) ),
		//                  random( i * sin(u_time * 0.5) + vec2(1.0,0.0) ), u.x),
		//             mix( random( i * sin(u_time * 0.5) + vec2(0.0,1.0) ),
		//                  random( i * sin(u_time * 0.5) + vec2(1.0,1.0) ), u.x), u.y);
    return mix( mix( random( i + vec2(0.0,0.0) ),
                     random( i + vec2(1.0,0.0) ), u.x),
                mix( random( i + vec2(0.0,1.0) ),
                     random( i + vec2(1.0,1.0) ), u.x), u.y);
}

// RR NOTES: something special about clamping tan angle above 1.5
mat2 rotate2d(float angle){
    return mat2(tan(angle),sin(angle),
                cos(angle),-sin(angle));
    // return mat2(log(angle),exp(angle),
    //             fract(angle),-fract(angle));
}

float lines(in vec2 pos, float b){
    float scale = 10.0;
    pos *= scale;
    return smoothstep(0.0,
                    .5+b*.5,
                    abs((fract(pos.x*3.1415)+b*2.0))*0.5);
}

// e4c752f, 23:26
void wood_bb_red_noise(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float bandpass_min_limit = 0.05;

    vec2 pos2 = pos.yx * vec2(10. * tan(u_time), 10.0 * fract(u_time));

    float pattern = pos2.x;

    // Add noise
    pos2 = rotate2d( noise(pos2, u_time) ) * pos2;

    // Draw lines
    pattern = lines(pos2, 0.1);

    color = vec3(pattern);

    if (audio.bandpass > bandpass_min_limit) {
      color = vec3(0.8, color.g - 0.4, color.b - 0.1290384);
    }
}

// e4c752f, 23:26
void wood_bb_red_tan_noise(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    vec2 pos2 = pos.yx * vec2(10. * tan(u_time), 10.0 * fract(u_time));

    float pattern = pos2.x;

    // Add noise
    pos2 = rotate2d( noise(pos2, u_time) ) * pos2;

    // Draw lines
    pattern = lines(pos2, pos.x * pos.y);

    color = vec3(pattern);

    float size = 5.5;
    color += SHARP(hexagon_sdf(pos * audio.notch * 0.5, size, audio.notch * 10.0));
    
    if (audio.bandpass > 0.10) {
      color = vec3(0.8, color.g - 0.4, color.b - 0.1290384);
    }
}
// 43e6235, Black and white tan wood
void wood_bb(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    vec2 pos2 = pos.yx*vec2(10. * fract(u_time),10.);

    float pattern = pos2.x;

    // Add noise
    pos2 = rotate2d( noise(pos2, u_time) ) * pos2;

    // Draw lines
    pattern = lines(pos2, pos.x * pos.y);

    color = vec3(pattern);
    // return  vec3(color.x + sin(u_time) * 1.1, 0.9, color.x - 0.1);

    float size = 5.5;
    color += SHARP(hexagon_sdf(pos * audio.notch * 0.5, size, audio.notch * 10.0));
		// color += SHARP(hexagon_sdf(pos * audio.notch * 0.5, size, 0.5));
    // color += SHARP(hexagon_sdf(pos * rotate2d(audio.notch * 0.1), audio.notch));
    
    // if (audio.bandpass > 50.0  && audio.bandpass < 70.0) {
    if (audio.bandpass > 0.10) {
      color = vec3(0.8, color.g - 0.4, color.b - 0.1290384);
    }

    // gl_FragColor = vec4(vec3(pattern),1.0);
}

float lines_hexagon_0(in vec2 pos, float b){
    float scale = 10.0;
    pos *= scale;
    return smoothstep(0.0,
                    .5+b*.5,
                    abs((sin(pos.x*3.1415)+b*2.0))*.5);
}

mat2 rotate2d_hexagon_0(float angle){
    return mat2(cos(angle),-sin(angle),
                sin(angle),cos(angle));
}
// Value noise_w by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float noise_w(vec2 pos, float u_t) {
    vec2 i = floor(pos);
    vec2 f = fract(pos);
    vec2 u = f*f*(3.0-2.0*f);
		// return mix( mix( random( i * sin(u_t * 0.5) + vec2(0.0,0.0) ),
		//                  random( i * sin(u_t * 0.5) + vec2(1.0,0.0) ), u.x),
		//             mix( random( i * sin(u_t * 0.5) + vec2(0.0,1.0) ),
		//                  random( i * sin(u_t * 0.5) + vec2(1.0,1.0) ), u.x), u.y);
		// return mix( mix( random( i * sin(u_t * 0.5) + vec2(0.0,0.0) ),
		//                  random( i * sin(u_t * 0.5) + vec2(1.0,0.0) ), u.x),
		//             mix( random( i * sin(u_t * 0.5) + vec2(0.0,1.0) ),
		//                  random( i * sin(u_t * 0.5) + vec2(1.0,1.0) ), u.x), u.y);
    return mix( mix( random( i + vec2(0.0,0.0) ),
                     random( i + vec2(1.0,0.0) ), u.x),
                mix( random( i + vec2(0.0,1.0) ),
                     random( i + vec2(1.0,1.0) ), u.x), u.y);
}

// 1e3befc, 23:29 hexagon wood bb
void wood_bb_hexagon_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
    vec2 pos2 = pos.yx*vec2(10. * tan(u_time),10. * fract(u_time));

    float pattern = pos2.x;

    // Add noise
    pos2 = rotate2d_hexagon_0( noise(pos2, u_time) ) * pos2;

    // Draw lines
    pattern = lines_hexagon_0(pos2,0.1);

    color = vec3(pattern);
    // return  vec3(color.x + sin(u_t) * 1.1, 0.9, color.x - 0.1);

    float size = 10.0;
    color += SHARP(hexagon_wood(pos * audio.notch * 10.5, size));
    // color += SHARP(hexagon_wood(pos * audio.notch * 0.5, size, 0.5));
    // color += SHARP(hexagon_sdf(pos * rotate2d(audio.notch * 0.1), audio.notch));
    
    // if (audio.notch > 50.0  && audio.notch < 70.0) {
    if (audio.notch > 0.1) {
      color = vec3(0.8, color.g + exp_out(audio.notch * 10.0) - 0.7, color.b + 0.4);
    }
    // gl_FragColor = vec4(vec3(pattern),1.0);
}
#endif
