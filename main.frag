#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// My OSC implementation 
uniform float full_min;
uniform float full_max;
uniform float full_ave;
uniform float song_id;


// OSC from Max
uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

void main() {
  vec3 color = vec3(0.2);

  gl_FragColor = vec4(color, 1.0);
}
