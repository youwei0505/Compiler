%{
#include<stdio.h>
unsigned charCount = 0,lineCount = 0;
void print_char();

%} 
String 	[a-zA-Z]+
space [ ]
eol \n
Symbol   .

%%
{String}	{charCount += yyleng; printf("String : \'%s\'\n", yytext);}
{space} {}
{eol}   {lineCount++;}
{Symbol} {print_char();}
%%

int main()
{
	yylex(); 	
	printf("\n\nThe number of characters: %d\n",charCount);
	printf("The number of lines: %d\n", lineCount);
	return 0;
}

void print_char()
{
	printf("[In print_char]Symbol:\'%s\'\n",yytext);charCount++;
}