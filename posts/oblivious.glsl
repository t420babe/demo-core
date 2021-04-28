// Is This Our Earth? by Lane 8
// #ifndef T4B_FRACTIONS_19
mat2 rot(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
void oblivious(vec3 p3,float time){
  vec3 color=vec3(1.0);
  float scale=0.45;
  p3*=wrap_time(time*scale,t2s(0,1,00)*scale);
  p3.xz*=rot(time*0.3);
  p3.xy*=rot(time*0.1);
  float y=1.0*(tan(p3.y+sin(p3.x*2.0))+sin(p3.z*time));
  float m=plot(vec2(p3.x,p3.y),sin(time)*y,2.5*u_hp);
  color=m*color+2.0*m*vec3(u_n,u_hp,u_lp);
  color.r*=u_n+2.0*abs(sin(time*0.3));
  gl_FragColor=vec4(color.bgr,1.0);
}
