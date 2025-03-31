
## Blog

---



#### 2025/03/27


For some reason, I did look for primes.

`perl -e 'my $b = shift; print "sqrt: ",sqrt($b),"\n";for my $a (2..sqrt($b)){ if ( int($b/$a)*$a == $b ){ print "a: $a\n"; } }' 0xffffffff`

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

Ok. checked it. The PIC flag did has been part of my trouble.
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




#### 2021/10/21

malloc.

I'm trying to work something sensible for minilib out.

The problem is, it is hard to say in which ways malloc is going to be used.
I'd even say, malloc shouldn't be part of a system library.

What to do with deleted elements? Currently, sparse areas are kept, until 
a continous area up to the end is free; which is free'd then in whole.

Obviously, memory usage will grow on unordered malloc's and free's.

However, there are advantages: It's fast, and the codesize is tiny.

For small tools, I yet intend minilib for, and which do allocate maybe a few 100kB, 
this might be the optimum.

Admittedly, not for programs, which do many de- and reallocations.

Again, up to a hard to say barrier, unused sparse areas don't matter - but as soon,
that's more than a few pages, it does matter. However, again dependent on the access schema.

I guess, I'm going to implement something like a minimal malloc, and have e.g. a tree of deleted elements as 
compile switch. Eventually the best solution would be sort of a malloc toolbox,
so everyone can build something, which is usable for the very usecase.





#### 2021/10/13


I'm currently about to look at the security of minilib.
Yet, I didn't try to really harden the library - The standards itself,
C89, C11, are inherently insecure.

There are functions like gets, which you shouldn't use for variable userinput at all.

For example:

```
cmd getcommand(){
	char buf[4096];
	if ( ! gets(buf) )
		throw_error();
	
	return(parse(buf));
}
```
This should read the next line from stdin, parse the line
and return the recognized cmd.

However, when faced with a line, longer than 4096 Bytes,
the stack would be overwritten - the classical bufferoverflow.

This, in turn, as soon the redline is crossed (gcc reserves some bytes for dynamical allocations
at the stack on each function entry, called the redzone),
it is possible to overwrite the return address of the function getcommand.
This allows an attacker to change the program flow, and jump somewhere else.

However, there are cases, it is ok to use gets. E.g., when stdin is conected to 
a pipe, and to the pipe is written by a trustworthy program.
Or, stdin is closed, and redirected to a configuration file.

Therefore, I did the decision some time ago, to not trying to patch functions like gets,
since finally the developer using minilib has to watch out for not doing things
like the above getcommand.

Anyways, now I'm trying to give the possiblity for some hardening options.

I wrote one option, globals_on_stack, which locate all globals of minilib at the stack;
behind the last used return address.
There is the advantage of being able to have binaries, only consisting of
one segment, the text segment.

The stack is created in each case by the kernel,
and this saves several hundred bytes of the binaries.

Finally I started the whole minilib, after I created my first hello world
without using glibc, and had been puzzled by the sizes.
(glibc hello world, up to 1MB; handwritten with the own syscall routines, around 200 Bytes)

Just now, I'm a bit puzzled. Firstly, gets shouldn't exist.
Even when used for a trustworthy stream. It opens an unneccessary attack vector.
But I cannot strip gets of minilib, since this would prevent many programs
of being linkable with minilib.

Secondly, there are other attack vectors. I tried to insert a guard page after the stack,
to prevent the ability of overwriting the environmental variables with a stackoverflow.
It's not possible.
(I do know, the bsd people even do a shadow copy of the environment).

Then, strangely the bss segment has to be executable. 

Sideways, several (even suid) programs of linux have a executable stack, e.g. the Xserver.

Furthermore, I'm wondering, why the stack's address is randomized, the other segment's not.

It's again - when randomizing the stack's location, one should do the same
for the other segments. Elsewhise - it's like having two holes in your boat;
one you patch, starring at the second hole and leaving it the way it is.

Then you could have leaved the first hole as well.

Finally, first hand someone has to do something like the above getcommand,
to be able to overwrite the stack at all.

I did implement map_protected, setting up a dynamicaly allocated memory area,
which is surrounded by protected pages.
I'm wondering whether to introduce a new data type, protected_mem,
and change gets(char*) to gets(protected_mem*).

This would at least throw a warning. 
Albite - Obviously there's the possibility to setup protected_mem buf[4096]
at the stack.

Ok, one could implement macros, which throw an error when someone tries 
to setup a protected_mem array. But - somehow - that's all not the solution.

Possibly I should just use compiler warnings for things like gets.

Have to think about that. I'm also thinking of the option "harden" -
which would simply disallow gets, doing a shadow copy of the environment, and so on.
But, this is someout out of the scope of minilib - having as small binaries as possible.

And would again introduce confusion - either a libray IS hardened - doing shadow copies
of sensitive data, placing stack canaries, and so on - or not.

Finally, C (luckily) isn't Java.

Possibly it is Vogonic, but I'm going to have lunch.

[https://www.youtube.com/watch?v=yaJMD4AkZWs](Vogon)


Ok. I leave this for now. This would just introduce confusion, 
and you just cannot ensure with a system library, other people don't do
stupid things.
You also shouldn't try, I'd guess, this would be as silly as well.

I now implemented warnings. However, everyone should be aware, 
I have read through some vulnerability reports - but I wouldn't say I know all weaknesses
of nowadays systems.

Somehow - this is correct. Somehow not. 

For now, I'm going to implement fuzzy tests, and compare the output of different libc implementations.

Some time ago, I haven't been aware, minilib would possibly be able to replace glibc or musl.
So I didn't even try to follow the standards, instead I just did want the whole thing working,
and used mainly the bsd manpages for reference.

I'm not so eager on comparing the reference and my implementation now.
Fuzzytesting might show differences between e.g. musl and minilib.



#### 2021/09

Sometimes hard to decide, where to start a project.

So, I've got my ideas for a linux distribution collected.
I know, howto get the things online.

Several things are more or less finished.

However, where to start, what are the most important things??


Good news, I'm going to miss several fiddly problems.
No dependency management for most programs (static linking), 
security problems might be avoidable by strict separation in different
(wideley known as firewall zones) containers, 
no need to have xzillion software available,
by (again) just having other distros or package managements as containers.


However - some things I'd like to have ready, but they aren't.

The whole posix userspace utilities linked with minilib, e.g.

The big question - use busybox for shell scripts, or.?


My userspace utilities are neither finished, or posix compatible (has never been the destiny, yet).


Thinking about that - I guess, I still have to get minilib to compile most programs, first place.

It is close. And there is the possibility to include other libraries, e.g. for the math functions.
(I do not see any advantage in ruling own math functions, most functions are better fitted to the according architecture,
which is not the target of minilib at all - the target there is to have a tiny standard libc, 
which is resulting in really small binaries).



The other side - what is important, and already running?

The system is up within a few seconds. (say, all over all 5 seconds, having xorg and i3 running, 10 years old thinkpad)

I do have some concepts (also tested) to layer the os transparently into different parts.
Security related (proxies in demilitarized zones/containers),
user software related.(having here arch for some software, not needed for the basic functionality).



Application firewall, without ui yet, but working.
Would be trivial to implement application throttling.



Again - thinking about it - what is the point of a distribution?


In this case, it is the concept of 
1. containerization, 
2. application firewalls,
3. application isolation. 
4. (I'm targetting a "single" user distribution,
in the meaning of, only one user is supposed to work with the system at the same time.)

5. statically linked core applications.
6. easy to integrate other distributions, so the central aspects of the core can be concentrated on. 
  I do not believe it is that wise trying to target this or that applications, user desktop and server applications,
   andsoon the same time. Better do one thing, but well. Albite some aspects are the same for desktop and server systems,
	I personally do believe there is a hard border in some aspects.
7. Have some sort of waybackmachine. (layered aufs)
8. the inner core should be unmodifiable, by default, the "mantle" should be readonly as well, 
   but might be useful to be able to update or add components.


thinking abot this - somehow I've got the guts, the application firewall ui could be the most important thing.
(Besides the package management, but this might be quite trivial).
I did quite much admire the cgi system admin interface of puppy linux.


Naa. I'm going into the forest now.
Mushrooms everywhere, I do like them.
My parents have been going looking for mushrooms, when I've been a child.
Possibly I'm going to find the starting point as well.

Confuzius did say, when you've got no time, you should take some time for relaxing.
So.

And I already do remember again some of the concepts I did have, also written down, 
sadly I did have some data loss. Anyways.


#### 2021/06

So. I hope for god's sake "Corona" is at the end of it's lifetime.

Annoying thing.

Meanwhile, I'm quite glad to have brought a project of mine into a useful state,
'minilib'.

Anyways, there are chances I'm able to get into my normal life again.

I'll further develop minilib and it's accompanying projects.
It's just, a passion and, sort of, point to concentrate on when everything else goes mad.

I guess I can be really happy to have this sort of contemplation.

My 'cover' of my 'real life' has been broken.

I won't link back anyways.

There honestly are reasons to separate different images.


#### 2020/07

Didn't blog too much the last time.
Albite I did quite some progress with minilib. (online within the branches  'devel', and 'devel-HEAD')
C89 done to 98%, when subtracting floating math functions and localizations.
Which I don't intend to add, anyways. For floating math there are several libraries
already out there. And localizations are somehow out of the scope of minilib.

Meanwhile. 
If you're a developer, possibly you do have some amusement reading this snippet.
(a nonconformant and nonoptimized seq implementation)..

I know. Defining void and zero isn't that respectful. Or wise.
But I couldn't resist.

Please, don't take that too serious..
But somehow I do like the solution, 
which came up by looking for the 'algorithms', resulting in an as small as possible binary.
(440 Bytes, regular elf binary).

```
#if 0
mini_start
mini_exit
mini_writes

LDSCRIPT text_and_bss
SHRINKELF
INCLUDESRC
return
#endif

// misc 2020/06
// public domain

void usage(){
		writes("Usage: seq from/to [to]\n");
		exit(-1);
}


int toint( const char c[] ){
	int ret = 0;

	while ( *c > 47 && *c < 58 ){
			ret *= 10;
			ret += (*c-48);
			*c++;		
	}
	return(ret);
}


char* count(char *digit, char* first){
	if ( digit < first )
			first=digit;
	*digit = *digit+1;
	if ( *digit > '9' ){ 
			*digit = '0';
			first = count(digit-1,first);
	}
	return(first);
}

#define VOID "0000000000\n"
static char* 
		ZERO = VOID; // seems ok to assume


int main(int argc, char *argv[]){
	if (argc == 1) {
			usage();
	}

	// A philosophical question.
	// However, it works, therefore it's true.
	char *p = ZERO + sizeof(VOID) - 3 ; 

	char *last = p;
	int i=0;

	int to = toint( argv[1] );

	if ( argc>2 ){ // count to 'from'
			for ( ; i<to; i++ )
					p=count(last,p); 
			to = toint( argv[2] );
	}

	for ( ; i<= to; i++ ){
			write(STDOUT_FILENO, p, ZERO - 1 + sizeof(VOID) - p );
			p=count(last,p);
	}

	return(0);
}
```


#### 2020/06

An update.

Got a milestone with minilib. (http://github.com/michael105/minilib)

A minimal shell compiles with unchanged sources to a stunning size of 5.8kB,
statically linked.

Minised from Eric Raymond, again unchanged, compiles to 18kB.

That's astonishing. Minised, compiled and linked dynamically with musl,
counts with 180kB here. (Gentoo, slightly optimized).
Honestly, I don't know how it's possible to save 90 percent.
Or, I don't know what exactly happens when compiling with musl.
Must be some strange multiple inclusion of utf8, localizations, and. Dunno.

There ist still some code left for ansic compatibility. (lacking a bit more to posixc)
And I've to tidy the sources. (Again)



Wrote a few more core tools for the "minicore", intended as absolute minimal
shell environment for an initrd.

I've to fiddle something out for the "rinit" set of initscripts.
Yet I'm using the shell interpreter from busybox.
Stripped down to 128kB. It's amayzingly fast.
However, somehow I do not like the idea of interpreted scripts for the bootup.

The parsing is uneccessary overhead.

On the other hand, I prefer the "microkernel" approach,
regarding the shell environment as kernel.
(Which it is, it's just not part of the "real" kernel.)

Last idea has been to compile the core tools with different load addresses,
and simply load and fire them with an own loader, without replacing the calling binary.
Just load them into ram, at the address specified by ld, and call "start".
Since they are compiled position dependent already, this could be a viable and performant way.
And would prevent forking, again saving some resources.

Maybe that's a viable way between monolythic and micro approach.
But have to think about that.
It's somehow a quite difficult question of design.
(Knowing about the discussion between Thorvalds and Tannenbaum)..
But the discussion between these both has never been about the different approaches,
it was more about personal things. As Linus states in his biography.


The tools are - minimal. But most of them stay below 1kB.

While thinking about that. Especially, about the build system.
There is no anyone reason, to not simply distribute the binaries.
Along the sources. But, having the sources without external build dependencies,
and, at the moment, restricted to x64 - besides the fact, (And I should know it),
cpu specific optimizations would rarely give a few cycles / the performance is 
given instead by the minimalistic approach - I believe in opensource.
But, since the binaries might built to even binary equal files on all systems (x64),
I do not see any reason anymore to not distribute the bins.


---

few days later. I don't exactly do know, why the heck I started this project.
Somehow, I wan't to get this finished.
But having given myself the silly border of 64kB for a usable basic system,
with a maximum of 128kB - I do not really know, if this has some real advantage.

Somehow yes. Obviously, every byte saved at the bottom, will pay out.

But. It still is a silly idea.

Atm, I'm having some trouble with the linker scripts of minilib.
What shows up in really annoying errors. Sort of, one time it works,
no changes, next time it doesn't work.
I'm quite sure, it has to do with static vars. But. I guess, whoever has already been
confronted with bugs, showing only randomly up, is able to understand my frustration.

It's uuugh. Guessing, the problem might be at this place - adding debug instructions -
suddenly, the problem is gone. To just show up at another place. Sometimes.

Darn it.

And somehow, I'm really in the grip of hacking now. I want this to work. Damnit.

Finally, sash (Stand alone shell) now compiles to 34kB, stripped of a few tools. And works. More or less.
You just shouldn't do too much file globbing. 

Having ranted enough now - there is quite some success.
Another minimal shell compiles to 4.8kB. And works, stable.
As well as the growing number of coretools.
64kB seems to be possible.
It is just the question, of what tools are to be defined basic.
Full posix - I do not believe yet, this could fit into 64kB.
Especially not, when linked as separate binaries.

However, a basic system of 64kB is absolutely possible now.  Statically compiled.
Counting some "extras" like sed (18kB) to another 64kBs.


#### 2020/04/17

Some time ago, I blogged here.

I should possibly link another blog of mine, albite I tried 
to put here the "serious" stuff, in the other page(s) I'm sort of presenting
another side.

Anyways. Atm, I'm (still) concerned about my security.
I didn't yet have the urge, to really secure my systems,
exceeding a "normal" security level.
Some things showed me I obviously got some leaks.

And, the usual "firewall", blocking things from the outside,
leaving everything from the inside out - well.

Seems to me, finally I stopped some ugly behaviour.
E.g., my hd always went full, but I wasn't able to pinpoint the problem.
Neither the disk usage showed the problem.

Going to upload some of the solutions I found for generic problems,
as soon I finished.
Implemented an allpication level firewall for linux, amongst others.
Since I already wrote some Gui(s) for generic tabular data representation
and alteration, probably an application level firewall gui is my next project. 
Have to check, how much time this would need.


Meanwhile, I stumbled about an quite interesting article.
Optimizations for C.

(snip)

#### 2020/04/17

Some time ago, I blogged here.

I should possibly link another blog of mine, albite I tried
to put here the "serious" stuff, in the other page(s) I'm sort of presenting
another side.

Anyways. Atm, I'm (still) concerned about my security.
I didn't yet have the urge, to really secure my systems,
exceeding a "normal" security level.
Some things showed me I obviously got some leaks.

And, the usual "firewall", blocking things from the outside,
leaving everything from the inside out - well.

Seems to me, finally I stopped some ugly behaviour.
E.g., my hd always went full, but I wasn't able to pinpoint the problem.
Neither the disk usage showed the problem.
Anyways, I guess, I should be really paranoic now.
So - :/ reinstall. As soon, as I have a new hd.
Which also broke.

Going to upload some of the solutions I found for generic problems,
when I finished.
Implemented an allpication level firewall for linux, amongst others.
Since I already wrote some Gui(s) for generic tabular data representation
and alteration, probably an application level firewall gui is my next project.
Have to check, how much time this would need.


Meanwhile, I stumbled about an quite interesting article.
Optimizations for C.

[https://www.codeproject.com/articles/6154/writing-efficient-c-and-c-code-optimization]

An especially surprising snippet below..

```
Faster for() loops

It is a simple concept but effective. Ordinarily, we used to code a simple for() loop like this:

for( i=0;  i<10;  i++){ ... }

[ i loops through the values 0,1,2,3,4,5,6,7,8,9 ]

If we needn't care about the order of the loop counter, we can do this instead:

for( i=10; i--; ) { ... }

Using this code, i loops through the values 9,8,7,6,5,4,3,2,1,0, and the loop should be faster.

This works because it is quicker to process i-- as the test condition, which says "Is i non-zero? If so, decrement it and continue". For the original code, the processor has to calculate "Subtract i from 10. Is the result non-zero? If so, increment i and continue.". In tight loops, this makes a considerable difference.

The syntax is a little strange, put is perfectly legal. The third statement in the loop is optional (an infinite loop would be written as for( ; ; )). The same effect could also be gained by coding:
Hide   Copy Code

for(i=10; i; i--){}

or (to expand it further):

for(i=10; i!=0; i--){}

The only things we have to be careful of are remembering that the loop stops at 0 (so if it is needed to loop from 50-80, this wouldn't work), and the loop counter goes backwards. It's easy to get caught out if your code relies on an ascending loop counter.

We can also use register allocation, which leads to more efficient code elsewhere in the function. This technique of initializing the loop counter to the number of iterations required and then decrementing down to zero, also applies to while and do statements.
```


..2025,misc

Reevaluating, what I've written and copied.

This might be only partially right.
It is quite often surprising, what compilers (I did most with gcc) do generate.

From the assembler view, it might be better to write for ( int a = 9; --a; )

This should break down to two single instructions. ( dec %[a]; jz endloop )

However, if 'a' isn't used in the loop, gcc *can* be smart enough.
It depends.

Me, I'm writing for ( int a = 10; a --> 0 ; )
or while ( a --> 0 )

what I should stop. I like the arrow, but just now I realize, 
a is tested to be greater than -1.
Therefore an additional comparison is needed.

So, I did check.
Code below.


By writing while ( a --> 1 ) again only two instructions are generated.
But this seems a bit misleading to me, the last loop will be with a==1,
and a will be 0 after the loop.

loops with while ( a-- ) will again compare a with -1.

so, best way is: while ( --a ) or for ( int i = 5; i; i-- )


Testcode and disassembly below. 
The inline asm is useful, to grep for the symbolic labels. (marks)



```

	writesl("===== while =====");

	asm("while:\n");
	int i = 5;
	do {
		printf("i%d\n",i);
	} while( i-->1 ); // 1
	printf("i out %d\n",i);

	writesl("=====");
	asm("while2:\n");
	 i = 5;
	do {
		printf("i%d\n",i);
	} while( i-->0 ); // 0

	writesl("=====");
	asm("while3:\n");
	 i = 5;
	do {
		printf("i%d\n",i);
	} while( i-- ); // 0


	writesl("=====");
	asm("while4:\n");
	 i = 5;
	do {
		printf("i%d\n",i);
	} while( --i );  // 1



	writesl("===== for =====");

	asm("mark:\n");
	for (int i = 6; i-->1; ){
		printf("i%d\n",i);
	}

	for (int i = 6; i-->0; ){
		printf("i%d\n",i); // 5..0
	}



	asm("mark2:\n");
	for (int i = 6; i;i-- ){
		printf("i%d\n",i); // 6..1
	}

	asm("mark3:\n");
	for (int i = 0; i<=5;i++ ){
		writesl("====="); // This gets unrolled. (with -Os (!))
	}

	asm("mark4:");
	for( int i = 5; i--; )
		printf("i: %d\n",i); // 4 3 2 1 0
									//

	asm("mark5:");
	for( int i = 5; --i; )
		printf("i: %d\n",i); // 4 3 2 1 
```

gcc -Os


```
0000000008048c46 <while>:
 8048c46:	bb 05 00 00 00       	mov    $0x5,%ebx
 8048c4b:	89 da                	mov    %ebx,%edx
 8048c4d:	31 c0                	xor    %eax,%eax
 8048c4f:	be d5 8e 04 08       	mov    $0x8048ed5,%esi
 8048c54:	bf 01 00 00 00       	mov    $0x1,%edi
 8048c59:	e8 5b fe ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048c5e:	ff cb                	dec    %ebx
 8048c60:	75 e9                	jne    8048c4b <while+0x5>
 8048c62:	31 d2                	xor    %edx,%edx
 8048c64:	be da 8e 04 08       	mov    $0x8048eda,%esi
 8048c69:	bf 01 00 00 00       	mov    $0x1,%edi
 8048c6e:	31 c0                	xor    %eax,%eax
 8048c70:	e8 44 fe ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048c75:	b8 01 00 00 00       	mov    $0x1,%eax
 8048c7a:	be ce 8e 04 08       	mov    $0x8048ece,%esi
 8048c7f:	ba 06 00 00 00       	mov    $0x6,%edx
 8048c84:	89 c7                	mov    %eax,%edi
 8048c86:	0f 05                	syscall 

0000000008048c88 <while2>:
 8048c88:	bb 05 00 00 00       	mov    $0x5,%ebx
 8048c8d:	89 da                	mov    %ebx,%edx
 8048c8f:	be d5 8e 04 08       	mov    $0x8048ed5,%esi
 8048c94:	bf 01 00 00 00       	mov    $0x1,%edi
 8048c99:	31 c0                	xor    %eax,%eax
 8048c9b:	e8 19 fe ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048ca0:	ff cb                	dec    %ebx
 8048ca2:	83 fb ff             	cmp    $0xffffffff,%ebx
 8048ca5:	75 e6                	jne    8048c8d <while2+0x5>
 8048ca7:	b8 01 00 00 00       	mov    $0x1,%eax
 8048cac:	be ce 8e 04 08       	mov    $0x8048ece,%esi
 8048cb1:	ba 06 00 00 00       	mov    $0x6,%edx
 8048cb6:	89 c7                	mov    %eax,%edi
 8048cb8:	0f 05                	syscall 

0000000008048cba <while3>:
 8048cba:	bb 05 00 00 00       	mov    $0x5,%ebx
 8048cbf:	89 da                	mov    %ebx,%edx
 8048cc1:	be d5 8e 04 08       	mov    $0x8048ed5,%esi
 8048cc6:	bf 01 00 00 00       	mov    $0x1,%edi
 8048ccb:	31 c0                	xor    %eax,%eax
 8048ccd:	e8 e7 fd ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048cd2:	ff cb                	dec    %ebx
 8048cd4:	83 fb ff             	cmp    $0xffffffff,%ebx
 8048cd7:	75 e6                	jne    8048cbf <while3+0x5>
 8048cd9:	b8 01 00 00 00       	mov    $0x1,%eax
 8048cde:	be ce 8e 04 08       	mov    $0x8048ece,%esi
 8048ce3:	ba 06 00 00 00       	mov    $0x6,%edx
 8048ce8:	89 c7                	mov    %eax,%edi
 8048cea:	0f 05                	syscall 

0000000008048cec <while4>:
 8048cec:	bb 05 00 00 00       	mov    $0x5,%ebx
 8048cf1:	89 da                	mov    %ebx,%edx
 8048cf3:	31 c0                	xor    %eax,%eax
 8048cf5:	be d5 8e 04 08       	mov    $0x8048ed5,%esi
 8048cfa:	bf 01 00 00 00       	mov    $0x1,%edi
 8048cff:	e8 b5 fd ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048d04:	ff cb                	dec    %ebx
 8048d06:	75 e9                	jne    8048cf1 <while4+0x5>
 8048d08:	b8 01 00 00 00       	mov    $0x1,%eax
 8048d0d:	be e4 8e 04 08       	mov    $0x8048ee4,%esi
 8048d12:	ba 10 00 00 00       	mov    $0x10,%edx
 8048d17:	89 c7                	mov    %eax,%edi
 8048d19:	0f 05                	syscall 

0000000008048d1b <mark>:
 8048d1b:	bb 06 00 00 00       	mov    $0x6,%ebx
 8048d20:	ff cb                	dec    %ebx
 8048d22:	74 15                	je     8048d39 <mark+0x1e>
 8048d24:	89 da                	mov    %ebx,%edx
 8048d26:	be d5 8e 04 08       	mov    $0x8048ed5,%esi
 8048d2b:	bf 01 00 00 00       	mov    $0x1,%edi
 8048d30:	31 c0                	xor    %eax,%eax
 8048d32:	e8 82 fd ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048d37:	eb e7                	jmp    8048d20 <mark+0x5>
 8048d39:	bb 06 00 00 00       	mov    $0x6,%ebx
 8048d3e:	ff cb                	dec    %ebx
 8048d40:	83 fb ff             	cmp    $0xffffffff,%ebx
 8048d43:	74 15                	je     8048d5a <mark2>
 8048d45:	89 da                	mov    %ebx,%edx
 8048d47:	be d5 8e 04 08       	mov    $0x8048ed5,%esi
 8048d4c:	bf 01 00 00 00       	mov    $0x1,%edi
 8048d51:	31 c0                	xor    %eax,%eax
 8048d53:	e8 61 fd ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048d58:	eb e4                	jmp    8048d3e <mark+0x23>

0000000008048d5a <mark2>:
 8048d5a:	bb 06 00 00 00       	mov    $0x6,%ebx
 8048d5f:	89 da                	mov    %ebx,%edx
 8048d61:	31 c0                	xor    %eax,%eax
 8048d63:	be d5 8e 04 08       	mov    $0x8048ed5,%esi
 8048d68:	bf 01 00 00 00       	mov    $0x1,%edi
 8048d6d:	e8 47 fd ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048d72:	ff cb                	dec    %ebx
 8048d74:	75 e9                	jne    8048d5f <mark2+0x5>

0000000008048d76 <mark3>:
 8048d76:	bf 01 00 00 00       	mov    $0x1,%edi
 8048d7b:	be ce 8e 04 08       	mov    $0x8048ece,%esi
 8048d80:	ba 06 00 00 00       	mov    $0x6,%edx
 8048d85:	89 f8                	mov    %edi,%eax
 8048d87:	0f 05                	syscall 
 8048d89:	89 f8                	mov    %edi,%eax
 8048d8b:	0f 05                	syscall 
 8048d8d:	89 f8                	mov    %edi,%eax
 8048d8f:	0f 05                	syscall 
 8048d91:	89 f8                	mov    %edi,%eax
 8048d93:	0f 05                	syscall 
 8048d95:	89 f8                	mov    %edi,%eax
 8048d97:	0f 05                	syscall 
 8048d99:	89 f8                	mov    %edi,%eax
 8048d9b:	0f 05                	syscall 

0000000008048d9d <mark4>:
 8048d9d:	bb 05 00 00 00       	mov    $0x5,%ebx
 8048da2:	ff cb                	dec    %ebx
 8048da4:	83 fb ff             	cmp    $0xffffffff,%ebx
 8048da7:	74 15                	je     8048dbe <mark5>
 8048da9:	89 da                	mov    %ebx,%edx
 8048dab:	be f5 8e 04 08       	mov    $0x8048ef5,%esi
 8048db0:	bf 01 00 00 00       	mov    $0x1,%edi
 8048db5:	31 c0                	xor    %eax,%eax
 8048db7:	e8 fd fc ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048dbc:	eb e4                	jmp    8048da2 <mark4+0x5>

0000000008048dbe <mark5>:
 8048dbe:	bb 05 00 00 00       	mov    $0x5,%ebx
 8048dc3:	ff cb                	dec    %ebx
 8048dc5:	74 15                	je     8048ddc <mark5_asm>
 8048dc7:	89 da                	mov    %ebx,%edx
 8048dc9:	be f5 8e 04 08       	mov    $0x8048ef5,%esi
 8048dce:	bf 01 00 00 00       	mov    $0x1,%edi
 8048dd3:	31 c0                	xor    %eax,%eax
 8048dd5:	e8 df fc ff ff       	callq  8048ab9 <_dprintf.constprop.0>
 8048dda:	eb e7                	jmp    8048dc3 <mark5+0x5>

```


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
        data-theme="light"
        data-lang="en"
        crossorigin="anonymous"
        async>
</script>



