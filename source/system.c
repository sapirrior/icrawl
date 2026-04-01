#include "system.h"
#include <sys/utsname.h>
#include <string.h>
#include <errno.h>
#include <stdio.h>

ArchType get_arch_type() {
	
	struct utsname arch_info;
	
	// If it fails, we use the default mode (error and exit)
	if(uname(&arch_info) != 0) {
		fprintf(stderr, "Error: %s\n", strerror(errno));
		return ARCH_UNKNOWN;
	}
	
	// send back the arch type
	if(strcmp(arch_info.machine, "aarch64") == 0) return ARCH_AARCH64;
	if(strcmp(arch_info.machine, "x86_64") == 0) return ARCH_X86_64;
	if(strcmp(arch_info.machine, "armv7l") == 0) return ARCH_ARMV7;
	
	// Again! return default if no choice (error and exit)
	return ARCH_UNKNOWN;
}

const char *arch_type_to_string(ArchType arch) {
	
	switch (arch) {
		case ARCH_AARCH64: return "aarch64";
		case ARCH_X86_64: return "x86_64";
		case ARCH_ARMV7: return "armv7l";
		default: return "unknown";
	}
}