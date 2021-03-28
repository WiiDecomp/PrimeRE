.PHONY: all tempdirs clean

USE_MODS = yes

# These should be configurable
PLUGIN_PATH ?= plugins
BUILT_PLUGIN_PATH = $(PLUGIN_PATH)/built
PLUGINS ?= 
ifeq ($(USE_MODS), yes)
	PLUGINS += mpmodcore

SOURCE_DIR = .
MAIN = main
MAIN_PATH = $(SOURCE_DIR)/$(MAIN).cpp

INCLUDES = include
INCLUDE_FLAGS = $(foreach dir,$(INCLUDES), -I$(dir))

LIB_DIR = lib
LIBS = 
LIB_FLAGS = $(foreach lib,$(LIBS), -l$(lib))

BUILD_TEMP = build

OBJS = $(BUILD_TEMP)/$(MAIN).o
OBJS += $(foreach file,$(PLUGINS), $(BUILT_PLUGIN_PATH)/$(file).o)

CXXFLAGS := -O2 -std=gnu++20 -fpermissive -Wfatal-errors
CXXFLAGS += $(INCLUDE_FLAGS)
ifeq ($(USE_MODS), yes)
	CXXFLAGS += -D__OPT_PLUGINS_ON__ --allow-multiple-definition

CPP = g++
C = gcc
MAKE = make
LD = ld
AR = ar

TARGET ?= MetroidPrime
VERSION ?= us
PLATFORM ?= Windows
EXECUTABLE ?= $(TARGET).$(PLATFORM)
DEBUG = no
ifeq ($(PLATFORM), Windows)
	EXECUTABLE = $(TARGET).$(PLATFORM).exe
endif
tempdirs:
	@echo Creating build temp...
	mkdir -p $(BUILD_TEMP) $(BUILT_PLUGIN_PATH)
$(BUILD_TEMP)/$(MAIN).o:$(MAIN_PATH)
	$(CXX) $(CXXFLAGS) -c -o $@ $<
$(BUILT_PLUGIN_PATH)/%.o:$(PLUGIN_PATH)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<
$(BUILD_TEMP)/%.o:%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<
$(TARGET) $(EXECUTABLE):$(OBJS) | tempdirs
	$(CXX) -o $(EXECUTABLE) $^ $(CXXFLAGS) $(LIB_FLAGS)
all:$(EXECUTABLE)
	@echo Building $(EXECUTABLE)
build:$(EXECUTABLE)
	@echo
clean:
	rm $(EXECUTABLE)
	rm -rf $(BUILD_TEMP) $(BUILT_PLUGIN_PATH)
