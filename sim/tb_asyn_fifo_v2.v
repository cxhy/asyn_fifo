//****************************************Copyright 2014[c]************************//
// ************************Declaration*********************************************//
// File name:        tb_asyn_fifo_v2.v	                                    			 //
// Author:           cxhy1981@163.com                                              //
// Date:             2014/8/29 14:47:45                                            //
// Version Number:   1.0                                                           //
// Abstract:                                                                       //
// Modification history:[including time, version, author and abstract]             //
// 2014/8/28 14:13:12 	        version 1.0     xxx                                //
// Abstract: Initial                                                               //
//                                                                                 //
// *********************************end********************************************//


module tb_asyn_fifo_v2;

parameter  DATA_WIDTH = 16;
parameter  ADDR_WIDTH = 4 ;

reg                                   reset_l;

reg                                   wr_clk;
reg                                   wr_en;
wire                                  full;
reg             [15:0]                write_data;

reg                                   rd_clk;
reg                                   rd_en;
wire                                  empty;
wire            [15:0]                read_data;

reg             [15:0]                wr_cnt;
reg             [15:0]                q;


initial begin
    reset_l <= 1'b0;
    #200 reset_l <= 1'b1;
end

initial begin
    wr_clk <= 1'b0;
    forever #10 wr_clk <= ~wr_clk;		
end

initial begin
     rd_clk <= 1'b1;
     forever #10 rd_clk <= ~rd_clk;
end

always(posedge wr_clk or negedge reset_l)begin
	    if(reset_l == 1'b0)begin
	        wr_en <= 1'b0;
	    end
	    else begin
	    	  if(full != 1'b0)begin
	    	      wr_en <= 1'b1;
	    	  end
	    end
end

always(posedge wr_clk or negedge reset_l)begin
	    if(reset_l == 1'b0)begin
	        wr_cnt <= 15'b0;
	    end
	    else begin
	        if(wr_en == 1'b1)begin
	            wr_cnt <= wr_cnt + 1;
	        end
	    end
end

assign write_data = (wr_en == 1) ? wr_cnt : 0;

always(posedge rd_clk or negedge reset_l)begin
	    if(reset_l == 1'b0)begin
	        rd_data <= 15'b0;
	    end
	    else begin
	        if(full == 1'b0)begin
	            rd_en <= 1'b1;
	        end
	    end
end

assign q = (rd_en == 1'b1) ? read_data : 0;







asyn_fifo_v2
#(

	.DATA_WIDTH (DATA_WIDTH),
	.ADDR_WIDTH (ADDR_WIDTH)
)
U_asyn_fifo_v2(
	.reset_l       (reset_l),

  .wr_clk        (wr_clk),//дʱ��
  .wr_en         (wr_en),//дʹ��
  .full          (full),//asyn_full == 0 ��ʾ��           ��1��ʾ����
	.write_data    (write_data),//д����

	.rd_clk        (rd_clk),//��ʱ��
	.rd_en         (rd_en),//��ʹ��
	.empty         (empty),//�͵�ƽʹ��asyn_empty == 0 ��ʾ�գ�1��ʾ�ǿ�
	.read_data     (read_data) //������   w_req
	)
endmodule





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
