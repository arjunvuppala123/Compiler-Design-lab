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
%token  INT FLOAT CHAR ID DOUBLE WHILE TRUE FALSE FOR DO IF ELSE INCLUDE MAIN NUM HEADER DEC EQCOMP GREATEREQ LESSEREQ NOTEQ INC OROR ANDAND STRLITERAL

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
      | Type array_expr
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
      | Inc
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
    | E INC;
    | E DEC;
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
             | For
             | Do_While
	     ;


Block : '{' Stmt '}'
	;

WhileL: WHILE '(' Cond ')' While_2
	;

Cond : Expr 
	| Assgn 
        | Logical_Operations 
	;

While_2 : '{' Stmt '}'
	  |
	  ;

true : TRUE
     ;

false : FALSE
      ;

Logical_Operations : Cond ANDAND Cond 
                   | Cond OROR Cond
                   | Cond EQCOMP true
                   | Cond EQCOMP false
                   ;


Do_While: DO While_2 WHILE  '(' Cond ')' ';'
        ;

Inc : ID INC 
    | ID DEC
    | Assgn 
    ;

Assgn_2 : Declr '=' Expr
        ;
	  
For : FOR '(' Assgn_2 ';' Expr ';' Inc ')' While_2
    ;

ex : Type | ID
   ;

array_expr : ex array
           ;

array : '[' F ']'
      | array array   
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

