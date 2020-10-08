#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec4 u_color;

uniform samplerCube u_cubeMap;

varying vec4 v_position;
varying vec4 v_color;
varying vec3 v_normal;
varying vec2 v_texcoord;

varying vec3 v_reflect;
varying vec3 v_refract;
varying vec3 v_refract_r;
varying vec3 v_refract_b;
varying vec3 v_refract_g;
varying float v_ratio;

float stroke(float x, float size, float w) {
    float d = step(size, x+w*.5) - step(size, x-w*.5);
    return clamp(d, 0., 1.);
}

float circleSDF(vec2 st) {
    return length(st-.5)*2.;
}

void main (void) {
    vec2 st = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
    float aspect = u_resolution.x/u_resolution.y;
    // st.x *= aspect;

    vec2 pixel = 2./u_resolution;

    vec3 color = vec3(0.0);
    // color += u_color.rgb;
    color.g +=  stroke(st.x + 0.5,u_bandpass,pixel.x) + 
                stroke(st.y + 0.5,u_lowpass,pixel.y);

    color.b += u_bandpass;

  vec3 refract_color, reflect_color;
  refract_color.r = vec3(textureCube(u_cubeMap, v_refract_r)).r;
  color.r += refract_color.r;
  color.b += refract_color.b / u_lowpass;
  color.g += refract_color.g;
  // refract_color.g = vec3(textureCube(u_cubeMap, v_refract_g)).g;
  // refract_color.b = vec3(textureCube(u_cubeMap, v_refract_b)).b * u_lowpass * 1.0;
  //
  // reflect_color = vec3(textureCube(u_cubeMap, v_reflect));
  //
  // color = mix(refract_color, reflect_color, v_ratio);
    // if (u_lowpass < 0.5) {
    // color.r += step(circleSDF(st-vec2(u_bandpass,u_lowpass)+.5),.025);
    // }
    
    gl_FragColor = vec4(color,1.0);
}
