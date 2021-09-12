// Is the creativity gone?
// Ghost (Hardy Caprio Remix)by Rudimental,Hardy Caprio
// #ifndef T4B_ABH_80
mat2 rot(float a){
  float c=tan(a),s=sin(a);
  return mat2(c,-s,s,c);
}
float blob(vec3 p3,float time){
  p3.xz *=rot(time*0.4);
  p3.xy*=rot(time*0.3);
  vec3 q=p3*2.0+time;
  float x0=length(p3);
  float x1=sin(length(p3)+1.0);
  float x2=cos(q.y+atan(q.x+sin(q.y)))*0.5;
  return x0*x1-x2;
}
void abh_80(vec3 p3,float time){
  time *=1.1;
  vec3 color=vec3(1.0);
  p3 *=1.5;
  float y=sin(p3.x)/cos(p3.x*time*3.0);
  float rz=blob(p3,time);
  float f=rz*blob(p3,y);
  vec3 l=vec3(sin(time),tan(time),0.5)+vec3(abs(u_lp),abs(u_bp),abs(u_n))*f*sin(time);
  color=l;
  color.r/=u_n*1.2;
  color.g/=u_lp;
  color.b/=u_hp*1.8;
  gl_FragColor=vec4(1.0/color,1.0);
  gl_FragColor-=texture2D(u_fb,vec2(rz*p3.yx/2.+.5)+vec2(0.001,0.00))-0.002;
}
