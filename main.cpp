// #include "otherfile.h"
#include <FEHLCD.h>
#include <FEHUtility.h>

int main() {
    const char *message = "hello";
    while (1) {
        LCD.Clear();
        LCD.WriteAt(message, 0, 0);
        LCD.Update();
        // Never end
    }
    return 0;
}