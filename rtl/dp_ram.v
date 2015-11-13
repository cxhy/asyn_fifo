//****************************************Copyright 2014[c]************************//
// ************************Declaration*********************************************//
// File name:        dp_ram.v	                                         						 //
// Author:           cxhy1981@163.com                                              //
// Date:             2014/8/25 14:53:21                                            //
// Version Number:   1.0                                                           //
// Abstract:                                                                       //
// Modification history:[including time, version, author and abstract]             //
// 2014/8/25 14:53:32 	        version 1.0     xxx                                //
// Abstract: Initial                                                               //
//                                                                                 //
// *********************************end********************************************//

//¡¡¡¡¡¡¡¡  ©³©·¡¡¡¡¡¡©³©·
//¡¡¡¡¡¡¡¡©³©¿©ß©¥©¥©¥©ß©»©·
//¡¡¡¡¡¡¡¡©§	            ©§
//¡¡¡¡¡¡¡¡©§¡¡¡¡¡¡©¥¡¡¡¡¡¡©§
//¡¡¡¡¡¡¡¡©§¡¡©×©¿¡¡©»©×¡¡©§
//¡¡¡¡¡¡¡¡©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡©§
//¡¡¡¡¡¡¡¡©§¡¡¡¡¡¡©ß¡¡¡¡¡¡©§
//¡¡¡¡¡¡¡¡©»©¥©·¡¡   ¡¡©³©¥©¿
//¡¡¡¡¡¡¡¡¡¡¡¡©§¡¡   ¡¡©§
//¡¡¡¡©³©¥©¥©¥©¿¡¡   ¡¡©§
//¡¡©³©Ï¡¡¡¡¡¡¡¡¡¡   ¡¡©§
//¡¡©»©·ÉñÊÞ×øÕò ÎÞbug©§
//¡¡¡¡©»©·©³©×©¥©·©³©³©¿
//¡¡¡¡¡¡©Ç©Ç©§¡¡©Ç©Ç©§
//¡¡¡¡¡¡©»©ß©¿¡¡©»©ß©¿
module dp_ram
#(
	parameter
	DATA_WIDTH = 16,
	ADDR_WIDTH = 4,
	DEPTH = 2**ADDR_WIDTH
)
( 
     input wire                     wr_clk    ,
     input wire  [DATA_WIDTH-1 : 0] write_data,     
     input wire  [ADDR_WIDTH-1 : 0] wr_addr   ,
     
     input  wire                    rd_clk    ,
     output wire [DATA_WIDTH-1 : 0] read_data ,     
     input  wire [ADDR_WIDTH-1 : 0] rd_addr       
);



reg [DATA_WIDTH-1 : 0] mem [DEPTH-1 : 0];

always @ (posedge wr_clk)
	mem[wr_addr] <= write_data;

assign read_data = mem[rd_addr];

endmodule