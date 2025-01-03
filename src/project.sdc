read_sdc $::env(SCRIPTS_DIR)/base.sdc

#set_multicycle_path -setup -from {adder.x[*] adder.y[*]} 2
#set_multicycle_path -hold  -from {adder.x[*] adder.y[*]} 1

set_multicycle_path -setup -through {adder.x[*] adder.y[*]} 2
set_multicycle_path -hold  -through {adder.x[*] adder.y[*]} 1
