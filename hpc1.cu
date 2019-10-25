#include<iostream>
using namespace std;

__global__
void sum(int *input){
	int tid = threadIdx.x;
	int step =1;
	int number_of_threads = blockDim.x;
	while(number_of_threads>0){
		if(tid<number_of_threads){
			int fst = tid * step * 2;
			int snd = fst + step;
      printf("%d\\n",input[fst]+input[snd]);
			input[fst]+=input[snd];
      
		}
		step *=2;
		number_of_threads/=2;
	}
	
}

int main(){
	int count = 8;
	int size = count * sizeof(int);
	
	int h[] = {10,20,30,40,50,60,70,80};
	int *d_h;
	cudaMalloc(&d_h,size);
	cudaMemcpy(d_h,h,size,cudaMemcpyHostToDevice);
	
	sum<<<1,count/2>>>(d_h);
	int result;	cudaMemcpy(&result,d_h,sizeof(int),cudaMemcpyDeviceToHost);
	cout<<result;
	cudaFree(d_h);
}
