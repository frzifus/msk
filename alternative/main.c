void show_text(char *text) {
  char *mem = (char*)0xb8000;
  while(*text) {
    *mem++ = *text++;
    *mem++ = 0x3;
  }
}

void cls() {
  char *mem = (char*)0xb8000;
  int i = 0;
  while (i < 80 * 25 * 2) {
    mem[i++] = 0;
  }
}

void kernel_main() {
  cls();
  show_text("Hello World!");
}
