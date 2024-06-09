import os
import sys
import string

test = sys.argv[1]
wave = sys.argv[2] if len(sys.argv) >=3 else "0"

out = ''

if(wave == '0' or wave == "command_line"):
   out = "vlog ../env/fifo_package.sv ../rtl/async_fifo.sv ../top/fifo_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl  && vsim -c -vopt -sv_seed random {1} -do \"run -all;exit\" +{0} ".format(test,"top")

elif(wave == '1' or wave == "with_waveforms"):
   out = "vlog ../env/fifo_package.sv ../rtl/async_fifo.sv ../top/fifo_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl  && vsim -vopt -sv_seed random {1} +{0} -do \"do wave.do; run -all\" ".format(test,"top")

elif(wave == '2' or wave == "with_coverage"):
   out = "vlog -coveropt 3 +cover +acc ../env/fifo_package.sv ../rtl/async_fifo.sv ../top/fifo_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl  && vsim -coverage -cvgbintstamp -c -vopt -sv_seed random -l test.log {1} -do \"coverage save -onexit -directive -cvg -codeall fifo_tcov; do wave.do; run -all\" +{0} ".format(test,"top")

elif(wave == '3' or wave == "with_waveforms_coverage"):
   out = "vlog -coveropt 3 +cover +acc ../env/fifo_package.sv ../rtl/async_fifo.sv ../top/fifo_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl  && vsim -coverage -cvgbintstamp -novopt -sv_seed random -l test.log {1} -do \"coverage save -onexit -directive -cvg -codeall fifo_tcov; do wave.do; run -all\" +{0} ".format(test,"top")

elif(wave == '4' or wave == "visualizer"):
   out = "vlog ../env/fifo_package.sv ../rtl/async_fifo.sv ../top/fifo_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl  && vopt {1} -o {1}_opt -designfile design.bin -debug && vsim {1}_opt -visualizer=design.bin -qwavedb=+class+signal+uvm_schematic+wavefile=qwave.db -sv_seed random -do \"run -all\" +{0} ".format(test,"top")

else: print("Nothing executed")

os.system(out)

#-run 0ns -do wave.do -run -all
