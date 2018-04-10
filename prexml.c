/*
* prexml - nroff pre-processor to escape tags
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

