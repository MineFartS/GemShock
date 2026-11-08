
PLATFORM?=linux64-debug

.PHONY: all

# ====================================================================
# Platform Specific C/C++ Flags

ifeq ($(PLATFORM), linux64-debug) #==================

	EXEC_EXTENSION=-debug

	LIB_EXTENSION=-debug.so
	LIB_EXTENSION_STATIC=(null)

	RAYLIB_DLL=-lraylib

	CFLAGS+=\
		-g \
		-D DEBUG \
		-D EXEC_EXTENSION=\"-debug\" \
		-D LIB_EXTENSION=\"-debug.so\"

	LDFLAGS+=-rdynamic

endif # =============================================

ifeq ($(PLATFORM), win64) # =========================

	EXEC_EXTENSION=.exe

	LIB_EXTENSION=.dll
	LIB_EXTENSION_STATIC=(null)

	SHELL=sh.exe

	RAYLIB_DLL=-lraylibdll

	CFLAGS+=\
		-O2 \
		-D RELEASE \
		-D EXEC_EXTENSION=\".exe\" \
		-D LIB_EXTENSION=\".dll\"

	LDFLAGS+=\
		-lws2_32 \
		-static-libstdc++ \
		-static-libgcc

endif # =============================================

# ====================================================================
# LDFLAGS

LDFLAGS+=\
	-Llib/libcurl-$(PLATFORM)/lib \
	-lcurl \
	-Wl,-rpath,lib/libcurl-$(PLATFORM)/lib \
	-lm \
	-Llib/raylib5.5-$(PLATFORM)/lib \
	$(RAYLIB_DLL) \
	-Wl,-rpath,lib/raylib5.5-$(PLATFORM)/lib \
	lib/luau/build/release/libluau.a \
	-lstdc++

# ====================================================================
# all (func)

all: build \
	build/src \
	build/src/luau \
	build/lib/cJSON/src \
	build/src/filetypes build/lib/xml/src \
	build/lib/lz4/src \
	build/lib/zstd/src \
	build/studio/classes \
	build/studio \
	build/studio$(EXEC_EXTENSION) \
	build/player$(EXEC_EXTENSION) \
	deps

# ====================================================================
# Mk Build Dirs

DIRS := \
	build/src \
	build/src/luau \
	build/lib/cJSON/src \
	build/src/filetypes \
	build/lib/xml/src \
	build/lib/lz4/src \
	build/lib/zstd/src \
	build/studio/classes \
	build/studio \
	build/player \
	build
$(DIRS):
	mkdir -p $@

# ====================================================================
# CFLAGS

CFLAGS+=\
	-Ilib/libcurl-$(PLATFORM)/include \
	-Isrc \
	-Iinclude \
	-Ilib/xml/src \
	-Ilib/xml/include \
	-Ilib/lz4/src \
	-Ilib/lz4/include \
	-Ilib/cJSON/src \
	-Ilib/cJSON/include \
	-Ilib/mini_gzip/src \
	-Ilib/mini_gzip/include \
	-Ilib/zstd/src \
	-Ilib/zstd/include \
	-D PLATFORM=\"$(PLATFORM)\" \
	-Ilib/luau/VM/include \
	-Ilib/luau/Compiler/include \
	-Ilib/luau/Common/include \
	-Ilib/luau/Ast/include \
	-Ilib/luau/VM/src \
	-Ilib/raylib5.5-$(PLATFORM)/include

# ====================================================================
# luau_CXX_SOURCES

luau_CXX_SOURCES+=\
	build/src/datamodel.o \
	build/src/instance.o \
	build/src/rbxscriptsignal.o \
	build/src/workspace.o \
	build/src/serviceprovider.o \
	build/src/rootinstance.o \
	build/src/model.o \
	build/src/pvinstance.o \
	build/src/trusspart.o \
	build/src/basepart.o \
	build/src/part.o \
	build/src/formfactorpart.o \
	build/src/camera.o \
	build/src/brickcolor.o \
	build/src/meshcontentprovider.o \
	build/src/cacheablecontentprovider.o \
	build/src/physicalcharacter.o \
	build/src/lighting.o \
	build/src/wedgepart.o \
	build/src/valuebase.o \
	build/src/vector3value.o \
	build/src/cylindermesh.o \
	build/src/bevelmesh.o \
	build/src/datamodelmesh.o \
	build/src/runservice.o \
	build/src/serverscriptservice.o \
	build/src/luasourcecontainer.o \
	build/src/basescript.o \
	build/src/script.o \
	build/src/specialmesh.o \
	build/src/filemesh.o \
	build/src/decal.o \
	build/src/faceinstance.o \
	build/lib/cJSON/src/cJSON.o \
	build/src/httpservice.o \
	build/src/numbervalue.o \
	build/src/folder.o \
	build/src/trianglemeshpart.o \
	build/src/meshpart.o \
	build/src/texturecontentprovider.o \
	build/src/players.o \
	build/src/player.o \
	build/src/stringvalue.o \
	build/src/spawnlocation.o \
	build/src/modulescript.o \
	build/src/localscript.o \
	build/src/starterplayerscripts.o \
	build/src/starterplayer.o \
	build/src/playerscripts.o \
	build/src/accessory.o \
	build/src/accoutrement.o \
	build/src/startercharacterscripts.o \
	build/src/testservice.o \
	build/src/localizationtable.o \
	build/src/plugin.o \
	build/src/baseplayergui.o \
	build/src/coregui.o \
	build/src/collectionservice.o \
	build/src/textservice.o \
	build/src/guiservice.o \
	build/src/rbxanalyticsservice.o \
	build/src/contentprovider.o \
	build/src/stylebase.o \
	build/src/stylerule.o \
	build/src/stylingservice.o \
	build/src/tweenservice.o \
	build/src/genericsettings.o \
	build/src/globalsettings.o \
	build/src/studiowidgetsservice.o \
	build/src/startpageservice.o \
	build/src/studiouserservice.o \
	build/src/messagebusservice.o \
	build/src/guibase.o \
	build/src/guibase2d.o \
	build/src/guiobject.o \
	build/src/frame.o \
	build/src/studio.o \
	build/src/standalonepluginscripts.o \
	build/src/boolvalue.o \
	build/src/studiotheme.o \
	build/src/stylesheet.o \
	build/src/mouse.o \
	build/src/pluginmouse.o \
	build/src/humanoid.o \
	build/src/localizationservice.o \
	build/src/userinputservice.o \
	build/src/translator.o \
	build/src/renderer.o \
	build/src/scriptruntime.o \
	build/src/luau/disassembler.o \
	build/src/luau/cframe.o \
	build/src/luau/color3.o \
	build/src/luau/dockwidgetpluginguiinfo.o \
	build/src/luau/enum.o \
	build/src/luau/event.o \
	build/src/luau/globals.o \
	build/src/luau/instance.o \
	build/src/luau/rect.o \
	build/src/luau/serialize.o \
	build/src/luau/state.o \
	build/src/luau/tweeninfo.o \
	build/src/luau/udim2.o \
	build/src/luau/udim.o \
	build/src/luau/vector2.o \
	build/src/luau/vector3.o \
	build/src/luau/numbersequence.o \
	build/src/luau/font.o \
	build/src/luau/path2dcontrolpoint.o \
	build/src/luau/numberrange.o \
	build/src/luau/colorsequence.o \
	build/src/luau/brickcolor.o \
	build/src/filetypes/rbxlx.o \
	build/src/filetypes/rbxmx.o \
	build/lib/xml/src/xml.o \
	build/src/filetypes/rbxm.o \
	build/lib/lz4/src/lz4.o \
	build/lib/zstd/src/zstd_decompress.o

# ====================================================================
# Build C

build/%.o: %.c
	gcc -c $^ $(CFLAGS) \
		-Wno-discarded-qualifiers \
		-Wno-incompatible-pointer-types \
		-o $@

# ====================================================================
# Build C++

build/%.o: %.cpp
	g++ -c $^ $(CFLAGS) \
		-DLUA_API='extern "C"' \
		-DLUACODE_API='extern "C"' \
		-Wno-attributes \
		-o $@

# ====================================================================
# Build Studio

build/studio$(EXEC_EXTENSION): \
	build/studio/studio.o \
	build/studio/classes/studioservice.o \
	build/studio/classes/corepackages.o \
	build/studio/classes/changehistoryservice.o \
	$(luau_CXX_SOURCES)
	gcc -o $@ $^ $(LDFLAGS)

# ====================================================================
# Build Player

build/player$(EXEC_EXTENSION): \
	build/player/player.o \
	build/src/filetypes/rbxs.o \
	$(luau_CXX_SOURCES)
	gcc -o $@ $^ $(LDFLAGS)

# ====================================================================

