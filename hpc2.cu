#include <iostream>
using namespace std;

__global__ void matmul(int* M, int* N, int* P, int* width)
{
  int row = blockIdx.x;
  int col = threadIdx.x;
  P[row*(*width)+col]=0;    //set the output of current element to 0
  for(int i=0; i<*width; i++)
  {
    P[row*(*width)+col] += M[row*(*width)+i]*N[i*(*width)+col]; //I've converted the general A[row][col] to A[row*width+col]
  }                                                             //because of the row major format
}
//d_xyz in my code means xyz is on the device
int main()
{
  int width = 4;  //width of n*n matrix
  int* d_width;
  cudaMalloc(&d_width, sizeof(int));
  //copy width
  cudaMemcpy(d_width, &width, sizeof(int), cudaMemcpyHostToDevice);
  
  //define input matrices
  int M[width][width] = {{5,7,9,10},
                        {2,3,3,8},  
                        {8,10,2,3},
                        {3,3,4,8}
                        };

  int N[width][width] = {{3,10,12,18},
                        {12,1,4,9},
                        {9,10,12,2},
                        {3,12,4,10}};
  
  //declare output matrix on host side
  int P[width][width];

  int *d_M, *d_N, *d_P;
  cudaMalloc(&d_M, sizeof(int)*width*width);
  cudaMalloc(&d_N, sizeof(int)*width*width);
  cudaMalloc(&d_P, sizeof(int)*width*width);

  //copy matrices to GPU
  cudaMemcpy(d_M, M, sizeof(int)*width*width, cudaMemcpyHostToDevice);
  cudaMemcpy(d_N, N, sizeof(int)*width*width, cudaMemcpyHostToDevice);
  cudaMemcpy(d_P, P, sizeof(int)*width*width, cudaMemcpyHostToDevice);
  
  matmul<<<width, width>>>(d_M, d_N, d_P, d_width);     
  cudaMemcpy(P, d_P, sizeof(int)*width*width, cudaMemcpyDeviceToHost);
  
  cout<<"The output is:\\n";
  for(int i=0; i<width; i++)
  {
    for(int j=0; j<width; j++)
    {
      cout<<P[i][j]<<" ";
    }
    cout<<"\\n";
  }
  cudaFree(d_M);
  cudaFree(d_N);
  cudaFree(d_P);
  return 0;
}

