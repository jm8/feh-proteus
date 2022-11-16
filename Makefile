CPPFLAGS = -MMD -MP -Os -DOBJC_OLD_DISPATCH_PROTOTYPES -g
AUTOC := $(wildcard *.c) $(wildcard Libraries/*.c)
AUTOCPP := $(wildcard *.cpp) $(wildcard Libraries/*.cpp)
AUTOH := $(wildcard *.h) $(wildcard Libraries/*.h)
AUTOOBJECTS := $(patsubst %.cpp,%.o,$(AUTOCPP)) $(patsubst %.c,%.o,$(AUTOC))
INCLUDES = -I. -ILibraries/

LDFLAGS = $(pkg-config --libs opengl x11 glx)
# ifeq ($(OS),Windows_NT)
# 	LDFLAGS = -lopengl32 -lgdi32
# 	EXEC = game.exe
# else
# 	UNAME := $(shell uname)
# 	ifeq ($(UNAME), Linux)
# 		LDFLAGS = $(pkg-config --libs opengl x11 glx)
# 		EXEC = game
# 	else
# 		LDFLAGS = -framework OpenGL -framework Cocoa
# 		EXEC = game
# 	endif
# endif

game : $(AUTOOBJECTS)
	$(CXX) -L/nix/store/xga98bqchjfkma1kj1pxhkp5nxciqyjs-libX11-1.8.1/lib -L/nix/store/n2y7xr21b4vvsap4zyxqvcqid5zr080f-libglvnd-1.5.0/lib -lOpenGL -lX11 -lGLX $(INCLUDES) $(ARGS) $(CFLAGS) $(AUTOOBJECTS) -o game

%.o : %.cpp $(AUTOH)
	$(CXX) -L/nix/store/xga98bqchjfkma1kj1pxhkp5nxciqyjs-libX11-1.8.1/lib -L/nix/store/n2y7xr21b4vvsap4zyxqvcqid5zr080f-libglvnd-1.5.0/lib -lOpenGL -lX11 -lGLX $(INCLUDES) $(ARGS) $(CFLAGS) -c $< -o $@

%.o : %.c $(AUTOH)
	$(CC) -L/nix/store/xga98bqchjfkma1kj1pxhkp5nxciqyjs-libX11-1.8.1/lib -L/nix/store/n2y7xr21b4vvsap4zyxqvcqid5zr080f-libglvnd-1.5.0/lib -lOpenGL -lX11 -lGLX $(INCLUDES) $(ARGS) $(CFLAGS) -c $< -o $@