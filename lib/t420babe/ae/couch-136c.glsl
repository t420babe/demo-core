#ifndef T420BABE_COUCH_136C
/// Aftershock by admo
#define T420BABE_COUCH_136C
float couch136c_random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch136c_noise (in vec2 st, peakamp audio) {
    vec2 i = log(st.xx *  0.00001);
    // vec2 i = (tan(st.xx *  0.00001));
    vec2 f = fract((st.yy * 0.001));

    // Four corners in 2D of a tile
    float a = couch136c_random(i);
    float b = couch136c_random(i * f + vec2(1.0, 10.0 * audio.bandpass));
    float c = couch136c_random(i * f + vec2(0.0, 1.0));
    float d = couch136c_random(i * f + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * i * i);

    return mix(a, d, u.y) +
            (c - a)* u.x * (1.0 - u.x) +
            (d - a) * u.x * u.y;
}

float couch136c_fbm (in vec2 st, peakamp audio) {
    st.y += 2.5;
    // st /= 10.0;
    // Initial values
    float value = -audio.bandpass * 10000.0;
    float amplitude = 5.2;
    // float amplitude = audio.bandpass * 2.0;
    // float amplitude = abs(sin(u_time));
    float frequency = 1.0;
    //
    // Loop of octaves
		int octaves = 6;
    for (int i = 0; i < octaves; i++) {
        value += amplitude * couch136c_noise(st, audio);
        st *= 8.0;
        // amplitude *= abs(sin(u_time)) - audio.notch;
        amplitude *= 0.5;
    }
    return value;
}

void couch136c(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, 1.0, audio.highpass * 1.0);
  pos /= 20000.0;
  pos *= 1.5;
    // pos.y += sin(u_time * 0.5);
    // pos.y += 0.5;
    // color += couch136c_fbm(pos, audio);
    color.r *= couch136c_fbm(pos, audio);
    color.b /= couch136c_fbm(pos, audio);
    color.g += couch136c_fbm(pos, audio);
    // color.r = abs(sin(u_time * audio.bandpass));
    // color.r *= abs(tan(u_time));
    // // color.r -= 0.1;
    // color.b *= abs(sin(audio.bandpass));
    // color.g += audio.bandpass;
    // color.g *= (abs(cos(u_time))) * audio.bandpass;
    // color.g *= (0.0 + 0.4) * 0.1;
}
#endif
