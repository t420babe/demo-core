#ifdef GL_ES
precision mediump float;
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_HEXAGON
#include "./lib/pxl/hex-sdf.glsl"
#endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif


void goon_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(0.5);

  vec3 purp_color = vec3(0.0);
  orange_circle_bright_purple_bg(pos, u_time, audio, purp_color);

  float mult = 0.5;
  float my_hex = (wbl1_hexagon(pos, sin(u_time * mult), audio));
  color += (my_hex);
  color.r /= audio.lowpass * abs(sin(u_time * mult));
  color += sin(purp_color) + 0.5;
}

float clouds_random (in vec2 _pos) {
    return fract(sin(dot(_pos.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float clouds_noise (in vec2 _pos) {
    vec2 i = floor(_pos);
    vec2 f = fract(_pos);

    // Four corners in 2D of a tile
    float a = clouds_random(i);
    float b = clouds_random(i + vec2(1.0, 0.0));
    float c = clouds_random(i + vec2(0.0, 1.0));
    float d = clouds_random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}


float clouds_fbm ( in vec2 _pos) {
  int num_octaves = 5;
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(5.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5), sin(0.5), cos(0.50));
    for (int i = 0; i < num_octaves; ++i) {
        v += a * clouds_noise(_pos);
        _pos = rot * _pos * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void clouds(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    pos *= 2.5;
    pos = log(pos);
    vec2 q = vec2(2.);
    q.x = clouds_fbm( pos + 0.00*u_time);
    q.y = clouds_fbm( pos + vec2(1.0));

    vec2 r = vec2(0.0);
    r.x = clouds_fbm( pos + 0.0 * q + vec2(0.7,9.2)+ 0.15 * u_time );
    r.y = clouds_fbm( pos + 0.0 * q + vec2(0.3,2.8)+ 0.15 * u_time);
    // r.y += fract(abs(sin(u_time * 0.5)));
    r.y *- fract(u_time);
    // r.x += abs(cos(u_time * 0.5)) * r.y;
    r.x *- r.y;

    float f = clouds_fbm(pos+r);

    color = mix(vec3(0.001961,0.619608,0.366667),
                vec3(0.966667,0.966667,0.998039),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color,
                vec3(0,0,0.164706),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.066667,1,1),
                clamp(length(r.x),1.0,0.0));

    color = vec3((f*f*f+.6*f*f+.5*f * audio.bandpass)*color);
}
void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(0.5);
  float mult = 0.5;

  goon_1(pos, u_time, audio, color);
  vec3 clouds_color = vec3(1.0);
  clouds(pos, u_time, audio, clouds_color);
  // color.g = (sin(u_time * mult)) - 0.8;
  color *= clouds_color;
  gl_FragColor = vec4(color, 1.0);
}

