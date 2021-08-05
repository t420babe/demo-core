#ifndef T420BABE_COUCH_65
/// 55ff042 lib/t420babe/couch/couch-1.glsl
#define T420BABE_COUCH_65
float couch65_random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch65_noise (in vec2 st, peakamp audio) {
    vec2 i = fract(st *  0.000001);
    vec2 f = fract(st * 0.001);

    // Four corners in 2D of a tile
    float a = couch65_random(i);
    float b = couch65_random(i * f + vec2(1.0, 10.0 * audio.bandpass));
    float c = couch65_random(i * f + vec2(0.0, 1.0));
    float d = couch65_random(i * f + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * i * f);

    return mix(a, d, u.y) +
            (c - a)* u.x * (1.0 - u.x) +
            (d - a) * u.x * u.y;
}

float couch65_fbm (in vec2 st, peakamp audio) {
    // st -= 2.5;
    // Initial values
    float value = -audio.bandpass;
    float amplitude = 1.0;
    // float amplitude = audio.bandpass * 2.0;
    // float amplitude = abs(sin(u_time));
    float frequency = 1.0;
    //
    // Loop of octaves
		int octaves = 6;
    for (int i = 0; i < octaves; i++) {
        value += amplitude * couch65_noise(st, audio);
        st *= 8.0;
        // amplitude *= abs(sin(u_time)) - audio.notch;
        amplitude *= 0.5;
    }
    return value;
}

void couch65(vec2 pos, float u_time, peakamp audio, out vec3 color) {
    pos.x += mod(u_time * 0.5, 100.0);
    color += couch65_fbm(pos * 5.0, audio);
    color.r += audio.lowpass;
    color.g = 1.0;
    color.b += 0.2;
}
#endif
