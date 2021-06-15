// Tunnel by Polo & Pan,Channel Tres
// #ifndef T4B_TTT_04
// https://youtu.be/WEy29adamhA
mat2 rot(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
vec3 make_me_float(vec2 pos,float time) {
  float x=pos.x;
  float y=pos.y;
  float iiTime=time;
  vec3 color=vec3(5.0);
  float mul=2.0;
  float fill=5.0;
  int v0=int(abs(x));
  int v1=int(abs(mul*(y+fill)));
  int v2=int(abs(x));
  int v3=int(abs(mul*(y-fill)));
  int v4=int(abs(y));
  int v5=int(abs(mul*(x-fill)));
  int v6=int(abs(x));
  int v7=int(iiTime);
  int v8=int(abs(y));
  int v9=int(iiTime);
  int v10=int(abs(x));
  int v11=int(abs(mul*y-iiTime));
  int v12=int(abs(x));
  int v13=int(abs(mul*y+iiTime));
  int v14=int(abs(y));
  int v15=int(abs(mul*x-iiTime));
  int v16=int(abs(y));
  int v17=int(abs(mul*x+iiTime));
  int v18=int(abs(y));
  int v19=int(abs(mul*x));
  int v20=int(abs(x));
  int v21=int(abs(mul*y));
  if(abs(x)>=iiTime+1.0||abs(y)>=iiTime+1.0){
    color=vec3(0.0,1.0,0.0);
  } else if((v0==v1)||(v2==v3)||(v4==v5)||(v6==v7)||(v8==v9)||(v10==v11)||(v12==v13)||(v14==v15)||(v16==v17)||(v18==v19)||(v20==v21)) {
    color=vec3(sin(pos.y),sin(pos.x),1.0);
  }
  return color;
}
void last_night(vec3 p3,float time) {
  vec2 pos=p3.xy;
  pos*=wrap_time(time,t2s(0,3,6)/4.0);
  pos*=rot(time*0.1);
  vec3 color=vec3(u_hp.g*5.5,1.5,1.5);
  color/=make_me_float(pos,time)+0.0;
  color=(0.1-color.gbr);
  gl_FragColor=vec4(color,1.0);
  gl_FragColor +=texture2D(u_fb,vec2(abs(tan(p3.yx/(PI*0.60)+PI))+0.10)+vec2(0.001,0.001))-0.005;
}
