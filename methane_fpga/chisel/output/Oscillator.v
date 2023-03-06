module methane.Oscillator(
  input         clock,
  input         reset,
  input         io_en,
  input  [31:0] io_freq,
  output [15:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] _holdTick_T = 32'h3b9aca / io_freq; // @[methane.Oscillator.scala 27:43]
  reg [31:0] holdTick; // @[methane.Oscillator.scala 27:27]
  reg [31:0] runTick; // @[methane.Oscillator.scala 28:26]
  reg [15:0] idx; // @[methane.Oscillator.scala 29:22]
  wire [31:0] _runTick_T_1 = runTick + 32'h1; // @[methane.Oscillator.scala 33:28]
  wire [15:0] _idx_T_1 = idx + 16'h1; // @[methane.Oscillator.scala 36:24]
  wire [15:0] _GEN_7 = 8'h1 == idx[7:0] ? $signed(16'sh1ea) : $signed(16'sh0); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_8 = 8'h2 == idx[7:0] ? $signed(16'sh3d5) : $signed(_GEN_7); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_9 = 8'h3 == idx[7:0] ? $signed(16'sh5bf) : $signed(_GEN_8); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_10 = 8'h4 == idx[7:0] ? $signed(16'sh7a8) : $signed(_GEN_9); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_11 = 8'h5 == idx[7:0] ? $signed(16'sh990) : $signed(_GEN_10); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_12 = 8'h6 == idx[7:0] ? $signed(16'shb76) : $signed(_GEN_11); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_13 = 8'h7 == idx[7:0] ? $signed(16'shd5b) : $signed(_GEN_12); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_14 = 8'h8 == idx[7:0] ? $signed(16'shf3d) : $signed(_GEN_13); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_15 = 8'h9 == idx[7:0] ? $signed(16'sh111e) : $signed(_GEN_14); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_16 = 8'ha == idx[7:0] ? $signed(16'sh12fb) : $signed(_GEN_15); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_17 = 8'hb == idx[7:0] ? $signed(16'sh14d6) : $signed(_GEN_16); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_18 = 8'hc == idx[7:0] ? $signed(16'sh16ad) : $signed(_GEN_17); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_19 = 8'hd == idx[7:0] ? $signed(16'sh1881) : $signed(_GEN_18); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_20 = 8'he == idx[7:0] ? $signed(16'sh1a51) : $signed(_GEN_19); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_21 = 8'hf == idx[7:0] ? $signed(16'sh1c1d) : $signed(_GEN_20); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_22 = 8'h10 == idx[7:0] ? $signed(16'sh1de5) : $signed(_GEN_21); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_23 = 8'h11 == idx[7:0] ? $signed(16'sh1fa8) : $signed(_GEN_22); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_24 = 8'h12 == idx[7:0] ? $signed(16'sh2167) : $signed(_GEN_23); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_25 = 8'h13 == idx[7:0] ? $signed(16'sh2320) : $signed(_GEN_24); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_26 = 8'h14 == idx[7:0] ? $signed(16'sh24d3) : $signed(_GEN_25); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_27 = 8'h15 == idx[7:0] ? $signed(16'sh2681) : $signed(_GEN_26); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_28 = 8'h16 == idx[7:0] ? $signed(16'sh282a) : $signed(_GEN_27); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_29 = 8'h17 == idx[7:0] ? $signed(16'sh29cb) : $signed(_GEN_28); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_30 = 8'h18 == idx[7:0] ? $signed(16'sh2b67) : $signed(_GEN_29); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_31 = 8'h19 == idx[7:0] ? $signed(16'sh2cfc) : $signed(_GEN_30); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_32 = 8'h1a == idx[7:0] ? $signed(16'sh2e89) : $signed(_GEN_31); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_33 = 8'h1b == idx[7:0] ? $signed(16'sh3010) : $signed(_GEN_32); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_34 = 8'h1c == idx[7:0] ? $signed(16'sh318f) : $signed(_GEN_33); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_35 = 8'h1d == idx[7:0] ? $signed(16'sh3307) : $signed(_GEN_34); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_36 = 8'h1e == idx[7:0] ? $signed(16'sh3477) : $signed(_GEN_35); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_37 = 8'h1f == idx[7:0] ? $signed(16'sh35de) : $signed(_GEN_36); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_38 = 8'h20 == idx[7:0] ? $signed(16'sh373e) : $signed(_GEN_37); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_39 = 8'h21 == idx[7:0] ? $signed(16'sh3894) : $signed(_GEN_38); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_40 = 8'h22 == idx[7:0] ? $signed(16'sh39e3) : $signed(_GEN_39); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_41 = 8'h23 == idx[7:0] ? $signed(16'sh3b28) : $signed(_GEN_40); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_42 = 8'h24 == idx[7:0] ? $signed(16'sh3c64) : $signed(_GEN_41); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_43 = 8'h25 == idx[7:0] ? $signed(16'sh3d96) : $signed(_GEN_42); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_44 = 8'h26 == idx[7:0] ? $signed(16'sh3ec0) : $signed(_GEN_43); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_45 = 8'h27 == idx[7:0] ? $signed(16'sh3fdf) : $signed(_GEN_44); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_46 = 8'h28 == idx[7:0] ? $signed(16'sh40f5) : $signed(_GEN_45); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_47 = 8'h29 == idx[7:0] ? $signed(16'sh4201) : $signed(_GEN_46); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_48 = 8'h2a == idx[7:0] ? $signed(16'sh4302) : $signed(_GEN_47); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_49 = 8'h2b == idx[7:0] ? $signed(16'sh43f9) : $signed(_GEN_48); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_50 = 8'h2c == idx[7:0] ? $signed(16'sh44e6) : $signed(_GEN_49); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_51 = 8'h2d == idx[7:0] ? $signed(16'sh45c8) : $signed(_GEN_50); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_52 = 8'h2e == idx[7:0] ? $signed(16'sh469f) : $signed(_GEN_51); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_53 = 8'h2f == idx[7:0] ? $signed(16'sh476c) : $signed(_GEN_52); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_54 = 8'h30 == idx[7:0] ? $signed(16'sh482d) : $signed(_GEN_53); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_55 = 8'h31 == idx[7:0] ? $signed(16'sh48e3) : $signed(_GEN_54); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_56 = 8'h32 == idx[7:0] ? $signed(16'sh498e) : $signed(_GEN_55); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_57 = 8'h33 == idx[7:0] ? $signed(16'sh4a2e) : $signed(_GEN_56); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_58 = 8'h34 == idx[7:0] ? $signed(16'sh4ac2) : $signed(_GEN_57); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_59 = 8'h35 == idx[7:0] ? $signed(16'sh4b4b) : $signed(_GEN_58); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_60 = 8'h36 == idx[7:0] ? $signed(16'sh4bc8) : $signed(_GEN_59); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_61 = 8'h37 == idx[7:0] ? $signed(16'sh4c3a) : $signed(_GEN_60); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_62 = 8'h38 == idx[7:0] ? $signed(16'sh4c9f) : $signed(_GEN_61); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_63 = 8'h39 == idx[7:0] ? $signed(16'sh4cf9) : $signed(_GEN_62); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_64 = 8'h3a == idx[7:0] ? $signed(16'sh4d47) : $signed(_GEN_63); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_65 = 8'h3b == idx[7:0] ? $signed(16'sh4d89) : $signed(_GEN_64); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_66 = 8'h3c == idx[7:0] ? $signed(16'sh4dbf) : $signed(_GEN_65); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_67 = 8'h3d == idx[7:0] ? $signed(16'sh4de9) : $signed(_GEN_66); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_68 = 8'h3e == idx[7:0] ? $signed(16'sh4e07) : $signed(_GEN_67); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_69 = 8'h3f == idx[7:0] ? $signed(16'sh4e19) : $signed(_GEN_68); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_70 = 8'h40 == idx[7:0] ? $signed(16'sh4e20) : $signed(_GEN_69); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_71 = 8'h41 == idx[7:0] ? $signed(16'sh4e19) : $signed(_GEN_70); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_72 = 8'h42 == idx[7:0] ? $signed(16'sh4e07) : $signed(_GEN_71); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_73 = 8'h43 == idx[7:0] ? $signed(16'sh4de9) : $signed(_GEN_72); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_74 = 8'h44 == idx[7:0] ? $signed(16'sh4dbf) : $signed(_GEN_73); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_75 = 8'h45 == idx[7:0] ? $signed(16'sh4d89) : $signed(_GEN_74); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_76 = 8'h46 == idx[7:0] ? $signed(16'sh4d47) : $signed(_GEN_75); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_77 = 8'h47 == idx[7:0] ? $signed(16'sh4cf9) : $signed(_GEN_76); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_78 = 8'h48 == idx[7:0] ? $signed(16'sh4c9f) : $signed(_GEN_77); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_79 = 8'h49 == idx[7:0] ? $signed(16'sh4c3a) : $signed(_GEN_78); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_80 = 8'h4a == idx[7:0] ? $signed(16'sh4bc8) : $signed(_GEN_79); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_81 = 8'h4b == idx[7:0] ? $signed(16'sh4b4b) : $signed(_GEN_80); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_82 = 8'h4c == idx[7:0] ? $signed(16'sh4ac2) : $signed(_GEN_81); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_83 = 8'h4d == idx[7:0] ? $signed(16'sh4a2e) : $signed(_GEN_82); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_84 = 8'h4e == idx[7:0] ? $signed(16'sh498e) : $signed(_GEN_83); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_85 = 8'h4f == idx[7:0] ? $signed(16'sh48e3) : $signed(_GEN_84); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_86 = 8'h50 == idx[7:0] ? $signed(16'sh482d) : $signed(_GEN_85); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_87 = 8'h51 == idx[7:0] ? $signed(16'sh476c) : $signed(_GEN_86); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_88 = 8'h52 == idx[7:0] ? $signed(16'sh469f) : $signed(_GEN_87); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_89 = 8'h53 == idx[7:0] ? $signed(16'sh45c8) : $signed(_GEN_88); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_90 = 8'h54 == idx[7:0] ? $signed(16'sh44e6) : $signed(_GEN_89); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_91 = 8'h55 == idx[7:0] ? $signed(16'sh43f9) : $signed(_GEN_90); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_92 = 8'h56 == idx[7:0] ? $signed(16'sh4302) : $signed(_GEN_91); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_93 = 8'h57 == idx[7:0] ? $signed(16'sh4201) : $signed(_GEN_92); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_94 = 8'h58 == idx[7:0] ? $signed(16'sh40f5) : $signed(_GEN_93); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_95 = 8'h59 == idx[7:0] ? $signed(16'sh3fdf) : $signed(_GEN_94); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_96 = 8'h5a == idx[7:0] ? $signed(16'sh3ec0) : $signed(_GEN_95); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_97 = 8'h5b == idx[7:0] ? $signed(16'sh3d96) : $signed(_GEN_96); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_98 = 8'h5c == idx[7:0] ? $signed(16'sh3c64) : $signed(_GEN_97); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_99 = 8'h5d == idx[7:0] ? $signed(16'sh3b28) : $signed(_GEN_98); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_100 = 8'h5e == idx[7:0] ? $signed(16'sh39e3) : $signed(_GEN_99); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_101 = 8'h5f == idx[7:0] ? $signed(16'sh3894) : $signed(_GEN_100); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_102 = 8'h60 == idx[7:0] ? $signed(16'sh373e) : $signed(_GEN_101); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_103 = 8'h61 == idx[7:0] ? $signed(16'sh35de) : $signed(_GEN_102); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_104 = 8'h62 == idx[7:0] ? $signed(16'sh3477) : $signed(_GEN_103); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_105 = 8'h63 == idx[7:0] ? $signed(16'sh3307) : $signed(_GEN_104); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_106 = 8'h64 == idx[7:0] ? $signed(16'sh318f) : $signed(_GEN_105); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_107 = 8'h65 == idx[7:0] ? $signed(16'sh3010) : $signed(_GEN_106); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_108 = 8'h66 == idx[7:0] ? $signed(16'sh2e89) : $signed(_GEN_107); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_109 = 8'h67 == idx[7:0] ? $signed(16'sh2cfc) : $signed(_GEN_108); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_110 = 8'h68 == idx[7:0] ? $signed(16'sh2b67) : $signed(_GEN_109); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_111 = 8'h69 == idx[7:0] ? $signed(16'sh29cb) : $signed(_GEN_110); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_112 = 8'h6a == idx[7:0] ? $signed(16'sh282a) : $signed(_GEN_111); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_113 = 8'h6b == idx[7:0] ? $signed(16'sh2681) : $signed(_GEN_112); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_114 = 8'h6c == idx[7:0] ? $signed(16'sh24d3) : $signed(_GEN_113); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_115 = 8'h6d == idx[7:0] ? $signed(16'sh2320) : $signed(_GEN_114); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_116 = 8'h6e == idx[7:0] ? $signed(16'sh2167) : $signed(_GEN_115); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_117 = 8'h6f == idx[7:0] ? $signed(16'sh1fa8) : $signed(_GEN_116); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_118 = 8'h70 == idx[7:0] ? $signed(16'sh1de5) : $signed(_GEN_117); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_119 = 8'h71 == idx[7:0] ? $signed(16'sh1c1d) : $signed(_GEN_118); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_120 = 8'h72 == idx[7:0] ? $signed(16'sh1a51) : $signed(_GEN_119); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_121 = 8'h73 == idx[7:0] ? $signed(16'sh1881) : $signed(_GEN_120); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_122 = 8'h74 == idx[7:0] ? $signed(16'sh16ad) : $signed(_GEN_121); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_123 = 8'h75 == idx[7:0] ? $signed(16'sh14d6) : $signed(_GEN_122); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_124 = 8'h76 == idx[7:0] ? $signed(16'sh12fb) : $signed(_GEN_123); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_125 = 8'h77 == idx[7:0] ? $signed(16'sh111e) : $signed(_GEN_124); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_126 = 8'h78 == idx[7:0] ? $signed(16'shf3d) : $signed(_GEN_125); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_127 = 8'h79 == idx[7:0] ? $signed(16'shd5b) : $signed(_GEN_126); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_128 = 8'h7a == idx[7:0] ? $signed(16'shb76) : $signed(_GEN_127); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_129 = 8'h7b == idx[7:0] ? $signed(16'sh990) : $signed(_GEN_128); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_130 = 8'h7c == idx[7:0] ? $signed(16'sh7a8) : $signed(_GEN_129); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_131 = 8'h7d == idx[7:0] ? $signed(16'sh5bf) : $signed(_GEN_130); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_132 = 8'h7e == idx[7:0] ? $signed(16'sh3d5) : $signed(_GEN_131); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_133 = 8'h7f == idx[7:0] ? $signed(16'sh1ea) : $signed(_GEN_132); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_134 = 8'h80 == idx[7:0] ? $signed(16'sh0) : $signed(_GEN_133); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_135 = 8'h81 == idx[7:0] ? $signed(-16'sh1ea) : $signed(_GEN_134); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_136 = 8'h82 == idx[7:0] ? $signed(-16'sh3d5) : $signed(_GEN_135); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_137 = 8'h83 == idx[7:0] ? $signed(-16'sh5bf) : $signed(_GEN_136); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_138 = 8'h84 == idx[7:0] ? $signed(-16'sh7a8) : $signed(_GEN_137); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_139 = 8'h85 == idx[7:0] ? $signed(-16'sh990) : $signed(_GEN_138); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_140 = 8'h86 == idx[7:0] ? $signed(-16'shb76) : $signed(_GEN_139); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_141 = 8'h87 == idx[7:0] ? $signed(-16'shd5b) : $signed(_GEN_140); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_142 = 8'h88 == idx[7:0] ? $signed(-16'shf3d) : $signed(_GEN_141); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_143 = 8'h89 == idx[7:0] ? $signed(-16'sh111e) : $signed(_GEN_142); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_144 = 8'h8a == idx[7:0] ? $signed(-16'sh12fb) : $signed(_GEN_143); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_145 = 8'h8b == idx[7:0] ? $signed(-16'sh14d6) : $signed(_GEN_144); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_146 = 8'h8c == idx[7:0] ? $signed(-16'sh16ad) : $signed(_GEN_145); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_147 = 8'h8d == idx[7:0] ? $signed(-16'sh1881) : $signed(_GEN_146); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_148 = 8'h8e == idx[7:0] ? $signed(-16'sh1a51) : $signed(_GEN_147); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_149 = 8'h8f == idx[7:0] ? $signed(-16'sh1c1d) : $signed(_GEN_148); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_150 = 8'h90 == idx[7:0] ? $signed(-16'sh1de5) : $signed(_GEN_149); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_151 = 8'h91 == idx[7:0] ? $signed(-16'sh1fa8) : $signed(_GEN_150); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_152 = 8'h92 == idx[7:0] ? $signed(-16'sh2167) : $signed(_GEN_151); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_153 = 8'h93 == idx[7:0] ? $signed(-16'sh2320) : $signed(_GEN_152); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_154 = 8'h94 == idx[7:0] ? $signed(-16'sh24d3) : $signed(_GEN_153); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_155 = 8'h95 == idx[7:0] ? $signed(-16'sh2681) : $signed(_GEN_154); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_156 = 8'h96 == idx[7:0] ? $signed(-16'sh282a) : $signed(_GEN_155); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_157 = 8'h97 == idx[7:0] ? $signed(-16'sh29cb) : $signed(_GEN_156); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_158 = 8'h98 == idx[7:0] ? $signed(-16'sh2b67) : $signed(_GEN_157); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_159 = 8'h99 == idx[7:0] ? $signed(-16'sh2cfc) : $signed(_GEN_158); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_160 = 8'h9a == idx[7:0] ? $signed(-16'sh2e89) : $signed(_GEN_159); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_161 = 8'h9b == idx[7:0] ? $signed(-16'sh3010) : $signed(_GEN_160); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_162 = 8'h9c == idx[7:0] ? $signed(-16'sh318f) : $signed(_GEN_161); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_163 = 8'h9d == idx[7:0] ? $signed(-16'sh3307) : $signed(_GEN_162); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_164 = 8'h9e == idx[7:0] ? $signed(-16'sh3477) : $signed(_GEN_163); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_165 = 8'h9f == idx[7:0] ? $signed(-16'sh35de) : $signed(_GEN_164); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_166 = 8'ha0 == idx[7:0] ? $signed(-16'sh373e) : $signed(_GEN_165); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_167 = 8'ha1 == idx[7:0] ? $signed(-16'sh3894) : $signed(_GEN_166); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_168 = 8'ha2 == idx[7:0] ? $signed(-16'sh39e3) : $signed(_GEN_167); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_169 = 8'ha3 == idx[7:0] ? $signed(-16'sh3b28) : $signed(_GEN_168); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_170 = 8'ha4 == idx[7:0] ? $signed(-16'sh3c64) : $signed(_GEN_169); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_171 = 8'ha5 == idx[7:0] ? $signed(-16'sh3d96) : $signed(_GEN_170); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_172 = 8'ha6 == idx[7:0] ? $signed(-16'sh3ec0) : $signed(_GEN_171); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_173 = 8'ha7 == idx[7:0] ? $signed(-16'sh3fdf) : $signed(_GEN_172); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_174 = 8'ha8 == idx[7:0] ? $signed(-16'sh40f5) : $signed(_GEN_173); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_175 = 8'ha9 == idx[7:0] ? $signed(-16'sh4201) : $signed(_GEN_174); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_176 = 8'haa == idx[7:0] ? $signed(-16'sh4302) : $signed(_GEN_175); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_177 = 8'hab == idx[7:0] ? $signed(-16'sh43f9) : $signed(_GEN_176); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_178 = 8'hac == idx[7:0] ? $signed(-16'sh44e6) : $signed(_GEN_177); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_179 = 8'had == idx[7:0] ? $signed(-16'sh45c8) : $signed(_GEN_178); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_180 = 8'hae == idx[7:0] ? $signed(-16'sh469f) : $signed(_GEN_179); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_181 = 8'haf == idx[7:0] ? $signed(-16'sh476c) : $signed(_GEN_180); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_182 = 8'hb0 == idx[7:0] ? $signed(-16'sh482d) : $signed(_GEN_181); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_183 = 8'hb1 == idx[7:0] ? $signed(-16'sh48e3) : $signed(_GEN_182); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_184 = 8'hb2 == idx[7:0] ? $signed(-16'sh498e) : $signed(_GEN_183); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_185 = 8'hb3 == idx[7:0] ? $signed(-16'sh4a2e) : $signed(_GEN_184); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_186 = 8'hb4 == idx[7:0] ? $signed(-16'sh4ac2) : $signed(_GEN_185); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_187 = 8'hb5 == idx[7:0] ? $signed(-16'sh4b4b) : $signed(_GEN_186); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_188 = 8'hb6 == idx[7:0] ? $signed(-16'sh4bc8) : $signed(_GEN_187); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_189 = 8'hb7 == idx[7:0] ? $signed(-16'sh4c3a) : $signed(_GEN_188); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_190 = 8'hb8 == idx[7:0] ? $signed(-16'sh4c9f) : $signed(_GEN_189); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_191 = 8'hb9 == idx[7:0] ? $signed(-16'sh4cf9) : $signed(_GEN_190); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_192 = 8'hba == idx[7:0] ? $signed(-16'sh4d47) : $signed(_GEN_191); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_193 = 8'hbb == idx[7:0] ? $signed(-16'sh4d89) : $signed(_GEN_192); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_194 = 8'hbc == idx[7:0] ? $signed(-16'sh4dbf) : $signed(_GEN_193); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_195 = 8'hbd == idx[7:0] ? $signed(-16'sh4de9) : $signed(_GEN_194); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_196 = 8'hbe == idx[7:0] ? $signed(-16'sh4e07) : $signed(_GEN_195); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_197 = 8'hbf == idx[7:0] ? $signed(-16'sh4e19) : $signed(_GEN_196); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_198 = 8'hc0 == idx[7:0] ? $signed(-16'sh4e20) : $signed(_GEN_197); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_199 = 8'hc1 == idx[7:0] ? $signed(-16'sh4e19) : $signed(_GEN_198); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_200 = 8'hc2 == idx[7:0] ? $signed(-16'sh4e07) : $signed(_GEN_199); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_201 = 8'hc3 == idx[7:0] ? $signed(-16'sh4de9) : $signed(_GEN_200); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_202 = 8'hc4 == idx[7:0] ? $signed(-16'sh4dbf) : $signed(_GEN_201); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_203 = 8'hc5 == idx[7:0] ? $signed(-16'sh4d89) : $signed(_GEN_202); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_204 = 8'hc6 == idx[7:0] ? $signed(-16'sh4d47) : $signed(_GEN_203); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_205 = 8'hc7 == idx[7:0] ? $signed(-16'sh4cf9) : $signed(_GEN_204); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_206 = 8'hc8 == idx[7:0] ? $signed(-16'sh4c9f) : $signed(_GEN_205); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_207 = 8'hc9 == idx[7:0] ? $signed(-16'sh4c3a) : $signed(_GEN_206); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_208 = 8'hca == idx[7:0] ? $signed(-16'sh4bc8) : $signed(_GEN_207); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_209 = 8'hcb == idx[7:0] ? $signed(-16'sh4b4b) : $signed(_GEN_208); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_210 = 8'hcc == idx[7:0] ? $signed(-16'sh4ac2) : $signed(_GEN_209); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_211 = 8'hcd == idx[7:0] ? $signed(-16'sh4a2e) : $signed(_GEN_210); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_212 = 8'hce == idx[7:0] ? $signed(-16'sh498e) : $signed(_GEN_211); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_213 = 8'hcf == idx[7:0] ? $signed(-16'sh48e3) : $signed(_GEN_212); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_214 = 8'hd0 == idx[7:0] ? $signed(-16'sh482d) : $signed(_GEN_213); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_215 = 8'hd1 == idx[7:0] ? $signed(-16'sh476c) : $signed(_GEN_214); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_216 = 8'hd2 == idx[7:0] ? $signed(-16'sh469f) : $signed(_GEN_215); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_217 = 8'hd3 == idx[7:0] ? $signed(-16'sh45c8) : $signed(_GEN_216); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_218 = 8'hd4 == idx[7:0] ? $signed(-16'sh44e6) : $signed(_GEN_217); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_219 = 8'hd5 == idx[7:0] ? $signed(-16'sh43f9) : $signed(_GEN_218); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_220 = 8'hd6 == idx[7:0] ? $signed(-16'sh4302) : $signed(_GEN_219); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_221 = 8'hd7 == idx[7:0] ? $signed(-16'sh4201) : $signed(_GEN_220); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_222 = 8'hd8 == idx[7:0] ? $signed(-16'sh40f5) : $signed(_GEN_221); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_223 = 8'hd9 == idx[7:0] ? $signed(-16'sh3fdf) : $signed(_GEN_222); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_224 = 8'hda == idx[7:0] ? $signed(-16'sh3ec0) : $signed(_GEN_223); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_225 = 8'hdb == idx[7:0] ? $signed(-16'sh3d96) : $signed(_GEN_224); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_226 = 8'hdc == idx[7:0] ? $signed(-16'sh3c64) : $signed(_GEN_225); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_227 = 8'hdd == idx[7:0] ? $signed(-16'sh3b28) : $signed(_GEN_226); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_228 = 8'hde == idx[7:0] ? $signed(-16'sh39e3) : $signed(_GEN_227); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_229 = 8'hdf == idx[7:0] ? $signed(-16'sh3894) : $signed(_GEN_228); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_230 = 8'he0 == idx[7:0] ? $signed(-16'sh373e) : $signed(_GEN_229); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_231 = 8'he1 == idx[7:0] ? $signed(-16'sh35de) : $signed(_GEN_230); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_232 = 8'he2 == idx[7:0] ? $signed(-16'sh3477) : $signed(_GEN_231); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_233 = 8'he3 == idx[7:0] ? $signed(-16'sh3307) : $signed(_GEN_232); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_234 = 8'he4 == idx[7:0] ? $signed(-16'sh318f) : $signed(_GEN_233); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_235 = 8'he5 == idx[7:0] ? $signed(-16'sh3010) : $signed(_GEN_234); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_236 = 8'he6 == idx[7:0] ? $signed(-16'sh2e89) : $signed(_GEN_235); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_237 = 8'he7 == idx[7:0] ? $signed(-16'sh2cfc) : $signed(_GEN_236); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_238 = 8'he8 == idx[7:0] ? $signed(-16'sh2b67) : $signed(_GEN_237); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_239 = 8'he9 == idx[7:0] ? $signed(-16'sh29cb) : $signed(_GEN_238); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_240 = 8'hea == idx[7:0] ? $signed(-16'sh282a) : $signed(_GEN_239); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_241 = 8'heb == idx[7:0] ? $signed(-16'sh2681) : $signed(_GEN_240); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_242 = 8'hec == idx[7:0] ? $signed(-16'sh24d3) : $signed(_GEN_241); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_243 = 8'hed == idx[7:0] ? $signed(-16'sh2320) : $signed(_GEN_242); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_244 = 8'hee == idx[7:0] ? $signed(-16'sh2167) : $signed(_GEN_243); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_245 = 8'hef == idx[7:0] ? $signed(-16'sh1fa8) : $signed(_GEN_244); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_246 = 8'hf0 == idx[7:0] ? $signed(-16'sh1de5) : $signed(_GEN_245); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_247 = 8'hf1 == idx[7:0] ? $signed(-16'sh1c1d) : $signed(_GEN_246); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_248 = 8'hf2 == idx[7:0] ? $signed(-16'sh1a51) : $signed(_GEN_247); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_249 = 8'hf3 == idx[7:0] ? $signed(-16'sh1881) : $signed(_GEN_248); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_250 = 8'hf4 == idx[7:0] ? $signed(-16'sh16ad) : $signed(_GEN_249); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_251 = 8'hf5 == idx[7:0] ? $signed(-16'sh14d6) : $signed(_GEN_250); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_252 = 8'hf6 == idx[7:0] ? $signed(-16'sh12fb) : $signed(_GEN_251); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_253 = 8'hf7 == idx[7:0] ? $signed(-16'sh111e) : $signed(_GEN_252); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_254 = 8'hf8 == idx[7:0] ? $signed(-16'shf3d) : $signed(_GEN_253); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_255 = 8'hf9 == idx[7:0] ? $signed(-16'shd5b) : $signed(_GEN_254); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_256 = 8'hfa == idx[7:0] ? $signed(-16'shb76) : $signed(_GEN_255); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_257 = 8'hfb == idx[7:0] ? $signed(-16'sh990) : $signed(_GEN_256); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_258 = 8'hfc == idx[7:0] ? $signed(-16'sh7a8) : $signed(_GEN_257); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_259 = 8'hfd == idx[7:0] ? $signed(-16'sh5bf) : $signed(_GEN_258); // @[methane.Oscillator.scala 42:{17,17}]
  wire [15:0] _GEN_260 = 8'hfe == idx[7:0] ? $signed(-16'sh3d5) : $signed(_GEN_259); // @[methane.Oscillator.scala 42:{17,17}]
  assign io_out = 8'hff == idx[7:0] ? $signed(-16'sh1ea) : $signed(_GEN_260); // @[methane.Oscillator.scala 42:{17,17}]
  always @(posedge clock) begin
    if (reset) begin // @[methane.Oscillator.scala 27:27]
      holdTick <= _holdTick_T; // @[methane.Oscillator.scala 27:27]
    end else if (io_en) begin // @[methane.Oscillator.scala 31:17]
      holdTick <= _holdTick_T; // @[methane.Oscillator.scala 32:18]
    end
    if (reset) begin // @[methane.Oscillator.scala 28:26]
      runTick <= 32'h0; // @[methane.Oscillator.scala 28:26]
    end else if (io_en) begin // @[methane.Oscillator.scala 31:17]
      if (runTick == holdTick) begin // @[methane.Oscillator.scala 34:36]
        runTick <= 32'h0; // @[methane.Oscillator.scala 35:21]
      end else begin
        runTick <= _runTick_T_1; // @[methane.Oscillator.scala 33:17]
      end
    end
    if (reset) begin // @[methane.Oscillator.scala 29:22]
      idx <= 16'h0; // @[methane.Oscillator.scala 29:22]
    end else if (io_en) begin // @[methane.Oscillator.scala 31:17]
      if (runTick == holdTick) begin // @[methane.Oscillator.scala 34:36]
        if (idx == 16'h100) begin // @[methane.Oscillator.scala 37:39]
          idx <= 16'h0; // @[methane.Oscillator.scala 38:21]
        end else begin
          idx <= _idx_T_1; // @[methane.Oscillator.scala 36:17]
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  holdTick = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  runTick = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  idx = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
