%{
#include "equation.tab.h"
int isatty(int fd);
#define ECHO
%}

digit ([0-9])+
hexdigital [0-9A-Fa-f]
hexstring 0x{hexdigital}+
letter [A-za-z]
identifier ("_"|{letter})("_"|{letter}|{digit})*
field {identifier}("."{identifier})+
%%

"+"                  { /*return PLUS;*/       }
"-"                  { /*return MINUS;*/      }
"*"                  { /*return TIMES;*/      }
"/"                  { /*return SLASH;*/      }
"|"                  { /*return BIT_OR;*/     }
"||"                 { /*return LOGIC_OR;*/     }
"&"                  { /*return BIT_AND;*/     }
"&&"                 { /*return LOGIC_AND;*/     }
"^"                  { /*return BIT_XOR;*/      }
"=="                 { /*return EQL;*/     }
"<>"                 { /*return NEQ;*/        }
"<"                  { /*return LSS;*/        }
">"                  { /*return GTR;*/        }
"<="                 { /*return LEQ;*/        }
">="                 { /*return GEQ;*/        }
"("                  { return LPAREN;     }
")"                  { return RPAREN;     }
","                  { return COMMA;      }
"."                  { /*return PERIOD;*/     }
{field} {
				return FIELD;      }
{identifier} {
				return IDENT;      }
{hexstring} {
				return NUMBER;      }
{digit}+             {
				return NUMBER;     }
" "             /* skip whitespace */
%%

int yywrap()
{
	return 1;
}