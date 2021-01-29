#ifndef COMMON_PERMUTE
#define COMMON_PERMUTE
vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
// Cellular noise ("Worley noise") in 3D in GLSL.
// Copyright (c) Stefan Gustavson 2011-04-19. All rights reserved.
// This code is released under the conditions of the MIT license.
// See LICENSE file for details.
// Permutation polynomial: (34x^2 + x) mod 289

vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }
vec4 permute(vec4 x) { return mod((34.0 * x + 1.0) * x, 289.0); }
#endif
