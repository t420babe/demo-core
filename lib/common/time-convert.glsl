#ifndef COMMON_TIME_CONVERT
#define COMMON_TIME_CONVERT

float t2s(float hour, float min, float sec) {
  float s = sec;
  s += min * 60.0;
  s += hour * 60.0 * 60.0;

  return s;
}
#endif
