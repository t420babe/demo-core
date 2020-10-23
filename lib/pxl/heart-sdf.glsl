#ifndef PXL_HEART
#define PXL_HEART
float heart_web(vec2 st, peakamp audio, float u_time) {
    // st -= vec2(.5,.8);
    float r = fract(length(st)*1.) * tan(u_time);
    st = normalize(st);
    return r - 
         ((st.y*pow((st.x),0.67))/ 
         (st.y+1.5)-(2.)*st.y+1.26);
}
float heart_sdf(vec2 st) {
   st -= vec2(-0.00, 0.33);
    float r = length(st)*5.;
    st = normalize(st);
    return r - 
         ((st.y*pow(abs(st.x),0.67))/ 
         (st.y+1.5)-(2.)*st.y+1.26);
}
#endif
