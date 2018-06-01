#include <cstdlib>
#include <ctime>
#include <cstdio>

using namespace std;

typedef int array_t;
typedef long long data_t;

int randint(int min, int max)
{
	return rand() % (max - min + 1) + min;
}

void swap(int *array, int x, int y)
{
	int temp = array[x];
	array[x] = array[y];
	array[y] = temp;
}

array_t* generateArray(size_t size)
{
	array_t *array = new array_t[size];
	for(size_t i = 0; i < size; ++i)
	{
		array[i] = i;
	}
	for(size_t i = size - 1; i > 0; --i)
	{
		int j = randint(0, i);
		swap(array, i, j);
	}
	return array;
}

array_t* copyArray(array_t *array, size_t size)
{
	array_t *newArray = new array_t[size];
	for(size_t i = 0; i < size; ++i)
	{
		newArray[i] = array[i];
	}
	return newArray;
}

void insSort(array_t *array, size_t size, data_t &numSwaps, data_t &numComps)
{
	numSwaps = 0;
	numComps = 0;
	for(size_t i = 1; i < size; ++i)
	{
		for(size_t j = i; j > 0; --j)
		{
			++numComps;
			if(array[j] < array[j-1])
			{
				++numSwaps;
				swap(array, j, j-1);
			}
			else
			{
				break;
			}
		}
	}
}

void bubbleSort(array_t *array, size_t size, data_t &numSwaps, data_t &numComps)
{
	numSwaps = 0;
	numComps = 0;
	for(size_t i = 0; i < size - 1; ++i)
	{
		for(size_t j = 0; j < size - i - 1; ++j)
		{
			++numComps;
			if(array[j] > array[j+1])
			{
				++numSwaps;
				swap(array, j, j+1);
			}
		}
	}
}

void selectionSort(array_t *array, size_t size, data_t &numSwaps, data_t &numComps)
{
	numSwaps = 0;
	numComps = 0;
	for(size_t i = 0; i < size - 1; ++i)
	{
		int bigIndex = 0;
		for(size_t j = 1; j < size - i; ++j)
		{
			++numComps;
			if(array[j] > array[bigIndex])
			{
				bigIndex = j;
			}
		}
		++numSwaps;
		swap(array, bigIndex, size - i - 1);
	}
}

void mergeSortHelper(array_t *array, array_t *temp, int left, int right, data_t &numSwaps, data_t &numComps)
{
	if(left == right)
	{
		return;
	}
	int mid = (left + right) / 2;
	mergeSortHelper(array, temp, left, mid, numSwaps, numComps);
	mergeSortHelper(array, temp, mid + 1, right, numSwaps, numComps);
	for(array_t i = left; i <= right; ++i)
	{
		temp[i] = array[i];
	}
	int i1 = left;
	int i2 = mid + 1;
	for(int curr = left; curr <= right; ++curr)
	{
		++numSwaps;
		if(i1 > mid)
		{
			array[curr] = temp[i2++];
		}
		else if(i2 > right)
		{
			array[curr] = temp[i1++];
		}
		else
		{
			++numComps;
			if(temp[i1] <= temp[i2])
			{
				array[curr] = temp[i1++];
			}
			else
			{
				array[curr] = temp[i2++];
			}
		}
	}
}

void mergeSort(array_t *array, size_t size, data_t &numSwaps, data_t &numComps)
{
	numSwaps = 0;
	numComps = 0;
	array_t *temp = new array_t[size];
	mergeSortHelper(array, temp, 0, size - 1, numSwaps, numComps);
	delete[] temp;
}

int partition(array_t *array, int left, int right, array_t pivot, data_t &numSwaps, data_t &numComps)
{
	while(left <= right)
	{
		++numComps;
		while(array[left] < pivot)
		{
			++left;
			++numComps;
		}
		++numComps;
		while(right >= left && array[right] >= pivot)
		{
			--right;
			++numComps;
		}
		if(right > left)
		{
			++numSwaps;
			swap(array, left++, right--);
		}
	}
	return left;
}

void quickSortHelper(array_t *array, int i, int j, data_t &numSwaps, data_t &numComps)
{
	int pivotIndex = i;
	++numSwaps;
	swap(array, pivotIndex, j);
	int k = partition(array, i, j - 1, array[j], numSwaps, numComps);
	++numSwaps;
	swap(array, k, j);
	if(k - i > 1)
	{
		quickSortHelper(array, i, k - 1, numSwaps, numComps);
	}
	if(j - k > 1)
	{
		quickSortHelper(array, k + 1, j, numSwaps, numComps);
	}
}

void quickSort(array_t *array, size_t size, data_t &numSwaps, data_t &numComps)
{
	numSwaps = 0;
	numComps = 0;
	quickSortHelper(array, 0, size - 1, numSwaps, numComps);
}

void sortData(char *name, void (*sort)(array_t*, size_t, data_t&, data_t&), array_t *array10, array_t *array100, array_t *array1000, array_t *array10000, array_t *array100000, array_t *array1000000, array_t *arrayUp, array_t *arrayDown)
{
	data_t numSwaps, numComps;
	array_t *current = copyArray(array10, 10);
	sort(current, 10, numSwaps, numComps);
	printf("%-9s %3lld,%-3lld ", name, numSwaps, numComps);
	delete[] current;
	current = copyArray(array100, 100);
	sort(current, 100, numSwaps, numComps);
	printf("%5lld,%-5lld ", numSwaps, numComps);
	delete[] current;
	current = copyArray(array1000, 1000);
	sort(current, 1000, numSwaps, numComps);
	printf("%7lld,%-7lld ", numSwaps, numComps);
	delete[] current;
	current = copyArray(array10000, 10000);
	sort(current, 10000, numSwaps, numComps);
	printf("%9lld,%-9lld ", numSwaps, numComps);
	delete[] current;
	current = copyArray(array100000, 100000);
	sort(current, 100000, numSwaps, numComps);
	printf("%11lld,%-11lld ", numSwaps, numComps);
	delete[] current;
	current = copyArray(array1000000, 1000000);
	sort(current, 1000000, numSwaps, numComps);
	printf("%13lld,%-13lld ", numSwaps, numComps);
	delete[] current;
	current = copyArray(arrayUp, 10000);
	sort(current, 10000, numSwaps, numComps);
	printf("%9lld,%-9lld ", numSwaps, numComps);
	delete[] current;
	current = copyArray(arrayDown, 10000);
	sort(current, 10000, numSwaps, numComps);
	printf("%9lld,%-9lld\n", numSwaps, numComps);
	delete[] current;
}

int main()
{
	srand(static_cast<unsigned int>(time(NULL)));
	array_t *array10 = generateArray(10);
	array_t *array100 = generateArray(100);
	array_t *array1000 = generateArray(1000);
	array_t *array10000 = generateArray(10000);
	array_t *array100000 = generateArray(100000);
	array_t *array1000000 = generateArray(1000000);
	array_t *arrayUp = new array_t[10000];
	for(int i = 0; i < 10000; ++i)
	{
		arrayUp[i] = i;
	}
	array_t *arrayDown = new array_t[10000];
	for(int i = 0; i < 10000; ++i)
	{
		arrayDown[i] = 10000 - i - 1;
	}
	printf("Algorithm   10        100          1,000            10,000                100,000                  1,000,000                10K Up             10K Down\n");
	printf("--------- ------- ----------- --------------- ------------------- ----------------------- --------------------------- ------------------- -------------------\n");
	sortData("Insertion", insSort, array10, array100, array1000, array10000, array100000, array1000000, arrayUp, arrayDown);
	sortData("Bubble", bubbleSort, array10, array100, array1000, array10000, array100000, array1000000, arrayUp, arrayDown);
	sortData("Selection", selectionSort, array10, array100, array1000, array10000, array100000, array1000000, arrayUp, arrayDown);
	sortData("Merge", mergeSort, array10, array100, array1000, array10000, array100000, array1000000, arrayUp, arrayDown);
	sortData("Quick", quickSort, array10, array100, array1000, array10000, array100000, array1000000, arrayUp, arrayDown);
	delete[] array10;
	delete[] array100;
	delete[] array1000;
	delete[] array10000;
	delete[] array100000;
	delete[] array1000000;
	delete[] arrayUp;
	delete[] arrayDown;
	system("PAUSE");
	return 0;
}