#include "heap.cpp"
#include "Huffman.cpp"
#include <iostream>
#include <string>
#include <algorithm>
#include <sstream>
#include <cassert>

using namespace std;

#define MAX_SIZE 100

class CompleteHuffNode
{
public:
	CompleteHuffNode():
	character(0), code("")
	{}
	CompleteHuffNode(char character, const string &code):
	character(character), code(code)
	{}
	char getCharacter() const {return character;}
	const string& getCode() const {return code;}
	bool operator<(const CompleteHuffNode &other) const
	{return character < other.character;}
private:
	char character;
	string code;
};

CompleteHuffNode huffArray[MAX_SIZE];

template <typename E>
class minComp
{
public:
	static bool prior(HuffTree<E> *x, HuffTree<E> *y)
	{
		return x->weight() <= y->weight();
	}
};

typedef HuffTree<char> Tree;
typedef heap<Tree*, minComp<char> > HeapTree;

template<typename E>
E strToNum(const string &in)
{
	E out;
	stringstream buffer(in);
	buffer >> out;
	return out;
}

Tree** getValues(string data, int &size)
{
	size = count(data.begin(), data.end(), ' ') / 2 + 1;
	assert(size < MAX_SIZE);
	Tree** trees = new Tree*[size];
	for (int i = 0; i < size; ++i)
	{
		char character = data[0];
		data = data.substr(2);
		size_t pos = data.find_first_of(' ');
		string amount = data.substr(0, pos);
		data = data.substr(pos + 1);
		trees[i] = new Tree(character, strToNum<int>(amount));
	}
	return trees;
}

void deleteTree(HuffNode<char> *root)
{
	if (root->isLeaf())
	{
		delete root;
	}
	else
	{
		IntlNode<char> *node = static_cast<IntlNode<char>*>(root);
		deleteTree(node->left());
		deleteTree(node->right());
		delete node;
	}
}

template <typename E>
HuffTree<E>* buildHuff(HuffTree<E> **treeArray, int count, int &numReads, int &numWrites)
{
	heap<HuffTree<E>*, minComp<E> > forest(treeArray, count, count);
	HuffTree<E> *temp1, *temp2, *temp3 = NULL;
	while (forest.size() > 1)
	{
		temp1 = forest.removefirst();
		temp2 = forest.removefirst();
		temp3 = new HuffTree<E>(temp1, temp2);
		forest.insert(temp3);
		delete temp1;
		delete temp2;
	}
	numReads = forest.getReads();
	numWrites = forest.getWrites();
	return forest.removefirst();
}

int fillArrayHelper(HuffNode<char> *root, const string &code, int i)
{
	if (root != NULL)
	{
		if (root->isLeaf())
		{
			LeafNode<char>* node = static_cast<LeafNode<char>*>(root);
			huffArray[i] = CompleteHuffNode(node->val(), code);
			return i + 1;
		}
		else
		{
			IntlNode<char> *node = static_cast<IntlNode<char>*>(root);
			int j = fillArrayHelper(node->left(), code + "0", i);
			return fillArrayHelper(node->right(), code + "1", j);
		}
	}
	else
	{
		return i;
	}
}

void fillArray(Tree *tree)
{
	int size = fillArrayHelper(tree->root(), "", 0);
	sort(huffArray, &(huffArray[size]));
}

const string& binarySearch(char character, int min, int max)
{
	int mid = (max + min) / 2;
	if (huffArray[mid].getCharacter() == character)
	{
		return huffArray[mid].getCode();
	}
	else if (huffArray[mid].getCharacter() > character)
	{
		return binarySearch(character, min, mid);
	}
	else
	{
		return binarySearch(character, mid, max);
	}
}

string decode(const string &input, HuffNode<char> *root, HuffNode<char> *original)
{
	if (root->isLeaf())
	{
		LeafNode<char> *node = static_cast<LeafNode<char>*>(root);
		string ret(1, node->val());
		return ret + decode(input, original, original);
	}
	else
	{
		if (input.empty())
		{
			return "";
		}
		else
		{
			IntlNode<char> *node = static_cast<IntlNode<char>*>(root);
			return decode(input.substr(1), input[0] == '0' ? node->left() : node->right(), original);
		}
	}
}

int main()
{
	bool running = true;
	int size = 0;
	Tree **trees = NULL;
	Tree *mainTree = NULL;
	while (running)
	{
		cout << "Enter a command. (Useful commands: \"exit\", \"help\")" << endl << '>';
		string input;
		getline(cin, input);
		if (input == "exit")
		{
			running = false;
		}
		else if (input == "help")
		{
			cout << endl;
			cout << "Start your input with a '1' to build a new Huffmann tree." << endl;
			cout << "After the 1, enter a list of letters and numbers separated\nby spaces for the tree's contents." << endl;
			cout << "Example: >1 a 5 b 10 c 3" << endl;
			cout << endl;
			cout << "Start your input with a '2' to encode a message with the tree." << endl;
			cout << "After the 2, enter the message to encode." << endl;
			cout << "Example: >2 acba" << endl;
			cout << endl;
			cout << "Start your input with a '3' to decode a message with the tree." << endl;
			cout << "After the 3, enter the message to decode." << endl;
			cout << "Example: >3 0100101" << endl;
			cout << endl;
			cout << "Note that all inputs for options 2 and 3 have to be\nin the tree made with option 1." << endl;
			cout << endl;
		}
		else if (!input.empty())
		{
			if (input[0] == '1')
			{
				if (size > 0)
				{
					deleteTree(trees[0]->root());
					delete trees[0];
				}
				delete[] trees;
				trees = getValues(input.substr(2), size);
				// Don't need to delete the old mainTree since it was also located in trees[0].
				int numReads;
				int numWrites;
				mainTree = buildHuff(trees, size, numReads, numWrites);
				fillArray(mainTree);
				for (int i = 0; i < size; ++i)
				{
					cout << huffArray[i].getCharacter() << ' ' << huffArray[i].getCode() << ' ';
				}
				cout << '(' << numReads << ", " << numWrites << ')' << endl << endl;
			}
			else if (input[0] == '2')
			{
				for (int i = 2; i < input.size(); ++i)
				{
					string code = binarySearch(input[i], 0, size);
					cout << code;
				}
				cout << endl << endl;
			}
			else if (input[0] == '3')
			{
				cout << decode(input.substr(2), mainTree->root(), mainTree->root()) << endl << endl;
			}
			else
			{
				cout << "Invalid command." << endl << endl;
			}
		}
	}
	if (size > 0)
	{
		deleteTree(trees[0]->root());
		delete trees[0];
	}
	delete[] trees;
	return 0;
}