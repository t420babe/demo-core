#ifndef T420BABE_COUCH_58
/// 6d2e175 lib/t420babe/couch/couch-1.glsl
#define T420BABE_COUCH_58

float couch58_random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch58_noise (in vec2 st, peakamp audio) {
    vec2 i = fract(st *  0.000001);
    vec2 f = fract(st * 0.1);

    // Four corners in 2D of a tile
    float a = couch58_random(i);
    float b = couch58_random(i * f + vec2(1.0, 10.0 * audio.bandpass));
    float c = couch58_random(i * f + vec2(0.0, 1.0));
    float d = couch58_random(i * f + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * i * f);

    return mix(a, d, u.y) +
            (c - a)* u.x * (1.0 - u.x) +
            (d - a) * u.x * u.y;
}

float couch58_fbm (in vec2 st, peakamp audio) {
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
        value += amplitude * couch58_noise(st, audio);
        st *= 8.0;
        // amplitude *= abs(sin(u_time)) - audio.notch;
        amplitude *= 0.5;
    }
    return value;
}

void couch58(vec2 pos, float u_time, peakamp audio, out vec3 color) {
    pos.y += mod(u_time * 0.4, 100.0);
    color += couch58_fbm(pos * 5.0, audio);
    // // Pink and Blue
    // color.r *= abs(tan(u_time));
    // color.g *= (abs(cos(u_time))) * audio.bandpass;

    // // Blue and green
    // color.b += (tan(u_time)) * audio.lowpass;
    // color.r *= (abs(cos(u_time))) * audio.bandpass;
    // color.g -= audio.notch;


    // All - looks cool
    color.r *= abs(tan(u_time));
    color.g *= (abs(cos(u_time))) * audio.bandpass;
    color.b += (tan(u_time)) * audio.lowpass;
    color.r *= (abs(cos(u_time))) * audio.bandpass;
    color.g -= audio.notch;

}
#endif
