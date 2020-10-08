#ifndef T420BABE_COUCH_155
/// e6198aa lib/t420babe/couch/couch-1.glsl
#define T420BABE_COUCH_155
float couch155_random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch155_noise (in vec2 st, peakamp audio) {
    // vec2 i = log(st.xx *  0.00001);
    vec2 i = (tan(st.xx *  0.0001));
    vec2 f = fract((st.yy * 0.00001));

    // Four corners in 2D of a tile
    float a = couch155_random(i);
    float b = couch155_random(i * f + vec2(1.0, 10.0 * audio.bandpass));
    float c = couch155_random(i * f + vec2(0.0, 1.0));
    float d = couch155_random(i * f + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * i * i);

    return mix(a, d, u.y) +
            fract(c - a)* u.x * fract(1.0 - u.x) +
            (d - a) * u.x * u.y;
}

float couch155_fbm (in vec2 st, peakamp audio) {
    st.y += 2.5;
    // st /= 10.0;
    // Initial values
    float value = -audio.bandpass;
    float amplitude = 5.2;
    // float amplitude = audio.bandpass * 2.0;
    // float amplitude = abs(sin(u_time));
    float frequency = 1.0;
    //
    // Loop of octaves
		int octaves = 6;
    for (int i = 0; i < octaves; i++) {
        value += amplitude * couch155_noise(st, audio);
        st *= 8.0;
        // amplitude *= abs(sin(u_time)) - audio.notch;
        amplitude *= 0.5;
    }
    return value;
}

void couch155(vec2 pos, float u_time, peakamp audio, out vec3 color) {
    // pos.y += sin(u_time * 0.5);
    // pos.y += 0.5;
    color += couch155_fbm(pos * 5.0, audio);
    // Blue, yellow, green
    color.r /= audio.notch;
    color.g = 0.3;
    color.b = audio.lowpass;

}
#endif
