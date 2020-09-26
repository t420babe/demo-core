#ifndef T420BABE_DOPPLER
#define T420BABE_DOPPLER

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

// be8e320, main.frag
void doppler_blue_web(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos *= 5.0;
  pos.x += 0.5;
  pos.y += 0.50;
  color = vec3(1.1, 0.1234, 0.34);
  // float pct = aastep(pos.y, -pos.y) / sin(u_time);
  vec2 rot_pos = rotate(pos * 2.5, 0.0, 0.0);
  // float pct = sharp(cross_sdf(rot_pos * sin(u_time), 1.4));
  // float pct = cross_sdf(rotate(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  // pct *= circle_sdf(pos);
  // float pct2 = circle_sdf(pos);
  // float pct = sharp(hexagon_sdf(pos) / 10.0) * u_highpass;
  // pct += sharp(heart_sdf(pos + sin(u_time) * cos(u_time)));
  // pct += heart_sdf(pos);
  // float pct = heart_web(pos, audio, u_time) * audio.notch * 10.0;
  float pct = triangle_web_1(pos, audio, u_time) * audio.notch * 10.0;
  // float pct = triangle_sdf(pos) * audio.notch * 10.0;
  pct = sharp(pct);
  // float pct2 = (hexagon_sdf(pos) / 10.0) * u_highpass;
  // float pct2 = (hexagon_sdf(pos) / 1.0);
  float pct2 = (hexagon_web(pos) / 1.0);
  // pct2 = 0.5;
  // pct2 *= 2.0;
  color = vec3(pct * color * color + abs(cos(pct2)));
  color.r += -0.6;
  color.b += sin_in(audio.bandpass * 5.0);
  color.g += 0.4;
}

// 9643dad, 20:38 heart
void doppler_sharp_heart(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  pos.x += 0.5;
  pos.y += 0.50;
  color = vec3(1.1, 0.1234, 0.34);
  vec2 rot_pos = rotate(pos * 2.5, 0.0, 0.0);
  float pct = heart_sdf(pos) * audio.notch;
  pct = sharp(pct);
  float pct2 = (hexagon_sdf(pos) / 1.0);
  color = vec3(pct * color + color.gbr * pct2);
  color.r -= 0.4;
}

// f25c0d0, 20:30 pulse rainbow heart
void doppler_rainbow_heart(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  pos.x += 0.5;
  pos.y += 0.50;
  color = vec3(1.1, 0.1234, 0.34);
  // float pct = aastep(pos.y, -pos.y) / sin(u_time);
  vec2 rot_pos = rotate(pos * 2.5, 0.0, 0.0);
  // float pct = sharp(cross_sdf(rot_pos * sin(u_time), 1.4));
  // float pct = cross_sdf(rotate(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  // pct *= circle_sdf(pos);
  // float pct2 = circle_sdf(pos);
  float pct2 = audio.notch;
  float pct = heart_sdf(pos);
  // pct2 *= 2.0;
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.highpass;
  color.b = audio.notch;
  color.g -= audio.lowpass;
}

// e363836, 20:28 SICK RAINBOW at beat drop for sofias theme
void doppler_sofias_rainbow(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  pos.x += 0.50;
  pos.y += 0.50;
  color = vec3(1.1, 0.1234, 0.34);
  vec2 rot_pos = rotate(pos * 2.5, 0.0, 0.0);
  float pct = cross_sdf(rotate(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  float pct2 = audio.notch;
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.highpass;
	color.b = audio.notch;
  color.g -= audio.lowpass;
}

// 809fde9, main.frag green rooster with the sun sofia's theme
void doppler_red_red_sun(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  // pos.x += 0.40;
  // pos.y += 0.50;
  color = vec3(1.0, 0.1234, 0.34);
  float pct = aastep(pos.y, -pos.y) * sin(u_time);
  // float pct = cross_sdf(rotate(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass * 2.5;
	color.b *= audio.notch;
  color.g += audio.highpass;
}

// 809fde9, main.frag green rooster with the sun sofia's theme
void doppler_green_rooster(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  // pos.x += 0.40;
  // pos.y += 0.50;
  color = vec3(1.0, 0.1234, 0.34);
  float pct = aastep(pos.y, -pos.y) * sin(u_time);
  pct *= cross_sdf(rotate(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass * 2.5;
	color.b *= audio.notch;
  color.g += audio.lowpass;
}

// 07c5717, main.frag 20:15 sun star rooster
void doppler_sun_star_rooster(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  // pos.x += 0.40;
  // pos.y += 0.50;
  color = vec3(1.0, 0.1234, 0.34);
  float pct = cross_sdf(rotate(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass * 2.5;
	color.b *= audio.notch;
  color.g += audio.lowpass;
}

// d6dda81, main.frag 20:12 spinning
void doppler_blue_cross_spinning(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  // pos.x += 0.40;
  // pos.y += 0.50;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = cross_sdf(rotate(pos, circle_sdf(vec2(u_time, u_time) * 0.5), 0.0), 0.4);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.highpass * 2.5;
}

// d5ebf1, main.frag
void doppler_blue_cross(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  pos.x += 0.4;
  pos.y += 0.5;

  color = vec3(1.0, 0.1234, 0.34);
  float pct = cross_sdf(pos, 0.4);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.lowpass * 4.5;
}

// 847e20e, main.frag
void doppler_blue_step_cross_horizontal(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  float pct = aastep(pos.y, -pos.y);

  pos.x += 0.4;
  pos.y += 0.5;

  color = vec3(1.0, 0.1234, 0.34);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.notch * 4.5;

  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);
}

// 38f3323, main.frag 20:02 cross_sdf
void doppler_blue_step_cross(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  pos.x += 0.4;
  pos.y += 0.5;

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.highpass * 4.5;

  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);
}

void doppler_floating_ring_morph(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos -= 0.0;
  // pos *= 2.5 * circle_sdf(pos * mod(u_time, 4.0));
  pos *= 2.5 * circle_sdf(pos * tan(u_time));

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.bandpass * 10.0;

  float rect = cross_sdf(pos, 0.4);
  // color = vec3(pct * color + color * rect);
  // color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler_floating_ring_morph_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos /= 3.0;
  pos.x += 0.25;
  pos.y += 0.2;
  pos *= 2.5 * circle_sdf(pos * mod(u_time, 10.0));
  pos *= 2.5 * circle_sdf(pos * tan(u_time));

  vec3 color_0 = vec3(1.1, 0.1234, 0.34);
  color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r - (audio.bandpass * 8.0);
  color.g = color.g * (audio.bandpass * 2.0);
  color.b = color.b + (audio.bandpass * 2.0);

  float rect = cross_sdf(pos, 0.4);
  // color = vec3(pct * color + color * rect);
  // color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler_cross_step_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos -= 0.0;
  float rate = 6.0;
  // pos *= 2.5 * circle_sdf(pos * mod(u_time, 4.0));
  pos *= 2.5 * circle_sdf(pos * tan(u_time * rate));

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.bandpass;
  color.g = color.g * audio.bandpass;
  color.b = color.b * audio.notch;

  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);
  color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler_cross_step_2(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos /= 2.0;
  float rate = 1.0;
  // pos *= 2.5 * circle_sdf(pos * mod(u_time, 4.0));
  pos += 0.5 * circle_sdf(pos * tan(u_time * rate));

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.bandpass;
  color.g = color.g * audio.bandpass;
  color.b = color.b * audio.notch;

  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);
  color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler_cross_step_3(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float rate = 1.0;
  // pos *= 2.5 * circle_sdf(pos * mod(u_time, 4.0));
  // pos += 0.5 * circle_sdf(pos * tan(u_time * rate));
  pos *= 0.5 * circle_sdf(pos * tan(u_time * rate));

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.bandpass;
  color.g = color.g * audio.bandpass;
  color.b = color.b * audio.notch;

  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);
  color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler_cross_step_4(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos -= 0.0;
  float rate = 1.0;
  // pos *= 2.5 * circle_sdf(pos * mod(u_time, 4.0));
  // pos += 0.5 * circle_sdf(pos * tan(u_time * rate));
  pos /= 0.5 * circle_sdf(pos * tan(u_time * rate));

  vec3 color_0 = vec3(1.1, 0.1234, 0.34);
  color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color_0 + color * pct2);
  color.r = color.r * audio.bandpass;
  color.g = color.g * audio.bandpass;
  color.b = color.b * audio.notch;

  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);
  color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler_cross_step_5(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos /= 2.5;
  float rate = 1.0;
  pos *= 2.5 * circle_sdf(pos * mod(u_time, 7.0));
  pos += 0.5 * circle_sdf(pos * tan(u_time * rate));

  vec3 color_0 = vec3(0.7, 0.7234, 0.84);
  color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color_0 + color * pct2);

  float rect = cross_sdf(pos, 2.0);
  color = vec3(pct * color + color * rect);
  color = vec3(pct2 * color + color * vec3(0.5));

  color.r = color.r - (audio.bandpass * 1.0);
  color.g = color.g * (audio.bandpass * 1.0);
  color.b = color.b + audio.notch * 8.0;
}

void doppler_cross_step_6(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos /= 3.0;
  float rate = 1.0;
  pos *= 2.5 * circle_sdf(pos * mod(u_time, 7.0));
  pos += 0.5 * circle_sdf(pos * tan(u_time * rate));

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.bandpass;
  color.g = color.g * audio.bandpass;
  color.b = color.b * audio.notch;

  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);
  color = vec3(pct2 * color + color * vec3(0.5));
}



void doppler_cross_step_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos += 0.2;
  pos *= 0.5;
  // pos *= 2.5 * circle_sdf(pos * mod(u_time, 4.0));
  pos *= 2.5 * circle_sdf(pos * tan(u_time * 2.0));

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.bandpass * 10.0;

  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);
  // color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler_cross_step(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos -= 0.0;
  // pos *= 2.5 * circle_sdf(pos * mod(u_time, 4.0));
  pos *= 2.5 * circle_sdf(pos * tan(u_time * 2.0));

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.bandpass * 5.0;

  float rect = cross_sdf(pos, 0.4);
  // color = vec3(pct * color + color * rect);
  // color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler_trial(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  // pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  pos *= rotate(pos, fract(audio.notch), 4.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  // pos *= rotate(pos, (cos(u_time))/cos(pos.y * pos.y), audio.notch);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass);
  color = vec3(pct * color + color * pct2);

  // color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
  color = vec3(color.x * audio.highpass, color.y * audio.lowpass, color.z);
}

// 544eb2, tilifoundyou.frag
void doppler_pink_blue_sand(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));

  // pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  pos *= rotate(pos, fract(audio.notch), 4.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  // pos *= rotate(pos, (cos(u_time))/cos(pos.y * pos.y), audio.notch);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  // color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
  color = vec3(color.x * audio.highpass, color.y * audio.lowpass, color.z);
}

// af8eb42b, 00:25 melting squares
void doppler_melting_square_glitch_fuck_with(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));

  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  pos *= rotate(pos, (cos(u_time))/cos(pos.y * pos.y), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// af8eb42b, 00:25 melting squares
void doppler_melting_square_glitch(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));

  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  pos *= rotate(pos, (cos(u_time))/cos(pos.y * pos.y), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 1544c24, 00:23 i just like it vertical ok
void doppler_twisting_timer(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  // pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  pos *= rotate(pos, (cos(u_time))/cos(pos.y * pos.y), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// d4cedf, 00:22 cos cos
void doppler_trippy_melting_diamond(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  // pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  pos *= rotate(pos, (cos(u_time))/cos(pos.x * pos.y), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);

}

// 6c5265, 00:22 trippy diamond cube
void doppler_trippy_diamond(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  // pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  pos *= rotate(pos, (tan(u_time))/tan(pos.x * pos.y), audio.bandpass * 10.0);


  vec3 color_0 = vec3(1.0, 0.1234, 0.34);
  color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  color.r += audio.highpass;
	color.b += audio.notch;
  color.g -= audio.lowpass * 7.0;
}

// 6c5265, 00:22 trippy diamond cube
void doppler_trippy_diamond_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  // pos /= abs(w_time);
  pos *= 5.0;
  // RRTI: (Transition Idea):
  // pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos *= rotate(pos, fract(pos.y), audio.bandpass * 10.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  // pos *= rotate(pos, (tan(u_time))/tan(pos.x * pos.y), 1.0);


  vec3 color_0 = vec3(1.0, 0.1234, 0.34);
  color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  color.r += audio.highpass;
	color.b += audio.notch;
  color.g -= audio.lowpass * 7.0;
}

//b5ba9f, 00:21 extra flinch
void doppler_morph(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
	// pos *= rotate(pos, 0.0, 4.0); // then on the beat:
	// pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  // pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  pos *= rotate(pos, (tan(u_time))/exp(pos.x * pos.y), 1.0);


  vec3 color_0 = vec3(1.1, 0.1234, 0.34);
  color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);
}

//b5ba9f, 00:21 extra flinch
void doppler_morph_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
	// pos *= rotate(pos, 0.0, 4.0); // then on the beat:
	// pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
	// pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  pos /= rotate(pos, (tan(u_time))/exp(pos.x * pos.y), audio.bandpass * 5.0);


  vec3 color_0 = vec3(1.1, 0.1234, 0.34);
  // color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  color = vec3(0.81176470588, 0.88823529411 * audio.bandpass * 5.0, audio.bandpass);
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);
}

//b5ba9f, 00:21 extra flinch
void doppler_morph_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  // pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
	// pos *= rotate(pos, 0.0, 4.0); // then on the beat:
	// pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
	// pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  pos /= rotate(pos, (tan(u_time))/exp(pos.x * pos.y), audio.bandpass * 5.0);


  vec3 color_0 = vec3(1.1, 0.1234, 0.34);
  // color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  color = vec3(0.81176470588, 0.88823529411 * audio.bandpass * 5.0, audio.bandpass);
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);
}

//b5ba9f, 00:21 extra flinch
void doppler_morph_2(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
	// pos *= rotate(pos, 0.0, 4.0); // then on the beat:
	// pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
	// pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);
  pos /= rotate(pos, (tan(u_time))/exp(pos.x * pos.y), audio.bandpass * 5.0);


  vec3 color_0 = vec3(1.1, 0.1234, 0.34);
  color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}


// f92ca4a, 00:15 cube guppy
void cube_guppy_doppler(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  // pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate(pos, (sin(u_time))/exp(pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));
  vec3 color_0 = vec3(0.9, 0.7, 0.34);
  color = vec3(0.91176470988, audio.bandpass * 5.0, audio.notch);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);
}


// 983da1, 00:12 its a butterfly
void curly_butterfly_doppler(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time) * 3.0;
  // float w_time = log(sin(u_time));

  pos /= abs(w_time);
  pos *= 4.0;
  pos *= rotate(pos, 0.0, 4.0);   // then on beat:
  pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate(pos, log(pos.x), 1.0);

  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));
  vec3 color_0 = vec3(0.8, 0.8234, 0.34);
  color = vec3(0.81176470588, 0.38823529411, audio.bandpass * 2.0);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 983da1, 00:12 its a butterfly
void cacoon_doppler(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time) * 3.0;
  // float w_time = log(sin(u_time));

  pos /= abs(w_time);
  pos *= 4.0;
  pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate(pos, log(pos.x), 1.0);

  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

}

// 983da1, 00:12 its a butterfly
void butterfly_doppler(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time) * 3.0;
  // float w_time = log(sin(u_time));

  pos /= abs(w_time);
  pos *= 4.0;
    // pos *= rotate(pos, 0.0, 4.0); // then on the beat:
    // pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
    pos *= rotate(pos, log(pos.x), 1.0);

  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// ce8d83, 00:11 weird wave urchin mouth
void sea_urchin_mouth_doppler(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  pos *= rotate(pos, 0.0, 4.0); // then on the beat:
  pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos /= rotate(pos, (pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// aeacd1, 00:09 vagina sea urchin
void vagina_sea_urchin_doppler(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));

  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  // pos /= rotate(pos, 0.0, 4.0); // then on the beat:
  pos *= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos /= rotate(pos, (pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);

}

// a6364b, 00:08 sound wave sea urchin
void sea_urchin_doppler(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  // pos /= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate(pos, (pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 0fa6c8, 00:03
void square_doppler_pulse(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= 0.15;
  // RRTI: (Transition Idea):
  // pos /= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate(pos, fract(pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 22ebc4, 00:02b
void square_doppler_yellow(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));

  pos /= 0.01;
  // RRTI: (Transition Idea):
  // pos /= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate(pos, fract(pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}


// 630a19, 00:02
void choppy_doppler_square_fractal_zoom_out(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  // pos /= 0.05;
  // pos *= rotate(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);

  pos *= 100.0;
  pos /= rotate(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 630a19, 00:02
void choppy_doppler_square_fractal_zoom_out_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  // pos /= 0.05;
  // pos *= rotate(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);

  pos *= 100.0;
  pos /= rotate(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));
  color = vec3(0.8 - audio.bandpass, audio.bandpass * 2.0 + 0.2, audio.bandpass * 4.0 + 0.3);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
}

void choppy_doppler_square_fractal_pulse(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  // pos /= 0.05;
  // pos *= rotate(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);

  pos *= 100.0 * w_time;
  pos /= rotate(pos, fract(fract(pos.y) * fract(pos.x)), 0.1);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

void choppy_doppler_square_fractal_pulse_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  // pos /= 0.05;
  // pos *= rotate(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);

  pos *= 100.0 * w_time;
  pos /= rotate(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 630a19, 00:02
void choppy_doppler_square_fractal(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));


  pos /= 0.05;
  pos *= rotate(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);



  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 630a19, 00:02
void choppy_doppler_square(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // float w_time = sin(u_time);
  float w_time = sin(u_time) * 0.1;
  // float w_time = log(sin(u_time));


  pos /= 0.05;
  // RRTI: (Transition Idea):
  // pos /= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate(pos, fract(pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 97b16a, 23:59 another amazing transistion
void plaid_choppy_glossy(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // float w_time = sin(u_time);
  float w_time = fract(tan(u_time));

  pos /= 0.1;
	pos /= rotate(pos, 0.0, 4.0);
  pos /= rotate(pos, fract(pos.y) * audio.bandpass * 10.0, 4.0);

  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 97b16a, 23:59 another amazing transistion
void plaid_choppy_glossy_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // float w_time = sin(u_time);
  float w_time = fract(tan(u_time));

  pos /= 0.1;
	pos /= rotate(pos, 0.0, 4.0);
  pos /= rotate(pos, fract(pos.y) * audio.bandpass * 10.0, 4.0);

  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.1234, 0.5);
  // color = vec3(0.81176470588, 0.38823529411, audio.bandpass * 2.0);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 97b16a, 23:59 another amazing transistion
void choppy_glossy(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = abs(sin(u_time));
  // float w_time = log(sin(u_time));


  pos /= 0.1;
  // RRTI: (Transition Idea):
  // pos /= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos /= rotate(pos, fract(pos.y), 4.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, audio.notch, (abs(tan(u_time))));
  vec3 color_0 = vec3(0.8, 0.8234, audio.notch);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  // color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);

}

// 97b16a, 23:59 another amazing transistion
void choppy_glossy_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = abs(sin(u_time));
  // float w_time = log(sin(u_time));


  pos /= 0.1;
  // RRTI: (Transition Idea):
  pos /= rotate(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate(pos, fract(pos.y), 4.0);   // then on beat:
  pos /= rotate(pos, fract(pos.y), 4.0);


  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, audio.notch, (abs(tan(u_time))));
  vec3 color_0 = vec3(0.8, 0.8234, audio.notch);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  // color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);

}

// e442e6, 23:57 amazing transition
void flossy_glossy(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));

  pos /= 0.1;
  // RRTI: (Transition Idea):
  // pos /= rotate(pos, 0.0, 4.0); then on the beat:
  pos /= rotate(pos, pos.y, 4.0);


  // color = vec3(1.0, 0.1234, (tan(u_time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(u_time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 29480f, 23:44 uhh ok this is the coolest thing ive ever seen
void doppler_cross_plaid_glitch(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // pos /= 0.1;
  pos /= rotate(pos, 0.0, 4.0);
  pos += 10.0;

  float w_time = sin(u_time * audio.lowpass * 10.0);
  color = vec3(1.0, 0.3234, 0.4);
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * abs(w_time) * 0.1, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));
}

// 29480f, 23:44 uhh ok this is the coolest thing ive ever seen
void doppler_cross_plaid_glitch_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // pos /= 0.1;
  pos /= rotate(pos, 0.0, 4.0);
  pos += 10.0;

  float w_time = sin(u_time * audio.lowpass * 10.0);
  color = vec3(1.0, 0.3234, audio.lowpass);
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * abs(w_time) * 0.1, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));
}

// 29480f, 23:44 uhh ok this is the coolest thing ive ever seen
void doppler_cross_plaid(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos /= 0.1;
  pos /= rotate(pos, 0.0, 4.0);

  float w_time = abs(sin(u_time));
  // float w_time = log(sin(u_time));
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(1.0, 0.5234, audio.lowpass);
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

}

// 117be2, 23:43 i invented a plaid
void doppler_plaid(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos /= rotate(pos, 0.0, 0.0);

  float w_time = abs(sin(u_time));
  color = vec3(1.0, 0.0, audio.notch);
  // vec3 color_0 = vec3(audio.bandpass, 1.0, audio.notch);
  vec3 color_0 = vec3(1.0, audio.bandpass, audio.notch);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * audio.bandpass, audio.bandpass * 10.0);
	color = vec3(pct * color_0 + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));

}

// 52f7fa, 23:40 oh shit we rotatin
void doppler_spaceship(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  int idx_w_time = 0;

  float w_time = sin(u_time);

  if (idx_w_time == 0) {
    w_time = sin(u_time);
  } else if (idx_w_time == 1) {
    w_time = log(sin(u_time));
  }
  pos *= 21.5;
  pos *= rotate(pos, sin(u_time), 4.0);

  color = vec3(1.0, 0.1234, abs(tan(u_time)));
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * w_time, audio.bandpass);
  // color = vec3(pct * color + color * pct2);    // with step
  color = vec3(pct2 * color + color * vec3(0.5)); // without step

}

// 52f7fa, 23:40 oh shit we rotatin
void doppler_diamond_collide(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  // pos *= 5.5;
  pos *= rotate(pos, 0.5, 0.0);

  float w_time = sin(u_time);
  // float w_time = log(sin(u_time));
  // color = vec3(1.0, 0.1234, abs(tan(u_time)));
  color = vec3(audio.bandpass, 1.0, audio.bandpass);
  vec3 color_0 = vec3(audio.bandpass, 1.0, audio.notch);
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));

}

// y=x line, dark fuzzy circle moving back and forth, turns blue at furthest dist
// fc2eb2, 23:33 tan to blue 
void doppler_step_pink_blue(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos *= 5.5;

	float w_time = sin(u_time);
	// float w_time = log(sin(u_time));
  color = vec3(1.0, 0.1234, abs(tan(u_time)));
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
  // color = vec3(pct2 * color + color * vec3(0.5));
}

// y=x line, dark fuzzy circle moving back and forth, turns blue at furthest dist
// fc2eb2, 23:33 tan to blue 
void doppler_step_pink_blue_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos *= 5.5;

	float w_time = sin(u_time);
	// float w_time = log(sin(u_time));
  // color = vec3(1.0, audio.bandpass, 0.4234);
  // color = vec3(audio.notch, 0.1234, 1.0);
  color = vec3(1.0, 0.1234, audio.bandpass * 2.0);
  vec3 color_0 = vec3(1.0, audio.bandpass, audio.bandpass);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);
  // color = vec3(pct2 * color + color * vec3(0.5));


}

// y=x line, dark fuzzy circle moving back and forth, flash of yellow at furthest dist
void doppler_step_pink_yellow(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos *= 5.5;

  float w_time = cos(u_time);
  // float w_time = log(sin(u_time));
  color = vec3(1.0, 0.1234, audio.notch);
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_0(pos * w_time, audio.bandpass) / audio.notch;
  float pct2 = circle_0(pos * w_time, audio.bandpass);
	color = vec3(pct * color + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));

}

// 25eb7a, main.frag
// shakey, shaky 
void doppler_shaky_shaky(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.y += 0.45;
  pos.x += 0.35;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y * sin(audio.highpass));
  float pct2 = circle_sdf(pos) - 1.0;
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass;
  color.b = color.b * audio.highpass * 10.0;
  // color = vec3(pct2 * color + color * vec3(0.5));
}

// 25eb7a, main.frag
// shakey, shaky 
void doppler_shaky_shaky_3(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.y += 0.45;
  pos.x += 0.35;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x * tan(audio.highpass), -pos.y * cos(audio.highpass));
  float pct2 = circle_sdf(pos) - 1.0;
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass;
  color.b = color.b * audio.highpass * 10.0;
  // color = vec3(pct2 * color + color * vec3(0.5));
}

// 25eb7a, main.frag
// shakey, shaky 
void doppler_shaky_shaky_2(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.y += 0.45;
  pos.x += 0.35;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x * tan(audio.highpass), pos.y * atan(audio.highpass));
  float pct2 = circle_sdf(pos) - 1.0;
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass;
  color.b = color.b * audio.highpass * 10.0;
  // color = vec3(pct2 * color + color * vec3(0.5));
}

// 25eb7a, main.frag
// shakey, shaky 
void doppler_shaky_shaky_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.y += 0.45;
  pos.x += 0.35;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(pos.x * tan(audio.highpass), pos.y * atan(audio.highpass));
  float pct2 = circle_sdf(pos) - 1.0;
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass;
  color.b = color.b * audio.highpass * 10.0;
  // color = vec3(pct2 * color + color * vec3(0.5));
}

// 25eb7a, main.frag
// shakey, shaky 
void doppler_shaky_shaky_0b(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.y += 0.45;
  pos.x += 0.35;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x * tan(audio.highpass), -pos.y * cos(audio.highpass));
  float pct2 = circle_sdf(pos) - 1.0;
  // color = vec3(pct * color + color * pct2);
  color *= pct2 * audio.notch;
  // color.r = color.r * audio.highpass;
  color.b *= audio.bandpass * 10.0;
  // color = vec3(pct2 * color + color * vec3(0.5));
}

// 25eb7a, main.frag
// shakey, shaky 
void doppler_shaky_shaky_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.y += 0.45;
  pos.x += 0.35;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(pos.y * tan(audio.highpass), pos.y * atan(audio.highpass));
  float pct2 = circle_sdf(pos) - 1.0;
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass;
  color.b = color.b * audio.highpass * 10.0;
  // color = vec3(pct2 * color + color * vec3(0.5));
}

// 25eb7a, main.frag
// shakey, shaky 
void doppler_shaky_blue(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.y += 0.45;
  pos.x += 0.35;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y * sin(audio.bandpass));
  float pct2 = circle_sdf(pos) - 1.0;
  color = vec3(pct * color + color * pct2);
	color.r = color.r * audio.lowpass;
}

// 89e139c, main.frag
void doppler_blue_fights_pink(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.notch * 10.0;
  // color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler(vec2 pos, float u_time, out vec3 color) {

  int shader_idx = 0;
  int color_idx = 2;

  float w_time = sin(u_time);
  color = vec3(1.1, 0.1234, 0.34);

  float pct = 1.0;
  float pct2 = 1.0;

  if (shader_idx == 0) {
    pct = aastep(-pos.x, -pos.y);
    pct2 = circle_sdf(pos * w_time);

  } else if (shader_idx == 1) {
    pos *= 50.0;
    pos += 0.45;

    pct = aastep(-pos.x, -pos.y);
    pct2 = circle_sdf(pos * w_time);

  } else if (shader_idx == 2) {
    pct = aastep(-pos.x, -pos.y);
    pct2 = circle_sdf(pos);

  } else if (shader_idx == 3) {
    pos *= 50.0;
    pos += 0.45;

    pct = aastep(-pos.x, -pos.y);
    pct2 = circle_sdf(pos);
  }

  if (color_idx == 0) {
    color = vec3(pct * color + color * pct2);
  } else if (color_idx == 1) {
    color = vec3(pct2 * color + color * vec3(0.5));
  } else if (color_idx == 2) {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(0.5));
  } else {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(0.5));
  }
}

// Moonlight by Gaulin 20 qmetro
void doppler_audio(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  int color_idx = 0;

  pos *= 50.0 * audio.bandpass;
  pos += 0.45;

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_sdf(pos);

  if (color_idx == 0) {
    color = vec3(pct * color + color * pct2 * audio.bandpass * 50.0);
  } else if (color_idx == 1) {
    color = vec3(pct2 * color + color * vec3(audio.bandpass * 50.0));
  } else if (color_idx == 2) {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(audio.bandpass * 10.0));
  } else {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(0.5));
  }
}


#endif
