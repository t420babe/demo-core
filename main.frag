#ifdef GL_ES
precision mediump float;
#endif

#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  // doppler(pos, u_time, color);
	// doppler_step_pink_blue(pos, u_time, audio, color);
	// doppler_spaceship(pos, u_time, audio, color);
	// doppler_diamond_collide(pos, u_time, audio, color);
	// doppler_plaid(pos, u_time, audio, color);
	// doppler_cross_plaid(pos, u_time, audio, color);
	// doppler_cross_plaid_glitch(pos, u_time, audio, color);
	// flossy_glossy(pos, u_time, audio, color);
  // choppy_glossy(pos, u_time, audio, color);
  // plaid_choppy_glossy(pos, u_time, audio, color);
  // choppy_doppler_square_fractal(pos, u_time, audio, color);
  // choppy_doppler_square_fractal_zoom_out(pos, u_time, audio, color);
  // square_doppler_pulse(pos, u_time, audio, color);
  // sea_urchin_doppler(pos, u_time, audio, color);
  // vagina_sea_urchin_doppler(pos, u_time, audio, color);
  // sea_urchin_mouth_doppler(pos, u_time, audio, color);
  // butterfly_doppler(pos, u_time, audio, color);
  // cacoon_doppler(pos, u_time, audio, color);
  // curly_butterfly_doppler(pos, u_time, audio, color);
  // cube_guppy_doppler(pos, u_time, audio, color);
	// doppler_morph(pos, u_time, audio, color);
	// doppler_trippy_diamond(pos, u_time, audio, color);
	// doppler_trippy_melting_diamond(pos, u_time, audio, color);
	// doppler_twisting_timer(pos, u_time, audio, color);
	// doppler_melting_square_glitch(pos, u_time, audio, color);
	// doppler_pink_blue_sand(pos, u_time, audio, color);
  // doppler_blue_fights_pink(pos, u_time, audio, color);
  // doppler_shaky_blue(pos, u_time, audio, color);
  // doppler_shaky_shaky(pos, u_time, audio, color);
  // doppler_cross_step(pos, u_time, audio, color);
  // doppler_blue_step_cross(pos, u_time, audio, color);
  // doppler_blue_step_cross_horizontal(pos, u_time, audio, color);
  // doppler_blue_cross(pos, u_time, audio, color);
  // doppler_blue_cross_spinning(pos, u_time, audio, color);
	// doppler_sun_star_rooster(pos, u_time, audio, color);
  // doppler_green_rooster(pos, u_time, audio, color);
  // doppler_sofias_rainbow(pos, u_time, audio, color);
  // doppler_rainbow_heart(pos, u_time, audio, color);
  // doppler_sharp_heart(pos, u_time, audio, color);
  doppler_blue_web(pos, u_time, audio, color);
  // purple_concentric(pos, u_time, audio, color);
  // green_concentric(pos, u_time, audio, color);



  gl_FragColor = vec4(color, 1.0);
}

// autocmd BufWritePost * execute '!git add % && git commit -m %'

