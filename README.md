# Respring-Counter
A simple daemon that keeps count of how many resprings your device had since booting up

Add the following code:

``` objc
#include <notify.h>

#define PRGetRespringCount() ({ \
	dlopen("/Library/MobileSubstrate/DynamicLibraries/respringcounter.dylib", RTLD_LAZY); \
	uint64_t state; int token; \
	notify_register_check("com.uroboro.respringcounter.count", &token); \
	notify_get_state(token, &state); \
	notify_cancel(token); \
	state; })
```

And use the following to get the count

``` c
	uint64_t count = PRGetRespringCount();
```
