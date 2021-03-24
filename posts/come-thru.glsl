// Music: Mexico (PunctualRemix) by @shellsmusic, @wearepunctual
// Forked: https://www.shadertoy.com/view/MsjSW3
// #shaders #shader #livecode #glsl #gpu #programming #algorithms #frequency #vj #vjing #art #procedural #creativecode #creativecoding #nyc #brooklyn #bushwick
// #ifndef T420BABE_CHOICE_49
// #include "./lib/t420babe/choice/choice-49.glsl"
// #endif

float map(vec3 uv,float s) {
  uv.xz*=rot(s*0.4);
  uv.xy*=rot(s*0.3);
  vec3 q=uv*2.0+s;
  float x0=length(uv+vec3(sin(s*3.0)));
  float x1=log(length(uv)+2.0);
  float x2=sin(q.x+tan(q.z+sin(q.y)))*5.5;
  return x0*x1+x2-1.0;
}
vec3 single(vec2 uv,float s) {
  vec3 col=vec3(1.0);
  float d=0.5;
  for(int i=0;i<=10;i++)	{
    vec3 uv=vec3(0.0,0.0,5.0)+normalize(vec3(uv,-1.0))*d;
    uv*=atan(s*1.0)*0.9+0.1;
    float rz=map(uv,s);
    float f=clamp((rz-map(uv+0.5,s))*0.5,0.1,1.0);
    float b_mul=wrap_s(s,5.0);
    float r_mul=1.5;
    float g_mul=3.0;
    vec3 l=vec3(0.15,0.25,0.25)+vec3(abs(notch)*r_mul,abs(bp)*g_mul,abs(hp)*b_mul)*f;
    col*=l;
    col+=(0.5-smoothstep(0.0,0.1,rz))*10.0*l;
    d+=min(rz,1.0);
  }
  col=col.bgr;
  col.g*=0.5;
  return col;
}
vec3 multi(vec2 uv,float s) {
  vec3 col=vec3(1.0);
  float d=0.5;
  for(int i=0;i<=10;i++)	{
    vec3 uv=vec3(0.0,0.0,5.0)+normalize(vec3(uv,-1.0))*d;
    uv*=atan(s*1.0)*cos(s*0.1)*0.9+0.1;
    float rz=map(uv,s);
    float f=clamp((rz-map(uv+0.5,s))*0.5,0.1,1.0);
    float b_mul=wrap_s(s,5.0);
    float r_mul=1.5;
    float g_mul=3.0;
    vec3 l=vec3(0.15,0.25,0.25)+vec3(abs(notch)*r_mul,abs(bp)*g_mul,abs(hp)*b_mul)*f;
    col*=l;
    col+=(1.2-smoothstep(0.0,0.1,rz))*0.6*l;
    d+=min(rz,1.0);
  }
  col=col.bgr;
  col.g*=0.5;
  return col;
}
vec3 come_thru(vec2 uv,float s) {
  vec3 col=vec3(1.0);
  lp*=1.3;
  hp*=1.3;
  bp*=1.3;
  notch*=1.3;
  if(s<t2s(0.0,1.0,35.0)) {
    col=single(uv,s);
  } else if(s>t2s(0.0,1.0,35.0)&&s<t2s(0.0,7.0,30.0)){
    col=multi(uv,s);
  } else {
    vec3 col_0=single(uv,s);
    vec3 col_1=multi(uv,s);
    float start=t2s(0.0,7.0,30.0);
    float end=t2s(0.0,7.0,40.0);
    float t=trans(s,start,end);
    col=mix(col_0,col_1,t);
  }
  return col;
}

