# National Sun Yat-sen University 
# 國立中山大學
## DESIGN AND IMPLEMENTATION OF COMPILER
## 編    譯    器    製    作
## Yacc報告
### 授課教師：張玉盈 教授
### 系級:資訊工程學系110級
### 學生:B053022059 蔣有為
### 日期：109.6.5
#### 更新版本MD https://hackmd.io/@7a3qwWmESmi3CKKE4NDUtw/rJ_r44S38
---
### ***編譯規格:***
1. Lex版本: flex 2.6.4
2. Yacc版本: bison (GNU Bison) 3.0.4
3. 作業平台: Linux ubuntu 5.3.0-42-generic #34~18.04.1-Ubuntu SMP Fri Feb 28 13:42:26 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
4.	執行方式:
  	makefile:
    ```
    all:	y.tab.c lex.yy.c 
	gcc lex.yy.c y.tab.c -ly -lfl

    y.tab.c:
	bison -y -d ex.y

    lex.yy.c:	
	flex ex.l

    clean:
	rm a.out lex.yy.c y.tab.c y.tab.h
	clear
    ```
--- 
### ***函式庫規格:***
Lex:
```C
#include "y.tab.h"
#include <stdio.h>
```
Yacc:
```C
#include <stdio.h>
#include <string.h>
```
--- 
### ***變數規格:***
#### Lex:
```C
int words=1,line=1;
```   
計算每行個次數跟字數。
```C
extern int error_flag
```
```C
extern int  hold_flag
```
作為在yacc中的標籤。 
```C
char check_table[30][15];
```
```C
int i_table;//table counter
```
為Symbol Table。 
```C
int i;//counter
```
會使用到的計算器
```C
int comment_flag = 0;
```
針對comment的情況所設立的標籤。
```C
extern int  var_num;
```
```C
extern char string_table[30][15];
```
```C
extern int  type_num;
```
```C
extern char type_table[30][15];
```
為Symbol Table:
string_table : 存放Var變數的內容
  type_table : 存放Var變數的型態
#### YACC:
```C
extern int line;
```
```C
extern int words;
```
在Lex中，計算每行個次數跟字數。
```C
int error_flag;
```
判斷錯誤訊息的標籤，以便供Lex端去判斷。
```C
extern char* yytext;
```
得到Lex所擷取到的token。
```C
void yyerror(const char* message) {
    //printf("Invaild format\n");
    ;
};
```
最為有趣的函式，是內建的!!!
```C
int  var_num;
char string_table[30][15];
int  type_num;
char type_table[30][15];
int  int_flag;
```
為Symbol Table:
string_table : 存放Var變數的內容
  type_table : 存放Var變數的型態
```C
struct table {
	char *name;
	char type;
}table;
```
有考慮用 struct方式去實作，但是沒有思考時間。作罷
```C
int id_com_flag=0;
int error_flag=0;
```
判斷錯誤訊息的標籤，以便供Lex端去判斷。
```C
int i,j,k;//counter
int i_temp;
```
這幾個單純是作為，程式執行過程中的counter，因為這是C!

---
***關於Lex的部分:***
(1). 保留字 (Reserved_word)
Pascal 是 case insensitive 。 例如：保留字 program、ProGram 和 PROGRAM 是一樣的。
因為是保留字，選擇放在Rlues中相當上面的位置，給予較高的優先權。
其中有提到，要針對保留字做篩選，並且是不分大小寫，然而許多的保留字在輸入的時候，會有不方便輸入且看不清楚，因此直接寫了一個C程式，直接輸出想要的保留字表示法列表。
(2). 識別字 (Identifiers )
一個識別字的第一個字元必須是英文字母 a-zA-z或是底線符號 _ 開始，在第一個字元之後，可以是英文字母、數字和底線符號。識別字裡不可包含空白字元。
Rules : 
```C
({alpha}|\_)+({alpha}|{digit}|\_)*
```
因為在HW1，已經實作內容，這次只簡單帶過。
(3). 符號 (Symbols)
這邊將所有的Symbols都獨立出來，為了是在yacc作判斷時候可以準確知道當下Token的Symbol是否匹配對。
Rules : 
```C
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
```
(4). 整數 (Integer)
整數可以有正負，數字會緊接在正負號後，因此
Rules : 
```C  
[+-]*{digit}+ 
```
因為在HW1，已經實作內容，這次只簡單帶過。
(5). 實數 (Real) 
常數可以有正負，且有小數點 (decimal point) 表示法和科學符號表示法兩種。
Rule:  
```C
[+-]?({small}|{small}[e|E][+-]{digit}+|{Integer}[e|E][+-]{digit}+)
```
因為在HW1，已經實作內容，這次只簡單帶過。
這邊要注意的是:![](https://i.imgur.com/F83Jvgo.png)
我已經將integer作為保留字，因此回傳的時候，真正的integer數值，要用另外一個var(integer_num)去回傳。
(6). 字串 (quoted string) 
Rule: 
```C
\'([^\n]*)+\'
```
只要非換行都讀入，並且以’’為起始標誌和終止標誌。
因為在HW1，已經實作內容，這次只簡單帶過。
(7).Comment
Rule:
```C
commentLL	    \(\*[*]*
commentRR	    [*]*\*\)
comment         {commentLL}"("*([^*)]|([^*]")")|("*"[^)]?))*"*"*{commentRR}
```
之後會詳細提到comment的實作過程和應用方式。

---
 
***關於Yacc的-Rule:***
1. 確定開頭的位置是Prog_declaration
```C
%start prog_declaration 
```   
2. Type的定義:
```C
type <stringVal> ID _ID_list_ _varid_ _factor_ _term_ string_content
				 _Integer_num  _Integeradd '(' _simpexp_ ')' '-' 
```
3. 透過union原本是想讀intVal和floatVal、stringVal
由於此次作業(Yacc)是匹配Santax，因此變數部分都是用string去處理
```C
    %union {char  stringVal[15];}
    strcpy(yylval.stringVal,yytext);
```
搭配Lex端的yylval然後用yylval.stringVal的方式去抓
4. 針對回傳的Token去接收
```C
token  _absolute _and _BEGIN_ _break _case _const _continue DO ELSE _end FOR _function IF MOD _nil _not _object OF _or _program THEN TO _var _while _array _integer _double WRITE WRITELN STRING _float READ ARRAY       
		
	    ID
		string_content
		_Integer_num
		_Integeradd
		_real_num
```
---
***關於Yacc的Architecture:***
```C
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
```
在這個架構中，除了基本的Pascal所需要的保留字和結構順序，
我自己加上initailize去針對Symbol Table等其他空間作處理。
另外，提到像是"Semicolon""DOT"有特殊處理
1. Symbol以Dot為例:
    ```C
    DOT 
	: '.'
	| { error_flag=1; printf("\n \033[40;31;5m Syntax error, \".\" expected but \"end of file\" found \033[0m");}
	;
    ```
    因為要繼續跑完全部的程式，因此檢查的過程，必須要用這種方式去處理，也是比較容易理解的方式，在Yacc上的結構也比較不會亂掉。
    結構中DOT會判斷有沒有'.'，若是該出DOT的結構，但是該Token不是'.'，則會顯示Error。
2. Var dec_list
    ```C
    dec_list
	: dec 
	| dec_list Semicolon dec 
	;
    dec
	: _ID_list_ ':' _data_type_ 
	{ 	
		for(i=type_num;i<var_num;i++)
			{			
			strcpy(type_table[i],yytext);			
			}
		type_num=var_num;
    ```
   在這之中會將:
   var_num計算總共的變數的個數
   type_num計算總共的變數型態的個數
   當每次宣告，都會記錄當下的var:i,j,k...N個，再將data_type(後面會提到細節)，記錄到type_table
   ```C
   | _ID_list_ s_Defined _data_type_ { printf("\n \033[40;31;5m Syntax error, \":\" expected but \":=\" found \033[0m"); }
	| _ID_list_ '=' _data_type_ { printf("\n \033[40;31;5m Syntax error, \":\" expected but \":=\" found \033[0m"); }
   ```
   同時，也先定義出錯誤的error可能會發生的問題。(整篇以這個方法處理。)
4. _ID_list_ 這邊是建立Symbol Table的過程，依序將讀到的Token放入到string_table，同時計算總共的個數。
   ```C
   _ID_list_
	: ID{						            strcpy(string_table[var_num++],$1);	
		}
	| _ID_list_ s_Comma ID{			
			strcpy(string_table[var_num++],$3);
		}
	;
   ```
5. 變數的型態
```C
    _data_type_
	: _stand_type_ | _array_type_
	;
    _stand_type_
	: _integer | _double | _float | STRING
	;
    _array_type_
	:	ARRAY '[' _Integer_num s_double_Period  _Integer_num  ']'  OF  _stand_type_
	;
   ``` 
6. 這裡的statement，透過"Semicolon"，去檢查';'
    ```C
    _stmt_list_
	: _stmt_ | _stmt_list_	Semicolon _stmt_
	;
    ```
    這裡的statement，有以下用法:
    ```C
    _stmt_
	: _assign_ | _read_ | _write_ | _for_ | _if_stmt_ 
	;
    ```
    其中的assgin:
    ```C
    _assign_
	: _varid_ {
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
			
		 }  s_Defined _simpexp_ {
         if (strcmp(type_table[i],"integer") == 0 )       
			if ( int_flag )
			;
			else
			printf("\n \033[40;31;5m Error: Incompatible types \"%s\" should be \"%s\" \033[0m",$1,type_table[i_temp]);
			;
			if ( id_com_flag == 1) 
			;
			else
			{			
			printf("\n \033[40;31;5m Error: Identifier not found \"%s\"\033[0m",$1);
			} 
			int_flag =0;
		 } 
    ```
    Assing要去檢查符號的錯誤，只有寫死的辦法，去檢查將"s_Defined"用其他符號取代，但是量很多，故不一一列出，有'='汗':'，做法都一樣。
7. If Then Else
Syntax for the if-then-else statement is −
```C
if condition then S1 else S2;
```
我在Yacc實作的方式:
   ```C
   _if_stmt_
	: IF '(' _exp_ ')' THEN _body_
	| '(' _exp_ ')' THEN _body_ { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\nError: Syntax error, expected \"If\" \033[0m"); 
	} 
	| IF  _exp_ ')' THEN _body_  { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\nError: Syntax error, expected \"(\" \033[0m"); 
	}
	| IF  '(' _exp_ THEN _body_  { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\nError: Syntax error, expected \")\" \033[0m"); 
	}
	| IF  '(' ')' THEN _body_  { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\nError: Syntax error, expected \")\" but \"Then\" found\033[0m"); 
	}
	| THEN _body_ { error_flag=1;
	printf("\033[40;31;5m\n Error: Syntax error, expected \"If and expression\" \033[0m"); 
	}
	| IF '(' _exp_ ')' { error_flag=1;
	printf("\033[40;31;5m\n Syntax error, \"Then\" expected but \"identifier %s\" found\033[0m",yytext); 
	}
	| IF '(' _exp_ ')' WRITE  '(' _write_list_ ')' { error_flag=1;
	printf("\033[40;31;5m\n Syntax error, \"Then\" expected but \"identifier WRITE\" found\033[0m"); 
	}	
	|  IF '(' _exp_  WRITE  '(' _write_list_ ')' { error_flag=1;
	printf("\033[40;31;5m\n Syntax error, \")\" and \"Then\" expected but \"identifier WRITE\" found\033[0m"); 
	}	
	| IF  _exp_ ')' _body_  { error_flag=1;
	//printf("\033[40;31;5mError :\033[0m\n"); 
	printf("\033[40;31;5m\nError: Syntax error, expected \"(\" and \"Then\" \033[0m"); 
	}
	|IF '(' _exp_ ')' THEN _body_ ELSE _body_
	;
   ```
   這邊比較複雜，首先:
   完整的結構定義 :  IF '(' _exp_ ')' THEN _body_ Else _body_
   (Else的部份是加分先不談)
   要去檢查這樣的Santax的方式:IF '(' _exp_ ')' THEN _body_，在這6個所需的元素中，C6取1，分別去找可能缺失的元素。(寫死
8. String 的內容分析
   ```C
   _simpexp_
	: _term_                
	| _simpexp_ '+' _term_
	| _simpexp_ '-' _term_ 
	| string_content
	;
   ```
   在Lex中
   ```C
   string_content  \'([^\n]*)+\'
   ```
   先將抓到的String_content放入到String_content這個Token中
   然後，在Santax中，將其位階提高，因為String不會有運算過程，我直接放在simple expresstion的結構中。
   要注意的是:
   ```C
   %union {
	char  stringVal[15];}
   ```
   和
   ```C
   %type <stringVal> ID _ID_list_ _varid_ _factor_ _term_ string_content
				 _Integer_num  _Integeradd '(' _simpexp_ ')' '-' 
   ```
   這邊將所有的元素定義成String的型態去整理，方便往上遞迴，算是一個小細節。
9. 整數相加的處理
   ```C
   _term_
	: _factor_                 
	| _factor_ '*' _factor_
	| _factor_ '/' _factor_
	| _factor_ '%' _factor_
	| _factor_ '+' _factor_ {
    char str_temp1[15];
	char str_temp2[15];
	for(i=0;i<var_num;i++)
	{
	if ( strcmp ($1,string_table[i]) ==0 )//the same
    strcpy(str_temp1,type_table[i]);}
	if ( strcmp ($3,string_table[i]) ==0 )//the same
    strcpy(str_temp2,type_table[i]);}
	if ( strcmp (str_temp1,str_temp2) )
	   {printf("\033[40;31;5m\n Error: Illegal expression\n Error: Incompatible types: got \"%s\" expected \"%s\"\033[0m",str_temp2,str_temp1);}
		};
   _factor_
	: _varid_  {strcpy($$,$1);}                    
	| _Integer_num   {
	//printf("^^^");
	nt_flag = 1;
	}                               
	| _Integeradd 
	| '(' _simpexp_ ')';
    
   ```
   
   利用2個暫存去將Symbol Table中作紀錄，這裡是因為要判斷不同型態進行相加的判斷，'+'和其他Symbol做法一樣﹐故不一一列出。
   注意:
   1.判斷String是否一樣，要用strcmp()去檢查，另外相同的回傳值是"0"。
   2.要複製String，要用strcpy()去實作。
   
   在_factor_的實作過程中，_Integer_num這個是我在Lex抓取的整數Token，因為INTEGER是保留字，因此特別用另外一個字來匹配，因為還要考慮在Assign的過程，要去檢查型態上的正確，我設立一個標籤去檢查是不是整數型態，這次作業只有整數integer和字串string2種。
   
10. VAR的ID
    只要是ID都會透過$$的方式，把收到的Token往上傳給結構，因為在上面需要作型態的檢查，也就是建立Symbol Table。
```C
_varid_
	: ID {
		  strcpy($$,$1);
		 } 
	| ID  '[' _simpexp_ ']'
	;
```
11. Write
```C
_write_
	: WRITE 
	| WRITE '(' _write_list_ ')' 
	| WRITELN 
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
```

這個部分比較自己發揮創意，write中可以包含很多如上所示:整數、整數相加、字串、給值...等
    
---

***關於Yacc的部分問題:***

1. 每個symbol是否合法?
    首先，這個Token，可能會遇到以下幾個問題:
    1. 是否該回傳?
        我的作法是先在Lex，先印出我的Token，然後等到Yacc 的 Santax結構匹配到的時候，在去檢查結構上的合法定義。在此同時，也要去檢查，是否有出現缺少Token的狀況出現。
        ![](https://i.imgur.com/qBlNGU3.png)
        上圖1.1為例:是切割Token的表示法expression
        ![](https://i.imgur.com/2xL5hln.png)
        上圖1.2為例:是Token對應到的Rules
    2. 針對圖1.2來說，有幾個要注意的地方:
        1. 兩個以上的符號，不作為一次性的匹配，因為會先，抓單一個Token到Yacc，因此我另外設名稱去做回傳。
        2. 這邊的回傳，都只是為了匹配Santax，無作其他用途。
2. space 是否要回傳?
    相較於我的結構來說:
    ![](https://i.imgur.com/5EX6FLV.png)
    我只需要在Monitor上顯示一個空白即可，並不需要拖到Yacc去處理，早點處理每個Token是好習慣。
3. eol 的處理方式:
    針對這個部分:
    ![](https://i.imgur.com/neargOk.png)
    1. Error : 當在Yacc端，我發現到有任何的Santax error時，透過extern的方式，兩邊溝通彼此的狀況，一有問題的結構，就會啟動這個flag。
    ![](https://i.imgur.com/VJo0xlD.png)
    2. comment :這個是針對comment所遇到的情況。
        只要不是comment的內容，代表都是要印在monitor上的內容，用else去印出輸入的東西(不需要做修改這邊只是確認輸入的內容。)
        當每一行結束讀到\n時，都會執行這個rule，必須要將comment的flag歸零，代表comment已經結束(也只能透過comment去啟動)，同時i_table作為symbol table的counter var。後續會詳細提到。
4. ID的處理方式:
   ![](https://i.imgur.com/qlouHq0.png)
   這個情況比較難以處理。
   在做到中後期時的後，會有變數形態要去檢查和判斷的需求，因此這邊讀的時候，可以先做判斷，在去處理。
   原本使用的方式是:sscanf()這個函式去處理，並且地址回傳給stringVal(這在Yacc中實作)，做後續判斷。
   注意
   1. 這裡的yytext是string，因此必須要使用strcpy()去將match到的token加以分類。
   2. 這邊回傳的ID，必須要放入到Symbol Table(我稱作 check_table)用來存放所有變數的內容(content)，在之後是判斷型態和給值時候，重要的參考依據。
1. string 的判斷:
   ![](https://i.imgur.com/auu9jW0.png)
   因為在之後的處理過程，會遇到一些型態上的分類。
   我將strnig的內容獨立出來處理:
   並且是放到另外一個Symbol Table(我稱作 check_table)用來存放所有變數的內容(content)。
   之後會解釋如何去和
2. comment 的判斷 :
   ![](https://i.imgur.com/2cC9Rqw.png)
   首先，因為要計算comment本身的行數，使用for迴圈去計算yytext中有多少個\n存在，並且啟動comment_flag，使的上述提到的eol，可以去判斷是否要印出來。
   我選擇直接將comment省略，因為不回影響改變Santax的結構，只是給程式員看的內容。

---

## 錯誤類型Error table
> #### 參考網站 : `https://docs.microsoft.com/zh-tw/cpp/error-messages/compiler-errors-1/compiler-errors-c2001-through-c2099?view=vs-2019`

1. Illegal expression
   Error 1-1 : `Identifier not found `
   Error 1-2 : ``Incompatible types: got "SmallInt" expected "ShortString"``
3. Syntax Error   
   Error 2-1 : `"S1" expected but "S2" found`
   Error 2-2 : ``"S1" expected``
   Error 2-2 : ``". "  expected but "end of file" found ``
5. IF THEN ELSE 
   1. Error 3-1缺少If
      `Syntax error, expected "If" `
   3. Error 3-2缺少Then  
      `Syntax error, "THEN" expected but "identifier" found`
   4. Error 3-3缺少Else
      並不是錯誤。
   6. Error 3-4缺少"()"
      `Syntax error, expected "("`
      `Syntax error, expected ")"`
   7. Error 3-5缺少"Expression"
      `Syntax error, expected "expression"`
5. Warning
   給值過程:var = 5;
   `Warning : Variable "var" does not seem to be initialized`
---

## 遇到的問題

問題1.Symbol要如何去檢查是否存在?
:accept: 
問題2.行數字數上的計算
:accept:
問題3.Then之前缺少If的情況
:accept:
在上述過程有提到詳細步驟
問題4.不同Type之間的運算錯誤訊息
:accept:
在上述過程有提到詳細步驟
問題5.連續Symbol的出現錯誤判斷
處理方式:
:accept:
s_equal s_greaterthen s_lessthen 等
問題6.最後一行的\n\r情況(在gedit底下編輯)
檢查:
```cat -A file```
移除最後一個字元:
```truncate -s -1 file```
問題7.comment之間行數的問題
:accept:
在上述過程有提到詳細步驟
問題8.Write的結構匹配問題
:accept:
在上述過程有提到詳細步驟
問題9.yytext和$1的轉換問題
:accept:
在上述過程有提到詳細步驟
問題10.發生error(yyerror)時，yacc如何知道哪個是錯誤Token
:accept:
在上述過程有提到詳細步驟，因此在yacc的結構上要去作分析
問題11.錯別字判斷
測試資料並無此情況，並且會直接噴error
問題12.無法用lex去作錯誤判斷
:accept:
在上述過程有提到詳細步驟，因此在yacc的結構上要去作分析

---

## 線上測試結果:
### GDB 
### https://www.onlinegdb.com/
## 測試檔案結果:
1.	correct.Pas
```C
program test;
var 
(* one line comment *)
  i, j: integer;
  ans: array[0 .. 81] of integer;
begin
    i := -1+3;
    j := +7*8;
    ans[0] := 7;
    (* 
    multiple lines comments
    do not show comments
    *)
    for i:=1 to 9 do 
    begin
        for j:=1 to i do
            ans[i*9+j] := i*j;
    end;
    
    for i:=1 to 9 do 
    begin
        for j:=1 to i do
            if ( ans[i*9+j] mod 2 = 0) then
                write(i, '*', j, '=', ans[i*9+j], ' ');
        writeln;
    end;
end.
```
   輸出結果:
```

```
2.	error1.Pas
Q: Assign的判斷:=、If then 的結構、宣告的Var
```C
program test;
var
  i: integer;
begin
  i = 3;
  j = 4;
  if (i > j) 
    Write('ok');
end.
```   
   GDB輸出結果:
```C
main.pas(5,8) Error: Illegal expression
main.pas(5,3) Warning: Variable "i" does not seem to be initialized
main.pas(6,5) Error: Identifier not found "j"
main.pas(6,8) Error: Illegal expression
main.pas(7,12) Error: Identifier not found "j"
main.pas(8,5) Fatal: Syntax error, "THEN" expected but "identifier WRITE" found
```
   輸出結果:
```C
Line  1: program test;
Line  2: var
Line  3:   i: integer;
Line  4: begin
Line  5:   i = 3;
  Warning: Variable "i" does not seem to be initialized 
  Syntax error 
  Error 2-1 : "=" expected but ":=" found 
Line  6:   j = 4;
  Warning: Variable "j" does not seem to be initialized 
  Syntax error 
  Error 2-1 : "=" expected but ":=" found 
  Illegal expression 
  Error 1-1 : Identifier not found "j"
Line  7:   if (i > j) 
Line  8:     Write('ok')
 Error 3-2 : Syntax error, "Then" expected but "identifier WRITE" found;
Line  9: end.
```
3.	error2.Pas
   Q: If then 的結構
```C
program test;
var
  i, j : integer;
begin
  i := 5*2;
  j := 9;
  if (i > j) 
    Write('ok');
end.
```
   GDB輸出結果:
```C
main.pas(8,5) Fatal: Syntax error, "THEN" expected but "identifier WRITE" found
```
   輸出結果:
```C
Line  1: program test;
Line  2: var
Line  3:   i, j : integer;
Line  4: begin
Line  5:   i := 5 * 2;
Line  6:   j := 9;
Line  7:   if (i > j) 
Line  8:     Write('ok')
 Error 3-2 : Syntax error, "Then" expected but "identifier WRITE" found;
Line  9: end.

```
4.	error3.Pas
   Q:缺少結構end後面.
```C
program test;
var
  i, j := integer;
begin
  i := 5;
end
``` 
   GDB輸出結果:
```C
main.pas(3,8) Fatal: Syntax error, ":" expected but ":=" found
```
   輸出結果:
```C
Line  1: program test;
Line  2: var
Line  3:   i, j := integer
  Error 2-1 : Syntax error, ":" expected but ":=" found ;
Line  4: begin
Line  5:   i := 5;
Line  6: end
Line  7: 
Line  8: 
  Error 2-3 : Syntax error, "." expected but "end of file" found 
```
5. error4.Pas 
   Q : 兩個不同型態的Var作運算
```C
program test;
var
  i, j : integer;
  c : string;
begin
  i := 5;
  c := 'aa';
  i = i+c;
end.
```
   GDB輸出結果:
```C
main.pas(8,10) Error: Illegal expression
main.pas(8,7) Error: Incompatible types: got "SmallInt" expected "ShortString"
main.pas(9,4) Fatal: There were 2 errors compiling module, stopping
```
   輸出結果:
```C
Line  1: program test;
Line  2: var
Line  3:   i, j : integer;
Line  4:   c : string;
Line  5: begin
Line  6:   i := 5;
Line  7:   c := 'aa';
  Illegal expression 
  Error 1-2 : Incompatible types "c" should be "string" 
Line  8:   i = i+c;
 Error: Illegal expression
 Error 1-2 : Incompatible types: got "string" expected "integer"
  Warning: Variable "i" does not seem to be initialized 
  Syntax error 
  Error 2-1 : "=" expected but ":=" found 
Line  9: end.
```
6. Pas 
   Q : If then else
   From : https://www.tutorialspoint.com/pascal/pascal_if_then_else_statement.htm
```C
program ifelseChecking;
var
   { local variable definition }
   a : integer;

begin
   a := 100;
   (* check the boolean condition *)
   if( a < 20 ) then
      (* if condition is true then print the following *)
      writeln('a is less than 20' )
   
   else
      (* if condition is false then print the following *) 
      writeln('a is not less than 20' );
      writeln('value of a is : ', a);
end.
```
   GDB輸出結果:
```C
NO Error
a is not less than 20     
value of a is : 100  
```
   輸出結果:
```C
Line  1: program ifelseChecking;
Line  2: var
Line  3:       a : integer;
Line  4: 
Line  5: begin
Line  6:    a := 100;
Line  7:       if( a < 20 ) then
Line  8:             writeln('a is less than 20' )
Line  9:    
Line 10:    else
Line 11:              writeln('a is not less than 20' );
Line 12:       writeln('value of a is : ', a);
Line 13: end.

```
7. Pas 
   Q : Var給值和型態衝突
```C
program test;
var
  i, j : integer;
begin
  i := 5 * 2;
  j := 'c';
  if (i > j) 
    Write('ok');
end.
```
   GDB輸出結果:
```C
main.pas(6,8) Error: Incompatible types: got "Char" expected "SmallInt"
main.pas(8,5) Fatal: Syntax error, "THEN" expected but "identifier WRITE" found
```
   輸出結果:
```C
Line  1: program test;
Line  2: var
Line  3:   i, j : integer;
Line  4: begin
Line  5:   i := 5 * 2;
Line  6:   j := 'c';
  Illegal expression 
  Error 1-2 : Incompatible types "j" should be "integer" 
Line  7:   if (i > j) 
Line  8:     Write('ok')
 Error 3-2 : Syntax error, "Then" expected but "identifier WRITE" found;
Line  9: end.

```  
8. Pas 
   Q : 缺少結構';'
```C
program test;
var 
(* one line comment *)
  i, j: integer;
  ans: array[0 .. 81] of integer;
begin
    i := -1+3;
    j := +7*8
    ans[0] := 7;
    (* 
    multiple lines comments
    do not show comments
    *)
    for i:=1 to 9 do 
    begin
        for j:=1 to i do
            ans[i*9+j] := i*j;
    end;
    
    for i:=1 to 9 do 
    begin
        for j:=1 to i do
            if ( ans[i*9+j] mod 2 = 0) then
                write(i, '*', j, '=', ans[i*9+j], ' ');
        writeln;
    end;
end.
```
   GDB輸出結果:
```C
main.pas(9,5) Fatal: Syntax error, ";" expected but "identifier ANS" found
```
   輸出結果:
```C
Line  1: program test;
Line  2: var 
  i, j: integer;
Line  4:   ans: array[0 .. 81] of integer;
Line  5: begin
Line  6:     i := -1+3;
Line  7:     j := +7*8
Line  8:     ans
  Error 2-2 : Syntax error, ";" [0] := 7;
    for i:=1 to 9 do 
Line 13:     begin
Line 14:         for j:=1 to i do
Line 15:             ans[i*9+j] := i*j;
Line 16:     end;
Line 17:     
Line 18:     for i:=1 to 9 do 
Line 19:     begin
Line 20:         for j:=1 to i do
Line 21:             if ( ans[i*9+j] mod 2 = 0) then
Line 22:                 write(i, '*', j, '=', ans[i*9+j], ' ');
Line 23:         writeln;
Line 24:     end;
Line 25: end.

```
9. Pas 
   Q :!!!注意，Pascal沒有"="的出現 
```C
program test;
var
  i, j : integer;
  c : string;
begin
  i := 5;
  j := 6;
  c := 'aa';
  i = i+j;
end.
```
   GDB輸出結果:
```C
main.pas(9,10) Error: Illegal expression
main.pas(10,4) Fatal: There were 1 errors compiling module, stopping
Fatal: Compilation aborted
```  
   輸出結果:
```C
Line  1: program test;
Line  2: var
Line  3:   i, j : integer;
Line  4:   c : string;
Line  5: begin
Line  6:   i := 5;
Line  7:   c := 'aa';
  Illegal expression 
  Error 1-2 : Incompatible types "c" should be "string" 
Line  8:   i = i+c;
 Error: Illegal expression
 Error 1-2 : Incompatible types: got "string" expected "integer"
  Warning: Variable "i" does not seem to be initialized 
  Syntax error 
  Error 2-1 : "=" expected but ":=" found 
Line  9: end.
```  
10. Pas 
   Q : 
```C
program ifelseChecking;
var
   (* check the boolean condition *)
   a : integer;

begin
   a := 100;
   (* check the boolean condition *)
   if( a < 20 ) then
      (* if condition is true then print the following *)
      writeln('a is less than 20' )
   
   else
      (* if condition is false then print the following *) 
      writeln('a is not less than 20' );
      read(a);
      a := 5;
      writeln(a);
end.
```
   GDB輸出結果:
```C
NO Error
a is not less than 20       
8                                      
5 
```
   輸出結果:
```C
Line  1: program ifelseChecking;
Line  2: var
Line  3:       a : integer;
Line  4: 
Line  5: begin
Line  6:    a := 100;
Line  7:       if( a < 20 ) then
Line  8:             writeln('a is less than 20' )
Line  9:    
Line 10:    else
Line 11:              writeln('a is not less than 20' );
Line 12:       read(a);
Line 13:       a := 5;
Line 14:       writeln(a);
Line 15: end.
```
11. Pas 
   Q : 
```

```
   GDB輸出結果:
```

```
   輸出結果:
```

```