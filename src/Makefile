define package/logopanel/configure
	PKG_SOURCE_DIR:=$(PROJECT_TOP_DIR)/src/logopanel
endef

$(eval $(call DefinePackage,logopanel))

define package/firmware/configure
	PKG_SOURCE_DIR:=$(SRC_TOP_DIR)/bossinit
	PKG_VERSION:=1.0
	PKG_DEPENDS:=libfirmware libdriver logopanel
endef

define package/firmware/logopanel/configure
	PKG_CONFIGURE_OPTIONS:=\
		--with-target=stm32f10x\
		--with-devicetree=$(PWD)/dts/ledpanel.dts\
		--with-drivers="-Wl,-u,logopanel_ko,-u,ledpanel_ko,-u,console_ko"\
		--with-libs=-llogopanel
endef


$(eval $(call DefinePackage,firmware))

package/firmware/logopanel/flash: package/firmware/logopanel/compile
	$(TARGET_TOOL_PREFIX)objcopy -O binary $(BUILD_DIR)/$(TARGET)/firmware/src/theboss $(BUILD_DIR)/$(TARGET)/firmware/theboss.bin
	$(TARGET_TOOL_PREFIX)objdump -t $(BUILD_DIR)/$(TARGET)/firmware/src/theboss | grep -v "ABS\|00000000" | awk '{print $$4 " " $$5 " " $$6}' | grep  "^\." | sort -r -k 1 | less > logopanel.syms
	$(TARGET_TOOL_PREFIX)size $(BUILD_DIR)/$(TARGET)/firmware/src/theboss
	stm32flash -w $(BUILD_DIR)/$(TARGET)/firmware/theboss.bin -b 115200 -v -g 0x0 /dev/ttyUSB0

package/firmware/logopanel/flash-stlink: package/firmware/logopanel/compile
	$(TARGET_TOOL_PREFIX)objcopy -O binary $(BUILD_DIR)/$(TARGET)/firmware/src/theboss $(BUILD_DIR)/$(TARGET)/firmware/theboss.bin
	$(TARGET_TOOL_PREFIX)objdump -t $(BUILD_DIR)/$(TARGET)/firmware/src/theboss | grep -v "ABS\|00000000" | awk '{print $$4 " " $$5 " " $$6}' | grep  "^\." | sort -r -k 1 | less > logopanel.syms
	$(TARGET_TOOL_PREFIX)size $(BUILD_DIR)/$(TARGET)/firmware/src/theboss
	#openocd -f interface/stlink-v2.cfg -f target/stm32f4x.cfg -c "program $(BUILD_DIR)/$(TARGET)/firmware/src/theboss verify reset";
	st-flash --reset write $(BUILD_DIR)/$(TARGET)/firmware/theboss.bin 0x8000000


