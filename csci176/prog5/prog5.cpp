// To compile, type
// mpiCC prog5.cpp
// MPI - Message Passing Interface
// Koding only has 1 core (LOL)

#include <iostream>
#include <mpi.h>
#include <stdio.h>
#include <cstdlib>

using namespace std;

int main(int argc, char** argv)
{
    
    // Get number of elements from command line
    if (argc != 2)
    {
        cout << "Error: Invalid arguments\n";
        exit(-1);
    }
    
    // Change command line argument to an int type and store it
    int n = atoi(argv[1]);
    
    // Initialize the MPI Environment
    // Currently takes no arguments
    // Arguments are reserved for future updates
    MPI_Init(NULL, NULL);
    
    // Get the number of processors supported by your local machine
    int world_size;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    
    // Get the rank of the processor
    int world_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
    
    // Get the name of the processor
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    MPI_Get_processor_name(processor_name, &name_len);
    
    // Print a Hello message from each processor
    cout << "Hello from processor " << processor_name
         << ", rank " << world_rank
         << " out of " << world_size
         << " number of processors\n";
         
    
    // Close the MPI environment
    MPI_Finalize();
    
    return 0;
}
