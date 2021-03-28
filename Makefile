.PHONY: all tempdirs clean
PLUGIN_PATH = plugins
BUILT_PLUGIN_PATH = $(PLUGIN_PATH)/built
PLUGINS = mpmodcore

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

CXXFLAGS := -O2 -std=gnu++20
CXXFLAGS += $(INCLUDE_FLAGS)

CPP = g++
C = gcc
MAKE = make
LD = ld
AR = ar

TARGET = MetroidPrime
VERSION = us
PLATFORM = Windows
EXECUTABLE = $(TARGET).$(PLATFORM)
DEBUG := no
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
build:all
	@echo
clean:
	rm $(EXECUTABLE)
	rm -rf $(BUILD_TEMP) $(BUILT_PLUGIN_PATH)