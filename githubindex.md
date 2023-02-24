{% include_relative header.md %}


#### About the projects

Here's a short introduction for nontech-people, 
where I try to put some information into a few sentences.

The current project in my focus is minilib, a C system singlefile headeronly librarie.
This project is quite big and has some unique features.
It's more than 800.000 lines (find * -exec cat {} \; | wc -l ),
counting all files; counting the source files only it's more than 35.000 loc's


Despite the size, the whole project is about resource saving.
A "hello world", the favour example program, just printing "Hello, World!" at the terminal,
compiles to 181 bytes at a x64 architecture.
That's only fractions of the same program, compiled and linked with the standard GNU libc: 504kB.

Aside of the resource usage, there's the point of security.
Only the parts of minilib are going to be compiled, which are used.
And it's not only theoretical reading these parts.

Just compile with 'mini-gcc -E sourcefile.c | less',
and the relevant code parts will be dumped.

Reports of vulnerabilities welcome.

Having full ANSI-C compatibility is close.
POSIX-C is supported to around 70%.



----

The other projects, I put here at gihub, are mainly related to terminal applications,
and also about resource usage. ( st-asc, et, readkey )

There are also some libraries, written in perl, C or cpp (my "native languages");
which are about parallel programming, web interface templating, database interfaces,
webscraping or data processing.

They aren't presented on it's own, however; instead they are "hidden" within the repo tools,
and spread in some other repos: bitsort, zcomp, home, andson.
(Have to put the better libs up on their own, but there's so much at my harddisks, 
this will take some time)

My bigger projects are only partial online: ksalomon (ksalomon.sf.net),
a vocabulary trainer, I built 2000-2003; wxPDF, a PDF reader built for reading big sized scans of books 
(handles without problems files>100MB); pgroupware, a Groupware solution.




----

{% gist 8481222f07035e568d774c4d6e0b51ef %}
