#ifdef GL_ES
precision mediump float;
#endif

#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif

#ifndef COMMON_COMMON
#include "./common/00-common.glsl"
#endif

#ifndef PXL
#include "./pxl/00-pxl.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec3 u_camera;
uniform vec3 u_light;
varying vec4 v_position;

#ifndef UNIFORMS
#define UNIFORMS
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
#endif


#ifdef MODEL_VERTEX_COLOR
varying vec4 v_color;
#endif

#ifdef MODEL_VERTEX_NORMAL
varying vec3 v_normal;
#endif


vec3 tonemap(const vec3 x) {
  return x / ( x + vec3(1.0) );
  // return x / (x + 0.155) * 1.019;
}

uniform samplerCube u_cubeMap;
const float num_mips = 1.0;

vec3 env_map(vec3 normal, float roughness) {
  vec4 color = mix( textureCube( u_cubeMap, normal, (roughness * num_mips) ),
      textureCube( u_cubeMap, normal, min( (roughness * num_mips) + 1.0, num_mips)),
      fract(roughness * num_mips) );

  return tonemap(color.rgb);
}

vec3 plastic() {
  vec3 color = vec3(1.0);
  vec3 n = normalize(v_normal);
  vec3 l = normalize(u_light);
  vec3 v = normalize(u_camera - v_position.xyz);

  float diffuse = (dot(n, l) + 3.0) * (audio.bandpass + 0.1);
  color *= diffuse;

  if (audio.notch > 1.0) {
    color.b = 0.0;
  } else {
    color.r = 0.0;
  }

  vec3 r = reflect(-v, n);
  vec3 specular = env_map(r, step(-1.0, v_position.x));
  color *= specular;
  return color;

}


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  color = plastic();

  gl_FragColor = vec4(color, audio.notch + 0.2);
}
