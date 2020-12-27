CC=gcc
CFLAGS=-Wall -Wextra -g

all: main

main: day23_2.o ring.o
	$(CC) $^ -o $@

day23_2.o: ring.h
ring.o: ring.h

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -f main
	rm -f *.o
