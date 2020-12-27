#ifndef RING
#define RING

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct Node{
    int val;
    struct Node * next;
}Node;


/* Ring with only integer between 0 and max_value */
typedef struct{
    Node * current;
    Node * ref;
    int length;
    Node ** address_table;
    int max_value;
}Ring;

void initRing(Ring * r, int max_value);
void nextNode(Ring * r);
void refNode(Ring * r);
void setOnValue(Ring * r, int value);
int insertAtCurrent(Ring * r, int val);

// Specific to this day of AoC
int moveAdjacentNodes(Ring * r, int nb_blocks, int dest_value);

int isEmpty(Ring * r);
int ringLength(Ring * r);
int getCurrentValue(Ring * r);
Node * findByValue(Ring * r, int val);

void deleteRing(Ring * r);

// Specific for the AoC
void printRing(Ring * r);

#endif
