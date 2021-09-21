// #effect #fav5 #shadershoot
#ifndef T4B_ABB_00
#define T4B_ABB_00

#ifndef COMMON_PEAKAMP
#include "lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "lib/common/plot.glsl"
#endif

#ifndef COMMON_TILE
#include "lib/common/tile.glsl"
#endif

#ifndef BOS_CLOUDS
#include "lib/bos/clouds.glsl"
#endif

#define NUM_OCTAVES_ABB_00 5

float abb_clouds_fbm ( in vec2 _pos) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(5.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5), sin(0.5), cos(0.50));
    for (int i = 0; i < NUM_OCTAVES_ABB_00; ++i) {
        v += a * clouds_noise(_pos);
        _pos = rot * _pos * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void clouds(vec2 pos, float time, peakamp audio, out vec3 color) {

    pos *= 3.0;
    pos = sin(pos);
    vec2 q = vec2(2.);
    q.x = abb_clouds_fbm( pos);
    q.y = abb_clouds_fbm( pos + vec2(1.0));

    vec2 r = vec2(0.0);
    r.x = abb_clouds_fbm( pos + 0.0 * q + vec2(0.7,9.2) + 0.15 * time );
    r.y = abb_clouds_fbm( pos + 0.0 * q + vec2(0.3,2.8) + 0.15 * time);
    // r.y += fract(abs(sin(time * 0.5)));
    // r.x += abs(cos(time * 0.5)) * r.y;

    // float f = abb_clouds_fbm(pos * r + smoothstep(audio.highpass, audio.highpass - 0.41, 0.1));
    // float f = abb_clouds_fbm(pos * r / sin(audio.bandpass * 0.5));
    float f = abb_clouds_fbm(pos * r / 0.5);

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


void abb_00(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  vec2 pos_0 = tile(pos, 10.0);

  color = vec3(1.0, 0.5, 0.5);
  clouds((pos + vec2(0.35)) * 1.5, time, audio, color);

  // color = vec3(1.0) - color;
  color = color.bgr;
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor = vec4(color.bgr, 1.0);
}

#endif
