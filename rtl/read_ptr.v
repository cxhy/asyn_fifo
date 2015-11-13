//****************************************Copyright 2014[c]************************//
// ************************Declaration*********************************************//
// File name:        read_ptr.v	                                    						   //
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
//����������	             ��
//������������������������ ��
//�������������ש������ס� ��
//������������������������ ��
//�����������������ߡ����� ��
//����������������   ��������
//����������������   ����
//����������������   ����
//�����ϡ���������   ����
//�������������� ��bug��
//�����������ש���������
//�������ǩǩ����ǩǩ�
//���������ߩ������ߩ�

//��ָ���߼�ģ��

module read_ptr
#(
	parameter
	ADDR_WIDTH = 4
)
(
	input  wire                         reset_l        ,

	output reg    [ADDR_WIDTH-1 : 0]    rd_addr        ,
	input  wire                         rd_en          ,
	input  wire                         rd_clk
);

reg  [ADDR_WIDTH-1 : 0] rbin;
wire [ADDR_WIDTH-1 : 0] rgnext, rbnext;

//�Ĵ����gray�����ַָ��
always @ (posedge rd_clk or negedge reset_l)
	if(reset_l == 1'b0)
	begin
		rd_addr <= 0;
		rbin <= 0;
	end
	else
	begin
		rd_addr <= rgnext;
		rbin <= rbnext;
	end



//����ַ����
assign rbnext = (rd_en == 1'b1) ? (rbin + 1) : rbin;
//�����Ƶ�gray��ת��
assign rgnext = (rbnext>>1) ^ rbnext;

endmodule