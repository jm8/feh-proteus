// #include "otherfile.h"
#if __has_include ("tigr.h")
#define SIMULATOR
#endif
#include <FEHLCD.h>
#include <FEHUtility.h>

int main() {
    const char *message = "hello";
    while (1) {
        LCD.Clear();
        LCD.WriteAt(message, 0, 0);
        #ifdef SIMULATOR
            LCD.Update();
        #endif
        // Never end
    }
    return 0;
}