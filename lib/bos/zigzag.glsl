#ifndef BOS_ZIGZAG
#define BOS_ZIGZAG
vec2 mirrorTile(vec2 _pos, float _zoom){
    _pos *= _zoom;
    if (fract(_pos.y * 0.5) > 0.5){
        _pos.x = _pos.x+0.5;
        _pos.y = 1.0-_pos.y;
    }
    return fract(_pos);
}

float fillY(vec2 _pos, float _pct,float _antia){
  return  smoothstep( _pct-_antia, _pct, _pos.y);
}

void zigzag(vec2 pos, float u_time, peakamp audio, inout vec3 color){
  // color = vec3(0.0);

  pos = mirrorTile(pos*vec2(1.,2.),5.);
  float x = pos.x*2.;
  float a = floor(1.+sin(x*3.14));
  float b = floor(1.+sin((x+1.)*3.14));
  float f = fract(x);

  color = vec3( fillY(pos,mix(a,b,f),0.01) );

}
#endif
