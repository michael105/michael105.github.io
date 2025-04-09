
## Blog


#### 2025/04/06


Finished a first version of a 4kB httpd. 
Since I did several other tools and toys focussed on size,
I did found the according 'organizations', 0x1kB, 0x4kB.

Going to put those tools into different repositories.

The webserver could come handy, no configuration, just the path of the webroot as argument.

Going to squeeze the mimetype strings. I'm already below 4kB, but I'd like
to add some other features. 
Does markdown to html conversion on the fly, via the external lowdown markdown compiler.

Going to upload that thing.







#### 2025/04/05

Did two things, finished `minihttpd`, which uses another concept to push updates 
to the clients, via 'SSA', Server Side Aborts. This showed up to be far more
reliable than any other method I tried, did some stresstesting. and kidding. sort of.

Since I was at it, did also implement two other webservers, both written in plain C,
mixed with some assembly.
One is missing closely the 8kB mark. 
So I was a bit annoyed by the bloat, rewrote that thing, now the statically compiled binary 
is 4kB; but is able to serve directory indexes as well.
They are forking, but incredibly fast, due to the small size, and use 'sendfile'.
('new' linux call). (memo: I remember a website with a lot of tiny webserver comparisons, look for that)

I'm going to push them into separate categories, 4kB, 8kB and 'bloat (64kB)'.

They all do a subset of http 1.0. Eventually I should implement persistent 
connections, and upgrade to 1.1, it's not that complicated.

The bloated one is already out of the mini category.

The main cause might be (again) callbacks.
Eventually I should replace those callbacks with macros,
the used callbacks are known at compile time.


With the bloated one, I'm again at the problem of howto include
a ls function in a generic way, to not parse again the output of ls.
Instead just write the list of links to the files in html.


Focus that strong on size might be a mistake. Somehow.
But I did learn so much by my mistakes, I need to do more.

I'm not going to try to write a 1kB webserver.

... Now the 4kB version is also able to convert markdown pages on the fly via lowdown to html.




#### 2025/04/04


Finally finished. This div based layout (again) doesn't necessarily,
what it is supposed to do. A little bit off at the smartphone.

The webserver works great, just needs some cleanup.
And I need to rethink, about how I publish the source.

Possibly I'm going to publish the original source along
with a preparsed version, which should compile with gcc.

Did struggle with the select syscall. 
The maybe 10th time, I was confused by the linux manpage.

The first argument, 'count', means bitcount.

Did a improved version.

I'm going to setup my blog repo first, then publish that.



---

```
   if (argc > 1 && strcmp(argv[1], "-advice") == 0) {
			printf("Don't Panic!\n");
				exit(42);
				    }
(Arnold Robbins in the LJ of February '95, describing RCS)



The chat program is in public domain. This is not the GNU public license. If
it breaks then you get to keep both pieces.
(Copyright notice for the chat program)


> > Other than the fact Linux has a cool name, could someone explain why I
> > should use Linux over BSD?
>
> No.  That's it.  The cool name, that is.  We worked very hard on
> creating a name that would appeal to the majority of people, and it
> certainly paid off: thousands of people are using linux just to be able
> to say "OS/2? Hah.  I've got Linux.  What a cool name".  386BSD made the
> mistake of putting a lot of numbers and weird abbreviations into the
> name, and is scaring away a lot of people just because it sounds too
> technical.
(Linus Torvalds' follow-up to a question about Linux)

```

---


Now I'm wondering - whether I should port my. 



Foot: A device for finding funiture in the dark.



Oh. the documentation to https://metacpan.org/pod/Acme::Don::t#LIMITATIONS 
remembers me to my regex expression machine implementation.
Where I did face the problem, what to do, if you negate everything. `!*`
I cannot remember, but the result was unexpected, albite logical correct.
Should finish that. 




```

LIMITATIONS
    Doesn't (yet) implement the opposite of do STRING. The current workaround is to use:
                  
    don't {"filename"};
              
    The construct:
                  
    don't { don't { ... } }
              
    isn't (yet) equivalent to:
                
    do { ... }
              
    because the outer don't prevents the inner don't from being executed, before the inner don't gets the chance to discover that it actually should execute.
    This is an issue of semantics. don't... doesn't mean do the opposite of...; it means do nothing with....
    In other words, doin nothing about doing nothing does...nothing.
    You can't (yet) use a:
                
    don't { ... } unless condition();
              
    as a substitute for:
                
    do { ... } if condition();
                
    Again, it's an issue of semantics. don't...unless... doesn't mean do the opposite of...if...; it means do nothing with...if not....
```





#### 2025/04/03

Did instead write a webserver, which watches a htmlroot with
inotify, and pushes updates to the browser.

Was quite some fun.

It's very early in the morning, so I'm not going to publish
that thing now. Testing this thing, works.

At least with firefox it's now possible to see in "realtime",
what I'm typing here.

Used a quite funny method to notify the browser about the need to update:
instead of using streams, ajax, sse or something, there is 
just another port connection opened.
As soon, this connection gets aborted by the server,
the browser does a reload.

Somehow, this is quite more reliable and easy to implement, as any other 
method I tried.

Markdown is converted with lowdown, nearly instantly.

I also tried ai generated solutions.
I come more and more to the conclusion, I don't now why,
but yet all suggestions of ai had problems.

Sometimes, in this case, the suggestions can help by showing the syntax.
Did need to look some things up for javascript, it's been a while.

But anyways, even things I tried some time before, simple shell scripts,
do tend to make trouble, when written by ai. Even if they SHOULD
work.  

Oh.

I did temporarly experiment with netcat based servers.

Did talk with ai about that, explained what I did,
and what the javascript should do.

Did kill the netcat server, to abort connections.
What worked out well.

Ai insisted, repeatedly: Stop killing netcat!

Somehow, as if the ai felt with the poor nc,
the conversation got sort of emotional. 

I do admit, that's been the other point of the ai,
what I'm doing isn't standard at all.
But, it works. And might be the most stable way.
Other experiments with timeouts showed up to be quirky.
And I wasn't interested in using a javascript framework, 
since the whole webserver is smaller than any framework.
13kB, when compiled as webserver only.
30kB with SSA extensions.




#### 2025/04/01

Reworking those pages.

I did write a recursive parser for templates some time ago, the funny thing is,
it recognizes just two tags: \#+i and \#+e

```
#+e command  :  executes a command, and insert the output.
#+i file     :  includes another file
```

The interesting result, this already helps a lot.

Just now I prepend and append files to the ouput of the md to html
converter.

I guess, I should just write a small perl script, 
to do my conversions. Not that complicated.

Instead, I did write a fmt function in assembler,
formatting numbers in base 2 - 36, doing different paddings,
and so on. 

I don't know why, but this conversion problem into digits
somehow is fascinating to me.
I definitely wrote more than 20 versions of this.

Now, the assembly version should be final.
I just need to rewrite that in C.

Eventually I'm going to just use the according instructions in C.
What isn't that nice to read, many goto's, in assembly
you need to write your loops with gotos.


Sametime I'm still trying to find a useful abstraction for the output
of tools. 
Last thought: define structures, where each data field it stored,
with it's according format string for printf.

This implies to either call the ouput callback from the tool,
and make a copy of the data.
Or have some memory mapped, and copy the data there.

Oh. I realize, the fmt can be separated.

It is not that easy in this case, since I'd like to have the possiblity 
to use shared memory, and parallel execution.

The main problem are strings. 

Seems to me, I'll end with a template system, and patterns known of cgi backends.

Well. Should end my brainstorming.



#### 2025/03/31

Compiling two source formatters, to highlight sources in html.

While waiting, I realize - this takes ages, the tools are written in c++.

It's quite amazing, how deep macros in C can be nested, without 
taking too long to compile.

With c++ - well. Now it finished. might had been 10 minutes
for a small tool.

Oh. Now I see, why it took that long.
The tool's binary to highlight sources does have 23MB.




#### 2025/03/27


For some reason, I did look for primes.

`perl -e 'my $b = shift; print "sqrt: ",sqrt($b),"\n";\
		for my $a (2..sqrt($b)){ \
			if ( int($b/$a)*$a == $b ){ \
				print "a: $a\n"; \
			} }' 0xffffffff`

(factorize/ to be exact, find all factors of/ the argument)

The interesting result, I was looking for: 32bit unsigned( -5 ) (0xfffffffb) is the largest unsigned 32bit prime. (4294967291)

Easy to remember. I'm not that good with numbers.

(did need a number, which isn't a potency of 2..36. What a prime > 36 cannot be. Most lazy solution. )

...

reading this again. the oneliner is the most simple solution, I could type.
There are better approaches, found primes should be stored, and there's a gap below the square root,
where no number can be a factor of b without having a factor below this gap.

Andsoon. Anyways. I leave this the way it is.



*tags primes*

---

All that ki generated stuff at the internet is starting to be too much.
It's as with those damned previews at the news portals.
'If you did buy that, you need to act' .. or whatever.
And everytime you are forced to go to the article and read half of it, 
until you realize, no, I didn't buy -whatever. A pound of platin.

It's annoying. And somehow even worse than the old popup advertisements of the 90s.

Eventually I should use an ai, to filter out news, I'm interested in.
But somehow I've got the bad feeling, this would make things worse.

There is the result, if ai trains other ais, after a few generations
the ais are completely degenerated.

What, if we regard ourselves as trained by ai??
This could get horrible.

Sametime I remember an even worse problem, which is more concrete.

What, if the communication with ai is under surveillance, and misused without context?

So, someone checks, if he is able to convince ai to some conspiration theories.

Bad news, now he is at the list. Welcome to brazil 23.0

Orwell and Terry Pratchet did team up to write reality, with maniac laughter.

Well, somehow I don't care. I think, it's funny, I like Terry Pratchet. But the dangers are there.

The real problem might be the surveillance.
People did talk nonsense for all times.
But it simply wasn't possible to watch all of them.

Where it was done, like in the DDR, and so on, we do know the result.

Now, it is not only possible, it is done more and more.
Even cryptography could get illegal.

This can get a real problem.
Especially, since too less people seem to realize, how dangerous this can get.

I believe, it's important for a culture, that there are divergent and special people.
Others think, it's dangerous, those are criminals. 

To cite Orwell: being different is a crime.

I do believe, what J.D.Vance did say in munich, is partially not right.
He sees several things from an outside perspective.
But he also talked about a very important point, freedom.


*tags ai,orwell*
*title Orwell and Pratchet do write our reality*


-----


Did get into some trouble with the redzone.
What, if my inline assembly function gets itself inlined, but I'm clobbering the redzone?

Well. Seem s to me, I do have to jump below the redzone within the asm.

While recherching, according to a microsoft developer, for windows
the size of the redzone varies - between 0 and 212 bytes, depending on the architecture.

And this is, I don't understand. I mean, it would be both ok, either have a redzone, or not.

But - both ?? This ist typical for microsoft.

The fact, their "OS" nowadays is halfway stable, might be the result of sheer luck,
and learning from mistakes. With the result of still having old 90's code stuff deep within,
I could bet on that.

Someone, I believe it was Palmer, suggested at this time: there should be two teams.
Developers, and debuggers.

The developers should exclusively code, and not test.
The debugger should exclusively look for bugs.

It should be obvious, this cannot work out.


Just think of the case, someone assumes, there is a redzone - but it isn't.
Since someone did decide, it's not needed for -whatever arch.
This sort of bugs is already hard to find.
How should someone find this bug, and fix it, if he didn't write the code??
You could read the disassembly. If the source would not had been written in visual basic.


 might have confused the names, I'm certain, it's been Al Bundy.






#### 2025/03/26


Did had written a function to convert unsigned integers to base 2-36.

My approach was a recursive (nested) function,
which doesn't need any division.
(division is one of the most expensive operations, using up to several 
 hundred times more resources than other operations)

Somehow, it looks nice in C.

But the disassembly shows, this isn't effective. (too big)

Somehow, with some things gcc isn't that good.
Nested functions, variable function arguments, 
(nested) structures and unions.

```
int _xuitobuf(char *buf, unsigned int i, const unsigned int base, int prec, const char pad){
	# define xuitobuf(_buf, _uint,...) _xuitobuf( _buf,_uint,DEFAULT_ARGS( (10,0,'0'), __VA_ARGS__) )

	char *pbuf = buf;
	uint tmp;

	void r_uitobuf(uint digit){
		prec --;
		if ( !__builtin_umul_overflow(digit,base,&tmp) && (  tmp <= i ) ){
				r_uitobuf(tmp);
		} else {
			while ( prec --> 0  )
				*buf++ = pad;
		}

		for ( *buf = '0'; i>=digit; i-=digit )
			(*buf)++;

		if ( *buf > '9' ) *buf += 39;
		buf++;
	}

	r_uitobuf( 1 );
	*buf = 0; 
	return ( buf - pbuf);
}
```
I copy the disassembly here: [./r_uitobuf.txt](./r_uitobuf.txt)

I conclude, nested functions are better avoided.

Since I was at it, I did rewrite the function in assembly.
Sort of "misusing" the stack as stack.


```
static int _asmuitobuf(char *buf, unsigned int i, unsigned int base, int prec, const char pad){
	# define asmuitobuf(_buf, _uint,...) _asmuitobuf( _buf,_uint,DEFAULT_ARGS( (10,0,'0'), __VA_ARGS__) )
	char *pbuf = buf;
	uint _base=base;

	asm volatile ( R"(
	xor %%edx,%%edx

	inc %%edx
	push %%rdx
	mov %%eax,%%r9d
1:
	cmp %%eax, %%esi
	jb 8f
	push %%rax
	dec %%ecx
	mul %%r9d
	jno 1b

8: # padding  
	dec %%ecx
	jle 2f
	mov %4,%%al
	repnz stosb

6:
	pop %%rcx
	mov $0x2f,%%eax
3:
	inc %%eax
	sub %%ecx,%%esi
	jae 3b
	add %%ecx,%%esi

4:
	cmp $'9',%%eax
	jbe 5f
	add $39,%%eax
5:
	stosb
2:
	dec %%ecx
	jnz 6b

9:
	movb %%cl,(%%rdi)
	)" : "+c"(prec), "+S"(i), "+D"(pbuf), "+a"(_base) : "g"(pad) : "rdx", "r9", "memory", "cc" );
						
	return ( pbuf-buf );
}
```

The disassembly with function prologue is in the same txt file.



#### 2025/03/24


Found at stack overflow,
a cite of Kotzker Rebbe

    If I am I because I am I, 
	 and you are you because you are you, 
	 then I am I and you are you. 

	 But if I am I because you are you 
	 and you are you because I am I, 
	 then I am not I and you are not you!


Reminds me of Schelling and the "Nicht Ich".(Not I)

For Schelling, the "not I" is the ground of beeing. 
With a 'negative' association.

Saying I'm grounded within myself does have imho way more positive effects.

Just now I do recognize, my English is technical firsthand.
While developing I quite often even think in English, albite not my native language.
With philosophy, this is different.

It's an interesting experiment, anyways.

I do need to somehow rethink all concepts I know.
This gets way more concrete. 

Sametime I get slow, extremely slow.
Trying to think of the 'I' of Descartes, doing this in English,
and make a connection to Schelling and Rebbe, I get stuck.

Close to trying to solve a mathematical riddle, which has no solution.

....

Here is the link to the cite: https://judaism.stackexchange.com/questions/148411/are-you-really-you


*tags: Schelling,philosophy*

-----

...


My solution to the overflow problem of multiplications is inline assembly.

```
int umul( uint *result, uint a, uint b ){
	int ret = 0;
	asm (R"( 
		mul %2
		jno 1f
		inc %0
		1:
	)" : "+r"(ret), "+a"(a) : "r"(b) : "cc" );
	*result = a;
	return(ret);
}
```
Reading this again, it should be inlined. 
And at least one register can be spared, the second operand of mul
can stay in memory, the first operand (eax) does hold the result as well.

ret doesn't need to be a register as well.

Just now I'm wondering whether it's possible to change the function abi
for single functions. 

Or if there is a hack to check for the overflow bit from within C.

...

https://www.fefe.de/intof.html


...








#### 2025/03/23


Should have written a transpiler, this would have been easier.

I extended the current options (getopt sort) like parsing macros,
 and added named arguments to the tools.

 sort of: xflags("/path1","/path1"); xflags( setflags='ds', "/path"), xflags( l ), ...

the cpp praeprocessor assigns the arguments, combines all paths into an array of pointers, and so on.

However, the preprocessed code now looks - awful. really awful.
first hand. second hand, this isn't easy to extend.

In my search for the smallest binaries, it is a huge advantage to loeave as much work as possible
to the preprocessor. But my other idea, writing a transpiler, which in turn e.g. converts
the named argument syntax into C syntax, would be way more easy to implement, and
there wouldbe more extension possible.

I'm writing some memos to me, about useful extensions to C, especially in the context
of tiny static binaries...


- named arguments, eventually as indirect small pointers.
- namespaces ( just prefix namespaced vars and functions with it's namespace id, and use a cpp syntax )
- make all functions and global vars static. (gcc isn't smart enough and assumes, the functions 
		could be called with other arguments from outside the curren compilation unit)
- stack canaries with less overhead
- compressed strings
- malloc analyzation ( using separated areas for malloc and the usage case )
- templates
- static inheritance

Well. Eventually, possibly, I should experiment with c++.
I do know c++ quite well, but dislike the overhead.
However, using C gets more and more complicated.
It is all possible.
Don't know. I leave that decision for later.


About c++ - In my opinion, there are several things not that great.

But eventually I really should see, whether it would be possible, to use only some
separated features of c++. E.g. namespaces, named arguments, and operator overloading.
templates.
On the other hand - I fear, it's like medusa'a box.

Start using only some features, and suddenly you end up with a typical c++ implementation,
which is something different as aiming for tiny static binaries.


My current problem is the abstraction of the output of tools.
I might have found a way. sort of: outp(type,fmt,content); ... 
and outpbuf();

The fmt ist applied to the content in outpbuf, which is a callback.

So it is possible to e.g. write the output of xflags into a char buffer,
or get a list of binary data as a list of structs.
(useful e.g. for 'find' or 'ls', and it's extensible, e.g. compression and network transmission)

Furthermore I'd like to separate the output logic from the program logic.


-----

##### multiplication overflow

This is one of the worst bugs, I ever found. (also introduced by me..)
the multiplication of two integers doesn't neccessarly yield 
in the result being smaller than one of the factors.

thinking about that, it's the same with addition.

a horrible feature.

There are intrinsics, which check for overflow.
I eventually might stick with assembler.


Looking into the code, gcc generated for the intrinsic, again those unecessary register copies.

```
8048de5:       89 d8                   mov    %ebx,%eax
8048de7:       48 89 44 24 18          mov    %rax,0x18(%rsp)
8048dec:       8b 04 24                mov    (%rsp),%eax
8048def:       f7 e3                   mul    %ebx
8048df1:       41 89 c5                mov    %eax,%r13d
8048df4:       0f 80 1b 01 00 00       jo     8048f15 <uitofmt.isra.0+0x209>
```

why?? 

Did read backwards in the assembly.
I don't understand, in ebx is just a 1 stored.


This is the same as with variable arguments of functions.
The code, gcc generates, is just crazy. Here there are several xmm instructions generated,
half of them could be strippped, I guess.

Might be some fun for kernel development.

I would be interested, in what code clang generates.
Currently, I better write my inline assembly.

*tags gcc bugs*



#### 2025/03/22


Still fiddling around with macros...

My current experiment, the idea is simple:

Have a Maro definition:

```
#define xflag_OPTIONS \
	h,,,"Show help", \
   w,int,cols,"Set column with", \
  ...
```

Parse that with the preprocessor, and create the functions
usage(), help(), the macro PARSEARGV(), the tool_main declaration, the tool() Macro...

It works already without the type specifier.
(Used in 'xflags')

I however did oversee, in my concept, I do need
all tools as variadic macros, so it's possible to write
in C xflags("/dir/file"), xflags( l+x, "/dir/file" ), xflags( s, addflags="sd", "/file" ), xflags( cols=80 )...
And those macros do need their own toolname as parameter.

The framework with global static vars for options and arguments, it's the same.
It is great and imho ok with small static linked tools.
But I do more and more come to the conclusion, I might end up
with a linked library. (typeof, I've written my own loader)
And in this case, It might be better to call the tools with arguments, instead of using
globals. Else I'll end up.

Oh. Sometimes writing helps sorting my thoughts out.
My current implementation expands into several arguments. 
so, tool_main( int opts, char* arg1, char*arg2,... , path1, path2.. )

There is the advantage for the compiler to optimize arguments and code paths within tool_main away,
if unused.

However, if using a struct instead, this can be seen as a 'global' at the stack, for the 
time execution takes place within and nested within tool_main.

Again, and this might be the real problem, it depends on whether I'm going to
'link', and tool_main is within a separated binary.
Or whether I stick with those small static linked binaries.


It is also the question of how much space can be spared effectively.
E.g. by having a printf implementation, but sparing most conversions.

.....

In my experience, usability is extremely important.

When comparing perl and shellscript, my point might be obvious.

Eventually I should have written a transpiler, instead of fiddling with macros around.

On the other hand, the advantage of my idea is the optionality.

It is just an option within a basic framework, so it's an optional addon.


.....

The other riddle is howto have a basic and unified output 'system'.

I fear, I'll need to get away from my byte counting obsession...

By looking into the compiled binaries, I did learn a lot about compiler internals.
Also about howto write performant code.

But since the formatting of the output and the exchange of binary data within 'pipes'
is such a basic thing, I need to get away from my priority in this case.
And shift my focus from codesize to usability.


I should regard this reflection as a riddle on its own. 


At least, I can shift my focus to aesthetics again with the output implementation.

Those macros, it's like, I don't know.

Each macro is like a pot, stuffed with unknown chemicals and objects. 
Look into the pot, and be surprised.
You eventually are able to sort the pots, and polish them outside.
But.. 

And don't ever put the wrong thing into such a pot, or you are going to experience,
what the true meaning of 'features' is...


Albite not the optimum performancewise, I might use callbacks for the output conversions,
to be able to redirect the output.
This is something completely different.

I again realize - I need to decide on whether build the tools as library or statically linked
conglomerats now. The abstraction of the output can be done via macros or callbacks.
Depending on the needs.


-----

Ok. I really should regard those macros as pots.
Doesn't matter, what's inside.

I just need to polish the outside a little bit.

And maybe even separate that clearly, by having the headers 'loops.h' and 'loops.impl.h' ...
Thinking about that, I should introduce a new 'keyword', something like
```//+INTERFACE
# define macro() ...
```
within loops.impl.h, and copy the definition into loop.h.

Or maybe even more easy, separate the header files itself into to parts.

at the top, have the outside definitions.

below, separated, its implementations and again the definitions and documentation,
which is copied to the top.

Write a marker with the file's timestamp at the top, so the build system doesn't need
to regenerate the file each time.

And have sort of marks with each definition, to be able to jump from the top definition
to its implementation, also being a mark for the parser.


-----


##### 'side effects'


I did check my strcmp implementation of yesterday again.

```
static int asm_cmp(const char *s1, const char *s2){
	int a = 0;
	asm (R"(
	1:
	   testb $0xFF, (%%rdi)
		jz 4f
		cmpsb
		je 1b
		jbe 3f
		2:
		dec %0
		jmp 6f
		3:
		inc %0
		jmp 6f
4:	
		testb $0xFF, (%%rsi)
		jnz 2b

6:
	)" : "+r"(a), "+D"(s1),"+S"(s2) :: "cc" );

	return(a);
}
```

shockingly:
```
asm_cmp( buf1, buf2 );// does work out.
buf2[4] = 'X'; // change buf2
asm_cmp( buf1, buf2 ); // wrong result.
```

either asm needs to be volatile, or the memory needs to be flagged. (:"memory")..

in this case, I'm buffled, since gcc doesn't know what happens inside the asm.
Besides, rax is written.


Anyways, my final solution.

```
static int asm_cmp(const char *s1, const char *s2){
	char a;
	asm volatile (R"(
	1:
	   lodsb (%%rsi),%%al
		subb (%%rdi),%%al
		jnz 6f

		inc %%rdi
		testb $0xff,-1(%%rdi)
		jnz 1b
6:
		neg %%al
	)" : "=a"(a),"+D"(s1),"+S"(s2) :: "cc" );

	return((int)a);
}
```

I'm not so happy with the neg.
But defining a macro to switch arguments s1/s2 (therefore rdi/rsi) doesn't seem wise.

the whole function now is 18 Bytes.
(uclibc 29 bytes. musl 23bytes)

On the other hand, musl and uclibc are compiled into movzbl instructions, 2 and 3 in the loop.
Those aren't that fast. well. I leave that for now.


To add some explanation, why I'm writing a strcmp in assembler:

the implementations of musl or uclibc are essentially machine language as well.

They do casts, and sign conversions.

I copy them below..

```

int muslstrncmp(const char *_l, const char *_r, size_t n)
{
	const unsigned char *l=(void *)_l, *r=(void *)_r;
	if (!n--) return 0;
	for (; *l && *r && n && *l == *r ; l++, r++, n--);
	return *l - *r;
}


//(uclibc)
int ucstrcmp (const char *p1, const char *p2)
{
  const unsigned char *s1 = (const unsigned char *) p1;
  const unsigned char *s2 = (const unsigned char *) p2;
  unsigned char c1, c2;

  do
    {
      c1 = (unsigned char) *s1++;
      c2 = (unsigned char) *s2++;
      if (c1 == '\0')
	return c1 - c2;
    }
  while (c1 == c2);

  return c1 - c2;
}

```

The bionic implementation is crazy. sse3, or unrolled.





#### 2025/03/21

Reading the C99 spec, (again) ....

Well. strncat(s1,s2,n) appends up to n+1 (!) bytes to s1. (memo to me: rtfm .......)

In my experience, especially older software often relies onto such features.
Hard to find bugs, sometimes even heisenbugs.
Furthermore, the implementations do not necessarily follow the specification,
making things worse.

 Sideways, I'd prefer a formal language for specifications. 
 Natural languages are sometimes hard to understand and distracting, 
 if you need to understand exactly the e.g. definitions.
 (Some thing, I did learn in philosophy.. it's common
  to read single pages at least twice, sometimes 10 or 20 times..
  With the difference, that associations can be quite important,
  depending on the author.)

And my question, what happens, if null pointer are supplied, this isn't specified.

Sametime I recognize, well. 
I still do have the project of fuzzy tests, comparing different libc
implementations. 

Currently rewriting an 'getopt' macro,
which does as much work as possible at compile time.
Still counting bytes...

Did a rewrite of strcmp in assembler.
;) spares about 40 bytes. (albite non portable)
Now wondering, whether strcmp should be aliased to strncmp(a,b,-1),
if strncmp is compiled. Obviously, yes.
Next question is, whether relying on the compiler to translate
a trampoline function halfway performant, or use a macro .....

Admittedly, this relies onto noone comparing strings > SIZE_T MAX


*tags C,gcc,C99,specifications*

#### 2025/03/19


I'm still thinking about howto implement named arguments for core tools.

I might write my own precompiler. 
And either use a fixed syntax, I can grep for, without parsing the whole
C code.
Or do an intermediate step, between two runs of the c praeprocessor.

I did oversee, I already have macro lists for the arguments,
and additional arguments like the ouput stream handler are the same for all tools.

About pipes, I'm still thinking.
I could use callbacks for the output, which can be overwritten.

Define structures, inheritable, and call either the output callback, 
to print at the screen, or into a buffer, or copy the binary data into
shared memory, or wherever.

The advantage is a clean separation of the program logic from its output as well.

The disadvantage - this costs some bytes.

But I already realized, with 'ls', it doesn't make sense at this level 
to look for the smallest possible solution alone.
E.g. colors could be regarded as unneccessary overhead.
But this doesn't make sense.


I'm going to work out a solution for that.

After that, I might look again at the problem of a package manager.
Which I'm eventually more or less dismiss. 

I did some work a long time ago, there my 'packages' had been simple tarballs,
and aufs overlays. Little bit tinycore linux alike.
The reason had been to be able to experiment with different 
source packages, at a gentoo base. 
E.g. installing a new version of glibc. What can get nasty,
due to further dependencies on iconv, and whatever.

.. did think about it. I need to rewrite those option parsing macros in each case,
they need to be prefixed with the current tool's name.

Possibly I should add options with long names.
maybe.. (so many bytes...)


Then I should focus on other things.

Currently, somehow, there are ten things at the same time.
Like slterm, it's imho very close to be 'finished'.
The core tools - many are missing, and I'll need to rewrite all of them,
for redirectionable output.

Static linking still is a problem, but will always be.

btw., to anyone reading this, please remove the debug switch (-g) from 
distributed makefiles. or make it optional.


---

Reading the manual - I note this for later..

'-mrtd'
   Use a different function-calling convention, in which functions
   that take a fixed number of arguments return with the 'ret NUM'
   instruction, which pops their arguments while returning.  This
   saves one instruction in the caller since there is no need to pop
   the arguments there.

(function attribute)
'const'
     Calls to functions whose return value is not affected by changes to
     the observable state of the program and that have no observable
     effects on such state other than to return a value may lend
     themselves to optimizations such as common subexpression
     elimination.  Declaring such functions with the 'const' attribute
     allows GCC to avoid emitting some calls in repeated invocations of
     the function with the same argument values.

'nonnull (ARG-INDEX, ...)'
     The 'nonnull' attribute may be applied to a function that takes at
     least one argument of a pointer type.  It indicates that the
     referenced arguments must be non-null pointers.

'patchable_function_entry'
     In case the target's text segment can be made writable at run time
     by any means, padding the function entry with a number of NOPs can
     be used to provide a universal tool for instrumentation.
(might be a way to use stack canaries..)

'-mfunction-return=CHOICE'
     Convert function return with CHOICE.  The default is 'keep', which
     keeps function return unmodified.  'thunk' converts function return
     to call and return thunk.  'thunk-inline' converts function return
     to inlined call and return thunk.  'thunk-extern' converts function
     return to external call and return thunk provided in a separate
     object file.  You can control this behavior for a specific function
     by using the function attribute 'function_return'.

---

No luck. I did hope to find something, to specify the difference
between the arguments 'str=_opt' and '_opt', to
have different Generic macro paths.

Currently it seems to me, I should start writing the transpiler.

Using the specifier 'const volatile' ... is. well.

The other option would be to write : xflag( +o+l, (args)(addflags=+s+d,delflags=+i), "path", "path" )
instead of: xflag( +o+l, addflags=+s+d, delflags=+i, "path", "path" )

I could do a typedef for paths as well. Using 'const signed char* const'.
so this gets: xflag( (path)"path1" );

It's ugly in both cases.

----


for blogging I might have found a solution (again).
Just using gists. 


It's sunny again here in munich.
Should go outside later.


Listen to some music first, while writing I somehow was remembered to some of the lyrics of 'the wall'..




#### 2025/03/18


Since I did write, what I'm doing currently, hacking some basic things together in strange ways,
maybe I also should explain a little bit more.

First hand, it's fun to me, and contemplation.

It's sort of a soothing puzzle. 
Possibly I'll never finish, but this is not, what puzzling is about.


It's more about my surprises, in which ways C can be used.

With Perl, it is known. 
With C, e.g., without any problem you are able to write object oriented
code. 

Sametime, I did learn a lot about compilers.
There are common misconceptions. E.g. - a variable isn't neccessarily
assigned or updated, if some conditions are given.

a=7; this is more like a hint.
The variable can get completely optimized away, or pushed into a register,
maybe even bitshifted, and so on.

(If you need to be sure, the variable gets assigned, write asm volatile("mov $7,%0" : "=m"(a) ); )

I might write more about that, also about the order of instructions, but I continue with Assembler.

C is an abstraction of Assembler. Even with assembler, some things are surprising,
especially when copying data around.
The abstraction layer adds its own complexity.

In both cases, neither the keyword 'volatile' nor memory fences seem to work
in each case, instead those features exist only, as long you don't
go into debug mode. The classical Heisenberg Bugs.

This is some special sort of fun with syscalls.


Somehow, today, I'm going to do other things.

oh, and my latest nic (misc147), my github page is placed at position 1 with google and quant.
Maybe I should stick with that this time. 

I didn't know (or remember, I did learn a litlle bit chinese years ago), 
I just did choose 147 for no special reason, but
it is the chinese radical (part of a word) for seeing, feeling, and some other meanings.




#### 2025/03/17



Surprisingly, AI couldn't help at all.

AI did write several macros, which do not work at all.


I tried several versions of gemini, but I don't expect any AI to be able to help.


Problem was to have a praeprocessor decision path for arguments.

There are three 'types': opts, a 32bit bitfield.
  Sadly I cannot resort to a struct, since the compiler isn't able to do its optimizations
  anymore with structs. in my experience.


  named args. 

  and path(s).


So I'd like to write: xflags("/path"); xflags(l+x,"/path2"); xflags(a+g+x,addflags=d+s,"/path3");

Further, optionally the output can be redirected. Into char buffers, or as binary 
output into shared memory/wherever.



More and more I struggle with my aim for the smallest possible binaries.

I'm going to find a solution for the macro decision path.

Then, I might need to take a break. 
The most obvious way seems to me to write a stream like interface for the output,
with callbacks, also for the formatting.

But this will not give the smallest binaries. 

Admittedly, I might need to rethink my definition of bloatware.
The problem is, it is much easier to have a clear destination set.
But in this case, this will not work out.
Or I'm going to have other problems.


I dislike the idea of formatting data at a pipe's writer, to then parse that data into binary format
at the receiver again.

I even dislike pipes, and might replace them with shared memory.
And I'm not eager to have several processes, eventually threads are needed,
but even that seems unneccessary in most cases.


---


So, I might have a plan: Sort the argument macro problem out.

And think about a generic output macro for the tools, which 
can be changed later.


Sort all those macros out, get them into a consistent state.


Make a decision, whether I really like to have my macro decision
path based on the difference of 'const volatile char*' and 'char*' (cough).

(eventually I'm at the point, where it would be better to begin with a transpiler..)
Thinking about a transpiler .. wouldn't be that hard. I just need to replace
all arg1=value1 arguments with (arg)(arg1=value1) ...
I just dislike the idea of writing those brackets within every's tool call.

Type conversion might be another problem, I'm faced with.
Doable via macros. But, since I like to exchange data in binary format as well,
and I don't want to rely too much on callbacks, they are quite an overhead,
well. 

cpp isn't an option to me, btw. It would obviously work, but then I'd be faced with
other trouble. Since I'm counting single bytes, and a few hundreds bytes are a red flag to me,
I'm not going to use cpp.


----

Then, there's still the question of howto combine the different tools into single binaries.
I did already write an own loader, which doesn't do symbolic relocations at all.
Instead, just maps another binary(/library, this doesn't matter) into ram,
load the function addresses from a table, and redirect function calls there.
Extremely simple. 

But my original goal was to have statically linked binaries.

I know, those problems are .. well, fun to me.


----


anyways. Plan is set. do those macros.
then take a break.


----


ok. done so far.

I'm writing down my thoughts about path lists.
Closely connected with binary output of tools.

several ideas..


```
struct _ls_entry{
	_ls_entry* next;
	char* path;
	uint permissions;
	...
}

struct xflag_entry{
	*next;
	xflag_t flags;
	char path[]; 
}
```

ah me. need another datatype.
e.g. filename and caps.
separating the list. hm. 
I might need to have data between the structs.
xfentry pathname capabilities xfentry ...

I did already think about a totally abstracted type, where
only the positions of members are given.

with structs there is the advantage of type safety.

e.g. GREP(pathlist,tr_entrys) will throw an error.


makros, some ideas:

FOREACH_PATH(list,do ...)

FOREACH_LINE(list,...)

GREP(list, path) 

ok. I need a tidy concept.

I'm close.


Looking at ls, it's also obvious, it is better to fill a struct first,
then do it's formatting for the output.

the fmt in turn would be nice to be given in the header.
So it is possible to have a list of the output of ls,
maybe modify it, print it out later.

I stop that for now. I really need to reconsider my thoughts about binary sizes..


#### 2025/03/16




Trying to figure a way out, to be able to use
os 'functions', which are sametime standalone tools,
from within C in a perlish manner.


things like: xflag (many options) (flags) path1, path2, ..


so here is my current experiment..


```
#define TOOL_MAIN( _tool)


#define _dbgv(_arg) #_arg": ",_arg, "\n"

#define dbgv(_str, ...) printvl( _str " (dbg "__FILE__", "__STRLINE__ ")\n", FOREACH_K(_dbgv,__VA_ARGS__) )


enum _arg {___arg};
typedef enum _arg arg;


int mytool_main( uint opts, int i1, int i2, char *str, char *path ){
   dbgv( "options: ", opts, i1, i2, str, path );

   return(0);
}

#define mytool(_opts,...) ({ int opts=0; int i1=21; int i2=22; char *str="STR1"; \
      char *path="n"; char *p = "0"; \
   _Generic((_opts), int: opts=(int)(POINTER)(_opts), arg: _opts, char*: p=(char*)(POINTER)(_opts) ); \
   __VA_ARGS__; \
   mytool_main( opts, i1, i2, str, p ); })


MAIN{


   printvl( *argv );

   //mytool_main( 7, 11,12, "str1 xx ", "path1" );


   mytool( "c" );
   mytool( 1, i2=33, "pfad" );


   //mytool( i1=100, i2=33, "pfad" );
   mytool( 0, i2=33, str="string 1", "pfad" );
   mytool( (arg)(str="string 1"), "pfad" );


   exit(0);
}
```



The current problem is the decision path between string args and paths.

I dislike (arg)(...), it's a strange syntax.
I also dislike having arguments at fixed positions.

Eventually I should have paths as an array of pointers.

What, again, would be awful, when writing e.g. xflags("/file")

could do a macro: xflags(PATHS("/file"))


Finally, this might not be the best solution,
but works: I'm going to use a special datatype,
argstr.

Which is a typedef to volatile const char*

Works with generic, makes it possible to use the macros
with variable arguments without fixed position,
and the named arguments don't need to be prefixed with another type
or anything else.


At this point it seems to me, I might need to start writing 
my own transpiler.


hm. well. wouldn't possibly be that complicated,
I'd need to replace just the calls to mytool, etc.

named arguments like str="string" would need to be rewritten
as (arg)(str="string").

Obviously this is possible, without too much logic.


---


And I should write my script to convert my entries here 
to html and taglists.







*tags c,macros*






#### 2025/01/20

About coding with AI

Got the problem to share an id (rendered glyphs) with all x11 clients.

So, I asked the ai, howto do that.

Well, the ai for sure isn't bad, and suggestet ipc.
Obviously right.

Then, we wen't through the possibilities, shared memory, tcp, ..

My solution was finally a config file.
Until I realized, that's bad, cause the file will be persistent, the id not.

Some more discussion with ai, and suddenly - x11 properties. Values, which can be set and read from the xserver.
The ai even pointed out, (correct) the values will not persist. Albite I already stated,
persistence would be a problem.


So - the ai didn't understand my problem. It might also had been
my questioning, since I did ask for ipc.

Since ai does nothing else than completion, those problems will stay.

Did just read, ai is going to replace coders. No. 
This will not work out.

Not yet, and maybe never, for methodical reasons.

Copying isn't developing.



#### 2022/04/06


Yesterday, I started a rework of 'calcit'.

I didn't make clear, what it's intention is.

And I realized, I would implement things in another way.

There's a case table, which is ugly and not that performant.
Amongst others.


I intended the whole thing originally as an expression parser
for configuration files.

Parse a mathematical formula once, and have later variables calculated.

E.g. a mouse driver, where the accelaration, or translation can be changed,
and the formulaes are stored within a configuration file.

This would work the same way by an embedded script language.

However, what I've done is more restricted, and might be more performant.

Just now I'm a bit struggling - by far most performant might be a jit compiler.
Or sort of. 
Somehow I really get to the restrictions of C just now.

Eventally it would be possible as well, to write some parts in assembly.
My current problem are relative return addresses.

ehm. wait. probably my problem is about position dependent executables.

Ok. checked it. The PIC flag did had been part of my trouble.
I tried, amongst others, to jump into naked functions.

The fun part of this construction is, 
there is e.g. f1 and f2.

f1 is callen from main.
there is a assembly jump to f2 in f1.
f2 returns, directly to main.

This spares the function call overhead of f2.

What eventually works out, just think of a game, where the physical formulaes of the racing
car are stored within configuration files.

If every mathematical operator does have the overhead of a function call,
this will show up in the overall performance.

The best solution might be a "compiler", translating the formulae into opcodes.
however, somehow I don't like this idea that much.

It's not portable, and a very attackable vector for malware.

I guess, I should have a look into the generated assembly of
a table of closures, and a function table, first.

and should probably rethink the overall design.

[https://github.com/michael105/calcit](https://github.com/michael105/calcit)


And I stumbled (again) about skeeto, who obviously did something very close.
Have yet to understand what he did exactly.

[C closures as a library](https://nullprogram.com/blog/2017/01/08/)



Oh. while checking the links online, I stumbled about - Commodore 64 schematics.
This is. Oh.Just wonderful
[https://github.com/kicadretroarchive/commodore64c](https://github.com/kicadretroarchive/commodore64c)



``


<script src="https://giscus.app/client.js"
        data-repo="michael105/michael105.github.io"
        data-repo-id="MDEwOlJlcG9zaXRvcnkyMjU5MTIwODI="
        data-category="Announcements"
        data-category-id="DIC_kwDODXclEs4CoOid"
        data-mapping="pathname"
        data-strict="1"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="https://michael105.github.io/css/custom.css"
        data-lang="en"
        crossorigin="anonymous"
        async>
</script>



