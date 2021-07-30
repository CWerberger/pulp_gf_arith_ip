
module gf_mult
    import gf_mult_pkg::status_e;
    #(
      localparam IO_WIDTH= 8,
      localparam pp_char = 29,
      localparam DEACCEL_COUNTER_WIDTH = 8
    )(
     input logic                              clk_i,
     input logic                              rst_ni,
     input logic                              trigger_i,
     input logic [IO_WIDTH-1:0]               op_a_i,
     input logic [IO_WIDTH-1:0]               op_b_i,
     output logic [IO_WIDTH-1:0]              result_o
     );

    status_e state_d, state_ff;
    logic [IO_WIDTH-1:0]            result_d, result_ff;
    logic [2*IO_WIDTH-1:0]	     temp,temp_ff;
    assign result_o         = result_ff;
    assign status_o         = state_ff;
    integer i = 0,k = 0;



    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (!rst_ni) begin
            result_ff           <= '0;
	    temp_ff 	     	<= '0;
            state_ff          	<= gf_mult_pkg::IDLE;
        end else begin
            result_ff        	<= result_d;
            state_ff 		<= state_d;
        end
    end // always_ff @ (posedge clk_i, negedge rst_ni)

    always_comb begin
        result_d <= result_ff;
	temp     <= temp_ff;
        case (state_ff)
            gf_mult_pkg::IDLE: begin
                if (trigger_i) begin
                    state_d = gf_mult_pkg::PENDING;
                end 
            end
            gf_mult_pkg::PENDING: begin
                    state_d = gf_mult_pkg::IDLE;
		    temp = temp;
	
                    for (i = 0; i < 8; i++) begin
      			if (op_b_i & (1 << i)) begin
         			temp ^= op_a_i << i;
     		   	end
		    end


   		   for (k = 15; k > 7; k--) begin
      			if (temp & (1 << k)) begin
	    			 temp ^= pp_char << (k - 8);
     			end
   		   end
    		 result_d <= temp & 255;  
	    end

            default: begin
                state_d      = gf_mult_pkg::IDLE;
		temp         = '0;
            end

       endcase
    end

    endmodule : gf_mult
