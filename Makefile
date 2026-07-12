LIBDLGMOD := $(shell cd libdlgmod && make && cd ..)
SOURCES += Widget_Systems/Native/dialogs.cpp
override LDFLAGS += libdlgmod/libdlgmod.a
override LDLIBS += libdlgmod/libdlgmod.a
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
else
	override LDFLAGS += -lntdll -lgdiplus -lcomctl32 -lshlwapi -lcomdlg32 -lole32 -loleaut32 -luuid
	override LDLIBS += -lntdll -lgdiplus -lcomctl32 -lshlwapi -lcomdlg32 -lole32 -loleaut32 -luuid
endif
