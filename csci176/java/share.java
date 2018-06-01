public class share
{
	public static void main(String[] args) throws InterruptedException
	{
		Pthread p = new Pthread(0);
		System.out.println("Before Count = " + p.getCount() );
		
		Thread t1 = new Thread(p, "t1");
		Thread t2 = new Thread(p, "t2");
		Thread t3 = new Thread(p, "t3");
		t1.start();
		t2.start();
		t3.start();
		
		t1.join();
		t2.join();
		t3.join();
		
		System.out.println("After Count = " + p.getCount() );
		
	}
	
}

class Pthread implements Runnable
{
	private int count;
	
	//Constructor
	public Pthread(int x)
	{
		this.count = x;
	}
	
	//Method for thread to run on
	@Override
	public void run()
	{
		//This will get the rank of the thread
		//Where the number 3 is the number of threads
		long threadID = Thread.currentThread().getId() % 3;
		
		System.out.println("Thread #" + threadID + " is running...");
		for (int i = 0; i < 5; i++)
		{
			//Do something
			count++;
		}
	}
	
	public int getCount()
	{
		return this.count;
	}
	
	
}