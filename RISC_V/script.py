import os
import sys
import string

#prg = sys.argv[1]
test = sys.argv[1]
wave = sys.argv[2] if len(sys.argv) >=3 else "0"
verbosity = sys.argv[3] if len(sys.argv) >=4 else "UVM_MEDIUM"

out = ''

if(wave == '0' or wave == "command_line"):
   out = "vlog ../env/cntr_pkg.sv ../rtl/dut_top.sv ../top/cntr_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl  && vsim -c -novopt -sv_seed random -l test.log {1} -do \"run -all;exit\" +UVM_TESTNAME={0} +UVM_VERBOSITY={2}".format(test,"top", verbosity)

#for displaying waveform
elif(wave == '1' or wave == "with_waveform"):
   out = "vlog ../env/cntr_pkg.sv ../rtl/dut_top.sv ../top/cntr_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl  && vsim -novopt -sv_seed random -l test.log {1} -do \"do wave.do; run -all\" +UVM_TESTNAME={0} +UVM_VERBOSITY={2}".format(test,"top", verbosity)

#for coverage
elif(wave == '2' or wave == "with_coverage"):
   out = "vlog -coveropt 3 +cover +acc ../env/cntr_pkg.sv ../rtl/dut_top.sv ../top/cntr_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl  && vsim -coverage -cvgbintstamp -vopt -sv_seed random -l test.log {1} -c -do \"coverage save -onexit -directive -cvg -codeall cntr_tcov; do wave.do; run -all\" +UVM_TESTNAME={0} +UVM_VERBOSITY={2} && vsim -viewcov cntr_tcov".format(test,"top", verbosity)

#for coverage and waveforms
elif(wave == '3' or wave == "with_coverage_waveform"):
   out = "vlog -coveropt 3 +cover +acc ../env/cntr_pkg.sv ../rtl/dut_top.sv ../top/cntr_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl  && vsim -coverage -cvgbintstamp -novopt -sv_seed random -l test.log {1} -do \"coverage save -onexit -directive -cvg -codeall cntr_tcov; do wave.do; run -all\" +UVM_TESTNAME={0} +UVM_VERBOSITY={2} && vsim -viewcov cntr_tcov".format(test,"top", verbosity)

#for visualizer
elif(wave == '4' or wave == "visualizer"):
   out = "vlog ../env/cntr_pkg.sv ../rtl/dut_top.sv ../top/cntr_top.sv +incdir+../env +incdir+../test +incdir+../top +incdir+../rtl && vopt top -o top_opt -designfile design.bin -debug  && vsim top_opt -visualizer=design.bin -qwavedb=+class+signal+uvm_schematic+wavefile=qwave.db -do \"run -all\" +UVM_TESTNAME={0}".format(test,"top")
#visualizer -designfile design.bin &

else: print("Nothing executed")

os.system(out)
#-run 0ns -do wave.do -run -all
#+UVM_CONFIG_DB_TRACE
