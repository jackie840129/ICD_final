read_verilog ../CLE.v
source CLE_DC.sdc
compile

write_sdf -version 2.1 ./CLE_syn.sdf
write -hierarchy -format verilog -output ../CLE_syn.v
write -hierarchy -format ddc -output ./CLE_syn.ddc                       
report_area -nosplit -hierarchy > ./CLE_syn.area.rpt
report_timing
