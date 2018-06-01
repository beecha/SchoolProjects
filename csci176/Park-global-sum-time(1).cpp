//////////////////////////////
//// Park - global sum computation using Pthreads
//// Assume that the array size is evenly divisible by P (num_threads).
//// 
//// $>g++ -o xxx -lpthread park-global-sum-time.cpp
//// $>./xxx 4
////   //4 is the number threads - any
//////////////////////////////

#include <iostream>
#include <iomanip>    //for setprecision()
#include <cstdlib>    //for atoi()
#include <pthread.h>  //for pthread
#include <sys/time.h> //for macro GET_TIME(double)
using namespace std;

//macro (in-line expansion) for GET_TIME(double); needs <sys/time.h>
#define GET_TIME(now)\
{ struct timeval t; gettimeofday(&t, NULL);\
  now = t.tv_sec + t.tv_usec/1000000.0; }

#define array_size 500000000 //200000000 //400000000 //1000

//globals --shared vars
int num_threads;
int a[array_size];
double global_sum = 0.0;
pthread_mutex_t mutex1, mutex2; //for mutex control

void *slave(void* rank); //prototype


//////////////////////////
int main(int argc, char* argv[])
{
  double start_time, end_time; //for time checking  
  long thread_id; //long for type casting with void*
  num_threads = atoi(argv[1]); //tot number of threads -from command line
  
  GET_TIME(start_time); //time checking starts

  //fill array elements
  for (int i=0; i<array_size; i++)
    a[i] = i+1;

  pthread_t myThreads[num_threads]; //define threads
  pthread_mutex_init(&mutex1, NULL); //initialize mutex1 and mutex2
  pthread_mutex_init(&mutex2, NULL);
  
  for (thread_id=0; thread_id < num_threads; thread_id++)
  { if(pthread_create(&myThreads[thread_id], NULL, slave, (void*)thread_id) != 0)
      cerr<<"Pthread_create fails"<<endl; //perror("Pthread_create fails");
      
    pthread_mutex_lock(&mutex1);   //reserve mutex1 for cout atomic operation
    cout<<"thread_"<<thread_id<<" is created"<<endl;
    pthread_mutex_unlock(&mutex1); //release mutex1
  }//for
      
  //wait until all threads terminate
  for (thread_id=0; thread_id < num_threads; thread_id++)
    if (pthread_join(myThreads[thread_id], NULL) != 0)
      cerr<<"Pthrread_join fails"<<endl; //perror("Pthread_join fails");
  
  //after joining all threads, mutex is not needed for cout 
  cout<<"The global sum of a[0]~a["<<array_size-1<<"] is: "<<global_sum<<endl;
  
  GET_TIME(end_time); //time checking ends
  //cout.precision(8); cout<<showpoint; //or, following way for formatted output
  cout<<"++++ time taken (sec) = "<<setprecision(8)<<showpoint<<end_time - start_time<<endl;
  
  pthread_mutex_destroy(&mutex1); //needed?
  pthread_mutex_destroy(&mutex2); //needed?
  return 0;
}
  
///////////////////////
void *slave(void *rank) //each thread exec this func
{ 
  int my_rank = (long)rank; //cast void* type to long type, and then to int
  double partial_sum = 0.0; //local to each thread
  
  //assume that array size is evenly divisible with P (num_threads)
  int start_index = my_rank * (array_size/num_threads); //local to each thread
  int end_index = start_index + (array_size/num_threads) - 1; //local to each thread
  for(int j=start_index; j<=end_index; j++)
    partial_sum += a[j];
  
  pthread_mutex_lock(&mutex1);   //researve mutex1 for atomic cout operation
  cout<<"Thread_"<<my_rank<<": start_index="<<start_index<<", end_index="
      <<end_index<<" -- partial sum is: "<<partial_sum<<endl;
  pthread_mutex_unlock(&mutex1); //release mutex1
  
  //pthread_mutex_lock(&mutex2);
  global_sum += partial_sum; //updating global_sum is c.s.
  //pthread_mutex_unlock(&mutex2);
  
  return NULL;
}//slave


