#include <cstdlib>
#include <iostream>
#include <vector>


using namespace std;



void permute(vector<int> v, int i, int n)
{
	int j;
	if (i == n)
    {
		for (int k = 0; k <= n; k++)   // outputs one of the permutations
            {
                cout << v[k] << " ";
            }
		cout << endl;
    }
	else
        {
            for (j = i; j <= n; j++)    // for loop to go through the vector
                {
                    int tmp = v[i];     // tmp variable to do a swap
                    v[i] = v[j];
                    v[j] = tmp;         // swap v[i] & v[j]
                    permute(v,i+1,n);
                    tmp = v[i];          // swap back
                    v[i] = v[j];
                    v[j] = tmp;
                }
        }

}


int main()
{
	vector<int> v;                      //vector to hold 1,2,3,...,n
	int n;
	cout<<"Please inter an integer to permute : ";
	cin >> n;
	for (int i = 1; i < n+1; i++)
        {                                //pushing back into the vector 0 to n-1 times
		v.push_back(i);
        }
	permute(v,0,n-1);                   // calling the permute function
   
   system("PAUSE");
    return 0;
}
