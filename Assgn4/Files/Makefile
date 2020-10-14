a.out: y.tab.o lex.yy.o ass4_18CS10013.o 
	gcc ass4_18CS10013.o lex.yy.o y.tab.o -lfl
	./a.out < ass4_18CS10013_test.c
lex.yy.c: ass4_18CS10013.l y.tab.h
	flex ass4_18CS10013.l
y.tab.c: ass4_18CS10013.y
	bison -dty ass4_18CS10013.y
ass4_18CS10013.o: ass4_18CS10013.c y.tab.h
	gcc -c ass4_18CS10013.c
y.tab.h: ass4_18CS10013.y
	bison -dty ass4_18CS10013.y
lex.yy.o: lex.yy.c
	gcc -c lex.yy.c
y.tab.o:    y.tab.c y.tab.h
	gcc -c y.tab.c
clean:
	rm a.out lex.yy.o ass4_18CS10013.o lex.yy.c y.tab.c y.tab.h y.tab.o
run:
	./a.out < ass4_18CS10013_test.c