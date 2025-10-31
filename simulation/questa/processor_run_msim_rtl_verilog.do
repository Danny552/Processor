transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/font_renderer.v}
vlog -vlog01compat -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/font_rom.v}
vlib vgaClock
vmap vgaClock vgaClock
vlog -vlog01compat -work vgaClock +incdir+c:/users/jucac/desktop/universidad/arquitectura/processor/db/ip/vgaclock/submodules {c:/users/jucac/desktop/universidad/arquitectura/processor/db/ip/vgaclock/submodules/altera_up_avalon_reset_from_locked_signal.v}
vlog -vlog01compat -work vgaClock +incdir+c:/users/jucac/desktop/universidad/arquitectura/processor/db/ip/vgaclock/submodules {c:/users/jucac/desktop/universidad/arquitectura/processor/db/ip/vgaclock/submodules/vgaclock_video_pll_0.v}
vlog -vlog01compat -work vgaClock +incdir+c:/users/jucac/desktop/universidad/arquitectura/processor/db/ip/vgaclock/submodules {c:/users/jucac/desktop/universidad/arquitectura/processor/db/ip/vgaclock/submodules/vgaclock_video_pll_0_video_pll.v}
vlog -vlog01compat -work vgaClock +incdir+c:/users/jucac/desktop/universidad/arquitectura/processor/db/ip/vgaclock {c:/users/jucac/desktop/universidad/arquitectura/processor/db/ip/vgaclock/vgaclock.v}
vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/ALU.sv}
vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/processor.sv}
vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/ProgramCounter.sv}
vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/RegisterUnit.sv}
vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/ControlUnit.sv}
vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/ImmGen.sv}
vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/color.sv}
vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/InstructionMemory.sv}
vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/DataMemory.sv}

vlog -sv -work work +incdir+C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor {C:/Users/jucac/Desktop/Universidad/Arquitectura/Processor/processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -L vgaClock -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all
