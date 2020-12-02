#include <stdio.h>
#include <string.h>

#define LENGTH 100

int count(char * str, char c){
    int count = 0;
    int i;
    int len = strlen(str);
    for(i = 0; i < len; i++) if(str[i] == c) count++;
    return count;
}

int main(){
    FILE * file = fopen("input", "r");
    char line[LENGTH];
    int num_valid = 0;
    // int cpt = 0;

    while(fgets(line, LENGTH-1, file) != NULL){
        printf("%s", line);
        // feof(file) ? printf("End\n") : printf("Continue\n");
        // cpt++;
        int min;
        int max;
        char c;
        char pw[LENGTH];
        if(sscanf(line, "%d-%d %c: %[a-z]\n", &min, &max, &c, pw) == 4){
            // printf("Récupéré : min = %d max = %d c = %c, password = %s\n", min, max, c, pw);
            int times = count(pw, c);
            int decision;
            if(decision = min <= times && times <= max) num_valid++;
            printf("%c is %d times in the pasword, therfore it is %s\n",
                    c, times, decision ? "valid" : "not valid");
        }
        else{
            printf("Error while parsing this line : %s\n", line);
        }
    }

    // printf("%d\n", cpt);

    printf("There is %d valid passwords\n", num_valid);

    return 0;
}
