%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%option noyywrap


/*operador_a ("-")|("+")|("!")|("¡")*/
/*operador_r ("<<")|(">>")|(">=")|("<=")|("==")|("^")*/
operador_l ("|")|("°")|("¬")
/*simbolos [{}();,]*/
com [^*/]

num [0-9]+
id [a-zA-Z_][a-zA-Z_0-9]*
cadena [a-zA-Z]+
caracter [a-zA-Z]
base ("real")|("ent")|("dreal")|("car")|("real")|("sin")
oparit [-+*/]
oprel ("<")|(">")|(">=")|("<=")|("<>")|("=")
param_arr ("("")")
tipo_arg {base}{param_arr}+
arg ({tipo_arg}" "{id})|({tipo_arg}{id})
lista_arg ({lista}|{arg})
lista ","{arg}
argumentos ({lista_arg}|{base})
lista_var ({var}|{id})
var ","{id}
arreglo_t  ("("{num}")")
tipo_arreglo {arreglo_t}+
tipo ({base}{tipo_arreglo})|({base}" "{tipo_arreglo})

exp2 {id}|{variable}|{num}|{cadena}|{caracter}|{id}("("{parametros}")")|expresion
exp1 {exp2}|{exp2}{oparit}{exp2}|{exp2}"%"{exp2}
expresion ("("{exp1}")")|exp1
lista_param ({lista_p}|{expresion})
lista_p ","{expresion}
parametros {lista_param}*
arreglo_1 ({id}"("{expresion}")")
arreglo {arreglo_1}|({arreglo_1}("("{expresion}")"))
dato_est_sim ({est_sim}|{id})
est_sim "."{id}
variable {dato_est_sim}|{arreglo}




%%
@if {printf("Encontre una palabra reservada: %s \n", yytext);}
@else {printf("Encontre una palabra reservada: %s \n", yytext);}
@while {printf("Encontre una palabra reservada: %s \n", yytext);}


"/*"{com}*"*/" {/*ignorar comentarios*/}
[ \t\n\r]+ {/*ignorar espacios en blanco*/}
{oprel} {printf("Encontre un(os) operador(es) (relacionales): %s \n", yytext);}
{oparit} {printf("Encontre un(os) operador(es) (aritmeticos): %s \n", yytext);}
{base} {printf("Encontre una base: %s \n", yytext);}
{param_arr}* {printf("Encontre un param_arr: %s \n", yytext);}
{tipo_arg} {printf("Encontre un tipo_arg: %s \n", yytext);}
{arg} {printf("Encontre un arg: %s \n", yytext);}
{lista_arg}+ {printf("Encontre un lista_arg: %s \n", yytext);}
{argumentos}+ {printf("Encontre unos argumenos: %s \n", yytext);}
{lista_var}+ {printf("Encontre un lista_var: %s \n", yytext);}
{tipo_arreglo}* {printf("Encontre un tipo_arreglo: %s \n", yytext);}
{tipo} {printf("Encontre un tipo: %s \n", yytext);}
{arreglo}+ {printf("Encontre un arreglo: %s \n", yytext);}



.   { printf("Error Lexico: %s\n", yytext);}



%%
