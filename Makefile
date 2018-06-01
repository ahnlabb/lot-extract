.PHONY : page clean reactor db

page: index.html

db: lot.db

site/SiteData.elm: site/generate.py site/SiteData.template.elm lot.db
	python3 site/generate.py ./lot.db ./site/SiteData.template.elm -o ./site/SiteData.elm

index.html: site/SiteData.elm site/Main.elm site/style.css
	yarn webpack

reactor: site/Main.elm site/SiteData.elm
	cd site && elm reactor

lot.db:
	python3 extract.py create
	python3 extract.py ceq

clean:
	rm -f site/TableData.elm
	rm -f lot.db
