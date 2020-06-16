%{
#include "y.tab.h"
#include <stdio.h>
unsigned charCount = 1,lineCount = 1;
int words=1,line=1;

extern int error_flag;
extern int hold_flag ;

char check_table[30][15];
int i_table;//table counter

int i;//counter

int comment_flag = 0;
extern int  var_num;
extern char string_table[30][15];
extern int  type_num;
extern char type_table[30][15];

%}

commentLL	    \(\*[*]*
commentRR	    [*]*\*\)
comment         {commentLL}"("*([^*)]|([^*]")")|("*"[^)]?))*"*"*{commentRR}

absolute [Aa][Bb][Ss][Oo][Ll][Uu][Tt][Ee]
and      [Aa][Nn][Dd]
begin    [Bb][Ee][Gg][Ii][Nn]
break    [Bb][Rr][Ee][Aa][Kk]
case     [Cc][Aa][Ss][Ee]
const    [Cc][Oo][Nn][Ss][Tt]
continue [Cc][Oo][Nn][Tt][Ii][Nn][Uu][Ee]
do       [Dd][Oo]
else     [Ee][Ll][Ss][Ee]
end      [Ee][Nn][Dd]
for      [Ff][Oo][Rr]
function [Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]
if       [Ii][Ff]
mod      [Mm][Oo][Dd]
nil      [Nn][Ii][Ll]
not      [Nn][Oo][Tt]
object   [Oo][Bb][Jj][Ee][Cc][Tt]
of       [Oo][Ff]
or       [Oo][Rr]
program  [Pp][Rr][Oo][Gg][Rr][Aa][Mm]
then     [Tt][Hh][Ee][Nn]
to       [Tt][Oo]
var      [Vv][Aa][Rr]
while    [Ww][Hh][Ii][Ll][Ee]
array    [Aa][Rr][Rr][Aa][Yy]
integer  [Ii][Nn][Tt][Ee][Gg][Ee][Rr]
double   [Dd][Oo][Uu][Bb][Ll][Ee]
write    [Ww][Rr][Ii][Tt][Ee]
writeln  [Ww][Rr][Ii][Tt][Ee][Ll][Nn]
string   [Ss][Tt][Rr][Ii][Nn][Gg]
float    [Ff][Ll][Oo][Aa][Tt]
read     [Rr][Ee][Aa][Dd]


alpha           [A-Za-z]
digit           [0-9]

id              ({alpha}|\_)+({alpha}|{digit}|\_)*
string_content  \'([^\n]*)+\'

Integer_num     [+-]*{digit}+
Integeradd		{Integer_num}[+-]{digit}+
small           {Integer_num}\.{digit}+
real            [+-]?({small}|{small}[e|E][+-]{digit}+|{Integer_num}[e|E][+-]{digit}+)

eol             \n
space           [ \t]

symbol_Quote             \'
symbol_Comma 			 ,
symbol_Colon             :
symbol_Semicolon         ;
symbol_Period            \.
symbol_double_Period     \.\.
symbol_Open_bracket      \[
symbol_Close_bracket     \]
symbol_Open_parenthesis  \(
symbol_Close_parenthesis \)
symbol_Open_brace        \{
symbol_Close_brace       \}
symbol_Defined           :=
symbol_Plus              \+
symbol_Minus             -
symbol_Multiply          \*
symbol_Multiply2         \'\*\'
symbol_Divide 			 \/
symbol_Greater_than	     \<
symbol_Less_than         \>
symbol_Greater_equal     >=
symbol_less_equal        <=
symbol_equal             =


%%
{comment}       {//printf("--comment111--");line;
				//++line;
				for( i=0; i < yyleng ; i ++)
				{
					if (yytext[i] ==  '\n')
						++line;
				}
				comment_flag = 1;
				} 

{absolute}      {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _absolute;}
{and}           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _and;}
{array}         {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return ARRAY;}
{begin}         {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _BEGIN_;}
{break}         {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _break;}
{case}          {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _case;}
{const}         {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _const;}
{continue}      {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _continue;}
{do}            {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return DO;}
{double}        {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _double;}
{else}          {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return ELSE;}
{end}           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _end;}
{for}           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return FOR;}
{float}         {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _float;}
{function}      {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _function;}
{if}            {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return IF;}
{integer}       {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _integer;}
{mod}           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '%';}
{nil}           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _nil;}
{not}           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _not;}
{object}        {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _object;}
{of}            {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return OF;}
{or}            {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _or;}
{program}       {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _program;}
{then}          {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return THEN;}
{to}            {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return TO;}
{var}           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _var;}
{while}         {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _while;}
{write}         {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return WRITE;}
{writeln}       {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return WRITELN;}
{string}        {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return STRING;}
{read}          {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return READ;}

{id}                   {
						printf("%s",yytext);
						strcpy(check_table[i_table++],yytext);
						strcpy(yylval.stringVal,yytext);
					    //	sscanf(yytext, "%s" ,&yylval.stringVal);
						words += yyleng;		
						return ID;
						}
{string_content}        {
						printf("%s",yytext);
						strcpy(check_table[i_table++],yytext);
						words += yyleng;		
						return string_content;			
						}
						
{Integer_num}          {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _Integer_num;}
{Integeradd}           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _Integeradd;}
{real}		           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return _real_num;}

{symbol_Quote}             {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return s_Quote;}
{symbol_Comma}             {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return s_Comma;}
{symbol_Colon}             {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return ':';}
{symbol_Period}            {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '.';}
{symbol_Semicolon}         {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return ';';}
{symbol_double_Period}     {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return s_double_Period;}
{symbol_Open_bracket}      {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '[';}
{symbol_Close_bracket}     {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return ']';}
{symbol_Open_brace}        {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '{';}
{symbol_Close_brace}       {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '}';}
{symbol_Open_parenthesis}  {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '(';}
{symbol_Close_parenthesis} {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return ')';}
{symbol_Defined}           {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return s_Defined;}
{symbol_Plus}              {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '+';}
{symbol_Minus}             {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '-';}
{symbol_Multiply}          {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '*';}
{symbol_Divide}            {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '/';}
{symbol_Greater_than}      {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '>';}
{symbol_Less_than}         {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '<';}
{symbol_Greater_equal}     {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return s_Greater_equal;}
{symbol_less_equal}        {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return s_less_equal;}
{symbol_equal}             {printf("%s",yytext);strcpy(check_table[i_table++],yytext);words += yyleng;return '=';}

{space}       { words+=yyleng;
				//printf(" %d",words);
				strcpy(check_table[i_table++],yytext);
				printf(" ");
			  }
{eol}               {
					/*
					//check list which have
					printf("\n---------\n");
					printf("%stttt %2d: ",yytext,++line);
					for(i=0;i<i_table;i++)
						{
						printf("%s",check_table[i]);
						}
					printf("\n---------\n");
					*/
					/*
					printf("\n------------------------\n");
					{
	  				
	  				for(i=0;i<var_num;i++)
				  		//printf("\n*%d : var_ -%s- ",i,string_table[i]);
				  	for(i=0;i<type_num;i++)
				  		//printf("\n*%d : text -%s- ",i,type_table[i]);
				  	;
	  			    } 
	  			   // printf("\n------------------------\n");
	  			   */
	  			   /*
	  			   	if ( hold_flag )
	  			   	{
	  			   		hold_flag = 0;
	  			   	}
	  			   	*/
					if ( error_flag )
						{
						printf("%sLine %2d: ",yytext,++line);						
						error_flag=0;
						break;
						}
					
					if ( comment_flag == 1 )
						{
						//printf("%d %snono %2d: ",comment_flag,yytext,++line);
						//printf("%snoLn %2d: ",yytext,++line);
						//++line;
						;
						}
					else
						{
						//printf("%d %sLine %2d: ",comment_flag,yytext,++line);
						printf("%sLine %2d: ",yytext,++line);
						}
						comment_flag = 0;
						words=1;
						//printf(" %d",words);
						i_table=0;
						//return '\n';
					}
					
%%


