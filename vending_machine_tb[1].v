`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:33:51 06/26/2023
// Design Name:   vending_machine
// Module Name:   /home/kusuma/Desktop/Opt/14.7/ISE_DS/vending/vending_machine_tb.v
// Project Name:  vending
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vending_machine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module vending_machine_tb;

    // Inputs
    reg clk;
    reg reset;
    reg coin;
    reg select;

    // Outputs
    wire disp;

    // Instantiate the vending machine module
    vending_machine dut (
        .clk(clk),
        .reset(reset),
        .coin(coin),
        .select(select),
        .disp(disp)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        clk = 0;
        reset = 0;
        coin = 0;
        select = 0;
        
        #10 reset = 1;   // Apply reset
        
        #20 reset = 0;   // Release reset

        // Insert coins
        #15 coin = 1;
        #10 coin = 0;
        #10 coin = 1;
        #10 coin = 0;
        #10 coin = 1;
        #10 coin = 0;

        // Select product
        #15 select = 1;
        #5 select = 0;

        // Insert more coins
        #10 coin = 1;
        #10 coin = 0;
        #10 coin = 1;
        #10 coin = 0;
        #10 coin = 1;
        #10 coin = 0;

        // Select another product
        #15 select = 1;
        #5 select = 0;

        // Wait for display
        #50;

        $finish;
    end

endmodule
