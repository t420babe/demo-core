#ifndef T4B_AB_00
#define T4B_AB_00

#ifndef PXL_HEXAGON
#include "./lib/pxl/hex-sdf.glsl"
#endif

#ifndef BOS_CLOUDS_HA
#include "./lib/bos/clouds-ha.glsl"
#endif

vec2 ab_00_brick_tile(vec2 _st, float _zoom){
    _st *= _zoom;

    // Here is where the offset is happening
    _st.x += step(1., mod(_st.y,2.0)) * 0.5;

    return fract(_st);
}

float ab_00_box(vec2 _st, vec2 _size){
    _size = vec2(0.5)-_size*0.5;
    vec2 uv = smoothstep(_size,_size+vec2(1e-4),_st);
    uv *= smoothstep(_size,_size+vec2(1e-4),vec2(1.0)-_st);
    return uv.x*uv.y;
}

void ab_00(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  clouds_ha(pos, time, audio, color);

  vec2 tmp_pos = pos;
  tmp_pos = ab_00_brick_tile(tmp_pos, 10.0);
  // float brick = ab_00_box(tmp_pos, vec2(abs(tan(time) * 10.0), 0.5));
  float brick = ab_00_box(tmp_pos, vec2(2.00, 0.5));

  color /= brick;

  color *= hexagon_web(pos);
  vec2 tmp_pos_1 = pos;
  tmp_pos_1.x *= 0.2;
  color *= hexagon_web(tmp_pos_1);
  color.b *= abs(sin(time));
  color.r *= audio.bandpass;
  // color = 1.0 - color;
  gl_FragColor = vec4(color, 1.0);
}

#endif
