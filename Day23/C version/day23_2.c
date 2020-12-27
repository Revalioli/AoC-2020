#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "ring.h"

#define MAX_VALUE 1000000
#define NB_TURNS 10000000

void printIntArray(int * tab, int length){
    int c;
    printf("Printing tab\n[");
    for(c = 0; c < length; c++){
        printf("%d, ", tab[c]);
    }
    printf("\b\b]\n");
}

// Runs in 1.6s

int main(){
    Ring r;
    int c;

    FILE * file = fopen("input", "r");

    int to_add;
    int max_input = 0;

    initRing(&r, MAX_VALUE-1);

    for(c = 0; c < MAX_VALUE && fscanf(file, "%1d", &to_add) == 1; c++){
        insertAtCurrent(&r, to_add-1);

        if(to_add-1 > max_input) max_input = to_add-1;
    }

    for(c = max_input+1; c < MAX_VALUE; c++){
        insertAtCurrent(&r, c);
    }

    fclose(file);


    refNode(&r);

    int turn;
    for(turn = 0; turn < NB_TURNS; turn ++){
        int dest_label = getCurrentValue(&r)-1 >= 0 ? getCurrentValue(&r)-1 : getCurrentValue(&r) + r.max_value;

        moveAdjacentNodes(&r, 3, dest_label);
        nextNode(&r);
    }

    // printRing(&r);
    setOnValue(&r, 0);

    long val1 = r.current->next->val + 1;
    long val2 = r.current->next->next->val + 1;
    printf("First cup : %ld\n", val1);
    printf("Second cup : %ld\n", val2);
    printf("Result : %ld\n", val1 * val2);

    deleteRing(&r);

    // Code to test some function of ring.c

    // Ring r;
    // initRing(&r, 50);
    // printf("Is empty ? %d --> Should be 1\n", isEmpty(&r));
    //
    // insertAtCurrent(&r, 2);
    // insertAtCurrent(&r, 3);
    // insertAtCurrent(&r, 42);
    // insertAtCurrent(&r, 31);
    //
    // printRing(&r);
    //
    // setOnValue(&r, 31);
    //
    // printf("Is empty ? %d --> Should be 0\n", isEmpty(&r));
    //
    // printf("Use of findByValue : %d ---> Should be 42\n", findByValue(&r, 42)->val);
    //
    // insertAtCurrent(&r, 4);
    // insertAtCurrent(&r, 5);
    // insertAtCurrent(&r, 6);
    // insertAtCurrent(&r, 7);
    //
    // printRing(&r);
    //
    // setOnValue(&r, 7);
    //
    // int res = moveAdjacentNodes(&r, 3, 4);
    // printf("Result of moveAdjacentNodes = %d\n", res);
    //
    // printRing(&r);
    //
    // deleteRing(&r);
}
