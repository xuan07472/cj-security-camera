/*******************************************************************************
 * \brief	串口打印消息
 ******************************************************************************/

// 2  outer corner
// 4
// 6
// 8  TX out
// 10 RX in

/* 函数声明 */
extern void PUT32(unsigned int, unsigned int);
extern void PUT16(unsigned int, unsigned int);
extern void PUT8(unsigned int, unsigned int);
extern unsigned int GET32(unsigned int);
extern unsigned int GETPC(void);
extern unsigned int GETCPSR(void);
extern unsigned int GETSCTLR(void);
extern unsigned int GETMPIDR(void);
extern void BRANCHTO(unsigned int);
extern void dummy(unsigned int);

extern void uart_init(void);
extern unsigned int uart_lcr(void);
extern void uart_flush(void);
extern void uart_send(unsigned int);
extern unsigned int uart_recv(void);
extern unsigned int uart_check(void);
extern void hexstring(unsigned int);
extern void hexstrings(unsigned int);
extern void timer_init(void);
extern unsigned int timer_tick(void);

extern void timer_init(void);
extern unsigned int timer_tick(void);

extern void leds_off(void);

/*
 * \brief	C语言主函数，串口打印消息
 */
int notmain(void)
{
    unsigned int ra;
    unsigned int rb;

    leds_off();
    uart_init();
    hexstring(0x12345678);
    hexstring(GETPC());
    hexstring(GETCPSR());
    hexstring(GETSCTLR());
    hexstring(GETMPIDR());
    hexstring(GET32(0x1000));
    hexstring(GET32(0x1004));
    hexstring(GET32(0x1008));

	if (1) {
		for (ra= 0x000; ra < 0x1000 ; ra += 4) {
			rb = GET32(ra);
			if (rb) {
				hexstrings(ra);
				hexstring(rb);
			}
		}
	}

    return(0);
}

//-------------------------------------------------------------------------
//
// Copyright (c) 2014 David Welch dwelch@dwelch.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//-------------------------------------------------------------------------
