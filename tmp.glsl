float circle(vec2 st,float r) {
  return length(st)*r;
}
float place(vec2 p,float r,vec2 off) {
  p+=off;
  return circle(p,r);
}
void from_255(inout vec3 rgb) { rgb /=255.0; }

mat2 rot(float a) {
  return mat2(cos(a),-sin(a),sin(a),cos(a));
}
vec3 alternate(in vec2 pos,vec3 color,peakamp audio) {
  pos=abs(sin(pos*0.8)*(wrap_time(u_time,4.0)+2.0));
  pos=rot(sin(u_time) *3.14)*pos;
  vec3 fill=vec3(1.0);
  if (abs(ntch) > 0.20) {
    fill=vec3(0.0,174.0,217.0);
    from_255(fill);
    fill=1.0-fill;
  }
  from_255(fill);
  float r=0.5*abs(ntch*lp+abs(ntch)+abs(bp));
  float mul1=abs(sin(u_time));
  float c00=place(pos,r,vec2(1.0, -0.75));
  float c01=place(pos,r,vec2(0.0, -0.75));
  float c02=place(pos,r,vec2(-1.0,-0.75));
  float c03=place(pos,r,vec2(-1.5,-0.75));
  float c04=place(pos,r,vec2(1.5,-0.75));
  float c10=place(sin(pos),r*mul1,vec2(1.0, 0.0));
  float c11=place(sin(pos),r*mul1,vec2(0.0, 0.0));
  float c12=place(sin(pos),r*mul1,vec2(-1.0,0.0));
  float c13=place(sin(pos),r*mul1,vec2(-1.5,0.0));
  float c14=place(sin(pos),r*mul1,vec2(1.5,0.0));
  float c20=place(pos,r,vec2(1.0, 0.75));
  float c21=place(pos,r,vec2(0.0, 0.75));
  float c22=place(pos,r,vec2(-1.0,0.75));
  float c23=place(pos,r,vec2(-1.5,0.75));
  float c24=place(pos,r,vec2(1.5,0.75));
  color*=vec3(c01*c03*c04);
  color*=vec3(1.0 / c13*abs(sin(u_time)));
  color*=vec3(c21*c23*c24);
  color/=fill;
  return color;
}
vec3 take_my_hand(vec2 pos,float u_time,peakamp audio) {
  vec3 color=vec3(1.0);
  float mul=0.5;
  lp*=mul;
  hp*=mul;
  bp*=mul;
  ntch*=mul;
  color=alternate(pos,color,audio);
  color=1.0-color;
  color=color.gbr;
  if(abs(ntch)>0.2){
    color=color.bgr;
  }
  color=color.bgr;
  return color;
}
