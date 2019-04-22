define target/logopanel/configure
    $(eval $(call target/stm32f10x/configure))
	TARGET_CFLAGS+=-DHSE_VALUE=8000000
endef

$(eval $(call DefineTarget,logopanel))


