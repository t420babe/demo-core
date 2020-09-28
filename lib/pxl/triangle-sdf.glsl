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

#ifndef PXL_TRIANGLE
#define PXL_TRIANGLE
float triangle_0(vec2 st) {
    st = (st*2.-1.) * 1.5;
    return max(abs(st.x) * 0.866025 + st.y * 0.5, -st.x * 0.5);
}

float triangle_web_1(vec2 st, peakamp audio, float u_time) {
    st = (st*2.-1.)*0.3;
    float tri_w = max(abs(st.x) * 0.866025 + st.y * 0.5, -st.y * 0.5);
    return (tri_w);
}

float triangle_web_0(vec2 st, peakamp audio, float u_time) {
    st = (st*2.-1.)*1. * (tan(u_time));
    float tri_w = max(abs(st.x) * 0.866025 + st.x * 0.5, -st.y * 0.5);
    return fract(tri_w);
}

float triangle_sdf(vec2 st) {
    st = (st*2.-1.)*2.;
    return max(abs(st.x) * 0.866025 + st.y * 0.5, -st.y * 0.5);
}
#endif
