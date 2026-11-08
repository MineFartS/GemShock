
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
	-lstdc++

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

DIRS := \
	build/src/../lib/luau/VM/src \
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
	build/src/../lib/luau/VM/src/lapi.o \
	build/src/../lib/luau/VM/src/laux.o \
	build/src/../lib/luau/VM/src/lbaselib.o \
	build/src/../lib/luau/VM/src/lbitlib.o \
	build/src/../lib/luau/VM/src/lbuffer.o \
	build/src/../lib/luau/VM/src/lbuflib.o \
	build/src/../lib/luau/VM/src/lbuiltins.o \
	build/src/../lib/luau/VM/src/lcorolib.o \
	build/src/../lib/luau/VM/src/ldblib.o \
	build/src/../lib/luau/VM/src/ldebug.o \
	build/src/../lib/luau/VM/src/ldo.o \
	build/src/../lib/luau/VM/src/lfunc.o \
	build/src/../lib/luau/VM/src/lgc.o \
	build/src/../lib/luau/VM/src/lgcdebug.o \
	build/src/../lib/luau/VM/src/linit.o \
	build/src/../lib/luau/VM/src/lmathlib.o \
	build/src/../lib/luau/VM/src/lmem.o \
	build/src/../lib/luau/VM/src/lnumprint.o \
	build/src/../lib/luau/VM/src/lobject.o \
	build/src/../lib/luau/VM/src/loslib.o \
	build/src/../lib/luau/VM/src/lperf.o \
	build/src/../lib/luau/VM/src/lstate.o \
	build/src/../lib/luau/VM/src/lstring.o \
	build/src/../lib/luau/VM/src/lstrlib.o \
	build/src/../lib/luau/VM/src/ltable.o \
	build/src/../lib/luau/VM/src/ltablib.o \
	build/src/../lib/luau/VM/src/ltm.o \
	build/src/../lib/luau/VM/src/ludata.o \
	build/src/../lib/luau/VM/src/lutf8lib.o \
	build/src/../lib/luau/VM/src/lveclib.o \
	build/src/../lib/luau/VM/src/lvmexecute.o \
	build/src/../lib/luau/VM/src/lvmload.o \
	build/src/../lib/luau/VM/src/lvmutils.o \
	build/src/../lib/luau/Compiler/src/BuiltinFolding.o \
	build/src/../lib/luau/Compiler/src/Builtins.o \
	build/src/../lib/luau/Compiler/src/BytecodeBuilder.o \
	build/src/../lib/luau/Compiler/src/Compiler.o \
	build/src/../lib/luau/Compiler/src/ConstantFolding.o \
	build/src/../lib/luau/Compiler/src/CostModel.o \
	build/src/../lib/luau/Compiler/src/lcode.o \
	build/src/../lib/luau/Compiler/src/TableShape.o \
	build/src/../lib/luau/Compiler/src/Types.o \
	build/src/../lib/luau/Compiler/src/ValueTracking.o \
	build/src/../lib/luau/Ast/src/Allocator.o \
	build/src/../lib/luau/Ast/src/Ast.o \
	build/src/../lib/luau/Ast/src/Confusables.o \
	build/src/../lib/luau/Ast/src/Cst.o \
	build/src/../lib/luau/Ast/src/Lexer.o \
	build/src/../lib/luau/Ast/src/Location.o \
	build/src/../lib/luau/Ast/src/Parser.o \
	build/src/../lib/luau/Ast/src/StringUtils.o \
	build/src/../lib/luau/Ast/src/TimeTrace.o \
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
	build/src/../lib/cJSON/src/cJSON.o \
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
	build/src/../lib/xml/src/xml.o \
	build/src/filetypes/rbxm.o \
	build/src/../lib/lz4/src/lz4.o \
	build/src/../lib/zstd/src/zstd_decompress.o

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
	build/src/../studio/studio.o \
	build/src/../studio/classes/studioservice.o \
	build/src/../studio/classes/corepackages.o \
	build/src/../studio/classes/changehistoryservice.o \
	$(luau_CXX_SOURCES)
	gcc -o $@ $^ $(LDFLAGS)

# ====================================================================
# Build Player

build/player$(EXEC_EXTENSION): \
	build/src/../player/player.o \
	build/src/filetypes/rbxs.o \
	$(luau_CXX_SOURCES)
	gcc -o $@ $^ $(LDFLAGS)

# ====================================================================

