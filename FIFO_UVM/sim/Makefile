# Makefile for Memory - Regression Testing 
RTL= ../rtl/*
work= work #library name
COVOP= -coveropt 3 +cover=bcft
SVTB1= ../top/top.sv
INC = +incdir+../rtl +incdir+../env +incdir+../test +incdir+../top
SVTB2 = ../test/fifo_pkg.sv
TEST = ../test/test.sv
TEST1 = ../test/test1.sv
TEST2 = ../test/test2.sv
VSIMOPT= -coverage -novopt -sva -sv_seed random work.top 
VSIMCOV= coverage save -onexit -assert -directive -cvg -codeAll mem_cov
VSIMBATCH= -c -do "$(VSIMCOV); run -all; exit"
VSIMBATCH1 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov1;run -all;exit"
VSIMBATCH2 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov2;run -all;exit"
VSIMBATCH3 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov3;run -all;exit"
VSIMBATCH4 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov4;run -all;exit"
VSIMBATCH5 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov5;run -all;exit"
VSIMBATCH6 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov6;run -all;exit"
VSIMBATCH7 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov7;run -all;exit"
VSIMBATCH8 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov8;run -all;exit"
VSIMBATCH9 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov9;run -all;exit"


html:
	firefox covhtmlreport/pages/__ffifoetop.htm

uvm_cdo:
	#vlib $(work)
	#vmap work $(work)
	vlog -work $(work) $(SVTB2) $(RTL) $(SVTB1) $(INC) #$(TEST)
	vsim -c -novopt -sv_seed random work.top -do "run -all;exit" 

uvm_do:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(SVTB2) $(RTL) $(SVTB1) $(INC) #$(TEST)
	vsim -novopt -sv_seed random work.top 

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(SVTB2) $(RTL) $(SVTB1) $(INC) #$(TEST)

run_sim:
	vsim $(VSIMBATCH1) $(VSIMOPT) -l test1_sim.log +TEST1 +nowarn3829   
	vcover report -html mem_cov1   

run_testg:
	#vsim -novopt -sva -sv_seed random work.top 
	vsim -c -novopt -sv_seed random work.top 
	#vcover report -html mem_cov1   
	#clear

clean:
	rm -rf modelsim.* transcript* vlog.* work vsim.wlf mem_cov* fcover* covhtml* vcover* *.log
	clear

TC2:
	vsim  $(VSIMBATCH2) -coverage -novopt -sva -sv_seed 598761566 -l test2_sim.log work.top +TEST2
	vcover report -html mem_cov2
TC3:
	vsim  $(VSIMBATCH3) -coverage -novopt -sva -sv_seed 74473697 -l test3_sim.log work.top +TEST3
	vcover report -html mem_cov3
TC4:
	vsim  $(VSIMBATCH4) -coverage -novopt -sva -sv_seed 4275076933 -l test4_sim.log work.top +TEST4
	vcover report -html mem_cov4

TC5:
	vsim  $(VSIMBATCH5) -coverage -novopt -sva -sv_seed 3868229417 -l test5_sim.log work.top +TEST5
	vcover report -html mem_cov5

TC6:
	vsim  $(VSIMBATCH6) -coverage -novopt -sva -sv_seed 749764269 -l test6_sim.log work.top +TEST6
	vcover report -html mem_cov6

TC7:
	vsim  $(VSIMBATCH7) -coverage -novopt -sva -sv_seed 1982889551 -l test7_sim.log work.top +TEST7
	vcover report -html mem_cov7

TC8:
	vsim  $(VSIMBATCH8) -coverage -novopt -sva -sv_seed 1987083824 -l test8_sim.log work.top +TEST8
	vcover report -html mem_cov8

TC9:
	vsim  $(VSIMBATCH9) -coverage -novopt -sva -sv_seed 1987083824 -l test8_sim.log work.top +TEST9
	vcover report -html mem_cov9
report:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9
	vcover report -html mem_cov

regress: clean run_test TC2 TC3 TC4 TC5 TC6 TC7 TC8 TC9 report html


gui:
	vsim $(VSIMOPT)

run_test: clean sv_cmp run_sim
	


