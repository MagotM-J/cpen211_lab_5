module fsm_synth(	input logic MATCH, RESETN, clk, ENTER,
						output logic ps, 
						output logic save);
	//
	enum int unsigned { OPEN=0, WAIT_TO_LOCK=1, LOCKED=2, WAIT_TO_OPEN=3}
		present_state, next_state;
	always_comb begin // combinational block to generate outputs
		case(present_state)
			OPEN: begin
				ps = 1'b0;
				save = 1'b0;
			end
			
			WAIT_TO_LOCK: begin
				ps = 1'b0;
				save = 1'b1;
			end
			
			LOCKED: begin
				ps = 1'b1;
				save = 1'b0;
			end
			
			WAIT_TO_OPEN: begin
				ps = 1'b1;
				save = 1'b1;
			end
			
			default: begin
				ps = 1'b0;
				save = 1'b0;
			end
		endcase
	end
	
	always_comb begin // combinational block to generate next_state
		next_state = present_state;
		case(present_state)
			OPEN: begin
				if(!ENTER) next_state = WAIT_TO_LOCK;
			end
			WAIT_TO_LOCK: begin
				if(ENTER) next_state = LOCKED;
			end
			LOCKED: begin
				 if(!ENTER & MATCH) next_state = WAIT_TO_OPEN;
			end
			WAIT_TO_OPEN: begin
				if(ENTER) next_state = OPEN;
			end
		endcase
	end
	
	always_ff @(posedge clk) begin // updates only present_state
		if( ~RESETN )
			present_state <= OPEN;
		else
			present_state <= next_state;
	end
endmodule