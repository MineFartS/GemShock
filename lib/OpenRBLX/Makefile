
PLATFORM?=linux64-debug

.PHONY: all

RAYLIB_NAME=raylib5.5-$(PLATFORM)

# ====================================================================
# Platform Specific C/C++ Flags

CC=gcc

ifeq ($(PLATFORM), linux64-debug) #==================
EXEC_EXTENSION=-debug
LIB_EXTENSION=-debug.so
LIB_EXTENSION_STATIC=(null)
RAYLIB_DLL=-lraylib
CFLAGS+=-g
CFLAGS+=-D DEBUG
CFLAGS+=-D EXEC_EXTENSION=\"-debug\"
CFLAGS+=-D LIB_EXTENSION=\"-debug.so\"
LDFLAGS+=-rdynamic
endif # =============================================

ifeq ($(PLATFORM), win64) # =========================
EXEC_EXTENSION=.exe
LIB_EXTENSION=.dll
LIB_EXTENSION_STATIC=(null)

SHELL=sh.exe

CXX=g++
RAYLIB_DLL=-lraylibdll
CFLAGS+=-O2
CFLAGS+=-D RELEASE
CFLAGS+=-D EXEC_EXTENSION=\".exe\"
CFLAGS+=-D LIB_EXTENSION=\".dll\"
LDFLAGS+=-lws2_32
LDFLAGS+=-static-libstdc++
LDFLAGS+=-static-libgcc
endif # =============================================

curl_NAME=libcurl-$(PLATFORM)
CFLAGS+=-Ilib/$(curl_NAME)/include
LDFLAGS+=-Llib/$(curl_NAME)/lib
LDFLAGS+=-lcurl
LDFLAGS+=-Wl,-rpath,lib/$(curl_NAME)/lib

# ====================================================================
# all (func)

all: build \
	build/src/../lib/luau/VM/src \
	build/src/../lib/luau/Compiler/src \
	build/src/../lib/luau/Ast/src \
	build/src \
	build/src/luau \
	build/src/../lib/cJSON/src \
	build/src/filetypes build/src/../lib/xml/src \
	build/src/../lib/lz4/src \
	build/src/../lib/zstd/src \
	build/src/../studio/classes \
	build/src/../studio \
	build/studio$(EXEC_EXTENSION) \
	build/player$(EXEC_EXTENSION) \
	deps

# ====================================================================
# Mk Build Dirs

DIRS := build/src/../lib/luau/VM/src \
        build/src/../lib/luau/Compiler/src \
        build/src/../lib/luau/Ast/src \
		build/src \
		build/src/luau \
		build/src/../lib/cJSON/src \
		build/src/filetypes \
		build/src/../lib/xml/src \
		build/src/../lib/lz4/src \
		build/src/../lib/zstd/src \
		build/src/../studio/classes \
		build/src/../studio \
		build/src/../player \
		build
$(DIRS):
	mkdir -p $@

# ====================================================================
# C/CXX Flags

CFLAGS+=-Isrc
CFLAGS+=-Iinclude
CFLAGS+=-Ilib/xml/src
CFLAGS+=-Ilib/xml/include
CFLAGS+=-Ilib/lz4/src
CFLAGS+=-Ilib/lz4/include
CFLAGS+=-Ilib/cJSON/src
CFLAGS+=-Ilib/cJSON/include
CFLAGS+=-Ilib/mini_gzip/src
CFLAGS+=-Ilib/mini_gzip/include
CFLAGS+=-Ilib/zstd/src
CFLAGS+=-Ilib/zstd/include
CFLAGS+=-D PLATFORM=\"$(PLATFORM)\"
CFLAGS+=-Iinclude
CFLAGS+=-Ilib/xml/include
CFLAGS+=-Ilib/luau/VM/include
CFLAGS+=-Ilib/luau/Compiler/include
CFLAGS+=-Ilib/luau/Common/include
CFLAGS+=-Ilib/luau/Ast/include
CFLAGS+=-Ilib/luau/VM/src

C_FLAGS+=-Wno-discarded-qualifiers
C_FLAGS+=-Wno-incompatible-pointer-types

CXXFLAGS+=-DLUA_API='extern
CXXFLAGS+="C"'
CXXFLAGS+=-DLUACODE_API='extern
CXXFLAGS+="C"'
CXXFLAGS+=-Wno-attributes

LDFLAGS+=-lcurl

CFLAGS+=-Ilib/$(RAYLIB_NAME)/include

LDFLAGS+=-lm
LDFLAGS+=-Llib/$(RAYLIB_NAME)/lib
LDFLAGS+=$(RAYLIB_DLL)
LDFLAGS+=-Wl,-rpath,lib/$(RAYLIB_NAME)/lib
LDFLAGS+=-lstdc++

# ====================================================================
# luau_CXX_SOURCES

luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lapi.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/laux.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lbaselib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lbitlib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lbuffer.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lbuflib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lbuiltins.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lcorolib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/ldblib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/ldebug.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/ldo.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lfunc.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lgc.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lgcdebug.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/linit.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lmathlib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lmem.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lnumprint.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lobject.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/loslib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lperf.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lstate.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lstring.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lstrlib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/ltable.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/ltablib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/ltm.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/ludata.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lutf8lib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lveclib.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lvmexecute.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lvmload.o
luau_CXX_SOURCES+=build/src/../lib/luau/VM/src/lvmutils.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/BuiltinFolding.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/Builtins.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/BytecodeBuilder.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/Compiler.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/ConstantFolding.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/CostModel.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/lcode.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/TableShape.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/Types.o
luau_CXX_SOURCES+=build/src/../lib/luau/Compiler/src/ValueTracking.o
luau_CXX_SOURCES+=build/src/../lib/luau/Ast/src/Allocator.o
luau_CXX_SOURCES+=build/src/../lib/luau/Ast/src/Ast.o
luau_CXX_SOURCES+=build/src/../lib/luau/Ast/src/Confusables.o
luau_CXX_SOURCES+=build/src/../lib/luau/Ast/src/Cst.o
luau_CXX_SOURCES+=build/src/../lib/luau/Ast/src/Lexer.o
luau_CXX_SOURCES+=build/src/../lib/luau/Ast/src/Location.o
luau_CXX_SOURCES+=build/src/../lib/luau/Ast/src/Parser.o
luau_CXX_SOURCES+=build/src/../lib/luau/Ast/src/StringUtils.o
luau_CXX_SOURCES+=build/src/../lib/luau/Ast/src/TimeTrace.o
luau_CXX_SOURCES+=build/src/datamodel.o
luau_CXX_SOURCES+=build/src/instance.o
luau_CXX_SOURCES+=build/src/rbxscriptsignal.o
luau_CXX_SOURCES+=build/src/workspace.o
luau_CXX_SOURCES+=build/src/serviceprovider.o
luau_CXX_SOURCES+=build/src/rootinstance.o
luau_CXX_SOURCES+=build/src/model.o
luau_CXX_SOURCES+=build/src/pvinstance.o
luau_CXX_SOURCES+=build/src/trusspart.o
luau_CXX_SOURCES+=build/src/basepart.o
luau_CXX_SOURCES+=build/src/part.o
luau_CXX_SOURCES+=build/src/formfactorpart.o
luau_CXX_SOURCES+=build/src/camera.o
luau_CXX_SOURCES+=build/src/brickcolor.o
luau_CXX_SOURCES+=build/src/meshcontentprovider.o
luau_CXX_SOURCES+=build/src/cacheablecontentprovider.o
luau_CXX_SOURCES+=build/src/physicalcharacter.o
luau_CXX_SOURCES+=build/src/lighting.o
luau_CXX_SOURCES+=build/src/wedgepart.o
luau_CXX_SOURCES+=build/src/valuebase.o
luau_CXX_SOURCES+=build/src/vector3value.o
luau_CXX_SOURCES+=build/src/cylindermesh.o
luau_CXX_SOURCES+=build/src/bevelmesh.o
luau_CXX_SOURCES+=build/src/datamodelmesh.o
luau_CXX_SOURCES+=build/src/runservice.o
luau_CXX_SOURCES+=build/src/serverscriptservice.o
luau_CXX_SOURCES+=build/src/luasourcecontainer.o
luau_CXX_SOURCES+=build/src/basescript.o
luau_CXX_SOURCES+=build/src/script.o
luau_CXX_SOURCES+=build/src/specialmesh.o
luau_CXX_SOURCES+=build/src/filemesh.o
luau_CXX_SOURCES+=build/src/decal.o
luau_CXX_SOURCES+=build/src/faceinstance.o
luau_CXX_SOURCES+=build/src/../lib/cJSON/src/cJSON.o
luau_CXX_SOURCES+=build/src/httpservice.o
luau_CXX_SOURCES+=build/src/numbervalue.o
luau_CXX_SOURCES+=build/src/folder.o
luau_CXX_SOURCES+=build/src/trianglemeshpart.o
luau_CXX_SOURCES+=build/src/meshpart.o
luau_CXX_SOURCES+=build/src/texturecontentprovider.o
luau_CXX_SOURCES+=build/src/players.o
luau_CXX_SOURCES+=build/src/player.o
luau_CXX_SOURCES+=build/src/stringvalue.o
luau_CXX_SOURCES+=build/src/spawnlocation.o
luau_CXX_SOURCES+=build/src/modulescript.o
luau_CXX_SOURCES+=build/src/localscript.o
luau_CXX_SOURCES+=build/src/starterplayerscripts.o
luau_CXX_SOURCES+=build/src/starterplayer.o
luau_CXX_SOURCES+=build/src/playerscripts.o
luau_CXX_SOURCES+=build/src/accessory.o
luau_CXX_SOURCES+=build/src/accoutrement.o
luau_CXX_SOURCES+=build/src/startercharacterscripts.o
luau_CXX_SOURCES+=build/src/testservice.o
luau_CXX_SOURCES+=build/src/localizationtable.o
luau_CXX_SOURCES+=build/src/plugin.o
luau_CXX_SOURCES+=build/src/baseplayergui.o
luau_CXX_SOURCES+=build/src/coregui.o
luau_CXX_SOURCES+=build/src/collectionservice.o
luau_CXX_SOURCES+=build/src/textservice.o
luau_CXX_SOURCES+=build/src/guiservice.o
luau_CXX_SOURCES+=build/src/rbxanalyticsservice.o
luau_CXX_SOURCES+=build/src/contentprovider.o
luau_CXX_SOURCES+=build/src/stylebase.o
luau_CXX_SOURCES+=build/src/stylerule.o
luau_CXX_SOURCES+=build/src/stylingservice.o
luau_CXX_SOURCES+=build/src/tweenservice.o
luau_CXX_SOURCES+=build/src/genericsettings.o
luau_CXX_SOURCES+=build/src/globalsettings.o
luau_CXX_SOURCES+=build/src/studiowidgetsservice.o
luau_CXX_SOURCES+=build/src/startpageservice.o
luau_CXX_SOURCES+=build/src/studiouserservice.o
luau_CXX_SOURCES+=build/src/messagebusservice.o
luau_CXX_SOURCES+=build/src/guibase.o
luau_CXX_SOURCES+=build/src/guibase2d.o
luau_CXX_SOURCES+=build/src/guiobject.o
luau_CXX_SOURCES+=build/src/frame.o
luau_CXX_SOURCES+=build/src/studio.o
luau_CXX_SOURCES+=build/src/standalonepluginscripts.o
luau_CXX_SOURCES+=build/src/boolvalue.o
luau_CXX_SOURCES+=build/src/studiotheme.o
luau_CXX_SOURCES+=build/src/stylesheet.o
luau_CXX_SOURCES+=build/src/mouse.o
luau_CXX_SOURCES+=build/src/pluginmouse.o
luau_CXX_SOURCES+=build/src/humanoid.o
luau_CXX_SOURCES+=build/src/localizationservice.o
luau_CXX_SOURCES+=build/src/userinputservice.o
luau_CXX_SOURCES+=build/src/translator.o
luau_CXX_SOURCES+=build/src/renderer.o
luau_CXX_SOURCES+=build/src/scriptruntime.o
luau_CXX_SOURCES+=build/src/luau/disassembler.o
luau_CXX_SOURCES+=build/src/luau/cframe.o
luau_CXX_SOURCES+=build/src/luau/color3.o
luau_CXX_SOURCES+=build/src/luau/dockwidgetpluginguiinfo.o
luau_CXX_SOURCES+=build/src/luau/enum.o
luau_CXX_SOURCES+=build/src/luau/event.o
luau_CXX_SOURCES+=build/src/luau/globals.o
luau_CXX_SOURCES+=build/src/luau/instance.o
luau_CXX_SOURCES+=build/src/luau/rect.o
luau_CXX_SOURCES+=build/src/luau/serialize.o
luau_CXX_SOURCES+=build/src/luau/state.o
luau_CXX_SOURCES+=build/src/luau/tweeninfo.o
luau_CXX_SOURCES+=build/src/luau/udim2.o
luau_CXX_SOURCES+=build/src/luau/udim.o
luau_CXX_SOURCES+=build/src/luau/vector2.o
luau_CXX_SOURCES+=build/src/luau/vector3.o
luau_CXX_SOURCES+=build/src/luau/numbersequence.o
luau_CXX_SOURCES+=build/src/luau/font.o
luau_CXX_SOURCES+=build/src/luau/path2dcontrolpoint.o
luau_CXX_SOURCES+=build/src/luau/numberrange.o
luau_CXX_SOURCES+=build/src/luau/colorsequence.o
luau_CXX_SOURCES+=build/src/luau/brickcolor.o

luau_CXX_SOURCES+=build/src/filetypes/rbxlx.o
luau_CXX_SOURCES+=build/src/filetypes/rbxmx.o
luau_CXX_SOURCES+=build/src/../lib/xml/src/xml.o
luau_CXX_SOURCES+=build/src/filetypes/rbxm.o
luau_CXX_SOURCES+=build/src/../lib/lz4/src/lz4.o
luau_CXX_SOURCES+=build/src/../lib/zstd/src/zstd_decompress.o

# ====================================================================
# Build Studio

studio_SOURCES+=build/src/../studio/studio.o
studio_SOURCES+=build/src/../studio/classes/studioservice.o
studio_SOURCES+=build/src/../studio/classes/corepackages.o
studio_SOURCES+=build/src/../studio/classes/changehistoryservice.o

build/studio$(EXEC_EXTENSION): $(studio_SOURCES) $(luau_CXX_SOURCES)
	$(CC) -o $@ $^ $(LDFLAGS)

# ====================================================================
# Build Player

player_SOURCES+=build/src/../player/player.o
player_SOURCES+=build/src/filetypes/rbxs.o

build/player$(EXEC_EXTENSION): $(player_SOURCES) $(luau_CXX_SOURCES)
	$(CC) -o $@ $^ $(LDFLAGS)

# ====================================================================
# Build o

build/%.o: %.c
	$(CC) -c $^ $(CFLAGS) $(C_FLAGS) -o $@

build/%.o: %.cpp
	$(CXX) -c $^ $(CFLAGS) $(CXXFLAGS) -o $@

# ====================================================================
# clean (func)

clean:
	rm -rf build/*

# ====================================================================

