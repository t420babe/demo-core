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



/* AUDIO_CIRCLE BEGIN */
#ifndef T420BABE_AUDIO_CIRCLE

/* PXL_CIRCLE BEGIN */
#ifndef PXL_CIRCLE
float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}
#endif
/* PXL_CIRCLE END */

void purple_circle_oh_yes_he_is_mio(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  color = vec3(0.2, 0.243, 0.0234);

  float pct = sharp(circle_1(pos * 1.1, audio.bandpass / 1.5));
  color = vec3(pct * color + pct + color.gbr);
}
#endif
/* AUDIO_CIRCLE END */

/* CLOUDS BEGIN */
#ifndef CLOUDS
float clouds_random (in vec2 _pos) {
    return fract(sin(dot(_pos.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

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

    vec2 q = vec2(0.);
    q.x = clouds_fbm( pos + 0.00*u_time);
    q.y = clouds_fbm( pos + vec2(1.0));

    vec2 r = vec2(0.);
    r.x = clouds_fbm( pos + 1.0*q + vec2(1.7,9.2)+ 0.15*u_time );
    r.y = clouds_fbm( pos + 1.0*q + vec2(8.3,2.8)+ 0.126*u_time);

    float f = clouds_fbm(pos+r);

    color = mix(vec3(0.101961,0.619608,0.666667),
                vec3(0.666667,0.666667,0.498039),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color,
                vec3(0,0,0.164706),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.666667,1,1),
                clamp(length(r.x),0.0,1.0));

    color = vec3((f*f*f+.6*f*f+.5*f)*color);
}
#endif
/* CLOUDS END */

/* T420BABE_SHARP_HEART BEGIN */
#ifndef T420BABE_SHARP_HEART
void say_nothing_none(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  clouds(pos, u_time, audio, color);
  // float vesica_wrap = wrap_time(u_time, 100.0);
  // float tri_wrap = 1.5;
  // float tri = (triangle_web_0(pos, audio, u_time * 0.1));
  // color *= (tri);

  color.g *= audio.bandpass;
  color.g /= audio.bandpass * 4.0;
  // color.b *= audio.lowpass * 1.0;
  // color.b *= audio.highpass * 2.5;
  color.b *= abs(sin(u_time));
  // color += heart_color;
  // color.r *= abs(audio.bandpass);
}
#endif
/* T420BABE_SHARP_HEART END */

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);
  vec3 purp_circle =  vec3(0.0);
  purple_circle_oh_yes_he_is_mio(pos, u_time, audio, purp_circle);
  color += purp_circle;

  say_nothing_none(pos, u_time, audio, color);

  gl_FragColor = vec4(color, 1.0);
}
