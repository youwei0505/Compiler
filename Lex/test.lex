%{
#include<stdio.h>
#include<string.h>
#include <ctype.h>

unsigned charCount = 1,lineCount = 1;
void commentL(char *yytext,int lineCount,int charCount)
{
	int str_l = strlen(yytext);
	
	
	printf("Line: %d, 1st char: %d, \"%s\" is a invaild \"commentL\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}
void commentR(char *yytext,int lineCount,int charCount)
{
	int str_l = strlen(yytext);
	/*for(int i=0;i<str_l;i++)
	{
		printf("")	
	}*/
	
	printf("Line: %d, 1st char: %d, \"%s\" is a invaild \"commentR\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}
void comment(char *yytext,int lineCount,int charCount)
{
	int str_l = strlen(yytext);
	
	
	printf("Line: %d, 1st char: %d, \"%s\" is a \"comment\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}
void string(char *yytext,int lineCount,int charCount)
{
	int str_l = strlen(yytext);
	if( str_l > 30)
	{
		printf("Line: %d, 1st char: %d,\"%s\" is a invild \"string(string)\".\n",lineCount,charCount,yytext);
		printf("\033[40;31;5mError :\033[0m\n"); 
		printf("\033[40;31mYour string is wrong ,look for string-(0) : the string is too long , size be in under 30 words.\033[0m\n");
	}
	else
	{
	printf("Line: %d, 1st char: %d, \"%s\" is a \"string(string)\".\n",lineCount,charCount,yytext);
	}	
	lineCount++;charCount = 1;
}
void nostring1(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"string(nostring1)\".\n",lineCount,charCount,yytext);
	printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31mYou couldnt forget to set (') afterhand the string what you tpye in .\033[0m\n ");
	lineCount++;charCount = 1;
}
void nostring2(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"string(nostring2)\".\n",lineCount,charCount,yytext);
	printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31mError :You couldnt forget to set (') beforehand the string what you tpye in .\033[0m\n ");
	lineCount++;charCount = 1;
}
void id(char *yytext,int lineCount,int charCount)
{
	int str_l = strlen(yytext);
	if( str_l > 15)
		{
		printf("Line: %d,1st char: %d,\" %s \" is a invild \"ID\".\n",lineCount,charCount,yytext);
		printf("\033[40;31;5mError : \033[0m\n");
		printf("\033[40;31mYour ID is wrong ,look for ID-(0) : the ID is too long , size be in under 15 words.\033[0m\n");
		}
	else
	{	
	printf("Line: %d, 1st char: %d, \"%s\" is a \"ID(id)\".\n",lineCount,charCount,yytext);
	}
	lineCount++;charCount = 1;
}
void no_Integer(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"Integer(no_Integer)\".\n",lineCount,charCount,yytext);
	printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31mYou shouldnt set '0' in front of the integer with digits , it doesnt make sence.\033[0m\n ");
	lineCount++;charCount = 1;
}
void Integer(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a \"Integer(Integer)\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}
/*
void Integeradd(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a \"Integer\".\n",lineCount,charCount,yytext);
	printf("Line: %d, 1st char: %d, \"%s\" is a \"Integeradd\".\n",lineCount,charCount,yytext);
	printf("Line: %d, 1st char: %d, \"%s\" is a \"Integeradd\".\n",lineCount,charCount,yytext);
	printf("Line: %d, 1st char: %d, \"%s\" is a \"Integeradd\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}
*/
void Inv_id(char *yytext,int lineCount,int charCount)
{
	//printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"ID\".\n",lineCount,charCount,yytext);
	int str_l = strlen(yytext);
	
	if( str_l > 15)
		{
		printf("Line: %d, 1st char: %d,\" %s \" is a invild \"ID\".\n",lineCount,charCount,yytext);
		printf("\033[40;31;5mError :\033[0m\n"); 
		printf("\033[40;31mYour ID is wrong ,look for ID-(0) : the ID is too long , size be in under 15 words.\033[0m\n");
		}
	else
	{
		if( yytext[0] == '#' || yytext[0] == '^')
			{
			printf("Line: %d, 1st char: %d,\" %s \" is a invild \"ID\".\n",lineCount,charCount,yytext);
			printf("\033[40;31;5mError :\033[0m\n"); 
			printf("\033[40;31mYour ID is wrong ,look for ID-(2) : the head isn't be # or ^ .\033[0m\n");
			}
		else if( (yytext[0] < 'a' || yytext[0] > 'z') && (yytext[0] < 'A' || yytext[0] > 'Z') && ( yytext[0] != '_'))
			{
			printf("Line: %d, 1st char: %d,\" %s \" is a invild \"ID\".\n",lineCount,charCount,yytext);
			printf("\033[40;31;5mError :\033[0m\n"); 
			printf("\033[40;31mYour ID is wrong ,look for ID-(1) : the ID need in a ~ z A ~ Z.\033[0m\n");
			}
		else			
			printf("Line: %d, 1st char: %d,\"%s\" is an \"ID\".\n",lineCount,charCount,yytext);
	}
	
	lineCount++;charCount = 1;
}
void small_2(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a \"Real(small_2)\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}
void small(char *yytext,int lineCount,int charCount)
{
	//printf("Line: %d, 1st char: %d, \"%s\" is a \"Real(small)\".\n",lineCount,charCount,yytext);
	int dot=-1;
	int i;
	//printf("\n\ncheck__float\n\n");
	
	int str_l=strlen(yytext);
	char s[str_l];
	strcpy(s,yytext);
	//printf("\nstring is : %s \n",s);
	for(i=0;i<str_l;i++)
		//printf("%c ",s[i]);
	//printf("\nstring long : %d\n\n\n" ,str_l);
	for(i=0;i<str_l;i++)
		if( s[i] == '.')
			{
			//
			dot=i;
			}
	//brfore .
	//for(int i=0;i<str_l;i++)
	if( s[0] == '0')
	{
		if( s[1] != '.')
			{
			printf("Line: %d,1st char: %d, \"%s\" is a invalid \"real(small)\".\n",lineCount,charCount,yytext);
			printf("\033[40;31;5mError :\033[0m\n"); 
			printf("\033[40;31mreal wrong : (1) .\033[0m\n");	
			}	
	}
	/*
	if( s[0]== '0' && ( s[dot] != '0' || s[dot-1] != '.' ) )
		printf(" means  invlid float number. \n\n\n");
	*/
	else if( s[str_l-1] == '0')
	{	
		if( s[str_l-2]== '0' && s[str_l-1]== '0' )
			{
			printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"real(small)\".\n",lineCount,charCount,yytext);
			printf("\033[40;31;5mError :\033[0m\n"); 
			printf("\033[40;31mreal wrong : (2-2) . \033[0m\n");
			}
	}
	else if( s[dot+1] == '\0' && dot != -1 )
		{
		printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"real(small)\".\n",lineCount,charCount,yytext);
		printf("\033[40;31;5mError :\033[0m\n"); 
		printf("\033[40;31mreal wrong : (3) . \033[0m\n");
		}
	else if( s[0] == '.')
		{
		printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"real(small)\".\n",lineCount,charCount,yytext);
		printf("\033[40;31;5mError :\033[0m\n"); 
		printf("\033[40;31mreal wrong : (4) . \033[0m\n");
		}
	else
	printf("Line: %d, 1st char: %d, \"%s\" is a \"real(small)\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}
/*
void no_small1(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"Real(no_small1)\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}
*/
void no_small2(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"Real(no_small2)\".\n",lineCount,charCount,yytext);
	printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31mYou shoudl put integer beforehand the dot(.) .\033[0m\n");
	lineCount++;charCount = 1;
}
void no_small3(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"Real(no_small3)\".\n",lineCount,charCount,yytext);
	printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31mYou shoudl put integer afterhand the dot(.) .\033[0m\n");
	lineCount++;charCount = 1;
}
void real(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a \"Real(real)\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}
void symint(char *yytext,int lineCount,int charCount)
{
	int str_l = strlen(yytext);
	int i;
	
	//printf("%s",yytext);
	//printf("------\n");
	printf("Line: %d, 1st char: %d, \"",lineCount,charCount);
	for(i=0;i<str_l;i++)	
		{
		if(yytext[i] == '+' || yytext[i] == '-')
			{
			printf("\" is a \"integer(symint)\".\n");
			printf("Line: %d, 1st char: %d, \"%c\" is a \"symreal_2\".\n",lineCount,charCount,yytext[i]);
			charCount++;
			printf("Line: %d, 1st char: %d, \"",lineCount,charCount);
			}
		else			
			{
			printf("%c",yytext[i]);
			charCount++;
			}
		/*
			if(i%2 == 0 )
			{
					printf("Line: %d, 1st char: %d, \"%c\" is a \"Symbol(s+i)\".\n",lineCount,charCount++,yytext[i]);
			}
			else
			{
					printf("Line: %d, 1st char: %d, \"%c\" is a \"Integer(s+i)\".\n",lineCount,charCount++,yytext[i]);
			}
		*/
		}
	printf("\" is a \"integer(symint)\".\n");
	//printf("\n");
	
	
	lineCount++;charCount = 1;
}
void symreal_2(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a \"symreal_2\".\n",lineCount,charCount,yytext);
	int str_l = strlen(yytext);
	for(int i=0;i<str_l;i++)	
		{
		printf("%c",yytext[i]);
		}
	printf("\n");
		
	/*if( yytext[0] == '+' || yytext[0] == '-')
	{
		for(int i=0;i<str_l;i++)	
		{
			if(i%2 == 0 )
			{
					printf("Line: %d, 1st char: %d, \"%c\" is a \"Symbol(s+i)\".\n",lineCount,charCount++,yytext[i]);
			}
			else
			{
					printf("Line: %d, 1st char: %d, \"%c\" is a \"Integer(s+i)\".\n",lineCount,charCount++,yytext[i]);
			}
		}
	}
	else
	{
		for(int i=0;i<str_l;i++)	
		{	
			if(i%2 == 0 )
			{
					printf("Line: %d, 1st char: %d, \"%c\" is a \"Symbol(s+i)\".\n",lineCount,charCount++,yytext[i]);
			}
			else
			{
					printf("Line: %d, 1st char: %d, \"%c\" is a \"Integer(s+i)\".\n",lineCount,charCount++,yytext[i]);	
			}
		}
	}
	*/
	lineCount++;charCount = 1;
}
void symbol2(char *yytext,int lineCount,int charCount)
{
	printf("Line: %d, 1st char: %d, \"%s\" is a \"Symbol\".\n",lineCount,charCount,yytext);
	lineCount++;charCount = 1;
}

%}
Reserved_word [Aa][Bb][Ss][Oo][Ll][Uu][Tt][Ee]|[Aa][Nn][Dd]|[Bb][Ee][Gg][Ii][Nn]|[Bb][Rr][Ee][Aa][Kk]|[Cc][Aa][Ss][Ee]|[Cc][Oo][Nn][Ss][Tt]|[Cc][Oo][Nn][Tt][Ii][Nn][Uu][Ee]|[Dd][Oo]|[Ee][Ll][Ss][Ee]|[Ee][Nn][Dd]|[Ff][Oo][Rr]|[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]|[Ii][Ff]|[Mm][Oo][Dd]|[Nn][Ii][Ll]|[Nn][Oo][Tt]|[Oo][Bb][Jj][Ee][Cc][Tt]|[Oo][Ff]|[Oo][Rr]|[Pp][Rr][Oo][Gg][Rr][Aa][Mm]|[Tt][Hh][Ee][Nn]|[Tt][Oo]|[Vv][Aa][Rr]|[Ww][Hh][Ii][Ll][Ee]|[Aa][Rr][Rr][Aa][Yy]|[Ii][Nn][Tt][Ee][Gg][Ee][Rr]|[Dd][Oo][Uu][Bb][Ll][Ee]|[Ww][Rr][Ii][Tt][Ee]|[Ww][Rr][Ii][Tt][Ee][Ll][Nn]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Ff][Ll][Oo][Aa][Tt]|[Rr][Ee][Aa][Dd]
eol             [\n]*
space           [ \t]*
commentL	    \(\*[*]*[^\*\)\n\r\ ]*
commentR	    [^\n\r\(\*\ ]*[*]*\*\)
commentLL	    \(\*[*]*
commentRR	    [*]*\*\)
comment         {commentLL}"("*([^*)]|([^*]")")|("*"[^)]?))*"*"*{commentRR}
alpha           [A-Za-z]
digit           [0-9]
no_string1		\'[^\'\n\ \r]*
no_string2		[^\'\n\ \r]*\'
string			\'([^\n]*)+\'
id              ({alpha}|\_)+({alpha}|{digit}|\_)*
symint			[+-]?{digit}+[\ ]*([+-]+[\ ]*{digit}+)+
symreal_2    	{small}([+-]{small})+
Integeradd		{Integer}[+-]{digit}+
no_Integer	    [+-]*[0]+{digit}+
Integer         [+-]*{digit}+
Inv_id          (\^|\#|{digit})+{id}
no_small1       [+-]*[0][0]+{Integer}*\.{digit}+
small_2         [^+-][^\n]{digit}+\.{digit}+
small           {Integer}\.{digit}+
real            [+-]?({small}|{small}[e|E][+-]{digit}+|{Integer}[e|E][+-]{digit}+)
no_small2       [+-]*\.{digit}+
no_small3       [+-]*{digit}+\.
Inv_real        [+-]?({small}|{small}[e|E][+-]{digit}+|{Integer}[e|E][+-]{digit}+)
symbol2			(,|;|:|\(|\)|:=|\>|\<|=|==|<=|>=|\[|\]|\*|\/|\.|\+|\-)

%%
{Reserved_word}	{
printf("Line: %d, 1st char: %d,\"%s\" is a \"reserved_word\".\n",lineCount,charCount,yytext);
charCount+=yyleng;
}
{eol}         {lineCount++;charCount=1;}
{space}       {charCount+=yyleng;}
{commentL}    {commentL(yytext,lineCount,charCount);charCount+=yyleng;}
{commentR}    {commentR(yytext,lineCount,charCount);charCount+=yyleng;}
{comment}     {comment(yytext,lineCount,charCount);charCount+=yyleng;
	int line=0;
	int str_l = strlen(yytext);
	for(int i=0;i<str_l;i++)
	{		
		//printf("%d:-%c-\n",i+1,yytext[i]);	
		//if(yytext[i] == '\r')
			//printf("rrr\n");
		if(yytext[i] == '\n')
			line++;
	}
	lineCount+=line;
	}
{no_string1}  {nostring1(yytext,lineCount,charCount);charCount+=yyleng;}
{no_string2}  {nostring2(yytext,lineCount,charCount);charCount+=yyleng;}
{string}      {string(yytext,lineCount,charCount);charCount+=yyleng;}
{id}          {id(yytext,lineCount,charCount);charCount+=yyleng;}
{no_Integer}  {no_Integer(yytext,lineCount,charCount);charCount+=yyleng;}
{Integer}     {Integer(yytext,lineCount,charCount);charCount+=yyleng;}
{Inv_id}      {Inv_id(yytext,lineCount,charCount);charCount+=yyleng;}
{small}       {small(yytext,lineCount,charCount);charCount+=yyleng;}
{no_small2}	  {no_small2(yytext,lineCount,charCount);charCount+=yyleng;}
{no_small3}	  {no_small3(yytext,lineCount,charCount);charCount+=yyleng;}
{real}		  {real(yytext,lineCount,charCount);charCount+=yyleng;}
{symint}      {symint(yytext,lineCount,charCount);charCount+=yyleng;}
{symreal_2}   {symreal_2(yytext,lineCount,charCount);charCount+=yyleng;}
{symbol2}     {symbol2(yytext,lineCount,charCount);charCount+=yyleng;}
%%

int main()
{
	yylex();		
	printf("\n\nThe number of characters: %d\n",charCount);
	printf("The number of lines: %d\n", lineCount--);
	return 0;
}

//alpha           [A-Za-z] just for elemnts don't need rules
//{digit}       {printf("digit        \t -%s- \n",yytext);}just for elemnts don't need rules

//{Integeradd}  {Integeradd(yytext,lineCount,charCount);charCount+=yyleng;} not very need to ues
//{small_2}     {small_2(yytext,lineCount,charCount);charCount+=yyleng;} stuck
//{no_small1}	  {no_small1(yytext,lineCount,charCount);charCount+=yyleng;}
void check_comment_one(char *s)
{	
	//printf("stw\t");
	//printf("%s",s);
	printf("\n-----------\n");
	printf("\ncomment : %s\n",s);
	printf("\nlineCount : %d",lineCount);
	printf("\ncharCount : %d",charCount);
	printf("\n-----------\n");
	
	int flag=0;
	int str_l = strlen(s);
	for(int i=0;i<str_l;i++)
		if(s[i] == '*' && s[i+1] == ')'  || s[i] == '(' && s[i+1] == '*')
		{
			flag++;
			//printf("change\n");
			/*for(int j=i;j<str_l;j++)
			{
				if(s[i] == '*' && s[i+1] == ')'  || s[i] == '(' && s[i+1] == '*')
				flag = 1;
			}
			*/
			//printf("\n");
			//printf("\(*");
			//printf("\n");
			
		}
	if( flag%2 != 0)
		{
		printf("flag %d",flag);
		//printf("wrong commoent\n");
		printf("Line: %d, 1st char: %d,\" %s \" is a \"\033[40;31;5mwrong one line comment\033[0m\".\n",lineCount,charCount,yytext);
		charCount = 1;
		}
	else if ( flag%2 == 0)
		{
		//printf("flag %d",flag);
		//printf("correct commnet\n");
		printf("Line: %d, 1st char: %d,\" %s \" is a \" (one line) comment\".\n",lineCount,charCount,yytext);
		charCount = 1;
		}
}
void check_comment(char *s)
{	
	//printf("stw\t");
	//printf("%s",s);
	int flag=0;
	int str_l = strlen(s);
	for(int i=0;i<str_l;i++)
		if(s[i] == '*' && s[i+1] == ')'  || s[i] == '(' && s[i+1] == '*')
		{
			flag++;
			//printf("change\n");
			/*for(int j=i;j<str_l;j++)
			{
				if(s[i] == '*' && s[i+1] == ')'  || s[i] == '(' && s[i+1] == '*')
				flag = 1;
			}
			*/
			//printf("\n");
			//printf("\(*");
			//printf("\n");
			
		}
	if( flag%2 != 0)
		{
		printf("flag %d",flag);
		//printf("wrong commoent\n");
		printf("Line: %d, 1st char: %d, \"%s\" is a \"wrong muti line comment\".\n",lineCount,charCount,yytext);lineCount++;charCount = 1;
		}
	else if ( flag%2 == 0)
		{
		//printf("flag %d",flag);
		//printf("correct commnet\n");
		printf("Line:%d,1st char:%d,\" %s \" is a \"(muti) comment\".\n",lineCount,charCount,yytext);lineCount++;charCount = 1;
		}

}


void string_count(char *s,int lineCount,int charCount)
{	
	printf("\n-----------\n");
	printf("\nstring fuction: %s\n",s);
	printf("\nlineCount : %d",lineCount);
	printf("\ncharCount : %d",charCount);
	printf("\n-----------\n");
	//int n=0;
	//printf("\n\n%s\n\n",s);
	int str_l = strlen(s);
	/*
	for(int i=0;i<str_l;i++)	
		{
			if(s[i] == '\'' && s[i+1] == '\'' && s[i+2] == '\'')
			{				
				printf("\nthere ''' invalid string.\n");
			}
		}
		
	*/
	printf("Line:%d,1st char:%d,\" %s \" is a \"string\".\n",lineCount,charCount,yytext);
	
	if( str_l > 30)
		printf("Line:%d,1st char:%d,\" %s \" is a invild \"string\".\n",lineCount,charCount,s);
	else
	{
	/*
	for(int i=0;i<str_l;i++)	
		{
			if(s[i] == '\'' && s[i+1] == '\'')
			{
				
				for(int j=i;j<str_l;j++)
					{
					s[j]=s[j+1];
					//printf("\n%c",s[j]);
					//printf("%d",str_l);
					}
					
					s[str_l]='\0';				
			}
		}
	*/
	//printf("\ntest 1 : %d,  %d  ,%s  \"string\" \n" , lineCount,charCount+1,yytext);
	//printf("Line:%d,1st char:%d",lineCount,charCount);
	printf("Line:%d,1st char:%d,\" %s \" is a \"string\".\n",lineCount,charCount,s);
	//printf(" Line: %d, 1st char:  %d  ,%s  is a invild \"string\" " , lineCount,charCount+1,yytext);
	}
	
	printf("\nhello2\n");
}
