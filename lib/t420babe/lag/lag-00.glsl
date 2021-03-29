#ifndef T4B_LLL_00
#define T4B_LLL_00

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_POLYGON
#include "lib/pxl/polygon-sdf.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

// Like https://www.shadertoy.com/view/llsyD2 with different setting:
// here, we show stable and unstable regions around a vortex.

// visualizing LCS/FTLE on flow field.
//     base flow field: trirop's https://www.shadertoy.com/view/MsScWD
// about LCS/FTLE:
//     http://georgehaller.com/reprints/annurev-fluid-010313-141322.pdf
//     https://en.wikipedia.org/wiki/Lagrangian_coherent_structure
// deformation/strain tensors: https://en.wikipedia.org/wiki/Finite_strain_theory#The_right_Cauchy.E2.80.93Green_deformation_tensor

#define FRAC false // true: fractal motion
#define FLOW 1     // animates either flow deformation (1) or details (0)

vec2 v(vec2 p,float s){	                    // --- advection vector field
#if 0                                       // base flow: better with FRAC = true
  return vec2(sin(s*p.y),cos(s*p.x));
#else                                       // vortex plume :  better with FRAC = false
#define vort(p) vec2( -(p).y, (p).x ) / dot(p,p)
  return .1 * ( vort(p-vec2(.2,.2)) - vort(p-vec2(-.2,.2)) ) -vec2(0,-.2); 
#endif
}

vec2 RK4(vec2 p, float s, float h){         // order 4 Runge-Kutta motion integrator
  vec2 k1 = v( p         , s ),
       k2 = v( p +.5*h*k1, s ),
       k3 = v( p +.5*h*k2, s ),
       k4 = v( p +   h*k3, s );
  return h/3.* ( .5*k1 + k2 + k3 + .5*k4 );
}

vec4 lagrangian_coherent_structure_00(vec2 pos, float time, peakamp audio, vec2 resolution) { 
  vec3 color = vec3(1.0);
  vec4 O = vec4(color, 1.0);
  vec2  R = resolution.xy, 
        U = ( 2.*pos - R ) / R.y, V = U;
  float s = 2. , scale = 1.,
#if FLOW                                    // animates flow deformation
        h = log(1./(exp(8.* -fract(time*.5/3.1415))+exp(-2.))+exp(-2.))/8.,
        n = 5.*3.; 
#else                                       // animates detail resolution
  h =  .25,      
    n = mod(4.*time,48.); n = 1.+ min(n, 48.-n);
#endif
  for(int i = 0; i < int(n); i++){        // step in time or scales
    if (FRAC) scale = exp2(floor(float(i+4)/5.)); // fractal scaling
    V += RK4( V, s*scale, h/scale );
  }
  if (FRAC) scale = exp2(floor((n+4.)/5.)); // fractal scaling
  V += fract(n) * RK4(V,s*scale,h/scale);   // partial step for continuity

  n = fract(4.*time/48.);
  vec2 tmp = pos;
  if (n<.5) {
    //   O = vec4(.4*length(V));               // display mapping
    // O = .7+.3*texture(iChannel0,V/4.-.5); // variant
    // O = .7+.3*texture2D(time,V/4.-.5); // variant
    tmp = .7+.3*pos; // variant
    O = vec4(tmp.x, tmp.y, tmp.x, tmp.y); // variant
  } else {
    O = vec4(1);
  }

  // --- compute right Cauchy-Green deformation tensor
  mat2 J = mat2(dFdx(V),dFdy(V)),        // grad(V) (should be transpose, but same final eigens)
       D = transpose(J)*J;               // right Cauchy-Green deformation tensor
  float a = 1., b = -D[0][0]-D[1][1], c = determinant(D), // compute eingenvalues
        d = sqrt(b*b-4.*a*c),
        l1 = (-b+d)/2., l2 = (-b-d)/2.;   // l1 > l2
  l1 = sqrt(l1); l2 = sqrt(l2);           // shears

  //n = mod(4.*time/48.,2.);               // display deformation measures
  //if (n<1.)
  O.gb -=  2.*l1;            
  //O.gb -=  10.*l2;
  //else      O.gb -= .7+.05*( log(l1)/h ); // Lyapunov exponent ( FTLE ) 

  //O = -.05*vec4( log(l1)/h );             // Lyapunov exponent ( FTLE ) 

  return O;
}

vec4 lag_00(vec2 pos, float time, peakamp audio) {
  // vec3 color = vec3(0.5, 0.0, 1.0);
  vec4 color = lagrangian_coherent_structure_00(pos, time, audio);
  // color = flash_mul(color, time, 5.0 + abs(audio.highpass));
  // pos = rotate2d(time * 5.0 * 10.0) * pos;
  // float poly = sharp(polygon(pos, 5, 5.0 * audio.bandpass));
  // color *= poly;

  return color;
}
#endif
