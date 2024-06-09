# Makefile for Counter - Regression Testing 
RTL= ../rtl/dut_top.sv
work= work #library name
COVOP= -coveropt 3 +cover=bcft
TOP= ../top/cntr_top.sv
INC = +incdir+../rtl +incdir+../env +incdir+../test +incdir+../top
PKG = ../env/cntr_pkg.sv
TEST = ../test/test.sv
TEST1 = ../test/test1.sv
TEST2 = ../test/test2.sv
VERBOSITY = +UVM_VERBOSITY=UVM_MEDIUM
VSIMOPT= -coverage -cvgbintstamp -vopt -sva -sv_seed random work.top 
VSIMCOV= coverage save -onexit -assert -directive -cvg -codeAll counter_cov
VSIMBATCH= -c -do "$(VSIMCOV); run -all; exit"
VSIMBATCH1 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov1;run -all;exit"
TESTCASE= +UVM_TESTNAME=InData_test
VSIMBATCH2 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov2;run -all;exit"
VSIMBATCH3 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov3;run -all;exit"
VSIMBATCH4 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov4;run -all;exit"
VSIMBATCH5 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov5;run -all;exit"
VSIMBATCH6 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov6;run -all;exit"
VSIMBATCH7 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov7;run -all;exit"
VSIMBATCH8 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov8;run -all;exit"
VSIMBATCH9 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov9;run -all;exit"

sv_cdo:
	#vlib $(work)
	#vmap work $(work)
	vlog -work $(work) $(PKG) $(RTL) $(TOP) $(INC) $(VERBOSITY) $(TESTCASE)
	vsim -c -do "run -all;exit" -novopt -sv_seed random work.top  

sv_do:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(PKG) $(RTL) $(TOP) $(INC) $(VERBOSITY) $(TESTCASE)
	vsim -novopt -sv_seed random work.top 

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work -coveropt 3 +cover +acc $(work) $(PKG) $(RTL) $(TOP) $(INC) #$(TEST)

sv_cmp1:
	#vlib $(work)
	#vmap work $(work)
	vlog -coveropt 3 +cover +acc $(PKG) $(RTL) $(TOP) $(INC) #$(TEST)

run_sim:
	vsim  $(VSIMBATCH1) $(VSIMOPT) -l test1_sim.log +UVM_TESTNAME=reset_test +nowarn3829 	
	vcover report -details -html counter_cov1

run_testg:
	#vsim -novopt -sva -sv_seed random work.top 
	vsim -c -novopt -sv_seed random work.top 
	#vcover report -html counter_cov1   
	#clear

run_test: clean sv_cmp1 run_sim

clean:
	rm -rf modelsim.* transcript* vlog.* work vsim.wlf counter_cov* fcover* covhtml* vcover* *.log
	clear

TC2:
	vsim  $(VSIMBATCH2) -coverage -cvgbintstamp -vopt -sva -sv_seed random -l test2_sim.log work.top +UVM_TESTNAME=elu_test +nowarn3829
	vcover report -details -html counter_cov2 
TC3:
	vsim  $(VSIMBATCH3) -coverage -cvgbintstamp -vopt -sva -sv_seed 598761566 -l test3_sim.log work.top +UVM_TESTNAME=rorb_test +nowarn3829
	vcover report -details -html counter_cov3
TC4:
	vsim  $(VSIMBATCH4) -coverage -cvgbintstamp -vopt -sva -sv_seed 74473697 -l test4_sim.log work.top +UVM_TESTNAME=ports_test +nowarn3829
	vcover report -details -html counter_cov4
TC5:
	vsim  $(VSIMBATCH5) -coverage -cvgbintstamp -vopt -sva -sv_seed 4275076933 -l test5_sim.log work.top +UVM_TESTNAME=priority_test +nowarn3829
	vcover report -details -html counter_cov5
TC6:
	vsim  $(VSIMBATCH6) -coverage -cvgbintstamp -vopt -sva -sv_seed 749764269 -l test6_sim.log work.top +UVM_TESTNAME=InData_test +nowarn3829
	vcover report -details -html counter_cov6
TC7:
	vsim  $(VSIMBATCH7) -coverage -cvgbintstamp -vopt -sva -sv_seed 1982889551 -l test7_sim.log work.top +TEST7 +nowarn3829
	vcover report -details -html counter_cov7
TC8:
	vsim  $(VSIMBATCH8) -coverage -cvgbintstamp -vopt -sva -sv_seed 1987083824 -l test8_sim.log work.top +TEST8 +nowarn3829
	vcover report -details -html counter_cov8
TC9:
	vsim  $(VSIMBATCH9) -coverage -cvgbintstamp -vopt -sva -sv_seed 1987083824 -l test8_sim.log work.top +TEST9 +nowarn3829
	vcover report -details -html counter_cov9

report1:
	vcover merge counter_cov counter_cov1 counter_cov2 counter_cov3 counter_cov4 counter_cov5 counter_cov6
	vcover report -details -html counter_cov

logs:	
	gvim -p test*.log

exclude:
	vsim -c -viewcov counter_cov -do "do exclusions.do; coverage save counter_cov_excluded; quit -f"
	vcover report -details -html counter_cov_excluded

regress1: clean run_test TC2 TC3 TC4 TC5 TC6 report1
regress2: clean run_test TC2 TC3 TC4 TC5 TC6 report1 cov
regress3: clean run_test TC2 TC3 TC4 TC5 TC6 report1 code_cov
regress4: clean run_test TC2 TC3 TC4 TC5 TC6 report1 code_cov exclude

#TC5 TC6 TC7 TC8 TC9 report html
func_code: cov code_cov

code_cov:
	nohup firefox covhtmlreport/index.html &
cov:
	vsim -viewcov counter_cov 
gui:
	vsim $(VSIMOPT)


regress: clean run_test TC2 TC3 TC4 TC5 TC6 TC7 TC8 TC9 report html

report:
	vcover merge counter_cov counter_cov1 counter_cov2 counter_cov3 counter_cov4 counter_cov5 counter_cov6 counter_cov7 counter_cov8 counter_cov9
	vcover report -html counter_cov

html:
	firefox covhtmlreport/pages/__ffifoetop.htm

