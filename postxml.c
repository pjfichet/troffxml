/*
** Copyright (c) 2012
** Pierre-Jean Fichet. All rights reserved.
** 
** Redistribution and use in source and binary forms, with or
** without modification, are permitted provided that the following
** conditions are met:
** 
**   1.  Redistributions of source code must retain the above
**     copyright notice, this list of conditions and the following
**     disclaimer.
**   2.  Redistributions in binary form must reproduce the above
**     copyright notice, this list of conditions and the following
**     disclaimer in the documentation and/or other materials
**     provided with the distribution.
** 
** THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS
** IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
** FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
** REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
** INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
** OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
** INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
** WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
** NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
** THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
** $Id: postxml.c,v 0.3 2017/12/11 08:49:05 pj Exp pj $
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

