{% include_relative header.md %}

## Blog

---


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
