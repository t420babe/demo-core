#ifndef PXL_STAR
#define PXL_STAR

#ifndef PXL_MATH
#include "./lib/pxl/math-sdf.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

// 671e2bc, 20:25 red yellow black weird shape 
float star_sliding(vec2 st, int V, float s) {
    st = st * 1.00;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    a = (((floor(seg) + 0.5)/float(V) + mix(s, -s, step( 0.1, (seg)))) * TAU);
    return ((dot(vec2((s*a), (s*a)), st)));
}

// 671e2bc, 20:25 red yellow black weird shape 
float star_line_retro_0(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    a = ((((seg) + 0.5)/float(V) + mix(s, -s, step( 0.1, (seg)))) * TAU);
    return abs((dot(vec2((s*a), (s*a)), st)));
}

// 671e2bc, 20:25 red yellow black weird shape 
float star_line_zoom(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    a = (((floor(seg) + 0.5)/float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    // a = DEMO_EASE(((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, fract(seg)))) * TWO_PI);
    return abs((dot(vec2((s*a), (s*a)), st)));
}

// 57b7aae, 20:11 red and yellow
float star_kal_2(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    a = (((floor(seg) + 0.5)/float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    // a = DEMO_EASE(((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, fract(seg)))) * TWO_PI);
    return abs((dot(vec2((s*a), log(s*a)), st)));
}

// 57b7aae, 20:11 red and yellow
float star_kal(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    a = (((floor(seg) + 0.5)/float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    // a = DEMO_EASE(((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, fract(seg)))) * TWO_PI);
    return abs((dot(vec2(log(s*a), sin(s*a)), st)));
}

// 651292d, 20:08
float star_schnoodle(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    // a = (((floor(seg) + 0.5)/float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    a = DEMO_EASE(((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, fract(seg)))) * TWO_PI);
    return abs((dot(vec2(log(s*a), sin(s*a)), st)));
}

float star(vec2 st, int V, float s) {
    st = st * 1.00;
    float a = sharp(atan(st.x, st.y) / TWO_PI);
    float seg = a * float(V);
    // a = (((floor(seg) + 0.5)/float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    a = (((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    return ((dot(vec2((s*a), (s*a)), st.yx)));
}

// cc7109f, 20:05 blue thing
float sayin_sayin_star_5(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.y, st.x) / TWO_PI;
    float seg = a * float(V);
    a = sharp(((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, fract(seg)))) * TWO_PI);
    return abs(dot(vec2(tan(s*a), sin(s*a)), st));
}

// cc7109f, 20:05 blue thing
float sayin_sayin_star_4(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.y, st.y) / TWO_PI;
    float seg = a * float(V);
    a = (((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, fract(seg)))) * TWO_PI);
    return abs(dot(vec2(tan(s*a), sin(s*a)), st));
}

// cc7109f, 20:05 blue thing
float sayin_sayin_star_3(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    a = (((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, fract(seg)))) * TWO_PI);
    return abs(dot(vec2(tan(s*a), sin(s*a)), st));
}

// cc7109f, 20:05 blue thing
float sayin_sayin_star_2(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    a = (((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    return abs(dot(vec2(tan(s*a), sin(s*a)), st));
}

// cc7109f, 20:05 blue thing
float sayin_sayin_star_1(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    a = (((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    return abs(dot(vec2(tan(s*a), (s*a)), st.yx));
}

// fe0bdc7, 19:59 yellow and red freaky star
float sayin_sayin_star_0(vec2 st, int V, float s) {
    st = st * 1.00 - 0.5;
    float a = atan(st.x, st.y) / TWO_PI;
    float seg = a * float(V);
    a = (((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
    return abs(dot(vec2(tan(s*a), sin(s*a)), st.yx));
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

