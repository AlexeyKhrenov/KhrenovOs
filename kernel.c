#include "./drivers/port.c"
#include "./drivers/screen.c"
#include "./util.c"
#include "./DescriptorTables/idt.c"
#include "./DescriptorTables/isr.c"

int get_cursor_offset();
void set_cursor_offset(int offset);
int print_char(char c, int col, int row, char attr);

void main() {

    init_idt();

    char x[] = "X";
    char multiplelines[] = "This text spans multiple lines";
    char linebreak[] = "There is a line\nbreak";
    char wrong[] = "What happens when we run out of space?";

    clear_screen();
    kprint_at(x, 20, 20);

    __asm__ __volatile__("int $3");
}