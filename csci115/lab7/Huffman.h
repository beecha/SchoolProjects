#ifndef HUFFMAN_H_
#define HUFFMAN_H_

template <typename E>
class HuffNode
{
public:
	virtual ~HuffNode() {}
	virtual int weight() = 0;
	virtual bool isLeaf() = 0;
};

template <typename E>
class LeafNode : public HuffNode<E>
{
public:
	LeafNode(const E& val, int freq);
	virtual int weight();
	E val();
	virtual bool isLeaf();

private:
	E it;
	int wgt;
};

template <typename E>
class IntlNode : public HuffNode<E>
{
public:
	IntlNode(HuffNode<E>* l, HuffNode<E>* r);
	virtual int weight();
	virtual bool isLeaf();
	inline HuffNode<E>* left() const;
	inline void setLeft(HuffNode<E>* b);
	inline HuffNode<E>* right() const;
	inline void setRight(HuffNode<E>* b);

private:
	HuffNode<E>* lc;
	HuffNode<E>* rc;
	int wgt;
};

template <typename E>
class HuffTree
{
public:
	HuffTree(E& val, int freq);
	HuffTree(HuffTree<E>* l, HuffTree<E>* r);
	~HuffTree() {}
	HuffNode<E>* root();
	int weight();

private:
	HuffNode<E>* Root;
};

#endif // HUFFMAN_H_