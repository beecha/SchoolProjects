#include <cstdlib>
#include <iostream>
#include <vector>


using namespace std;

int counter = 0;

void TOH1 (int p1, int p2, int p3, int n)    //function for TOH that is available in the textbook
{
  if (n == 0) return;

  TOH1 (p1,p3,p2,n-1);
  cout << p1 << " " << p3 << endl;
  counter = counter + 1;
  TOH1 (p2,p1,p3,n-1);
}



//Since all of the elements on pole 2 are larger than any element on pole 1, pole 2
//can be considered empty with respect to pole 1 and so the usual TOH program can move
//all of the elements of pole 1 to pole 3 using pole 2.  The trick is to first put
//an element from pole 2 on pole 3 and then move the contents of pole 1 to pole 3. Now
//that pole 1 is empty, move the top element of pole 2 to pole 1 and then use the usual
//TOH program to move all of pole 1 back to pole 3 using pole 2.  Continue this idea
//until done.  (If n is even, you must first move the contents of pole 1 to pole 3
//before moving anything from the original pole 2.)

int main()
{
	int n;
	cin >> n;
	if (n%2 == 1)       //if n is odd -- move top of pole 2 to pole 3
        {
            int a = 1;
            int b = 2;
            int c = 3;
            for (int j = 0; j < n; j++)
                {
                    cout << b << " " << c << endl;
                    counter+=1;
                    TOH1 (a,b,c,n+j);          // calling the tower of hanoi function
                    int tmp = a;            // swapping will take place
                    a = c;
                    c = tmp;
                }
        }
    else                        // if n is even move contents of pole 1 to pole 3
        {
            int a = 1;
            int b = 2;
            int c = 3;
            TOH1(a,b,c,n);
            a = 3;
            c = 1;
            for (int j = 0; j < n; j++)
                {
                    cout << b << " " << c << endl;
                    counter+=1;
                    TOH1 (a,b,c,n+j);
                    int tmp = a;
                    a = c;
                    c = tmp;
                }
        }

	cout << "counter = " << counter << endl; // just outputs the total number of moves
	
	system("PAUSE");
    return 0;
}
