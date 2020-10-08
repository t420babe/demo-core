#ifndef T420BABE_COUCH_106
/// 53249d0 lib/t420babe/couch/couch-1.glsl
#define T420BABE_COUCH_106
float couch106_random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch106_noise (in vec2 st, peakamp audio) {
    vec2 i = log(st.xx *  0.00001);
    // vec2 i = (tan(st.xx *  0.00001));
    vec2 f = (fract(st.yy * 0.0001));

    // Four corners in 2D of a tile
    float a = couch106_random(i);
    float b = couch106_random(i * f + vec2(1.0, 10.0 * audio.bandpass));
    float c = couch106_random(i * f + vec2(0.0, 1.0));
    float d = couch106_random(i * f + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * i * f);

    return mix(a, d, u.y) +
            (c - a)* u.x * (1.0 - u.x) +
            (d - a) * u.x * u.y;
}

float couch106_fbm (in vec2 st, peakamp audio) {
    // st.y += 2.5;
    st /= 50.0;
    // Initial values
    float value = -audio.bandpass;
    float amplitude = 5.0 * audio.notch;
    // float amplitude = audio.bandpass * 2.0;
    // float amplitude = abs(sin(u_time));
    float frequency = 1.0;
    //
    // Loop of octaves
		int octaves = 6;
    for (int i = 0; i < octaves; i++) {
        value += amplitude * couch106_noise(st, audio);
        st *= 8.0;
        // amplitude *= abs(sin(u_time)) - audio.notch;
        amplitude *= audio.bandpass;
    }
    return value;
}

void couch106(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos = pos.yx;
  pos.y += 0.5;

  color.r *= audio.lowpass * 1.5;
  // color.g *= audio.highpass * 1.5;

  color += couch106_fbm(pos * 5.0, audio)  * audio.bandpass;
  // color = couch106_fbm(pos * 5.0, audio)  * audio.bandpass * abs(sin(u_time));
  color.r *= couch106_fbm(pos * 5.0, audio)  * audio.bandpass;

}
#endif
