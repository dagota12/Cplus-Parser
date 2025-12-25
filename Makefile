all: compiler

compiler: lex.yy.c y.tab.c
	gcc -o compiler y.tab.c lex.yy.c    # Try this first

# Alternative if above fails:
# gcc -o compiler y.tab.c lex.yy.c        # No flags

lex.yy.c: lexer.l
	flex lexer.l

y.tab.c y.tab.h: parser.y
	bison -d -y parser.y

clean:
	rm -f compiler lex.yy.c y.tab.c y.tab.h
