#include <notify.h>

%ctor {
	notify_post("com.uroboro.respringcounter.count");
}
%dtor {
	notify_post("com.uroboro.respringcounter.tnuoc");
}
