/*
* -------------------------------------------------------------------------------------
* NAME: AISHNI PARAB
* CRUZID: APARAB
* CLASS: CMPS 12M
* DATE: JULY 27 2015
* FILENAME: DictionaryTest.c
* DESCRIPTION: Testts the implementation of the Dictionary ADT
* ---------------------------------------------------------------------------------------
*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"Dictionary.h"

#define MAX_LEN 180

int main(int argc, char* argv[]){
   Dictionary A = newDictionary();
   char* k;
   char* v;
   char* word1[] = {"0","1","3"};
   char* word2[] = {"test1", "test2", "test3"};
   int i;

   for(i=0; i<3; i++){
      insert(A, word1[i], word2[i]);
   }

   printDictionary(stdout, A);

   for(i=0; i<3; i++){
      k = word1[i];
      v = lookup(A, k);
      printf("key=\"%s\" %s\"%s\"\n", k, (v==NULL?"not found ":"value="), v);
   }

   delete(A, "1");

   printDictionary(stdout, A);

   for(i=0; i<3; i++){
      k = word1[i];
      v = lookup(A, k);
      printf("key=\"%s\" %s\"%s\"\n", k, (v==NULL?"not found ":"value="), v);
   }

   printf("%s\n", (isEmpty(A)?"true":"false"));
   printf("%d\n", size(A));
   makeEmpty(A);
   printf("%s\n", (isEmpty(A)?"true":"false"));

   freeDictionary(&A);

   return(EXIT_SUCCESS);
}
