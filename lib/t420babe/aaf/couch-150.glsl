#ifndef T420BABE_COUCH_150
/// f382483 lib/t420babe/couch/couch-1.glsl
#define T420BABE_COUCH_150
float couch150_random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch150_noise (in vec2 st, peakamp audio) {
    // vec2 i = log(st.xx *  0.00001);
    vec2 i = (tan(st.xx *  0.00001));
    vec2 f = fract((st.yy * 0.1));

    // Four corners in 2D of a tile
    float a = couch150_random(i);
    float b = couch150_random(i * f + vec2(1.0, 10.0 * audio.bandpass));
    float c = couch150_random(i * f + vec2(0.0, 1.0));
    float d = couch150_random(i * f + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * i * i);

    return mix(a, d, u.y) +
            (c - a)* u.x * fract(1.0 - u.x) +
            (d - a) * u.x * u.y;
}

float couch150_fbm (in vec2 st, peakamp audio) {
    st.y += 2.5;
    // st /= 10.0;
    // Initial values
    float value = -audio.bandpass;
    float amplitude = 0.5;
    // float amplitude = audio.bandpass * 2.0;
    // float amplitude = abs(sin(u_time));
    float frequency = 1.0;
    //
    // Loop of octaves
		int octaves = 6;
    for (int i = 0; i < octaves; i++) {
        value += amplitude * couch150_noise(st, audio);
        st *= 8.0;
        // amplitude *= abs(sin(u_time)) - audio.notch;
        amplitude *= 0.5;
    }
    return value;
}

void couch150(vec2 pos, float u_time, peakamp audio, out vec3 color) {
    // pos.y += sin(u_time * 0.5);
    // pos.y += 0.5;
    color += couch150_fbm(pos * 5.0, audio);
    // Red, light purple, green
    color.r /= audio.notch;
    color.g = 0.3;

    // // Red, yellow, blue
    // color.r /= audio.notch;
    // color.b = 0.3;

    // // Blue, yellow, green
    // color.g /= audio.notch;
    // color.b = 0.3;
}
#endif
