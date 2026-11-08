
PLATFORM?=linux64-debug

.PHONY: all

RAYLIB_NAME=raylib5.5-$(PLATFORM)

CC=gcc

ifeq ($(PLATFORM), linux64-debug)
EXEC_EXTENSION=-debug
LIB_EXTENSION=-debug.so
LIB_EXTENSION_STATIC=(null)
RAYLIB_DLL=-lraylib
CFLAGS+=-g
CFLAGS+=-D DEBUG
CFLAGS+=-D EXEC_EXTENSION=\"-debug\"
CFLAGS+=-D LIB_EXTENSION=\"-debug.so\"
LDFLAGS+=-rdynamic
endif

ifeq ($(PLATFORM), win64)
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
endif

curl_NAME=libcurl-$(PLATFORM)
CFLAGS+=-Ilib/$(curl_NAME)/include
LDFLAGS+=-Llib/$(curl_NAME)/lib
LDFLAGS+=-lcurl
LDFLAGS+=-Wl,-rpath,lib/$(curl_NAME)/lib

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
luau_SOURCES+=build/src/scriptruntime.o
luau_SOURCES+=build/src/luau/disassembler.o
luau_SOURCES+=build/src/luau/cframe.o
luau_SOURCES+=build/src/luau/color3.o
luau_SOURCES+=build/src/luau/dockwidgetpluginguiinfo.o
luau_SOURCES+=build/src/luau/enum.o
luau_SOURCES+=build/src/luau/event.o
luau_SOURCES+=build/src/luau/globals.o
luau_SOURCES+=build/src/luau/instance.o
luau_SOURCES+=build/src/luau/rect.o
luau_SOURCES+=build/src/luau/serialize.o
luau_SOURCES+=build/src/luau/state.o
luau_SOURCES+=build/src/luau/tweeninfo.o
luau_SOURCES+=build/src/luau/udim2.o
luau_SOURCES+=build/src/luau/udim.o
luau_SOURCES+=build/src/luau/vector2.o
luau_SOURCES+=build/src/luau/vector3.o
luau_SOURCES+=build/src/luau/numbersequence.o
luau_SOURCES+=build/src/luau/font.o
luau_SOURCES+=build/src/luau/path2dcontrolpoint.o
luau_SOURCES+=build/src/luau/numberrange.o
luau_SOURCES+=build/src/luau/colorsequence.o
luau_SOURCES+=build/src/luau/brickcolor.o

instance_SOURCES+=build/src/datamodel.o
instance_SOURCES+=build/src/instance.o
instance_SOURCES+=build/src/rbxscriptsignal.o
instance_SOURCES+=build/src/workspace.o
instance_SOURCES+=build/src/serviceprovider.o
instance_SOURCES+=build/src/rootinstance.o
instance_SOURCES+=build/src/model.o
instance_SOURCES+=build/src/pvinstance.o
instance_SOURCES+=build/src/trusspart.o
instance_SOURCES+=build/src/basepart.o
instance_SOURCES+=build/src/part.o
instance_SOURCES+=build/src/formfactorpart.o
instance_SOURCES+=build/src/camera.o
instance_SOURCES+=build/src/brickcolor.o
instance_SOURCES+=build/src/meshcontentprovider.o
instance_SOURCES+=build/src/cacheablecontentprovider.o
instance_SOURCES+=build/src/physicalcharacter.o
instance_SOURCES+=build/src/lighting.o
instance_SOURCES+=build/src/wedgepart.o
instance_SOURCES+=build/src/valuebase.o
instance_SOURCES+=build/src/vector3value.o
instance_SOURCES+=build/src/cylindermesh.o
instance_SOURCES+=build/src/bevelmesh.o
instance_SOURCES+=build/src/datamodelmesh.o
instance_SOURCES+=build/src/runservice.o
instance_SOURCES+=build/src/serverscriptservice.o
instance_SOURCES+=build/src/luasourcecontainer.o
instance_SOURCES+=build/src/basescript.o
instance_SOURCES+=build/src/script.o
instance_SOURCES+=build/src/specialmesh.o
instance_SOURCES+=build/src/filemesh.o
instance_SOURCES+=build/src/decal.o
instance_SOURCES+=build/src/faceinstance.o
instance_SOURCES+=build/src/../lib/cJSON/src/cJSON.o
instance_SOURCES+=build/src/httpservice.o
instance_SOURCES+=build/src/numbervalue.o
instance_SOURCES+=build/src/folder.o
instance_SOURCES+=build/src/trianglemeshpart.o
instance_SOURCES+=build/src/meshpart.o
instance_SOURCES+=build/src/texturecontentprovider.o
instance_SOURCES+=build/src/players.o
instance_SOURCES+=build/src/player.o
instance_SOURCES+=build/src/stringvalue.o
instance_SOURCES+=build/src/spawnlocation.o
instance_SOURCES+=build/src/modulescript.o
instance_SOURCES+=build/src/localscript.o
instance_SOURCES+=build/src/starterplayerscripts.o
instance_SOURCES+=build/src/starterplayer.o
instance_SOURCES+=build/src/playerscripts.o
instance_SOURCES+=build/src/accessory.o
instance_SOURCES+=build/src/accoutrement.o
instance_SOURCES+=build/src/startercharacterscripts.o
instance_SOURCES+=build/src/testservice.o
instance_SOURCES+=build/src/localizationtable.o
instance_SOURCES+=build/src/plugin.o
instance_SOURCES+=build/src/baseplayergui.o
instance_SOURCES+=build/src/coregui.o
instance_SOURCES+=build/src/collectionservice.o
instance_SOURCES+=build/src/textservice.o
instance_SOURCES+=build/src/guiservice.o
instance_SOURCES+=build/src/rbxanalyticsservice.o
instance_SOURCES+=build/src/contentprovider.o
instance_SOURCES+=build/src/stylebase.o
instance_SOURCES+=build/src/stylerule.o
instance_SOURCES+=build/src/stylingservice.o
instance_SOURCES+=build/src/tweenservice.o
instance_SOURCES+=build/src/genericsettings.o
instance_SOURCES+=build/src/globalsettings.o
instance_SOURCES+=build/src/studiowidgetsservice.o
instance_SOURCES+=build/src/startpageservice.o
instance_SOURCES+=build/src/studiouserservice.o
instance_SOURCES+=build/src/messagebusservice.o
instance_SOURCES+=build/src/guibase.o
instance_SOURCES+=build/src/guibase2d.o
instance_SOURCES+=build/src/guiobject.o
instance_SOURCES+=build/src/frame.o
instance_SOURCES+=build/src/studio.o
instance_SOURCES+=build/src/standalonepluginscripts.o
instance_SOURCES+=build/src/boolvalue.o
instance_SOURCES+=build/src/studiotheme.o
instance_SOURCES+=build/src/stylesheet.o
instance_SOURCES+=build/src/mouse.o
instance_SOURCES+=build/src/pluginmouse.o
instance_SOURCES+=build/src/humanoid.o
instance_SOURCES+=build/src/localizationservice.o
instance_SOURCES+=build/src/userinputservice.o
instance_SOURCES+=build/src/translator.o
instance_SOURCES+=build/src/renderer.o
instance_CXX_SOURCES+=$(luau_CXX_SOURCES)
instance_SOURCES+=$(luau_SOURCES)

rbxmx_SOURCES+=build/src/filetypes/rbxlx.o
rbxmx_SOURCES+=build/src/filetypes/rbxmx.o
rbxmx_SOURCES+=build/src/../lib/xml/src/xml.o

rbxm_SOURCES+=build/src/filetypes/rbxm.o
rbxm_SOURCES+=build/src/../lib/lz4/src/lz4.o
rbxm_SOURCES+=build/src/../lib/zstd/src/zstd_decompress.o

rbxs_SOURCES+=build/src/filetypes/rbxs.o

studioclasses_SOURCES+=build/src/../studio/classes/studioservice.o
studioclasses_SOURCES+=build/src/../studio/classes/corepackages.o
studioclasses_SOURCES+=build/src/../studio/classes/changehistoryservice.o

studio_SOURCES+=build/src/../studio/studio.o
studio_CXX_SOURCES+=$(instance_CXX_SOURCES)
studio_SOURCES+=$(instance_SOURCES)
studio_CXX_SOURCES+=$(rbxmx_CXX_SOURCES)
studio_SOURCES+=$(rbxmx_SOURCES)
studio_CXX_SOURCES+=$(rbxm_CXX_SOURCES)
studio_SOURCES+=$(rbxm_SOURCES)
studio_CXX_SOURCES+=$(studioclasses_CXX_SOURCES)
studio_SOURCES+=$(studioclasses_SOURCES)

build/studio$(EXEC_EXTENSION): $(studio_SOURCES) $(studio_CXX_SOURCES)
	$(CC) -o $@ $^ $(LDFLAGS)

player_SOURCES+=build/src/../player/player.o
player_CXX_SOURCES+=$(instance_CXX_SOURCES)
player_SOURCES+=$(instance_SOURCES)
player_CXX_SOURCES+=$(rbxmx_CXX_SOURCES)
player_SOURCES+=$(rbxmx_SOURCES)
player_CXX_SOURCES+=$(rbxm_CXX_SOURCES)
player_SOURCES+=$(rbxm_SOURCES)
player_CXX_SOURCES+=$(rbxs_CXX_SOURCES)
player_SOURCES+=$(rbxs_SOURCES)

build/player$(EXEC_EXTENSION): $(player_SOURCES) $(player_CXX_SOURCES)
	$(CC) -o $@ $^ $(LDFLAGS)

build/%.o: %.c
	$(CC) -c $^ $(CFLAGS) $(C_FLAGS) -o $@

build/%.o: %.cpp
	$(CXX) -c $^ $(CFLAGS) $(CXXFLAGS) -o $@

clean:
	rm -rf build/*

