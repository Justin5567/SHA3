// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  schedNewEvent (struct dummyq_struct * I1406, EBLK  * I1401, U  I623);
void  schedNewEvent (struct dummyq_struct * I1406, EBLK  * I1401, U  I623)
{
    U  I1670;
    U  I1671;
    U  I1672;
    struct futq * I1673;
    struct dummyq_struct * pQ = I1406;
    I1670 = ((U )vcs_clocks) + I623;
    I1672 = I1670 & ((1 << fHashTableSize) - 1);
    I1401->I665 = (EBLK  *)(-1);
    I1401->I666 = I1670;
    if (0 && rmaProfEvtProp) {
        vcs_simpSetEBlkEvtID(I1401);
    }
    if (I1670 < (U )vcs_clocks) {
        I1671 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1401, I1671 + 1, I1670);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I623 == 1)) {
        I1401->I668 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I665 = I1401;
        peblkFutQ1Tail = I1401;
    }
    else if ((I1673 = pQ->I1309[I1672].I688)) {
        I1401->I668 = (struct eblk *)I1673->I686;
        I1673->I686->I665 = (RP )I1401;
        I1673->I686 = (RmaEblk  *)I1401;
    }
    else {
        sched_hsopt(pQ, I1401, I1670);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
