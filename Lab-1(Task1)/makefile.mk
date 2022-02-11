a.out:y.tab.c lex.yy.c
	cc y.tab.c lex.yy.c -ll
y.tab.c:yacc.y
	yacc -d yacc.y
lex.yy.c:lex.l
	lex lex.l
