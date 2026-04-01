#ifndef SYSTEM_H
#define SYSTEM_H

typedef enum {
	ARCH_UNKNOWN,  // Default (Normally error at all)
	ARCH_AARCH64,  // 64-bit ARM (Mostly all phones / Termux)
	ARCH_X86_64,   // 64-bit Intel/AMD (Standard Linux PC)
	ARCH_ARMV7     // 32-bit ARM (Older Android/Raspberry Pi)
} ArchType;

/**
* Finds out what kind of silicon is it.
*/
ArchType get_arch_type();

/**
 * Converts the raw number to meaningful words that humans understand.
*/
const char *arch_type_to_string(ArchType arch);

#endif