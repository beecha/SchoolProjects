#include "bst.h"
#include <cstddef>
#include <iostream>

using std::cout;
using std::endl;

void insertHelp(Node* tree, int k);
int getSmallHelp(const Node* const tree, int k);
int printHelp(const Node* const tree, int min, int max);

class Node
{
public:
	explicit Node(int k);
	~Node();

	inline int getVal() const;
	inline Node* getLeft() const;
	inline Node* getRight() const;
	inline int getNumSmaller() const;
	inline void setLeft(Node* l);
	inline void setRight(Node* r);
	inline void incrementNumSmaller();

private:
	int val;
	Node* left;
	Node* right;
	// numSmaller = sizeof(leftSubtree)
	int numSmaller;
};

Node::Node(int k):
val(k), left(NULL), right(NULL), numSmaller(0)
{}

Node::~Node()
{
	delete left;
	delete right;
}

int Node::getVal() const
{
	return val;
}

Node* Node::getLeft() const
{
	return left;
}

Node* Node::getRight() const
{
	return right;
}

int Node::getNumSmaller() const
{
	return numSmaller;
}

void Node::setLeft(Node* l)
{
	left = l;
}

void Node::setRight(Node* r)
{
	right = r;
}

void Node::incrementNumSmaller()
{
	++numSmaller;
}

BST::BST():
root(NULL)
{}

BST::~BST()
{
	delete root;
}

void BST::insert(int k)
{
	if (root == NULL)
	{
		root = new Node(k);
	}
	else
	{
		insertHelp(root, k);
	}
}

int BST::getSmall(int k) const
{
	if (root == NULL)
	{
		cout << "Empty tree" << endl;
		return 0;
	}
	else
	{
		return getSmallHelp(root, k - 1);
	}
}

int BST::printBetween(int min, int max) const
{
	if (root == NULL)
	{
		cout << "Empty tree" << endl;
		return 0;
	}
	else
	{
		int ret = printHelp(root, min, max);
		cout << endl;
		return ret;
	}
}

void insertHelp(Node* tree, int k)
{
	if (k <= tree->getVal())
	{
		if (tree->getLeft() == NULL)
		{
			tree->setLeft(new Node(k));
		}
		else
		{
			insertHelp(tree->getLeft(), k);
		}
		/*
		 * This is why numSmaller remains accurate.
		 * Whenever anything is added to the left subtree,
		 * whether the subtree existed before or not,
		 * numSmaller will be incremented due to the new node.
		 */
		tree->incrementNumSmaller();
	}
	else
	{
		/*
		 * numSmaller is untouched when a new item
		 * is put in the right subtree.
		 */
		if (tree->getRight() == NULL)
		{
			tree->setRight(new Node(k));
		}
		else
		{
			insertHelp(tree->getRight(), k);
		}
	}
}

int getSmallHelp(const Node* const tree, int k)
{
	if (tree->getNumSmaller() == k)
	{
		return tree->getVal();
	}
	else if (tree->getNumSmaller() > k)
	{
		return getSmallHelp(tree->getLeft(), k);
	}
	else
	{
		return getSmallHelp(tree->getRight(), k - tree->getNumSmaller() - 1);
	}
	return 0;
}

int printHelp(const Node* const tree, int min, int max)
{
	int val = tree->getVal();
	Node* left = tree->getLeft();
	Node* right = tree->getRight();
	int numNodes = 1;
	if (left != NULL && val >= min)
	{
		numNodes += printHelp(left, min, max);
	}	
	if (val >= min && val <= max)
	{
		cout << val << ' ';
	}
	if (right != NULL && val <= max)
	{
		numNodes += printHelp(right, min, max);
	}
	return numNodes;
}