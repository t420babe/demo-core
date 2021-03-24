#ifndef COMMON_TIME_CONVERT
#define COMMON_TIME_CONVERT

float t2s(int hour, int min, int sec) {
  float s = float(sec);
  s += float(min * 60);
  s += float(hour * 60 * 60);

  return float(s);
}


// For historical
float t2s(float hour, float min, float sec) {
  float s = sec;
  s += min * 60.0;
  s += hour * 60.0 * 60.0;

  return s;
}
#endif
