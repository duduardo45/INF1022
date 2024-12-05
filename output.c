#include <stdio.h>

int main() {

float decimal=2.7;
for (int i = 0; i<3;i++) {
if (!(decimal>3)) {
decimal *= 5;
} else {
printf("%f\n",decimal * 0.5);
}
}
printf("%f\n",decimal + (-2));

return 0;
}
