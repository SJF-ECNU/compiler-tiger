%{
#include <string.h>
#include "util.h"
#include "tokens.h"
#include "errormsg.h"

int charPos=1;

int yywrap(void)
{
 charPos=1;
 return 1;
}


void adjust(void)
{
 EM_tokPos=charPos;
 charPos+=yyleng;
}

%}

%%

" "	 {adjust(); continue;}
\t	 {adjust(); continue;}
\n	 {adjust(); EM_newline(); continue;}

while {adjust(); return WHILE;}
for   {adjust(); return FOR;}
to    {adjust(); return TO;}
break {adjust(); return BREAK;}
let   {adjust(); return LET;}
in    {adjust(); return IN;}
end   {adjust(); return END;}
function {adjust(); return FUNCTION;}
var    {adjust(); return VAR;}
type   {adjust(); return TYPE;}
array  {adjust(); return ARRAY;}
if     {adjust(); return IF;}
then   {adjust(); return THEN;}
else   {adjust(); return ELSE;}
do     {adjust(); return DO;}
of     {adjust(); return OF;}
nil    {adjust(); return NIL;}

[a-zA-Z_][a-zA-Z0-9_]* { adjust(); yylval.sval=String(yytext); return ID; }
[0-9]+	 {adjust(); yylval.ival=atoi(yytext); return INT;}

","	 {adjust(); return COMMA;}
":"	 {adjust(); return COLON;}
";"	 {adjust(); return SEMICOLON;}
"("	 {adjust(); return LPAREN;}
")"	 {adjust(); return RPAREN;}
"["	 {adjust(); return LBRACK;}
"]"	 {adjust(); return RBRACK;}
"."	 {adjust(); return DOT;}
"+"	 {adjust(); return PLUS;}
"-"	 {adjust(); return MINUS;}
"*"	 {adjust(); return TIMES;}
"/"	 {adjust(); return DIVIDE;}
"="	 {adjust(); return EQ;}
"<"	 {adjust(); return LT;}
"<=" {adjust(); return LE;}
">"	 {adjust(); return GT;}
">=" {adjust(); return GE;}
"<>" {adjust(); return NEQ;}
"&"	 {adjust(); return AND;}
"|"	 {adjust(); return OR;}
":=" {adjust(); return ASSIGN;}



.	 {adjust(); EM_error(EM_tokPos,"illegal token");}


