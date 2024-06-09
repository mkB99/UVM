onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/rst_inf/Reset
add wave -noupdate {/top/inf[0]/Clk}
add wave -noupdate {/top/inf[0]/Enable}
add wave -noupdate {/top/inf[0]/Load}
add wave -noupdate {/top/inf[0]/UpDown}
add wave -noupdate {/top/inf[0]/InData}
add wave -noupdate {/top/inf[0]/OutData}
add wave -noupdate {/top/inf[1]/Clk}
add wave -noupdate {/top/inf[1]/Enable}
add wave -noupdate {/top/inf[1]/Load}
add wave -noupdate {/top/inf[1]/UpDown}
add wave -noupdate {/top/inf[1]/InData}
add wave -noupdate {/top/inf[1]/OutData}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {38 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {312 ns}
