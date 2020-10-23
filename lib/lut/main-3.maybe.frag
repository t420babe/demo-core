#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

uniform sampler2D u_tex0;
uniform sampler2D u_tex1;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

// Author: Matt DesLauriers
// https://github.com/mattdesl/glsl-lut/blob/master/index.glsl
//
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
  u_time -= 20.0;
    #ifndef LUT_NO_CLAMP
        textureColor = clamp(textureColor, 0.0, 1.0);
    #endif

    float rate = 0.3;
    float start = 0.0;
    float end = 250.0;
    float blueColor = textureColor.r * (mod(u_time * rate, end - start) + start);

    float mul = 11.0;
    vec2 quad1 = vec2(0.0);
    // quad1.y = floor(floor(blueColor) / mul * (abs(sin(u_time) - audio.notch)));
    quad1.y = floor(floor(blueColor) / mul);
    quad1.x = floor(blueColor) - (quad1.y * mul);

    vec2 quad2 = vec2(0.0);
    quad2.y = floor(ceil(blueColor) / mul);
    quad2.x = ceil(blueColor) - (quad2.y * mul);

    vec2 texPos1 = vec2(0.0);
    // texPos1.y = (quad1.x * 0.125) + 10.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r * audio.lowpass);
    texPos1.y = (quad1.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texPos1.x = (quad1.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);

    #ifdef LUT_FLIP_Y
        texPos1.y = 1.0-texPos1.y;
    #endif

    vec2 texPos2 = vec2(0.0);
    texPos2.x = (quad2.x * 0.125) + 0.5/512.0 + ((0.125 - 100.0/512.0) * textureColor.r);
    texPos2.y = (quad2.y * 0.125) + 0.5/512.0 + ((0.125 - 100.0/512.0) * textureColor.g);

    #ifdef LUT_FLIP_Y
        texPos2.y = 1.0 - texPos2.y;
    #endif

    vec4 newColor1 = texture2D(lookupTable, texPos1);
    vec4 newColor2 = texture2D(lookupTable, texPos2);

    vec4 newColor = mix(newColor1, newColor2, fract(blueColor) * log(blueColor));
    return newColor * audio.lowpass;
}

void main(){
	vec2 pos = gl_FragCoord.xy / u_resolution.xy;
  pos.x *= 1.5;
  pos.x -= 0.25;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

	vec3 color = vec3(0.5);
	vec4 srcColor = texture2D(u_tex0, pos);
  
	vec3 dstcolor = lookup(srcColor, u_tex1, audio, u_time).rgb;

  // dstcolor.g *= clamp(abs(sin(audio.bandpass)), audio.lowpass, abs(audio.highpass)) + audio.notch;
  // // Color scheme 0
  // dstcolor.b *= audio.notch * 2.0;
  // dstcolor.b /= audio.lowpass;
  // dstcolor.g *= abs(audio.highpass) - 0.4;
  // dstcolor.g *= clamp(abs(sin(audio.highpass)), 0.0, abs(audio.lowpass));
  // dstcolor.g += abs(audio.highpass) - 0.4;

  // // // Color scheme 1
  // dstcolor.r *= audio.notch * 2.0;
  // dstcolor.r /= audio.lowpass;
  // dstcolor.b *= abs(audio.highpass) - 0.4;

  // Color scheme 2
  // dstcolor.r *= abs(sin(u_time));
  // dstcolor.g *= abs(cos(u_time));
  // dstcolor.g *= abs(audio.bandpass + audio.highpass);

  dstcolor = abs(audio.highpass) - dstcolor + abs(audio.bandpass);
	gl_FragColor = vec4( dstcolor , 1.0);
}
