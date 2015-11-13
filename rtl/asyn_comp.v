//*************************Copyright 2014[c]***************************************//
// ************************Declaration*********************************************//
// File name:        asyn_comp.v	                                    						 //
// Author:           cxhy1981@163.com                                              //
// Date:             2014/8/25 14:53:21                                            //
// Version Number:   1.0                                                           //
// Abstract:                                                                       //
// Modification history:[including time, version, author and abstract]             //
// 2014/8/25 14:53:32 	        version 1.0     xxx                                //
// Abstract: Initial                                                               //
//                                                                                 //
// *********************************end********************************************//


//　　　　  ┏┓　　　┏┓
//　　　　┏┛┻━━━┻┗┓
//　　　　┃	            ┃
//　　　　┃　　　━　　　┃
//　　　　┃　┳┛　┗┳　┃
//　　　　┃　　　　　　　┃
//　　　　┃　　　┻　　　┃
//　　　　┗━┓　   　┏━┛
//　　　　　　┃　   　┃
//　　┏━━━┛　   　┃
//　┏┫　　　　　   　┃
//　┗┓神兽坐镇 无bug┃
//　　┗┓┏┳━┓┏┏┛
//　　　┣┣┃　┣┣┃
//　　　┗┻┛　┗┻┛


//异步比较模块

module asyn_comp
#(
	parameter
	ADDR_WIDTH = 4
)
(
	input  wire                    rst_n,
	
	output wire                    asyn_full,
	input  wire [ADDR_WIDTH-1 : 0] w_ptr  ,
	
	output wire                    asyn_empty,
	input  wire [ADDR_WIDTH-1 : 0] r_ptr
);

wire dirset;
wire dirclr;

assign dirset = (w_ptr[ADDR_WIDTH-1] ^ r_ptr[ADDR_WIDTH-2]) & (~(w_ptr[ADDR_WIDTH-2] ^ r_ptr[ADDR_WIDTH-1]));
assign dirclr = (~(w_ptr[ADDR_WIDTH-1] ^ r_ptr[ADDR_WIDTH-2])) & (w_ptr[ADDR_WIDTH-2] ^ r_ptr[ADDR_WIDTH-1]);


wire direction;
assign direction = ~((~(dirset | direction)) | dirclr | (~rst_n));

assign asyn_empty = ~((w_ptr == r_ptr) && (direction == 1'b0));
assign asyn_full = ~((w_ptr == r_ptr) && (direction == 1'b1));

endmodule