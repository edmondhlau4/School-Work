//-----------------------------------------------------------------------------
// DictionaryClient.c
// Test client for the Dictionary ADT
//-----------------------------------------------------------------------------

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"Dictionary.h"

#define MAX_LEN 100

int main(int argc, char* argv[]){
   Dictionary dict = newDictionary();
   char* k;
   char* v;
   char* word1[] = {"test1","test2","test3"};
   char* word2[] = {"word1","word2","word3"};
   int i;

   for(i=0; i<3; i++){
      insert(A, word1[i], word2[i]);
   }

   printDictionary(stdout, A);

   delete(A, "test1");

   printDictionary(stdout, A);

   printf("%d\n", size(A));
   makeEmpty(A);
   printf("%s\n", (isEmpty(A)?"true":"false"));

   freeDictionary(&A);

   return(EXIT_SUCCESS);
}
