module safe_lock(	input logic MAX10_CLK1_50,
						input logic[9:0] SW,
						input logic[1:0] KEY,
						output logic[7:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
						output logic[9:0] LEDR);

	//
	localparam logic [47:0] OPEN = 48’hFC_C0_8C_86_AB_F7;
	localparam logic [47:0] LOCKED = 48’hC7_C0_C6_89_86_C0;
	

	


endmodule

module compute(	input logic[9:0] SW, ATTEMPT, PASSWORD,
						input[1:0] PRESENT_STATE,
						output logic LOCKED, MATCH, HINT);
	//
	logic[9:0] a_node, s_node;
	always_comb begin
		xnor x1(s_node, SW, PASSWORD);
		xnor x2(a_node, ATTEMPT, PASSWORD);
		MATCH = &anode;
		HINT = s_node[9]+s_node[8]+s_node[7]+s_node[6]+s_node[5]+s_node[4]+s_node[3]+s_node[2]+s_node[1]+s_node[0];
		LOCKED = //something	
	end
	
endmodule

module reg_10b(	input logic clk, reset, en, rstAT,
						input logic[9:0] in,
						output logic[9:0] out);

	//
	always_ff @(posedge clk) begin
		if(!reset)
			out <= (rstAT) ? 10'h3FF : 10'h0;
		else if(en) out <= in;
	end
	
endmodule

module reg_2b(	input logic clk, reset, en,
						input logic[1:0] in,
						output logic[1:0] out);

	//
	always_ff @(posedge clk) begin
		if(!reset)
			out <= '0; 
		else if(en) out <= in;
	end
	
endmodule
