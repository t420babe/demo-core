#ifndef FNC_EASING
#define FNC_EASING

#ifndef FNC_MATH_CONSTANTS
#include "math-constants.glsl"
#endif

float easeInSine(float x) {
  return 1.0 - cos((x * PI) / 2.0);
}

float easeOutSine(float x) {
  return sin((x * PI) / 2.0);
}

float easeInOutSine(float x) {
  return -(cos((x * PI) - 1.0) / 2.0);
}

float easeInQuad(float x) {
  return x * x;
}

float easeOutQuad(float x) {
  return 1.0 - (1.0 - x) * (1.0 - x);
}

float easeInOutQuad(float x) {
  if (x < 0.5) {
    return (2.0 * easeInQuad(x));
  } else {
    return 1.0 - pow(-2.0 * x + 2.0, 2.0) / 2.0;
  }
}

float easeInCubic(float x) {
  return pow(x, 3.0);
}

float easeOutCubic(float x) {
  return 1.0 - pow(1.0 - x, 3.0);
}

float easeInOutCubic(float x) {
  if (x < 0.5) {
    return 4.0 * easeInCubic(x);
  } else {
    return 1.0 - pow(-2.0 * x + 2.0, 3.0) / 2.0;
  }
}

float easeInQuart(float x) {
  return pow(x, 4.0);
}

float easeOutQuart(float x) {
  return 1.0 - pow(1.0 - x, 4.0);
}

float easeInOutQuart(float x) {
  if (x < 0.5) {
    return 8.0 * easeInQuart(x);
  } else {
    return 1.0 - pow(-2.0 * x + 2.0, 4.0);
  }
}

float easeInQuint(float x) {
  return pow(x, 5.0);
}

float easeOutQuint(float x) {
  return 1.0 - pow(1.0 - x, 5.0);
}

float easeInOutQuint(float x) {
  if (x < 0.5) {
    return 16.0 * pow(x, 5.0);
  } else {
    return 1.0 - pow(-2.0 * x + 2.0, 5.0);
  }
}

float easeInExpo(float x) {
  if ( x == 0.0) {
    return 0.0;
  } else {
    return pow(2.0, 10.0 * x - 10.0);
  }
}

// https://easings.net/#easeOutExpo
float easeOutExpo(float x) {
  if (x == 1.0) {
    return 1.0;
  } else {
    return 1.0 - pow(2.0, -10.0 * x);
  }
}

// https://easings.net/#easeInOutExpo
// float easeInOutExpo(float x) {
//   if (x == 0.0) {
//     return 0.0;
//   } else if (x == 1.0) {
//     if (x < 0.5) {
//       return pow(2.0, 20.0 * x - 10.0) / 2.0;
//     }
//   }
// }

// https://easings.net/#easeInCirc
float easeInCirc(float x) {
  return 1.0 - sqrt(1.0 - pow(x, 2.0));
}

// https://easings.net/#easeOutCirc
float easeOutCirc(float x) {
  return sqrt(1.0 - pow(x - 1.0, 2.0));
}

// https://easings.net/#easeInOutCirc
float easeInOutCirc(float x) {
  if (x < 0.5) {
    return (1.0 - sqrt(1.0 - pow(2.0 * x, 2.0))) / 2.0;
  } else {
    return (sqrt(1.0 - pow(-2.0 * x + 2.0, 2.0)) + 1.0) / 2.0;
  }
}

// https://easings.net/#easeInBack
float easeInBack(float x) {
  float c1 = 1.70158;
  float c3 = c1 + 1.0;
  return c3 * x * x * x - c1 * x * x;
}

// https://easings.net/#easeOutBack
float easeOutBack(float x) {
  float c1 = 1.70158;
  float c3 = c1 + 1.0;
  return 1.0 + c3 * pow(x - 1.0, 3.0) + c1 * pow(x - 1.0, 2.0);
}

// https://easings.net/#easeInOutBack
float easeInOutBack(float x) {
  float c1 = 1.70158;
  float c2 = c1 + 1.525;

  if (x < 0.5) {
    return (pow(2.0 * x, 2.0) * ((c2 + 1.0) * 2.0 * x - c2)) / 2.0;
  } else {
    return (pow(2.0 * x - 2.0, 2.0) * ((c2 + 1.0) * (x * 2.0 - 2.0) + c2) + 2.0) / 2.0;
  }
}

// https://easings.net/#easeInElastic
float easeInElastic(float x) {
  float c4 = (2.0 * PI) / 3.0;
  if (x == 0.0) {
    return 0.0;
  } else if (x == 1.0) {
    return 1.0;
  } else {
    -pow(2.0, 10.0 * x - 10.0) * sin((x * 10.0 - 10.75) * c4);
  }
}

// https://easings.net/#easeOutElastic
float easeOutElastic(float x) {
  float c4 = (2.0 * PI) / 3.0;
  if (x == 0.0) {
    return 0.0;
  } else if (x == 1.0) {
    return 1.0;
  } else {
    return pow(2.0, -10.0 * x) * sin((x * 10.0 - 0.75) * c4) + 1.0;
  }
}

// https://easings.net/#easeInOutElastic
float easeInOutElastic(float x) {
  float c5 = (2.0 * PI) / 4.5;
  if (x == 0.0) {
    return 0.0;
  } else if ( x < 0.5) {
    return 1.0;
  } else if (x < 0.5) {
    return -(pow(2.0, 20.0* x - 10.0) * sin((20.0 * x - 11.125) * c5)) / 2.0;
  } else {
    return (pow(2.0, -20.0 * x + 10.0) * sin((20.0 * x - 11.125) * c5)) / 2.0 + 1.0;
  }
}


// https://easings.net/#easeOutBounce
float easeOutBounce(float x) {
  float n1 = 7.5625;
  float d1 = 2.75;

  if (x < 1.0 / d1) {
    return n1 * x * x;
  } else if (x < 2.0 / d1) {
    float m = x - 1.5;
    return n1 * (m / d1) * m + 0.75;
  } else if (x < 2.5 / d1) {
    float m = x - 2.5;
    return n1 * (m / d1) * m + 0.9375;
  } else {
    float m = x - 2.625;
    return n1 * ( m / d1) * m + 0.984375;
  }
}

// https://easings.net/#easeInBounce
float easeInBounce(float x) {
  return 1.0 - easeOutBounce(1.0 - x);
}

// https://easings.net/#easeInOutBounce
float easeInOutBounce(float x) {
  if (x < 0.5) {
    return (1.0 - easeOutBounce( 1.0 - 2.0 * x)) / 2.0;
  } else {
    return (1.0 + easeOutBounce( 2.0 * x - 1.0)) / 2.0;
  }
}
#endif
