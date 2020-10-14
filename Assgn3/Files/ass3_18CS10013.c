#include <stdio.h>
extern char* yytext;
int main() 
{ 
	int token;
	while (token = yylex()) 
	{
		switch (token) 
		{
			case IDENTIFIER: printf("< IDENTIFIER"); 
                                break;
			case INT_CONST: printf("< INTEGER_CONSTANT"); 
                                break;
			case FLT_CONST: printf("< FLOATING_CONSTANT"); 
                                break;
			case CHAR_CONST: printf("< CHARACTER_CONSTANT"); 
                                break;
			case STR_LTRL: printf("< STRING_LITERAL"); 
                                break;

			case SQ_BKT_OPN : printf("< SQUARE_BRACKET_OPEN"); 
                                break;
    		case SQ_BKT_CLS: printf("< SQUARE_BRACKET_CLOSE"); 
                                break;
    		case RND_BKT_OPEN : printf("< ROUND_BRACKET_OPEN"); 
                                break;
     		case RND_BKT_CLOSE: printf("< ROUND_BRACKET_CLOSE"); 
                                break;
    		case CLY_BKT_OPEN: printf("< CURLY_BRACKET_OPEN"); 
                                break;
    		case CLY_BKT_CLOSE: printf("< CURLY_BRACKET_CLOSE"); 
                                break;

    		case DOT: printf("< DOT"); 
                break;
    		case IMPLIES: printf("< IMPLIES"); 
                break;
    		case INC: printf("< INC"); 
                break;
    		case DEC: printf("< DEC"); 
                break;
    		case BITW_AND: printf("< BITWISE_AND"); 
                break;
    		case MUL: printf("< MUL"); 
                break;
    		case ADD: printf("< ADD"); 
                break;
    		case SUB: printf("< SUB"); 
                break;
    		case BITW_NOT: printf("< BITWISE_NOT"); 
                break;
   	 		case EXLM: printf("< EXCLAIM"); 
                break;
    		case DIV: printf("< DIV"); 
                break;
    		case MOD: printf("< MOD"); 
                break;
    		case SFT_LFT: printf("< SHIFT_LEFT"); 
                break;
    		case SFT_RHT: printf("< SHIFT_RIGHT"); 
                break;
    		case LT: printf("< BIT_SL"); 
                break;
    		case GT: printf("< BIT_SR"); 
                break;
    		case LTE: printf("< LTE"); 
                break;
    		case GTE: printf("< GTE"); 
                break;
            case EQ: printf("< EQ"); 
                break;
    		case NEQ: printf("< NEQ"); 
                break;
    		case BITW_XOR: printf("< BITWISE_XOR"); 
                break;
    		case BITW_OR: printf("< BITWISE_OR"); 
                break;
    		case AND: printf("< AND"); 
                break;
    		case OR: printf("< OR"); 
                break;
    		case QUESTION: printf("< QUESTION"); 
                break;
    		case COLON: printf("< COLON"); 
                break;
    		case SEMICOLON: printf("< SEMICOLON"); 
                break;
    		case DOTS: printf("< DOTS"); 
                break;
    		case ASSIGN: printf("< ASSIGN"); 
                break;
    		case MUL_EQ: printf("< STAR_EQ"); 
                break;
    		case DIV_EQ: printf("< DIV_EQ"); 
                break;
    		case MOD_EQ: printf("< MOD_EQ"); 
                break;
    		case ADD_EQ: printf("< ADD_EQ"); 
                break;
    		case SUB_EQ: printf("< SUB_EQ"); 
                break;
    		case LT_EQ: printf("< SL_EQ"); 
                break;
    		case GT_EQ: printf("< SR_EQ"); 
                break;
    		case BITW_AND_EQ: printf("< BITWISE_AND_EQ"); 
                break;
    		case BITW_XOR_EQ: printf("< BITWISE_XOR_EQ"); 
                break;
    		case BITW_OR_EQ: printf("< BITWISE_OR_EQ"); 
                break;
   			case COMMA: printf("< COMMA"); 
                break;
    		case HASH: printf("< HASH"); 
                break;
			case S_LINE_CMNT: printf("< SINGLE_LINE_COMMENT"); 
                break;
			case M_LINE_CMNT: printf("< MULTI_LINE_COMMENT"); 
                break;
			default: printf("< KEYWORD"); 
		}

        printf(", %d, %s>\n",token,yytext);
	}
}