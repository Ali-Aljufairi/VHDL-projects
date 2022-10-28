vsim -gui work.lab2
add wave -position insertpoint sim:/lab2/*
force -freeze sim:/lab2/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/lab2/wr_en 1 0
run
run
force -freeze sim:/lab2/WB_add 1 0
force -freeze sim:/lab2/WB 00000001 0
run
run
force -freeze sim:/lab2/WB_add 2 0
force -freeze sim:/lab2/WB 00000010 0
run
run
force -freeze sim:/lab2/WB_add 3 0
force -freeze sim:/lab2/WB 00000011 0
run
run
force -freeze sim:/lab2/wr_en 0 0
force -freeze sim:/lab2/B_add 1 0
run
run
force -freeze sim:/lab2/A_add 2 0
force -freeze sim:/lab2/B_add 3 0
run
run