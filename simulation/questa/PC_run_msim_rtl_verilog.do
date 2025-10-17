transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/ALU_Module.sv}
vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/Program_Counter.sv}
vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/Register_Unit.sv}
vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/Imm_generator.sv}
vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/Riscv_CPU.sv}
vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/hex7seg.sv}
vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/Control_Unit.sv}
vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/mux2to1.sv}
vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/ALU_Control.sv}
vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/Instruction_Memory.sv}

vlog -sv -work work +incdir+C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM {C:/Users/maxim/Documents/U-6semestre/Arquitectura/PC_FPGA_SIM/TB_Riscv_CPU.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  TB_Riscv_CPU

add wave *
view structure
view signals
run -all
