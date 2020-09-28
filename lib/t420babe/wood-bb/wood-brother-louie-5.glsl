#ifndef T420BABE_WOOD_BROTHER_LOUIE_5
#define T420BABE_WOOD_BROTHER_LOUIE_5

// b80dcf97, 23:56

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif


float wbl5_random (in vec2 pos) {
    return fract(sin(dot(pos.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

float wbl5_noise(vec2 pos, float u_time) {
    vec2 i = floor(pos);
    vec2 f = fract(pos);
    vec2 u = f*f*(3.0-2.0*f);
    return mix( mix( wbl5_random( i + vec2(0.0,0.0) ), wbl5_random( i + vec2(1.0,0.0) ), u.x),
                mix( wbl5_random( i + vec2(0.0,1.0) ), wbl5_random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 wbl5_rotate2d(float angle){
    return mat2(tan(angle),sin(angle), cos(angle),-sin(angle));
}

mat2 wbl5b_rotate2d(float angle){
    return mat2(tan(clamp(angle, 1.5, 3.14)), sin(angle), cos(angle),-sin(angle));
}

float wbl5_lines(in vec2 pos, float b){
    float scale = 10.0;
    pos *= scale;
    return smoothstep(0.0, .5+b*.5, abs((sin(pos.x*3.1415)+b*2.0))*.5);
}

void wbl5_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    vec2 pos2 = pos.yx*vec2(10. * sin(u_time),10.);

    float pattern = pos2.x;
		float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;

    // Add wbl5_noise
		pos2 = wbl5_rotate2d( noise(pos2, u_time) ) * pos2;

    // Draw wbl5_lines
    pattern = wbl5_lines(pos2,0.1);

    color = vec3(pattern);
    // return  vec3(color.x + sin(u_time) * 1.1, 0.9, color.x - 0.1);

    float size = 6.5;
    color += SHARP(wbl1_hexagon(pos * audio_ave * 4.0, size, audio));
    // color += SHARP(hex_sdfheart(pos * full_ave * 0.5, size));
    // color += SHARP(hex_sdf(pos * (full_ave * 0.1), full_ave));
    
    // if (full_max > 50.0  && full_max < 70.0) {
    if (audio.lowpass < 0.65) {
      color = vec3(0.7, color.g + 0.0, color.b + 0.3);
    }
}

void wbl5b_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    // vec2 pos2 = pos.yx*vec2(10. * sin(u_time),10.);
    vec2 pos2 = pos.yx*vec2(10. * sin(pos.y),10.);

    float pattern = pos2.x;
		float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;

    // Add wbl5_noise
		pos2 = wbl5b_rotate2d( noise(pos2, u_time) ) * pos2;

    // Draw wbl5_lines
    pattern = wbl5_lines(pos2,0.1);

    color = vec3(pattern);
    // return  vec3(color.x + sin(u_time) * 1.1, 0.9, color.x - 0.1);

    float size = 9.0;
    color += SHARP(wbl1_hexagon(pos * audio_ave * 4.0, size, audio));
    // color += SHARP(
    // color += SHARP(hex_sdfheart(pos * full_ave * 0.5, size));
    // color += SHARP(hex_sdf(pos * (full_ave * 0.1), full_ave));
    
    if (audio.lowpass < 0.65) {
      color = vec3(0.7, color.g + 0.0, color.b + 0.3);
    }
}

// In Memoriam (Mixed) - Ben Bohmer
void wbl5c_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    // vec2 pos2 = pos.yx*vec2(10. * sin(u_time),10.);
    vec2 pos2 = pos.yx*vec2(10. * sin(pos.y),10.);

    float pattern = pos2.x;
		float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;

    // Add wbl5_noise
		pos2 = wbl5b_rotate2d( noise(pos2, u_time) ) * pos2;

    // Draw wbl5_lines
    pattern = wbl5_lines(pos2,0.1);

    color = vec3(pattern);
    // return  vec3(color.x + sin(u_time) * 1.1, 0.9, color.x - 0.1);

    float size = 3.0;
    color += (wbl1_hexagon(pos * audio_ave * 4.0, size, audio));
    // color += SHARP(
    // color += SHARP(hex_sdfheart(pos * full_ave * 0.5, size));
    // color += SHARP(hex_sdf(pos * (full_ave * 0.1), full_ave));
    
    // if (audio.lowpass < 0.65) {
    if (audio.lowpass < 0.55) {
      color = vec3(0.7, color.g - 0.6, color.b - 0.3);
    } else {
      color -= vec3(1.0, color.g - 0.1, color.b - 0.3);
    }
}

// Decade - Ben Bohmer ft Jan Blomqvist
void wbl5d_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    // vec2 pos2 = pos.yx*vec2(10. * sin(u_time),10.);
    vec2 pos2 = pos.yx*vec2(10. * sin(pos.y),10.);

    float pattern = pos2.x;
		float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;

    // Add wbl5_noise
		pos2 = wbl5b_rotate2d( noise(pos2, u_time) ) * pos2;

    // Draw wbl5_lines
    pattern = wbl5_lines(pos2,0.1);

    color = vec3(pattern);
    // return  vec3(color.x + sin(u_time) * 1.1, 0.9, color.x - 0.1);

    float size = 2.0;
    color /= (wbl1_hexagon(pos * audio_ave * 10.0, size, audio));
    // color -= (heart_sdf(pos + vec2(0.5)));
    float poly_size = 1.5;
    color *= (polygon(pos + vec2(0.5), 10, poly_size));
    
    // if (audio.lowpass < 0.65) {
    if (audio.lowpass > 0.60) {
      color = vec3(0.7, color.g - 0.6, color.b - 0.3);
    } else {
      color = vec3(0.7, color.g - 0.6, color.b - 0.3);
      color = color.bgr;
      // color.b -= 0.2;
      // color -= vec3(1.0, color.g - 0.1, color.b - 0.3);
    }
}


#endif
