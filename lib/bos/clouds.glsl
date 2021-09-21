#ifndef BOS_CLOUDS
#define BOS_CLOUDS

#ifndef COMMON_RANDOM
#include "lib/common/random.glsl"
#endif

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float clouds_noise (in vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define BOS_CLOUDS_NUM_OCTAVES 5


float clouds_fbm ( in vec2 _st) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5),
                    -sin(0.5), cos(0.50));
    for (int i = 0; i < BOS_CLOUDS_NUM_OCTAVES; ++i) {
        v += a * clouds_noise(_st);
        _st = rot * _st * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

vec3 clouds(vec2 st, float time, peakamp audio) {
    // st += st * abs(sin(time*0.1)*3.0);
    vec3 color = vec3(0.0);

    vec2 q = vec2(0.);
    q.x = clouds_fbm( st + 0.00*time);
    q.y = clouds_fbm( st + vec2(1.0));

    vec2 r = vec2(0.);
    r.x = clouds_fbm( st + 1.0*q + vec2(1.7,9.2)+ 0.15*time );
    r.y = clouds_fbm( st + 1.0*q + vec2(8.3,2.8)+ 0.126*time);

    float f = clouds_fbm(st+r);

    color = mix(vec3(0.101961,0.619608,0.666667),
                vec3(0.666667,0.666667,0.498039),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color,
                vec3(0,0,0.164706),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.666667,1,1),
                clamp(length(r.x),0.0,1.0));

    return vec3((f*f*f+.6*f*f+.5*f)*color);
}

#endif
