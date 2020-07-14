#include "./timer.h"
#include "./screen.h"
#include "./port.h"
#include "../DescriptorTables/isr.h"

int tick;

static void timer_callback(registers_t regs){
    tick++;
    kprint_newline();
    kprint_hex_int(tick);
}

void init_timer(int frequency){

    register_interrupt_handler(32, &timer_callback);
    int divisor = 1193180 / frequency;

    char l = (char)(divisor & 0xFF);
    char h = (char)((divisor >> 8) & 0xFF);

    port_byte_out(0x43, 0x36);
    port_byte_out(0x40, l);
    port_byte_out(0x40, h);
}