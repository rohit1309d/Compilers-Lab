tinyC_compiler: y.tab.o lex.yy.o ass6_18CS10013_18CS10024_translator.o ass6_18CS10013_18CS10024_target_translator.o 
	@g++ -g ass6_18CS10013_18CS10024_translator.o ass6_18CS10013_18CS10024_target_translator.o lex.yy.o y.tab.o -lfl -o tinyC_compiler
	@./tinyC_compiler < ass6_18CS10013_18CS10024_test1.c
	@./tinyC_compiler < ass6_18CS10013_18CS10024_test2.c 
	@./tinyC_compiler < ass6_18CS10013_18CS10024_test3.c
	@./tinyC_compiler < ass6_18CS10013_18CS10024_test4.c
	@./tinyC_compiler < ass6_18CS10013_18CS10024_test5.c
	@./tinyC_compiler < ass6_18CS10013_18CS10024_test6.c
	@echo " USE COMMAND (make run) TO CREATE THE TEST RUN FILES"
lex.yy.c: ass6_18CS10013_18CS10024.l
	@flex ass6_18CS10013_18CS10024.l
y.tab.c: ass6_18CS10013_18CS10024.y
	@bison -dty ass6_18CS10013_18CS10024.y
ass6_18CS10013_18CS10024_target_translator.o: ass6_18CS10013_18CS10024_target_translator.cxx
	@g++ -g -c ass6_18CS10013_18CS10024_target_translator.cxx
ass6_18CS10013_18CS10024_translator.o: ass6_18CS10013_18CS10024_translator.cxx
	@g++ -g -c ass6_18CS10013_18CS10024_translator.cxx
lex.yy.o: lex.yy.c
	@g++ -g -c lex.yy.c
y.tab.o:    y.tab.c
	@g++ -g -DYYDEBUG -c y.tab.c
libass6_18CS10013_18CS10024.a: ass6_18CS10013_18CS10024.o
	@ar -rcs libass6_18CS10013_18CS10024.a ass6_18CS10013_18CS10024.o

ass6_18CS10013_18CS10024.o: ass6_18CS10013_18CS10024.c myl.h
	@gcc -Wall  -c ass6_18CS10013_18CS10024.c
clean:
	@rm runtest1 runtest2 runtest3 runtest4 runtest5 runtest6 lex.yy.c y.tab.h y.tab.c lex.yy.o y.tab.o ass6_18CS10013_18CS10024_translator.o ass6_18CS10013_18CS10024_target_translator.o ass6_18CS10013_18CS10024_test1.o ass6_18CS10013_18CS10024_test2.o ass6_18CS10013_18CS10024_test3.o ass6_18CS10013_18CS10024_test4.o ass6_18CS10013_18CS10024_test5.o ass6_18CS10013_18CS10024_test6.o libass6_18CS10013_18CS10024.a ass6_18CS10013_18CS10024.o tinyC_compiler


runtest1: ass6_18CS10013_18CS10024_test1.o libass6_18CS10013_18CS10024.a
	@gcc -g -no-pie ass6_18CS10013_18CS10024_test1.o -o runtest1 -L. -lass6_18CS10013_18CS10024
ass6_18CS10013_18CS10024_test1.o: ass6_18CS10013_18CS10024_test1.s myl.h
	@gcc -g -Wall  -c ass6_18CS10013_18CS10024_test1.s -o ass6_18CS10013_18CS10024_test1.o

runtest2: ass6_18CS10013_18CS10024_test2.o libass6_18CS10013_18CS10024.a
	@gcc -g -no-pie  ass6_18CS10013_18CS10024_test2.o -o runtest2 -L. -lass6_18CS10013_18CS10024
ass6_18CS10013_18CS10024_test2.o: ass6_18CS10013_18CS10024_test2.s myl.h
	@gcc -g -Wall -c ass6_18CS10013_18CS10024_test2.s

runtest3: ass6_18CS10013_18CS10024_test3.o libass6_18CS10013_18CS10024.a
	@gcc -g -no-pie  ass6_18CS10013_18CS10024_test3.o -o runtest3 -L. -lass6_18CS10013_18CS10024
ass6_18CS10013_18CS10024_test3.o: ass6_18CS10013_18CS10024_test3.s myl.h
	@gcc -g -Wall  -c ass6_18CS10013_18CS10024_test3.s

runtest4: ass6_18CS10013_18CS10024_test4.o libass6_18CS10013_18CS10024.a
	@gcc -g -no-pie  ass6_18CS10013_18CS10024_test4.o -o runtest4 -L. -lass6_18CS10013_18CS10024
ass6_18CS10013_18CS10024_test4.o: ass6_18CS10013_18CS10024_test4.s myl.h
	@gcc -g -Wall  -c ass6_18CS10013_18CS10024_test4.s

runtest5: ass6_18CS10013_18CS10024_test5.o libass6_18CS10013_18CS10024.a
	@gcc -g -no-pie  ass6_18CS10013_18CS10024_test5.o -o runtest5 -L. -lass6_18CS10013_18CS10024
ass6_18CS10013_18CS10024_test5.o: ass6_18CS10013_18CS10024_test5.s myl.h
	@gcc -g -Wall -c ass6_18CS10013_18CS10024_test5.s

runtest6: ass6_18CS10013_18CS10024_test6.o libass6_18CS10013_18CS10024.a
	@gcc -g -no-pie  ass6_18CS10013_18CS10024_test6.o -o runtest6 -L. -lass6_18CS10013_18CS10024
ass6_18CS10013_18CS10024_test6.o: ass6_18CS10013_18CS10024_test6.s myl.h
	@gcc -g -Wall -c ass6_18CS10013_18CS10024_test6.s

#output: output.o
output: output.o libass6_18CS10013_18CS10024.a
	@gcc -g  output.o -o output -L. -lass6_18CS10013_18CS10024
output.o: output.s myl.h
	@gcc -g -Wall -c output.s

run: 
		
	@./tinyC_compiler < ass6_18CS10013_18CS10024_test1.c > ass6_18CS10013_18CS10024_quad1.out
	
	@mv output.s ass6_18CS10013_18CS10024_test1.s
	
	@make -s runtest1
	
	@./tinyC_compiler < ass6_18CS10013_18CS10024_test2.c > ass6_18CS10013_18CS10024_quad2.out

	@mv output.s ass6_18CS10013_18CS10024_test2.s
	
	@make -s runtest2

	@./tinyC_compiler < ass6_18CS10013_18CS10024_test3.c > ass6_18CS10013_18CS10024_quad3.out

	@mv output.s ass6_18CS10013_18CS10024_test3.s

	@make -s runtest3

	@./tinyC_compiler < ass6_18CS10013_18CS10024_test4.c > ass6_18CS10013_18CS10024_quad4.out
	
	@mv output.s ass6_18CS10013_18CS10024_test4.s

	@make -s runtest4

	@./tinyC_compiler < ass6_18CS10013_18CS10024_test5.c > ass6_18CS10013_18CS10024_quad5.out
	
	@mv output.s ass6_18CS10013_18CS10024_test5.s

	@make -s runtest5

	@./tinyC_compiler < ass6_18CS10013_18CS10024_test6.c > ass6_18CS10013_18CS10024_quad6.out
	
	@mv output.s ass6_18CS10013_18CS10024_test6.s

	@make -s runtest6

	@echo ""
	@echo "COMMANDS FOR THE TEST CASES"
	@echo "1 : Calculate force                      : ./runtest1"
	@echo "2 : Convert Decimal Number to Binary     : ./runtest2"
	@echo "3 : Greatest Common Divisor Calculation  : ./runtest3"
	@echo "4 : nth Fibonacci Number                 : ./runtest4"
	@echo "5 : Rod Cutting Problem                  : ./runtest5"
	@echo "6 : Merge Sort                           : ./runtest6"
