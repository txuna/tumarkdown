%{
#include <stdio.h>
#include "y.tab.h" //여기에는 BISON이 각 토큰에 대해 어떻게 처리할 것인지에 대한 정보가 들어간다. 

//#define YY_DECL int yylex(YYSTYPE* yylval)

/*
 int yylex(void) : lexer을 호출하고 토큰을 리턴한다. 
 char* yytext : 매칭된 문자열의 포인터 
 yyleng : 매칭된 문자열의 길이 
 yylval : 토큰에 대한 정보 값 
 int yywrap(void) 
 FILE* yyout : 출력 파일 
 FILE* yyin : 입력파일 
 INITIAL : initial start condition 
 BEGIN : condition switch start condition 
 ECHO : 매칭된 문자열을 쓴다. 

*/


/*
[ \t] 이걸로 문서내의 공백과 탭 토큰 무시 개행은 어떻게? 
TRAIL로도 개행 처리? 중괄호 안에 개행은 처리못할거 같은데 

[{]{TRAIL} : 여는 중괄호 다음 개행까지 해당 토큰으로 처리 
[}] : 닫는 중괄호 토큰 처리 
*/
%}
%option noyywrap
TRAIL ([\t \n]|"#"[^\n]*"\n")*
%%
"->"{TRAIL} return op_rasgn; 
H1 return keyword_header_one; 
H2 return keyword_header_two;
["]([^"\\\n]|\\.|\\\n)*["] return lit_string; 
Paragraph return keyword_paragraph;
[}] return yytext[0]; 
[{]{TRAIL} return yytext[0]; 
"\n" return '\n';
[ \t] return yytext[0]; 

. {
	fprintf(stderr, "lexical error %s\n", yytext);
};

%%
