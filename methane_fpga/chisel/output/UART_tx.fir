circuit UART_tx :
  module UART_tx :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_tx_trig : UInt<1>, flip i_data : UInt<8>, o_tx_busy : UInt<1>, o_tx_done : UInt<1>, o_serial_data : UInt<1>}

    reg clkCnterReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[UART_tx.scala 27:28]
    reg bitCnterReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[UART_tx.scala 28:28]
    reg inDataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[UART_tx.scala 30:26]
    reg outDataReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[UART_tx.scala 31:27]
    reg outTxBusyReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[UART_tx.scala 32:29]
    reg outTxDoneReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[UART_tx.scala 33:29]
    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[UART_tx.scala 34:25]
    io.o_serial_data <= outDataReg @[UART_tx.scala 36:20]
    io.o_tx_busy <= outTxBusyReg @[UART_tx.scala 37:16]
    io.o_tx_done <= outTxDoneReg @[UART_tx.scala 38:16]
    node _outTxBusyReg_T = neq(stateReg, UInt<2>("h0")) @[UART_tx.scala 39:28]
    outTxBusyReg <= _outTxBusyReg_T @[UART_tx.scala 39:16]
    node _T = eq(UInt<2>("h0"), stateReg) @[UART_tx.scala 41:21]
    when _T : @[UART_tx.scala 41:21]
      outTxDoneReg <= UInt<1>("h0") @[UART_tx.scala 43:20]
      clkCnterReg <= UInt<8>("h0") @[UART_tx.scala 45:19]
      bitCnterReg <= UInt<4>("h0") @[UART_tx.scala 46:19]
      node _T_1 = eq(io.i_tx_trig, UInt<1>("h1")) @[UART_tx.scala 48:26]
      when _T_1 : @[UART_tx.scala 48:38]
        outDataReg <= UInt<1>("h0") @[UART_tx.scala 49:20]
        inDataReg <= io.i_data @[UART_tx.scala 51:19]
        stateReg <= UInt<2>("h1") @[UART_tx.scala 52:18]
      else :
        stateReg <= UInt<2>("h0") @[UART_tx.scala 54:18]
    else :
      node _T_2 = eq(UInt<2>("h1"), stateReg) @[UART_tx.scala 41:21]
      when _T_2 : @[UART_tx.scala 41:21]
        node _T_3 = lt(clkCnterReg, UInt<7>("h56")) @[UART_tx.scala 58:25]
        when _T_3 : @[UART_tx.scala 58:41]
          node _clkCnterReg_T = add(clkCnterReg, UInt<1>("h1")) @[UART_tx.scala 59:36]
          node _clkCnterReg_T_1 = tail(_clkCnterReg_T, 1) @[UART_tx.scala 59:36]
          clkCnterReg <= _clkCnterReg_T_1 @[UART_tx.scala 59:21]
          stateReg <= UInt<2>("h1") @[UART_tx.scala 60:18]
        else :
          clkCnterReg <= UInt<8>("h0") @[UART_tx.scala 62:21]
          node _bitCnterReg_T = add(bitCnterReg, UInt<1>("h1")) @[UART_tx.scala 63:36]
          node _bitCnterReg_T_1 = tail(_bitCnterReg_T, 1) @[UART_tx.scala 63:36]
          bitCnterReg <= _bitCnterReg_T_1 @[UART_tx.scala 63:21]
          node _outDataReg_T = dshr(inDataReg, bitCnterReg) @[UART_tx.scala 65:32]
          node _outDataReg_T_1 = bits(_outDataReg_T, 0, 0) @[UART_tx.scala 65:32]
          outDataReg <= _outDataReg_T_1 @[UART_tx.scala 65:20]
          stateReg <= UInt<2>("h2") @[UART_tx.scala 66:18]
      else :
        node _T_4 = eq(UInt<2>("h2"), stateReg) @[UART_tx.scala 41:21]
        when _T_4 : @[UART_tx.scala 41:21]
          node _T_5 = lt(clkCnterReg, UInt<7>("h56")) @[UART_tx.scala 70:25]
          when _T_5 : @[UART_tx.scala 70:41]
            node _clkCnterReg_T_2 = add(clkCnterReg, UInt<1>("h1")) @[UART_tx.scala 71:36]
            node _clkCnterReg_T_3 = tail(_clkCnterReg_T_2, 1) @[UART_tx.scala 71:36]
            clkCnterReg <= _clkCnterReg_T_3 @[UART_tx.scala 71:21]
            stateReg <= UInt<2>("h2") @[UART_tx.scala 72:18]
          else :
            clkCnterReg <= UInt<8>("h0") @[UART_tx.scala 74:21]
            node _T_6 = lt(bitCnterReg, UInt<4>("h8")) @[UART_tx.scala 75:27]
            when _T_6 : @[UART_tx.scala 75:44]
              node _outDataReg_T_2 = dshr(inDataReg, bitCnterReg) @[UART_tx.scala 77:34]
              node _outDataReg_T_3 = bits(_outDataReg_T_2, 0, 0) @[UART_tx.scala 77:34]
              outDataReg <= _outDataReg_T_3 @[UART_tx.scala 77:22]
              node _bitCnterReg_T_2 = add(bitCnterReg, UInt<1>("h1")) @[UART_tx.scala 78:38]
              node _bitCnterReg_T_3 = tail(_bitCnterReg_T_2, 1) @[UART_tx.scala 78:38]
              bitCnterReg <= _bitCnterReg_T_3 @[UART_tx.scala 78:23]
              stateReg <= UInt<2>("h2") @[UART_tx.scala 79:20]
            else :
              bitCnterReg <= UInt<4>("h0") @[UART_tx.scala 81:23]
              outDataReg <= UInt<1>("h1") @[UART_tx.scala 83:22]
              stateReg <= UInt<2>("h3") @[UART_tx.scala 84:20]
        else :
          node _T_7 = eq(UInt<2>("h3"), stateReg) @[UART_tx.scala 41:21]
          when _T_7 : @[UART_tx.scala 41:21]
            node _T_8 = lt(clkCnterReg, UInt<7>("h56")) @[UART_tx.scala 89:25]
            when _T_8 : @[UART_tx.scala 89:41]
              node _clkCnterReg_T_4 = add(clkCnterReg, UInt<1>("h1")) @[UART_tx.scala 90:36]
              node _clkCnterReg_T_5 = tail(_clkCnterReg_T_4, 1) @[UART_tx.scala 90:36]
              clkCnterReg <= _clkCnterReg_T_5 @[UART_tx.scala 90:21]
              stateReg <= UInt<2>("h3") @[UART_tx.scala 91:18]
            else :
              clkCnterReg <= UInt<8>("h0") @[UART_tx.scala 93:21]
              outTxDoneReg <= UInt<1>("h1") @[UART_tx.scala 94:22]
              stateReg <= UInt<2>("h0") @[UART_tx.scala 95:18]

