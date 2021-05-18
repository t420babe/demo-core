// Matcha Mistake by Lane 8
mat2 rotate2d(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
float map(vec3 p3,float time) {
  p3.xz*=rotate2d(time*0.3);
  p3.xy*=rotate2d(time*0.2);
  vec3 q=tan(p3*2.0+time);
  float x0=length(p3+vec3((time*0.7)));
  float x1=sin(length(p3)+1.0);
  float x2=log(q.x+(q.z+(q.y)));
  return x0*x1/x2;
}
void late(vec3 p3,float time) {
  time*=0.2;
  time+=10.0;
  vec3 color=vec3(1.0);
  u_lp*=1.7;
  u_hp*=1.7;
  u_n*=1.7;
  p3*=wrap_time(time*0.05,30.0)*cos(p3.y) ;
  p3.xz*=-rotate2d(p3.y);
  p3.yx*=rotate2d(time*0.8);
  p3*=5.0;
  float y1=sin(p3.x);
  float m1=plot(vec2(p3.x,p3.y),y1,15.5);
  p3.xy*=m1;
  float rot_z=map(p3,time);
  float y=1.5*u_n*(sin(p3.y*time)+sin(p3.y*time));
  float m=plot(vec2(p3.x,p3.y*u_lp),y*5.0*u_lp,5.50);
  float f=(rot_z-map(p3*1.0,wrap_time(time,10.0))) ;
  vec3 l=vec3(u_n)*asin(0.1*f*p3.y)+cos(0.1*f*p3.y);
  color*=fract(l)*m*l;
  color.r*=u_n;
  color.g*=u_hp;
  color.b*=u_lp;
  gl_FragColor=vec4(rgb2hsv(1.0-color),1.0);
}
