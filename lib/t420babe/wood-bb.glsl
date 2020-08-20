// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com
#ifndef COMMON_EASING_FUNCTIONS
#include "../common/easing-functions.glsl"
#endif

#ifndef COMMON_PLOT
#include "../common/plot.glsl"
#endif

#ifndef FNC_HEXSDF
#include "../pixel-spirit-deck/hexSDF.glsl"
#endif

#ifndef FNC_HEARTSDF
#include "../pixel-spirit-deck/heartSDF.glsl"
#endif


float random (in vec2 pos) {
    return fract(sin(dot(pos.xy,
                         vec2(12.9898,78.233)))
                * 43758.5453123);
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float noise(vec2 pos, float u_t) {
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

vec3 wood_bb(vec4 frag_coord, vec2 u_r, float u_t, float full_ave, float full_max) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
    // pos.y *= u_r.y/u_r.x;

    vec2 pos2 = pos.yx*vec2(10. * fract(u_t),10.);

    float pattern = pos2.x;

    // Add noise
    pos2 = rotate2d( noise(pos2, u_t) ) * pos2;

    // Draw lines
    pattern = lines(pos2,pos.x*pos.y);

    vec3 color = vec3(pattern);
    // return  vec3(color.x + sin(u_t) * 1.1, 0.9, color.x - 0.1);

    float size = 5.5;
    color += SHARP(hexSDF(pos * full_ave * 0.5, size));
    // color += SHARP(hexSDFheart(pos * full_ave * 0.5, size));
    // color += SHARP(hexSDF(pos * rotate2d(full_ave * 0.1), full_ave));
    
    // if (full_max > 50.0  && full_max < 70.0) {
    if (full_max > 100.0) {
      color = vec3(0.8, color.g - 0.4, color.b - 0.1290384);
    }

    return color;
    // gl_FragColor = vec4(vec3(pattern),1.0);
}
