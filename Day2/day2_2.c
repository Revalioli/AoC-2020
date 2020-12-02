#include <stdio.h>
#include <string.h>

#define LENGTH 100

int main(){
    FILE * file = fopen("input", "r");
    char line[LENGTH];
    int num_valid = 0;

    while(fgets(line, LENGTH-1, file)){
        int min, max;
        char c;
        char pw[LENGTH];
        if(sscanf(line, "%d-%d %c: %[a-z]\n", &min, &max, &c, pw) == 4){
            if(pw[min-1] == c ^ pw[max-1] == c){
                printf("Valid password !\n");
                num_valid++;
            }
            else printf("Invalid password >:(\n");
        }
        else printf("Error while parsing this line : %s\n", line);
    }

    printf("There is %d valid passwords\n", num_valid);

    return 0;
}
