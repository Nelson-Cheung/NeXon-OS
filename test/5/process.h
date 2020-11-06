#include <stdint.h>
typedef struct RegisterImage{
	uint16_t ax;     // 0
	uint16_t bx;     // 2
	uint16_t cx;     // 4
	uint16_t dx;     // 6
	uint16_t sp;     // 8
	uint16_t bp;     // 10
	uint16_t si;     // 12
	uint16_t di;     // 14
	uint16_t ds;     // 16
	uint16_t es;     // 18
	uint16_t fs;     // 20
	uint16_t gs;     // 22
	uint16_t ss;     // 24
	uint16_t ip;     // 26
	uint16_t cs;     // 28
	uint16_t flags;  // 30
} RegisterImage;

RegisterImage KernalContext;

RegisterImage* getRegisterImage(){
    return &KernalContext;
}
