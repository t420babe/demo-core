#ifndef T420BABE_COUCH_8
/// 15f1698 20:48
/// Yamaha by Aleksandir
/// qmetro - 50 ms
#define T420BABE_COUCH_8
float couch8_random (in vec2 st) {
  return fract(sin(dot(st.xy,
          vec2(12.9898,78.233)))*
      43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch8_noise (in vec2 st, peakamp audio) {
  vec2 i = floor(st);
  vec2 f = fract(st);

  // Four corners in 2D of a tile
  float a = couch8_random(i);
  float b = couch8_random(i + vec2(1.0, 10.0 * audio.bandpass));
  float c = couch8_random(i + vec2(0.0, 1.0));
  float d = couch8_random(i + vec2(1.0, 1.0));

  vec2 u = f * f * (3.0 - 2.0 * f);

  return mix(a, b, u.x) +
    (c - a)* u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

float couch8_fbm (in vec2 st, peakamp audio) {
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
    value += amplitude * couch8_noise(st, audio);
    st *= 8.0;
    // amplitude *= abs(sin(u_time)) - audio.notch;
    amplitude *= 0.5;
  }
  return value;
}

void couch8(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // pos.y += sin(u_time * 0.5);
  // pos.y += 0.5;
  color += couch8_fbm(pos * 5.0, audio);
  // color.r = abs(sin(u_time * audio.bandpass));
  color.r *= abs(tan(u_time));
  // // color.r -= 0.1;
  // color.b += audio.bandpass * 0.5;
  // color.g *= audio.bandpass;
  color.g *= (abs(cos(u_time))) * audio.bandpass;
  // color.g *= (0.0 + 0.4) * 0.1;
}
#endif

