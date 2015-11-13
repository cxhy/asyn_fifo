//****************************************Copyright 2014[c]************************//
// ************************Declaration*********************************************//
// File name:        write_ptr.v	                                    						 //
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

module write_ptr
#(
	parameter
	ADDR_WIDTH = 4
)
(
	input         wire                             reset_l      ,
	
	output        reg       [ADDR_WIDTH-1 : 0]     wr_addr      ,
	input         wire                             wr_clk       ,
	input         wire                             write_en	
);

reg [ADDR_WIDTH-1 : 0] wbin;
wire [ADDR_WIDTH-1 : 0] wgnext, wbnext;

//寄存输出gray码写地址指针
always @ (posedge wr_clk or negedge reset_l)
	if(reset_l == 1'b0)
	begin
		wr_addr <= 0;
		wbin <= 0;
	end
	else
	begin
		wr_addr <= wgnext;
		wbin <= wbnext;
	end

//写地址计数
assign wbnext = (write_en == 1'b1) ? (wbin + 1) : wbin;
//二进制到gray码转换
assign wgnext = (wbnext >> 1) ^ wbnext;


endmodule