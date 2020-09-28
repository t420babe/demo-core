/* target qmetro: 20 ms but can set it and forget it at 30 ms */
#ifdef GL_ES
precision mediump float;
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef UNIFORMS
#define UNIFORMS
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#endif

#ifndef COMMON_COMMON
#include "./common/00-common.glsl"
#endif

#ifndef PXL
#include "./pxl/00-pxl.glsl"
#endif

#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif

#ifndef S
#define S(multiplier, seconds) multiplier * seconds
#endif

void couch_auto(vec2 pos, float u_time, peakamp audio, out vec3 color, float seconds) {
  float my_time = mod(u_time, seconds * 5.0) + 50.0;
  if (u_time < S(51.0, seconds)) {
  couch_0(pos, u_time, audio, color);
  } else if (my_time < S(50.0, seconds)) {
  couch2(pos, u_time, audio, color);
  } else if (my_time < S(51.0, seconds)) {
  couch3(pos, u_time, audio, color);
  } else if (my_time < S(52.0, seconds)) {
  couch4(pos, u_time, audio, color);
  } else if (my_time < S(53.0, seconds)) {
  couch5(pos, u_time, audio, color);
  } else if (my_time < S(54.0, seconds)) {
  couch6(pos, u_time, audio, color);
  } else if (my_time < S(55.0, seconds)) {
  couch7(pos, u_time, audio, color);
  } else if (my_time < S(56.0, seconds)) {
  couch8(pos, u_time, audio, color);
  } else if (my_time < S(57.0, seconds)) {
  couch9(pos, u_time, audio, color);
  } else if (my_time < S(58.0, seconds)) {
  couch10(pos, u_time, audio, color);
  } else if (my_time < S(59.0, seconds)) {
  couch11(pos, u_time, audio, color);
  } else if (my_time < S(60.0, seconds)) {
  couch12(pos, u_time, audio, color);
  } else if (my_time < S(61.0, seconds)) {
  couch13(pos, u_time, audio, color);
  } else if (my_time < S(62.0, seconds)) {
  couch14(pos, u_time, audio, color);
  } else if (my_time < S(63.0, seconds)) {
  couch15(pos, u_time, audio, color);
  } else if (my_time < S(64.0, seconds)) {
  couch16(pos, u_time, audio, color);
  } else if (my_time < S(65.0, seconds)) {
  couch17(pos, u_time, audio, color);
  } else if (my_time < S(66.0, seconds)) {
  couch18(pos, u_time, audio, color);
  } else if (my_time < S(71.0, seconds)) {
  couch23(pos, u_time, audio, color);
  } else if (my_time < S(72.0, seconds)) {
  couch24(pos, u_time, audio, color);
  } else if (my_time < S(73.0, seconds)) {
  couch25(pos, u_time, audio, color);
  } else if (my_time < S(74.0, seconds)) {
  couch26(pos, u_time, audio, color);
  } else if (my_time < S(75.0, seconds)) {
  couch27(pos, u_time, audio, color);
  } else if (my_time < S(76.0, seconds)) {
  couch28(pos, u_time, audio, color);
  } else if (my_time < S(77.0, seconds)) {
  couch29(pos, u_time, audio, color);
  } else if (my_time < S(78.0, seconds)) {
  couch30(pos, u_time, audio, color);
  } else if (my_time < S(89.0, seconds)) {
  couch41(pos, u_time, audio, color);
  } else if (my_time < S(90.0, seconds)) {
  couch42(pos, u_time, audio, color);		// i like this one a lot
  } else if (my_time < S(91.0, seconds)) {
  couch43(pos, u_time, audio, color);
  } else if (my_time < S(92.0, seconds)) {
  couch44(pos, u_time, audio, color);
  } else if (my_time < S(93.0, seconds)) {
  couch45(pos, u_time, audio, color);
  } else if (my_time < S(94.0, seconds)) {
  couch46(pos, u_time, audio, color);
  } else if (my_time < S(95.0, seconds)) {
  couch47(pos, u_time, audio, color);
  } else if (my_time < S(96.0, seconds)) {
  couch48(pos, u_time, audio, color);
  } else if (my_time < S(97.0, seconds)) {
  couch49(pos, u_time, audio, color);
  } else if (my_time < S(98.0, seconds)) {
  couch50(pos, u_time, audio, color);
  } else if (my_time < S(99.0, seconds)) {
  couch51(pos, u_time, audio, color);
  } else if (my_time < S(100.0, seconds)) {
  couch52(pos, u_time, audio, color);
  } else if (my_time < S(101.0, seconds)) {
  couch53(pos, u_time, audio, color);
  } else if (my_time < S(102.0, seconds)) {
  couch54(pos, u_time, audio, color);
  } else if (my_time < S(103.0, seconds)) {
  couch55(pos, u_time, audio, color);
  } else if (my_time < S(104.0, seconds)) {
  couch56(pos, u_time, audio, color);
  } else if (my_time < S(105.0, seconds)) {
  couch57(pos, u_time, audio, color);
  } else if (my_time < S(106.0, seconds)) {
  couch58(pos, u_time, audio, color);
  } else if (my_time < S(107.0, seconds)) {
  couch59(pos, u_time, audio, color);
  } else if (my_time < S(108.0, seconds)) {
  couch60(pos, u_time, audio, color);
  } else if (my_time < S(109.0, seconds)) {
  couch61(pos, u_time, audio, color);
  } else if (my_time < S(110.0, seconds)) {
  couch62(pos, u_time, audio, color);
  } else if (my_time < S(111.0, seconds)) {
  couch63(pos, u_time, audio, color);
  } else if (my_time < S(112.0, seconds)) {
  couch64(pos, u_time, audio, color);
  } else if (my_time < S(113.0, seconds)) {
  couch65(pos, u_time, audio, color);
  } else if (my_time < S(114.0, seconds)) {
  couch66(pos, u_time, audio, color);
  } else if (my_time < S(115.0, seconds)) {
  couch67(pos, u_time, audio, color);
  } else if (my_time < S(116.0, seconds)) {
  couch68(pos, u_time, audio, color);
  } else if (my_time < S(117.0, seconds)) {
  couch69(pos, u_time, audio, color);
  } else if (my_time < S(118.0, seconds)) {
  couch70(pos, u_time, audio, color);
  } else if (my_time < S(119.0, seconds)) {
  couch71(pos, u_time, audio, color);
  } else if (my_time < S(120.0, seconds)) {
  couch72(pos, u_time, audio, color);
  } else if (my_time < S(121.0, seconds)) {
  couch73(pos, u_time, audio, color);
  } else if (my_time < S(122.0, seconds)) {
  couch74(pos, u_time, audio, color);
  } else if (my_time < S(123.0, seconds)) {
  couch75(pos, u_time, audio, color);
  } else if (my_time < S(124.0, seconds)) {
  couch76(pos, u_time, audio, color);
  } else if (my_time < S(125.0, seconds)) {
  couch77(pos, u_time, audio, color);
  } else if (my_time < S(126.0, seconds)) {
  couch78(pos, u_time, audio, color);
  } else if (my_time < S(127.0, seconds)) {
  couch79(pos, u_time, audio, color);
  } else if (my_time < S(128.0, seconds)) {
  couch80(pos, u_time, audio, color);
  } else if (my_time < S(129.0, seconds)) {
  couch81(pos, u_time, audio, color);
  } else if (my_time < S(130.0, seconds)) {
  couch82(pos, u_time, audio, color);
  } else if (my_time < S(131.0, seconds)) {
  couch83(pos, u_time, audio, color);
  } else if (my_time < S(132.0, seconds)) {
  couch84(pos, u_time, audio, color);
  } else if (my_time < S(133.0, seconds)) {
  couch85(pos, u_time, audio, color);
  } else if (my_time < S(134.0, seconds)) {
  couch86(pos, u_time, audio, color);
  } else if (my_time < S(135.0, seconds)) {
  couch87(pos, u_time, audio, color);
  } else if (my_time < S(136.0, seconds)) {
  couch88(pos, u_time, audio, color);
  } else if (my_time < S(137.0, seconds)) {
  couch89(pos, u_time, audio, color);
  } else if (my_time < S(138.0, seconds)) {
  couch90(pos, u_time, audio, color);
  } else if (my_time < S(139.0, seconds)) {
  couch91(pos, u_time, audio, color);
  } else if (my_time < S(140.0, seconds)) {
  couch92(pos, u_time, audio, color);
  } else if (my_time < S(141.0, seconds)) {
  couch93(pos, u_time, audio, color);
  } else if (my_time < S(142.0, seconds)) {
  couch94(pos, u_time, audio, color);
  } else if (my_time < S(143.0, seconds)) {
  couch95(pos, u_time, audio, color);
  } else if (my_time < S(144.0, seconds)) {
  couch96(pos, u_time, audio, color);
  } else if (my_time < S(145.0, seconds)) {
  couch97(pos, u_time, audio, color);
  } else if (my_time < S(146.0, seconds)) {
  couch98(pos, u_time, audio, color);
  } else if (my_time < S(147.0, seconds)) {
  couch99(pos, u_time, audio, color);
  } else if (my_time < S(148.0, seconds)) {
  couch100(pos, u_time, audio, color);
  } else if (my_time < S(149.0, seconds)) {
  couch101(pos, u_time, audio, color);
  } else if (my_time < S(150.0, seconds)) {
  couch102(pos, u_time, audio, color);
  } else if (my_time < S(151.0, seconds)) {
  couch103(pos, u_time, audio, color);
  } else if (my_time < S(152.0, seconds)) {
  couch104(pos, u_time, audio, color);
  } else if (my_time < S(153.0, seconds)) {
  couch105(pos, u_time, audio, color);
  } else if (my_time < S(154.0, seconds)) {
  couch106(pos, u_time, audio, color);
  } else if (my_time < S(155.0, seconds)) {
  couch107(pos, u_time, audio, color);
  } else if (my_time < S(156.0, seconds)) {
  couch108(pos, u_time, audio, color);
  } else if (my_time < S(157.0, seconds)) {
  couch109(pos, u_time, audio, color);
  } else if (my_time < S(158.0, seconds)) {
  couch110(pos, u_time, audio, color);
  } else if (my_time < S(159.0, seconds)) {
  couch111(pos, u_time, audio, color);
  } else if (my_time < S(160.0, seconds)) {
  couch112(pos, u_time, audio, color);
  } else if (my_time < S(161.0, seconds)) {
  couch113(pos, u_time, audio, color);
  } else if (my_time < S(162.0, seconds)) {
  couch114(pos, u_time, audio, color);
  } else if (my_time < S(163.0, seconds)) {
  couch115(pos, u_time, audio, color);
  } else if (my_time < S(164.0, seconds)) {
  couch116(pos, u_time, audio, color);
  } else if (my_time < S(165.0, seconds)) {
  couch117(pos, u_time, audio, color);
  } else if (my_time < S(166.0, seconds)) {
  couch118(pos, u_time, audio, color);
  } else if (my_time < S(167.0, seconds)) {
  couch119(pos, u_time, audio, color);
  } else if (my_time < S(168.0, seconds)) {
  couch120(pos, u_time, audio, color);
  } else if (my_time < S(169.0, seconds)) {
  couch121(pos, u_time, audio, color);
  } else if (my_time < S(170.0, seconds)) {
  couch122(pos, u_time, audio, color);
  } else if (my_time < S(171.0, seconds)) {
  couch123(pos, u_time, audio, color);
  } else if (my_time < S(172.0, seconds)) {
  couch124(pos, u_time, audio, color);
  } else if (my_time < S(173.0, seconds)) {
  couch125(pos, u_time, audio, color);
  } else if (my_time < S(174.0, seconds)) {
  couch126(pos, u_time, audio, color);
  } else if (my_time < S(175.0, seconds)) {
  couch127(pos, u_time, audio, color);
  } else if (my_time < S(176.0, seconds)) {
  couch128(pos, u_time, audio, color);
  } else if (my_time < S(177.0, seconds)) {
  couch129(pos, u_time, audio, color);
  } else if (my_time < S(178.0, seconds)) {
  couch130(pos, u_time, audio, color);		// i like this one a lot, yeah thats cool
  } else if (my_time < S(179.0, seconds)) {
  couch131(pos, u_time, audio, color);
  } else if (my_time < S(180.0, seconds)) {
  couch132(pos, u_time, audio, color);
  } else if (my_time < S(181.0, seconds)) {
  couch133(pos, u_time, audio, color);
  } else if (my_time < S(182.0, seconds)) {
  couch134(pos, u_time, audio, color);
  } else if (my_time < S(183.0, seconds)) {
  couch135(pos, u_time, audio, color);
  } else if (my_time < S(184.0, seconds)) {
  couch136(pos, u_time, audio, color);
  } else if (my_time < S(185.0, seconds)) {
  couch137(pos, u_time, audio, color);
  } else if (my_time < S(186.0, seconds)) {
  couch138(pos, u_time, audio, color);
  } else if (my_time < S(187.0, seconds)) {
  couch139(pos, u_time, audio, color);
  } else if (my_time < S(188.0, seconds)) {
  couch140(pos, u_time, audio, color);
  } else if (my_time < S(189.0, seconds)) {
  couch141(pos, u_time, audio, color);
  } else if (my_time < S(190.0, seconds)) {
  couch142(pos, u_time, audio, color);
  } else if (my_time < S(191.0, seconds)) {
  couch143(pos, u_time, audio, color);
  } else if (my_time < S(192.0, seconds)) {
  couch144(pos, u_time, audio, color);
  } else if (my_time < S(193.0, seconds)) {
  couch145(pos, u_time, audio, color);
  } else if (my_time < S(194.0, seconds)) {
  couch146(pos, u_time, audio, color);
  } else if (my_time < S(195.0, seconds)) {
  couch147(pos, u_time, audio, color);
  } else if (my_time < S(196.0, seconds)) {
  couch148(pos, u_time, audio, color);
  } else if (my_time < S(197.0, seconds)) {
  couch149(pos, u_time, audio, color);
  } else if (my_time < S(198.0, seconds)) {
  couch150(pos, u_time, audio, color);
  } else if (my_time < S(199.0, seconds)) {
  couch151(pos, u_time, audio, color);			// i like this one
  } else if (my_time < S(200.0, seconds)) {
  couch152(pos, u_time, audio, color);
  } else if (my_time < S(201.0, seconds)) {
  couch153(pos, u_time, audio, color);
  } else if (my_time < S(202.0, seconds)) {
  couch154(pos, u_time, audio, color);
  } else if (my_time < S(203.0, seconds)) {
  couch155(pos, u_time, audio, color);
  } else if (my_time < S(204.0, seconds)) {
  couch156(pos, u_time, audio, color);
  } else if (my_time < S(205.0, seconds)) {
  couch157(pos, u_time, audio, color);
  } else if (my_time < S(206.0, seconds)) {
  couch158(pos, u_time, audio, color);
  } else if (my_time < S(207.0, seconds)) {
  couch159(pos, u_time, audio, color);
  } else if (my_time < S(208.0, seconds)) {
  couch160(pos, u_time, audio, color);
  } else if (my_time < S(209.0, seconds)) {
  couch161(pos, u_time, audio, color);
  } else if (my_time < S(210.0, seconds)) {
  couch162(pos, u_time, audio, color);
  } else if (my_time < S(211.0, seconds)) {
  couch163(pos, u_time, audio, color);
  } else if (my_time < S(212.0, seconds)) {
  couch164(pos, u_time, audio, color);
  } else if (my_time < S(213.0, seconds)) {
  couch165(pos, u_time, audio, color);
  } else if (my_time < S(214.0, seconds)) {
  couch166(pos, u_time, audio, color);
  } else if (my_time < S(215.0, seconds)) {
  couch167(pos, u_time, audio, color);
  } else if (my_time < S(216.0, seconds)) {
  couch168(pos, u_time, audio, color);
  } else if (my_time < S(217.0, seconds)) {
  couch169(pos, u_time, audio, color);
  } else if (my_time < S(218.0, seconds)) {
  couch170(pos, u_time, audio, color);
  } else if (my_time < S(219.0, seconds)) {
  couch171(pos, u_time, audio, color);
  } else if (my_time < S(220.0, seconds)) {
  couch172(pos, u_time, audio, color);
  } else if (my_time < S(221.0, seconds)) {
  couch173(pos, u_time, audio, color);
  } else if (my_time < S(222.0, seconds)) {
  couch174(pos, u_time, audio, color);
  } else if (my_time < S(223.0, seconds)) {
  couch175(pos, u_time, audio, color);
  } else if (my_time < S(224.0, seconds)) {
  couch176(pos, u_time, audio, color);
  } else if (my_time < S(225.0, seconds)) {
  couch177(pos, u_time, audio, color);
  } else if (my_time < S(226.0, seconds)) {
  couch178(pos, u_time, audio, color);
  } else if (my_time < S(227.0, seconds)) {
  couch179(pos, u_time, audio, color);
  } else if (my_time < S(228.0, seconds)) {
  couch180(pos, u_time, audio, color);
  } else if (my_time < S(229.0, seconds)) {
  couch181(pos, u_time, audio, color);
  } else if (my_time < S(220.0, seconds)) {
  couch182(pos, u_time, audio, color);			// simple but i like it:noh
  } else if (my_time < S(221.0, seconds)) {
  couch183(pos, u_time, audio, color);
  } else if (my_time < S(222.0, seconds)) {
  couch184(pos, u_time, audio, color);
  } else if (my_time < S(223.0, seconds)) {
  couch185(pos, u_time, audio, color);
  } else if (my_time < S(224.0, seconds)) {
  couch186(pos, u_time, audio, color);
  } else if (my_time < S(225.0, seconds)) {
  couch187(pos, u_time, audio, color);
  } else if (my_time < S(226.0, seconds)) {
  couch188(pos, u_time, audio, color);
  } else if (my_time < S(227.0, seconds)) {
  couch189(pos, u_time, audio, color);
  } else if (my_time < S(228.0, seconds)) {
  couch190(pos, u_time, audio, color);
  } else if (my_time < S(229.0, seconds)) {
  couch191(pos, u_time, audio, color);
  } else if (my_time < S(230.0, seconds)) {
  couch192(pos, u_time, audio, color);
  } else if (my_time < S(231.0, seconds)) {
  couch193(pos, u_time, audio, color);
  } else if (my_time < S(232.0, seconds)) {
  couch194(pos, u_time, audio, color);
  } else if (my_time < S(233.0, seconds)) {
  couch195(pos, u_time, audio, color);
  } else if (my_time < S(234.0, seconds)) {
  couch196(pos, u_time, audio, color);
  } else if (my_time < S(235.0, seconds)) {
  couch197(pos, u_time, audio, color);
  } else if (my_time < S(236.0, seconds)) {
  couch198(pos, u_time, audio, color);
  } else if (my_time < S(237.0, seconds)) {
  couch199(pos, u_time, audio, color);
  } else if (my_time < S(238.0, seconds)) {
  couch200(pos, u_time, audio, color);
  } else if (my_time < S(239.0, seconds)) {
  couch201(pos, u_time, audio, color);
  } else if (my_time < S(240.0, seconds)) {
  couch202(pos, u_time, audio, color);
  } else if (my_time < S(241.0, seconds)) {
  couch203(pos, u_time, audio, color);
  } else if (my_time < S(242.0, seconds)) {
  couch204(pos, u_time, audio, color);
  } else if (my_time < S(243.0, seconds)) {
  couch205(pos, u_time, audio, color);
  } else if (my_time < S(244.0, seconds)) {
  couch206(pos, u_time, audio, color);
  } else if (my_time < S(245.0, seconds)) {
  couch207(pos, u_time, audio, color);
  } else if (my_time < S(246.0, seconds)) {
  couch208(pos, u_time, audio, color);
  } else if (my_time < S(247.0, seconds)) {
  couch209(pos, u_time, audio, color);
  } else if (my_time < S(248.0, seconds)) {
  couch210(pos, u_time, audio, color);
  } else if (my_time < S(249.0, seconds)) {
  couch211(pos, u_time, audio, color);
  } else if (my_time < S(250.0, seconds)) {
  couch212(pos, u_time, audio, color);
  } else if (my_time < S(251.0, seconds)) {
  couch212(pos, u_time, audio, color);
  } else if (my_time < S(252.0, seconds)) {
  couch213(pos, u_time, audio, color);
  } else if (my_time < S(253.0, seconds)) {
  couch214(pos, u_time, audio, color);
  } else if (my_time < S(254.0, seconds)) {
  couch215(pos, u_time, audio, color);
  } else if (my_time < S(255.0, seconds)) {
  couch216(pos, u_time, audio, color);
  } else if (my_time < S(256.0, seconds)) {
  couch217(pos, u_time, audio, color);
  } else if (my_time < S(257.0, seconds)) {
  couch218(pos, u_time, audio, color);
  } else if (my_time < S(258.0, seconds)) {
  couch219(pos, u_time, audio, color);
  } else if (my_time < S(259.0, seconds)) {
  couch220(pos, u_time, audio, color);
  } else if (my_time < S(260.0, seconds)) {
  couch221(pos, u_time, audio, color);
  } else if (my_time < S(261.0, seconds)) {
  couch222(pos, u_time, audio, color);
  } else if (my_time < S(262.0, seconds)) {
  couch223(pos, u_time, audio, color);
  } else if (my_time < S(263.0, seconds)) {
  couch1(pos, u_time, audio, color);
  } else {
  couch1(pos, u_time, audio, color);
  }
}

void couch_manual(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // couch_0(pos, u_time, audio, color);
  // couch2(pos, u_time, audio, color);
  // couch3(pos, u_time, audio, color);
  // couch4(pos, u_time, audio, color);
  // couch5(pos, u_time, audio, color);
  // couch6(pos, u_time, audio, color);
  // couch7(pos, u_time, audio, color);      // H
  // couch8(pos, u_time, audio, color);      // H
  couch9(pos, u_time, audio, color);        // H
  // couch10(pos, u_time, audio, color);     // HH
  // couch11(pos, u_time, audio, color);
  // couch12(pos, u_time, audio, color);
  // couch13(pos, u_time, audio, color);
  // couch14(pos, u_time, audio, color);
  // couch15(pos, u_time, audio, color);
  // couch16(pos, u_time, audio, color);     // HHH
  // couch17(pos, u_time, audio, color);      // HHH
  // couch18(pos, u_time, audio, color);
  // couch23(pos, u_time, audio, color);
  // couch24(pos, u_time, audio, color);
  // couch25(pos, u_time, audio, color);
  // couch26(pos, u_time, audio, color);     // H
  // couch27(pos, u_time, audio, color);
  // couch28(pos, u_time, audio, color);     // H
  // couch29(pos, u_time, audio, color);       // H
  // couch30(pos, u_time, audio, color);
  // couch40(pos, u_time, audio, color);
  // couch41(pos, u_time, audio, color);
  couch42(pos, u_time, audio, color);		// i like this one a lot
  // couch43(pos, u_time, audio, color);
  // couch44(pos, u_time, audio, color);
  // couch45(pos, u_time, audio, color);
  // couch46(pos, u_time, audio, color);
  // couch47(pos, u_time, audio, color);
  // couch48(pos, u_time, audio, color);
  // couch49(pos, u_time, audio, color);
  // couch50(pos, u_time, audio, color);
  // couch51(pos, u_time, audio, color);
  // couch52(pos, u_time, audio, color);
  // couch53(pos, u_time, audio, color);
  // couch54(pos, u_time, audio, color);
  // couch55(pos, u_time, audio, color);
  // couch56(pos, u_time, audio, color);
  // couch57(pos, u_time, audio, color);
  // couch58(pos, u_time, audio, color);
  // couch59(pos, u_time, audio, color);
  // couch60(pos, u_time, audio, color);
  // couch61(pos, u_time, audio, color);
  // couch62(pos, u_time, audio, color);
  // couch63(pos, u_time, audio, color);
  // couch64(pos, u_time, audio, color);
  // couch65(pos, u_time, audio, color);
  // couch66(pos, u_time, audio, color);
  // couch67(pos, u_time, audio, color);
  // couch68(pos, u_time, audio, color);
  // couch69(pos, u_time, audio, color);
  // couch70(pos, u_time, audio, color);
  // couch71(pos, u_time, audio, color);
  // couch72(pos, u_time, audio, color);
  // couch73(pos, u_time, audio, color);
  // couch74(pos, u_time, audio, color);
  // couch75(pos, u_time, audio, color);
  // couch76(pos, u_time, audio, color);
  // couch77(pos, u_time, audio, color);
  // couch78(pos, u_time, audio, color);
  // couch79(pos, u_time, audio, color);
  // couch80(pos, u_time, audio, color);
  // couch81(pos, u_time, audio, color);
  // couch82(pos, u_time, audio, color);
  // couch83(pos, u_time, audio, color);
  // couch84(pos, u_time, audio, color);
  // couch85(pos, u_time, audio, color);
  // couch86(pos, u_time, audio, color);
  // couch87(pos, u_time, audio, color);
  // couch88(pos, u_time, audio, color);
  // couch89(pos, u_time, audio, color);
  // couch90(pos, u_time, audio, color);
  // couch91(pos, u_time, audio, color);
  // couch92(pos, u_time, audio, color);
  // couch93(pos, u_time, audio, color);
  // couch94(pos, u_time, audio, color);
  // couch95(pos, u_time, audio, color);
  // couch96(pos, u_time, audio, color);
  // couch97(pos, u_time, audio, color);
  // couch98(pos, u_time, audio, color);
  // couch99(pos, u_time, audio, color);
  // couch100(pos, u_time, audio, color);
  // couch101(pos, u_time, audio, color);
  // couch102(pos, u_time, audio, color);
  // couch103(pos, u_time, audio, color);
  // couch104(pos, u_time, audio, color);
  // couch105(pos, u_time, audio, color);
  // couch106(pos, u_time, audio, color);
  // couch107(pos, u_time, audio, color);
  // couch108(pos, u_time, audio, color);
  // couch109(pos, u_time, audio, color);
  // couch110(pos, u_time, audio, color);
  // couch111(pos, u_time, audio, color);
  // couch112(pos, u_time, audio, color);
  // couch113(pos, u_time, audio, color);
  // couch114(pos, u_time, audio, color);
  // couch115(pos, u_time, audio, color);
  // couch116(pos, u_time, audio, color);
  // couch117(pos, u_time, audio, color);
  // couch118(pos, u_time, audio, color);
  // couch119(pos, u_time, audio, color);
  // couch120(pos, u_time, audio, color);
  // couch121(pos, u_time, audio, color);
  // couch122(pos, u_time, audio, color);
  // couch123(pos, u_time, audio, color);
  // couch124(pos, u_time, audio, color);
  // couch125(pos, u_time, audio, color);
  // couch126(pos, u_time, audio, color);
  // couch127(pos, u_time, audio, color);
  // couch128(pos, u_time, audio, color);
  // couch129(pos, u_time, audio, color);
  // couch130(pos, u_time, audio, color);		// i like this one a lot, yeah thats cool
  // couch131(pos, u_time, audio, color);
  // couch132(pos, u_time, audio, color);
  // couch133(pos, u_time, audio, color);
  // couch134(pos, u_time, audio, color);
  // couch135(pos, u_time, audio, color);
  // couch136(pos, u_time, audio, color);
  // couch137(pos, u_time, audio, color);
  // couch138(pos, u_time, audio, color);
  // couch139(pos, u_time, audio, color);
  // couch140(pos, u_time, audio, color);
  // couch141(pos, u_time, audio, color);
  // couch142(pos, u_time, audio, color);
  // couch143(pos, u_time, audio, color);
  // couch144(pos, u_time, audio, color);
  // couch145(pos, u_time, audio, color);
  // couch146(pos, u_time, audio, color);
  // couch147(pos, u_time, audio, color);
  // couch148(pos, u_time, audio, color);
  // couch149(pos, u_time, audio, color);
  // couch150(pos, u_time, audio, color);
  // couch151(pos, u_time, audio, color);			// i like this one
  // couch152(pos, u_time, audio, color);
  // couch153(pos, u_time, audio, color);
  // couch154(pos, u_time, audio, color);
  // couch155(pos, u_time, audio, color);
  // couch156(pos, u_time, audio, color);
  // couch157(pos, u_time, audio, color);
  // couch158(pos, u_time, audio, color);
  // couch159(pos, u_time, audio, color);
  // couch160(pos, u_time, audio, color);
  // couch161(pos, u_time, audio, color);
  // couch162(pos, u_time, audio, color);
  // couch163(pos, u_time, audio, color);
  // couch164(pos, u_time, audio, color);
  // couch165(pos, u_time, audio, color);
  // couch166(pos, u_time, audio, color);
  // couch167(pos, u_time, audio, color);
  // couch168(pos, u_time, audio, color);
  // couch169(pos, u_time, audio, color);
  // couch170(pos, u_time, audio, color);
  // couch171(pos, u_time, audio, color);
  // couch172(pos, u_time, audio, color);
  // couch173(pos, u_time, audio, color);
  // couch174(pos, u_time, audio, color);
  // couch175(pos, u_time, audio, color);
  // couch176(pos, u_time, audio, color);
  // couch177(pos, u_time, audio, color);
  // couch178(pos, u_time, audio, color);
  // couch179(pos, u_time, audio, color);
  // couch180(pos, u_time, audio, color);
  // couch181(pos, u_time, audio, color);
  // couch182(pos, u_time, audio, color);			// simple but i like it:noh
  // couch183(pos, u_time, audio, color);
  // couch184(pos, u_time, audio, color);
  // couch185(pos, u_time, audio, color);
  // couch186(pos, u_time, audio, color);
  // couch187(pos, u_time, audio, color);
  // couch188(pos, u_time, audio, color);
  // couch189(pos, u_time, audio, color);
  // couch190(pos, u_time, audio, color);
  // couch191(pos, u_time, audio, color);
  // couch192(pos, u_time, audio, color);
  // couch193(pos, u_time, audio, color);
  // couch194(pos, u_time, audio, color);
  // couch195(pos, u_time, audio, color);
  // couch196(pos, u_time, audio, color);
  // couch197(pos, u_time, audio, color);
  // couch198(pos, u_time, audio, color);
  // couch199(pos, u_time, audio, color);
  // couch200(pos, u_time, audio, color);
  // couch201(pos, u_time, audio, color);
  // couch202(pos, u_time, audio, color);
  // couch203(pos, u_time, audio, color);
  // couch204(pos, u_time, audio, color);
  // couch205(pos, u_time, audio, color);
  // couch206(pos, u_time, audio, color);
  // couch207(pos, u_time, audio, color);
  // couch208(pos, u_time, audio, color);
  // couch209(pos, u_time, audio, color);
  // couch210(pos, u_time, audio, color);
  // couch211(pos, u_time, audio, color);
  // couch212(pos, u_time, audio, color);
  // couch212(pos, u_time, audio, color);
  // couch213(pos, u_time, audio, color);
  // couch214(pos, u_time, audio, color);
  // couch215(pos, u_time, audio, color);
  // couch216(pos, u_time, audio, color);
  // couch217(pos, u_time, audio, color);
  // couch218(pos, u_time, audio, color);
  // couch219(pos, u_time, audio, color);
  // couch220(pos, u_time, audio, color);
  // couch221(pos, u_time, audio, color);
  // couch222(pos, u_time, audio, color);
  // couch223(pos, u_time, audio, color);
  // couch1(pos, u_time, audio, color); // HHH
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  // float seconds = 5.0;
  // couch_auto(pos, u_time, audio, color, seconds);

  couch_manual(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
