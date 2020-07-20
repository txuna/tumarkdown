
%{
#include <stdio.h>
int yylex(void); 
static void yyerror(const char *s);
extern FILE* yyin;

#define YYDEBUG 1 
#define YYERROR_VERBOSE 1

%}


%token 
		lit_string 
		keyword_header_one 
		keyword_header_two
		op_rasgn 
		keyword_paragraph 
%%


mddoc : paragraphs opt_terms
	  ;

paragraphs : /* None */
		   | paragraph
		   | paragraphs terms paragraph
		   ;

paragraph : keyword_paragraph op_rasgn '{' pcontents opt_terms '}'
		  ;

pcontents : pcontent
		  | pcontents terms pcontent
		  ;

pcontent : keyword_header_one op_rasgn '{' ptext opt_terms '}'
		 | keyword_header_two op_rasgn '{' ptext opt_terms '}'
		 ;

ptext : pstring 
	  ;

pstring : lit_string 
		;

opt_terms : /* None */
		 | terms
		 ; 

terms : term 
	  | terms term 
	  ;

term : '\n'
	 | ' '
	 | '\t' 
	 ;


%%

//#include "lex.yy.c"

static int syntax_check(FILE* f, const char* fname){
	int n; 
	yyin = f; 
	n = yyparse(); 
	if(n==0){
		printf("%s: Syntax OK\n", fname);
		return 0;
	}
	else {
		printf("%s: Syntax NG\n", fname);
		return 1; 
	}
}

static int syntax_check_file(const char* fname){
	int n; 
	FILE* f = fopen(fname, "r"); 
	if(f == NULL){
		fprintf(stderr, "failed to open file: %s\n", fname);
		return 1; 
	}
	n = syntax_check(f, fname); 
	fclose(f); 
	return n; 
}

static void yyerror(const char* s){
	printf("%s\n", s);
}

int main(int argc, char** argv){
	int i, n = 0; 
	if(argc == 1){
		n = syntax_check(stdin, "stdin");
	}
	else {
		for(i=1; i<argc; i++){
			n += syntax_check_file(argv[i]); 
		}
	}
	if(n > 0){
		return 1;
	} 
	return 0;
}


