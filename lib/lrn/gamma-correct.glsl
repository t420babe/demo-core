#ifndef LRN_GAMMA_CORRECT
#define LRN_GAMMA_CORRECT

float gamma_correct(float gamma, float x) {
  return pow(x, 1.0 / gamma);
}
#endif
