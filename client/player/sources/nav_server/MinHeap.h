#ifndef __MIN_HEAP_H__
#define __MIN_HEAP_H__

#include <stdio.h>
#include <iostream>

#include "Cell.h"

#define DEFAULT_HEAP_SIZE 512
//父节点下标
#define PARENTIDX(i) ((i-1)>>1)
//左子节点下标
#define LEFTIDX(i) ((i<<1)+1)
//右子节点下标
#define RIGHTIDX(i) ((i<<1)+2)

class CMinHeap
{
public:
    static CMinHeap* instance(bool isreset = false)
    {
        if (NULL == m_Instance)
        {
            m_Instance = new CMinHeap();
            m_Instance->init();
        }

        if (isreset)
        {
            m_Instance->reset();
        }

        return m_Instance;
    }

    static void destroy()
    {
        if (NULL != m_Instance)
        {
            m_Instance->uninit();
            delete m_Instance;
            m_Instance = NULL;
        }
    }

    //初始化最小堆，分配内存
    void init();

    //释放最小堆所占内存
    void uninit();

    //重置堆
    void reset();

    //最小堆出栈
    Cell* pop();

    //最小堆进栈
    void push(Cell* cell);

    //节点值更新，该cell必须是在堆中
    void update(Cell* cell);

    //最小堆当前的数量
    inline unsigned int size()
    {
        return m_Count;
    }

    inline void dump()
    {
       // printf("MinHeap Count %d:", m_Count);
      //  for (unsigned int i = 0; i < m_Count; ++i)
      //  {
     //       printf("%d ", m_Heap[i]->f);
     //   }
        //printf("\n");
    }

private:
    //自顶向下的最小堆重建
    void rebuildDown(unsigned int idx);

    //自下而上的最小堆重建
    void rebuildUp(unsigned int idx);

    //交换两个节点
    void swap(unsigned int a, unsigned int b);

    //当默认堆大小不足时，扩展堆内存，翻倍
    void resize();

private:
    Cell** m_Heap;                  //堆数组
    unsigned int m_MemSize;         //内存分配的大小
    unsigned int m_Count;           //当前堆的大小
    static CMinHeap* m_Instance;    //单例
};

#ifdef MINHEAPDBG

//测试代码
class Cell
{
public:
    int f;
    int heapId;
};

static void testHeap()
{
    CMinHeap* minheap = new CMinHeap();
    minheap->init();
    Cell* cell = new Cell();
    cell->f = 4;
    minheap->push(cell);
    cell = new Cell();
    cell->f = 1;
    minheap->push(cell);
    cell = new Cell();
    cell->f = 3;
    minheap->push(cell);
    cell = new Cell();
    cell->f = 2;
    minheap->push(cell);
    cell = new Cell();
    cell->f = 16;
    minheap->push(cell);
    cell = new Cell();
    cell->f = 9;
    minheap->push(cell);
    cell = new Cell();
    cell->f = 10;
    minheap->push(cell);
    cell = new Cell();
    cell->f = 14;
    minheap->push(cell);
    cell = new Cell();
    cell->f = 8;
    minheap->push(cell);
    cell = new Cell();
    cell->f = 7;
    minheap->push(cell);
    minheap->dump();

    minheap->pop();
    minheap->dump();
    minheap->pop();
    minheap->dump();
    minheap->pop();
    minheap->dump();

    cell->f = 0;
    minheap->update(cell);
    minheap->dump();

    cell->f = 20;
    minheap->update(cell);
    minheap->dump();

    return;
}
#endif

#endif
