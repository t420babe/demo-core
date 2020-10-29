#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

uniform sampler2D u_tex0;
uniform sampler2D u_tex1;

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef T420BABE_SHARP_HEART
#include "./lib/t420babe/doppler-heart.glsl"
#endif

#ifndef T420BABE_CASH
#ifndef PXL_HEXAGON
#include "./lib/pxl/hex-sdf.glsl"
#endif

#ifndef BOS_CLOUDS_HA
#include "./lib/bos/clouds-ha.glsl"
#endif

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

void cash(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  clouds_ha(pos, u_time, audio, color);

  vec2 tmp_pos = pos;
  tmp_pos = brickTile(tmp_pos, 30.0);
  // float brick = box(tmp_pos, vec2(abs(tan(u_time) * 10.0), 0.5));
  float brick = box(tmp_pos, vec2(2.00, 0.5));

  color /= brick;

  color *= hexagon_web(pos);
  vec2 tmp_pos_1 = pos;
  tmp_pos_1.x *= 0.2;
  color *= hexagon_web(tmp_pos_1);
  color.b *= abs(sin(u_time));
  color.r *= audio.bandpass;
  // color = 1.0 - color;
}

#endif

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
	peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  pos *= 3.5;
	vec3 color = vec3(1.0);
	vec3 turb_color = vec3(1.0);
  cash(pos, u_time, audio, turb_color);
  // color *= lns;
	say_nothing_next_1(pos, u_time, audio, color);

  color /= log(color);
  color += fract(turb_color);
  gl_FragColor = vec4( color , 1.0);
}
