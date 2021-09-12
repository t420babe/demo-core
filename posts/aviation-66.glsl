// Ferris Wheel - Maya Jane Cole Remix by Sylvan Esso,Maya Jane Cole
// #ifndef T4B_ABH_66
// named by Tim Garrity
mat2 rot(float a){
    return mat2(cos(a),-sin(a),sin(a),cos(a));
}
mat2 rot(float a){
  float c=cos(a),s=sin(a);
  return mat2(c,-s,s,c);
}
float blob(vec3 p3,float time){
    p3.xz*=rot(time*0.4);
    p3.xy*=rot(time*0.3);
    vec3 q=p3*2.0+time;
    float x0=length(p3+vec3(sin(time*0.7)));
    float x1=log(length(p3)+1.0);
    float x2=tan(q.x+sin(q.z+sin(q.y)))*0.5;
    return x0*x1+x2;
}
void aviation_66(vec3 p3,float time) {
  time+=100.0;
  vec3 color=vec3(1.0);
  p3*=2.5;
  float y=tan(p3.x)*cos(p3.x*time*3.0);
  p3.x-=0.5;
  float rz=blob(p3,time);
  float f=rz/blob(p3,y)*10.0;
  vec3 l=vec3(0.35,0.1,0.3)+vec3(abs(u_lp),abs(bandpass),abs(u_n))*f;
  color=l;
  color.r/=u_n;
  color.g/=u_lp;
  color.b/=u_hp*1.8;
  gl_FragColor=vec4(1.0/color.grb,1.0);
}

