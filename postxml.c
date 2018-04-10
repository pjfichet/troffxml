/*
* postxml - nroff post-processor to output xml
*
* Copyright (C) 2012-2018 Pierre Jean Fichet
* <pierrejean dot fichet at posteo dot net>
* 
* Permission to use, copy, modify, and/or distribute this software for any
* purpose with or without fee is hereby granted, provided that the above
* copyright notice and this permission notice appear in all copies.
* 
* THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
* WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
* MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
* ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
* WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
* ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
* OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

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
** Any following #- are deleted
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
		if( (del==0 || del==1 || del==4) && c=='\n'){
			// if del==1: repeated newlines don't reset the count
			// if del==4: any following #- are deleted
			del=1;
			tag=0;
		}
		else if( del==1 && c=='#'){
			// we will print a newline if we replace that tag
			del=2;
			tag=1;
		}
		else if( del==4 && c=='#'){
			// we will not print a newline if we replace that tag
			del=5;
			tag=1;
		}
		else if( (del==2 || del==5) && c=='-'){
			del=3;
			tag=0;
		}
		else if( del==3 && c=='\n'){
			del=4;
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

