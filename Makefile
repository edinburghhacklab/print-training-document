.PHONY: print status

COPIES:=1
FILE:=
NAME:=$(shell echo -n "$FILE" | sha1sum - | awk '{print $$1}')
URI:=ipp://laserjet.hacklab/printers/laserjet

print: $(NAME).ps
	ipptool -v -d filename=$< -d copies=$(COPIES) $(URI) print-job-a4.ipp

$(NAME).ps: $(NAME).pdf
	pdf2ps $< $@

$(NAME).pdf: FORCE
	mkdir -p -- "tmp/$(dir $(FILE))"
	wget -N "https://edinburghhacklab.github.io/hacklab-training/syllabuses/$(FILE).pdf" -P "tmp/$(dir $(FILE))"
	cmp "tmp/$(FILE).pdf" $@ || cp -a "tmp/$(FILE).pdf" $@

FORCE:
