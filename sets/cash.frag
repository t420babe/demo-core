#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef BOS_CLOUDS_HA
#include "./lib/bos/clouds-ha.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 brickTile(vec2 _st, float _zoom){
    _st *= _zoom;

    // Here is where the offset is happening
    _st.x += step(1., mod(_st.y,2.0)) * 0.5;

    return fract(_st);
}

float box(vec2 _st, vec2 _size){
    _size = vec2(0.5)-_size*0.5;
    vec2 uv = smoothstep(_size,_size+vec2(1e-4),_st);
    uv *= smoothstep(_size,_size+vec2(1e-4),vec2(1.0)-_st);
    return uv.x*uv.y;
}


float hexagon_web_4(vec2 st) {
  st = abs(st*2.);
  return max(abs(st.x), st.x * 1.866025 + fract(st.x) * 0.5);
}

void cash(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  clouds_ha(pos, u_time, audio, color);

  vec2 tmp_pos = pos;
  tmp_pos = brickTile(tmp_pos, 10.0);
  // float brick = box(tmp_pos, vec2(abs(tan(u_time) * 10.0), 0.5));
  float brick = box(tmp_pos, vec2(2.00, 0.5));

  color /= brick;

  color *= hexagon_web_4(pos);
  vec2 tmp_pos_1 = pos;
  tmp_pos_1.x *= 0.2;
  color *= hexagon_web_4(tmp_pos_1);
  color.b *= abs(sin(u_time));
  color.r *= audio.bandpass;
  // color = 1.0 - color;
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  cash(pos, u_time, audio, color);
  
  gl_FragColor = vec4(color, 1.0);
}


