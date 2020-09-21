 /*test*/
%{
#include<stdio.h>
#include<string.h>
unsigned charCount = 0,lineCount = 0;
void print_char();
void print_Symbol();

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
	printf("\nstring : %s\n",yytext);
	printf("\nlineCount : %d",lineCount);
	printf("\ncharCount : %d",charCount);
	printf("\n-----------\n");
	int n=0;
	printf("\n\n%s\n\n",s);
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
	if( str_l > 30)
		printf("Line:%d,1st char:%d,\" %s \" is a invild \"string\".\n",lineCount,charCount,s);
	else
	{
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
	//printf("%s\n\n",s);
	printf("Line:%d,1st char:%d,\" %s \" is a \"string\".\n",lineCount,charCount+1,yytext);
	}
}
void check__int(char *s)
{
	printf("\n\ncheck__int\n\n");
	printf("\n int is : %s\n\n",s);
	int str_l=strlen(s);
	
}
void check_float(char *s)
{
	int dot=-1;
	int i;
	//printf("\n\ncheck__float\n\n");
	//printf("\nstring is : %s",s);
	int str_l=strlen(s);
	//printf("\nstring long : %d\n\n\n" ,str_l);
	for(i=0;i<str_l;i++)
		if( s[i] == '.')
			{
			//printf(" %d is . \n",i);
			dot=i;
			}
	//brfore .
	//for(int i=0;i<str_l;i++)
	if( s[0] == '0')
	{
		if( s[1] != '.')
			{
			printf("Line:%d,1st char:%d,\"%s\" is a invalid \"real(Float)\".\n",lineCount,charCount,yytext);
			printf(" real wrong : (1) .\n\n");	
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
			printf("Line:%d,1st char:%d,\"%s\" is a invalid \"real(Float)\".\n",lineCount,charCount,yytext);
			printf(" real wrong : (2-2) . \n\n");
			}
	}
	else if( s[dot+1] == '\0' && dot != -1 )
		{
		printf("Line:%d,1st char:%d,\"%s\" is a invalid \"real(Float)\".\n",lineCount,charCount,yytext);
		printf(" real wrong : (3) . \n\n");
		}
	else if( s[0] == '.')
		{
		printf("Line:%d,1st char:%d,\"%s\" is a invalid \"real(Float)\".\n",lineCount,charCount,yytext);
		printf(" real wrong : (4) . \n\n");
		}
	else
	printf("Line:%d,1st char:%d,\"%s\" is a \"real(Float)\".\n",lineCount,charCount,yytext);
}
void check_id(char *s,int lineCount,int charCount)
{
	printf("\n\nid : %s\n\n",s);
	int str_l = strlen(s);
	
	if( str_l > 15)
		{
		printf("Line:%d,1st char:%d,\" %s \" is a invild \"ID\".\n",lineCount,charCount,s);
		printf("ID wrong (0) : the ID is too long , size be in under 15 words.\n");
		}
	else
	{
		if( s[0] == '#' || s[0] == '^')
			{
			printf("Line:%d,1st char:%d,\" %s \" is a invild \"ID\".\n",lineCount,charCount,s);
			printf("ID wrong (2) : the head isn't be # or ^ .\n");
			}
		else if( (s[0] < 'a' || s[0] > 'z') && (s[0] < 'A' || s[0] > 'Z') && ( s[0] != '_'))
			{
			printf("Line:%d,1st char:%d,\" %s \" is a invild \"ID\".\n",lineCount,charCount,s);
			printf("ID wrong (1) : the ID need in a ~ z A ~ Z.\n");
			}
		else			
			printf("Line:%d,1st char:%d,\"%s\" is an \"ID\".\n",lineCount,charCount,yytext);
	}
	
	//charCount += yyleng;
}


%}
eol \n
one_comment \(\*[^\n]*\*\)
comment\(\*(.*[\n]*)*\*\)
symbol :=|[,|:|;|\(|\)|\[|\]|\{|\}]
operator (\+\+|\+|--|-|\*|\/|%|==|>=|>|<=|<|!=|=|&&|\|\||!)
Reserved_word [Aa][Bb][Ss][Oo][Ll][Uu][Tt][Ee]|[Aa][Nn][Dd]|[Bb][Ee][Gg][Ii][Nn]|[Bb][Rr][Ee][Aa][Kk]|[Cc][Aa][Ss][Ee]|[Cc][Oo][Nn][Ss][Tt]|[Cc][Oo][Nn][Tt][Ii][Nn][Uu][Ee]|[Dd][Oo]|[Ee][Ll][Ss][Ee]|[Ee][Nn][Dd]|[Ff][Oo][Rr]|[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]|[Ii][Ff]|[Mm][Oo][Dd]|[Nn][Ii][Ll]|[Nn][Oo][Tt]|[Oo][Bb][Jj][Ee][Cc][Tt]|[Oo][Ff]|[Oo][Rr]|[Pp][Rr][Oo][Gg][Rr][Aa][Mm]|[Tt][Hh][Ee][Nn]|[Tt][Oo]|[Vv][Aa][Rr]|[Ww][Hh][Ii][Ll][Ee]|[Aa][Rr][Rr][Aa][Yy]|[Ii][Nn][Tt][Ee][Gg][Ee][Rr]|[Dd][Oo][Uu][Bb][Ll][Ee]|[Ww][Rr][Ii][Tt][Ee]|[Ww][Rr][Ii][Tt][Ee][Ll][Nn]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Ff][Ll][Oo][Aa][Tt]|[Rr][Ee][Aa][Dd]
string_constants \'[^\n]*\'
non_string \'[^\n|^\|^\'|^;]*|[^\n|^ |^\|^\'|^;]*\'
ID [0-9a-zA-Z_\^\#\$][a-zA-Z0-9_\$]*
Integer ([\+-]|[0-9])*[0-9]
Float [\+-]?({small}|{small}[eE][\+-][0-9]+|{Integer}[eE][\+-][0-9]+)
small {Integer}\.[0-9]+
not_small [\+-]*[0-9]*([\.]+[0-9]*){1,}
not_Float [\+-]*({not_small}|{not_small}[eE]*[\+-]*[0-9]+)
space [ ]



%%
{eol}   {lineCount++;charCount=1;}
{space}	{charCount++;}
{one_comment} {
//printf("sss\t %s \n",yytext);
check_comment_one(yytext);
//printf("ttt\t %s \n",yytext);
//printf("Line: %d, 1st char: %d, \"%s\" is a \"one line comment\".\n",lineCount,charCount,yytext);lineCount++;charCount = 1;

}
{comment} {
//printf("ttt\t");
check_comment(yytext);
//printf("Line: %d, 1st char: %d, \"%s\" is a \"mulit comment\".\n",lineCount,charCount,yytext);lineCount++;charCount = 1;
}
{symbol} {
printf("\n-----------\n");
printf("\nsymbol : %s\n",yytext);
printf("\nlineCount : %d",lineCount);
printf("\ncharCount : %d",charCount);
printf("\n-----------\n");
printf("Line:%d,1st char:%d,\"%s\" is a \"smybol\".\n",lineCount,charCount,yytext);
charCount+=yyleng;
}
{operator} {
printf("\n-----------\n");
printf("\noperator : %s\n",yytext);
printf("\nlineCount : %d",lineCount);
printf("\ncharCount : %d",charCount);
printf("\n-----------\n");
printf("Line:%d,1st char:%d,\"%s\" is an \"operator\".\n",lineCount,charCount,yytext);charCount += yyleng;
}
{Reserved_word}	{
printf("\n-----------\n");
printf("\nReserved_word : %s\n",yytext);
printf("\nlineCount : %d",lineCount);
printf("\ncharCount : %d",charCount);
printf("\n-----------\n");
printf("Line:%d,1st char:%d,\"%s\" is a \"reserved_word\".\n",lineCount,charCount,yytext);
charCount+=yyleng;
}
{string_constants} {
printf("\n-----------\n");
printf("\nstring : %s\n",yytext);
printf("\nlineCount : %d",lineCount);
printf("\ncharCount : %d",charCount);
printf("\n-----------\n");
string_count(yytext,lineCount,charCount);
//charCount += yyleng;
}
{non_string} {
//printf("hello");
int len = strlen(yytext);
//printf("\nyyleng : %d",len);
char str[len];
//strcpy(str, yytext);
printf("\n-----------\n");
printf("\nnonstring : %s\n",yytext);
printf("\nlineCount : %d",lineCount);
printf("\ncharCount : %d",charCount);
printf("\n-----------\n");
string_count(yytext,lineCount,charCount);
//printf("\nyytest : %s",str);
//printf("\nlineCount : %d",lineCount);
//printf("\ncharCount : %d",charCount);


//printf("Line:%d,1st char:%d,\"%s\" is a invild \"string\".\n",lineCount,charCount,yytext);
//charCount += yyleng;
}

{Integer} {
printf("\n-----------\n");
printf("\nint : %s\n",yytext);
printf("\nlineCount : %d",lineCount);
printf("\ncharCount : %d",charCount);
printf("\n-----------\n");
check__int(yytext);
printf("Line:%d,1st char:%d,\"%s\" is an \"Integer\".\n",lineCount,charCount,yytext);
charCount += yyleng;
}

{ID} {
printf("\n-----------\n");
printf("\nid : %s\n",yytext);
printf("\nlineCount : %d",lineCount);
printf("\ncharCount : %d",charCount);
printf("\n-----------\n");
check_id(yytext,lineCount,charCount);
//printf("Line:%d,1st char:%d,\"%s\" is an invalid \"ID\".\n",lineCount,charCount,yytext);
//charCount += yyleng;

}



{Float} {
printf("\n-----------\n");
printf("\nfloat : %s\n",yytext);
printf("\nlineCount : %d",lineCount);
printf("\ncharCount : %d",charCount);
printf("\n-----------\n");
check_float(yytext);
//printf("Line:%d,1st char:%d,\"%s\" is a \"real(Float)\".\n",lineCount,charCount,yytext);
charCount++;
}
{not_small} {
check_float(yytext);
printf("Line:%d,1st char:%d,\"%s\" is an \"not_small\".\n",lineCount,charCount,yytext);

charCount += yyleng;
}



%%

int main()
{
	lineCount++;
	charCount++;
	yylex();		
	printf("\n\nThe number of characters: %d\n",charCount);
	printf("The number of lines: %d\n", lineCount--);
	return 0;
}

