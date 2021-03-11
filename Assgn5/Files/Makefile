all: a.out
	
	./a.out < ass5_18CS10013_18CS10024_test1.c > ass5_18CS10013_18CS10024_quads1.out
	./a.out < ass5_18CS10013_18CS10024_test2.c > ass5_18CS10013_18CS10024_quads2.out
	./a.out < ass5_18CS10013_18CS10024_test3.c > ass5_18CS10013_18CS10024_quads3.out
	./a.out < ass5_18CS10013_18CS10024_test4.c > ass5_18CS10013_18CS10024_quads4.out
	./a.out < ass5_18CS10013_18CS10024_test5.c > ass5_18CS10013_18CS10024_quads5.out
	./a.out < ass5_18CS10013_18CS10024_test6.c > ass5_18CS10013_18CS10024_quads6.out
	./a.out < ass5_18CS10013_18CS10024_test7.c > ass5_18CS10013_18CS10024_quads7.out
	@echo "\nALL TEST FILES SUCCESSFULLY TRANSLATED !!\n"

a.out: lex.yy.o y.tab.o ass5_18CS10013_18CS10024_translator.o
	g++ lex.yy.o y.tab.o ass5_18CS10013_18CS10024_translator.o -lfl

ass5_18CS10013_18CS10024_translator.o: ass5_18CS10013_18CS10024_translator.cxx ass5_18CS10013_18CS10024_translator.h
	g++ -c ass5_18CS10013_18CS10024_translator.h
	g++ -c ass5_18CS10013_18CS10024_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.c: ass5_18CS10013_18CS10024.l y.tab.h ass5_18CS10013_18CS10024_translator.h
	flex ass5_18CS10013_18CS10024.l

y.tab.c: ass5_18CS10013_18CS10024.y
	bison -dty ass5_18CS10013_18CS10024.y

y.tab.h: ass5_18CS10013_18CS10024.y
	bison -dty ass5_18CS10013_18CS10024.y

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass5_18CS10013_18CS10024_translator.o a.out ass5_18CS10013_18CS10024_translator.h.gch
