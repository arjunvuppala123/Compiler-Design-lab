%{
	#include "sym_tab.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
	int type=-1;	//initial declaration of type for symbol table
	char* vval="~";	//initial declaration of value for symbol table
	int vtype=-1;	//initial declaration for type checking for symbol table
	int scope=0;	//initial declaration for scope
	void yyerror(char* s); // error handling function
	int yylex(); // declare the function performing lexical analysis
	extern int yylineno; // track the line number

%}
/* declare tokens */
%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_PRINTLN T_STRING  T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN T_ID T_NUM

/* specify start symbol */
%start START


%%
START : PROG { printf("Valid syntax\n");
	 YYACCEPT; }	/* If program fits the grammar, syntax is valid */
        ;						/* Anything within {} is C code, it is the action corresponding to the 							production rule */


	  
PROG :  MAIN PROG				/* main function  */
	|DECLR ';' PROG 			/* global declarations   */	
	| ASSGN ';' PROG 			/* global assigments     */
	| 					/* end of program */
	;

/* Grammar for variable declaration */
DECLR : TYPE LISTVAR 
	;	/* always terminate with a ; */


LISTVAR : LISTVAR ',' VAR 
	  | VAR
	  ;

VAR: T_ID '=' EXPR 	{
				/*
					to be done in lab 3
				*/
			}
     | T_ID 		{
				if(check_sym_tab($1))	//if variable is in table then variable is being re-declared
				{
					printf("Variable %s already declared\n",$1);
					yyerror($1);
				}
				else{
				insert_symbol($1,size(type),type,yylineno,scope);
				type=-1;	//revert to default for checking
				}
			}	 
	
TYPE : T_INT {type = INT;}		//INT=2
       | T_FLOAT {type = FLOAT;}	//FLOAT=3
       | T_DOUBLE {type = DOUBLE;}	//DOUBLE=4
       | T_CHAR {type = CHAR;}		//CHAR=1
       ;
    
/* Grammar for assignment */   
ASSGN : T_ID {type=retrieve_type($1);}'=' EXPR 	{
				/*
					to be done in lab 3
				*/
			}
	;

EXPR : EXPR REL_OP E  
       | E {vval=$1;}
       ;

/* Expression Grammar */	   
E : E '+' T 
    | E '-' T 
    | T
    ;
	
	
T : T '*' F 
    | T '/' F 
    | F 
    ;

F : '(' EXPR ')'
    | T_ID 
    | T_NUM
    | T_STRLITERAL
    ;

REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	


/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' {scope++;} STMT '}' {scope--;};


/* argument list can be empty, or have a list of variables */
EMPTY_LISTVAR : LISTVAR
		|	/* similar to lambda */
		;


/* statements can be standalone, or parts of blocks */
STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT
       |
       ;


STMT_NO_BLOCK : DECLR ';'
       | ASSGN ';'
       ;

BLOCK : '{' {scope++;} STMT '}' {scope--;};


/* Condition can be an expression or an assignment */
COND : EXPR  
       | ASSGN
       ;
      

%%


/* error handling function */
void yyerror(char* s)
{
	printf("Error :%s at %d \n",s,yylineno);
}


/* main function - calls the yyparse() function which will in turn drive yylex() as well */
int main(int argc, char* argv[])
{
	t=init_table();
	//printf("here \n");
	yyparse();
	display_sym_tab();
	return 0;

}
