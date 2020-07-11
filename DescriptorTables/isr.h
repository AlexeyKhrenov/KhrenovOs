typedef struct __attribute__((packed)) registers
{
   int ds;                  // Data segment selector
   int edi, esi, ebp, esp, ebx, edx, ecx, eax; // Pushed by pusha.
   int int_no, err_code;    // Interrupt number and error code (if applicable)
   int eip, cs, eflags, useresp, ss; // Pushed by the processor automatically.
} registers_t;