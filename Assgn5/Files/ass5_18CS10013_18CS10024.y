%{
	#include <iostream>              
	#include <cstdlib>
	#include <string>
	#include <stdio.h>
	#include <sstream>

	#include "ass5_18CS10013_18CS10024_translator.h"

	extern int yylex();
	void yyerror(string s);
	extern string var_type;

	using namespace std;
%}


%union {           

	char unaryOp;		
	char* char_value;	

	int instr_number;		
	int intval;		
	int num_params;			

	Expression* expr;		
	Statement* stat;		

	symboltype* sym_type;	
	sym* symp;		
	Array* A;  
		
} 

%token BREAK CASE CHAR CONTINUE DEFAULT DO DOUBLE ELSE EXTERN FLOAT FOR GOTO IF INT LONG RETURN SHORT SIZEOF STATIC STRUCT SWITCH TYPEDEF UNION VOID WHILE INLINE CONST RESTRICT VOLATILE

%token <symp> IDENTIFIER
%token <intval> INT_CONST
%token <char_value> FLT_CONST
%token <char_value> CHAR_CONST
%token <char_value> STR_LTRL

%token SQ_BKT_OPN SQ_BKT_CLS
%token RND_BKT_OPEN RND_BKT_CLOSE
%token CLY_BKT_OPEN CLY_BKT_CLOSE

%token DOT IMPLIES INC DEC BITW_AND BITW_NOT EXLM MUL ADD SUB DIV MOD SFT_LFT SFT_RHT LT GT 
%token LTE GTE EQ NEQ BITW_XOR BITW_OR AND OR
%token QUESTION COLON SEMICOLON DOTS ASSIGN 
%token MUL_EQ DIV_EQ MOD_EQ ADD_EQ SUB_EQ LT_EQ GT_EQ BITW_AND_EQ BITW_XOR_EQ BITW_OR_EQ 
%token COMMA HASH 

%start translation_unit

%right THEN ELSE

%type <unaryOp> unary_operator

%type <num_params> argument_expression_list argument_expression_list_opt


%type <expr>
	expression
	primary_expression 
	multiplicative_expression
	additive_expression
	shift_expression
	relational_expression
	equality_expression
	and_expression
	exclusive_or_expression
	inclusive_or_expression
	logical_and_expression
	logical_or_expression
	conditional_expression
	assignment_expression
	expression_statement


%type <stat>  statement
	compound_statement
	selection_statement
	iteration_statement
	labeled_statement 
	jump_statement
	block_item
	block_item_list
	block_item_list_opt


%type <sym_type> pointer


%type <symp> initializer
%type <symp> direct_declarator init_declarator declarator


%type <A> postfix_expression
	unary_expression
	cast_expression


%type <instr_number> M
%type <stat> N

%%

M
	: 
	{
		$$=nextinstr();
	}   
	;

N
	:
	{
		$$ =new Statement(); 
		$$->nextlist=makelist(nextinstr());
		emit("goto","");
	}
	;


primary_expression
        : IDENTIFIER
        { 
		debug();
		$$=new Expression();
		update_nextinstr();		 
		$$->loc=$1;
		update_nextinstr();
		$$->type="not-boolean";
		update_nextinstr();
		debug();
	}
        | INT_CONST 
        { 
		debug();   
		$$=new Expression();	
		update_nextinstr();
		string p=convertIntToString($1);
		update_nextinstr();
		$$->loc=gentemp(new symboltype("int"),p);
		update_nextinstr();
		emit("=",$$->loc->name,p);
		update_nextinstr();
		debug();
	}
        | FLT_CONST 
        {    
		debug();
		$$=new Expression();
		update_nextinstr();
		$$->loc=gentemp(new symboltype("float"),$1);
		update_nextinstr();
		emit("=",$$->loc->name,string($1));
		update_nextinstr();
		debug();
	}
        | CHAR_CONST
        {    
		debug();
		$$=new Expression();
		update_nextinstr();
		$$->loc=gentemp(new symboltype("char"),$1);
		update_nextinstr();
		emit("=",$$->loc->name,string($1));
		update_nextinstr();
		debug();
	}
        | STR_LTRL
        {   
		debug();
		$$=new Expression();
		update_nextinstr();
		$$->loc=gentemp(new symboltype("ptr"),$1);
		update_nextinstr();
		$$->loc->type->arrtype=new symboltype("char");
		update_nextinstr();
		debug();
	}
        | RND_BKT_OPEN expression RND_BKT_CLOSE
        { $$=$2;}
        ;
	
postfix_expression
        : primary_expression
        { 
		debug();
		$$=new Array();
		update_nextinstr();
		$$->Array=$1->loc;	
		update_nextinstr();
		$$->type=$1->loc->type;	
		update_nextinstr();
		$$->loc=$$->Array;
		update_nextinstr();
		debug();
	}
        | postfix_expression SQ_BKT_OPN expression SQ_BKT_CLS
        { 	
		debug();
		$$=new Array();
		update_nextinstr();
		$$->type=$1->type->arrtype;
		update_nextinstr();			
		$$->Array=$1->Array;
		update_nextinstr();
		$$->loc=gentemp(new symboltype("int"));
		update_nextinstr();
		$$->atype="arr";
		update_nextinstr();
		if($1->atype=="arr") 
		{
			debug();
			sym* t=gentemp(new symboltype("int"));
			update_nextinstr();
			int p=computeSize($$->type);
			update_nextinstr();
			string str=convertIntToString(p);
			update_nextinstr();
			emit("*",t->name,$3->loc->name,str);
			update_nextinstr();	
			debug();
			emit("+",$$->loc->name,$1->loc->name,t->name);
			update_nextinstr();
			debug();
		}
		else 
		{
			int p=computeSize($$->type);
			update_nextinstr();
			string str=convertIntToString(p);
			update_nextinstr();
			emit("*",$$->loc->name,$3->loc->name,str);
			update_nextinstr();
			debug();
		}
	}
        | postfix_expression RND_BKT_OPEN argument_expression_list_opt RND_BKT_CLOSE
        {
		debug();
		$$=new Array();	
		update_nextinstr();
		$$->Array=gentemp($1->type);
		update_nextinstr();
		string str=convertIntToString($3);
		update_nextinstr();
		emit("call",$$->Array->name,$1->Array->name,str);
		update_nextinstr();
		debug();
	}
        | postfix_expression DOT IDENTIFIER { }
        | postfix_expression IMPLIES IDENTIFIER { }
        | postfix_expression INC
        { 
		debug();
		$$=new Array();
		update_nextinstr();
		$$->Array=gentemp($1->Array->type);
		update_nextinstr();	
		emit("=",$$->Array->name,$1->Array->name);
		update_nextinstr();
		debug();
		emit("+",$1->Array->name,$1->Array->name,"1");
		update_nextinstr();
		debug();
	}
        | postfix_expression DEC
        {
		debug();
		$$=new Array();	
		update_nextinstr();
		$$->Array=gentemp($1->Array->type);
		update_nextinstr();
		emit("=",$$->Array->name,$1->Array->name);
		update_nextinstr();
		debug();
		emit("-",$1->Array->name,$1->Array->name,"1");
		update_nextinstr();
		debug();
	}
        | RND_BKT_OPEN type_name RND_BKT_CLOSE CLY_BKT_OPEN initializer_list CLY_BKT_CLOSE {  }
        | RND_BKT_OPEN type_name RND_BKT_CLOSE CLY_BKT_OPEN initializer_list COMMA CLY_BKT_CLOSE {  }
        ;

argument_expression_list_opt
        : argument_expression_list    { $$=$1; }
        |  { $$=0; } 
        ;

argument_expression_list
        : assignment_expression
        {
		debug();
		$$=1;
		update_nextinstr();
		emit("param",$1->loc->name);	
		update_nextinstr();
		debug();
	}
        | argument_expression_list COMMA assignment_expression
        {
		debug();
		$$=$1+1;
		update_nextinstr();	 
		emit("param",$3->loc->name);
		update_nextinstr();
		debug();
	}
        ;

unary_expression
        : postfix_expression    { $$ = $1; }
        | INC unary_expression
        {  	
		debug();
		emit("+",$2->Array->name,$2->Array->name,"1");
		update_nextinstr();
		debug();
		$$=$2;
		update_nextinstr();
	}
        | DEC unary_expression
        {
		debug();
		emit("-",$2->Array->name,$2->Array->name,"1");
		update_nextinstr();
		debug();
		$$=$2;
		update_nextinstr();
	}
        | unary_operator cast_expression
        {			
		debug();		  	
		$$=new Array();
		update_nextinstr();
		switch($1)
		{	  
			case '&':                                       
				
				$$->Array=gentemp((new symboltype("ptr")));
				update_nextinstr();
				$$->Array->type->arrtype=$2->Array->type; 
				update_nextinstr();
				emit("=&",$$->Array->name,$2->Array->name);
				update_nextinstr();
				debug();
				break;
			case '*':                          
				$$->atype="ptr";
				update_nextinstr();
				$$->loc=gentemp($2->Array->type->arrtype);
				update_nextinstr();
				$$->Array=$2->Array;
				update_nextinstr();
				emit("=*",$$->loc->name,$2->Array->name);
				update_nextinstr();
				debug();
				break;
			case '+':  
				$$=$2;
				debug();
				break;                    
			case '-':				   
				$$->Array=gentemp(new symboltype($2->Array->type->type));
				update_nextinstr();
				emit("uminus",$$->Array->name,$2->Array->name);
				update_nextinstr();
				debug();
				break;
			case '~':                   
				$$->Array=gentemp(new symboltype($2->Array->type->type));
				update_nextinstr();
				emit("~",$$->Array->name,$2->Array->name);
				update_nextinstr();
				debug();
				break;
			case '!':				
				$$->Array=gentemp(new symboltype($2->Array->type->type));
				update_nextinstr();
				emit("!",$$->Array->name,$2->Array->name);
				update_nextinstr();
				debug();
				break;
		}
	}
        | SIZEOF unary_expression    {  }
        | SIZEOF RND_BKT_OPEN type_name RND_BKT_CLOSE   { }
        ;

unary_operator
        : BITW_AND
        { 
		$$='&'; 
		update_nextinstr();
		debug();
	} 
        | MUL
        {
		$$='*'; 
		update_nextinstr();
		debug();
	}
        | ADD
        { 
		$$='+'; 
		update_nextinstr();
		debug();
	}
        | SUB
        { 
		$$='-'; 
		update_nextinstr();
		debug();
	}
        | BITW_NOT
	{ 
		$$='~'; 
		update_nextinstr();
		debug();
	} 
        | EXLM 
	{
		$$='!'; 
		update_nextinstr();
		debug();
	}
        ;

cast_expression
        : unary_expression  { $$=$1; }
        | RND_BKT_OPEN type_name RND_BKT_CLOSE cast_expression
        { 
		debug();
		$$=new Array();	
		update_nextinstr();
		$$->Array=convertType($4->Array,var_type);             
		update_nextinstr();
		debug();
	}
        ;

multiplicative_expression
        : cast_expression
	{
		debug();
		$$ = new Expression();             	
		update_nextinstr();						    
		if($1->atype=="arr") 			   
		{
			$$->loc = gentemp($1->loc->type);	
			update_nextinstr();
			emit("=[]", $$->loc->name, $1->Array->name, $1->loc->name);     
			update_nextinstr();
			debug();
		}
		else if($1->atype=="ptr")         
		{ 
			$$->loc = $1->loc;        
			update_nextinstr();
			debug();
		}
		else
		{
			$$->loc = $1->Array;
			update_nextinstr();
			debug();
		}
	}
        | multiplicative_expression MUL cast_expression
        { 
		debug();
		if(!compareSymbolType($1->loc, $3->Array))         
			cout<<"Type Error in Program"<< endl;	
		else 								 
		{
			$$ = new Expression();	
			update_nextinstr();
			$$->loc = gentemp(new symboltype($1->loc->type->type));
			update_nextinstr();
			emit("*", $$->loc->name, $1->loc->name, $3->Array->name);
			update_nextinstr();
			debug();
		}
	}
        | multiplicative_expression DIV cast_expression
        {
		debug();
		if(!compareSymbolType($1->loc, $3->Array))
			cout << "Type Error in Program"<< endl;
		else    
		{
			$$ = new Expression();
			update_nextinstr();
			$$->loc = gentemp(new symboltype($1->loc->type->type));
			update_nextinstr();
			emit("/", $$->loc->name, $1->loc->name, $3->Array->name);
			update_nextinstr();	
			debug();						
		}
	}
        | multiplicative_expression MOD cast_expression
        {
		debug();
		if(!compareSymbolType($1->loc, $3->Array))
			cout << "Type Error in Program"<< endl;		
		else 		 
		{
			$$ = new Expression();
			update_nextinstr();
			$$->loc = gentemp(new symboltype($1->loc->type->type));
			update_nextinstr();
			emit("%", $$->loc->name, $1->loc->name, $3->Array->name);	
			update_nextinstr();	
			debug();	
		}
	}
        ;

additive_expression
        : multiplicative_expression     { $$ = $1; }
        | additive_expression ADD multiplicative_expression
        {
		debug();
		if(!compareSymbolType($1->loc, $3->loc))
			cout << "Type Error in Program"<< endl;
		else    	
		{
			$$ = new Expression();	
			update_nextinstr();
			$$->loc = gentemp(new symboltype($1->loc->type->type));
			update_nextinstr();
			emit("+", $$->loc->name, $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
		}
	}
        | additive_expression SUB multiplicative_expression
        {
		debug();
		if(!compareSymbolType($1->loc, $3->loc))
			cout << "Type Error in Program"<< endl;		
		else        
		{	
			$$ = new Expression();	
			update_nextinstr();
			$$->loc = gentemp(new symboltype($1->loc->type->type));
			update_nextinstr();
			emit("-", $$->loc->name, $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
		}
	}
        ;

shift_expression
        : additive_expression   { $$=$1; } 
        | shift_expression SFT_LFT additive_expression
        { 
		debug();
		if(!($3->loc->type->type == "int"))
			cout << "Type Error in Program"<< endl; 		
		else            
		{		
			$$ = new Expression();	
			update_nextinstr();
			$$->loc = gentemp(new symboltype("int"));
			update_nextinstr();
			emit("<<", $$->loc->name, $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
		}
	}
        | shift_expression SFT_RHT additive_expression
        { 	
		if(!($3->loc->type->type == "int"))
		{
			debug();
			cout << "Type Error in Program"<< endl; 		
		}
		else  		
		{		
			debug();
			$$ = new Expression();	
			update_nextinstr();
			$$->loc = gentemp(new symboltype("int"));
			update_nextinstr();
			emit(">>", $$->loc->name, $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
		}
	}
        ;

relational_expression
        : shift_expression   { $$=$1; }
        | relational_expression LT shift_expression
        {
		if(!compareSymbolType($1->loc, $3->loc)) 
		{
			debug();
			cout << "Type Error in Program"<< endl;
		}
		else 
		{      
			debug();							
			$$ = new Expression();
			update_nextinstr();
			$$->type = "bool";                        
			update_nextinstr();		
			$$->truelist = makelist(nextinstr());     
			update_nextinstr();
			$$->falselist = makelist(nextinstr()+1);
			update_nextinstr();
			emit("<", "", $1->loc->name, $3->loc->name);     
			update_nextinstr();
			debug();
			emit("goto", "");	
			update_nextinstr();
			debug();
		}
	}
        | relational_expression GT shift_expression
        {
		if(!compareSymbolType($1->loc, $3->loc)) 
		{
			debug();
			cout << "Type Error in Program"<< endl;
		}
		else 
		{
			debug();
			$$ = new Expression();	
			update_nextinstr();
			$$->type = "bool";
			update_nextinstr();
			$$->truelist = makelist(nextinstr());
			update_nextinstr();
			$$->falselist = makelist(nextinstr()+1);
			update_nextinstr();
			emit(">", "", $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
			emit("goto", "");
			update_nextinstr();
			debug();
		}	
	}
        | relational_expression LTE shift_expression
        {
		if(!compareSymbolType($1->loc, $3->loc)) 
		{
			debug();
			cout << "Type Error in Program"<< endl;
		}
		else 
		{		
			debug();
			$$ = new Expression();		
			update_nextinstr();
			$$->type = "bool";
			update_nextinstr();
			$$->truelist = makelist(nextinstr());
			update_nextinstr();
			$$->falselist = makelist(nextinstr()+1);
			update_nextinstr();
			emit("<=", "", $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
			emit("goto", "");
			update_nextinstr();
			debug();
		}		
	}
        | relational_expression GTE shift_expression
        {
		if(!compareSymbolType($1->loc, $3->loc))
		{
			debug(); 
			cout << "Type Error in Program"<< endl;
		}
		else 
		{
			debug();
			$$ = new Expression();
			update_nextinstr();
			$$->type = "bool";
			update_nextinstr();
			$$->truelist = makelist(nextinstr());
			update_nextinstr();
			$$->falselist = makelist(nextinstr()+1);
			update_nextinstr();
			emit(">=", "", $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
			emit("goto", "");
			update_nextinstr();
			debug();
		}
	}
        ;

equality_expression
        : relational_expression { $$=$1; }	
        | equality_expression EQ relational_expression
        {
		if(!compareSymbolType($1->loc, $3->loc))                
		{
			debug();
			cout << "Type Error in Program"<< endl;
		}
		else 
		{
			debug();
			convertBoolToInt($1);                 
			update_nextinstr();	
			convertBoolToInt($3);
			update_nextinstr();
			$$ = new Expression();
			update_nextinstr();
			$$->type = "bool";
			update_nextinstr();
			$$->truelist = makelist(nextinstr());            
			update_nextinstr();
			$$->falselist = makelist(nextinstr()+1); 
			update_nextinstr();
			emit("==", "", $1->loc->name, $3->loc->name);      
			update_nextinstr();
			debug();
			emit("goto", "");				
			update_nextinstr();
			debug();
		}
		
	}
        | equality_expression NEQ relational_expression
        {
		if(!compareSymbolType($1->loc, $3->loc)) 
		{
			debug();
			cout << "Type Error in Program"<< endl;
		}
		else 
		{			
			debug();
			convertBoolToInt($1);	
			update_nextinstr();
			convertBoolToInt($3);
			update_nextinstr();
			$$ = new Expression();                 
			update_nextinstr();
			$$->type = "bool";
			update_nextinstr();
			$$->truelist = makelist(nextinstr());
			update_nextinstr();
			$$->falselist = makelist(nextinstr()+1);
			update_nextinstr();
			emit("!=", "", $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
			emit("goto", "");
			update_nextinstr();
			debug();
		}
	}
        ;

and_expression
        : equality_expression { $$=$1; }
        | and_expression BITW_AND equality_expression
        {
		if(!compareSymbolType($1->loc, $3->loc))         
		{
			debug();		
			cout << "Type Error in Program"<< endl;
		}
		else 
		{
			debug();              
			convertBoolToInt($1);                             
			update_nextinstr();
			convertBoolToInt($3);
			update_nextinstr();
			$$ = new Expression();
			update_nextinstr();
			$$->type = "not-boolean";                   
			update_nextinstr();
			$$->loc = gentemp(new symboltype("int"));
			update_nextinstr();
			emit("&", $$->loc->name, $1->loc->name, $3->loc->name);               
			update_nextinstr();
			debug();
		}
	}
        ;

exclusive_or_expression
        : and_expression  { $$=$1; }
        | exclusive_or_expression BITW_XOR and_expression
        {
		if(!compareSymbolType($1->loc, $3->loc))    
		{
			debug();
			cout << "Type Error in Program"<< endl;
		}
		else 
		{
			debug();
			convertBoolToInt($1);	
			update_nextinstr();
			convertBoolToInt($3);
			update_nextinstr();
			$$ = new Expression();
			update_nextinstr();
			$$->type = "not-boolean";
			update_nextinstr();
			$$->loc = gentemp(new symboltype("int"));
			update_nextinstr();
			emit("^", $$->loc->name, $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
		}
	}
        ;

inclusive_or_expression
        : exclusive_or_expression { $$=$1; }
        | inclusive_or_expression BITW_OR exclusive_or_expression
        { 
		if(!compareSymbolType($1->loc, $3->loc))   
		{
			debug();
			cout << "Type Error in Program"<< endl;
		}
		else 
		{
			debug();
			convertBoolToInt($1);		
			update_nextinstr();
			convertBoolToInt($3);
			update_nextinstr();
			$$ = new Expression();
			update_nextinstr();
			$$->type = "not-boolean";
			update_nextinstr();
			$$->loc = gentemp(new symboltype("int"));
			update_nextinstr();
			emit("|", $$->loc->name, $1->loc->name, $3->loc->name);
			update_nextinstr();
			debug();
		} 
	}
        ;

logical_and_expression
        : inclusive_or_expression  { $$=$1; }
        | logical_and_expression N AND M inclusive_or_expression 
        { 
		debug();
		convertIntToBool($5);       
		update_nextinstr();
		backpatch($2->nextlist, nextinstr());        
		update_nextinstr();
		convertIntToBool($1);                 
		update_nextinstr();
		$$ = new Expression();     
		update_nextinstr();
		$$->type = "bool";
		update_nextinstr();
		backpatch($1->truelist, $4);        
		update_nextinstr();
		$$->truelist = $5->truelist;        
		update_nextinstr();
		$$->falselist = merge($1->falselist, $5->falselist);    
		update_nextinstr();
		debug();
	}
        ;

logical_or_expression
        : logical_and_expression  { $$=$1; }
        | logical_or_expression N OR M logical_and_expression 
        { 
		debug();
		convertIntToBool($5);			 
		update_nextinstr();
		backpatch($2->nextlist, nextinstr());	
		update_nextinstr();
		convertIntToBool($1);			
		update_nextinstr();
		$$ = new Expression();			
		update_nextinstr();
		$$->type = "bool";
		update_nextinstr();
		backpatch($1->falselist, $4);		
		update_nextinstr();
		$$->truelist = merge($1->truelist, $5->truelist);		
		update_nextinstr();
		$$->falselist = $5->falselist;		 	
		update_nextinstr();
		debug();
	}
        ;

conditional_expression
        : logical_or_expression {$$=$1;}
        | logical_or_expression N QUESTION M expression N COLON M conditional_expression 
        {
		debug();
		//normal conversion method to get conditional expressions
		$$->loc = gentemp($5->loc->type);       
		update_nextinstr();
		$$->loc->update($5->loc->type);
		update_nextinstr();
		emit("=", $$->loc->name, $9->loc->name);      
		update_nextinstr();
		debug();
		list<int> l = makelist(nextinstr());        
		emit("goto", "");              
		update_nextinstr();
		debug();
		backpatch($6->nextlist, nextinstr());        
		update_nextinstr();
		emit("=", $$->loc->name, $5->loc->name);
		update_nextinstr();
		debug();
		list<int> m = makelist(nextinstr());         
		update_nextinstr();
		l = merge(l, m);						
		update_nextinstr();
		emit("goto", "");						
		update_nextinstr();
		debug();
		backpatch($2->nextlist, nextinstr());   
		update_nextinstr();
		convertIntToBool($1);                   
		update_nextinstr();
		backpatch($1->truelist, $4);           
		update_nextinstr();
		backpatch($1->falselist, $8);          
		update_nextinstr();
		backpatch(l, nextinstr());
		update_nextinstr();
		debug();
	}
        ;

assignment_expression
        : conditional_expression {$$=$1;}
        | unary_expression assignment_operator assignment_expression
        {
		if($1->atype=="arr")       
		{
			debug();
			$3->loc = convertType($3->loc, $1->type->type);
			update_nextinstr();
			emit("[]=", $1->Array->name, $1->loc->name, $3->loc->name);		
			update_nextinstr();
			debug();
		}
		else if($1->atype=="ptr")     
		{
			debug();
			emit("*=", $1->Array->name, $3->loc->name);		
			update_nextinstr();
			debug();
		}
		else                              
		{
			debug();
			$3->loc = convertType($3->loc, $1->Array->type->type);
			emit("=", $1->Array->name, $3->loc->name);
			update_nextinstr();
			debug();
		}
		$$ = $3;
		debug();	
	}
        ;

assignment_operator
        : ASSIGN   { }
        | MUL_EQ   { }
        | DIV_EQ   { }
        | MOD_EQ   { }
        | ADD_EQ   { }
        | SUB_EQ   { }
        | LTE   { }
        | GTE   { }
        | BITW_AND_EQ   { }
        | BITW_XOR_EQ   { }
        | BITW_OR_EQ   { }
        ;

expression
        : assignment_expression {  $$=$1;  }
        | expression COMMA assignment_expression   { }
        ;

constant_expression
        : conditional_expression   { }
        ;


declaration
	: declaration_specifiers init_declarator_list SEMICOLON {	}
	| declaration_specifiers SEMICOLON {  	}
	;

declaration_specifiers
	: storage_class_specifier declaration_specifiers {	}
	| storage_class_specifier {	}
	| type_specifier declaration_specifiers {	}
	| type_specifier {	}
	| type_qualifier declaration_specifiers {	}
	| type_qualifier {	}
	| function_specifier declaration_specifiers {	}
	| function_specifier {	}
	;


init_declarator_list
        : init_declarator { }
        | init_declarator_list COMMA init_declarator { }
        ;

init_declarator
        : declarator {$$=$1;}
        | declarator ASSIGN initializer
        {
		debug();
		if($3->val!="") $1->val=$3->val;        
		emit("=", $1->name, $3->name);
		update_nextinstr();
		debug();
	}
        ;

storage_class_specifier
        : EXTERN { }
        | STATIC { }
        ;

type_specifier
        : VOID   { var_type="void"; } 
        | CHAR   { var_type="char"; }
        | SHORT { }
        | INT  { var_type="int"; }
        | LONG  { }
        | FLOAT   { var_type="float"; }
        | DOUBLE { }
        ;

specifier_qualifier_list
        : type_specifier specifier_qualifier_list_opt   { }
        | type_qualifier specifier_qualifier_list_opt   { }
        ;

specifier_qualifier_list_opt
        : { }
        | specifier_qualifier_list { }
        ;

type_qualifier
        : CONST { }
        | VOLATILE { }
        | RESTRICT { }
        ;

function_specifier
        : INLINE { }
        ;

declarator
	: pointer direct_declarator 
	{
		debug();
		symboltype *t = $1;
		update_nextinstr();
		while(t->arrtype!=NULL) t = t->arrtype;           
		update_nextinstr();
		t->arrtype = $2->type;                
		update_nextinstr();
		$$ = $2->update($1);                  
		update_nextinstr();
		debug();
	}
	| direct_declarator {   }
	;

direct_declarator
        : IDENTIFIER
        {
		debug();
		$$ = $1->update(new symboltype(var_type));
		update_nextinstr();
		currSymbolPtr = $$;
		update_nextinstr();
		debug();
		
	}
        | RND_BKT_OPEN declarator RND_BKT_CLOSE {$$=$2;}
        | direct_declarator SQ_BKT_OPN type_qualifier_list assignment_expression SQ_BKT_CLS {	}
	| direct_declarator SQ_BKT_OPN type_qualifier_list SQ_BKT_CLS {	}
	| direct_declarator SQ_BKT_OPN assignment_expression SQ_BKT_CLS 
	{
		debug();
		symboltype *t = $1 -> type;
		update_nextinstr();
		symboltype *prev = NULL;
		update_nextinstr();
		while(t->type == "arr") 
		{
			prev = t;	
			t = t->arrtype;      
			update_nextinstr();
		}
		if(prev==NULL) 
		{
			debug();
			int temp = atoi($3->loc->val.c_str());      
			update_nextinstr();
			symboltype* s = new symboltype("arr", $1->type, temp);        
			update_nextinstr();
			$$ = $1->update(s);   //update the symbol table
			update_nextinstr();
			debug();
		}
		else 
		{
			debug();
			prev->arrtype =  new symboltype("arr", t, atoi($3->loc->val.c_str()));     	
			update_nextinstr();
			$$ = $1->update($1->type);
			update_nextinstr();
			debug();
		}
	}
	| direct_declarator SQ_BKT_OPN SQ_BKT_CLS 
	{
		debug();
		symboltype *t = $1 -> type;
		update_nextinstr();
		symboltype *prev = NULL;
		update_nextinstr();
		while(t->type == "arr") 
		{
			prev = t;	
			t = t->arrtype;         
			update_nextinstr();
		}
		if(prev==NULL) 
		{
			debug();
			symboltype* s = new symboltype("arr", $1->type, 0);    
			update_nextinstr();
			$$ = $1->update(s);
			update_nextinstr();
			debug();	
		}
		else 
		{
			debug();
			prev->arrtype =  new symboltype("arr", t, 0);
			update_nextinstr();
			$$ = $1->update($1->type);
			update_nextinstr();
			debug();
		}
	}
	| direct_declarator SQ_BKT_OPN STATIC type_qualifier_list assignment_expression SQ_BKT_CLS {	}
	| direct_declarator SQ_BKT_OPN STATIC assignment_expression SQ_BKT_CLS {	}
	| direct_declarator SQ_BKT_OPN type_qualifier_list MUL SQ_BKT_CLS {	}
	| direct_declarator SQ_BKT_OPN MUL SQ_BKT_CLS {	}
	| direct_declarator RND_BKT_OPEN changetable parameter_type_list RND_BKT_CLOSE 
	{
		debug();
		ST->name = $1->name;
		update_nextinstr();
		if($1->type->type !="void") 
		{
			sym *s = ST->lookup("return");        
			s->update($1->type);
			update_nextinstr();
			debug();
		}
		$1->nested=ST;       
		update_nextinstr();	
		ST->parent = globalST;
		update_nextinstr();
		changeTable(globalST);				
		update_nextinstr();
		currSymbolPtr = $$;
		update_nextinstr();
		debug();
	}
	| direct_declarator RND_BKT_OPEN identifier_list RND_BKT_CLOSE { }
	| direct_declarator RND_BKT_OPEN changetable RND_BKT_CLOSE 
	{ 
		debug();
		ST->name = $1->name;
		update_nextinstr();
		if($1->type->type !="void") 
		{
			sym *s = ST->lookup("return");
			s->update($1->type);
			update_nextinstr();
			debug();			
		}
		$1->nested=ST;
		update_nextinstr();
		ST->parent = globalST;
		update_nextinstr();
		changeTable(globalST);				
		update_nextinstr();
		currSymbolPtr = $$;
		update_nextinstr();
		debug();
	}
        ;


changetable
	:
	{ 													
		if(currSymbolPtr->nested==NULL) 
		{
			debug();
			changeTable(new symtable(""));	
			update_nextinstr();
		}
		else 
		{
			debug();
			changeTable(currSymbolPtr ->nested);						
			update_nextinstr();
			emit("label", ST->name);
			update_nextinstr();
			debug();
		}
	}
	;

pointer
        : MUL type_qualifier_list_opt
        { 
		$$ = new symboltype("ptr");
		update_nextinstr();
		debug();  
	} 
        | MUL type_qualifier_list_opt pointer
        { 
		$$ = new symboltype("ptr",$3);
		update_nextinstr();
		debug(); 
	}
        ;


type_qualifier_list
	: type_qualifier   {  }
	| type_qualifier_list type_qualifier   {  }
	;

type_qualifier_list_opt
	:   {  }
	| type_qualifier_list      {  }
	;

parameter_type_list
        : parameter_list { }
        | parameter_list COMMA DOTS { }
        ;

parameter_list
        : parameter_declaration { }
        | parameter_list COMMA parameter_declaration { }
        ;

parameter_declaration
        : declaration_specifiers declarator { }
        | declaration_specifiers { }
        ;

identifier_list
        : IDENTIFIER { }
        | identifier_list COMMA IDENTIFIER { }
        ;


type_name
        : specifier_qualifier_list { }
        ;

initializer
        : assignment_expression  { $$=$1->loc; }
        | CLY_BKT_OPEN initializer_list CLY_BKT_CLOSE { }
        | CLY_BKT_OPEN initializer_list COMMA CLY_BKT_CLOSE { }
        ;

initializer_list
        : designation_opt initializer { }
        | initializer_list COMMA designation_opt initializer { }
        ;

designation
        : designator_list ASSIGN { }
        ;

designation_opt
	:  {  }
	| designation   {  }
	;

designator_list
        : designator { }
        | designator_list designator { }
        ;

designator
        : SQ_BKT_OPN constant_expression SQ_BKT_CLS { }
        | DOT IDENTIFIER { }
        ;

statement
        : labeled_statement { }
        | compound_statement   { $$=$1; }
        | expression_statement
        { 
		$$=new Statement();             
		$$->nextlist=$1->nextlist; 
	}
        | selection_statement   { $$=$1; }
        | iteration_statement   { $$=$1; }
        | jump_statement   { $$=$1; }
        ;

labeled_statement
        : IDENTIFIER COLON statement { }
        | CASE constant_expression COLON statement { }
        | DEFAULT COLON statement { }
        ;

compound_statement
        : CLY_BKT_OPEN block_item_list_opt CLY_BKT_CLOSE   { $$=$2; }
        ;

block_item_list
        : block_item   { $$=$1; }
        | block_item_list M block_item    
	{ 
		$$=$3;
		backpatch($1->nextlist,$2);     
	}
        ;

block_item_list_opt
	:  { $$=new Statement(); } 
	| block_item_list   { $$=$1; }
	;

block_item
        : declaration   { $$=new Statement(); } 
        | statement   { $$=$1; }
        ;

expression_statement
	: expression SEMICOLON {$$=$1;}
	| SEMICOLON {$$ = new Expression();}
	;

selection_statement
        : IF RND_BKT_OPEN expression N RND_BKT_CLOSE M statement N %prec THEN
        {
		debug();
		backpatch($4->nextlist, nextinstr());        
		update_nextinstr();
		convertIntToBool($3);         
		update_nextinstr();
		$$ = new Statement();        
		update_nextinstr();
		backpatch($3->truelist, $6);        
		update_nextinstr();
		list<int> temp = merge($3->falselist, $7->nextlist);   
		update_nextinstr();
		$$->nextlist = merge($8->nextlist, temp);
		update_nextinstr();
		debug();
	}
        | IF RND_BKT_OPEN expression N RND_BKT_CLOSE M statement N ELSE M statement
        {
		debug();
		backpatch($4->nextlist, nextinstr());	
		update_nextinstr();
		convertIntToBool($3);        
		update_nextinstr();
		$$ = new Statement();       
		update_nextinstr();
		backpatch($3->truelist, $6);    
		update_nextinstr();
		backpatch($3->falselist, $10);
		update_nextinstr();
		list<int> temp = merge($7->nextlist, $8->nextlist);       
		update_nextinstr();
		$$->nextlist = merge($11->nextlist,temp);	
		update_nextinstr();
		debug();	
	}
        | SWITCH RND_BKT_OPEN expression RND_BKT_CLOSE statement { }
        ;

iteration_statement
        : WHILE M RND_BKT_OPEN expression RND_BKT_CLOSE M statement
        {
		debug();
		$$ = new Statement();    
		update_nextinstr();
		convertIntToBool($4);     
		update_nextinstr();
		backpatch($7->nextlist, $2);	
		update_nextinstr();
		backpatch($4->truelist, $6);	
		update_nextinstr();
		$$->nextlist = $4->falselist;   
		update_nextinstr();
		// Emit to prevent fallthrough
		string str=convertIntToString($2);			
		update_nextinstr();
		emit("goto", str);
		update_nextinstr();
		debug();
			
	}
        | DO M statement M WHILE RND_BKT_OPEN expression RND_BKT_CLOSE SEMICOLON
        {
		debug();
		$$ = new Statement();     
		update_nextinstr();
		convertIntToBool($7);     
		update_nextinstr();
		backpatch($7->truelist, $2);						
		update_nextinstr();
		backpatch($3->nextlist, $4);						
		update_nextinstr();
		$$->nextlist = $7->falselist;                       
		update_nextinstr();
		debug();		
	}
        | FOR RND_BKT_OPEN expression_statement M expression_statement RND_BKT_CLOSE M statement
        {
		debug();
		$$ = new Statement();   
		update_nextinstr();
		convertIntToBool($5);    
		update_nextinstr();
		backpatch($5->truelist,$7);       
		update_nextinstr();
		backpatch($8->nextlist,$4);        
		update_nextinstr();
		string str=convertIntToString($4);
		update_nextinstr();
		emit("goto", str);                
		update_nextinstr();
		debug();
		$$->nextlist = $5->falselist;      
		update_nextinstr();
		debug();
	}
        | FOR RND_BKT_OPEN expression_statement M expression_statement M expression N RND_BKT_CLOSE M statement
        {
		debug();
		$$ = new Statement();		 
		update_nextinstr();
		convertIntToBool($5);  
		update_nextinstr();
		backpatch($5->truelist, $10);	
		update_nextinstr();
		backpatch($8->nextlist, $4);	
		update_nextinstr();
		backpatch($11->nextlist, $6);	
		update_nextinstr();
		string str=convertIntToString($6);
		update_nextinstr();
		emit("goto", str);				
		update_nextinstr();
		debug();
		$$->nextlist = $5->falselist;	
		update_nextinstr();
		debug();	
	}
        ;

jump_statement
        : GOTO IDENTIFIER SEMICOLON { $$ = new Statement(); } 
        | CONTINUE SEMICOLON { $$ = new Statement(); } 
        | BREAK SEMICOLON { $$ = new Statement(); } 
        | RETURN expression SEMICOLON               
	{
		debug();
		$$ = new Statement();
		update_nextinstr();
		emit("return",$2->loc->name);
		update_nextinstr();
		debug();
		
	}
	| RETURN SEMICOLON 
	{
		debug();
		$$ = new Statement();
		update_nextinstr();
		emit("return","");                        
		update_nextinstr();
		debug();
	}
        ;

translation_unit
        : external_declaration { }
        | translation_unit external_declaration { }
        ;

external_declaration
        : function_definition { }
        | declaration { }
        ;

function_definition
        : declaration_specifiers declarator declaration_list_opt changetable compound_statement  
        {
		debug();
		int next_instr=0;	 
		update_nextinstr();
		ST->parent=globalST;
		update_nextinstr();
		changeTable(globalST);                     
		update_nextinstr();
		debug();
	}
        ;

declaration_list
        : declaration { }
        | declaration_list declaration { }
        ;

declaration_list_opt
	: {  }
	| declaration_list   {  }
	;


%%

void yyerror(string s) {
    cout << s << endl;
}
