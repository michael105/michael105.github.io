{% include_relative header.md %}

## Blog

---

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



#### 2019/12/10

Looking through old projects I did, 
to show them here.
The best references one can have might be the accomplished works.
Although for some things I'd choose a completely different approach,
but this also shows my development. 
Pascal, e.g., I'd consider as mostly academic language nowadays.
The concepts of the language are still useful, but I'd say only in special contexts;
especially in resource restricted environments. When trying to squeeze a program into a few kB,
a functional programming style has its advantages. But this would be a lengthy discussion,
and might offend the objectivists, so I better don't claim a functional programming style
has its advantages...


Changing theme fastly, there's a big advantage in Informatics - the bitentropy is annoying,
and some work I did and saved on 5.1/4 discettes might be lost.
But many things are still there, into some programs I invested hundred of work hours,
but you can store all this much work essentially on your smartphone.

Other things can be kept only in remedy, for example paintings or crafted works;
software you can carry with you in your pocket.




#### 2019/12/7

Didn't know there is the possiblity to include other files from within Github markup.
That's handy for the sitemap, for example.
And most possibly I'm also going to switch over to another blogging methodology,
building up on includes.
So I'm about to rewrite some parts. 

And I still have to recollect parts of websites, I did earlier.
Republishing useful information here, the kidding things I guess I should publish somewhere else..



#### 2019/12/04 

Working at these pages.<br>
Mainly for the presentation of myself.<br>
michaNNN@protonmail.com, replace NNN with 105

<hr>

Addendum: I somehow have the feeling, I should (again) make clear, misc Myer is a Pseudonym.
Which I use for several reasons, mainly, since I've to separate my identities.
The public image of, uhm, michael1 would be severely damaged, when michael2 would get connected.
And I've worked as ethic's teacher with young people, what in turn gives a reason to separate michael1 and michael3.
You can reach me with the given email in any case, and for business I also use my real name.
Besides, nics and Pseudonyms are quite usual in the opensource scene. My feeling to show this up explicitely seems unusual to me.
Anyways. Just for case.
