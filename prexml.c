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
** $Id: prexml.c,v 0.2 2013/02/12 10:33:45 pj Exp pj $
*/




/*
** prexml.c
** nroff pre-processor that escape some tags.
** Replace '#[', '#]' '#(', '#)', '#\' and '#-'
** by troff strings.
** Compile with: cc -Wall -o prexml prexml.c
*/

#include <stdio.h>

/*
** Read input stream
** Insert '\*(' before '#[', '#]',
** '#(', '#)' and '#-'.
*/ 
int
main(void)
{
	char c;
	int tag=0;
	while( (c=getchar()) != EOF){
		// look for tag
		if( tag==0 && c=='#')
			tag=1;
		else if( tag==1 && ( c=='[' || c==']' \
		|| c=='(' || c==')' || c=='~' || c=='-') ){
			putchar('\\');
			putchar('*');
			putchar('(');
			putchar('#');
			putchar(c);
			tag=0;
		}
		// print normal chars
		else if( tag==1){
			putchar('#');
			putchar(c);
			tag=0;
		}
		else{
			putchar(c);
			tag=0;
		}
	} // end of while loop
	if( tag==1)
		putchar('#');
	return 0;
}

