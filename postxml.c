/*
** postxml.c
** nroff post-processor that output xml.
** Replace '#[' and ']#' by '<' and '>'
** replace '#(' and ')#' by '&' and ';'
** replace '#~' by '#'
** and delete '\n#-\n' from stream.
** Compile with: cc -Wall -o postxml postxml.c
*/

#include <stdio.h>

/*
** Read input stream
** If \n#-\n is found, delete it
** Replace '#[' and ']#' by '<' and '>'
** Replace '#(' and ')#' by '&' and ';'
** Replace '#~' by '#'.
*/ 
int
main(void)
{
	char c;
	int del=0; // delete lines
	int tag=0; // replace tag
	while( (c=getchar()) != EOF){
		// delete
		if( del==0 && c=='\n'){
			del=1;
			tag=0;
		}
		else if( del==1 && c=='#'){
			del=2;
			tag=1;
		}
		else if( del==2 && c=='-'){
			del=3;
			tag=0;
		}
		else if( del==3 && c=='\n'){
			del=0;
			tag=0;
		}

		// replace tags
		else if( tag==0 && c=='#' ){
			tag=1;
		}
		else if( tag==1 && c=='[' ){
			if( del==2 )
				putchar('\n');
			putchar('<');
			tag=0;
			del=0;
		}
		else if( tag==1 && c==']' ){
			if( del==2 )
				putchar('\n');
			putchar('>');
			tag=0;
			del=0;
		}
		else if( tag==1 && c=='(' ){
			if( del==2 )
				putchar('\n');
			putchar('&');
			tag=0;
			del=0;
		}
		else if( tag==1 && c==')' ){
			if( del==2 )
				putchar('\n');
			putchar(';');
			tag=0;
			del=0;
		}
		// delete '~' after '#'
		else if( tag==1 && c=='~' ){
			if( del==2 )
				putchar('\n');
			putchar('#');
			tag=0;
			del=0;
		}
		// take care of '#' following another '#'
		else if( tag==1 && c=='#' ){
			if( del==2 )
				putchar('\n');
			putchar('#');
			tag=1;
			del=0;
		}

		// print normaly
		else if( del==1){
			putchar('\n');
			putchar(c);
			tag=0;
			del=0;
		}
		else if( del==2){
			putchar('\n');
			putchar('#');
			putchar(c);
			tag=0;
			del=0;
		}
		else if( del==3){
			putchar('\n');
			putchar('#');
			putchar('-');
			putchar(c);
			tag=0;
			del=0;
		}
		else if( tag==1){
			putchar('#');
			putchar(c);
			tag=0;
			del=0;
		}
		else {
			putchar(c);
			tag=0;
			del=0;
		}
	} // end of while loop

	// print last line
	if( del==1){
		putchar('\n');
	}
	else if( del==2){
		putchar('\n');
		putchar('#');
	}
	else if( del==3){
		putchar('\n');
		putchar('#');
		putchar('-');
	}
	else if( tag==1){
		putchar('#');
	}
	return 0;
}

