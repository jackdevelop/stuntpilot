#ifndef _HEAP_H
#define _HEAP_H

#include <stdio.h>
#include <algorithm>
#include <vector>

#include "Cell.h"

using namespace std;

class Heap
{
    private:
        vector<Cell*> v;
    public:
        Heap(void);
        void push(Cell *val);
        Cell *pop(void);
        int size(void);
        void clear(void);
        void dump(void);
};

#endif
