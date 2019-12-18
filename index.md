{% include_relative header.md %}

## Blog

---


#### 2019/12/18

Somehow I got the feeling,
I should raise an old project/idea especially.

It's about sort algorithms. To be more exact, 
it's about howto sort and take most advantage of the cashelines/memory access/instruction set. 

I did this about ten years before, and also implemented the algorithm in Perl/C/Assembly.

The results are overall surprising.

-Firstly, my algorithm is in most cases about 50% faster than, e.g., gnu glibc sort.
-Although my algorithm utilizes a conquer and divide approach; for datasets below, say, 10MB,
parallelization doesn't give much of an advantage. The syncronization overhead is to expensive;
and I tried different techniques, also spinlocks / combined with XCHANGE (or so, it has been ten years ago).
-C is faster than perl, but not much. Even when optimized.
-Same for Assembly; Assembly is faster than C (gnu gcc), WHEN optimized right. 

I guess, the methodology of my algorithm has been overseen; simply,
cause normally you think in terms of complexity. Which isn't the same as efficiency.

Complexity is a heuristic approach, which is useful. 
But the other factors also have to be taken in account.

In computing terms, we simply do not have turing machines.
Instead, there are memory casheline, instruction pipelines, jump predictions, 
parallel instruction processing, and so on.

While the compiler is very often suprisingly good in optimizing,
e.g. the choice of the algorithm as well as the prediction on the datasets (size,entropy,..) has to be done by humans(yet).

At which point my philosophical education could jump in, but I'm going to write
about my thoughts on the differences of humans and machines another time.


Somehow crazy, but I got the feeling, I should make clear I'm the discoverer of this sorting approach.
I'm still not sure, whether this algorithm really gives such an andvantage. Simply,
cause I'm not experienced in big data or mainframe computing. However,
well. My feelings. Sometimes I've got the feeling, I'd better close my eyes when walking around.
And should listen to my feelings.

I really do not know, what is happening these days. Somehow the people around me, well, are nervous.
And I'm looking for the reason, but I'm unable to find one.
Possibly, cause there's none. However, there's a slight possibilty, someone else I've told about this 
discovery of me would like to take advantage.

Which should be harder now. And it's just another guess of mine.
I simply don't know nothing.


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

Writing this website.<br>
Mainly for the presentation of myself, since I'm now open for new assignments.<br>
;) If you'd like to hire me, hurry up and send me a proposal.<br>
michaNNN@protonmail.com, replace NNN with 105

