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
LIB_FLAGS = $(foreach lib,$(LIBS) -l$(lib))

OBJS = $(MAIN).o
OBJS += $(foreach file,$(PLUGINS), $(file).o)

CXXFLAGS := -O2
CXXFLAGS += $(INCLUDE_FLAGS)

CPP = g++
C = gcc
MAKE = make
LD = ld
AR = ar

TARGET = MetroidPrime
VERSION = us
PLATFORM = windows
EXECUTABLE = $(TARGET)
ifeq ($(PLATFORM), windows)
    EXECUTABLE += .exe

$(MAIN).o:$(MAIN_PATH)
	$(CXX) $(CXXFLAGS) -c -o $@ $<
%.o:$(PLUGIN_PATH)/*/%.cpp
    $(CXX) $(CXXFLAGS) -c -o $@ $<
%.o:%.cpp
    $(CXX) $(CXXFLAGS) -c -o $@ $<
$(EXECUTABLE):$(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LIB_FLAGS)
    

