float circle_1(vec2 st,float radius) {
return length(st)*radius;
}
float place(vec2 p,float r,vec2 off) {
p+=off;
return circle_1(p,r);
}
void from_255(inout vec3 rgb) {
rgb/=255.0;
}
mat2 rotate2d(float theta) {
return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
vec3 alternate(in vec2 pos,vec3 color) {
pos=abs(sin(pos*5.5))+0.05;
// pos=abs(sin(pos*2.8)*(wrap_time(u_time,30.0)*0.5+1.01));
vec3 fill=vec3(1.0);
fill=vec3(233.0,255.0,164.0);
from_255(fill);
if (abs(ntch)>0.4) {
fill=vec3(200.0,174.0,117.0);
from_255(fill);
fill=1.0-fill;
}
fill.r*=abs(sin(u_time)+0.1);
fill.g*=abs(cos(u_time)+0.4);
float r=0.5*abs(hp*lp+abs(ntch));
float r0=1.0*abs(hp*lp+abs(ntch));
float mul=(clamp(sin(u_time*0.5),0.5,1.0)+0.05)*0.1;
pos/=0.5;
pos=rotate2d(tan(u_time)*3.14/5.0)*abs(tan(pos.yx))*pos;
float play=1.5;
float f0=abs(cos(u_time/0.3))+0.1;
float c00=place(pos,r0,vec2(f0*1.0, f0*-0.75));
float c01=place(pos,r,vec2(f0,f0*-0.75));
float c02=place(pos,r0,vec2(f0*-2.0,f0*-0.75));
float c03=place(pos,r,vec2(f0*-1.5,f0*-0.75));
float c04=place(pos,r0,vec2(f0*1.5,f0*-0.75));
float c10=place(pos,abs(sin(r*mul)),vec2(f0*0.5,play));
float c11=place(pos*vec2(0.5),abs(sin(r*mul)),vec2(f0,play));
float c12=place(pos,abs(sin(r*mul)),vec2(f0*-0.5,play));
float c13=place(pos*vec2(0.5),abs(sin(r*mul)),vec2(f0*-.3,play));
float c14=place(pos,abs(sin(r*mul)),vec2(f0*1.5, play));
float c20=place(pos*vec2(0.5),r,vec2(f0*1.0, f0*0.75));
float c21=place(pos,r,vec2(f0*0.2, f0*0.75));
float c22=place(pos,r,vec2(f0*0.2, f0*1.75));
float c23=place(pos*vec2(0.5),r,vec2(f0*-1.0,f0*0.75));
float c24=place(pos,r,vec2(f0*0.5, f0*0.5));
color*=vec3((c01*c02*c03/c04));
color/=vec3(c01/(c11)*c13/(c14));
color*=vec3((c20*c21*c23*c24));
color*=fill;
color=1.0-color;
return color;
}
vec3 its_voodoo(vec2 pos) {
vec3 color=vec3(1.0);
color=alternate(pos,color);
color=1.0-color;
return color;
}
