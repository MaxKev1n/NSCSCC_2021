onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib divider_u_opt

do {wave.do}

view wave
view structure
view signals

do {divider_u.udo}

run -all

quit -force
