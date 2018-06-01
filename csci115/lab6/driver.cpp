#include "bst.cpp"
#include <cstdlib>

using std::cout;
using std::endl;

int main()
{
	BST tree;
	tree.insert(6);
	tree.insert(9);
	tree.insert(20);
	tree.insert(7);
	tree.insert(2);
	tree.insert(0);
	tree.insert(19);

	bool correct = true;

	cout << "Printing all numbers between 0 and 20" << endl;
	cout << "Should be 0 2 6 7 9 19 20" << endl;
	int nodes = tree.printBetween(0, 20);
	cout << "Nodes touched: " << nodes << endl;
	if (nodes != 7)
	{
		correct = false;
		cout << "Expected nodes touched is 7" << endl;
	}
	cout << endl;

	cout << "Printing all numbers between 5 and 8" << endl;
	cout << "Should be 6 7" << endl;
	nodes = tree.printBetween(5, 8);
	cout << "Nodes touched: " << nodes << endl;
	if (nodes != 4)
	{
		correct = false;
		cout << "Expected nodes touched is 4" << endl;
	}
	cout << endl;

	cout << "Printing all numbers between 15 and 20" << endl;
	cout << "Should be 19 20" << endl;
	nodes = tree.printBetween(15, 20);
	cout << "Nodes touched: " << nodes << endl;
	if (nodes != 4)
	{
		correct = false;
		cout << "Expected nodes touched is 4" << endl;
	}
	cout << endl;

	int number = tree.getSmall(1);
	cout << "Smallest: " << number << endl;
	if (number != 0)
	{
		correct = false;
		cout << "Expected 0" << endl;
	}

	number = tree.getSmall(2);
	cout << "2nd smallest: " << number << endl;
	if (number != 2)
	{
		correct = false;
		cout << "Expected 2" << endl;
	}

	number = tree.getSmall(3);
	cout << "3rd smallest: " << number << endl;
	if (number != 6)
	{
		correct = false;
		cout << "Expected 6" << endl;
	}

	number = tree.getSmall(4);
	cout << "4th smallest: " << number << endl;
	if (number != 7)
	{
		correct = false;
		cout << "Expected 7" << endl;
	}

	number = tree.getSmall(5);
	cout << "5th smallest: " << number << endl;
	if (number != 9)
	{
		correct = false;
		cout << "Expected 9" << endl;
	}

	number = tree.getSmall(6);
	cout << "6th smallest: " << number << endl;
	if (number != 19)
	{
		correct = false;
		cout << "Expected 19" << endl;
	}

	number = tree.getSmall(7);
	cout << "7th smallest: " << number << endl;
	if (number != 20)
	{
		correct = false;
		cout << "Expected 20" << endl;
	}
	cout << endl;

	if(correct)
	{
		cout << "All tests passed." << endl;
	}
	else
	{
		cout << "A test failed to pass." << endl;
	}
	system("PAUSE");
	return 0;
}
