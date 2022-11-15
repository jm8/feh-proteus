#include "FEHLCD.h"
#include "FEHUtility.h"
#include <cstdio>

int main() {
    char message[30];
    while (1) {
        LCD.Clear();
        std::snprintf(message, 30, "Time: %lf", TimeNow());
        LCD.WriteAt(message, 0, 0);
        LCD.Update();
        // Never end
    }
    return 0;
}