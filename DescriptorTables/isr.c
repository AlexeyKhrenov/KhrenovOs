#include "./isr.h"
#include "../drivers/screen.h"

void isr_handler(registers_t regs)
{
    char rec[] = "Received interrupt: ";
    kprint(rec);

    //monitor_write("recieved interrupt: ");
    //monitor_write_dec(regs.int_no);
    //monitor_put('\n');
}