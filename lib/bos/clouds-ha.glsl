#ifndef BOS_CLOUDS_HA
#define BOS_CLOUDS_HA

float clouds_ha_random (in vec2 _pos) {
    return fract(sin(dot(_pos.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float clouds_ha_noise (in vec2 _pos) {
    vec2 i = fract(_pos);
    vec2 f = fract(_pos);

    // Four corners in 2D of a tile
    float a = clouds_ha_random(i);
    float b = clouds_ha_random(i + vec2(1.0, 0.0));
    float c = clouds_ha_random(i + vec2(0.0, 1.0));
    float d = clouds_ha_random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}


float clouds_ha_fbm ( in vec2 _pos) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(5.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(tan(0.5), sin(0.5) * audio.bandpass * 2.0, sin(0.5), cos(0.50));
    for (int i = 0; i < 9; ++i) {
        v += a * clouds_ha_noise(_pos);
        _pos = rot * _pos * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void clouds_ha(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    vec2 q = vec2(0.);
    q.x = clouds_ha_fbm( pos + 0.00*u_time);
    q.y = clouds_ha_fbm( pos + vec2(1.0));

    vec2 r = vec2(0.);
    r.x = clouds_ha_fbm( pos + 1.0*q + vec2(1.7,9.2)+ 0.15*u_time );
    r.y = clouds_ha_fbm( pos + 1.0*q + vec2(8.3,2.8)+ 0.126*u_time);

    float f = clouds_ha_fbm(pos+r);

    color = mix(vec3(0.001961,audio.notch,0.066667),
                vec3(0.066667,0.066667,0.498039 * audio.highpass),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color, vec3(audio.notch, 0, 0.164706), clamp(length(q),0.0,1.0));

    color = mix(color, vec3(0.666667,1,audio.highpass), clamp(length(r.x),0.0,1.0));

    color = vec3((f*f*f+.6*f*f+.5*f)*color) * audio.lowpass;
    color.r *= audio.bandpass; 
    // color.g *= audio.highpass;
    // color.b *= audio.lowpass;
}
#endif
