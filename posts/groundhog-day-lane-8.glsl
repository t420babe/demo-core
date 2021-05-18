// Groundhog Day by Lane 8
// #ifndef T4B_FRACTIONS_88
mat2 rotate2d(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
float map(vec3 p3,float time) {
  p3.xz*=rotate2d(time*0.3);
  p3.xy*=rotate2d(time*0.2);
  vec3 q=p3*2.0+time;
  float x0=length(p3+vec3(sin(time*0.7)));
  float x1=log(length(p3)+1.0);
  float x2=sin(q.x+atan(q.z+sin(q.y)))*5.5;
  return x0*x1+x2*5.0;
}
void ghd(vec3 p3,float time) {
  vec3 color=vec3(1.0);
  p3*=10.0;
  float y1=1.5*(sin(p3.x+1.0)*sin(p3.x*time));
  float m1=plot(vec2(p3.x,p3.y),y1,0.10)*1.0;
  p3.xy*=rotate2d(time*0.2)*m1;
  p3.xy+=0.1;
  float rz=map(p3,time);
  float y=0.5*abs(sin(p3.x+1.0)+sin(p3.x*time));
  float m=plot(vec2(p3.x,p3.y),y,1.50)*1.0;
  float r_mul=0.1;
  float g_mul=2.0;
  float b_mul=1.5;
  float f =rz - (map(p3,sin(time*1.0))*5.0);
  vec3 l=vec3(y);
  color*=l;
  gl_FragColor=vec4(color,1.0);
}

#endif
