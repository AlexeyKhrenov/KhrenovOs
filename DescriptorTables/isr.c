#include "./isr.h"
#include "../drivers/screen.h"

void isr_handler(registers_t regs)
{
    char rec[] = "Received interrupt: ";
    kprint(rec);

    regs.int_no;

    char newline[] = "\n";

    kprint_hex_int(regs.int_no);
    kprint(newline);
}

isr_t interrupt_handlers[256];

void irq_handler(registers_t regs)
{
   // Send an EOI (end of interrupt) signal to the PICs.
   // If this interrupt involved the slave.
   if (regs.int_no >= 40)
   {
       // Send reset signal to slave.
       port_byte_out(0xA0, 0x20);
   }
   // Send reset signal to master. (As well as slave, if necessary).
   port_byte_out(0x20, 0x20);

   if (interrupt_handlers[regs.int_no] != 0)
   {
       isr_t handler = interrupt_handlers[regs.int_no];
       handler(regs);
   }
}

void register_interrupt_handler(char n, isr_t handler)
{
  interrupt_handlers[n] = handler;
}