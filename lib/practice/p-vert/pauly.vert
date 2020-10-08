#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;

uniform mat4 u_modelViewProjectionMatrix;
uniform vec3 u_camera;

attribute vec4 a_position;
varying vec4 v_position;

#ifdef MODEL_VERTEX_COLOR
attribute vec4 a_color;
varying vec4 v_color;
#endif 

#ifdef MODEL_VERTEX_NORMAL
attribute vec3 a_normal;
varying vec3 v_normal;
#endif

#ifdef MODEL_VERTEX_TEXCOORD
attribute vec3 a_texcoord;
varying vec2 v_texcoord;
#endif

const float eta_r = 0.64;
const float eta_g = 0.65;
const float eta_b = 0.66;
const float fresnel_power = 6.0;


const float f = ( (1.0 - eta_g) * (1.0 - eta_g) ) / ( (1.0 + eta_g) * (1.0 + eta_g) );

varying vec3 v_reflect;
varying vec3 v_refract_r;
varying vec3 v_refract_g;
varying vec3 v_refract_b;
varying float v_ratio;

void main(void) {
  v_position = a_position;

#ifdef MODEL_VERTEX_COLOR
  v_color = a_color;
#endif

#ifdef MODEL_VERTEX_NORMAL
  v_normal = a_normal;
#endif

#ifdef MODEL_VERTEX_TEXCOORD
  v_texcoord = a_texcoord;
#endif

  gl_Position = u_modelViewProjectionMatrix * v_position;

  vec3 i = normalize(v_position.xyz - u_camera);

  v_ratio = f + (1.0 - f) * pow((1.0 - dot(-i, v_normal)), fresnel_power);

  v_refract_r = refract(i, v_normal, eta_r);
  v_refract_g = refract(i, v_normal, eta_g);
  v_refract_b = refract(i, v_normal, eta_b);

  v_reflect = reflect(i, v_normal);

}
