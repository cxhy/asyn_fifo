//****************************************Copyright 2014[c]************************//
// ************************Declaration*********************************************//
// File name:        asyn_fifo.v	                                    						 //
// Author:           cxhy1981@163.com                                              //
// Date:             2014/8/25 14:53:21                                            //
// Version Number:   1.0                                                           //
// Abstract:                                                                       //
// Modification history:[including time, version, author and abstract]             //
// 2014/8/25 14:53:32 	        version 1.0     xxx                                //
// Abstract: Initial                                                               //
//                                                                                 //
// *********************************end********************************************//
//��������  ��������������
//�������������ߩ������ߩ���
//����������	            ��
//��������������������������
//�������������ש������ס���
//��������������������������
//�����������������ߡ�������
//����������������   ��������
//����������������   ����
//����������������   ����
//�����ϡ���������   ����
//�������������� ��bug��
//�����������ש���������
//�������ǩǩ����ǩǩ�
//���������ߩ������ߩ�


`timescale 1ns/10ps
`default_nettype none


module asyn_fifo_v2
#(
	parameter
	DATA_WIDTH = 16,
	ADDR_WIDTH = 4
)
(
	input  wire          reset_l       ,

  input  wire          wr_clk        ,//дʱ��
  input  wire          wr_en         ,//дʹ��
  output wire          full          ,//asyn_full == 0 ��ʾ��           ��1��ʾ����
	input  wire [15:0]   write_data    ,//д����


	input  wire          rd_clk        ,//��ʱ��
	input  wire          rd_en         ,//��ʹ��
	output wire          empty         ,//�͵�ƽʹ��asyn_empty == 0 ��ʾ�գ�1��ʾ�ǿ�
	output wire [15:0]   read_data      //������   w_req
);

wire [ADDR_WIDTH-1:0] wr_addr;
wire [ADDR_WIDTH-1:0] rd_addr;


dp_ram
#(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH),
    .DEPTH (2**ADDR_WIDTH)
)
U1_dp_ram
(
          .wr_clk    (wr_clk)     ,
          .write_data(write_data) ,
          .wr_addr   (wr_addr)    ,
          
          .rd_clk    (rd_clk)     ,
          .read_data (read_data)  ,
          .rd_addr   (rd_addr)
);

asyn_comp
#(
    .ADDR_WIDTH(ADDR_WIDTH)
)
U2_asyn_comp
(
            .rst_n       (reset_l) ,
                                   
            .asyn_full   (full)    ,
            .w_ptr       (wr_addr) ,
                                   
            .asyn_empty  (empty)   ,
            .r_ptr       (rd_addr)
);


write_ptr 
#(
    .ADDR_WIDTH(ADDR_WIDTH)
)
U3_write_ptr
(
           .reset_l    (reset_l), 

           .wr_addr    (wr_addr),
           .wr_clk     (wr_clk),
           .write_en   (wr_en)
);



read_ptr 
#(
    .ADDR_WIDTH(ADDR_WIDTH)
)
U4_read_ptr
(
           .reset_l      (reset_l)  ,

           .rd_addr      (rd_addr)  ,
           .rd_en        (rd_en)    ,
           .rd_clk       (rd_clk)   
);

endmodule