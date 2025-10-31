transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor {C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor/ALU.sv}
vlog -sv -work work +incdir+C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor {C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor/processor.sv}
vlog -sv -work work +incdir+C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor {C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor/ProgramCounter.sv}
vlog -sv -work work +incdir+C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor {C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor/RegisterUnit.sv}
vlog -sv -work work +incdir+C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor {C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor/ControlUnit.sv}
vlog -sv -work work +incdir+C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor {C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor/ImmGen.sv}
vlog -sv -work work +incdir+C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor {C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor/InstructionMemory.sv}
vlog -sv -work work +incdir+C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor {C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor/DataMemory.sv}

vlog -sv -work work +incdir+C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor {C:/Users/danie/Desktop/UNI/SEMESTRE_VI/Arq/Processor/processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all
