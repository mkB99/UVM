vlog -coveropt 3 +cover +acc ../env/package.sv ../rtl/async_fifo.sv ../top/top.sv +incdir+../env +incdir+../tests +incdir+../top +incdir+../rtl 

#vsim -coverage -novopt -sv_seed random top +WR_RD_TEST
#coverage save -onexit -directive -cvg -codeall wr_rd_cov.ucdb

vsim -coverage -novopt -sv_seed random top +LRANGE_TEST
coverage save -onexit -directive -cvg -codeall lrange_cov.ucdb

#vsim -coverage -novopt -sv_seed random top +WR_ONLY_TEST
#coverage save -onexit -directive -cvg -codeall wr_only_cov.ucdb

#vsim -coverage -novopt -sv_seed random top +RD_ONLY_TEST
#coverage save -onexit -directive -cvg -codeall rd_only_cov.ucdb

#vsim -coverage -novopt -sv_seed random top +RESET_TEST
#coverage save -onexit -directive -cvg -codeall reset_cov.ucdb

run -all
quit -f

#do wave.do
