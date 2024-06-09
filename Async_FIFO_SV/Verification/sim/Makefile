# Makefile for FIFO - Regression Testing 
RTL= ../rtl/*
work= work #library name
COVOP= -coveropt 3 +cover=bcft
SVTB1= ../top/fifo_top.sv
INC = +incdir+../rtl +incdir+../env +incdir+../test +incdir+../top
SVTB2 = ../env/fifo_package.sv
TEST = ../test/test.sv
TEST1 = ../test/test1.sv
TEST2 = ../test/test2.sv
VSIMOPT= -coverage -cvgbintstamp -vopt -sva -sv_seed random work.top 
VSIMCOV= coverage save -onexit -assert -directive -cvg -codeAll fifo_cov
VSIMBATCH= -c -do "$(VSIMCOV); run -all; exit"
VSIMBATCH1 = -c -do "coverage save -onexit -assert -directive -cvg -codeall fifo_cov1;run -all;exit"
VSIMBATCH2 = -c -do "coverage save -onexit -assert -directive -cvg -codeall fifo_cov2;run -all;exit"
VSIMBATCH3 = -c -do "coverage save -onexit -assert -directive -cvg -codeall fifo_cov3;run -all;exit"
VSIMBATCH4 = -c -do "coverage save -onexit -assert -directive -cvg -codeall fifo_cov4;run -all;exit"
VSIMBATCH5 = -c -do "coverage save -onexit -assert -directive -cvg -codeall fifo_cov5;run -all;exit"
VSIMBATCH6 = -c -do "coverage save -onexit -assert -directive -cvg -codeall fifo_cov6;run -all;exit"
VSIMBATCH7 = -c -do "coverage save -onexit -assert -directive -cvg -codeall fifo_cov7;run -all;exit"
VSIMBATCH8 = -c -do "coverage save -onexit -assert -directive -cvg -codeall fifo_cov8;run -all;exit"
VSIMBATCH9 = -c -do "coverage save -onexit -assert -directive -cvg -codeall fifo_cov9;run -all;exit"

html:
	firefox covhtmlreport/pages/__ffifoetop.htm

html1:
	firefox covhtmlreport/index.html 

sv_cdo:
	#vlib $(work)
	#vmap work $(work)
	vlog -work $(work) $(SVTB2) $(RTL) $(SVTB1) $(INC) #$(TEST)
	vsim -c -do "run -all;exit" -novopt -sv_seed random work.top +LRANGE_TEST 

sv_do:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(SVTB2) $(RTL) $(SVTB1) $(INC) #$(TEST)
	vsim -novopt -sv_seed random work.top 

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work -coveropt 3 +cover +acc $(work) $(SVTB2) $(RTL) $(SVTB1) $(INC) #$(TEST)

sv_cmp1:
	#vlib $(work)
	#vmap work $(work)
	vlog -coveropt 3 +cover +acc $(SVTB2) $(RTL) $(SVTB1) $(INC) #$(TEST)

run_sim:
	vsim  $(VSIMBATCH1) $(VSIMOPT) -l test1_sim.log +RESET_TEST +nowarn3829 	
	vcover report -details -html fifo_cov1

run_testg:
	#vsim -novopt -sva -sv_seed random work.top 
	vsim -c -novopt -sv_seed random work.top 
	#vcover report -html fifo_cov1   
	#clear

clean:
	rm -rf modelsim.* transcript* vlog.* work vsim.wlf fifo_cov* fcover* covhtml* vcover* *.log
	clear

TC2:
	vsim  $(VSIMBATCH2) -coverage -cvgbintstamp -vopt -sva -sv_seed random -l test2_sim.log work.top +WR_RD_TEST
	vcover report -details -html fifo_cov2 
TC3:
	vsim  $(VSIMBATCH3) -coverage -cvgbintstamp -vopt -sva -sv_seed random -l test3_sim.log work.top +FLAGS_TEST
	vcover report -details -html fifo_cov3
TC4:
	vsim  $(VSIMBATCH4) -coverage -cvgbintstamp -vopt -sva -sv_seed random -l test4_sim.log work.top +ERROR_TEST
	vcover report -details -html fifo_cov4
TC5:
	vsim  $(VSIMBATCH5) -coverage -cvgbintstamp -vopt -sva -sv_seed random -l test5_sim.log work.top +TEST5
	vcover report -details -html fifo_cov5
TC6:
	vsim  $(VSIMBATCH6) -coverage -cvgbintstamp -vopt -sva -sv_seed random -l test6_sim.log work.top +TEST6
	vcover report -details -html fifo_cov6
TC7:
	vsim  $(VSIMBATCH7) -coverage -cvgbintstamp -vopt -sva -sv_seed random -l test7_sim.log work.top +TEST7
	vcover report -details -html fifo_cov7
TC8:
	vsim  $(VSIMBATCH8) -coverage -cvgbintstamp -vopt -sva -sv_seed random -l test8_sim.log work.top +TEST8
	vcover report -details -html fifo_cov8
TC9:
	vsim  $(VSIMBATCH9) -coverage -cvgbintstamp -vopt -sva -sv_seed random -l test8_sim.log work.top +TEST9
	vcover report -details -html fifo_cov9

report:
	vcover merge fifo_cov fifo_cov1 fifo_cov2 fifo_cov3 fifo_cov4 fifo_cov5 fifo_cov6 fifo_cov7 fifo_cov8 fifo_cov9
	vcover report -html fifo_cov

report1:
	vcover merge fifo_cov fifo_cov1 fifo_cov2 fifo_cov3 fifo_cov4 
	vcover report -details -html fifo_cov

exclude:
	vsim -c -viewcov fifo_cov -do "do exclusions.do; coverage save fifo_cov_excluded; quit -f"
	vcover report -details -html fifo_cov_excluded

regress: clean run_test TC2 TC3 TC4 TC5 TC6 TC7 TC8 TC9 report html

regress1: clean run_test TC2 TC3 TC4 report1
regress2: clean run_test TC2 TC3 TC4 report1 cov
regress3: clean run_test TC2 TC3 TC4 report1 code_cov
regress4: clean run_test TC2 TC3 TC4 report1 exclude 

#TC5 TC6 TC7 TC8 TC9 report html
code_cov:
	firefox covhtmlreport/index.html
cov:
	vsim -viewcov fifo_cov 
ecov:
	vsim -viewcov fifo_cov_excluded 
gui:
	vsim $(VSIMOPT)

run_test: clean sv_cmp1 run_sim
