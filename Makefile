all:
	make -C theboss PROJECT=$(PWD) package/firmware/logopanel/compile

logopanel.csv:
	sh update_symbols.sh theboss/build_dir/logopanel/firmware/src/theboss

logopanel:
	make -C theboss PROJECT=$(PWD) package/firmware/logopanel/compile
	make logopanel.csv

logopanel-flash:
	make -C theboss PROJECT=$(PWD) package/firmware/logopanel/flash-stlink

tags:
	rm -f tags
	ctags --exclude=*staging_dir* -R .

.PHONY: tags logopanel.csv
