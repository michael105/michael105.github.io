

#### Projects






##### logik.pl



A perl script, I wrote in 2006/2007, quickly hacked together.

It's a brute force attack to the riddles of the german magazine "PM".
I remember, I was annoyed of not being able to solve them myself.

I just put the source online, it's commented in german, and untidied.
The abstraction route I went down is quite funny. 
Some constructs, you can do only in perl.
Arrays of functors, closures, "virtual virtualization", I don't know how to call this.
Might be only of interest for people, who do know perl.

Just one note, it is possible in perl, to create (also virtual) closures on the fly,
globally available. 
It is possible to ignore usual concepts of abstraction.
it is possible to shoot into your own foot, as well.
Imho this has not so much to do with restrictions of a language, however.
The cause might be more lacking selfdiscipline, sometimes you realize,
this or that idea hasn't been that great - but you don't like to, or maybe
aren't able cause of time restrictions, to correct the clumsy approach.


I applied some rules of the analytical philosophy, did study "Erlanger Konstruktivismus" 
in Erlangen back then, and wrote a recursive brute force attack.

..Some riddles did take quite some time to solve.

[./logik.pl.html](logik.pl.html)


One of those riddles, I wrote the script for, is here: [Chaos Firma in Sibirien](https://philognosie.net/denken-lernen/witziger-logiktrainer-chaos-firma-in-sibirien)(German)

Now, using the script for the solution is a new problem.
Those formalizations sometimes are a bit quirky.

However, I was satisifed back then, after I've had been able to solve several riddles with the script,
so I didn't try to make the usage easier at all.



-----


##### totp


A totp token generator for the terminal.

I did choose a more 'serious' approach. 


Most opensource projects online I did either just for fun, 
or they aren't really finished, therefore lacking documentation.

totp I'm using myself for several years now.

It solves the problem of the need to have a correct system time
by syncronizing the time of the tokens via sntp to a network time server.
The token of the next timestep is displayed as well, no need anymore to estimate whether
it is possible to enter the token within 5 seconds, or better wait.
The tokens can be displayed via dzen as a small overlay for xorg.


(https://github.com/michael105/totp)






----






