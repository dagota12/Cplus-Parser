%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE *yyin;   // Important: tell Bison/Flex about input stream
extern int yylex();
void yyerror(const char *s);
%}

%union {
    char *str;
    double num;
}

%token EQ NE LT GT LE GE   /* == != < > <= >= */

%token <str> ID
%token <num> NUMBER
%token KEYWORD IF ELSE WHILE

%type <num> expr   /* Important: type for non-terminal expr */

%left '+' '-'
%left '*' '/'
%left EQ NE LT GT LE GE

%%

program: stmt_list

stmt_list: stmt_list stmt
         | stmt
         | /* empty */
         ;

stmt: decl ';'
    | assign ';'
    | if_stmt
    | while_stmt
    ;

decl: KEYWORD ID                { printf("Declaration: %s\n", $2); }

assign: ID '=' expr             { printf("Assignment to %s\n", $1); }

if_stmt: IF '(' expr ')' '{' stmt_list '}'
       | IF '(' expr ')' '{' stmt_list '}' ELSE '{' stmt_list '}'
       ;

while_stmt: WHILE '(' expr ')' '{' stmt_list '}'
          ;

expr: expr EQ expr             { printf("==\n"); }
    | expr NE expr             { printf("!=\n"); }
    | expr LT expr             { printf("<\n"); }
    | expr GT expr             { printf(">\n"); }
    | expr LE expr             { printf("<=\n"); }
    | expr GE expr             { printf(">=\n"); }
    | expr '+' expr             { printf("+\n"); }
    | expr '-' expr             { printf("-\n"); }
    | expr '*' expr             { printf("*\n"); }
    | expr '/' expr             { printf("/\n"); }
    | '(' expr ')'              { $$ = $2; }   /* Fixed: use $2 here */
    | ID                        { printf("ID: %s\n", $1); }
    | NUMBER                    { printf("Number: %.2f\n", $1); }  /* Fixed: $1 not $2 */
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        // Read from file provided as argument
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Error: Cannot open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;  // Tell Flex to read from this file
    } else {
        // No file given → read from keyboard (like before)
        printf("Enter a simple C-like program (Ctrl+D to end input):\n");
    }

    if (yyparse() == 0) {
        printf("\nParsing successful: Valid syntax!\n");
    } else {
        printf("\nParsing failed: Invalid syntax.\n");
    }

    return 0;
}
