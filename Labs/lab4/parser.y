%{
	#include "abstract_syntax_tree.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror(char* s); 											// error handling function
	int yylex(); 													// declare the function performing lexical analysis
	extern int yylineno; 											// track the line number
%}

%union																// union to allow nodes to store return different datatypes
{
	char* text;
	expression_node* exp_node;
}



%token <text> T_ID T_NUM

%type <exp_node> E T F

/* specify start symbol */
%start START


%%
START : ASSGN	{YYACCEPT;}

/* Grammar for assignment */
ASSGN : T_ID '=' E	{printf("Valid Syntax\n"); display_exp_tree($3);}
	;

/* Expression Grammar */
E : E '+' T 	{$$ = init_exp_node("+",$1,$3);}
	| E '-' T 	{$$ = init_exp_node("-",$1,$3);}
	| T 	{ $$ = $1; }
	;
	
	
T : T '*' F 	{$$ = init_exp_node("*",$1,$3);}
	| T '/' F 	{$$ = init_exp_node("/",$1,$3);}
	| F {$$ = $1;}
	;

F : '(' E ')' { $$ = $2; }
	| T_ID 	{$$ = init_exp_node(strdup($1),NULL,NULL);}
	| T_NUM 	{$$ = init_exp_node(strdup($1),NULL,NULL);}
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
	yyparse();
	return 0;
}
