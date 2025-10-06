module test_debug(	input logic MAX10_CLK1_50,
							input logic [1:0] KEY,
							input logic [9:0] SW,
							output logic [9:0] LEDR,
							output logic [7:0] HEX5,
							output logic [7:0] HEX4,
							output logic [7:0] HEX3,
							output logic [7:0] HEX2,
							output logic [7:0] HEX1,
							output logic [7:0] HEX0 );
	//
	fsm_gates f(.MATCH(SW[9]), .RESETN(KEY[0]), .clk(MAX10_CLK1_50), .ENTER(KEY[1]), .ps(HEX0[7]), .save(HEX1[7]));
	
endmodule