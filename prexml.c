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

