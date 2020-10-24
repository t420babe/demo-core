#ifndef T420BABE_COUCH_2
#define T420BABE_COUCH_2
/// 39028f0 01:50
/// All Over Again - Edit by Saffron Stone
float couch2_random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch2_noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = couch2_random(i);
    float b = couch2_random(i + vec2(1.0, 0.0));
    float c = couch2_random(i + vec2(0.0, 1.0));
    float d = couch2_random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

float couch2_fbm (in vec2 st, peakamp audio) {
    // Initial values
    // float value = -0.1;
    float value = -0.5;
    float amplitude = audio.bandpass * 2.0;
    float frequency = 0.0;
    //
    // Loop of octaves
		int octaves = 6;
    for (int i = 0; i < octaves; i++) {
        value += amplitude * couch2_noise(st);
        st *= 3. * audio.lowpass;
        amplitude *= .5;
    }
    return value;
}

void couch2(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos /= 1.5;
    color += couch2_fbm(pos*8.0, audio);
    // color.r = abs(sin(u_time * audio.bandpass));
    // color.r = clamp(abs(sin(u_time * 1.0)) - 0.1, 0.2, 0.8);
    // color.r = abs(sin(u_time * 1.0));
    color.b += 0.5;
    color.g += 0.1;
}
#endif
