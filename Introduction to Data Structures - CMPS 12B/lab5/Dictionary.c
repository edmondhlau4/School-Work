#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<assert.h>
#include"Dictionary.h"

typedef struct NodeObj{
  char* key;
  char* value;
  struct NodeObj* next;
} NodeObj;

typedef NodeObj* Node;

Node newNode(char* newX, char* newY){
  Node N = malloc(sizeof(NodeObj));
  /////////////////////

  assert(N!=NULL);


  N->key = newX;
  N->value = newY;
  N->next = NULL;
  return(N);
}

//freeNode()
//destructor for Node type
void freeNode(Node* pN){
   if(pN!=NULL && *pN!=NULL ){
      free(*pN);
      *pN = NULL;
   }
}

// Dictionary
// Exported reference type
typedef struct DictionaryObj{
  Node head;
  Node tail;
  int numItems;
} DictionaryObj;

// newDictionary()
// constructor for the Dictionary type
Dictionary newDictionary(void){
  Dictionary D = malloc(sizeof(DictionaryObj));
  assert(D!=NULL);
  D->head = NULL;
  D->tail = NULL;
  D->numItems = 0;
  return D;
}

// freeDictionary()
// destructor for the Dictionary type
void freeDictionary(Dictionary* pD){
  if(pD !=  NULL && *pD != NULL){
    free(*pD);
    *pD = NULL;
  }
}

// isEmpty()
// returns 1 (true) if S is empty, 0 (false) otherwise
// pre: none
int isEmpty(Dictionary D){
  if(D->numItems == 0){
    return 1;
  }
  else{
    return 0;
  }
}

// size()
// returns the number of (key, value) pairs in D
// pre: none
int size(Dictionary D){
  return D->numItems;
}

// lookup()
// returns the value v such that (k, v) is in D, or returns NULL if no
// such value v exists.
// pre: none
char* lookup(Dictionary D, char* k){
  Node N = D->head;
  if(D == NULL){
    fprintf(stderr, "no keys are available");
  }
  while(N!=NULL){
    if(strcmp(N->key, k) == 0){
      return N->value;
    }
    N = N->next;
  }
  return NULL;
}

// insert()
// inserts new (key,value) pair into D
// pre: lookup(D, k)==NULL
void insert(Dictionary D, char* k, char* v){
  if(D->numItems == 0){
    D->head = D->tail = newNode(k, v);;
    D->numItems++;
  }
  else{
    Node N = newNode(k,v);
    D->tail->next = N;
    D->tail = N;
    D->numItems++;
  }

}

// delete()
// deletes pair with the key k
// pre: lookup(D, k)!=NULL


void delete(Dictionary D, char* k){
      Node N = D->head;
      if( lookup(D,k) == NULL ){
          fprintf(stderr, "Dictionary error: key not found\n");
          exit(EXIT_FAILURE);
      }
      if(strcmp(N->key,k)==0){
         Node temp1 = D->head;
         Node A = temp1->next;
         D->head = A;
         freeNode(&temp1);
         D->numItems--;
      }else{
         while(N !=NULL && N->next != NULL){
            if(strcmp(N->next->key, k)==0){
            Node temp2 = N;
            Node B = N->next;
            temp2->next = B->next;
            N=temp2;
            freeNode(&B);
            D->numItems--;
            }
         N = N->next;
        }
      }
 }


// makeEmpty()
// re-sets D to the empty state.
// pre: none
void makeEmpty(Dictionary D){
//  Node N;
//  for(N = D->head; N->next != NULL; N = N->next){
//    freeNode(&N);
//  }
  D->head = D->tail = NULL;
  D->numItems = 0;
}

// printDictionary()
// pre: none
// prints a text representation of D to the file pointed to by out
void printDictionary(FILE* out, Dictionary D){
  Node N = D->head;
  for(N=D->head; N!=NULL; N=N->next){
    fprintf(out, "%s %s \n" , N->key, N->value);
  }
}
