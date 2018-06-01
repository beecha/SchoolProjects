#include "Huffman.h"

template <typename E>
LeafNode<E>::LeafNode(const E& val, int freq)
{
	it = val;
	wgt = freq;
}

template <typename E>
int LeafNode<E>::weight()
{
	return wgt;
}

template <typename E>
E LeafNode<E>::val()
{
	return it;
}

template <typename E>
bool LeafNode<E>::isLeaf()
{
	return true;
}

template <typename E>
IntlNode<E>::IntlNode(HuffNode<E>* l, HuffNode<E>* r)
{
	wgt = l->weight() + r->weight();
	lc = l;
	rc = r;
}

template <typename E>
int IntlNode<E>::weight()
{
	return wgt;
}

template <typename E>
bool IntlNode<E>::isLeaf()
{
	return false;
}

template <typename E>
HuffNode<E>* IntlNode<E>::left() const
{
	return lc;
}

template <typename E>
void IntlNode<E>::setLeft(HuffNode<E>* b)
{
	lc = b;
}

template <typename E>
HuffNode<E>* IntlNode<E>::right() const
{
	return rc;
}

template <typename E>
void IntlNode<E>::setRight(HuffNode<E>* b)
{
	rc = b;
}

template <typename E>
HuffTree<E>::HuffTree(E& val, int freq)
{
	Root = new LeafNode<E>(val, freq);
}

template <typename E>
HuffTree<E>::HuffTree(HuffTree<E>* l, HuffTree<E>* r)
{
	Root = new IntlNode<E>(l->root(), r->root());
}

template <typename E>
HuffNode<E>* HuffTree<E>::root()
{
	return Root;
}

template <typename E>
int HuffTree<E>::weight()
{
	return Root->weight();
}
