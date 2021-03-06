#include <string.h>
#include "idt.h"

static void idt_set_gate(char num, int base);

idt_entry_t idt_entries[256];
idt_entry_ptr idt_ptr;

void init_idt(){
    idt_ptr.limit = sizeof(idt_entry_t) * 256 - 1;
    idt_ptr.base = (short)&idt_entries; // is it the right way to get the pointer?

    // todo - find size of function and change pointer accordingly
    idt_set_gate(0, isr0);
    idt_set_gate(1, isr1);
    idt_set_gate(2, isr2);
    idt_set_gate(3, isr3);
    idt_set_gate(4, isr4);
    idt_set_gate(5, isr5);
    idt_set_gate(6, isr6);
    idt_set_gate(7, isr7);
    idt_set_gate(8, isr8);
    idt_set_gate(9, isr9);

    idt_set_gate(10, isr10);
    idt_set_gate(11, isr11);
    idt_set_gate(12, isr12);
    idt_set_gate(13, isr13);
    idt_set_gate(14, isr14);
    idt_set_gate(15, isr15);
    idt_set_gate(16, isr16);
    idt_set_gate(17, isr17);
    idt_set_gate(18, isr18);
    idt_set_gate(19, isr19);

    idt_set_gate(20, isr20);
    idt_set_gate(21, isr21);
    idt_set_gate(22, isr22);
    idt_set_gate(23, isr23);
    idt_set_gate(24, isr24);
    idt_set_gate(25, isr25);
    idt_set_gate(26, isr26);
    idt_set_gate(27, isr27);
    idt_set_gate(28, isr28);
    idt_set_gate(29, isr29);

    idt_set_gate(30, isr30);
    idt_set_gate(31, isr31);

    port_byte_out(0x20, 0x11);
    port_byte_out(0xA0, 0x11);
    port_byte_out(0x21, 0x20);
    port_byte_out(0xA1, 0x28);
    port_byte_out(0x21, 0x04);
    port_byte_out(0xA1, 0x02);
    port_byte_out(0x21, 0x01);
    port_byte_out(0xA1, 0x01);
    port_byte_out(0x21, 0x0);
    port_byte_out(0xA1, 0x0); 

    idt_set_gate(32, irq0);
    idt_set_gate(33, irq1);
    idt_set_gate(34, irq2);
    idt_set_gate(35, irq3);
    idt_set_gate(36, irq4);
    idt_set_gate(37, irq5);
    idt_set_gate(38, irq6);
    idt_set_gate(39, irq7);
    idt_set_gate(40, irq8);
    idt_set_gate(41, irq9);
    idt_set_gate(42, irq10);
    idt_set_gate(43, irq11);
    idt_set_gate(44, irq12);
    idt_set_gate(45, irq13);
    idt_set_gate(46, irq14);
    idt_set_gate(47, irq15);

    __asm__ __volatile__("lidtl (%0)" : : "r" (&idt_ptr));
}

static void idt_set_gate(char num, int base){

    // todo - use pointer instead of array index
    idt_entries[num].base_lo = base & 0xFFFF;
    idt_entries[num].base_hi = (base >> 16) & 0xFFFF;

    idt_entries[num].sel = 0x08;
    idt_entries[num].flags = 0x8e;
    idt_entries[num].always0 = 0;
}