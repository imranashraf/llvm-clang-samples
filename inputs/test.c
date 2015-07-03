#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void initVecs(int *vec, int nElem)
{
    int i;
    for(i = 0; i < nElem; i++){
        printf("Address of init array %d = %p\n",i, vec);
        vec[i]=i;
    }
}

void sumVecs(int *sum, int *a, int *b, int nElem)
{
    int i;
    for(i = 0; i < nElem; i++)
    {
        sum[i] = a[i] + b[i];
    }
}

void diffVecs(int *sum, int *a, int *b, int nElem)
{
    int i;
    for(i = 0; i < nElem; i++)
    {
        sum[i] = a[i] - b[i];
    }
}

void process()
{
    int nElem=10;
    int nBytes = nElem*sizeof(int);
    int *Vecs[4];
    int i;
    for(i=0;i<4;i++)
    {
        Vecs[i] = malloc(nBytes);
        printf("Address of created array %d = %p\n",i, Vecs[i]);
    }

    initVecs(Vecs[0], nElem);
    initVecs(Vecs[1], nElem);
    sumVecs(Vecs[2],Vecs[0],Vecs[1],nElem);
    diffVecs(Vecs[3],Vecs[0],Vecs[1],nElem);

    printf("sum : %d\n", Vecs[2][0] );
    printf("diff : %d\n", Vecs[3][0] );

    for(i=0;i<4;i++)
    {
        free(Vecs[i]);
    }
}

int main()
{
    printf("Loop Allocation Test.\n");
    process();
    return 0;
}


/*
unsigned mult(unsigned a, unsigned b)
{
    unsigned i, s = 0, c =0;
    for (i = 0; i < a; ++i) 
    {
        for (i = 0; i < a; ++i)
        {
            c += i;
        }
        s += b + c;
    }

    for (i = 0; i < a; ++i)
        c += i;

    return s+c;
}

unsigned fact(unsigned a) {
  if (a <= 1) {
    return 1;
  } else {
    return a * fact(a - 1);
  }
}
*/