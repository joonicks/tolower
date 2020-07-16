
run:		tolower.o main.c
		gcc -Wall -c main.c
		gcc -Wall -o run main.o tolower.o

tolower.o:	tolower.S
		gcc -Wall -c tolower.S

