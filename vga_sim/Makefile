SOURCES = main.cpp 
TOP_MODULE:=$(shell awk -F'"' '/top_module:/ {print $$2}' ../info.yaml)
VERILOG_SOURCES:=$(shell sed -n 's/.*- "\(.*\)".*/..\/src\/\1/p'  ../info.yaml | xargs)
OBJ_DIR:=obj_dir
LANGUAGE:=--default-language 1364-2005 

#VFLAGS = -Wall -Wpedantic $(LANGUAGE) --x-assign fast --x-initial fast --noassert --top-module $(TOP_MODULE)
VFLAGS = $(LANGUAGE) --x-assign fast --x-initial fast --noassert --top-module $(TOP_MODULE)
CFLAGS = -flto -O3 -march=native -DTOP_MODULE=V$(TOP_MODULE) -I$(OBJ_DIR) -I/usr/share/verilator/include -include V$(TOP_MODULE).h
LDFLAGS = -flto -lSDL2

all: $(OBJ_DIR)/V$(TOP_MODULE).h
	make -C $(OBJ_DIR) -f V$(TOP_MODULE).mk

$(OBJ_DIR)/V$(TOP_MODULE).h: $(VERILOG_SOURCES) $(SOURCES)
	verilator $(VFLAGS) --cc $(VERILOG_SOURCES) --exe $(SOURCES) -CFLAGS "$(CFLAGS)" -LDFLAGS "$(LDFLAGS)"

lint: $(VERILOG_SOURCES)
	verilator --lint-only $(VFLAGS) $(VERILOG_SOURCES)

sim: all
	$(OBJ_DIR)/V$(TOP_MODULE)

gif: all
	$(OBJ_DIR)/V$(TOP_MODULE) --gif 1024

clean:
	rm -rf $(OBJ_DIR)
	rm -f output.gif

distclean: clean

.PHONY: all lint sim gif clean distclean
