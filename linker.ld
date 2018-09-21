ENTRY(loader)
SECTIONS {
	. = 0x1000000;
	.text : { *(.text) }
}
