a.out: 	main.o libass2_18CS10013.a
			g++ main.o -L. -lass2_18CS10013

main.o: 	main.cpp toylib.h
				g++ -Wall -c main.cpp

libass2_18CS10013.a: 	ass2_18CS10013.o
					ar -rcs libass2_18CS10013.a ass2_18CS10013.o

ass2_18CS10013.o: 	ass2_18CS10013.cpp toylib.h
			g++ -Wall -c ass2_18CS10013.cpp

clean:
	rm a.out main.o libass2_18CS10013.a ass2_18CS10013.o
