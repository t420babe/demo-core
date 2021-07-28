#ifndef T4B_AC_02
#define T4B_AC_02

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif


void butterfly_doppler(vec2 pos, float time, peakamp audio, out vec3 color) {
}

// ce8d83, 00:11 weird wave urchin mouth
void sea_urchin_mouth_doppler(vec2 pos, float time, peakamp audio, out vec3 color) {
}

// aeacd1, 00:09 vagina sea urchin
void vagina_sea_urchin_doppler(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));

  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  // pos /= rotate_w_offset(pos, 0.0, 4.0); // then on the beat:
  pos *= rotate_w_offset(pos, fract(pos.y), 4.0);   // then on beat:
  pos /= rotate_w_offset(pos, (pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);

}

// a6364b, 00:08 sound wave sea urchin
void sea_urchin_doppler(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));


  pos /= abs(w_time);
  pos *= 4.0;
  // RRTI: (Transition Idea):
  // pos /= rotate_w_offset(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate_w_offset(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate_w_offset(pos, (pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 0fa6c8, 00:03
void square_doppler_pulse(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));


  pos /= 0.15;
  // RRTI: (Transition Idea):
  // pos /= rotate_w_offset(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate_w_offset(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate_w_offset(pos, fract(pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 22ebc4, 00:02b
void square_doppler_yellow(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));

  pos /= 0.01;
  // RRTI: (Transition Idea):
  // pos /= rotate_w_offset(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate_w_offset(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate_w_offset(pos, fract(pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}


// 630a19, 00:02
void choppy_doppler_square_fractal_zoom_out(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));


  // pos /= 0.05;
  // pos *= rotate_w_offset(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);

  pos *= 100.0;
  pos /= rotate_w_offset(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 630a19, 00:02
void choppy_doppler_square_fractal_zoom_out_0(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));


  // pos /= 0.05;
  // pos *= rotate_w_offset(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);

  pos *= 100.0;
  pos /= rotate_w_offset(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  // color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));
  color = vec3(0.8 - audio.bandpass, audio.bandpass * 2.0 + 0.2, audio.bandpass * 4.0 + 0.3);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
}

void choppy_doppler_square_fractal_pulse(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));


  // pos /= 0.05;
  // pos *= rotate_w_offset(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);

  pos *= 100.0 * w_time;
  pos /= rotate_w_offset(pos, fract(fract(pos.y) * fract(pos.x)), 0.1);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

void choppy_doppler_square_fractal_pulse_0(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));


  // pos /= 0.05;
  // pos *= rotate_w_offset(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);

  pos *= 100.0 * w_time;
  pos /= rotate_w_offset(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 630a19, 00:02
void choppy_doppler_square_fractal(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));


  pos /= 0.05;
  pos *= rotate_w_offset(pos, fract(fract(pos.y) * fract(pos.x)), 1.0);



  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time * audio.bandpass * 7.0, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 630a19, 00:02
void choppy_doppler_square(vec2 pos, float time, peakamp audio, out vec3 color) {
  // float w_time = sin(time);
  float w_time = sin(time) * 0.1;
  // float w_time = log(sin(time));


  pos /= 0.05;
  // RRTI: (Transition Idea):
  // pos /= rotate_w_offset(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate_w_offset(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate_w_offset(pos, fract(pos.x), 1.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 97b16a, 23:59 another amazing transistion
void plaid_choppy_glossy(vec2 pos, float time, peakamp audio, out vec3 color) {
  // float w_time = sin(time);
  float w_time = fract(tan(time));

  pos /= 0.1;
	pos /= rotate_w_offset(pos, 0.0, 4.0);
  pos /= rotate_w_offset(pos, fract(pos.y) * audio.bandpass * 10.0, 4.0);

  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 97b16a, 23:59 another amazing transistion
void plaid_choppy_glossy_0(vec2 pos, float time, peakamp audio, out vec3 color) {
  // float w_time = sin(time);
  float w_time = fract(tan(time));

  pos /= 0.1;
	pos /= rotate_w_offset(pos, 0.0, 4.0);
  pos /= rotate_w_offset(pos, fract(pos.y) * audio.bandpass * 10.0, 4.0);

  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, 0.5);
  // color = vec3(0.81176470588, 0.38823529411, audio.bandpass * 2.0);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 97b16a, 23:59 another amazing transistion
void choppy_glossy(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = abs(sin(time));
  // float w_time = log(sin(time));


  pos /= 0.1;
  // RRTI: (Transition Idea):
  // pos /= rotate_w_offset(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate_w_offset(pos, fract(pos.y), 4.0);   // then on beat:
  pos /= rotate_w_offset(pos, fract(pos.y), 4.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, audio.notch, (abs(tan(time))));
  vec3 color_0 = vec3(0.8, 0.8234, audio.notch);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  // color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);

}

// 97b16a, 23:59 another amazing transistion
void choppy_glossy_0(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = abs(sin(time));
  // float w_time = log(sin(time));


  pos /= 0.1;
  // RRTI: (Transition Idea):
  pos /= rotate_w_offset(pos, 0.0, 4.0); // then on the beat:
  // pos /= rotate_w_offset(pos, fract(pos.y), 4.0);   // then on beat:
  pos /= rotate_w_offset(pos, fract(pos.y), 4.0);


  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, audio.notch, (abs(tan(time))));
  vec3 color_0 = vec3(0.8, 0.8234, audio.notch);

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  // color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);

}

// e442e6, 23:57 amazing transition
void flossy_glossy(vec2 pos, float time, peakamp audio, out vec3 color) {
  float w_time = sin(time);
  // float w_time = log(sin(time));

  pos /= 0.1;
  // RRTI: (Transition Idea):
  // pos /= rotate_w_offset(pos, 0.0, 4.0); then on the beat:
  pos /= rotate_w_offset(pos, pos.y, 4.0);


  // color = vec3(1.0, 0.1234, (tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  color = vec3(clamp(color.x, 0.0, 0.5), color.y, color.z);
}

// 29480f, 23:44 uhh ok this is the coolest thing ive ever seen
void doppler_cross_plaid_glitch(vec2 pos, float time, peakamp audio, out vec3 color) {
  // pos /= 0.1;
  pos /= rotate_w_offset(pos, 0.0, 4.0);
  pos += 10.0;

  float w_time = sin(time * audio.lowpass * 10.0);
  color = vec3(1.0, 0.3234, 0.4);
  // color = vec3(1.0, 0.1234, abs(tan(time)));
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * abs(w_time) * 0.1, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));
}

// 29480f, 23:44 uhh ok this is the coolest thing ive ever seen
void doppler_cross_plaid_glitch_0(vec2 pos, float time, peakamp audio, out vec3 color) {
  // pos /= 0.1;
  pos /= rotate_w_offset(pos, 0.0, 4.0);
  pos += 10.0;

  float w_time = sin(time * audio.lowpass * 10.0);
  color = vec3(1.0, 0.3234, audio.lowpass);
  // color = vec3(1.0, 0.1234, abs(tan(time)));
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * abs(w_time) * 0.1, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));
}

// 29480f, 23:44 uhh ok this is the coolest thing ive ever seen
void doppler_cross_plaid(vec2 pos, float time, peakamp audio, out vec3 color) {
  pos /= 0.1;
  pos /= rotate_w_offset(pos, 0.0, 4.0);

  float w_time = abs(sin(time));
  // float w_time = log(sin(time));
  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.5234, audio.lowpass);
  // color = vec3(1.0, 0.1234, abs(tan(time)));
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

}

// 117be2, 23:43 i invented a plaid
void doppler_plaid(vec2 pos, float time, peakamp audio, out vec3 color) {
  pos /= rotate_w_offset(pos, 0.0, 0.0);

  float w_time = abs(sin(time));
  color = vec3(1.0, 0.0, audio.notch);
  // vec3 color_0 = vec3(audio.bandpass, 1.0, audio.notch);
  vec3 color_0 = vec3(1.0, audio.bandpass, audio.notch);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * audio.bandpass, audio.bandpass * 10.0);
	color = vec3(pct * color_0 + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));

}

// 52f7fa, 23:40 oh shit we rotatin
void doppler_spaceship(vec2 pos, float time, peakamp audio, out vec3 color) {
  int idx_w_time = 0;

  float w_time = sin(time);

  if (idx_w_time == 0) {
    w_time = sin(time);
  } else if (idx_w_time == 1) {
    w_time = log(sin(time));
  }
  pos *= 21.5;
  pos *= rotate_w_offset(pos, sin(time), 4.0);

  color = vec3(1.0, 0.1234, abs(tan(time)));
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * w_time, audio.bandpass);
  // color = vec3(pct * color + color * pct2);    // with step
  color = vec3(pct2 * color + color * vec3(0.5)); // without step

}

// 52f7fa, 23:40 oh shit we rotatin
void doppler_diamond_collide(vec2 pos, float time, peakamp audio, out vec3 color) {

  // pos *= 5.5;
  pos *= rotate_w_offset(pos, 0.5, 0.0);

  float w_time = sin(time);
  // float w_time = log(sin(time));
  // color = vec3(1.0, 0.1234, abs(tan(time)));
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
void doppler_step_pink_blue(vec2 pos, float time, peakamp audio, out vec3 color) {
  pos *= 5.5;

	float w_time = sin(time);
	// float w_time = log(sin(time));
  color = vec3(1.0, 0.1234, abs(tan(time)));
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);
  // color = vec3(pct2 * color + color * vec3(0.5));
}

// y=x line, dark fuzzy circle moving back and forth, turns blue at furthest dist
// fc2eb2, 23:33 tan to blue 
void doppler_step_pink_blue_0(vec2 pos, float time, peakamp audio, out vec3 color) {
  pos *= 5.5;

	float w_time = sin(time);
	// float w_time = log(sin(time));
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
void doppler_step_pink_yellow(vec2 pos, float time, peakamp audio, out vec3 color) {
  pos *= 5.5;

  float w_time = cos(time);
  // float w_time = log(sin(time));
  color = vec3(1.0, 0.1234, audio.notch);
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_0(pos * w_time, audio.bandpass) / audio.notch;
  float pct2 = circle_0(pos * w_time, audio.bandpass);
	color = vec3(pct * color + color * pct2);
	// color = vec3(pct2 * color + color * vec3(0.5));

}

// 25eb7a, main.frag
// shakey, shaky 
void doppler_shaky_shaky(vec2 pos, float time, peakamp audio, out vec3 color) {
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
void doppler_shaky_shaky_3(vec2 pos, float time, peakamp audio, out vec3 color) {
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
void doppler_shaky_shaky_2(vec2 pos, float time, peakamp audio, out vec3 color) {
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
void doppler_shaky_shaky_1(vec2 pos, float time, peakamp audio, out vec3 color) {
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
void doppler_shaky_shaky_0b(vec2 pos, float time, peakamp audio, out vec3 color) {
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
void doppler_shaky_shaky_0(vec2 pos, float time, peakamp audio, out vec3 color) {
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
void doppler_shaky_blue(vec2 pos, float time, peakamp audio, out vec3 color) {
  pos.y += 0.45;
  pos.x += 0.35;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y * sin(audio.bandpass));
  float pct2 = circle_sdf(pos) - 1.0;
  color = vec3(pct * color + color * pct2);
	color.r = color.r * audio.lowpass;
}

// 89e139c, main.frag
void doppler_blue_fights_pink(vec2 pos, float time, peakamp audio, out vec3 color) {

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.notch * 10.0;
  // color = vec3(pct2 * color + color * vec3(0.5));
}

void doppler(vec2 pos, float time, out vec3 color) {

  int shader_idx = 0;
  int color_idx = 2;

  float w_time = sin(time);
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
void doppler_audio(vec2 pos, float time, peakamp audio, out vec3 color) {
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
