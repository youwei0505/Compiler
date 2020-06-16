%{
#include <stdio.h>
#include <string.h>
int yylex();

extern int line; //
extern int words; //
int error_flag;
extern char* yytext;

void yyerror(const char* message) {
    //printf("Invaild format\n");
    ;
};

int  var_num;
char string_table[30][15];
int  type_num;
char type_table[30][15];
int  int_flag;

struct table {
	char *name;
	char type;
}table;
//flag
int id_com_flag=0;
int error_flag=0;

int i,j,k;//counter
int i_temp;

%}

%start prog_declaration 
%type <stringVal> ID _ID_list_ _varid_ _factor_ _term_ string_content
				 _Integer_num  _Integeradd '(' _simpexp_ ')' '-' 
%union {
	char  stringVal[15];
}
%token  _absolute _and _BEGIN_ _break _case _const _continue DO ELSE _end FOR _function IF MOD _nil _not _object OF _or _program THEN TO _var _while _array _integer _double WRITE WRITELN STRING _float READ ARRAY        
		
		ID
		string_content
		_Integer_num
		_Integeradd
		_real_num
//symbol list	
s_Quote
s_Comma 			 
s_Colon             
s_Period            
s_double_Period     
s_Open_bracket      
s_Close_bracket     
s_Open_parenthesis  
s_Close_parenthesis 
s_Defined           
s_Plus             
s_Minus             
s_Multiply          
s_Divide 	
s_Greater_than	     
s_Less_than         
s_Greater_equal     
s_less_equal        
s_equal  		          

%%
//{ yylval.symbol==';'}
prog_declaration
	:
	| _program     prog_name      	Semicolon 
	  { //initailize
	  	var_num = 0 ; 	 
	  	type_num = 0 ;
	  	for (i =0; i<30 ;i++)
	  		for (j =0; j<15 ;j++)
	  				{string_table[i][j]=0;type_table[i][j]=0;}
	   }
	  _var 
	  			   dec_list      Semicolon     
	  			   	  			
	  _BEGIN_ 
	  			   _stmt_list_     Semicolon   
	  			   			
	   _end DOT	
	;
//checksymbol
DOT 
	: '.'
	| { error_flag=1; printf("\n \033[40;31;5m Error 2-3 : Syntax error, \".\" expected but \"end of file\" found \033[0m");}
	;
	
	
	
Semicolon
	: ';' 
	| { error_flag=1; printf("\n \033[40;31;5m Error 2-2 : Syntax error, \";\" \033[0m");}
	;
	/*
Defined
	: s_Defined
	| '=' {printf("\n \033[40;31;5m Syntax error, \";\" \033[0m");}
	;

*/

prog_name
	: ID
	;
dec_list
	: dec 
	| dec_list Semicolon dec 
	;
dec
	: _ID_list_ ':' _data_type_ 
	{ 
		
		//printf("\nid1 type %s\n",yytext);
		//printf("id1 varnum %d\n",var_num);
		//printf("id1 typenum %d\n",type_num);		
		for(i=type_num;i<var_num;i++)
			{			
			strcpy(type_table[i],yytext);
			//printf("\n*%d : type_ -%s- ",i,type_table[i]);			
			}
		type_num=var_num;
			
			
		//for(i=0;i<type_num;i++) 
			//printf("\n*%d : type -%s- ",i,type_table[i]);
		/*
		for(i=0;i<var_num;i++){
				
				strcpy(type_table[type_num],yytext); 		
		}
		type_num++;	
		*/
		//type_num++;
		/*
		for(i=0;i<var_num;i++)
				  		printf("\n*%d : %s %s",i,string_table[i],type_table[i]);	  
				  		;
		*/	
	}
	| _ID_list_ s_Defined _data_type_ { printf("\n \033[40;31;5m Error 2-1 : Syntax error, \":\" expected but \":=\" found \033[0m"); }
	| _ID_list_ '=' _data_type_ { printf("\n \033[40;31;5m  Error 2-1 : Syntax error, \":\" expected but \":=\" found \033[0m"); }
	;
_ID_list_
	: ID{
			//printf("#1 %s \n",$1);
			//strcpy(string_table[var_num++],$1);
				
			strcpy(string_table[var_num++],$1);	
		  	for(i=0;i<var_num;i++)
		  		//printf("*\n%d : %s \n",i,string_table[i]);	  
		  		;
		}
	| _ID_list_ s_Comma ID{
			//printf("#2 %s \n",$3);
			strcpy(string_table[var_num++],$3);
			//strcpy(string_table[var_num++],$3);
			for(i=0,j=type_num;i<var_num;i++)
		  		//printf("\n*%d : %s \n",i,string_table[i]);	
		  		;  
		}
	;
_data_type_
	: _stand_type_ | _array_type_
	;
_stand_type_
	: _integer | _double | _float | STRING
	;
_array_type_
	:	ARRAY '[' _Integer_num s_double_Period  _Integer_num  ']'  OF  _stand_type_
	;
_stmt_list_
	: _stmt_ | _stmt_list_	Semicolon	_stmt_
	;
_stmt_
	: _assign_ | _read_ | _write_ | _for_ | _if_stmt_ 
	;
_assign_
	: _varid_ {
			
			//printf("$$11%s$$$$",$1);	
			//After begin
			for(i=0;i<var_num;i++)
		  		//printf("*%d : %s \n",i,string_table[i]);	  
		  	//printf("----------------------------");
			//printf("# id = %s # , varnum = %d ",$1,var_num);
			id_com_flag = 0;
			for(i=0;i<var_num;i++)
			{
				if ( strcmp ($1,string_table[i]) ==0 )//the same
					{
					id_com_flag = 1;error_flag=0;
					i_temp = i;
					}
				
			}			
			var_num++;
			
		 }  s_Defined _simpexp_{
		 						if (strcmp(type_table[i],"integer") == 0 ) //same as integer
								printf("\n%d\n",int_flag);
									if ( int_flag )
									;
									else
										{
										printf("\n \033[40;31;5m Illegal expression \033[0m");
										printf("\n \033[40;31;5m Error 1-2 : Incompatible types \"%s\" should be \"%s\" \033[0m",$1,type_table[i_temp]);
									};
							 	if ( id_com_flag == 1) 
									//printf("$1 in array");
									;
								else
									{
									//printf("%s not in array",$1);
									printf("\n \033[40;31;5m Illegal expression \033[0m");
									printf("\n \033[40;31;5m Error 1-1 : Identifier not found \"%s\" \033[0m",$1);
									} 
									
								int_flag =0;
		 } 
	|_varid_ {
			//printf("$$22%s$$$$",$1);	
			//After begin
			for(i=0;i<var_num;i++)
		  		//printf("*%d : %s \n",i,string_table[i]);	  
		  	//printf("----------------------------");
			//printf("# id = %s # , varnum = %d ",$1,var_num);
			id_com_flag = 0;
			for(i=0;i<var_num;i++)
			{
				if ( strcmp ($1,string_table[i]) ==0 )//the same
					{id_com_flag = 1;error_flag=0;}
			}			
			var_num++;
			
		 }  '=' _simpexp_{
		 						//printf("$$44%s$$$$",$3);
		 						//printf("\n \033[40;31;5m Error: Variable \"%s\" does not seem to be initialized \033[0m",$1);
		 						printf("\n \033[40;31;5m Warning: Variable \"%s\" does not seem to be initialized \033[0m",$1);
		 						printf("\n \033[40;31;5m Syntax error \033[0m");
		 						printf("\n \033[40;31;5m Error 2-1 : \"=\" expected but \":=\" found \033[0m"); 
							 	if ( id_com_flag == 1) 
									//printf("$1 in array");
									;
								else
									{
									//printf("%s not in array",$1);
									printf("\n \033[40;31;5m Illegal expression \033[0m");
									printf("\n \033[40;31;5m Error 1-1 : Identifier not found \"%s\"\033[0m",$1);
									} 
		 } 
	| _varid_ ':' _simpexp_ { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n");
	printf("\n \033[40;31;5m Syntax error \033[0m"); 
	printf("\n \033[40;31;5m Error 2-1 : \":\" expected but \":=\" found \033[0m"); 
	} 
	;
_if_stmt_
	: IF '(' _exp_ ')' THEN _body_
	| '(' _exp_ ')' THEN _body_ { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\n Error 3-1 : Syntax error, expected \"If\" \033[0m"); 
	} 
	| IF  _exp_ ')' THEN _body_  { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\n Error 3-4 : Syntax error, expected \"(\" \033[0m"); 
	}
	| IF  '(' _exp_ THEN _body_  { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\n Error 3-4 : Syntax error, expected \")\" \033[0m"); 
	}
	| IF  '(' ')' THEN _body_  { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\n Error 3-5 : Syntax error, expected \"If and expression\" \033[0m"); 
	}
	| THEN _body_ { error_flag=1;
	printf("\033[40;31;5m\n Error 3-5 : Syntax error, expected \"If and expression\" \033[0m"); 
	}
	| IF '(' _exp_ ')' { error_flag=1;
	printf("\033[40;31;5m\n Error 3-2 : Syntax error, \"Then\" expected but \"identifier %s\" found\033[0m",yytext); 
	}
	| IF '(' _exp_ ')' _stmt_ { error_flag=1;
	printf("\033[40;31;5m\n Error 3-2 : Syntax error, \"Then\" expected but \"identifier %s\" found\033[0m",yytext); 
	}
	| IF '(' _exp_ ')' WRITE  '(' _write_list_ ')' { error_flag=1;
	printf("\033[40;31;5m\n Error 3-2 : Syntax error, \"Then\" expected but \"identifier WRITE\" found\033[0m"); 
	}
	| IF '(' _exp_ ')' WRITELN  '(' _write_list_ ')' { error_flag=1;
	printf("\033[40;31;5m\n Error 3-2 : Syntax error, \"Then\" expected but \"identifier WRITELN\" found\033[0m"); 
	}	
	| IF '(' _exp_ ')' _write_  '(' _write_list_ ')' { error_flag=1;
	printf("\033[40;31;5m\n Error 3-2 : Syntax error, \"Then\" expected but \"identifier WRITE\" found\033[0m"); 
	}	
	|  IF '(' _exp_  WRITE  '(' _write_list_ ')' { error_flag=1;
	printf("\033[40;31;5m\n Error 3-2 : Syntax error, \")\" and \"Then\" expected but \"identifier WRITE\" found\033[0m"); 
	}	
	| IF  _exp_ ')' _body_  { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\n Error 3-2 : Error: Syntax error, expected \"(\" and \"Then\" \033[0m"); 
	}
	| IF '(' _exp_ ')' THEN _body_ ELSE _body_
	;
_exp_
	: _simpexp_ | _exp_ _relop_ _simpexp_
	;
_relop_
	: '>' | '<' | s_Greater_equal | s_less_equal | '='
	;

_simpexp_
	: _term_                
	| _simpexp_ '+' _term_
	| _simpexp_ '-' _term_ 
	| string_content
	;
_term_
	: _factor_ //{printf("$$%s$$",$1);}//{strcpy($$,$1);}                
	| _factor_ '*' _factor_
	| _factor_ '/' _factor_
	| _factor_ '%' _factor_
	| _factor_ '+' _factor_ {	
							//printf("$$%s$$ ++ $$%s$$",$1,$3);
							char str_temp1[15];
							char str_temp2[15];
							for(i=0;i<var_num;i++)
							{
								if ( strcmp ($1,string_table[i]) ==0 )//the same
									{//printf("&&%d&&",i);
									strcpy(str_temp1,type_table[i]);}
									
								if ( strcmp ($3,string_table[i]) ==0 )//the same
									{//printf("&&%d&&",i);
									strcpy(str_temp2,type_table[i]);}
							}	
							//printf("\n$$%s$$\n",str_temp1);
							//printf("$$%s$$\n",str_temp2);
							if ( strcmp (str_temp1,str_temp2) )
								{printf("\033[40;31;5m\n Error: Illegal expression\n Error 1-2 : Incompatible types: got \"%s\" expected \"%s\"\033[0m",str_temp2,str_temp1);}
							}
	;
_factor_
	: _varid_  {strcpy($$,$1);}                    
	| _Integer_num   {
						//printf("^^^");
						int_flag = 1;
					  }                               
	| _Integeradd    {
						//printf("^^^");
						int_flag = 1;
					  }  
	| '(' _simpexp_ ')'{
						//printf("^^^");
						int_flag = 1;
					  }  
	;

_for_
	: FOR _index_exp_ DO _body_
	;
_index_exp_
	: _varid_ s_Defined _simpexp_ TO _exp_
	| _varid_ '=' _simpexp_ TO _exp_ { 
	error_flag=1;
	printf("\n \033[40;31;5m Syntax error \033[0m");
	printf("\n Error 2-1 : \":=\" expected but \"=\" found\n"); 
	;}
	;
_varid_
	: ID {
		  //printf("$$33%s$$$$",$1);	
		  strcpy($$,$1);
		 } 
	//printf(" ,str %s",string_table[i]);printf(" ,type %s",type_table[i]);
	//;}
	| ID  '[' _simpexp_ ']'
	;
_body_
	: _stmt_ | _BEGIN_ _stmt_list_ ';' _end
	;	
_read_
	: READ '(' _write_list_ ')'
	| READ 
	;
	
_write_
	: WRITE 
	| WRITE '(' _write_list_ ')' 
	| WRITELN 
	| WRITELN '(' _write_list_ ')' 
	;
_write_list_
	:  
	| ID
	| ID s_Comma _write_list_
	| ID '[' _simpexp_ ']'
	| ID '[' _simpexp_ ']' s_Comma _write_list_	
	| s_Quote '*' s_Quote
	| s_Quote '*' s_Quote s_Comma _write_list_
	| s_Quote '=' s_Quote
	| s_Quote '=' s_Quote s_Comma _write_list_
	| s_Quote  s_Quote
	| s_Quote  s_Quote s_Comma _write_list_
	| s_Quote  ID  s_Quote  _write_list_
	| string_content { int_flag = 0 ;}
	| string_content { int_flag = 0 ;} s_Comma _write_list_
	;
//{printf("***%s***",yytext);}

//check \n
//cat -A file
//truncate -s -1 file
%%
int main() {
	printf("Line  1: ");
    yyparse();
    return 0;
}
