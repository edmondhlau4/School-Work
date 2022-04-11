//----------------------------------
//pa5
//----------------------------------

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<assert.h>
#include"Dictionary.h"

const int tableSize=101;

typedef struct DictionaryObj* Dictionary;

// rotate_left()
// rotate the bits in an unsigned int
unsigned int rotate_left(unsigned int value, int shift) {
  int sizeInBits = 8*sizeof(unsigned int);
  shift = shift & (sizeInBits - 1);
  if ( shift == 0 )
    return value;
  return (value << shift) | (value >> (sizeInBits - shift));
}
// pre_hash()
// turn a string into an unsigned int
unsigned int pre_hash(char* input) {
  unsigned int result = 0xBAE86554;
  while (*input) {
     result ^= *input++;
     result = rotate_left(result, 5);
  }
  return result;
}
// hash()
// turns a string into an int in the range 0 to tableSize-1
int hash(char* key){
  return pre_hash(key)%tableSize;
}

typedef struct NodeObj{
  char* key;
  char* value;
  struct NodeObj* next;
} NodeObj;

typedef struct NodeObj* Node;

typedef struct DictionaryObj{
  Node* table;
  int numItems;
} DictionaryObj;


Node newNode(char* newX, char* newY){
  Node N = malloc(sizeof(NodeObj));
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

/*Create the list obj
typedef struct ListObj{
  Node head;
  int size;
}ListObj;*/

//typedef struct ListObj* List;

/*List newList(void){
  List L = malloc(sizeof(ListObj));
  assert(L!=NULL);
  L->head = NULL;
  L->size = 0;
  return L;
}

void freeList(List* L){
  free(*L);
  *L=NULL;
}*/

// Dictionary
// Exported reference type


// newDictionary()
// constructor for the Dictionary type
Dictionary newDictionary(void){
  Dictionary D = malloc(sizeof(DictionaryObj));
  assert(D!=NULL);
  D->table = calloc(tableSize, sizeof(NodeObj));
  assert(D->table!=NULL);
  D->numItems = 0;
  //for(int i = 0; i < tableSize; i++){
  //  D->table[i] = newList();
  //}
  return D;
}

// freeDictionary(
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
  return (D->numItems == 0);
}

// size()
// returns the number of (key, value) pairs in D
// pre: none
int size(Dictionary D){
  return D->numItems;
}

Node findKey(Dictionary D, char* key){
  Node N = D->table[hash(key)];
  for(; N!=NULL; N = N->next){
    if(strcmp(N->key, key) == 0){
      return N;
    }
  }
  return NULL;
}

// lookup()
// returns the value v such that (k, v) is in D, or returns NULL if no
// such value v exists.
// pre: none
char* lookup(Dictionary D, char* k){
  Node N = findKey(D, k);
  if(N != NULL){
    return N->value;
  }
  return NULL;
}

// insert()
// inserts new (key,value) pair into D
// pre: lookup(D, k)==NULL
void insert(Dictionary D, char* k, char* v){
  if(findKey(D, k) != NULL){
    fprintf(stderr, "Key is in use");
    exit(EXIT_FAILURE);
  }
  int index = hash(k);
  Node N = newNode(k, v);
  N->next = D->table[index];
  D->table[index] = N;
  D->numItems++;
}

// delete()
// deletes pair with the key k
// pre: lookup(D, k)!=NULL

void delete(Dictionary D, char* k){
      if( lookup(D,k) == NULL ){
          fprintf(stderr, "Dictionary error: key not found\n");
          exit(EXIT_FAILURE);
      }
      int index = hash(k);
      if(D->numItems == 1){
         Node N = findKey(D, k);
         freeNode(&N);
       }
       else if(strcmp(D->table[index]->key, k) == 0){   //key is at head of Node
          Node N = D->table[index];
          D->table[index] = D->table[index]->next;
          freeNode(&N);
          N = NULL;
        }
        else{//key is not at head of Node
          Node P = D->table[index];
          Node C;

          for(; P->next!= findKey(D, k); P=P->next){
            //
          }

          C = P->next;
          P->next = C->next;
          freeNode(&C);
          C->next = NULL;
        }
      D->numItems--;
 }


// makeEmpty()
// re-sets D to the empty state.
// pre: none
void makeEmpty(Dictionary D){
//  Node N;
//  for(N = D->head; N->next != NULL; N = N->next){
//    freeNode(&N);
//  }
  for(int i = 0; i < tableSize; i++){
    Node N = D->table[i];
  	while(N!=NULL){
      Node M =  N;
      N = N->next;
      freeNode(&M);
      D->table[i] = N;
    }
  }
  D->numItems = 0;
}

// printDictionary()
// pre: none
// prints a text representation of D to the file pointed to by out
void printDictionary(FILE* out, Dictionary D){
  for(int i = 0; i<tableSize; i++){
    Node N = D->table[i];
    for(; N!=NULL; N=N->next){
      fprintf(out, "%s %s \n" , N->key, N->value);
    }
  }
}
