%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <math.h>


%}

%option yylineno

delim                           [ \t]
bl                              {delim}+

chiffre                         [0-9]
lettre                          [a-zA-Z]
Error_character                 .

Boolean                         True|False
Integer                         {chiffre}+
String                          \"([^"\n]|\"\")+\"
Error_string                    \"([^"\n]|\"\")+
Identifier                      ({lettre}|"_")({lettre}|{chiffre}|"_")*
Error_identifier                {chiffre}({lettre}|{chiffre}|"_")*

Parenthese_open                 (\()
Parenthese_close                (\))
Bracket_open                    (\[)
Bracket_close                   (\])
Brace_open                      (\{)
Brace_close                     (\})

Comment_block                   "/*"([^*]|\*+[^*/])*\*+"/"
Comment_line                    "//".*\n
Error_comment                   \/\*([^(\*\/)]|\n)*

%%

"class"                               printf(" KEYWORD_CLASS \n ");
"public"                              printf(" KEYWORD_PUBLIC \n ");
"static void main"                    printf(" KEYWORD_MAIN \n ");
"extends"                             printf(" KEYWORD_EXTENDS \n ");
"return"                              printf(" KEYWORD_return \n ");
"if"                                  printf(" KEYWORD_IF \n ");
"else"                                printf(" KEYWORD_ELSE \n ");
"while"                               printf(" KEYWORD_WHILE \n ");
"System.out.println"                  printf(" KEYWORD_PRINT \n ");
"length"                              printf(" KEYWORD_LENGTH \n ");
"this"                                printf(" KEYWORD_THIS \n ");
"new"                                 printf(" KEYWORD_NEW \n ");

"int"                                 printf(" TYPE_INT \n ");
"boolean"                             printf(" TYPE_BOOLEAN \n ");
"String"                              printf(" TYPE_STRING \n ");

{Boolean}			       printf(" BOOLEAN_LITERAL \n ");
{Integer}                             printf(" INTEGER_LITERAL \n ");
{String}			       printf(" STRING_LITERAL \n ");
{Identifier}                          printf(" IDENTIFIER \n ");

{Parenthese_open}                     printf(" PARENTHESE_OPEN \n ");
{Parenthese_close}                    printf(" PARENTHESE_CLOSE \n ");
{Bracket_open}                        printf(" BRACKET_OPEN \n ");
{Bracket_close}                       printf(" BRACKET_CLOSE \n ");
{Brace_open}                          printf(" BRACE_OPEN \n ");
{Brace_close}                         printf(" BRACE_CLOSE \n ");

"="	                              printf(" AFFECT \n ");
"+"                                   printf(" ADD \n ");
"-"                                   printf(" SUBSTRACT \n ");
"*"                                   printf(" MULTIPLY \n ");
"!"                                   printf(" NOT \n ");

"&&"                                  printf(" LOG_AND \n ");
"<"                                   printf(" LOG_LESS \n ");
"<="                                  printf(" LOG_EQLESS \n ");
">"                                   printf(" LOG_MORE \n ");
">="                                  printf(" LOG_EQMORE \n ");
"=="                                  printf(" LOG_EQ \n ");
"!="                                  printf(" LOG_DIF \n ");

";"                                   printf(" SEMI_COLON \n ");
"."                                   printf(" DOT \n ");
","                                   printf(" COMMA \n ");

{bl}                                  /* no actions */
"\n"			                      /* no actions */

{Comment_line}         				  /* no actions */
{Comment_block}         		      /* no actions */

{Error_identifier}                    {printf("\nLEXICAL ERROR on character %d (line %d): Illegal Identifier\n\n", yytext[0], yylineno);}
{Error_comment}                    	  {printf("\n unclosed comment (line %d)\n\n", yylineno );}
{Error_string}                    	  {printf("\n unclosed string (line %d)\n\n", yylineno);}
{Error_character}                     {printf("\n error character %d (line %d): Illegal Identifier\n\n", yytext[0], yylineno);}




%%


int main(int argc, char *argv[])
{
     yyin = fopen(argv[1], "r");
     yylex();
     fclose(yyin);
}



int yywrap()
{

}

