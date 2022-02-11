%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"

int yylex();
FILE *yyin;
extern int yylineno;
void yyerror(const char* s);
extern char* yytext;

%}
%token  INT FLOAT CHAR ID DOUBLE WHILE FOR DO IF ELSE INCLUDE MAIN NUM HEADER DEC EQCOMP GREATEREQ LESSEREQ NOTEQ INC OROR ANDAND STRLITERAL

%%

S 	: P 	{printf("Valid Syntax\n"); YYACCEPT;}
  	;
P	: INCLUDE '<'HEADER'>' P
	 | MainF P
	 | Declr ';' P
	 | Assgn ';' P
	 |
	 ; 

Declr : Type ListVar 
        ;
  

Type : INT 
     | FLOAT 
     | CHAR
     | DOUBLE
     ;
     

ListVar : ListVar ',' ID 
	 | ID  
	 ;
	 


Assgn : ID '=' Expr
      ;


Expr : Expr Relop E | E 
     ;


Relop : '<' 
	| '>'
	| LESSEREQ
	| GREATEREQ
	| EQCOMP
	| NOTEQ
	;
	


E : E '+' T
    | E '-' T
    | T
    ;
    
    

T : T '*' F
    | T'/'F
    | F
    ;
    

F : '('Expr')'
    | ID
    | NUM
    ;

MainF : Type MAIN '('Empty_ListVar')' '{'Stmt'}'
      ;

Empty_ListVar : ListVar 
		|
		;

Stmt : SingleStmt Stmt 
	| Block Stmt 
	|
	;

SingleStmt : Declr ';'
	     | Assgn ';'
	     | IF '('Cond ')' Stmt 
	     | IF '(' Cond ')' Stmt ELSE Stmt 
	     | WhileL
	     ;


Block : '{' Stmt '}'
	;

WhileL: WHILE '(' Cond ')' While_2
	;

Cond : Expr 
	| Assgn
	;

While_2 : '{' Stmt '}'
	  |
	  ;
	  
	   

%%
void yyerror(const char *s)
{
printf("Error: %s, Line number: %d, token: %s\n", s,yylineno,yytext);

}


int main()
{
if(!yyparse())
	printf("Successful\n");
else
	printf("Unsuccessful\n");
return 0;
}

