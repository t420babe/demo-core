// #ifndef T4B_ABQ_06
// Forked from: @playbyan1453 https://www.shadertoy.com/view/ft3GDX
mat2 rot(float a){
  return mat2(cos(a),-sin(a),sin(a),cos(a));
}
float map(vec3 p) {
  return ((length(p)-1.0)+
      (sin(8.0*p.x)*sin(8.0*p.y)*sin(8.0*p.z))*0.5)*0.7;
}
vec3 normal(vec3 p) {
  const float e=1e-5;
  const vec2 h=vec2(1,-1);
  return normalize(h.xyy*map(p+h.xyy*e) +
      h.yyx*map(p+h.yyx*e) +
      h.yxy*map(p+h.yxy*e) +
      h.xxx*map(p+h.xxx*e));
}
// Original Code : https://iquilezles.org/www/articles/rmshadows/rmshadows.htm
float hraymarch(vec3 ro,vec3 rd) {
  float t=0.0;
  float pd=1e19;
  for (int i=0;i<28;i++) {
    float d=map(ro+rd*t);
    float y=d*d/(2.0*pd);
    float h=sqrt(d*d-y*y);
    pd=d;
    t +=min(d,h / max(0.0,t-y));
    if (d<1e-5||t>21.0) break;
  }
  return t;
}
void main_1453(vec3 p3,float time) {
  vec2 uv=p3.xy;
  vec3 at=vec3(0,0,0);
  vec2 ro_uv=rot(time)*uv;
  vec3 ro=vec3(sin(time*0.25)*2.0,cos(time*0.25)*2.0,2.0);
  vec3 z=normalize(at-ro);
  vec3 x=normalize(cross(vec3(0,1,0),z));
  vec3 y=cross(z,x);
  vec3 rd=normalize(uv.x*x+uv.y*y+z);
  float t=hraymarch(ro,rd);
  vec3 p=ro-rd*t*(sin(time)+2.0);
  vec3 nor=normal(p);
  float a=dot(nor,normalize(ro*ro));
  vec3 a_v=vec3(a);
  a_v.r*=u_n*3.0;
  a_v.g*=u_lp*2.5;
  a_v.b*=u_hp*3.0;
  vec3 col=fract(a_v);
  gl_FragColor=vec4(col.gbr,1.0);
}
