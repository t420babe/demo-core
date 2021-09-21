#ifndef COMMON_TILE
#define COMMON_TILE
// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015
vec2 tile(vec2 _st, float _zoom){
  _st *= _zoom;
  return fract(_st);
}
#endif
