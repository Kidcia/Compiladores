%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%option noyywrap

operador_l ("|")|("°")|("¬")
com [^*/]

num [0-9]+
id [a-zA-Z_][a-zA-Z_0-9]*
cadena [a-zA-Z]+
caracter [a-zA-Z]
sin ("sin")
estructura ("estructura")
inicio ("inicio")
fin ("fin")

programa {declaraciones}{funciones}
instruc1 {tipo}{lista_var}";"
instruc2 {tipo_registro}{lista_var}";"
declaraciones {instruc1}+|{instruc2}+
tipo_registro {estructura}{inicio}{declaraciones}{fin}
tipo ({base}{tipo_arreglo})|({base}" "{tipo_arreglo})
base ("real")|("ent")|("dreal")|("car")|("real")|{sin}
arreglo_t  ("("{num}")")
tipo_arreglo {arreglo_t}+
lista_var ({var}|{id})
var ","{id}
funciones ("def")" "{tipo}" "{id}("("{argumentos}")")" "{inicio}" "{declaraciones}" "{sentencias}" "{fin}
argumentos ({lista_arg}|{base})|{sin}
lista_arg ({lista}|{arg})
lista ","{arg}
arg ({tipo_arg}" "{id})|({tipo_arg}{id})
tipo_arg {base}{param_arr}+
param_arr ("("")")

/*14*/
/*15*/
caso  ("caso")" "{num}(":"){sentencia}
casos {caso}+
predeterminado (("pred:")" "{sentencia}|("pred:"){sentencia})*
/*18*/
/*19*/
oprel ("<")|(">")|(">=")|("<=")|("<>")|("=")
exp2 {id}|{variable}|{num}|{cadena}|{caracter}|{id}("("{parametros}")")|expresion
exp1 {exp2}|{exp2}{oparit}{exp2}|{exp2}"%"{exp2}
expresion ("("{exp1}")")|exp1
oparit [-+*/]
variable {dato_est_sim}|{arreglo}
dato_est_sim ({est_sim}|{id})
est_sim "."{id}
arreglo_1 ({id}"("{expresion}")")
arreglo {arreglo_1}|({arreglo_1}("("{expresion}")"))
parametros {lista_param}*
lista_param ({lista_p}|{expresion})
lista_p ","{expresion}

%%
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

.   { printf("Error Lexico: %s\n", yytext);}
"/*"{com}*"*/" {/*ignorar comentarios*/}
[ \t\n\r]+ {/*ignorar espacios en blanco*/}
%%
