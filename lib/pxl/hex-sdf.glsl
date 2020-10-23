#ifndef PXL_HEXAGON
#define PXL_HEXAGON

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

float hexagon_web(vec2 st) {
  st = abs(st*2.);
  return max(abs(st.x), st.x * 1.866025 + fract(st.x) * 0.5);
}
float hexagon_sdf(vec2 st, float size, float full_max) {
  st = abs(st * 1.0);
  st /= size;
  float hexagon = 1.0;
  if (full_max > 200.0) {
    hexagon =  max(abs(st.y), st.x * 0.866025 + st.y * 0.0);
  }  else if (full_max > 100.0 ){
    hexagon =  max(abs(st.y), st.x * 0.866025 + st.y * 0.5);
  } else {
    hexagon =  max(abs(st.y), st.x * 0.866025 + st.y * 0.0);
  }

  return hexagon;
}

float hexagon_wood(vec2 pos, float size) {
  pos = abs( pos * 1.0);
  pos /= size;
  return max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.5);
}

float hexagon_sdf(vec2 st) {
  st = abs(st*2.-1.);
  return max(abs(st.y), st.x * 0.866025 + st.y * 0.5);
}

// wood_brother_louie
float wbl1_hexagon(vec2 pos, float size, peakamp audio) {
  pos = abs(pos * 1.0);
  pos /= size;
  float hexagon = 1.0;
  // if (audio.notch * 100.0 > 100.0) {
  // if (audio.bandpass > 0.9) {
  // if (audio.bandpass > 0.5) {
  // if (audio.notch > 0.5) {
  if (audio.notch > 0.4) {
  // if (full_max > 100.0) {
    hexagon =  max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.5);
  }  else {
    hexagon =  max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.0);
  }
  return hexagon;
}

// wood_brother_louie
float wbl_hexagon(vec2 pos, float size, peakamp audio) {
  pos = abs(pos * 1.0);
  pos /= size;
  float hexagon = 1.0;
  // if (audio.notch * 100.0 > 100.0) {
  // if (audio.bandpass > 0.9) {
  // if (audio.bandpass > 0.5) {
  // if (audio.notch > 0.5) {
  if (audio.notch > 0.4) {
  // if (full_max > 100.0) {
    hexagon =  max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.5);
  }  else {
    hexagon =  max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.0);
  }
  return hexagon;
}

#endif
