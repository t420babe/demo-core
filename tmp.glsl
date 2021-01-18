float circ(vec2 st,float r){return length(st)*r;}
float place(vec2 p,float r,vec2 off){
  p +=off;
  return circ(p,r);
}
void from_255(inout vec3 rgb){rgb/=255.0;}
vec3 alt(in vec2 pos,vec3 color,pa a){
  pos=pos.yx*pos.yx*0.5;
  pos=abs(sin(pos*0.8)*(wrap_time(u_time,4.0) + 2.0));
  vec3 fill=vec3(1.0);
  fill=vec3(33.0,55.0,164.0);
  if (abs(a.n)>0.50){
    fill=vec3(0.0,174.0,217.0);
    from_255(fill);
    fill=1.0-fill;
  }
  from_255(fill);
  float r=1.0*abs(a.hp*a.lp + abs(a.n));
  float mul=abs(sin(u_time));
  float c00=place(pos,r,vec2(1.,-0.75));
  float c01=place(pos,r,vec2(0.,-0.75));
  float c02=place(pos,r,vec2(-1.,-0.75));
  float c03=place(pos,r,vec2(-1.5,-0.75));
  float c04=place(pos,r,vec2(1.5,-0.75));
  float c10=place(pos,r*mul,vec2(1.,0.));
  float c11=place(pos,r*mul,vec2(0.,0.));
  float c12=place(pos,r*mul,vec2(-1.,0.));
  float c13=place(pos,r*mul,vec2(-1.5,0.));
  float c14=place(pos,r*mul,vec2(1.5,0.));
  float c20=place(pos,r,vec2(1.,0.75));
  float c21=place(pos,r,vec2(0.,0.75));
  float c22=place(pos,r,vec2(-1.,0.75));
  float c23=place(pos,r,vec2(-1.5,0.75));
  float c24=place(pos,r,vec2(1.5,0.75));
  color*=vec3(fract(c01*c03*c04));
  color*=vec3(fract(c11)*c13*fract(c14));
  color*=vec3(fract(c21*c23*c24));
  color/=fill;
  color=1.-color;
  return color;
}
vec3 last_call(vec2 pos,float u_time,pa a){
  vec3 c=vec3(1.0);
  float mul=1.0;
  a.lp*=mul;
  a.hp*=mul;
  a.bp*=mul;
  a.n*=mul;
  c=alt(pos,c,a);
  c=1.-c;
  return c;
}
