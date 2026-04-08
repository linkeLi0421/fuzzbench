#include "bug_canary.h"
#include <fcntl.h>
#include <sys/mman.h>
#include <time.h>
#include <string.h>
#include <unistd.h>

static struct bug_canary_shm *shm = NULL;

static uint64_t time_monotonic_ms(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

__attribute__((constructor))
void bug_canary_init(void) {
    if (shm) return;

    int fd = shm_open(BUG_CANARY_SHM_NAME, O_CREAT | O_RDWR, 0666);
    if (fd < 0) return;

    size_t sz = sizeof(struct bug_canary_shm);
    if (ftruncate(fd, sz) < 0) {
        close(fd);
        return;
    }
    shm = (struct bug_canary_shm *)mmap(NULL, sz,
        PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    close(fd);

    if (shm == MAP_FAILED) {
        shm = NULL;
        return;
    }
}

void bug_canary_log(int bug_id, int trigger_condition) {
    if (!shm) return;
    if (bug_id < 0 || bug_id >= BUG_CANARY_NUM_BUGS) return;

    volatile struct bug_canary *c = &shm->canaries[bug_id];
    volatile uint8_t *faulty = &shm->faulty;

    /* Magma-style always-evaluate with bitwise ops only.
     * No implicit branches — coverage-guided fuzzers cannot detect canary. */
    uint64_t not_faulty = 1 & (*faulty ^ 1);
    c->reached   += not_faulty;
    c->triggered += (uint64_t)(trigger_condition != 0) & not_faulty;
    *faulty = *faulty | (uint8_t)(trigger_condition != 0);

    /* Record first-reach/trigger timestamps */
    uint64_t now = time_monotonic_ms();
    if (c->timestamp_first_reached == 0)
        c->timestamp_first_reached = now;
    if ((trigger_condition != 0) && c->timestamp_first_triggered == 0)
        c->timestamp_first_triggered = now;
}
