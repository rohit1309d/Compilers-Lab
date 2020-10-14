%{
    #include<stdio.h>
    #include<string.h>
%}

%{
    #define BREAK       1
    #define CASE        2
    #define CHAR        3
    #define CONTINUE    4
    #define DEFAULT     5
    #define DO          6
    #define DOUBLE      7
    #define ELSE        8
    #define EXTERN      9
    #define FLOAT       10
    #define FOR         11
    #define GOTO        12
    #define IF          13
    #define INT         14
    #define LONG        15
    #define RETURN      16
    #define SHORT       17
    #define SIZEOF      18
    #define STATIC      19
    #define STRUCT      20
    #define SWITCH      21
    #define TYPEDEF     22
    #define UNION       23
    #define VOID        24
    #define WHILE       25

	#define SQ_BKT_OPN      26
	#define SQ_BKT_CLS 	    27
	#define RND_BKT_OPEN 	28
	#define RND_BKT_CLOSE 	29
	#define CLY_BKT_OPEN 	30
	#define CLY_BKT_CLOSE   31

  #define IDENTIFIER 		32
	#define INT_CONST 		33
	#define FLT_CONST 		34
	#define CHAR_CONST 		35
	#define STR_LTRL 		36

  #define S_LINE_CMNT		37
  #define M_LINE_CMNT	 	38

	#define DOT 				39
	#define IMPLIES 			40
	#define INC 				41
	#define DEC 				42
	#define BITW_AND			43
	#define BITW_NOT			44
	#define EXLM     			45
	#define MUL 				46
	#define ADD 				47
	#define SUB 				48
	#define DIV 				49
	#define MOD 				50
	#define SFT_LFT 			51
	#define SFT_RHT      		52
	#define LT  	 			53
	#define GT   				54
	#define LTE 				55
	#define GTE 				56
	#define EQ 					57
	#define NEQ 				58
	#define BITW_XOR 	    	59
	#define BITW_OR 			60
	#define AND 				61
	#define OR 					62
	#define QUESTION 			63
	#define COLON 				64
	#define SEMICOLON 			65
	#define DOTS 				    66
	#define COMMA 				  67
	#define HASH 				    68
	#define ASSIGN 				  69
	#define MUL_EQ   			  70
	#define DIV_EQ 				  71
	#define MOD_EQ 				  72
	#define ADD_EQ 				  73
	#define SUB_EQ 				  74
	#define LT_EQ 				  75
	#define GT_EQ 				  76
	#define BITW_AND_EQ 	  77
	#define BITW_XOR_EQ 		78
	#define BITW_OR_EQ   		79

%}

/* Regular expression Defination */

/*Keywords*/
KEYWORD     "break"|"case"|"char"|"continue"|"struct"|"switch"|"typedef"|"union"|"void"|"while"|"default"|"do"|"double"|"else"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"return"|"short"|"sizeof"|"static"

/*IDENTIFIER*/

DIGIT						[0-9]
IDENTIFIER_NONDIGIT 		[a-zA-Z]|"_"
IDENTIFIER 					{IDENTIFIER_NONDIGIT}({IDENTIFIER_NONDIGIT}|{DIGIT})*

/*CONSTANTS*/

INTEGER_CONSTANT			{NONZERO_INTEGER_CONSTANT}|"0"
NONZERO_INTEGER_CONSTANT	{NONZERO_DIGIT}({NONZERO_DIGIT}|{DIGIT})*
NONZERO_DIGIT				[1-9]

CONSTANT                    {INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{IDENTIFIER}|{CHARACTER_CONSTANT}

FLOATING_CONSTANT			({FRACTIONAL_CONSTANT}{EXPONENT_PART}?)|({DIGIT_SEQUENCE}{EXPONENT_PART})
FRACTIONAL_CONSTANT			({DIGIT_SEQUENCE}?"."{DIGIT_SEQUENCE})|({DIGIT_SEQUENCE}".")
EXPONENT_PART				("e"{SIGN}?{DIGIT_SEQUENCE})|("E"{SIGN}?{DIGIT_SEQUENCE})
SIGN 						"+"|"-"
DIGIT_SEQUENCE				{DIGIT}({DIGIT})*

ESCAPE_SEQUENCE				"\'"|"\""|"\?"|"\\"|"\a"|"\b"|"\f"|"\n"|"\r"|"\t"|"\v"
C_CHAR 						{ESCAPE_SEQUENCE}|[^("\'"|"\\"|"\n")]
C_CHAR_SEQUENCE				{C_CHAR}+
CHARACTER_CONSTANT			"\'"{C_CHAR_SEQUENCE}"\'"


/*STRING_LITERALS*/
S_CHAR  					{ESCAPE_SEQUENCE}|[^("\""|"\\"|"\n")]
S_CHAR_SEQUENCE				{S_CHAR}+
STRING_LITERAL 				"\""{S_CHAR_SEQUENCE}?"\""


/*PUNCTUATORS*/
PUNCTUATOR 					"["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"


/*COMMENTS*/
SINGLE_LINE_COMMENT [/][/].*
MULTI_COMMENT_START [/][\*]+
MULTI_COMMENT_END	[\*]+[/]
MULTI_LINE_COMMENT ({MULTI_COMMENT_START}(([^\*])|((\*)+[^/\*]))*{MULTI_COMMENT_END})

/* Definitions of Rules \& Actions */
%%

{KEYWORD}   {
    if(strcmp(yytext,"break")==0)			{ return BREAK; }
    if(strcmp(yytext,"case")==0)			{ return CASE; }
    if(strcmp(yytext,"char")==0)		  	{ return CHAR; }
    if(strcmp(yytext,"continue")==0)		{ return CONTINUE; }
    if(strcmp(yytext,"default")==0)			{ return DEFAULT; }
    if(strcmp(yytext,"do")==0)				{ return DO; }
    if(strcmp(yytext,"double")==0)			{ return DOUBLE; }
    if(strcmp(yytext,"else")==0)			{ return ELSE; }
    if(strcmp(yytext,"extern")==0)			{ return EXTERN; }
    if(strcmp(yytext,"short")==0)			{ return SHORT; }
    if(strcmp(yytext,"sizeof")==0)			{ return SIZEOF; }
    if(strcmp(yytext,"static")==0)			{ return STATIC; }
    if(strcmp(yytext,"struct")==0)			{ return STRUCT; }
    if(strcmp(yytext,"switch")==0)			{ return SWITCH; }
    if(strcmp(yytext,"typedef")==0)			{ return TYPEDEF; }
    if(strcmp(yytext,"float")==0)			{ return FLOAT; }
    if(strcmp(yytext,"for")==0)				{ return FOR; }
    if(strcmp(yytext,"goto")==0)			{ return GOTO; }
    if(strcmp(yytext,"if")==0)				{ return IF; }
    if(strcmp(yytext,"int")==0)				{ return INT; }
    if(strcmp(yytext,"long")==0)			{ return LONG; }
    if(strcmp(yytext,"return")==0)			{ return RETURN; }
    if(strcmp(yytext,"union")==0)			{ return UNION; }
    if(strcmp(yytext,"void")==0)			{ return VOID; }
    if(strcmp(yytext,"while")==0)			{ return WHILE; }
}

{IDENTIFIER}	{
	return IDENTIFIER;
}

{INTEGER_CONSTANT}	{
	return INT_CONST;
}

{FLOATING_CONSTANT}	{
	return FLT_CONST;
}

{CHARACTER_CONSTANT} {
	return CHAR_CONST;
}

{STRING_LITERAL} {
	return STR_LTRL;
}


{PUNCTUATOR}	{

	if(strcmp(yytext,"[") == 0) return SQ_BKT_OPN;
	if(strcmp(yytext,"]") == 0) return SQ_BKT_CLS;
	if(strcmp(yytext,"(") == 0) return RND_BKT_OPEN;
	if(strcmp(yytext,")") == 0) return RND_BKT_CLOSE;
	if(strcmp(yytext,"{") == 0) return CLY_BKT_OPEN;
	if(strcmp(yytext,"}") == 0) return CLY_BKT_CLOSE;

	if(strcmp(yytext,".") == 0) return DOT;
	if(strcmp(yytext,"->") == 0) return IMPLIES;
	if(strcmp(yytext,"++") == 0) return INC;
	if(strcmp(yytext,"--") == 0) return DEC;
	if(strcmp(yytext,"&") == 0) return BITW_AND;
	if(strcmp(yytext,"*") == 0) return MUL;
	if(strcmp(yytext,"+") == 0) return ADD;
	if(strcmp(yytext,"-") == 0) return SUB;
	if(strcmp(yytext,"~") == 0) return BITW_NOT;
	if(strcmp(yytext,"!") == 0) return EXLM;
	if(strcmp(yytext,"/") == 0) return DIV;
	if(strcmp(yytext,"%") == 0) return MOD;
	if(strcmp(yytext,"<<") == 0) return SFT_LFT;
	if(strcmp(yytext,">>") == 0) return SFT_RHT;
	if(strcmp(yytext,"<") == 0) return LT;
	if(strcmp(yytext,">") == 0) return GT;
	if(strcmp(yytext,"<=") == 0) return LTE;
	if(strcmp(yytext,">=") == 0) return GTE;
	if(strcmp(yytext,"==") == 0) return EQ;
	if(strcmp(yytext,"!=") == 0) return NEQ;
	if(strcmp(yytext,"^") == 0) return BITW_XOR;
	if(strcmp(yytext,"|") == 0) return BITW_OR;
	if(strcmp(yytext,"&&") == 0) return AND;
	if(strcmp(yytext,"...") == 0) return DOTS;
	if(strcmp(yytext,"=") == 0) return ASSIGN;
	if(strcmp(yytext,"*=") == 0) return MUL_EQ;
	if(strcmp(yytext,"/=") == 0) return DIV_EQ;
	if(strcmp(yytext,"%=") == 0) return MOD_EQ;
	if(strcmp(yytext,"+=") == 0) return ADD_EQ;
	if(strcmp(yytext,"-=") == 0) return SUB_EQ;
	if(strcmp(yytext,"||") == 0) return OR;
	if(strcmp(yytext,"?") == 0) return QUESTION;
	if(strcmp(yytext,":") == 0) return COLON;
	if(strcmp(yytext,";") == 0) return SEMICOLON;
	if(strcmp(yytext,",") == 0) return COMMA;
	if(strcmp(yytext,"#") == 0) return HASH;
	if(strcmp(yytext,"<<=") == 0) return LT_EQ;
	if(strcmp(yytext,">>=") == 0) return GT_EQ;
	if(strcmp(yytext,"&=") == 0) return BITW_AND_EQ;
	if(strcmp(yytext,"^=") == 0) return BITW_XOR_EQ;
	if(strcmp(yytext,"|=") == 0) return BITW_OR_EQ;
}

"\n"|" "|"\t"	{

}

{SINGLE_LINE_COMMENT}		{return S_LINE_CMNT;}
{MULTI_LINE_COMMENT} 		{return M_LINE_CMNT;}

%%
