%option noyywrap
%{

#include<stdio.h>
#include "y.tab.h"

%}

letter [a-zA-Z]

digit [0-9]

undersco _

id {letter}({letter}|{digit}|{undersco})*

opsign [+-]?

opfrac (\.{digit}+)?

opexponent ([Ee][+-]?{digit}+)?

number {opsign}{digit}*{opfrac}{opexponent}

%x state
%%
"//".* ;
[\r] 	;
[' '|\t]        ;
\/\* {yymore(); BEGIN state;}

<state>[' '|\t] {yymore(); BEGIN state;}

<state>[\n] {yymore(); ++yylineno; BEGIN state;}

<state>[^\*] {yymore(); BEGIN state;}

<state>"*"[^/] {yymore(); BEGIN state;}

<state>"*"\/ BEGIN 0 ;

[\n] ++yylineno;

int   return INT;

float return FLOAT;

char return CHAR;

double return DOUBLE;

while return WHILE;

for return FOR;

do return DO;

if return IF;

else return ELSE;

#include return INCLUDE;

main return MAIN;

"+" return *yytext;

"-" return *yytext;

"*" return *yytext;

"=" return *yytext;

\\ return *yytext;

{number} return NUM;

{id} return ID;

\"{id}\" return STRLITERAL;

{id}\.h return HEADER;

"--" return DEC;

"==" return EQCOMP;

">=" return GREATEREQ;

"<=" return LESSEREQ;

"!=" return NOTEQ;

"++" return INC;

"||" return OROR;

"&&" return ANDAND;

.   return *yytext;

%%
