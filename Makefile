LIBDLGMOD := $(shell chmod u+x Widget_Systems/Native/libdlgmod/build-cc.sh)
LIBDLGMOD += $(shell Widget_Systems/Native/libdlgmod/build-cc.sh 2> /dev/null)
SOURCES += Widget_Systems/Native/dialogs.cpp
override CFLAGS += -DUSE_SDL_POLLEVENT -DUSE_SDL2_POLLEVENT -DUSE_SDL3_POLLEVENT
override CXXFLAGS += -DUSE_SDL_POLLEVENT -DUSE_SDL2_POLLEVENT -DUSE_SDL3_POLLEVENT
override LDFLAGS += Widget_Systems/Native/libdlgmod/libdlgmod-cc.a
override LDLIBS += Widget_Systems/Native/libdlgmod/libdlgmod-cc.a
ifeq ($(UNIX_BASED), true)
	ifeq ($(OS), Darwin)
		override LDFLAGS += -framework AppKit -framework UniformTypeIdentifiers 
		override LDLIBS += -framework AppKit -framework UniformTypeIdentifiers
	else
		ifeq ($(OS), Linux)
			override LDFLAGS += -lX11 -lpthread
			override LDLIBS += -lX11 -lpthread
		else
			override LDFLAGS += -lX11 -lpthread -lc -lkvm
			override LDLIBS += -lX11 -lpthread -lc -lkvm
		endif
	endif
else
	override LDFLAGS += -lntdll -lgdiplus -lcomctl32 -lshlwapi -lcomdlg32 -lole32 -loleaut32 -luuid
	override LDLIBS += -lntdll -lgdiplus -lcomctl32 -lshlwapi -lcomdlg32 -lole32 -loleaut32 -luuid
endif
