import os
import sys
import string

#prg = sys.argv[1]
prog = sys.argv[1]
wave = sys.argv[2]

print(wave)
#print(prg + " " + mod)
#out = "vlog {0} ../rtl/async_fifo.sv ../progs/prog.sv ../top/top.sv  && vsim -novopt -sv_seed random {1} && run -all".format(prg = "top.sv",mod = "top")
out = ''
if(wave == '1'):
   out = "vlog {0}.sv && vsim -novopt -sv_seed random {0} -do \"do wave.do\" ".format(prog,"top")

elif(wave == '0'):
   out = "vlog {0}.sv && vsim -c -novopt -sv_seed random {0} -do \"run -all;exit\"".format(prog,"top")
else: print("Nothing executed")

os.system(out)

#-run 0ns -do wave.do -run -all
