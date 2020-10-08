#ifndef T420BABE_COUCH_5
#define T420BABE_COUCH_5
/// 1f7a3e8 02:12
float couch5_random (in vec2 st) {
  return fract(sin(dot(st.xy,
          vec2(12.9898,78.233)))*
      43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch5_noise (in vec2 st, peakamp audio) {
  vec2 i = floor(st);
  vec2 f = fract(st) * audio.bandpass;

  // Four corners in 2D of a tile
  float a = couch5_random(i);
  float b = couch5_random(i + vec2(1.0, 0.0));
  float c = couch5_random(i + vec2(0.0, 1.0));
  float d = couch5_random(i + vec2(1.0, 1.0));

  vec2 u = f * f * (3.0 - 2.0 * f);

  return mix(a, b, u.x) +
    (c - a)* u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

float couch5_fbm (in vec2 st, peakamp audio) {
  // Initial values
  float value = -0.3;
  float amplitude = audio.bandpass * 3.0;
  // float amplitude = audio.bandpass * 2.0;
  // float amplitude = abs(sin(u_time));
  float frequency = audio.lowpass;
  //
  // Loop of octaves
  int octaves = 6;
  for (int i = 0; i < octaves; i++) {
    value += amplitude * couch5_noise(st, audio);
    st *= 8.0;
    amplitude *= abs(sin(u_time)) - audio.notch;
  }
  return value;
}

void couch5(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.y += 0.3;
  color += couch5_fbm(pos * 5.0, audio);
  // color.r = abs(sin(u_time));
  color.r = abs(tan(audio.notch));
  // color.r += audio.notch;
  color.b += 0.1;
}
#endif

