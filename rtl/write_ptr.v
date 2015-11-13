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

//�Ĵ����gray��д��ַָ��
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

//д��ַ����
assign wbnext = (write_en == 1'b1) ? (wbin + 1) : wbin;
//�����Ƶ�gray��ת��
assign wgnext = (wbnext >> 1) ^ wbnext;


endmodule