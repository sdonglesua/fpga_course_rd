`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/08/2026 12:26:03 AM
// Design Name:
// Module Name: tb_top_wrapper
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module tb_top_wrapper;

    reg sys_clock_tb = 0;

    // ---- Зовнішні GPIO-порти -- перевірені раніше через Make External ----
    reg  [3:0] btns_4bits_tri_i = 4'b0000;
    reg  [1:0] sws_2bits_tri_i = 2'b01;
    tri  [3:0] led_tri_io_bidir;

    design_1_wrapper dut(
        .btns_4bits_tri_i(btns_4bits_tri_i),
        .leds_4bits_tri_io(led_tri_io_bidir),
        .sws_2bits_tri_i(sws_2bits_tri_i),
        .sys_clock(sys_clock_tb));

    always #4 sys_clock_tb = ~sys_clock_tb;

    always @(led_tri_io_bidir)
        $display("[%0t] LEDs = %b", $time, led_tri_io_bidir);

    initial begin
        sws_2bits_tri_i  = 2'b01; // Forward
        btns_4bits_tri_i = 4'b0000;

        // Wait for firmware initialization and one complete forward cycle.
        wait (led_tri_io_bidir === 4'b0001);
        wait (led_tri_io_bidir === 4'b0010);
        wait (led_tri_io_bidir === 4'b0100);
        wait (led_tri_io_bidir === 4'b1000);
        wait (led_tri_io_bidir === 4'b0001);

        $display("[%0t] Forward cycle complete; switching backward", $time);
        sws_2bits_tri_i = 2'b00;
        wait (led_tri_io_bidir === 4'b1000);
        wait (led_tri_io_bidir === 4'b0100);
        wait (led_tri_io_bidir === 4'b0010);
        wait (led_tri_io_bidir === 4'b0001);

        $display("[%0t] Backward cycle complete", $time);
        #10000; // Keep the final LED value visible for 10 us.
        $finish;
    end

    initial begin
        #2000000; // 2 ms watchdog if firmware does not complete both cycles.
        $display("ERROR: Timed out waiting for firmware LED cycles");
        $finish;
    end
endmodule
