#ifndef CLOUDS_BOS
#define CLOUDS_BOS

float clouds_bos_random (in vec2 _pos) {
    return fract(sin(dot(_pos.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float clouds_bos_noise (in vec2 _pos) {
    vec2 i = floor(_pos);
    vec2 f = fract(_pos);

    // Four corners in 2D of a tile
    float a = clouds_bos_random(i);
    float b = clouds_bos_random(i + vec2(1.0, 0.0));
    float c = clouds_bos_random(i + vec2(0.0, 1.0));
    float d = clouds_bos_random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define NUM_OCTAVES 5

float clouds_bos_fbm ( in vec2 _pos) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5),
                    -sin(0.5), cos(0.50));
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * clouds_bos_noise(_pos);
        _pos = rot * _pos * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void clouds_bos(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    vec2 q = vec2(0.);
    q.x = clouds_bos_fbm( pos + 0.00*u_time);
    q.y = clouds_bos_fbm( pos + vec2(1.0));

    vec2 r = vec2(0.);
    r.x = clouds_bos_fbm( pos + 1.0*q + vec2(1.7,9.2)+ 0.15*u_time );
    r.y = clouds_bos_fbm( pos + 1.0*q + vec2(8.3,2.8)+ 0.126*u_time);

    float f = clouds_bos_fbm(pos+r);

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
