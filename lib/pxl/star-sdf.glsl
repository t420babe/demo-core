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

#ifndef PXL_STAR
#define PXL_STAR
#ifndef PXL_MATH
#include "./lib/pxl/math-sdf.glsl"
#endif
#ifndef COMMON
#include "./lib/common/common.glsl"
#endif

float star(vec2 st, int V, float s) {
    st = st * 1.00;
    float a = sharp(atan(st.x, st.y) / TWO_PI);
    float seg = a * float(V);
    // a = (((floor(seg) + 0.5)/float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    a = (((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    return ((dot(vec2((s*a), (s*a)), st.yx)));
}

float star_sdf(vec2 st, int V, float s) {
    st = st*4.-2.;
    float a = atan(st.y, st.x)/TWO_PI;
    float seg = a * float(V);
    a = ((floor(seg) + 0.5)/float(V) + 
        mix(s,-s,step(.5,fract(seg)))) 
        * TWO_PI;
    return abs(dot(vec2(cos(a),sin(a)),
                   st));
}
#endif
