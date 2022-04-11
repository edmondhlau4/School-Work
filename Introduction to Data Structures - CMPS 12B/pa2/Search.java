//------------------------
// Shyaan Khan
// skhan17
// pa2
// 4-17-16
// Uses MergeSort and binarySort functions to
// find a target word in a given file
//----------------------


import java.io.*;
import java.util.Scanner;

public class Search{

  public static void main(String[] args) throws IOException
    {

    if(args.length == 0)
    {
      System.out.println("Usage: Search file target1 [target2 ..]");
    }
    else
    {
      Scanner in = new Scanner(new File(args[0]));
      int Count = 0;
      while( in.hasNextLine() ){
         in.nextLine();
         Count++;
      }
      in.close();

      String[] arrayStr = new String[Count];
      int[] Placement = new int[Count];
      in = new Scanner(new File(args[0]));


      for(int i = 0; i < Count; i++)
      {
        arrayStr[i] = in.nextLine();
        Placement[i] = i+1;
      }
      mergeSort(arrayStr, Placement, 0, arrayStr.length-1);

    for(int i = 1; i < args.length; i++)
    {
      int num = binarySort(arrayStr, Placement, 0, arrayStr.length, args[i]);
      if( num > 0)
      {
        System.out.println(args[i]+" found on line " + num);
      }
      else
      {
        System.out.println(args[i]+ " not found");
      }
    }

  }
}

//mergeSort(): takes two arrays and puts into order
public static void mergeSort(String[] arrayStr, int[] Placement, int p, int r){
      int q;
      if(p < r){
        q = (p + r)/2;
        mergeSort(arrayStr, Placement, p, q);
        mergeSort(arrayStr, Placement, q+1, r);
        merge(arrayStr, Placement, p, q, r);
      }
    }

//merge(): combines two separate arrays
  public static void merge(String[] arrayStr, int[] Placement, int p, int q, int r){

    int n1 = q - p + 1;
    int n2 = r - q;
    String[] left = new String[n1];
    String[] right = new String[n2];
    int[] numLeft = new int[n1];
    int[] numRight = new int[n2];
    int i, j, k;

    for(i=0; i<n1; i++){
          left[i] = arrayStr[p+i];
          numLeft[i] = Placement[p+i];
        }
        for(j=0; j<n2; j++){
          right[j] = arrayStr[q+j+1];
          numRight[j] = Placement[q+j+1];
        }

    i = 0;
    j = 0;
    for(k=p; k<=r; k++){
      if( i<n1 && j<n2 ){
        if( left[i].compareTo(right[j]) < 0 ){
               arrayStr[k] = left[i];
               Placement[k] = numLeft[i];
               i++;
            }else{
               arrayStr[k] = right[j];
               Placement[k] = numRight[j];
               j++;
            }
         }else if( i<n1 ){
            arrayStr[k] = left[i];
            Placement[k] = numLeft[i];
            i++;
         } else{ // j<n2
            arrayStr[k] = right[j];
            Placement[k] = numRight[j];
            j++;
         }
      }
  }


//binarySort(): Searches for target string in the given arrays
  public static int binarySort(String[] arrayStr, int[] Placement, int p, int r, String target)
  {
    int q;
    if(p == r)
    {
      return -1;
    }
    else
    {
      q = (p + r)/2;
      if(arrayStr[q].compareTo(target) == 0)
      {
        return Placement[q];
      }
      else if(arrayStr[q].compareTo(target) > 0)
      {
        return binarySort(arrayStr, Placement, p, q, target);
      }
      else
      {
        return binarySort(arrayStr, Placement, q+1, r, target);
      }

    }


  }



}
