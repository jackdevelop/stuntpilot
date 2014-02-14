#include "Heap.h"

bool cmpCallback(Cell *a, Cell *b)
{
    return (b->f < a->f);
}

Heap::Heap(void)
{
    v.clear();
    make_heap(v.begin(), v.end(), cmpCallback);
}

void Heap::push(Cell *val)
{
    v.push_back(val);
   // push_heap(v.begin(), v.end(), cmpCallback);
}

Cell *Heap::pop(void)
{
    if (v.size() > 0)
    {
        make_heap(v.begin(), v.end(), cmpCallback);
        pop_heap(v.begin(), v.end(), cmpCallback);
        Cell* ret = v.back();
        v.pop_back();
        return ret;
    }

    return NULL;
}

int Heap::size(void)
{
    return v.size();
}

void Heap::clear(void)
{
    v.clear();
}

void Heap::dump(void)
{
    printf("current heap data:\n");
    for (vector<Cell*>::iterator it = v.begin(); it != v.end(); ++it) {
        printf("%d ", (*it)->index);
    }
    printf("\n");
}
