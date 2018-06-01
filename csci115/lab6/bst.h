#ifndef BST_H_
#define BST_H_

class Node;

class BST
{
public:
	BST();
	~BST();

	void insert(int k);
	int getSmall(int k) const;
	int printBetween(int min, int max) const;
private:
	Node* root;
};

#endif // BST_H_