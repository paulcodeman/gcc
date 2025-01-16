#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <string.h>
#include "./include/all.c"
// #include <stdlib.h> не надо добавлять!

void RedrawAll(int bar_pos) {
	Redraw(1);
	// DrawWindow(500, 250, 420, 200, "test");
	Redraw(2);
	Sleep(500);
	Exit();
}

int main()
{
	int pos = 160;
	
	while(true) {
		switch (Event()){
			case 1:
				RedrawAll(pos);
				break;
		}
	}
}