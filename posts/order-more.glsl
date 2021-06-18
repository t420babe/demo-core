// On Hold-Jamie xx Remix by the xx,Jamie xx
// OrderMore 
// #ifndef T4B_TTT_06
mat2 rot(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
// Forked this fn from somewhere but can't remember now :(
vec3 make_me_float(vec2 pos,float time) {
  float x=pos.x;
  float y=pos.y;
  float iiTime= time;
  vec3 color=vec3(0.0);
  int v0=int(abs(y*tan(x)));
  int v1=int(abs(2.0*(y+100.0)));
  int v2=int(abs(x));
  int v3=int(abs(2.0*(y-100.0)));
  int v4=int(abs(y));
  int v5=int(abs(2.0*(x-100.0)));
  int v6=int(abs(x));
  int v7=int(iiTime);
  int v8=int(abs(y));
  int v9=int(iiTime);
  int v10=int(abs(x));
  int v11=int(abs(2.0*y-iiTime));
  int v12=int(abs(x));
  int v13=int(abs(2.0*y+iiTime));
  int v14=int(abs(y));
  int v15=int(abs(2.0*x-iiTime));
  int v16=int(abs(y));
  int v17=int(abs(2.0*x+iiTime));
  int v18=int(abs(y));
  int v19=int(abs(2.0*x));
  int v20=int(abs(x));
  int v21=int(abs(2.0*y));
  if(abs(x)>=iiTime+1.0||abs(y)>=iiTime+1.0){
    color=vec3(0,1,0);
  } else if((v0==v1)||(v2==v3)||(v4==v5)||(v6==v7)||(v8==v9)||(v10==v11)||(v12==v13)||(v14==v15)||(v16==v17)||(v18==v19)||(v20==v21)){
    color=vec3(1,1,1);
  }
  return color;
}
void ordermore(vec3 p3,float time) {
  u_n*=2.0;
  u_bp*=2.0;
  u_hp*=2.0;
  time=wrap_time(time,t2s(0,6,11) / 4.0);
  p3.xy*=rot(time*0.15);
  vec2 pos=p3.xy;
  pos*=time;
  vec3 color=vec3(1.0);
  color*=make_me_float(pos,time,audio);
  color.b*=u_hp*2.0;
  color.g*=u_bp*2.0;
  color.r*=u_n*2.0;
  color=color.rbg;
  gl_FragColor=vec4(color,1.0);
  gl_FragColor+=texture2D(u_fb,vec2(abs(sin(p3.yx/(PI*0.60)+PI))+0.10)+vec2(0.001,0.001));
  gl_FragColor-=texture2D(u_fb,vec2(abs(tan(p3.yx/(PI*0.60)+PI))+0.10)+vec2(0.001,0.001))-0.002;
}
