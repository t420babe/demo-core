// #torecord
// Music: Idontknow- 7" Version by Jamie xx
// #ifndef T4B_B2B_38
mat2 rot(float a){
  return mat2(cos(a),-sin(a),sin(a),cos(a));
}
float blob(vec3 p3,float time){
  p3=p3.yxz;
  p3.xz*=rot(time*0.4);
  p3.xy*=rot(time*0.3);
  vec3 q=p3*2.0+time;
  float x0=length(p3+vec3(sin(time*0.7)));
  float x1=tan(length(p3)+p3.x *p3.y);
  float x2=(q.x+tan(q.z+length(q)))*0.5-1.0;
  return x0*x1+x2;
}
void _22d(vec3 p3,float time) {
  vec3 color=vec3(1.0);
  p3.y*=0.75;
  p3.xz*=rot(time*0.25);
  p3.xy*=rot(time*0.25);
  p3*=10.0;
  float y=tan(p3.x)*cos(p3.x*time*3.0);
  float m=plot(vec2(p3),y,0.25);
  float rz=blob(p3,time);
  float f=(rz/blob(p3,y))*10.0;
  vec3 l=vec3(0.35,0.1,0.3)+vec3(abs(u_lp),abs(u_bp),abs(u_n))*f;
  color*=l;
  color.r*=u_n;
  color.g*=u_lp;
  color.b*=u_hp;
  color=rgb2hsv(color).bgr;
  gl_FragColor=vec4(color,1.0);
}
