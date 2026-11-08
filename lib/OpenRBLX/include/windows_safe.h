
// Rename conflicting Windows functions before windows.h loads
#define Rectangle   WinRectangle
#define CloseWindow WinCloseWindow
#define ShowCursor  WinShowCursor

// Include the real windows.h
#include <windows.h>

// Clean up the macros so raylib stays unaffected
#undef Rectangle
#undef CloseWindow
#undef ShowCursor

