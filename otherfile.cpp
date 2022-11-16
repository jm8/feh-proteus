#include <FEHUtility.h>
#include <sstream>
#include <string>
using namespace std;

string message() {
    stringstream ss;
    ss << "Time: " << TimeNow();
    return ss.str();
}