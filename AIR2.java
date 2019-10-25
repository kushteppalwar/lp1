class node
{
node left;
node right;
String id;
int val;

	node(String id,int val)
	{
	left=null;
	right=null;
	this.id=id;
	this.val=val;
	}
}


public class AIR2
{

public static void main(String args[])
{
node root = new node("A",0);
root.left = new node("B",0);
root.right = new node("C",0);

root.left.left = new node("D",0);
root.left.left.left = new node("L1",3);
root.left.left.right = new node("L2",5);

root.left.right = new node("E",0);
root.left.right.left = new node("L3",6);
root.left.right.right = new node("L4",9);

root.right.left =  new node("F",0);
root.right.left.left = new node("L5",1);
root.right.left.right = new node("L6",2);

root.right.right = new node("G",0);
root.right.right.left = new node("L7",0);
root.right.right.right = new node("L8",-1);

int result = show(root,-10000,10000,true);
System.out.println("Optimal value is: "+result);

}

static int show(node current,int alpha,int beta,boolean isMaximizing)
{
System.out.println("Visited=>"+current.id+" alpha:"+alpha+" beta"+beta);
if(current.left==null && current.right==null)
	return current.val;

if(isMaximizing)
	{
	int bestVal=-10000;
	int val = show(current.left,alpha,beta,false);
	bestVal = max(val,bestVal);
	alpha = max(bestVal,alpha);
	
	if(alpha<beta)
		{
		val= show(current.right,alpha,beta,false);
		bestVal=max(val,bestVal);
		alpha=max(alpha,bestVal);
		}
	return bestVal;
	}
else
	{
	int bestVal=10000;
	int val = show(current.left,alpha,beta,true);
	bestVal = min(val,bestVal);
	beta = min(bestVal,beta);
	
	if(alpha<beta)
		{
		val= show(current.right,alpha,beta,true);
		bestVal=min(val,bestVal);
		beta=min(beta,bestVal);
		}
	return bestVal;
	}

}

static int min(int a,int b)
{
return a<b?a:b;
}

static int max(int a,int b)
{
return a>b?a:b;
}
}
