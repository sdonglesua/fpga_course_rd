// main.c -- проста версія: кнопки напряму на світлодіоди.
// Перемикачі фізично підключені й ініціалізовані, але в логіці
// не використовуються -- залишені на майбутнє, якщо захочете
// розширити.

#include "xparameters.h"
#include "xil_io.h"
#include "xgpio.h"
#include "xtmrctr.h"
#include "xinterrupt_wrap.h"
#include <stdint.h>

// ---- ПЕРЕВІРИТИ реальні назви у вашому xparameters.h ----
#define LED_BASEADDR   XPAR_AXI_GPIO_0_BASEADDR
#define BTN_BASEADDR   XPAR_AXI_GPIO_1_BASEADDR
#define SW_BASEADDR    XPAR_AXI_GPIO_2_BASEADDR
#define TIMER_BASEADRR XPAR_AXI_TIMER_0_BASEADDR
#define BTN_SPEED_INC 0x1
#define BTN_SPEED_DEC 0x2
#define BTN_STOP 0x4
#define BTN_START 0x8

XGpio led_gpio, btn_gpio, sw_gpio;

static uint8_t led_idx = 0;
static uint8_t direction = 1;
static uint8_t run = 1;

void TimerISR(void *CallBackRef, u8 TimerNumber) {
    (void)CallBackRef;
    (void) TimerNumber;
    if (run == 0)
    {
        return;
    }
    
    if (direction) {
        led_idx++;
        if (led_idx > 3U) {
            led_idx = 0U;
        }
    }
    else {
        led_idx--;
        if (led_idx > 3U) {
            led_idx = 3U;
        }
    }
}

#define CNT_VAL_MIN 10000000
#define CNT_VAL_MAX 100000000
#define CNT_VAL_STEP 50

int main() {
    XGpio_Config *cfg_ptr;

    cfg_ptr = XGpio_LookupConfig(LED_BASEADDR);
    XGpio_CfgInitialize(&led_gpio, cfg_ptr, cfg_ptr->BaseAddress);

    cfg_ptr = XGpio_LookupConfig(BTN_BASEADDR);
    XGpio_CfgInitialize(&btn_gpio, cfg_ptr, cfg_ptr->BaseAddress);

    cfg_ptr = XGpio_LookupConfig(SW_BASEADDR);
    XGpio_CfgInitialize(&sw_gpio, cfg_ptr, cfg_ptr->BaseAddress);

    XTmrCtr timer;
    int status = XTmrCtr_Initialize(&timer, TIMER_BASEADRR);
    if (status != XST_SUCCESS)
    {
        return status;    
    }

    uint32_t cnt_val = 10000000;
    
    XGpio_SetDataDirection(&led_gpio, 1, 0x0); // вихід
    XGpio_SetDataDirection(&btn_gpio, 1, 0xF); // вхід
    XGpio_SetDataDirection(&sw_gpio,  1, 0x3); // вхід (не використовується в логіці)

    XTmrCtr_SetOptions(&timer, 0, XTC_AUTO_RELOAD_OPTION | XTC_DOWN_COUNT_OPTION | XTC_INT_MODE_OPTION);

    XTmrCtr_SetResetValue(&timer, 0, cnt_val);

    XTmrCtr_SetHandler(&timer, TimerISR, &timer);

    status = XSetupInterruptSystem(
        &timer,
        (XInterruptHandler)XTmrCtr_InterruptHandler,
        timer.Config.IntrId,
        timer.Config.IntrParent,
        XINTERRUPT_DEFAULT_PRIORITY
    );

    if (status != XST_SUCCESS)
    {
        return status;    
    }

    XTmrCtr_Start(&timer, 0);
    
    while (1) {
        u32 btn_value = XGpio_DiscreteRead(&btn_gpio, 1);
        if (btn_value & BTN_SPEED_INC) {
            if (cnt_val <= CNT_VAL_MAX - CNT_VAL_STEP) {
                cnt_val += CNT_VAL_STEP;
                XTmrCtr_SetResetValue(&timer, 0, cnt_val);
                XTmrCtr_Reset(&timer, 0);
            }            
        } else if (btn_value & BTN_SPEED_DEC) {
            if (cnt_val >= CNT_VAL_MIN + CNT_VAL_STEP) {
                cnt_val -= CNT_VAL_STEP;
                XTmrCtr_SetResetValue(&timer, 0, cnt_val);
                XTmrCtr_Reset(&timer, 0);
            }
        } else if (btn_value & BTN_STOP) {
            run = 0;
        } else if (btn_value & BTN_START) {
            run = 1;
        } 

        direction = XGpio_DiscreteRead(&sw_gpio, 1) & 0x1;
        
        XGpio_DiscreteWrite(&led_gpio, 1, (1 << led_idx));
    }

    return 0;
}
