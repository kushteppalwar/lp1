#include<mpi.h>
#include<iostream>

using namespace std;

void binary_search(int *array,int start,int end,int key,int rank){

	while(start <= end){
	
		int m = (start+end)/2;
		if(array[m] == key){
		
			cout<<"Element found by process with rank"<<rank<<endl;
			return;
		
		}else if(array[m] < key)
			start = m+1;
		else
			end = m-1;	
	
	
	}

	cout<<"The element was not found by process with rank "<<rank<<endl;
}

int main(){

	int n = 8000;
	int *array = new int[n];
	for(int i=0;i<n;i++)
		array[i] = i+1;
	
	int rank,blocksize;
	MPI_Init(NULL,NULL);
	MPI_Comm_rank(MPI_COMM_WORLD,&rank);	//For rank assigning
	MPI_Comm_size(MPI_COMM_WORLD,&blocksize);
	
	blocksize = n/4;
	
	double start = MPI_Wtime();
	
	binary_search(array,(rank*blocksize),((rank+1)*blocksize)-1,4500,rank);
	
	double stop = MPI_Wtime();
	cout<<"The time for process "<<rank<<" is "<<(stop-start)*1000<<endl;

}


//mpiCC Assignment4_bin.cpp 
//mpirun -np 2 ./a.out

