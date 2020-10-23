#ifndef LUT_2
#define LUT_2
// Original algorithm: from Matt DesLauriers, https://github.com/mattdesl/glsl-lut/blob/master/index.glsl
#define LUT_NO_CLAMP
#define LUT_FLIP_Y

float wrap_time_not_quite(float start, float end, float rate, float u_time) {
  // float mod_time = mod(u_time, limit);
  float mod_time = mod(u_time * rate, end) + start;
  if (mod_time < end / 2.0) {
    return mod_time;
  } else {
    return end - mod_time;
  }
}

float wrap_time(float u_time, float limit, float offset) {
  float mod_time = mod(u_time, limit - offset) + offset;
  if (mod_time < (limit - offset) / 2.0) {
    return mod_time;
  } else {
    return limit - mod_time;
  }
}


float loop(float start, float end, float speed, float u_time) {
  return (mod(u_time * speed, end) + start);
}

vec4 lookup(in vec4 textureColor, in sampler2D lookupTable, peakamp audio, float u_time) {
    #ifndef LUT_NO_CLAMP
        textureColor = clamp(textureColor, 0.0, 1.0);
    #endif

    // float blueColor = textureColor.b * 63.0;
    float rate = 3.0;
    float start = 30.0;
    float end = 250.0;
    float blueColor = textureColor.r * (mod(u_time * rate, end - start) + start);
    // float blueColor = textureColor.b * mod(u_time * 10.0, 10.0);
    // float blueColor = textureColor.b * loop(5.0, 200.0, 10.0, u_time);
    // float blueColor = textureColor.b * wrap_time_not_quite(0.0, 170.0, 15.0, u_time);
    // float blueColor = textureColor.b * wrap_time(u_time, 100.0, 60.0);

    vec2 quad1 = vec2(0.0);
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);

    vec2 quad2 = vec2(0.0);
    quad2.y = floor(ceil(blueColor) / 8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);

    vec2 texPos1 = vec2(0.0);
    texPos1.x = (quad1.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texPos1.y = (quad1.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);

    #ifdef LUT_FLIP_Y
        texPos1.y = 1.0-texPos1.y;
    #endif

    vec2 texPos2 = vec2(0.0);
    texPos2.x = (quad2.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texPos2.y = (quad2.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);

    #ifdef LUT_FLIP_Y
        texPos2.y = 1.0-texPos2.y;
    #endif

    vec4 newColor1 = texture2D(lookupTable, texPos1);
    vec4 newColor2 = texture2D(lookupTable, texPos2);

    vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    return newColor;
}

void lut_2(vec2 pos, float u_time, peakamp audio, sampler2D u_tex0, sampler2D u_tex1, out vec3 color) {

	vec4 srcColor = texture2D(u_tex0, pos);
	color = lookup(srcColor, u_tex1, audio, u_time).rgb;

  // // Color scheme 0
  // color.b *= audio.notch * 2.0;
  // color.b /= audio.lowpass;
  // color.g += abs(audio.highpass) - 0.4;

  // Color scheme 1
  color.r *= abs(sin(u_time));
  // color.r *= abs(tan(audio.bandpass));
  color.g *= abs(audio.bandpass + audio.highpass);
  // color.g *= abs(sin(u_time) * audio.notch);
  // color.r *= (tan(u_time)) * audio.bandpass;
  // color.b
  // color.g *= abs(audio.lowpass) + 0.5;
  // color.r -= abs(audio.notch) + 0.4;
  // color.r /= abs(audio.highpass) + audio.lowpass;
  // color.g += abs(audio.highpass) - 0.4;

}
#endif
