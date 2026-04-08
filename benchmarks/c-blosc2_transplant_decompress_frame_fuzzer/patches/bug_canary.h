#ifndef BUG_CANARY_H
#define BUG_CANARY_H

#include <stdint.h>

#define BUG_CANARY_NUM_BUGS 28
#define BUG_CANARY_SHM_NAME "/bug_canary"

struct bug_canary {
    uint64_t reached;
    uint64_t triggered;
    uint64_t timestamp_first_reached;
    uint64_t timestamp_first_triggered;
};

struct bug_canary_shm {
    volatile uint8_t faulty;
    struct bug_canary canaries[BUG_CANARY_NUM_BUGS];
};

/* Call at dispatch block entry (reached) and fault site (triggered).
 * Uses bitwise ops only — no implicit branches for coverage-guided fuzzers. */
void bug_canary_log(int bug_id, int trigger_condition);

/* Initialize shared memory region. Call once at program startup. */
void bug_canary_init(void);

#endif /* BUG_CANARY_H */
