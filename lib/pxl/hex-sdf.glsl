/*
   Copyright (c) 2017 Patricio Gonzalez Vivo ( http://www.pixelspiritdeck.com )
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
met:

Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef PXL_HEXAGON
#define PXL_HEXAGON
float hexagon_web(vec2 st) {
  st = abs(st*2.-1.);
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
