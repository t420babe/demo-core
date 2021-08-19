#ifndef T420BABE_COUCH_14
/// 302d51c 20:56 oh okay
/// RR NOTE: There is a flash on magenta in here that is really cool
/// Try to see if i can bring that out more.
/// Saw it when listening to Buya - Loco Dice Kliptown Love Remix by Black Coffee, Toshi
/// To really see the magenta, pause the music (aka set audio strcut members == 0)
/// Yamaha by Aleksandir
/// qmetro - 50 ms
#define T420BABE_COUCH_14
float couch14_random (in vec2 st) {
  return fract(sin(dot(st.xy,
          vec2(12.9898,78.233)))*
      43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float couch14_noise (in vec2 st, peakamp audio) {
  vec2 i = floor(st * 0.01);
  vec2 f = log(st * 0.01);

  // Four corners in 2D of a tile
  float a = couch14_random(i);
  float b = couch14_random(i + vec2(1.0, 10.0 * audio.bandpass));
  float c = couch14_random(i + vec2(0.0, 1.0));
  float d = couch14_random(i + vec2(1.0, 1.0));

  vec2 u = f * f * (3.0 - 2.0 * f);

  return mix(a, b, u.x) +
    (c - a)* u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

float couch14_fbm (in vec2 st, peakamp audio) {
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
    value += amplitude * couch14_noise(st, audio);
    st *= 8.0;
    // amplitude *= abs(sin(u_time)) - audio.notch;
    amplitude *= 0.5;
  }
  return value;
}

void couch14(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // pos.y += sin(u_time * 0.5);
  // pos.y += 0.5;
  color += couch14_fbm(pos * 5.0, audio);
  // color.r = abs(sin(u_time * audio.bandpass));
  color.r *= abs(tan(u_time));
  // // color.r -= 0.1;
  // color.b += audio.bandpass * 0.5;
  // color.g *= audio.bandpass;
  color.g *= (abs(cos(u_time))) * audio.bandpass;
  // color.g *= (0.0 + 0.4) * 0.1;
}
#endif

