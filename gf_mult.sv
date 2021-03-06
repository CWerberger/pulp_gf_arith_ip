
module gf_mult
    import gf_mult_pkg::status_e;
    #(
      localparam IO_WIDTH= 8,
      localparam pp_char = 29
    )(
     input logic                              clk_i,
     input logic                              rst_ni,
     input logic                              trigger_i,
     input logic [IO_WIDTH-1:0]               op_a_i,
     input logic [IO_WIDTH-1:0]               op_b_i,
     input logic [IO_WIDTH-1:0]               op_c_i,
     input logic [1:0]			              op_select_i,
     output logic [IO_WIDTH-1:0]              result_o,
     output 				      status_e status_o		// check if the IP is working 
     );

    status_e state_d, state_ff;
    logic [2*IO_WIDTH-1:0]            	result_d, result_ff;
    integer i,k;
    logic [2*IO_WIDTH-1:0]	     	temp;

    assign result_o		= result_ff;
    assign status_o		= state_ff;

    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (!rst_ni) begin
            result_ff		<= '0;
            state_ff		<= gf_mult_pkg::IDLE;
        end else begin
            result_ff        	<= result_d;
            state_ff 		<= state_d;
        end
    end // always_ff @ (posedge clk_i, negedge rst_ni)

  
    always_comb begin
    result_d <= result_ff;
    temp     = 0;
        case (state_ff)
            gf_mult_pkg::IDLE: begin
                if (trigger_i) begin
                    state_d	<= gf_mult_pkg::PENDING;
		    result_d	<= '0;
			         
                end else begin
                    state_d   <= gf_mult_pkg::IDLE;
                end
            end

           gf_mult_pkg::PENDING: begin
              state_d  <= gf_mult_pkg::IDLE;
		          if (op_select_i == 0) begin
		              	temp = op_a_i^ op_b_i;
			     end
   		 else if(op_select_i == 1) begin
			for (i = 0; i < 8; i++) begin
      			       if (op_b_i[i] == 1) begin
					
         			   temp ^= op_a_i << i;
     		   	       end
		            end
			
   		           for (k = 15; k > 7; k--) begin
      			       if (temp[k] == 1) begin
	    			        temp ^= pp_char << (k - 8);
     			       end
   		           end
		end
		else begin
			for (i = 0; i < 8; i++) begin
      			       if (op_b_i[i] == 1) begin
					
         			   temp ^= op_a_i << i;
     		   	       end
		            end
			
   		           for (k = 15; k > 7; k--) begin
      			       if (temp[k] == 1) begin
	    			        temp ^= pp_char << (k - 8);
     			       end
   		           end
			
			temp = op_c_i ^ temp ;
		end
    		 	result_d <= temp ; 
	       
	end
	default: begin
                state_d      <=gf_mult_pkg::IDLE;
		        
		        result_d     <= '0;
            end

       endcase
    end

    endmodule : gf_mult
