#ifndef _TRANSLATE_H
#define _TRANSLATE_H

#include <bits/stdc++.h>

extern  char* yytext;
extern  int yyparse();

using namespace std;
#define lsit list<sym>::iterator
#define listi list<int>
#define lstsym list<sym>
#define vec vector
#define stri string
#define vd void
class sym;						
class symboltype;				
class symtable;					
class quad;						
class quadArray;				



class sym 
{                      
	public:
		stri name;				
		symboltype *type;			
		int size;					
		int offset;					
		symtable* nested;			
		stri val;				    

		
		sym (stri , stri t="int", symboltype* ptr = NULL, int width = 0);
		
		sym* update(symboltype*); 	
};
typedef sym s;
class symboltype 
{                      
	public:
		stri type;					
		int width;					   
		symboltype* arrtype;			
		
		symboltype(stri , symboltype* ptr = NULL, int width = 1);
};
typedef symboltype symtyp;
class symtable 
{ 					
	public:
		stri name;				
		int count;					
		lstsym table; 			
		symtable* parent;			
		
		symtable (stri name="NULL");
		
		s* lookup (stri);		
							
		vd print();	
					            			
		vd update();						        			
};
class quad 
{ 			
	public:
		stri res;					
		stri op;					
		stri arg1;				
		stri arg2;				

		
		vd print();	
		vd type1();     
		vd type2();

									
		quad (stri , stri , stri op = "=", stri arg2 = "");			
		quad (stri , int , stri op = "=", stri arg2 = "");				
		quad (stri , float , stri op = "=", stri arg2 = "");			
};

class quadArray 
{ 		
	public:
		vec<quad> Array;		                  
		
		vd print();								
};

class basicType 
{                        
	public:
		vec<stri> type;                    
		vec<int> size;                       
		vd addType(stri ,int );
};

extern symtable* ST;						
extern symtable* globalST;				    
extern s* currSymbolPtr;					    
extern quadArray Q;							
extern basicType bt;                        
extern long long int instr_count;			
extern bool debug_on;			

stri convertIntToString(int );
stri convertFloatToString(float );
vd generateSpaces(int );


s* gentemp (symboltype* , stri init = "");	  


vd emit(stri , stri , stri arg1="", stri arg2 = "");  
vd emit(stri , stri , int, stri arg2 = "");		  
vd emit(stri , stri , float , stri arg2 = "");   


vd backpatch (list <int> , int );
listi makelist (int );							    
listi merge (list<int> &l1, list <int> &l2);		

int nextinstr();										
vd update_nextinstr();

vd debug();											

s* convertType(sym*, stri);								
bool compareSymbolType(sym* &s1, sym* &s2);				
bool compareSymbolType(symboltype*, symboltype*);	
int computeSize (symboltype *);						
stri printType(symboltype *);							
vd changeTable (symtable* );					


struct Statement {
	listi nextlist;					
};

struct Array {
	stri atype;				
	s* loc;					
	s* Array;					
	symboltype* type;			
};

struct Expression {
	s* loc;								
	stri type; 							
	listi truelist;						
	listi falselist;				
	listi nextlist;						
};
typedef Expression* Exps;
vd convertIntToBool(Exps);				
vd convertBoolToInt(Exps);				

#endif