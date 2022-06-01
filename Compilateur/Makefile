GRM=yacc.y
LEX=lex.l
BIN=compiler

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o tab_symbole.o tab_instructions.o tab_jmp.o interpreteur.o

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

y.tab.c y.tab.h: $(GRM)
	yacc -d $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@
	
lex.yy.o: y.tab.h

clean:
	rm $(OBJ) y.tab.c y.tab.h lex.yy.c

