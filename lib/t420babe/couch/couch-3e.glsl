#ifndef T420BABE_COUCH_3E
#define T420BABE_COUCH_3E
/// 635168d 02:09
/// Turn Mills - Club Mix by Maribou State
float couch3e_random (in vec2 st) {
  return fract(sin(dot(st.xy,
          vec2(12.9898,78.233)))*
      43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch3e_noise (in vec2 st) {
  vec2 i = floor(st);
  vec2 f = fract(st);

  // Four corners in 2D of a tile
  float a = couch3e_random(i);
  float b = couch3e_random(i + vec2(1.0, 0.0));
  float c = couch3e_random(i + vec2(0.0, 1.0));
  float d = couch3e_random(i + vec2(1.0, 1.0));

  vec2 u = f * f * (3.0 - 2.0 * f);

  return mix(a, b, u.x) +
    (c - a)* u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

float couch3e_fbm(in vec2 st, peakamp audio, float u_time) {
  // Initial values
  float value = -0.3;
  float amplitude = 1.0;
  // float amplitude = audio.bandpass * 2.0;
  // float amplitude = abs(sin(u_time));
  float frequency = 0.0;
  //
  // Loop of octaves
  int octaves = 6;
  for (int i = 0; i < octaves; i++) {
    value += amplitude * couch3e_noise(st * audio.notch);
    st *= 17.0 * audio.lowpass;
    amplitude *= abs(sin(u_time)) - audio.lowpass;
  }
  return value;
}

void couch3e(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // pos.y += 0.5;
  pos.x += 0.3;
  color += couch3e_fbm(pos * 5.0, audio, u_time);
  // color.r = abs(sin(u_time * audio.bandpass));
  // color.r = abs(sin(audio.bandpass));
  color.r = audio.notch;
  // color.r -= 0.1;
  // color.b += 0.1;
}
#endif
