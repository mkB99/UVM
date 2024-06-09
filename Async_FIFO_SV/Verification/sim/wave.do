onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /top/wintf/clear_n
add wave -noupdate -radix unsigned /top/wintf/wr_clk
add wave -noupdate -radix unsigned /top/rintf/rd_clk
add wave -noupdate -radix unsigned /top/wintf/wr_en
add wave -noupdate -radix unsigned /top/rintf/rd_en
add wave -noupdate -radix unsigned /top/wintf/din
add wave -noupdate -radix unsigned /top/rintf/dout
add wave -noupdate -radix unsigned /top/wintf/full
add wave -noupdate -radix unsigned /top/wintf/almost_full
add wave -noupdate -radix unsigned /top/rintf/almost_empty
add wave -noupdate -radix unsigned /top/rintf/empty
add wave -noupdate -radix unsigned /top/wintf/wr_ack
add wave -noupdate -radix unsigned /top/wintf/wr_err
add wave -noupdate -radix unsigned /top/rintf/rd_ack
add wave -noupdate -radix unsigned /top/rintf/rd_err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {52 ns}
