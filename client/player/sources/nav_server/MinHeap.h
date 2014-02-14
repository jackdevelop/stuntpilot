#ifndef __MIN_HEAP_H__
#define __MIN_HEAP_H__

#include <stdio.h>
#include <iostream>

#include "Cell.h"

#define DEFAULT_HEAP_SIZE 512
//���ڵ��±�
#define PARENTIDX(i) ((i-1)>>1)
//���ӽڵ��±�
#define LEFTIDX(i) ((i<<1)+1)
//���ӽڵ��±�
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

    //��ʼ����С�ѣ������ڴ�
    void init();

    //�ͷ���С����ռ�ڴ�
    void uninit();

    //���ö�
    void reset();

    //��С�ѳ�ջ
    Cell* pop();

    //��С�ѽ�ջ
    void push(Cell* cell);

    //�ڵ�ֵ���£���cell�������ڶ���
    void update(Cell* cell);

    //��С�ѵ�ǰ������
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
    //�Զ����µ���С���ؽ�
    void rebuildDown(unsigned int idx);

    //���¶��ϵ���С���ؽ�
    void rebuildUp(unsigned int idx);

    //���������ڵ�
    void swap(unsigned int a, unsigned int b);

    //��Ĭ�϶Ѵ�С����ʱ����չ���ڴ棬����
    void resize();

private:
    Cell** m_Heap;                  //������
    unsigned int m_MemSize;         //�ڴ����Ĵ�С
    unsigned int m_Count;           //��ǰ�ѵĴ�С
    static CMinHeap* m_Instance;    //����
};

#ifdef MINHEAPDBG

//���Դ���
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
