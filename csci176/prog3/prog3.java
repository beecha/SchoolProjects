public class prog3
{
    int l = 4, m = 5, n = 6;
    public globals g = new globals(l, m, n);
    public communication c;
    
    public static void main(String args[])
    {
		
    }
    
}


// The shared object that will hold the matrix
class globals
{
    public int [][] A;
    public int [][] B;
    public int [][] C;
    
    // Constructor to set size of matrix
    public globals(int l, int m, int n)
    {
        // Matrix A is l x m
        A = new int[l][m];
        
        // Matrix B is m x n
        B = new int[m][n];
        
        // Matrix C is l x n
        C = new int[l][n];
        
        
        // Initialize values for A and B
        for (int i = 0; i < l; i++)
		{
			
			for (int j = 0; j < m; j++)
			{
				A[i][j] = i+j;
			}
			
		}
		
		for (int i = 0; i < m; i++)
		{
			
			for (int j = 0; j < n; j++)
			{
				B[i][j] = i+j+1;
			}
			
		}
    }
    
}

class test
{
	private int i;
	
	public test(int j)
	{
		this.i = j;
	}
	
	public void get_num()
	{
		System.out.println(i);
	}
}

// The shared object that will synchronize communication between threads
class communication
{
    private static int counter = 0;
    
    // Synchronized method will do wait and notify
    public synchronized void increment(int id)
    {
        // Master Thread will wait() until all worker
        // threads have finish. When the last thread
        // is done, it will call notify() to wake up 
        // the master thread. When counter is equal 
        // to the number of threads, we will call 
        // the notify() method
        
        // If (I'm MasterThread)
        //   While (Worker Thread not done)
        //      MasterThread.wait()
        // else
        //   wait for notify()
    }
}

class myThread extends Thread
{
    static globals G;
    static communication C;
    private int id;
    
    // Constructor for passing arguments into threads
    public myThread(int i, globals glob, communication comm)
    {
        // Local parameters will be assigned to each thread
        this.id = i;
        this.G = glob;
        this.C = comm;
    }
    
    // This class method implements runnable threads
    public void run()
    {
        // Matrix computation will go here 
        // Each thread has different bounds for 
        // their starting index and ending index
        // If N = 16, T = 4, then
        // Local n = 16/4 = 4
        // So each thread perform work on 4 elements
        
        
    }
}
