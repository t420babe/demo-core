#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


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
    float v = -0.5;
    float a = 3.0;
    vec2 shift = vec2(0.0);
    // Rotate to reduce axial bias
    // mat2 rot = mat2(cos(0.5), sin(0.5), sin(0.5), cos(0.50));
    mat2 rot = mat2(tan(0.5), sin(0.5), sin(0.5), tan(0.50));
    for (int i = 0; i < num_octaves; ++i) {
        v += a * clouds_noise(_pos);
        _pos = rot * _pos * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void clouds(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    pos *= 3.0;
    pos = sin(pos);
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

    // float f = clouds_fbm(pos * r + smoothstep(audio.highpass, audio.highpass - 0.41, 0.1));
    // float f = clouds_fbm(pos * r / sin(audio.bandpass * 0.5));
    float f = clouds_fbm(pos * r / 0.5);

    color = mix(vec3(0.001961,0.619608,0.366667),
                vec3(0.966667,0.966667,0.998039),
                clamp((f * f) * 4.0, 0.0, 1.0));

    color = mix(color,
                vec3(1.0, 0.0, 0.164706),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.066667, 1, 2),
                clamp(length(r.x),1.0,0.0));

    color = vec3((f * f * f + 0.6 * f * f + 0.5 * f) * color);
}

vec2 tile(vec2 _pos, float _zoom){
  _pos *= _zoom;
  return fract(_pos);
}

float jail(vec2 _pos, float _radius){
  vec2 pos = vec2(0.5)-_pos;
  _radius *= 5.75 * abs(audio.highpass);
  return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), fract(pos.x * pos.y) * 0.05 * (abs(sin(u_time * 0.1)) + 0.1));
  // return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), fract(pos.x * pos.y) * 3.14 * (abs(sin(u_time * 2.5)) +1.0));
}

float circle(vec2 pos, float _radius){
  _radius *= 0.75;
  return 1.0 - smoothstep( _radius - (_radius * 0.05), _radius + (_radius * 0.05), dot(pos, pos) * 3.14 );
}

float rectangle(in vec2 pos, in vec2 origin, in vec2 dim) {
  vec2 aa = origin - dim / 2.0;
  vec2 bb = 1.0 - (origin + dim / 2.0);

  vec2 onblock = step(aa, pos);
  vec2 offblock = step(bb, 1.0 - pos);
  return (1.0 - onblock.x * onblock.y * offblock.x * offblock.y);
}


float rect_sdf(vec2 st, vec2 s) {
    st = st * 2.0;
    return max( abs(st.x/s.x),
                abs(st.y/s.y) );
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  vec2 pos_0 = tile(pos, 10.0);

  color = vec3(1.0, 0.5, 0.5);
  vec3 rect_color = vec3(rect_sdf(pos, vec2(1.1, 1.0)));
  clouds((pos + vec2(0.35)) * 1.5, u_time, audio, color);
  color -= rect_color * audio.bandpass;

  color = vec3(1.0) - color;
  // color = color.bgr;
  color = color.gbr;

  gl_FragColor = vec4(color, 1.0);
}

