module safe(	input logic MAX10_CLK1_50,
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
	localparam logic[47:0] OPEN = 48'hF7_C0_8C_86_AB_F7;
	localparam logic[47:0] LOCKED = 48'hC7_C0_C6_89_86_C0;
	//
	logic[9:0] s_node, password, attempt;
	logic savePW, saveAT, match;
	logic[1:0] fsm_out;
	
	always_comb begin
		match = (attempt == password);//MATCH
		s_node = SW ^ password;
		LEDR[3:0] = s_node[0] + s_node[1] + s_node[2] + s_node[3] + s_node[4] + s_node[5] + s_node[6] + s_node[7] + s_node[8] + s_node[9];//HINT
		LEDR[9:8] = fsm_out;// PRESENT_STATE
		
	end
	
	assign {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = (fsm_out[1]) ? LOCKED : OPEN;
	
	//
	
	always_ff @(posedge MAX10_CLK1_50) begin
		if(!KEY[0]) begin
			password <= 10'h0; 
			attempt <= 10'h3FF;
		end
		else begin 
			if(savePW) password <= SW;
			if(saveAT) attempt <= SW;
		end
	end
	
	fsm_gates f(.MATCH(match), .RESETN(KEY[0]), .clk(MAX10_CLK1_50), .ENTER(KEY[1]), .ps(fsm_out[1]), .save(fsm_out[0]));
	assign savePW = ~fsm_out[0] & ~fsm_out[1];
	assign saveAT = ~fsm_out[0] & fsm_out[1];
	
endmodule