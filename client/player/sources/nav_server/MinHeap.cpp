#include "MinHeap.h"

CMinHeap* CMinHeap::m_Instance = NULL;

void CMinHeap::init()
{
    m_Heap = reinterpret_cast<Cell**>(malloc(
        DEFAULT_HEAP_SIZE * sizeof(Cell*)));
    memset(m_Heap, 0, DEFAULT_HEAP_SIZE * sizeof(Cell*));
    m_Count = 0;
    m_MemSize = DEFAULT_HEAP_SIZE;
}

void CMinHeap::uninit()
{
    free(m_Heap);
    m_Count = 0;
    m_MemSize = 0;
}

void CMinHeap::reset()
{
    memset(m_Heap, 0, m_MemSize * sizeof(Cell*));
    m_Count = 0;
}

Cell* CMinHeap::pop()
{
    if (0 == m_Count)
    {
        return NULL;
    }

    //�����һ������Ϊ��С�Ѹ��ڵ�
    Cell* ret = m_Heap[0];
    --m_Count;

    if (m_Count > 0)
    {
        m_Heap[0] = m_Heap[m_Count];
    }
    m_Heap[m_Count] = NULL;

    if (NULL != m_Heap[0]
    && m_Heap[0] != ret)
    {
        //���϶���
        m_Heap[0]->heapId = 0;
        rebuildDown(0);
    }

    ret->heapId = -1;
    return ret;
}

void CMinHeap::push(Cell* cell)
{
    if (NULL == cell)
    {
        return;
    }

    if (m_MemSize == m_Count)
    {
        resize();
    }

    //1.���뵽β��
    m_Heap[m_Count] = cell;
    cell->heapId = m_Count;

    //2.������С��
    rebuildUp(m_Count);

    ++m_Count;

    dump();
}

void CMinHeap::rebuildDown(unsigned int idx)
{
    if (m_Count <= 1
        || idx >= m_Count)
    {
        return;
    }

    //1.�Ӹ��ڵ���������
    unsigned int currentIdx = idx;
    //���϶��µĶ�����
    unsigned int left, right;
    unsigned int leastIdx = currentIdx;

    while(true)
    {
        left = LEFTIDX(currentIdx);
        right = RIGHTIDX(currentIdx);

        //�ҵ���С�ӽڵ�
        if (left < m_Count
            && m_Heap[currentIdx]->f > m_Heap[left]->f)
        {
            leastIdx = left;
        }

        if (right < m_Count
            && m_Heap[leastIdx]->f > m_Heap[right]->f)
        {
            leastIdx = right;
        }

        //�����ǰ�ڵ�����С�ڵ㣬����ؽ�
        if (leastIdx == currentIdx)
        {
            break;
        }

        //������С�ڵ�
        swap(currentIdx, leastIdx);
        currentIdx = leastIdx;
    }
}

void CMinHeap::rebuildUp(unsigned int idx)
{
    unsigned int currentIdx = idx;
    unsigned int parentIdx = PARENTIDX(currentIdx);

    //�Ե����Ͻ��ж�����
    while(true)
    {
        //1.Ϊ���ڵ�
        //2.Ȩֵ���丸�ڵ��
        if (currentIdx == 0
            || m_Heap[parentIdx]->f <= m_Heap[currentIdx]->f)
        {
            break;
        }

        //3.Ȩֵ�ȸ��ڵ�С������
        swap(currentIdx, parentIdx);
        currentIdx = parentIdx;
        parentIdx = PARENTIDX(currentIdx);
    }
}

void CMinHeap::update(Cell* cell)
{
    if (NULL == cell
        || cell->heapId >= m_Count)
    {
        return;
    }

    //�ȼ���Ƿ�
    unsigned int parentIdx;
    if (cell->heapId == 0)
    {
        parentIdx = 0;
    }
    else
    {
        parentIdx = PARENTIDX(cell->heapId);
    }

    if (parentIdx != cell->heapId
        && m_Heap[parentIdx]->f > cell->f)
    {
        rebuildUp(cell->heapId);
    }
    else
    {
        rebuildDown(cell->heapId);
    }
}

//�ϲ㸺���±�İ�ȫ���
void CMinHeap::swap(unsigned int a, unsigned int b)
{
    Cell* tmpcell = m_Heap[a];
    m_Heap[a] = m_Heap[b];
    m_Heap[b] = tmpcell;

    unsigned int heapId = m_Heap[a]->heapId;
    m_Heap[a]->heapId = m_Heap[b]->heapId;
    m_Heap[b]->heapId = heapId;
}

void CMinHeap::resize()
{
    m_MemSize = m_MemSize<<1;
    realloc(m_Heap, m_MemSize);
}
