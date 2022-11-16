#include "otherfile.h"
#include <FEHLCD.h>
#include <FEHUtility.h>

int main() {
    while (1) {
        LCD.Clear();
        LCD.WriteAt(message().c_str(), 0, 0);
        LCD.Update();
        // Never end
    }
    return 0;
}