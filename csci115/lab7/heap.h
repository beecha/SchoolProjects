#ifndef HEAP_H_
#define HEAP_H_

template <typename E, typename Comp>
class heap
{
public:
	heap(E* h, int num, int max);
	inline int size() const;
	inline bool isLeaf(int pos) const;
	inline int leftchild(int pos);
	inline int rightchild(int pos);
	inline int parent(int pos);
	void buildHeap();
	void insert(const E& it);
	E removefirst();
	E remove(int pos);
	int getReads() const;
	int getWrites() const;

private:
	E* Heap;
	int maxsize;
	int n;
	int reads;
	int writes;

	void siftdown(int pos);
	static void swap(E* h, int x, int y);
};

#endif // HEAP_H_