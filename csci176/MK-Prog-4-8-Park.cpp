/////////////////////////////////////
//// Park -- semaphore solution to producer-consumer synchronization -- C++ version.
////
//// Each thread sends a message to the next thread, and displays msg received from 
//// one previous thread.
//// This version uses named semaphores, since unnamed semaphores aren't available 
//// in MacOS X (as of 10.6).
////
//// $> g++ -lpthread MK-Prog-4-8-Park.cpp
//// $>./a.out 4  //or any
/////////////////////////////////////

#include <iostream>
#include <pthread.h>   //for pthread
#include <semaphore.h> //for semaphore
#include <string>
#include <sstream>     //for int to string conversion
//#include <time.h>    //for checking exec time
using namespace std;

//globals --accessible to all threads
int num_threads;
string* msg_array;     //dynamic array of messages
string* semName_array; //dynamic array of semaphore names (needed for MacOSX)
sem_t** sem_array;     //dynamic array of semaphore ptr's
pthread_mutex_t mutex1;//for atomic cout statement

void *Send_msg(void* rank); //prototype - thread slave function

//////////////////////////////////
int main(int argc, char* argv[]) 
{
   int thread_id;
   num_threads = atoi(argv[1]); //command line arg - tot num of threads
  
   pthread_t* myThreads; myThreads=new pthread_t[num_threads]; 
   //pthread_t myThreads[num_threads]; //simple way --this also works
   pthread_mutex_init(&mutex1, NULL);

   msg_array = new string[num_threads];
   for(thread_id = 0; thread_id < num_threads; thread_id++)
     msg_array[thread_id] = ""; //initialize with empty strings

   sem_array = new sem_t*[num_threads];
   semName_array = new string[num_threads]; //MacOSX needs semaphore name
  
   for (thread_id = 0; thread_id < num_threads; thread_id++) 
   { semName_array[thread_id] = "sem_"+thread_id;
     sem_array[thread_id] = sem_open(semName_array[thread_id].c_str(), O_CREAT, 0777, 0);
     //initialize sem to 0 (locked); sem_open needs c_str type;
   }
   for (thread_id = 0; thread_id < num_threads; thread_id++)
     pthread_create(&myThreads[thread_id], NULL, Send_msg, (void*) thread_id);

   for (thread_id = 0; thread_id < num_threads; thread_id++) 
     pthread_join(myThreads[thread_id], NULL);

   for (thread_id = 0; thread_id < num_threads; thread_id++) 
   { sem_unlink(semName_array[thread_id].c_str());
     sem_close(sem_array[thread_id]);
   }
   //delete[] sem_array; delete[] semName_array; delete[] msg_array; delete[] myThreads;
   return 0;
}//main

////////////////////////////
void *Send_msg(void* rank) 
{
   int my_rank = (long) rank;
   int dest = (my_rank + 1) % num_threads; //dest is one next thread (rotational)
   int source = (my_rank - 1 + num_threads) % num_threads; //source is one prev thread
  
   //type casting from int to string --needs #include <sstream>
   stringstream out1, out2;
   out1<<dest;
   out2<<my_rank;
   string dest_str = out1.str();
   string my_rank_str = out2.str();
  
   string my_msg = "Hello to Thread_"+dest_str+" from Thread_"+my_rank_str;
   msg_array[dest] = my_msg;  //send msg to dest
   sem_post(sem_array[dest]); //notify to dest

   sem_wait(sem_array[my_rank]);  //wait until source notifies me
   if (msg_array[my_rank] != "")
   { pthread_mutex_lock(&mutex1); //make cout atomic
     cout<<"Thread_"<<my_rank<<" > "<<msg_array[my_rank]<<endl;
     pthread_mutex_unlock(&mutex1);
   }
   else
   { pthread_mutex_lock(&mutex1); //make cout atomic
     cout<<"Thread_"<<my_rank<<" > No message from Thread_"<<source<<endl;
     pthread_mutex_unlock(&mutex1);
   }
   return NULL;
}
