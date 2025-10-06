module fsm_gates(	input logic MATCH, RESETN, clk, ENTER,
						output logic ps, 
						output logic save);
	//
	logic[1:0] present_state, next_state;
	
	always_comb begin // combinational logic to generate outputs
		ps = present_state[1];
		save = present_state[0]; //save to PW/AT or not. 1 only when its in the main 2 states 
	end
	
	always_comb begin // combinational logic to generate next_state
		next_state[1] = ENTER & ~present_state[1] & present_state[0] | ~ENTER & present_state[1] & present_state[0]| present_state[1] & ~present_state[0];
		next_state[0] = ~MATCH & ~ENTER & ~present_state[1] | ~MATCH & ~ENTER & present_state[0]|MATCH & ~ENTER;
	end
	
	always_ff @(posedge clk) begin // updates only present_state
		if( ~RESETN )
			present_state <= 0;
		else
			present_state <= next_state;
	end
endmodule