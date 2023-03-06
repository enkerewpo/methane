circuit I2S :
  module I2S :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip leftChannel : UInt<16>, flip rightChannel : UInt<16>, bitClock : UInt<1>, wordSelect : UInt<1>, serialData : UInt<1>}

    reg bitCounter : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[I2S.scala 15:29]
    node interleavedData = cat(io.rightChannel, io.leftChannel) @[Cat.scala 33:92]
    reg bitClock : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[I2S.scala 21:27]
    node _T = eq(bitCounter, UInt<3>("h7")) @[I2S.scala 22:21]
    when _T : @[I2S.scala 22:30]
      node _bitClock_T = not(bitClock) @[I2S.scala 23:21]
      bitClock <= _bitClock_T @[I2S.scala 23:18]
      bitCounter <= UInt<1>("h0") @[I2S.scala 24:20]
    else :
      node _bitCounter_T = add(bitCounter, UInt<1>("h1")) @[I2S.scala 26:34]
      node _bitCounter_T_1 = tail(_bitCounter_T, 1) @[I2S.scala 26:34]
      bitCounter <= _bitCounter_T_1 @[I2S.scala 26:20]
    reg wordSelect : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[I2S.scala 30:29]
    node _T_1 = eq(bitCounter, UInt<1>("h0")) @[I2S.scala 31:21]
    when _T_1 : @[I2S.scala 31:30]
      node _wordSelect_T = not(wordSelect) @[I2S.scala 32:23]
      wordSelect <= _wordSelect_T @[I2S.scala 32:20]
    reg serialData : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[I2S.scala 36:29]
    node _T_2 = eq(bitCounter, UInt<1>("h0")) @[I2S.scala 37:21]
    when _T_2 : @[I2S.scala 37:30]
      serialData <= UInt<1>("h0") @[I2S.scala 38:20]
    else :
      node _T_3 = eq(bitCounter, UInt<4>("hf")) @[I2S.scala 39:27]
      when _T_3 : @[I2S.scala 39:37]
        serialData <= UInt<1>("h1") @[I2S.scala 40:20]
    io.bitClock <= bitClock @[I2S.scala 44:17]
    io.wordSelect <= wordSelect @[I2S.scala 45:19]
    node _io_serialData_T = bits(interleavedData, 0, 0) @[I2S.scala 46:53]
    node _io_serialData_T_1 = sub(UInt<4>("hf"), bitCounter) @[I2S.scala 46:79]
    node _io_serialData_T_2 = tail(_io_serialData_T_1, 1) @[I2S.scala 46:79]
    node _io_serialData_T_3 = dshr(interleavedData, _io_serialData_T_2) @[I2S.scala 46:74]
    node _io_serialData_T_4 = bits(_io_serialData_T_3, 0, 0) @[I2S.scala 46:74]
    node _io_serialData_T_5 = eq(_io_serialData_T_4, UInt<1>("h0")) @[I2S.scala 46:58]
    node _io_serialData_T_6 = mux(serialData, _io_serialData_T, _io_serialData_T_5) @[I2S.scala 46:25]
    io.serialData <= _io_serialData_T_6 @[I2S.scala 46:19]

