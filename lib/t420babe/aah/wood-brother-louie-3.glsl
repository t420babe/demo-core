#ifndef T420BABE_WOOD_BROTHER_LOUIE_3
#define T420BABE_WOOD_BROTHER_LOUIE_3
// 755320c, 18:27 hesagrownassfirefighter

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

float wbl3_random (in vec2 pos) {
  return fract((dot(pos.xy,
          vec2(12.9898,78.233)))
      * 43758.5453123);
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float wbl3_noise(vec2 pos, float u_time) {
  vec2 i = floor(pos);
  vec2 f = fract(pos);
  vec2 u = f*f*(3.0-2.0*f);
  return mix( mix( wbl3_random( i + vec2(0.0,0.0) ),
        wbl3_random( i + vec2(1.0,0.0) ), u.x),
        mix( wbl3_random( i + vec2(0.0,1.0) ),
        wbl3_random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 wbl3_rotate2d(float angle){
  return mat2(cos(angle),-sin(angle),
      sin(angle),cos(angle));
}

float wbl3_lines(in vec2 pos, float b){
  float scale = 10.0;
  pos *= scale;
  return smoothstep(0.0,
      .5+b*.5,
      abs((sin(pos.x*3.1415)+b*2.0))*.5);
}

void wbl3_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  vec2 pos2 = pos.yx;

  float pattern = pos2.x;
  float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;

  // Add noise
  pos2 = wbl3_rotate2d( wbl3_noise(pos2, u_time) ) * pos2;

  // Draw lines
  pattern = wbl3_lines(pos2,0.1);

  color = vec3(pattern);

  float size = 1.5;
  color += SHARP(wbl1_hexagon(pos * audio_ave * 4.0, size, audio));

  if (audio.lowpass < 0.65) {
    color = vec3(color.r + 0.1, color.g - 0.6, color.b + 0.4);
  }
}

#endif
