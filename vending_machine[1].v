`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:04 06/26/2023 
// Design Name: 
// Module Name:    vending_machine 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vending_machine(
    input clk,        // Clock signal
    input reset,      // Reset signal
    input coin,       // Coin input
    input select,     // Product selection
    output reg disp   // Output display
);

// Vending machine states
parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter DISPENSE = 2'b10;

// Internal signals
reg [1:0] state,next_state;       // Current state
reg [3:0] count;       // Coin count

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        IDLE:
            if (coin) begin
                count <= 1;
                next_state <= WAIT;
            end
            else
                next_state <= IDLE;
        
        WAIT:
            if (coin && (count < 9)) begin
                count <= count + 1;
                next_state <= WAIT;
            end
            else if (select && (count >= 5)) begin
                count <= count - 5;
                next_state <= DISPENSE;
            end
            else if (select && (count < 5)) begin
                next_state <= WAIT;
            end
            else if (coin && (count >= 9)) begin
                count <= count - 9;
                next_state <= DISPENSE;
            end
            else
                next_state <= WAIT;
        
        DISPENSE:
            next_state <= IDLE;
        
        default:
            next_state <= IDLE;
    endcase
end

// Output display logic
always @(state) begin
    case (state)
        IDLE:
            disp = 0;
        
        WAIT:
            disp = count;
        
        DISPENSE:
            disp = 0;
        
        default:
            disp = 0;
    endcase
end

endmodule
