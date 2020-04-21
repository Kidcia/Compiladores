%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void error(char *s);

typedef struct _token{
	char valor[32];
	int linea;
} token;

enum clase {ID = 1, ENTERO, DECIMAL, ARITMETICO, RELACIONAL, LOGICO, PUNTUACION, RESERVADA};

token TOKEN;

%}

%s COMENTARIO
%x COMENTARIO2

%option yylineno
%option noyywrap

letra [a-zA-Z]
digito [0-9]
opa [-+*/%]
opr ("<")|(">")|(">=")|("<=")|(":")|("=!")
opl ("&&")|("||")|("!")
sp ("{")|("(")|(",")|(";")|(")")|("}")
simb1 [#]
id {simb1}({letra}|{digito})*
simb2 [@]
palabras [Ii][Ff]|[Ee][Ll][Ss][Es]|[Ww][Hh][Ee][Rr][Ee]
pr {simb2}{palabras}
entero {digito}*
real {digito}*\.{digito}+|{digito}+"."{digito}*
exp [eE][+-]?{digito}+
decimal {digito}+\.{digito}+|\.{digito}+


%%
	/* Expresion Regular Accion Lexica */

<INITIAL>{id}	{
	strcpy(TOKEN.valor, yytext);
	TOKEN.linea = yylineno;
	return ID;
}
<INITIAL>{entero} {
	strcpy(TOKEN.valor, yytext);
	TOKEN.linea = yylineno;
	return ENTERO;
}
<INITIAL>{decimal} {
	strcpy(TOKEN.valor, yytext);
	TOKEN.linea = yylineno;
	return DECIMAL;
}
<INITIAL>{opa} {
	strcpy(TOKEN.valor, yytext);
	TOKEN.linea = yylineno;
	return ARITMETICO;
}
<INITIAL>{opr} {
	strcpy(TOKEN.valor, yytext);
	TOKEN.linea = yylineno;
	return RELACIONAL;
}
<INITIAL>{opl} {
	strcpy(TOKEN.valor, yytext);
	TOKEN.linea = yylineno;
	return LOGICO;
}
<INITIAL>{sp} {
	strcpy(TOKEN.valor, yytext);
	TOKEN.linea = yylineno;
	return PUNTUACION;
}
<INITIAL>{pr} {
	strcpy(TOKEN.valor, yytext);
	TOKEN.linea = yylineno;
	return RESERVADA;
}
<INITIAL>[ \n\t]+ {}

<INITIAL>. {error(yytext);}

<COMENTARIO>[^*/] {}
<COMENTARIO>[*/] {}
<COMENTARIO>"*/" {BEGIN(INITIAL);}

%%

void error(char *s){
	printf("Error Léxico: %s, En la linea: %d\n", s, yylineno);
}

int main(int argc, char **argv){
	FILE *f;
	if(argc < 2){
		printf("Falta el archivo\n");
	}
	f = fopen(argv[1], "r");
	if(!f){
		printf("No se pudo abrir el archivo\n");
		exit(-1);
	}
	yyin = f;

	int  tok = yylex();

	while(tok != 0){
		printf("< %d, %s >\n", tok, TOKEN.valor);
		tok = yylex();
	}

	fclose(yyin);
	return 0;
}