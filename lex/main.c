//win_flex.exe -o equation.lex.c equation.lex.l
extern "C"
{
	void* yy_scan_string(const char * base);
	int yylex(void);
	char *yytext;
};

	yy_scan_string(str);
	stack<FuncCall> functions;
	while (1)
	{
		int type = yylex();
		if (type <= 0)
			break;
		//yytext
		switch (type)
		{
		case IDENT:
		case FIELD:
			break;
		case NUMBER:
			break;
		case COMMA:
			break;
		case LPAREN:
			break;		
			break;
		}
	}
