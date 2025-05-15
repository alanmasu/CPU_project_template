/*!
    @file       main.c
    @brief      Main file for the project.
    @details    This file contains the main function and initializes the system.
    @author     Alan Masutti  (@alanmasu)
    @date       14/05/2025
*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <main.h>
#include <printf.h>
#include <utilities.h>
#include <UART.h>

#define N 100

const char *msg = "Ciao!"; // .rodata
const int costante = 100;  // .rodata
static int statica = 5;    // .data
int glob_init = 42;        // .data
static int statica_uninit; // .bss
int glob_uninit;           // .bss

void test(){
    statica ++;
    statica_uninit ++;
}

int main(int argc, char const *argv[]){
	uint8_t data[100];
	int size = 0;
	UARTInit();
	while(1){
        wait(0);
//		size = UARTRead(data, 10, UART_READ_NONBLOCKING);
		size = UARTRead(data, 10, UART_READ_BLOCKING);
		if(size == 0) continue;

		data[10] = 0;
		printf("Data: %s\n", data);
	}
}
