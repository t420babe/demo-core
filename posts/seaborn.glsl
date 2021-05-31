// Music: Lovingly - Meramek Remic by Oliver Smitt, Amy J Pryce, Meramek
// #ifndef T4B_B2B_31
mat2 rot(float a){
  return mat2(cos(a),-sin(a),sin(a),cos(a));
}
// https://www.shadertoy.com/view/MsjSW3
float blob(vec3 p3,float time){
  p3.xz*=rot(time*0.4);
  p3.xy*=rot(time*0.3);
  vec3 q=p3*2.0;
  float x0=length(p3+vec3(sin(time*0.7)));
  float x1=sin(length(p3)+1.0);
  float x2=(q.x+sin(q.z+sin(q.y)))*0.5-1.0;
  return x0*x1+x2;
}
void seaborn(vec3 p3,float time) {
  time+=t2s(0,6,13);
  vec3 color=vec3(1.0);
  p3*=2.0;
  p3.xz*=rot(p3.x);
  float y=tan(p3.x)*cos(p3.x*time*3.0);
  p3.x-=0.5;
  float rz=blob(p3,time);
  float f=(rz/blob(p3,y))*10.0;
  vec3 l=1.0*(vec3(u_n,u_hp,u_bp))+vec3(u_lp,u_bp,u_n)*f;
  color=l;
  color.r*=u_n;
  color.g*=u_lp;
  color.b*=u_hp;
  gl_FragColor=vec4(color,1.0);
  gl_FragColor-=texture2D(u_fb,vec2(rz* p3.yx/2.+.5)+vec2(0.001,0.00))-0.002;
  gl_FragColor+=texture2D(u_fb,vec2(p3.xy+0.5));
}
