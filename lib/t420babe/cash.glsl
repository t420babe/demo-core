#ifndef T420BABE_CASH
#define T420BABE_CASH

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
  tmp_pos = brickTile(tmp_pos, 10.0);
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
