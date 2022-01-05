#include <linux/kernel.h>
#include <linux/version.h>


#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0)
#include "v5.13.0/pl2303.c"

#else
#include "legacy/pl2303.c"

#endif
