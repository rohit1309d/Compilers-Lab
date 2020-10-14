%{ /* C Declarations and Definitions */
	#include <string.h>
	#include <stdio.h>

	extern int yylex();
	void yyerror(const char*);
%}


%token BREAK CASE CHAR CONTINUE DEFAULT DO DOUBLE ELSE EXTERN FLOAT FOR GOTO IF INT LONG RETURN SHORT SIZEOF STATIC STRUCT SWITCH TYPEDEF UNION VOID WHILE INLINE CONST RESTRICT VOLATILE

%token IDENTIFIER INT_CONST FLT_CONST CHAR_CONST STR_LTRL

%token SQ_BKT_OPN SQ_BKT_CLS
%token RND_BKT_OPEN RND_BKT_CLOSE
%token CLY_BKT_OPEN CLY_BKT_CLOSE

%token DOT IMPLIES INC DEC BITW_AND BITW_NOT EXLM MUL ADD SUB DIV MOD SFT_LFT SFT_RHT LT GT 
%token LTE GTE EQ NEQ BITW_XOR BITW_OR AND OR
%token QUESTION COLON SEMICOLON DOTS ASSIGN 
%token MUL_EQ DIV_EQ MOD_EQ ADD_EQ SUB_EQ LT_EQ GT_EQ BITW_AND_EQ BITW_XOR_EQ BITW_OR_EQ 
%token COMMA HASH 

%start translation_unit

%%

primary_expression
        : IDENTIFIER
        | INT_CONST 
        | FLT_CONST 
        | CHAR_CONST
        | STR_LTRL
        | RND_BKT_OPEN expression RND_BKT_CLOSE
        ;
	
postfix_expression
        : primary_expression
        | postfix_expression SQ_BKT_OPN expression SQ_BKT_CLS
        | postfix_expression RND_BKT_OPEN argument_expression_list_opt RND_BKT_CLOSE
        | postfix_expression DOT IDENTIFIER
        | postfix_expression IMPLIES IDENTIFIER
        | postfix_expression INC
        | postfix_expression DEC
        | RND_BKT_OPEN type_name RND_BKT_CLOSE CLY_BKT_OPEN initializer_list CLY_BKT_CLOSE
        | RND_BKT_OPEN type_name RND_BKT_CLOSE CLY_BKT_OPEN initializer_list COMMA CLY_BKT_CLOSE
        ;

argument_expression_list_opt
        : argument_expression_list
        |
        ;

argument_expression_list
        : assignment_expression
        | argument_expression_list COMMA assignment_expression
        ;

unary_expression
        : postfix_expression
        | INC unary_expression
        | DEC unary_expression
        | unary_operator cast_expression
        | SIZEOF unary_expression
        | SIZEOF RND_BKT_OPEN type_name RND_BKT_CLOSE
        ;

unary_operator
        : BITW_AND
        | MUL
        | ADD
        | SUB
        | BITW_NOT
        | EXLM
        ;

cast_expression
        : unary_expression
        | RND_BKT_OPEN type_name RND_BKT_CLOSE cast_expression
        ;

multiplicative_expression
        : cast_expression
        | multiplicative_expression MUL cast_expression
        | multiplicative_expression DIV cast_expression
        | multiplicative_expression MOD cast_expression
        ;

additive_expression
        : multiplicative_expression
        | additive_expression ADD multiplicative_expression
        | additive_expression SUB multiplicative_expression
        ;

shift_expression
        : additive_expression
        | shift_expression SFT_LFT additive_expression
        | shift_expression SFT_RHT additive_expression
        ;

relational_expression
        : shift_expression
        | relational_expression LT shift_expression
        | relational_expression GT shift_expression
        | relational_expression LTE shift_expression
        | relational_expression GTE shift_expression
        ;

equality_expression
        : relational_expression
        | equality_expression EQ relational_expression
        | equality_expression NEQ relational_expression
        ;

and_expression
        : equality_expression
        | and_expression BITW_AND equality_expression
        ;

exclusive_or_expression
        : and_expression
        | exclusive_or_expression BITW_XOR and_expression
        ;

inclusive_or_expression
        : exclusive_or_expression
        | inclusive_or_expression BITW_OR exclusive_or_expression
        ;

logical_and_expression
        : inclusive_or_expression
        | logical_and_expression AND inclusive_or_expression
        ;

logical_or_expression
        : logical_and_expression
        | logical_or_expression OR logical_and_expression
        ;

conditional_expression
        : logical_or_expression
        | logical_or_expression QUESTION expression COLON conditional_expression
        ;

assignment_expression
        : conditional_expression
        | unary_expression assignment_operator assignment_expression
        ;

assignment_expression_opt
        : assignment_expression
        |
        ;

assignment_operator
        : ASSIGN
        | MUL_EQ
        | DIV_EQ
        | MOD_EQ
        | ADD_EQ
        | SUB_EQ
        | LTE
        | GTE
        | BITW_AND_EQ
        | BITW_XOR_EQ
        | BITW_OR_EQ
        ;

expression
        : assignment_expression
        | expression COMMA assignment_expression
        ;

constant_expression
        : conditional_expression
        ;

expression_opt
        : expression
        |
        ;

declaration
        : declaration_specifiers init_declarator_list_opt SEMICOLON
        ;

declaration_specifiers
        : storage_class_specifier declaration_specifiers_opt
        | type_specifier declaration_specifiers_opt
        | type_qualifier declaration_specifiers_opt
        | function_specifier declaration_specifiers_opt
        ;

declaration_specifiers_opt
        : declaration_specifiers
        |
        ;

init_declarator_list_opt
        : init_declarator_list
        |
        ;

init_declarator_list
        : init_declarator
        | init_declarator_list COMMA init_declarator
        ;

init_declarator
        : declarator
        | declarator ASSIGN initializer
        ;

storage_class_specifier
        : EXTERN
        | STATIC
        ;

type_specifier
        : VOID
        | CHAR
        | SHORT
        | INT
        | LONG
        | FLOAT
        | DOUBLE
        ;

specifier_qualifier_list
        : type_specifier specifier_qualifier_list_opt
        | type_qualifier specifier_qualifier_list_opt
        ;

specifier_qualifier_list_opt
        : specifier_qualifier_list
        |
        ;

type_qualifier
        : CONST
        | VOLATILE
        | RESTRICT
        ;

function_specifier
        : INLINE
        ;

declarator
        : pointer_opt direct_declarator
        ;

direct_declarator
        : IDENTIFIER
        | RND_BKT_OPEN declarator RND_BKT_CLOSE
        | direct_declarator SQ_BKT_OPN  type_qualifier_list_opt assignment_expression_opt SQ_BKT_CLS
        | direct_declarator SQ_BKT_OPN STATIC type_qualifier_list_opt assignment_expression SQ_BKT_CLS
        | direct_declarator SQ_BKT_OPN type_qualifier_list STATIC assignment_expression SQ_BKT_CLS
        | direct_declarator SQ_BKT_OPN type_qualifier_list_opt MUL SQ_BKT_CLS
        | direct_declarator RND_BKT_OPEN parameter_type_list RND_BKT_CLOSE
        | direct_declarator RND_BKT_OPEN identifier_list_opt RND_BKT_CLOSE
        ;

pointer
        : MUL type_qualifier_list_opt
        | MUL type_qualifier_list_opt pointer
        ;

pointer_opt
        : pointer
        |
        ;

type_qualifier_list
        : type_qualifier
        | type_qualifier_list type_qualifier
        ;

type_qualifier_list_opt
        : type_qualifier_list
        |
        ;

parameter_type_list
        : parameter_list
        | parameter_list COMMA DOTS
        ;

parameter_list
        : parameter_declaration
        | parameter_list COMMA parameter_declaration
        ;

parameter_declaration
        : declaration_specifiers declarator
        | declaration_specifiers
        ;

identifier_list
        : IDENTIFIER
        | identifier_list COMMA IDENTIFIER
        ;

identifier_list_opt
        : identifier_list
        |
        ;

type_name
        : specifier_qualifier_list
        ;

initializer
        : assignment_expression
        | CLY_BKT_OPEN initializer_list CLY_BKT_CLOSE
        | CLY_BKT_OPEN initializer_list COMMA CLY_BKT_CLOSE
        ;

initializer_list
        : designation_opt initializer
        | initializer_list COMMA designation_opt initializer
        ;

designation
        : designator_list ASSIGN
        ;

designation_opt
        : designation
        |
        ;

designator_list
        : designator
        | designator_list designator
        ;

designator
        : SQ_BKT_OPN constant_expression SQ_BKT_CLS
        | DOT IDENTIFIER
        ;

statement
        : labeled_statement
        | compound_statement
        | expression_statement
        | selection_statement
        | iteration_statement
        | jump_statement
        ;

labeled_statement
        : IDENTIFIER COLON statement
        | CASE constant_expression COLON statement
        | DEFAULT COLON statement
        ;

compound_statement
        : CLY_BKT_OPEN block_item_list_opt CLY_BKT_CLOSE
        ;

block_item_list
        : block_item
        | block_item_list block_item
        ;

block_item_list_opt
        : block_item_list
        |
        ;

block_item
        : declaration
        | statement
        ;

expression_statement
        : expression_opt SEMICOLON
        ;

selection_statement
        : IF RND_BKT_OPEN expression RND_BKT_CLOSE statement
        | IF RND_BKT_OPEN expression RND_BKT_CLOSE statement ELSE statement
        | SWITCH RND_BKT_OPEN expression RND_BKT_CLOSE statement
        ;

iteration_statement
        : WHILE RND_BKT_OPEN expression RND_BKT_CLOSE statement
        | DO statement WHILE RND_BKT_OPEN expression RND_BKT_CLOSE SEMICOLON
        | FOR RND_BKT_OPEN expression_opt SEMICOLON expression_opt SEMICOLON expression_opt RND_BKT_CLOSE statement
        | FOR RND_BKT_OPEN declaration expression_opt SEMICOLON expression_opt RND_BKT_CLOSE statement
        ;

jump_statement
        : GOTO IDENTIFIER SEMICOLON
        | CONTINUE SEMICOLON
        | BREAK SEMICOLON
        | RETURN expression_opt SEMICOLON
        ;

translation_unit
        : external_declaration
        | translation_unit external_declaration
        ;

external_declaration
        : function_definition
        | declaration
        ;

function_definition
        : declaration_specifiers declarator declaration_list_opt compound_statement
        ;

declaration_list
        : declaration
        | declaration_list declaration
        ;

declaration_list_opt
        : declaration_list
        |
        ;

%%

void yyerror(const char *s) {
    printf("Error occured : %s\n",s);
}
