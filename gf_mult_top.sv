'include "register_interface/typedef.svh"
'include "register_interface/assign.svh"

module gf_mult_top
	#(
	   parameter int unsigned AXI_ADDR_WIDTH = 32,
	   localparam int unsigned AXI_DATA_WIDTH = 32,
	   parameter int unsigned AXI_ID_WIDTH = -1,
	   parameter in unsigned AXI_USER_WIDTH = -1
	  )
	(
	input logic clk_i,
	input logic rst_ni,
	input logic test_mode_i,
	
	AXI_BUS.Slave axi_slave
	);
	
	import gf_mult_reg_pkg::gf_mult_reg2hw_t;
	import gf_mult_reg_pkg::gf_mult_hw2reg_t;
	
	//Wiring Signals
	REG_BUS #(.ADDR_WIDTH(32), .DATA_WIIDTH(32)) axi_to_regfile();  // Generic Reg-Interface Bus
	gf_mult_reg2hw_t reg_file_to_ip;
	gf_mult_hw2reg_t ip_to_reg_file;
	
	//Protocoll converter from axi to the generic register interface
	
	axi_to_reg_intf #(
			  .ADDR_WIDTH(AXI_ADDR_WIDTH),
			  .DATA_WIDTH(AXI_DATA_WIDTH),
			  .ID_WIDTH(AXI_ID_WIDTH),
			  .USER_WIDTH(AXI_USER_WIDTH),
			  .DECOUPLE_W(0)
	) i_axi2reg (
			  .clk_i,
			  .rst_ni,
			  .testmode_i(test_mode_i),
			  .in(axi_slave),
			  .reg_o(axi_to_regfile)
	);
	// Convert Reg_Bus Interface to struct signals which are used by the autogenerated reg file
	typedef logic [AXI_ADDR_WIDTH-1:0] addr_t;    
	typedef logic [AXI_ADDR_WIDTH-1:0] data_t;
	typedef logic [AXI_ADDR_WIDTH/8-1:0] strb_t;
	// Macro to declare a struct with adress witdh, data_bus , strb_t to access specific bytes)
	// First Value is the name of the struct e.g. reg_req_t
	'REG_BUS_TYPEDEF_REQ(reg_req_t, addr_t, data_t, strb_t);  
	'REG_BUS_TYPEDEF_RSP(reg_rsp_t, data_t);
	
	// Wiring the structs 
	reg_req_t to_reg_file_req;
	reg_rsp_t from reg_file_rsp;
	
	// ASSIGN every signal from Interface to the struct
	'REG_BUS_ASSIGN_TO_REQ(to_reg_file_req, axi_to_regfile);
	'REG_BUS_ASSIGN_FROM_RST(axi_to_regfile, from_reg_file_rsp);
	
	// Instace of the autogeneratet reg_file by the reg_file tool 
	
	gf_mult_reg_top #(
	.reg_req_t(reg_req_t),
	.reg_rsp_t(reg_rsp_t)
	) i_regfile (
			.clk_i,
			.rst_ni,
			.devmode_i(1'b1),	
			
			//protocol converter -> regfile
			.reg_req_i(to_reg_file_req),
			.reg_rsp_o(from_reg_file_rsp),
			
			//Singal to gf_mult IP
			.reg2hw(reg_file_to_ip),
			.hw2reg(ip_to_reg_file)
	);
	// Wrapper for the IP -> use regfile for connection -> gf_mult_hjson
	gf_mult i_gf_mult (
			   .clk_i,
			   .rst_ni,
			   .trigger_i(reg_file_to_ip.ctrl1.trigger.q & reg_file_to_ip.ctrl1.trigger.qe),
			   .op_a_i(reg_file_to_ip.op_a),
			   .op_b_i(reg_file_to_ip.op_b),
			   .result_o(ip_to_reg_file.result)
			   );
endmodul : gf_mult_top
			
			
			
				
