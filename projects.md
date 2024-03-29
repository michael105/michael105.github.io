{% include_relative header.md %}


#### Old Projects

`Some projects I'd like to highlight.
Some of them are just ideas, others I've finished.`



##### logik.pl



A perl script, I wrote in 2006/2007.

It's a brute force attack to the riddles of the german magazine "PM".
I guess, I had been annoyed by not being able to solve them myself.

I just put the source online, it's commented in german, and untidied.
The abstraction route I went down is quite funny. 
Some constructs, you can do only in perl.
Arrays of functors, closures, "virtual virtualization", I don't know how to call this.
Might be only of interest for people, who do know perl.

Just one explanation, it is possible in perl, to create (also virtual) closures on the fly,
globally available. 
It is possible to ignore usual concepts of abstraction.
it is possible to shoot into your own foot, as well.
Imho this has not so much to do with restrictions of the language, however.
The source might be more lacking selfdiscipline, sometimes you realize,
this or that idea hasn't been that great - but you don't like to, or maybe
aren't able cause of time restrictions, to correct the clumsy approach.


I applied some rules of the analytical philosphy, did study "Erlanger Konstruktivismus" 
in Erlangen back then, and wrote a recursive brute force attack.

..Some riddles did take quite some time to solve.

[./logik.pl.html](logik.pl.html)


One of these riddles, I wrote the script for, is here: [Chaos Firma in Sibirien](https://philognosie.net/denken-lernen/witziger-logiktrainer-chaos-firma-in-sibirien)(German)

Now, using the script for the solution is an new problem.
These formalizations sometimes are a bit quirky.

However, I did have been satisifed, after I've had been able to solve several riddles with the script,
so I didn't try to make the usage easier at all.



-----


##### Perlgroupware

The most successfull project has been a groupware project (erp,pms,crm) I did 2005-2006. 
A customer told me ten years later, around 2015, the project would still be 
the exceptional best solution for his branch of industry.

I essentially had the idea of cloud software, before clouds existed.
The project is a big perl project, round about 60,000 lines of code (80,000 when counting also templates, comments, sql, andsoon),
which serve as interface between database and the webinterface.

I did choose this design, because I was sure html would be a future-proof and versatile way to present generic data.
Which showed up true. 

Perl in turn is a very dynamic language, there nearly aren't any restrictions.
The fact the whole project started to shrink in loc's at some point gave me the confirmation,,
I implemented some object oriented concept's the right (partly unusual) way. 

Perl also is a quite performant language, the groupware could serve several thousand concurrent users in my estimation,
running on my old notebook.


Some later research on sort algorithms gave me the same results about perl's performance, 
even Assembly hardly gave more of an advantage than 30 percent.
What is quite surprising, and I optimized my assembly hardly and consequently processor and system specific.

Memo to me, setup the script on a webserver.


I developed the software in close cooperation with a pendently construction industry company,
also giving trainings to the employees. 

The reason to put the project aside might have been some familie calamities and disturbances;
although I was already within negotiations with big companies, I abandoned the project and 
started a study generalis, in order to break my personal limits.

Of all the subjects I did within two years of doing a study generalis (e.g. Archaeology, Sinology, History, Psychology, Sociology, even Tibetan)
I decided me towards a study of Philosophy. Which I did for the next 6 years, finishing with the degree "Magister Artium"(Master of Arts).


The studies might have been a mistake judging financially, instead of selling my software I now had to spare every penny.
(I once adapted and licensed my software to a customer of another business, but this costed me overall half a year,
and I could live of the money earned only for one year overall, so I favored my studies in consequence)
But this "mistake" I'd do again, Philosophy gave me more than all the money could have.

After all- a neighboured farmer, who also raised me up, when I was child, told me when I did see him the last time 
before he died (And in retrospective, he knew he'd die within a few months, you could see it in his eyes):
You cannot take anything with you onto your last journey.

What is absolutely true.

However, what might give the appearance of being paradox, developing software is to me a release of thinking about, well,
the big questions in life and all the other struggles.. 
Instead of questioning the reason of life, or which dynamics lead to the influence of one theory, abandoning the other;
You can simply say it works, or it doesn't. Even usability in terms of being accepted, or denied by the users can be reduced into quite simple 
questions and answers.

----

Since I got into some sort of trouble - na, the value of the software might be now about 0.
It's nearly 20 years old, written in a abandoned language, and there are some - quirks.

There wasn't any need for security, I just did need to separate internet and
intranet. So. There are some fundamental design "flaws".
In the company, my "solution" was easy, and save. Physically changing a backup harddisk each day,
and doing incremental backups. 
IF there would have been a problem, it would had been easy to track it back.
It didn't happen. Albite a lacking rights management, amongst others.
But the few users did know as well, their actions were protocolled.
So. 


And there are other companies, which nowadays do have more than competitive solutions.
Using my software wouldn't pay out.

I would estimate an effort of at least half a year fulltime, if I would try to make the software
competitive. But I'm also calculating with 80hours per week, and I'm quite productive.

So - the value at the market is 0. Now.

Back then, it's been an exclusive solution.
But I'm also happy I decided to study philosophy, instead of going at the market.









----






