
 __    __     ______     ______   __  __     ______     __   __     ______    
/\ "-./  \   /\  ___\   /\__  _\ /\ \_\ \   /\  __ \   /\ "-.\ \   /\  ___\   
\ \ \-./\ \  \ \  __\   \/_/\ \/ \ \  __ \  \ \  __ \  \ \ \-.  \  \ \  __\   
 \ \_\ \ \_\  \ \_____\    \ \_\  \ \_\ \_\  \ \_\ \_\  \ \_\\"\_\  \ \_____\ 
  \/_/  \/_/   \/_____/     \/_/   \/_/\/_/   \/_/\/_/   \/_/ \/_/   \/_____/ 
                                                                              
a polyphonic analog synthesizer built on fpga

[todos]
1. midi processor unit design (current stage)
2. subtractive synthesis unit:
   2.1. oscilator
   2.2. ADSR control
   2.3. filter
3. polyphonic control unit
4. mix bus
5. fx chain
6. audio output processor unit

7. (probably add FM synthesis, granular synthesis, etc)
   (can use that ARM cortex-A9 CPU to design some sophisticated new sound engines - using machine learning? lol)

[specs]
1. vivado project version - 2019.2
2. vitis project version - 2019.2
3. fpga device - Zynq-7000 SoC Z-7010(XC7Z010) with Artix-7 FPGA
4. fpga soc - Dual-core ARM Cortex-A9 MPCore™ with CoreSight™
            - NEON™ & Single / Double Precision Floating Point for each processor

wheatfox 2022
