#ifndef T420BABE_COUCH
#define T420BABE_COUCH
float couch_random (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

float couch_noise(in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = couch_random(i);
    float b = couch_random(i + vec2(1.0, 0.0));
    float c = couch_random(i + vec2(0.0, 1.0));
    float d = couch_random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

float couch_fbm(in vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitude = .5;
    float frequency = 0.;
    //
    // Loop of octaves
		int octaves = 6;
    for (int i = 0; i < octaves; i++) {
        value += amplitude * couch_noise(st);
        st *= 2.;
        amplitude *= .5;
    }
    return value;
}

void couch(vec2 pos, float u_time, peakamp audio, out vec3 color) {
    color += couch_fbm(pos*3.0);
}
#endif
