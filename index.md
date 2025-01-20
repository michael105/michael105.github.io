{% include_relative header.md %}

## Blog

---

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


#### 2020/02/11

Good morning.

I don't know, why. But, somehow,
I'm getting up earlier and earlier.
Maybe, cause I see I've got things to do.

So, my plan for today:

I did some changes to minilib; they are within the devel branch yet.
Like to push them to master.

Also, regarding minilib: ANSI-C is close.
And much of POSIX-C is written.
If I can take the time today, I'd love to push that forward.
The point is close, where one could build an entire basic linux system 
with minilib. Which would be a real milestone.
And also one of m other plans; having a solid and secure "minicore";
above one can build a linux distribution.
It's thought like this: The core should be rock solid. Just the core,
literary. Above that, you can build, whatever you want.
And the core should provide security related functionality.
E.g. password and user management, the firewall, syslogs.
I'm thinking about how to minimize memory usage of the core related services.
Every taskswitch needs resources. 
The core functionality is needed quite often,
every time, something is logged, e.g.
So, having a tiny core, counting in kilobytes, does have real advantages
in terms of responsibility and resource usage, of the whole system.


Ok. That's what I'd like to do.

Then, there IS to do:
I need to move. Have to call some people, and see, where I'm going to travel now.
ATM, some things seem to force me travelling. ;) Could be worse.

I have to take care of my money. I did see a job offer today,
which could be my dream. Remote work, and some travelling.
Have to apply. Today.

I really should do some music.
Albite, atm, my macbook is dead. :( 
And somehow, this really slows me down.
I'm used to open this thing, and do music, no matter where I am.
That's. But, I should do some music, and record this time, no matter of the circumstances.

Linkedin I'm going to push a bit.
I guess, yet I underestimated the power of social networks.
Ok. I'm a opensource developer, not a manager, you know. Anyways. 
I should improve myself.


I should change the harddisk in my notebook.
Somehow the free space is. well. too less.
And I got another disk with me, 
I'm just fearing the work, copying my current development system (Arch Linux), andsoon.

I need a dictionary, on my hd. Not sure, wheter I'm going to have fast enough internet, where I'm moving.
So better take care in advance.

I should say thanks for the accomodation to the good friend, where I'm now.
Have to think about what I could do for her.

Finally, I should setup a real blog.
ATM, I'm blogging at several places.
That's partially, cause I do have sort of several lifes.
And I don't want to have my postpubertying ego, writing down it's anger about some peculiar circumstances,
doing this at these more serious pages here.

But, somehow, I need to reintegrate. Or not.
It's about what I am. And parts of me do an entirely different carreer.
It is more than naturally, separating these parts in public.
Albite, that has nothing to do with me, and my personality.
I believe I'm a quite unified person.
I'm just having trouble with some other people,
who force me to, e.g., travel. And who also seem to think the craziest things about me.
These people seem to have a problem with me, and even managed to force me out of my flat.
Where I'm not going again, until I can afford the money for some lawyers.
;) possibly they didn't like my music.
Or, whatever. But one should be able to communicate. 
My unloved neighbour - she even isn't able to communicate,
when you talk to her friendly, saying repeatedly she should talk, when there is anything.
Naaa. Instead. She does crazy and violent things. Stupid.

The good thing: I'm travelling. I'm visiting good friends. I'm thinking about howto monetize
some of my knowledge of IT.
And I'm working quite straight, somehow. Possibly I should be travelling for some longer.
Seems to do me good.

##### 12:30

Uuuhm.

Sort of successfull.
I did some more networking at linkedin.
Writing more about me at my profile.

Some communication. And again, this took 5 hours yet. (or even 6?)

That's the part, I'm having trouble with. Do things in the right order; 
especially thats true for things, I don't like to do.
I'm able to do so. But. Anyways. I still do have another half of today.

So - left is: my application, my accomodation for the next days, the dictionary.

Some todo list, I could place here at github.
Ok. This I'm going to do now.




#### 2020/02/10

Life is an adventure.

In the need of falling back to some of my resources,
meaning, good friends and my knowledge and experience in informatic technologies,
suddenly, this starts to get fun.

I always preferred doing some development work just for fun.
It's a soothing puzzle to me,
other people watch television,
I do either music or some development puzzles.

However - sometimes life changes, and, well, I always did know,
I do have some things in my background.

And, my opensource engagement obviously pays out.

So, quite gripping, I'm travelling along, visiting good friends, 
and building a network for my (now) business, I'm going to work again.

Btw., when you've got linkedin, would be glad if you'd connect with me:
[linked.in](https://linked.in/in/michael-scondo)

Cheers, Michael


#### 2020/01/05

##### Happy new year everyone!

I better do not say, it can only get better - it could always be worse.

so. Just my best wishes to anyone.

Found a interesting reading about the state of software development 
written by Rob Pike, and dating back to the year 2000.

A quote: 
> Ironically, at a time when computing is almost the definition of innovation, research in both software and hardware at universities and much of industry is becoming insular, ossified, and irrelevant.


.. still true. Read on: [http://doc.cat-v.org/bell_labs/utah2000/utah2000.html](http://doc.cat-v.org/bell_labs/utah2000/utah2000.html)


Oh. Some further readings: [The Bell System Technical Journal 1922-1983](https://archive.org/details/bstj-archives)

---

oh. That's surprising. 
Unaligned memory access is way faster when aligned?? Am I reading wrong?
Or, if I get this right, the conclusion might be, don't use data structures, 
aligned and with a power of two. I'm still surprised.
Although this is somehow logical; when the data exactl would fit into a cache,
ever byte more will cause a cache miss. Why I sometimes used to set the size of structures to just a few bytes
below a power of two. Anyways. I learnd something new.
https://danluu.com/3c-conflict/

Compare here: 
- https://danluu.com/new-cpu-features/
- https://people.freebsd.org/~lstewart/articles/cpumemory.pdf
- this diskussion, Torvalds et al.. [https://groups.google.com/forum/#!msg/comp.arch/_uecSnSEQc4/mvfRnOvIyzUJ](https://groups.google.com/forum/#!msg/comp.arch/_uecSnSEQc4/mvfRnOvIyzUJ)




#### 2019/12/28

Just created a new project for a sort algorithm implementation, I'm calling bitsort.
It's a implementation, being in most cases about twice as fast as glibc qsort, for example.
(That's my claim, at least - have to reevaluate at the machines, I can get a grip on.
I did this implementation more than 10 years before)

I somehow guess, I should publish a quite nice compression algorithm as well - 
the decompressor implementation are three(!) lines of code, in the unoptimized version.




#### 2019/12/21

Well. There's an Austrian regisseur. Hader. Why the heck does he write my life??
That's to change.

However. In the "morning" I preferrably drink coffee. 4 cups. And let my thoughts free.
Today, I came upon an ineteresting question: You can regard programming as an Aristotelic approach of
getting grip of the world.
The whole object oriented approach can be seen as an Aristotelic conception.
Species, genre, individuum - classes, objects, instances. Andsoon.

So what would be a Platonic conception?

*I for myself say I'm a Platonician, furthermore, Aristoteles is read completely wrong. 
Besides we don't know which documents are really "written" by Aristoteles,
most writings are just compilations of fragments, sometimes someone did have the 
meaning this or that sentence could haven been written by Aristoteles -- 
I'd also say Aristoteles.. uh. That's going to be too lengthy. But my meaning to (the construction of) Aristoteles
would be, he's a Platonician - who didn't get Plato right.*

Back to software and Plato. Plato's conception of the world is mostly related to the ideas.
These, in turn, are somehow a paradox conception, being hard to understand.
They are in the world of the ideas, separated by our world, they are the being of itself.

However, they also are the essence of all things in our world.
All we understand, we just get the idea of it, not the thing itself.

So this also might be the Platonic approach of software development.

Instead of abstracting, differenciating (e.g. a button, which has the attribute of being clickable),
it's about the idea and the inner intent. 
So the button could be represented as an object, which is there to be clicked and initiate an action.
In which way the button is represented is secondary. 

I guess, we all use this conception, one could name "Platonic", without knowing it.

But when thinking about it - e.g. most UI libraries are obviously written with the Aristotelic approach.

Firstly, the visual representation of the Button is designed, and how it fits into the other elements of the UI.
Then, the possible attributes are implemented. The example given, being clickable.

However, I'd say, the visual representation is not the important aspect of a Button.
The important aspect is the intent, to be clickable, and .. 

I need more coffee. And better stop this writing for now.

..rereading - I've to rethink the beginning, cause when naming this approach "Platonic",
there's also a Platonic object oriented approach. What somehow negates my initial sentences.

So. I rethink. drink more coffee. And leave this entry, as it is. 
It's a blog and not a scientific publication.

... So. seems to me, what I tried to characterize as a Platonic conception of software development
overlaps in many points with the concept of Agile Software Development. [(Wikipedia: Agile Software Development)](https://en.wikipedia.org/wiki/Agile_software_development)

I push these thoughts onto my stack for now. 



#### 2019/12/20

... Two things to put on top: Get a linkedin account. And read a book. 


#### 2019/12/18

Somehow I got the feeling,
I should raise an old project/idea especially.

It's about sort algorithms. To be more exact, 
it's about howto sort and take most advantage of the cashelines/memory access/instruction set. 

I did this about ten years before, and also implemented the algorithm in Perl/C/Assembly.

The results are overall surprising.

- Firstly, my algorithm is in most cases about 50% faster than, e.g., gnu glibc sort(quicksort), but also faster than other approaches.
But I don't remember exactly, I should reinvestigate the results again..
- Although the algorithm utilizes a conquer and divide approach; for datasets below, say, 10 or 100MB,
parallelization doesn't give much of an advantage. The syncronization overhead is too expensive;
and I tried different techniques, also spinlocks / combined with XCHANGE (or so, it has been ten years ago).
- C is faster than perl, but not much. Even when optimized.
- Same for Assembly; Assembly is faster than C (gnu gcc), WHEN optimized right. 

I guess, the methodology of my algorithm has been overseen; simply,
cause normally you think in terms of complexity. Which isn't the same as efficiency.

Complexity is a heuristic approach, which is useful. 
But the other factors also have to be taken in account.

In computing terms, we simply do not have turing machines.
Instead, there are memory cashelines, instruction pipelines, jump predictions, 
parallel instruction processing, and so on.

While the compiler is very often suprisingly good in optimizing --
e.g. the choice of the algorithm as well as the prediction on the datasets (size,entropy,..) has to be done by humans(yet).

At which point my philosophical education could jump in, but I'm going to write
about my thoughts on the differences of humans and machines another time.


Somehow crazy, but I got the feeling, I should make clear I'm the discoverer of this sorting approach.
I'm still not sure, whether this algorithm really gives such an andvantage. Simply,
cause I'm not experienced in big data or mainframe computing. However,
well. My feelings. Sometimes I've got the feeling, I'd better close my eyes when walking around.
And should listen to my feelings. Cause when looking around, I'm going to surely stamp into every puddle
and piece of sxxx on my way.

I really do not know, what is happening these days. Somehow the people around me, well, are nervous.

And I'm looking for the reason, but I'm unable to find one.
Possibly, cause there's none. However, there's a slight possibilty, ~~xxxxx ..??~~
This also seems wrong. Possibly nothing is wrong, and I'm just looking for nothing;
which is quite hard to detect, logically. Dunno.

Which should be harder now. And it's just another guess of mine.
I simply don't know anything.


~~Happily, I'm not easy to infect with nervousity.~~
It's possibly more honest, I'm able to cope
with high tensions. I did freeclimbing for more than ten years, and there you've to learn to cope
with your fears. Not willingly you will get from time to time into real dangers. And when you are going to cramp,
cause you let the fear control your body, you'll drop. Which sometimes wouldn't be good at all.
But, at the moment, I'm still like WTF what is going on WTF. And everyone keeps suggesting me different directions.

Also remembering me onto freeclimbing.
Sometimes, people try cheering you to keep going.
Everyone reacts in another way on the cheering, 
so within your climbing group you normally know, what to yell, when someone fights with his route.

Which is quite funny. One has to be insulted, like "UUhh you'll never do it, looser", and so on.
The other has to be praised and lauded, that she's a great climber, did really well, she's looking wonderful,..
Me responding best to positive suggestions.

Worst thing however in all cases might be, when people yell contradicting instructions.
That's like -- right? left?? eh, what?? -- even worse, you'll get into thinking. Which is not what you have the time for,
when climbing at your limit. The conclusions might show up more detailed in these "extreme" situations.
But should be applicable in normal life as well. 

And there's the experience, I possibly should heed on now. 
Whatever you do, keep climbing. If you're in the wrong direction, you'll possibly drop.
But when you stand still, you'll drop for sure, since your strengths cannot hold on forever.
So better keep climbing. 

