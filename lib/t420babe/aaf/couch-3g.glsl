#ifndef T420BABE_COUCH_3G
#define T420BABE_COUCH_3G
/// 635168d 02:09
/// Turn Mills - Club Mix by Maribou State
float couch3g_random (in vec2 st) {
  return fract(sin(dot(st.xy,
          vec2(12.9898,78.233)))*
      43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch3g_noise (in vec2 st) {
  vec2 i = floor(st);
  vec2 f = fract(st);

  // Four corners in 2D of a tile
  float a = couch3g_random(i);
  float b = couch3g_random(i + vec2(1.0, 0.0));
  float c = couch3g_random(i + vec2(0.0, 1.0));
  float d = couch3g_random(i + vec2(1.0, 1.0));

  vec2 u = f * f * (3.0 - 2.0 * f);

  return mix(a, b, u.x) +
    (c - a)* u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

float couch3g_fbm (in vec2 st, peakamp audio) {
  // Initial values
  float value = -2.0 * audio.lowpass;
  float amplitude = 2.0;
  // float amplitude = audio.bandpass * 2.0;
  // float amplitude = abs(sin(u_time));
  float frequency = 1.5;
  //
  // Loop of octaves
  int octaves = 6;
  for (int i = 0; i < octaves; i++) {
    value += amplitude * couch3g_noise(st);
    st *= 7.0 * audio.lowpass;
    amplitude *= abs(sin(u_time)) - audio.lowpass;
  }
  return value;
}

void couch3g(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos /= 1.5;
  // pos.y += 0.5;
  pos.x += 0.3;
  color = vec3(couch3g_fbm(pos * 8.0, audio));
  // color.r = abs(sin(u_time * audio.bandpass));
  color.r *= abs(sin( u_time * audio.bandpass));
  // color.r = audio.notch;
  // color.r -= 0.1;
  color.g *= audio.bandpass;
}
#endif
