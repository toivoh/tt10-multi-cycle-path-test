read_sdc $::env(SCRIPTS_DIR)/base.sdc

#set_multicycle_path -setup -from {adder.x[0]} 2
#set_multicycle_path -hold -from {adder.x[0]} 1
#set_multicycle_path -setup -from {adder.y[0]} 2
#set_multicycle_path -hold -from {adder.y[0]} 1

set_multicycle_path -setup -through {adder.x[0]} 2
set_multicycle_path -hold -through {adder.x[0]} 1
set_multicycle_path -setup -through {adder.y[0]} 2
set_multicycle_path -hold -through {adder.y[0]} 1
