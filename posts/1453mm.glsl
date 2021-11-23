void main(){
  highp vec3 a;
  highp vec3 b;
  b.z=2.0;
  b.x=0.4948079;
  b.y=1.937825;
  highp vec3 c;
  c=b;
  highp float d;
  highp float e;
  e=0.0;
  d=1e+19;
  for(highp int f=0; f<28; f++){
    highp float g;
    highp vec3 h;
    h=(c+(vec3(-0.7564531,0.02500008,-0.65357)*e));
    g=(((sqrt(dot(h,h))-1.0)+(((sin((8.0*h.x))*sin((8.0*h.y)))*sin((8.0*h.z)))*0.5))*0.7);
    highp float i;
    i=((g*g)/(2.0*d));
    d=g;
    e=(e+min(g,(sqrt(((g*g)-(i*i)))/max(0.0,(e-i)))));
    if(((g<1e-05)||(e>21.0))){
      break;
    }
  }
  highp vec3 j;
  j=(vec3(0.4948079,1.937825,2.0)-(vec3(-2.14944,0.07103699,-1.8571)*e));
  highp vec3 k;
  k=(j+vec3(1e-05,-1e-05,-1e-05));
  highp vec3 l;
  l=(j+vec3(-1e-05,-1e-05,1e-05));
  highp vec3 m;
  m=(j+vec3(-1e-05,1e-05,-1e-05));
  highp vec3 n;
  n=(j+vec3(1e-05,1e-05,1e-05));
  highp float o;
  o=dot(normalize(((((((sqrt(dot(k,k))-1.0)+(((sin((8.0*k.x))*sin((8.0*k.y)))*sin((8.0*k.z)))*0.5))*vec3(0.7,-0.7,-0.7))+(((sqrt(dot(l,l))-1.0)+(((sin((8.0*l.x))*sin((8.0*l.y)))*sin((8.0*l.z)))*0.5))*vec3(-0.7,-0.7,0.7)))+(((sqrt(dot(m,m))-1.0)+(((sin((8.0*m.x))*sin((8.0*m.y)))*sin((8.0*m.z)))*0.5))*vec3(-0.7,0.7,-0.7)))+vec3((((sqrt(dot(n,n))-1.0)+(((sin((8.0*n.x))*sin((8.0*n.y)))*sin((8.0*n.z)))*0.5))*0.7)))),vec3(0.04458091,0.6837615,0.7283424));
  a.x=(o*3.0);
  a.y=(o*2.5);
  a.z=(o*3.0);
  mediump vec4 p;
  p.w=1.0;
  p.xyz=fract(a).yzx;
  gl_FragColor=p;

}

