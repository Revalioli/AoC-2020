#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "ring.h"

// If allocating error, node pointer is NULL
static Node * createNode(int val, Node * next){
    Node * node = (Node *)malloc(sizeof(Node));
    if(node != NULL){
        node->val = val;
        node->next = next;
    }

    return node;
}

static void deleteNode(Node * node){
    free(node);
}

// Return 1 if tab includes val, 0 if not
static int include(int * tab, int tab_length, int val){
    int c;
    for(c = 0; c < tab_length; c++){
        if(tab[c] == val) return 1;
    }
    return 0;
}




/* Initialize empty Ring r
 * Use this only after allocating memory for the ring or after deleteRing */
void initRing(Ring * r, int max_value){
    r->current = NULL;
    r->ref = NULL;
    r->length = 0;
    r->max_value = max_value;
    r->address_table = calloc(max_value+1, sizeof(Node*));
    if(r->address_table == NULL){
        fprintf(stderr, "Error while allocating memory for address_table\n");
        exit(EXIT_FAILURE);
    }
    else{
        int c;
        for(c = 0; c <= max_value; c++) r->address_table[c] = NULL;
    }
}


/* Return 1 if Ring c is empty, 0 otherwise */
int isEmpty(Ring * r){
    return r->ref == NULL;
}

void nextNode(Ring * r){
    if(!isEmpty(r)) r->current = r->current->next;
}

void refNode(Ring * r){
    r->current = r->ref;
}

void setOnValue(Ring * r, int value){
    Node * temp = findByValue(r, value);
    if(temp != NULL) r->current = temp;
}


/* Insert new int val after current Node
 * Return 1 if is ok, 0 otherwise */
int insertAtCurrent(Ring * r, int val){
    Node * newNode;

    if(val > r->max_value){
        fprintf(stderr, "Value is greater than the max value of this ring, it cannot be inserted\n");
        return 0;
    }

    if(val < 0){
        fprintf(stderr, "Negative values cannot be inserted in this Ring\n");
        return 0;
    }

    if(isEmpty(r)){
        newNode = createNode(val, NULL);
        if(newNode == NULL){
            fprintf(stderr, "Error while allocating memory for a new Node\n");
            return 0;
        }
        newNode->next = newNode;

        r->current = newNode;
        r->ref = newNode;
        r->length = 1;
        r->address_table[val] = newNode;

        return 1;
    }

    newNode = createNode(val, r->current->next);
    if(newNode == NULL){
        fprintf(stderr, "Error while allocating memory for a new Node\n");
        return 0;
    }

    r->current->next = newNode;
    nextNode(r);
    r->length ++;
    r->address_table[val] = newNode;

    return 1;

}


int ringLength(Ring * r){
    return r->length;
}


int getCurrentValue(Ring * r){
    if(isEmpty(r)){
        printf("Ring empty !\n");
        return 0;
    }
    return r->current->val;
}


// Return a pointer to the node that contains val, NULL if this node doesn't exist
Node * findByValue(Ring * r, int val){
    if(val < 0 || val > r->max_value){
        fprintf(stderr, "This Ring cannot hold Node with value lower than 0 or greater than %d\n", r->max_value);
        return NULL;
    }

    return r->address_table[val];
}

/* Take nb_blocks adjacent nodes starting from the current node and move them
 * just after the node with dest_value. If this node must be move, dest_value is
 * decreased until a valid node is found
 * Return 1 if the operation is successful, 0 otherwise*/
int moveAdjacentNodes(Ring * r, int nb_blocks, int dest_value){
    if(nb_blocks < 1){
        fprintf(stderr, "nb_block must be greater or equal to 1\n");
        return 0;
    }

    if(dest_value < 0 || dest_value > r->max_value){
        fprintf(stderr, "dest_value must be included between 0 and %d\n", r->max_value);
        return 0;
    }

    if(nb_blocks > ringLength(r)-1){
        fprintf(stderr, "Ring is to small, there is less than %d nodes\n", nb_blocks+1);
        return 0;
    }

    int c;
    int * moved_values = calloc(nb_blocks, sizeof(int));
    Node * start = r->current->next;
    moved_values[0] = start->val;
    Node * end = start;
    Node * dest;

    for(c = 1; c < nb_blocks; c++){
        end = end->next;
        moved_values[c] = end->val;
    }

    while(include(moved_values, nb_blocks, dest_value)){
        dest_value = dest_value-1 >= 0 ? dest_value-1 : dest_value + r->max_value;
    }

    if((dest = findByValue(r, dest_value)) == NULL){
        fprintf(stderr, "The valid destination value found is not in this ring\n");
        free(moved_values);
        return 0;
    }

    r->current->next = end->next;
    end->next = dest->next;
    dest->next = start;

    free(moved_values);

    return 1;
}


// Completely delete the content of the ring and its address table
void deleteRing(Ring * r){
    refNode(r);
    while(r->current->next != r->current){
        Node * to_delete = r->current->next;
        r->current->next = to_delete->next;
        deleteNode(to_delete);
    }
    deleteNode(r->current);

    r->ref = NULL;
    refNode(r);

    free(r->address_table);
}

// Print ring content
// Specific for the AoC
void printRing(Ring * r){
    if(isEmpty(r)){
        printf("Ring is empty !\n");
    }
    else{
        Node * start = r->current;
        printf("Printing ring :\n");
        printf("%d, ", r->current->val+1);
        nextNode(r);
        while(r->current != start){
            printf("%d, ", r->current->val+1);
            nextNode(r);
        }
        printf("\b\b \n");
    }
}
