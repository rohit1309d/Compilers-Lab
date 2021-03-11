%{
    #include <stdio.h>
	#include <string.h>
	#include "ass5_18CS10013_18CS10024_translator.h"
	#include "y.tab.h"
%}


/* Regular expression Defination */

%option noyywrap

/*Keywords*/
KEYWORD     "break"|"case"|"char"|"continue"|"struct"|"switch"|"typedef"|"union"|"void"|"while"|"default"|"do"|"double"|"else"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"return"|"short"|"sizeof"|"static"|"volatile"|"inline"|"const"|"restrict"

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


%x single_line_comment multi_line_comment

%%

"//"			{BEGIN(single_line_comment);}
<single_line_comment>[^\n]	{}
<single_line_comment>"\n"		{BEGIN(INITIAL);}
<single_line_comment><<EOF>>	{BEGIN(INITIAL);}

"/*"			{BEGIN(multi_line_comment);}	
<multi_line_comment>[^*]	{}
<multi_line_comment>"*"[^/]	{}
<multi_line_comment>"*/"	{BEGIN(INITIAL);}

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
	if(strcmp(yytext,"const")==0)			{ return CONST; }
	if(strcmp(yytext,"volatile")==0)		{ return VOLATILE; }
	if(strcmp(yytext,"restrict")==0)		{ return RESTRICT; }
	if(strcmp(yytext,"inline")==0)			{ return INLINE; }
	
}

{IDENTIFIER}	{
	yylval.symp = ST->lookup(yytext);
	return IDENTIFIER;
}

{INTEGER_CONSTANT}	{
	yylval.intval = atoi(yytext);
	return INT_CONST;
}

{FLOATING_CONSTANT}	{
	yylval.char_value = yytext;
	return FLT_CONST;
}

{CHARACTER_CONSTANT} {
	yylval.char_value = yytext;
	return CHAR_CONST;
}

{STRING_LITERAL} {
	yylval.char_value = yytext;
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


%%
