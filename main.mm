#include <notify.h>

static const char *syslogPrefix = "\x1b[1;34m[RespringCounter]\x1b[0m";

static const char *countNotification  = "com.uroboro.respringcounter.count";
static const char *tnuocNotification  = "com.uroboro.respringcounter.tnuoc";

int main(int argc, char **argv, char **envp) {
	uint64_t count = 0;
	char alive = 0;
	
	int fd;
	int countToken = 0;
	if (notify_register_file_descriptor(countNotification, &fd, 0, &countToken) != NOTIFY_STATUS_OK) {
		return 1;
	}
	int tnuocToken = 0;
	if (notify_register_file_descriptor(tnuocNotification, &fd, NOTIFY_REUSE, &tnuocToken) != NOTIFY_STATUS_OK) {
		return 1;
	}

	fd_set readfds;
	FD_ZERO(&readfds);
	FD_SET(fd, &readfds);

	while (1) {
		int status = select(fd + 1, &readfds, NULL, NULL, NULL);
		if (status <= 0 || !FD_ISSET(fd, &readfds)) {
			continue;
		}

		int t;
		status = read(fd, &t, sizeof(int));
		if (status < 0) {
			continue;
		}
		t = ntohl(t); // notify_register_file_descriptor docs: "The value is sent in network byte order."

		// Value in file descriptor matches token for count notification
		if (t == countToken && !alive) {
			alive = 1;
			uint32_t r = notify_set_state(countToken, count);
			NSLog(@"%s could %sset \"%s\" to %llu.", syslogPrefix, (r)?"not ":"", countNotification, count);
			count++;
		}

		// Value in file descriptor matches token for tnuoc notification
		if (t == tnuocToken) {
			alive = 0;
		}
	}

	// Cancel notification watching
	notify_cancel(countToken);
	notify_cancel(tnuocToken);

	return 0;
}
