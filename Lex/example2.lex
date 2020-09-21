 /*test*/
%{
#include <stdio.h>
#include <string.h>
int words = 1,line = 1,i = 0,num = 0;
char *table[1000];
void string_cut(char *s)
{
	char temp[1000];
	strcpy(temp,s);
	for(i = 0; temp[i]!='\0'; i++)
	{
		if(temp[i] == '\\' && temp[i+1] == '\"')
		{
			for(i; temp[i]!='\0'; i++)
			{				
				temp[i] = temp [i+1];
			}
			string_cut(temp);
		}
	}
	strcpy(s,temp);
}
void create()
{
	for(i = 0;i<1000; i++)
		table[i] = NULL;  
}
int lookup(char *s)
{
	int can_new = 0;
	for(i = 0; i<num; i++)
	{
		int test = strcmp(s,table[i]);
		if(test == 0)
		{
			can_new = 0;
			break;
		}
		else
			can_new = 1;
	}
	if(can_new == 1 || num == 0)
		return -1;
}
void insert(char *s) 
{
	table[num]=(char*) malloc(sizeof(char*));
	strcpy(table[num],s);
	num++;
}
void dump() 
{
	printf("The symbol table contains:\n");
	for(i = 0; i<num; i++)
		printf("%s\n",table[i]);
}
void comment_line_add(char *s) 
{
	for(i = 0; s[i]!='\0'; i++)
	{
		if(s[i] == '\n')
			line++;
	}
}

%}
change_line \n
one_comment \/\/[^\n]*\n
comment\/\*(.*[\n]*)*\*\/
symbol [,:;\(\)\[\]\{\}]
operator (\+\+|\+|--|-|\*|\/|%|==|>=|>|<=|<|!=|=|&&|\|\||!)
reserved_words boolean|break|byte|case|char|catch|class|const|continue|default|do|double|else|extends|false|final|finally|float|for|if|implements|int|long|new|private|protected|public|return|short|static|string|switch|this|true|try|void|while
ID [a-zA-Z_\$][a-zA-Z0-9_\$]*
Integer [\+-]?[0-9]+
not_ID [0-9][a-zA-Z0-9_\$]+
small {Integer}\.[0-9]+
not_small [\+-]*[0-9]*([\.]+[0-9]*){1,}
Float [\+-]?({small}|{small}[eE][\+-][0-9]+|{Integer}[eE][\+-][0-9]+)
not_Float [\+-]*({not_small}|{not_small}[eE]*[\+-]*[0-9]+)
string_constants \"([^\n"]|\\\")*\"
not_string \"[^\n]*\"
character .

%%
{change_line} {line++; words = 1;}
{one_comment} {printf("Line: %d, 1st char: %d, \"%s\" is a \"comment\".\n",line,words,yytext);line++;words = 1;}
{comment} {printf("Line: %d, 1st char: %d, \"%s\" is a \"comment\".\n",line,words,yytext);words += yyleng;comment_line_add(yytext);}
{symbol} {printf("Line: %d, 1st char: %d, \"%s\" is a \"symbol\".\n",line,words,yytext);words += yyleng;}
{operator} {printf("Line: %d, 1st char: %d, \"%s\" is an \"operator\".\n",line,words,yytext);words += yyleng;}
{reserved_words} {printf("Line: %d, 1st char: %d, \"%s\" is a \"reserved word\".\n",line,words,yytext);words += yyleng;}
{ID} {if(lookup(yytext) == -1) insert(yytext);printf("Line: %d, 1st char: %d, \"%s\" is an \"ID\".\n",line,words,yytext);words += yyleng;}
{Integer} {printf("Line: %d, 1st char: %d, \"%s\" is an \"Integer\".\n",line,words,yytext);words += yyleng;}
{not_ID} {printf("Line: %d, 1st char: %d, \"%s\" is an \"error\".\n",line,words,yytext);words += yyleng;}
{Float} {printf("Line: %d, 1st char: %d, \"%s\" is a \"real\".\n",line,words,yytext);words++;}
{not_small} {printf("Line: %d, 1st char: %d, \"%s\" is an \"error\".\n",line,words,yytext);words += yyleng;}
{string_constants} {string_cut(yytext); printf("Line: %d, 1st char: %d, %s is a \"string\".\n",line,words+1,yytext);words += yyleng;words--;}
{not_string} {printf("Line: %d, 1st char: %d, %s is an \"error\".\n",line,words+1,yytext);words += yyleng;words--;}
{character} {words++;}
%%
int main(){ 
	create();
	yylex();
	dump();
	return 0;
} 
