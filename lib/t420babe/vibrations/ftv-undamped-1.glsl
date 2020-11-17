#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float undamped(vec2 pos, float u_time) {
  /* Shaft Properties */
  float E1 = 0.7 * pow(10.0, 8.0);
  float E2 = E1 * 2.0;
  vec2 E = vec2(E1, E2);
  // Poisson's ratio
  float v = 0.33;
  // Density of disk [kg/mm^3]
  float rho = 2.7 * pow(10.0, -6.0);
  // Length [mm]
  float L = 900.0;
  // Diameter [mm]
  float disk_diameter = 30.0;
  // Height [mm]
  float h = 5.0;


  /* Initial Conditions */
  float theta = 0.2 * PI;
  // Theta velocity [rad/s]
  float theta_dot = 0.1;

  /* Free vibration response for the undamped case */
  // Number of cycles to analyze
  float n_cycle = 10.0;
  // Polar moment of inertia of the shaft
  float Js = PI / 32.0 * pow(disk_diameter, 4.0);
  // Shear modulus relation to Youngs modulus
  float G = E.x / ( 2.0 * (v + 1.0) );
  // Torsional spring constant
  float kt = G * Js / L;

  // // // Vary disk radius d by 100%, 150%, 300%, and 350%
  // vec4 disk_radius = vec4(d, d * 1.5, d * 3.0, d * 3.5);

  float delta = pow(10.0, -4.0);

  // Mass moment of inertia of disk
  float Id = PI / 2.0 * h * rho * pow(disk_diameter, 4.0);
  // Angular velocity, ω
  float wn = sqrt(kt / Id);
  // Period
  float T = 2.0 * PI / wn;
  // Coefficients
  float C1 = theta;
  float C2 = theta_dot / wn;
  // Amplitude
  float A = sqrt(C1 * C1 + C2 * C2);
  float phi = atan(C1 / C2);

  // Time
  float time = pos.x * wrap_time(abs((u_time)) * 1.0, 5.0);
  // Theta position
  return C1 * cos(wn * time) + C2 * sin(wn * time);
}

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  float zoom = 0.001;
  pos.x += 1.0;
  pos.x *= zoom;
  // pos.x *= 500.0;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  // vec3 color = vec3(abs(audio.bandpass * 1.0), abs(audio.notch * 1.0), abs(audio.highpass) * 1.5);
  vec3 color = vec3(0.29345, 0.235, abs(audio.highpass) * 0.5);
  // vec3 color = vec3(0.29345, 0.235, 1.0);


  float theta_undamped = undamped(pos, u_time);
  float pct = plot(pos, theta_undamped);
  // color = (1.0 - pct) * color + pct * vec3(0.0, 1.0, 0.0);
  vec3 free_color = color;
  // free_color = (1.0 - pct) * free_color + pct * vec3(0.0, 1.0, 0.0);
  free_color = pct * free_color + pct * vec3(0.0, 1.0, audio.notch);
  color.b *= free_color.g;
  color.g += free_color.b;
  color.r -= free_color.r;
  gl_FragColor = vec4(color,1.0);
}

