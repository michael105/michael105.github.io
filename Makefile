

pages := $(patsubst %.md.in,build/%.md,$(wildcard *.md.in))
htmlpages := $(patsubst %.md,%.html,$(wildcard *.md))


html: $(htmlpages)

.ONESHELL:

%.html: %.md generate/global.css.inc generate/header.inc generate/footer.inc
	cp generate/header.inc $@
	cpconv utf8 < $< | lowdown --html-no-skiphtml --html-no-escapehtml \
		 >> $@
	cat generate/footer.inc >> $@
	title=`sed -nE '/\#\#/{p;q}' $< | sed -e 's/#* *//'`
	@echo $$title
	echo sed -ei \""s/\\[TITLE]/$$title/"\" $@
	sed -ie "s/\\[TITLE]/$$title/" $@





all: guest up

allpages: $(pages)

build/%.md: %.md.in *.inc
	./scripts/makesite.pl $< > build/tmp.mdx  #| sed -E 'sx<<(.*)>>x<a href="\1">\1</a>xg' > tmp.md
	./scripts/sed.sh build/tmp.mdx > $@
# sed -e '/^ ../,/^$/{H;d};/^$/{x;s/^..*/<pre>&<\/pre>/}' tmp.md > $@

	
up: html
	git commit -a -m `date +%Y/%M/%d` 
	git push 


#up: allpages
#	( git commit -a -m 'Update' $(gitflag) && git push $(gitflag)) || true


verbose:
	$(MAKE) --debug=b gitflag=-v $(MAKEFLAGS)



# make the page and serve it on port 3000
servesite:
	while true; do make; (echo -e "HTTP/1.1 200 OK\n\n";cat ./index.html; ) | nc -l -p 3000 -w 1; done



thttpd:
	thttpd -c "*.html" -p 3000 -d ./thttpd/

stop_thttpd:
	killall thttpd

.PHONY: thttpd stop_thttpd

