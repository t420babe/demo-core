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

#define S(min) min * 5.0

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);


  //
  // // wood_bb_red_tan_noise(pos, u_time, audio, color);
  // if (u_time < S(1.0)) {
  //   couch224(pos, u_time, audio, color);
  // } else if (u_time < S(2.0)) {
  //   doppler_step_pink_yellow(pos, u_time, audio, color);
  // } else if (u_time < S(3.0)) {
  //   wood_bb_hexagon_0(pos, u_time, audio, color);
  // } else if (u_time < S(4.0)) {
  //
  // } else if (u_time < S(5.0)) {
  //
  // } else if (u_time < S(6.0)) {
  // wood_bb_red_tan_noise(pos, u_time, audio, color);
  // } else if (u_time < S(7.0)) {
  // wood_bb_red_noise(pos, u_time, audio, color);
  // } else if (u_time < S(8.0)) {
  // wbl_wood(pos, u_time, audio, color);
  // } else if (u_time < S(9.0)) {
  // wbl2_wood(pos, u_time, audio, color);
  // } else if (u_time < S(10.0)) {
  // wbl3_wood(pos, u_time, audio, color);
  // } else if (u_time < S(11.0)) {
  // wbl4_wood(pos, u_time, audio, color);
  // } else if (u_time < S(12.0)) {
  // caterpillar(pos, u_time, audio, color);
  // } else if (u_time < S(13.0)) {
  // wbl5_wood(pos, u_time, audio, color);
  // } else if (u_time < S(14.0)) {
  // wbl5b_wood(pos, u_time, audio, color);
  // } else if (u_time < S(15.0)) {
  // wbl5c_wood(pos, u_time, audio, color);
  // } else if (u_time < S(16.0)) {
  // wbl5d_wood(pos, u_time, audio, color);
  // } else if (u_time < S(17.0)) {
  // wbl6_wood(pos, u_time, audio, color);
  // } else if (u_time < S(18.0)) {
  // wbl7_wood(pos, u_time, audio, color);
  // } else if (u_time < S(19.0)) {
  // wbl8_wood(pos, u_time, audio, color);
  // } else if (u_time < S(20.0)) {
  // ridge_1_main(pos, u_time, audio, color);
  // } else if (u_time < S(21.0)) {
  // alligator(pos, u_time, audio, color);
  // } else if (u_time < S(22.0)) {
  // r1a_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(23.0)) {
  // r2_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(24.0)) {
  // r3_ridge_main(pos, u_time, audio, color);       // rly trippy alien, Mi Mujer
  // } else if (u_time < S(25.0)) {
  // r4_ridge_main(pos, u_time, audio, color);       // love this but need to encorpoate audio with some color changes more
  // } else if (u_time < S(26.0)) {
  // r5_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(27.0)) {
  // r6_ridge_main(pos, u_time, audio, color);       // yes yes yes! Something to Say - Holow
  // } else if (u_time < S(28.0)) {
  // r7_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(29.0)) {
  // r8_ridge_main(pos, u_time, audio, color);     // oh thats a fun one
  // } else if (u_time < S(30.0)) {
  // r9_ridge_main(pos, u_time, audio, color);     // works well with low qmetro rate, ~60 - 100 ms, 70ms i like rn, song: Warrior, Aluna
  // } else if (u_time < S(31.0)) {
  // r10_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(32.0)) {
  // r11_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(33.0)) {
  // r12_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(34.0)) {
  // r13_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(35.0)) {
  // r14_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(36.0)) {
  // r15_ridge_main(pos, u_time, audio, color);        // needs LOW qmetro ~5-10. i like 10nm rn   - This Girl (Kungs Vs Cookin' On 3 Burners) - Extended
  // } else if (u_time < S(37.0)) {
  // r16_ridge_main(pos, u_time, audio, color);          // needs  30ms on qmetro
  // } else if (u_time < S(38.0)) {
  // r17_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(39.0)) {
  // r18_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(40.0)) {
  // r19_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(41.0)) {
  // r20_ridge_main(pos, u_time, audio, color);   // yes yes yeh! I Feel So Band - The Kungs
  // } else if (u_time < S(42.0)) {
  // r21_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(43.0)) {
  // r22_ridge_main(pos, u_time, audio, color);      // 60 ms on qmetro
  // } else if (u_time < S(44.0)) {
  // r23_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(45.0)) {
  // r24_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(46.0)) {
  // r25_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(47.0)) {
  // r26_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(48.0)) {
  // r27_ridge_main(pos, u_time, audio, color);
  // } else if (u_time < S(49.0)) {
  // couch_0(pos, u_time, audio, color);
  // } else if (u_time < S(50.0)) {
  // couch2(pos, u_time, audio, color);
  // } else if (u_time < S(51.0)) {
  // couch3(pos, u_time, audio, color);
  // } else if (u_time < S(52.0)) {
  // couch4(pos, u_time, audio, color);
  // } else if (u_time < S(53.0)) {
  // couch5(pos, u_time, audio, color);
  // } else if (u_time < S(54.0)) {
  // couch6(pos, u_time, audio, color);
  // } else if (u_time < S(55.0)) {
  // couch7(pos, u_time, audio, color);
  // } else if (u_time < S(56.0)) {
  // couch8(pos, u_time, audio, color);
  // } else if (u_time < S(57.0)) {
  // couch9(pos, u_time, audio, color);
  // } else if (u_time < S(58.0)) {
  // couch10(pos, u_time, audio, color);
  // } else if (u_time < S(59.0)) {
  // couch11(pos, u_time, audio, color);
  // } else if (u_time < S(60.0)) {
  // couch12(pos, u_time, audio, color);
  // } else if (u_time < S(61.0)) {
  // couch13(pos, u_time, audio, color);
  // } else if (u_time < S(62.0)) {
  // couch14(pos, u_time, audio, color);
  // } else if (u_time < S(63.0)) {
  // couch15(pos, u_time, audio, color);
  // } else if (u_time < S(64.0)) {
  // couch16(pos, u_time, audio, color);
  // } else if (u_time < S(65.0)) {
  // couch17(pos, u_time, audio, color);
  // } else if (u_time < S(66.0)) {
  // couch18(pos, u_time, audio, color);
  // } else if (u_time < S(67.0)) {
  // couch19(pos, u_time, audio, color);
  // } else if (u_time < S(68.0)) {
  // couch20(pos, u_time, audio, color);
  // } else if (u_time < S(69.0)) {
  // couch21(pos, u_time, audio, color);
  // } else if (u_time < S(70.0)) {
  // couch22(pos, u_time, audio, color);
  // } else if (u_time < S(71.0)) {
  // couch23(pos, u_time, audio, color);
  // } else if (u_time < S(72.0)) {
  // couch24(pos, u_time, audio, color);
  // } else if (u_time < S(73.0)) {
  // couch25(pos, u_time, audio, color);
  // } else if (u_time < S(74.0)) {
  // couch26(pos, u_time, audio, color);
  // } else if (u_time < S(75.0)) {
  // couch27(pos, u_time, audio, color);
  // } else if (u_time < S(76.0)) {
  // couch28(pos, u_time, audio, color);
  // } else if (u_time < S(77.0)) {
  // couch29(pos, u_time, audio, color);
  // } else if (u_time < S(78.0)) {
  // couch30(pos, u_time, audio, color);
  // } else if (u_time < S(79.0)) {
  // couch31(pos, u_time, audio, color);
  // } else if (u_time < S(80.0)) {
  // couch32(pos, u_time, audio, color);
  // } else if (u_time < S(81.0)) {
  // couch33(pos, u_time, audio, color);
  // } else if (u_time < S(82.0)) {
  // couch34(pos, u_time, audio, color);
  // } else if (u_time < S(83.0)) {
  // couch35(pos, u_time, audio, color);
  // } else if (u_time < S(84.0)) {
  // couch36(pos, u_time, audio, color);
  // } else if (u_time < S(85.0)) {
  // couch37(pos, u_time, audio, color);
  // } else if (u_time < S(86.0)) {
  // couch38(pos, u_time, audio, color);
  // } else if (u_time < S(87.0)) {
  // couch39(pos, u_time, audio, color);
  // } else if (u_time < S(88.0)) {
  // couch40(pos, u_time, audio, color);
  // } else if (u_time < S(89.0)) {
  // couch41(pos, u_time, audio, color);
  // } else if (u_time < S(90.0)) {
  // couch42(pos, u_time, audio, color);		// i like this one a lot
  // } else if (u_time < S(91.0)) {
  // couch43(pos, u_time, audio, color);
  // } else if (u_time < S(92.0)) {
  // couch44(pos, u_time, audio, color);
  // } else if (u_time < S(93.0)) {
  // couch45(pos, u_time, audio, color);
  // } else if (u_time < S(94.0)) {
  // couch46(pos, u_time, audio, color);
  // } else if (u_time < S(95.0)) {
  // couch47(pos, u_time, audio, color);
  // } else if (u_time < S(96.0)) {
  // couch48(pos, u_time, audio, color);
  // } else if (u_time < S(97.0)) {
  // couch49(pos, u_time, audio, color);
  // } else if (u_time < S(98.0)) {
  // couch50(pos, u_time, audio, color);
  // } else if (u_time < S(99.0)) {
  // couch51(pos, u_time, audio, color);
  // } else if (u_time < S(100.0)) {
  // couch52(pos, u_time, audio, color);
  // } else if (u_time < S(101.0)) {
  // couch53(pos, u_time, audio, color);
  // } else if (u_time < S(102.0)) {
  // couch54(pos, u_time, audio, color);
  // } else if (u_time < S(103.0)) {
  // couch55(pos, u_time, audio, color);
  // } else if (u_time < S(104.0)) {
  // couch56(pos, u_time, audio, color);
  // } else if (u_time < S(105.0)) {
  // couch57(pos, u_time, audio, color);
  // } else if (u_time < S(106.0)) {
  // couch58(pos, u_time, audio, color);
  // } else if (u_time < S(107.0)) {
  // couch59(pos, u_time, audio, color);
  // } else if (u_time < S(108.0)) {
  // couch60(pos, u_time, audio, color);
  // } else if (u_time < S(109.0)) {
  // couch61(pos, u_time, audio, color);
  // } else if (u_time < S(110.0)) {
  // couch62(pos, u_time, audio, color);
  // } else if (u_time < S(111.0)) {
  // couch63(pos, u_time, audio, color);
  // } else if (u_time < S(112.0)) {
  // couch64(pos, u_time, audio, color);
  // } else if (u_time < S(113.0)) {
  // couch65(pos, u_time, audio, color);
  // } else if (u_time < S(114.0)) {
  // couch66(pos, u_time, audio, color);
  // } else if (u_time < S(115.0)) {
  // couch67(pos, u_time, audio, color);
  // } else if (u_time < S(116.0)) {
  // couch68(pos, u_time, audio, color);
  // } else if (u_time < S(117.0)) {
  // couch69(pos, u_time, audio, color);
  // } else if (u_time < S(118.0)) {
  // couch70(pos, u_time, audio, color);
  // } else if (u_time < S(119.0)) {
  // couch71(pos, u_time, audio, color);
  // } else if (u_time < S(120.0)) {
  // couch72(pos, u_time, audio, color);
  // } else if (u_time < S(121.0)) {
  // couch73(pos, u_time, audio, color);
  // } else if (u_time < S(122.0)) {
  // couch74(pos, u_time, audio, color);
  // } else if (u_time < S(123.0)) {
  // couch75(pos, u_time, audio, color);
  // } else if (u_time < S(124.0)) {
  // couch76(pos, u_time, audio, color);
  // } else if (u_time < S(125.0)) {
  // couch77(pos, u_time, audio, color);
  // } else if (u_time < S(126.0)) {
  // couch78(pos, u_time, audio, color);
  // } else if (u_time < S(127.0)) {
  // couch79(pos, u_time, audio, color);
  // } else if (u_time < S(128.0)) {
  // couch80(pos, u_time, audio, color);
  // } else if (u_time < S(129.0)) {
  // couch81(pos, u_time, audio, color);
  // } else if (u_time < S(130.0)) {
  // couch82(pos, u_time, audio, color);
  // } else if (u_time < S(131.0)) {
  // couch83(pos, u_time, audio, color);
  // } else if (u_time < S(132.0)) {
  // couch84(pos, u_time, audio, color);
  // } else if (u_time < S(133.0)) {
  // couch85(pos, u_time, audio, color);
  // } else if (u_time < S(134.0)) {
  // couch86(pos, u_time, audio, color);
  // } else if (u_time < S(135.0)) {
  // couch87(pos, u_time, audio, color);
  // } else if (u_time < S(136.0)) {
  // couch88(pos, u_time, audio, color);
  // } else if (u_time < S(137.0)) {
  // couch89(pos, u_time, audio, color);
  // } else if (u_time < S(138.0)) {
  // couch90(pos, u_time, audio, color);
  // } else if (u_time < S(139.0)) {
  // couch91(pos, u_time, audio, color);
  // } else if (u_time < S(140.0)) {
  // couch92(pos, u_time, audio, color);
  // } else if (u_time < S(141.0)) {
  // couch93(pos, u_time, audio, color);
  // } else if (u_time < S(142.0)) {
  // couch94(pos, u_time, audio, color);
  // } else if (u_time < S(143.0)) {
  // couch95(pos, u_time, audio, color);
  // } else if (u_time < S(144.0)) {
  // couch96(pos, u_time, audio, color);
  // } else if (u_time < S(145.0)) {
  // couch97(pos, u_time, audio, color);
  // } else if (u_time < S(146.0)) {
  // couch98(pos, u_time, audio, color);
  // } else if (u_time < S(147.0)) {
  // couch99(pos, u_time, audio, color);
  // } else if (u_time < S(148.0)) {
  // couch100(pos, u_time, audio, color);
  // } else if (u_time < S(149.0)) {
  // couch101(pos, u_time, audio, color);
  // } else if (u_time < S(150.0)) {
  // couch102(pos, u_time, audio, color);
  // } else if (u_time < S(151.0)) {
  // couch103(pos, u_time, audio, color);
  // } else if (u_time < S(152.0)) {
  // couch104(pos, u_time, audio, color);
  // } else if (u_time < S(153.0)) {
  // couch105(pos, u_time, audio, color);
  // } else if (u_time < S(154.0)) {
  // couch106(pos, u_time, audio, color);
  // } else if (u_time < S(155.0)) {
  // couch107(pos, u_time, audio, color);
  // } else if (u_time < S(156.0)) {
  // couch108(pos, u_time, audio, color);
  // } else if (u_time < S(157.0)) {
  // couch109(pos, u_time, audio, color);
  // } else if (u_time < S(158.0)) {
  // couch110(pos, u_time, audio, color);
  // } else if (u_time < S(159.0)) {
  // couch111(pos, u_time, audio, color);
  // } else if (u_time < S(160.0)) {
  // couch112(pos, u_time, audio, color);
  // } else if (u_time < S(161.0)) {
  // couch113(pos, u_time, audio, color);
  // } else if (u_time < S(162.0)) {
  // couch114(pos, u_time, audio, color);
  // } else if (u_time < S(163.0)) {
  // couch115(pos, u_time, audio, color);
  // } else if (u_time < S(164.0)) {
  // couch116(pos, u_time, audio, color);
  // } else if (u_time < S(165.0)) {
  // couch117(pos, u_time, audio, color);
  // } else if (u_time < S(166.0)) {
  // couch118(pos, u_time, audio, color);
  // } else if (u_time < S(167.0)) {
  // couch119(pos, u_time, audio, color);
  // } else if (u_time < S(168.0)) {
  // couch120(pos, u_time, audio, color);
  // } else if (u_time < S(169.0)) {
  // couch121(pos, u_time, audio, color);
  // } else if (u_time < S(170.0)) {
  // couch122(pos, u_time, audio, color);
  // } else if (u_time < S(171.0)) {
  // couch123(pos, u_time, audio, color);
  // } else if (u_time < S(172.0)) {
  // couch124(pos, u_time, audio, color);
  // } else if (u_time < S(173.0)) {
  // couch125(pos, u_time, audio, color);
  // } else if (u_time < S(174.0)) {
  // couch126(pos, u_time, audio, color);
  // } else if (u_time < S(175.0)) {
  // couch127(pos, u_time, audio, color);
  // } else if (u_time < S(176.0)) {
  // couch128(pos, u_time, audio, color);
  // } else if (u_time < S(177.0)) {
  // couch129(pos, u_time, audio, color);
  // } else if (u_time < S(178.0)) {
  // couch130(pos, u_time, audio, color);		// i like this one a lot, yeah thats cool
  // } else if (u_time < S(179.0)) {
  // couch131(pos, u_time, audio, color);
  // } else if (u_time < S(180.0)) {
  // couch132(pos, u_time, audio, color);
  // } else if (u_time < S(181.0)) {
  // couch133(pos, u_time, audio, color);
  // } else if (u_time < S(182.0)) {
  // couch134(pos, u_time, audio, color);
  // } else if (u_time < S(183.0)) {
  // couch135(pos, u_time, audio, color);
  // } else if (u_time < S(184.0)) {
  // couch136(pos, u_time, audio, color);
  // } else if (u_time < S(185.0)) {
  // couch137(pos, u_time, audio, color);
  // } else if (u_time < S(186.0)) {
  // couch138(pos, u_time, audio, color);
  // } else if (u_time < S(187.0)) {
  // couch139(pos, u_time, audio, color);
  // } else if (u_time < S(188.0)) {
  // couch140(pos, u_time, audio, color);
  // } else if (u_time < S(189.0)) {
  // couch141(pos, u_time, audio, color);
  // } else if (u_time < S(190.0)) {
  // couch142(pos, u_time, audio, color);
  // } else if (u_time < S(191.0)) {
  // couch143(pos, u_time, audio, color);
  // } else if (u_time < S(192.0)) {
  // couch144(pos, u_time, audio, color);
  // } else if (u_time < S(193.0)) {
  // couch145(pos, u_time, audio, color);
  // } else if (u_time < S(194.0)) {
  // couch146(pos, u_time, audio, color);
  // } else if (u_time < S(195.0)) {
  // couch147(pos, u_time, audio, color);
  // } else if (u_time < S(196.0)) {
  // couch148(pos, u_time, audio, color);
  // } else if (u_time < S(197.0)) {
  // couch149(pos, u_time, audio, color);
  // } else if (u_time < S(198.0)) {
  // couch150(pos, u_time, audio, color);
  // } else if (u_time < S(199.0)) {
  // couch151(pos, u_time, audio, color);			// i like this one
  // } else if (u_time < S(200.0)) {
  // couch152(pos, u_time, audio, color);
  // } else if (u_time < S(201.0)) {
  // couch153(pos, u_time, audio, color);
  // } else if (u_time < S(202.0)) {
  // couch154(pos, u_time, audio, color);
  // } else if (u_time < S(203.0)) {
  // couch155(pos, u_time, audio, color);
  // } else if (u_time < S(204.0)) {
  // couch156(pos, u_time, audio, color);
  // } else if (u_time < S(205.0)) {
  // couch157(pos, u_time, audio, color);
  // } else if (u_time < S(206.0)) {
  // couch158(pos, u_time, audio, color);
  // } else if (u_time < S(207.0)) {
  // couch159(pos, u_time, audio, color);
  // } else if (u_time < S(208.0)) {
  // couch160(pos, u_time, audio, color);
  // } else if (u_time < S(209.0)) {
  // couch161(pos, u_time, audio, color);
  // } else if (u_time < S(210.0)) {
  // couch162(pos, u_time, audio, color);
  // } else if (u_time < S(211.0)) {
  // couch163(pos, u_time, audio, color);
  // } else if (u_time < S(212.0)) {
  // couch164(pos, u_time, audio, color);
  // } else if (u_time < S(213.0)) {
  // couch165(pos, u_time, audio, color);
  // } else if (u_time < S(214.0)) {
  // couch166(pos, u_time, audio, color);
  // } else if (u_time < S(215.0)) {
  // couch167(pos, u_time, audio, color);
  // } else if (u_time < S(216.0)) {
  // couch168(pos, u_time, audio, color);
  // } else if (u_time < S(217.0)) {
  // couch169(pos, u_time, audio, color);
  // } else if (u_time < S(218.0)) {
  // couch170(pos, u_time, audio, color);
  // } else if (u_time < S(219.0)) {
  // couch171(pos, u_time, audio, color);
  // } else if (u_time < S(220.0)) {
  // couch172(pos, u_time, audio, color);
  // } else if (u_time < S(221.0)) {
  // couch173(pos, u_time, audio, color);
  // } else if (u_time < S(222.0)) {
  // couch174(pos, u_time, audio, color);
  // } else if (u_time < S(223.0)) {
  // couch175(pos, u_time, audio, color);
  // } else if (u_time < S(224.0)) {
  // couch176(pos, u_time, audio, color);
  // } else if (u_time < S(225.0)) {
  // couch177(pos, u_time, audio, color);
  // } else if (u_time < S(226.0)) {
  // couch178(pos, u_time, audio, color);
  // } else if (u_time < S(227.0)) {
  // couch179(pos, u_time, audio, color);
  // } else if (u_time < S(228.0)) {
  // couch180(pos, u_time, audio, color);
  // } else if (u_time < S(229.0)) {
  // couch181(pos, u_time, audio, color);
  // } else if (u_time < S(220.0)) {
  // couch182(pos, u_time, audio, color);			// simple but i like it:noh
  // } else if (u_time < S(221.0)) {
  // couch183(pos, u_time, audio, color);
  // } else if (u_time < S(222.0)) {
  // couch184(pos, u_time, audio, color);
  // } else if (u_time < S(223.0)) {
  // couch185(pos, u_time, audio, color);
  // } else if (u_time < S(224.0)) {
  // couch186(pos, u_time, audio, color);
  // } else if (u_time < S(225.0)) {
  // couch187(pos, u_time, audio, color);
  // } else if (u_time < S(226.0)) {
  // couch188(pos, u_time, audio, color);
  // } else if (u_time < S(227.0)) {
  // couch189(pos, u_time, audio, color);
  // } else if (u_time < S(228.0)) {
  // couch190(pos, u_time, audio, color);
  // } else if (u_time < S(229.0)) {
  // couch191(pos, u_time, audio, color);
  // } else if (u_time < S(230.0)) {
  // couch192(pos, u_time, audio, color);
  // } else if (u_time < S(231.0)) {
  // couch193(pos, u_time, audio, color);
  // } else if (u_time < S(232.0)) {
  // couch194(pos, u_time, audio, color);
  // } else if (u_time < S(233.0)) {
  // couch195(pos, u_time, audio, color);
  // } else if (u_time < S(234.0)) {
  // couch196(pos, u_time, audio, color);
  // } else if (u_time < S(235.0)) {
  // couch197(pos, u_time, audio, color);
  // } else if (u_time < S(236.0)) {
  // couch198(pos, u_time, audio, color);
  // } else if (u_time < S(237.0)) {
  // couch199(pos, u_time, audio, color);
  // } else if (u_time < S(238.0)) {
  // couch200(pos, u_time, audio, color);
  // } else if (u_time < S(239.0)) {
  // couch201(pos, u_time, audio, color);
  // } else if (u_time < S(240.0)) {
  // couch202(pos, u_time, audio, color);
  // } else if (u_time < S(241.0)) {
  // couch203(pos, u_time, audio, color);
  // } else if (u_time < S(242.0)) {
  // couch204(pos, u_time, audio, color);
  // } else if (u_time < S(243.0)) {
  // couch205(pos, u_time, audio, color);
  // } else if (u_time < S(244.0)) {
  // couch206(pos, u_time, audio, color);
  // } else if (u_time < S(245.0)) {
  // couch207(pos, u_time, audio, color);
  // } else if (u_time < S(246.0)) {
  // couch208(pos, u_time, audio, color);
  // } else if (u_time < S(247.0)) {
  // couch209(pos, u_time, audio, color);
  // } else if (u_time < S(248.0)) {
  // couch210(pos, u_time, audio, color);
  // } else if (u_time < S(249.0)) {
  // couch211(pos, u_time, audio, color);
  // } else if (u_time < S(250.0)) {
  // couch212(pos, u_time, audio, color);
  // } else if (u_time < S(251.0)) {
  // couch212(pos, u_time, audio, color);
  // } else if (u_time < S(252.0)) {
  // couch213(pos, u_time, audio, color);
  // } else if (u_time < S(253.0)) {
  // couch214(pos, u_time, audio, color);
  // } else if (u_time < S(254.0)) {
  // couch215(pos, u_time, audio, color);
  // } else if (u_time < S(255.0)) {
  // couch216(pos, u_time, audio, color);
  // } else if (u_time < S(256.0)) {
  // couch217(pos, u_time, audio, color);
  // } else if (u_time < S(257.0)) {
  // couch218(pos, u_time, audio, color);
  // } else if (u_time < S(258.0)) {
  // couch219(pos, u_time, audio, color);
  // } else if (u_time < S(259.0)) {
  // couch220(pos, u_time, audio, color);
  // } else if (u_time < S(260.0)) {
  // couch221(pos, u_time, audio, color);
  // } else if (u_time < S(261.0)) {
  // couch222(pos, u_time, audio, color);
  // } else if (u_time < S(262.0)) {
  // couch223(pos, u_time, audio, color);
  // } else if (u_time < S(263.0)) {
  // couch1(pos, u_time, audio, color);
  // }

  // color = babydoyougetme_0(pos, u_time);
  // color = babydoyougetme_1(pos, u_time);
  // babydoyougetme_0_audio(pos, u_time, audio, color);


  // hypnotized_by_the_light(pos, u_time, audio, color);



  // color = rainbow_scales(pos, u_time);  // Superlove? add audio

  /* DONE */
  // sayin_sayin_digital_black_hole(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_cyan_square(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_cyan_square_og(pos, u_time, audio, color);
  // sayin_sayin_sliding(pos, u_time, audio, color);
  // sayin_sayin_sliding_in(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_0(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_1(pos, u_time, audio, color);
  // sayin_sayin_sliding_in_2(pos, u_time, audio, color);
  // sayin_sayin_deep_blue(pos, u_time, audio, color);
  // sayin_sayin_red(pos, u_time, audio, color);
  // sayin_sayin_break(pos, u_time, audio, color);
  // sayin_sayin_red_fracture(pos, u_time, audio, color);
  // sayin_sayin_blue_single_fracture(pos, u_time, audio, color);
  // sayin_sayin_blue_single_fracture_0(pos, u_time, audio, color);
  // sayin_sayin_blue_single_fracture_1(pos, u_time, audio, color);   // H favorite color combo
  // sayin_sayin_blue_single_fracture_2(pos, u_time, audio, color);   // H favorite color combo
  // sayin_sayin_dancing_blue_clock_0(pos, u_time, audio, color);
  // sayin_sayin_blue_clock_arrow_0(pos, u_time, audio, color);  // H, really cool, Techno Disco
  // sayin_sayin_blue_clock_og_0(pos, u_time, audio, color);
  // sayin_sayin_blue_wiggly_clock_og(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  // sayin_sayin_blue_wiggly_clock_og_0(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  // sayin_sayin_blue_wiggly_clock_og_1(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  // sayin_sayin_blue_wiggly_clock_og_2(pos, u_time, audio, color);    // H, thatsss cool, Techno Disco
  // sayin_sayin_blue_wiggly_clock_og_3(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  // sayin_sayin_blue_wiggly_clock_og_3b(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  // sayin_sayin_blue_wiggly_clock_og_3c(pos, u_time, audio, color);    // H, thatsss cool, Losing Your Mind
  //
  // x_box(pos, u_time, audio, color);
  // pink_purple_x_max_oval(pos, u_time, audio, color);
  // pink_purple_x_max(pos, u_time, audio, color);
  // pink_purple_x_max_0(pos, u_time, audio, color);
  // pink_purple_x_max_1(pos, u_time, audio, color); // Sosa
  // red_x_max(pos, u_time, audio, color);
  //
  // purple_concentric(pos, u_time, audio, color);      // All The Ladies - Fat Boy Slim
  // green_concentric(pos, u_time, audio, color);
  // purple_circle(pos, u_time, audio, color);
  // orange_circle_bright_purple_bg(pos, u_time, audio, color);
  //
  //
  // doppler_audio(pos, u_time, audio, color);       // Ba:sen Pool Party Dub Mix
  // doppler_blue_web(pos, u_time, audio, color);
  // doppler_sharp_heart(pos, u_time, audio, color);   // Warrior
  // doppler_rainbow_heart(pos, u_time, audio, color);   // Superlove

  // doppler_sofias_rainbow(pos, u_time, audio, color);    // Loverus -> change all audio ot bandpass for main part of song
  // doppler_red_red_sun(pos, u_time, audio, color);     // Heaven Can Wait Intro and Verse
  // doppler_green_rooster(pos, u_time, audio, color);       // Heaven Can Wait Chorus
  // doppler_sun_star_rooster(pos, u_time, audio, color);
  // doppler_blue_cross_spinning(pos, u_time, audio, color);
  // doppler_blue_cross(pos, u_time, audio, color);
  // doppler_blue_step_cross_horizontal(pos, u_time, audio, color);
  // doppler_blue_step_cross(pos, u_time, audio, color);
  // doppler_cross_step_1(pos, u_time, audio, color);
  // GOTTA GET BETTER COLORS FOR THE doppler_floating_X
  // doppler_floating_ring_morph(pos, u_time, audio, color);
  // doppler_floating_ring_morph_1(pos, u_time, audio, color);
  // doppler_cross_step_2(pos, u_time, audio, color);
  // doppler_cross_step_3(pos, u_time, audio, color);
  // doppler_cross_step_4(pos, u_time, audio, color);
  // doppler_cross_step_5(pos, u_time, audio, color);        // Back & Forth - Harris & Hurr
  // doppler_cross_step_6(pos, u_time, audio, color);
  // doppler_cross_step(pos, u_time, audio, color);
  // doppler_cross_step_0(pos, u_time, audio, color);
  // doppler_pink_blue_sand(pos, u_time, audio, color);
  // doppler_melting_square_glitch_fuck_with(pos, u_time, audio, color);    // meh
  // doppler_melting_square_glitch(pos, u_time, audio, color);
  // doppler_twisting_timer(pos, u_time, audio, color);
  // doppler_trippy_melting_diamond(pos, u_time, audio, color);
  // doppler_trippy_diamond(pos, u_time, audio, color);  // love
  // doppler_trippy_diamond_0(pos, u_time, audio, color);  // love
  // doppler_morph(pos, u_time, audio, color);
  // doppler_morph_0(pos, u_time, audio, color);   // superlove maybe
  // doppler_morph_1(pos, u_time, audio, color);
  // doppler_morph_2(pos, u_time, audio, color);

  // choppy_doppler_square_fractal_zoom_out(pos, u_time, audio, color);
  // choppy_doppler_square_fractal_zoom_out_0(pos, u_time, audio, color); // 4 The People
  // choppy_doppler_square_fractal_pulse(pos, u_time, audio, color);
  // plaid_choppy_glossy(pos, u_time, audio, color);
  // plaid_choppy_glossy_0(pos, u_time, audio, color);   // really like
  // choppy_glossy(pos, u_time, audio, color);
  // choppy_glossy_0(pos, u_time, audio, color);
  // flossy_glossy(pos, u_time, audio, color);
  // doppler_cross_plaid_glitch_0(pos, u_time, audio, color);    // Ada Lovelace
  // doppler_cross_plaid(pos, u_time, audio, color);    // Ada Lovelace
  // doppler_plaid(pos, u_time, audio, color); // Lone Digger - Caravan Palace
  // doppler_diamond_collide(pos, u_time, audio, color);
  // doppler_step_pink_blue(pos, u_time, audio, color);
  // doppler_step_pink_blue_0(pos, u_time, audio, color);
  // doppler_step_pink_yellow(pos, u_time, audio, color);
  // doppler_shaky_shaky(pos, u_time, audio, color);       // Ecstacy - Disclosure
  // doppler_shaky_shaky_0(pos, u_time, audio, color);       // Ecstacy - Disclosure
  // doppler_shaky_shaky_0b(pos, u_time, audio, color);       // Ecstacy - Disclosure
  // doppler_shaky_shaky_1(pos, u_time, audio, color);       // Ecstacy - Disclosure
  // doppler_shaky_shaky_2(pos, u_time, audio, color);       // Ecstacy - Disclosure
  // doppler_shaky_shaky_3(pos, u_time, audio, color);       // Ecstacy - Disclosure, oh yeah
  // doppler_shaky_blue(pos, u_time, audio, color);
  // doppler_blue_fights_pink(pos, u_time, audio, color);

  /* DONE */

  gl_FragColor = vec4(color, 1.0);
}
