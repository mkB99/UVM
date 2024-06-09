// Code your design here
// Code your design here
`timescale 1ns / 1ps
module Main_Processor(
input clk,
input [15:0]inst_in,
output reg [7:0]pc_out,
output reg [15:0]inst_out,
output reg [2:0]jmp_val,
output reg jmp,eop,
output reg [1:0]regwr_out2,dir_val_out2,
output reg memwr_out2,ctrl_sel_out2,wrbk_sel_out2,
output reg [2:0]aD_out2,dir_s2_out2,
output reg [3:0]alu_sel_out2,
output reg [7:0]dir_s1_out2,
output reg [15:0]s1_out2,s2_out2,
output reg [1:0]reg_wr_out3,reconfig_mul,reconfig_load,
output reg mem_wr_out3,wrbk_sel_out3,
output reg [2:0]aM_out3,aD_out3,
output reg [15:0]alu_out3,dM_out3,
output reg [15:0]wD_rf,
output reg [1:0]w_en,
output reg [2:0]aD_rf,
output reg s1_c0,s1_c1,s2_c0,s2_c1,
output reg [1:0]inita,
output reg [2:0]initb,
output reg [15:0]pc_2,pc_3,inst_out_tb,
output reg [15:0]mem_data_tb,
output reg mem_en_tb,
output reg [2:0]mem_add_tb
    );
//Start of Processor Part1	 
wire [7:0]pc_in;
//input [15:0]inst_in;
wire [7:0]k;
assign k=pc_out;
wire clk_mod=clk&~eop;
wire s1_c1_k,s2_c1_k,s1_c0_k,s2_c0_k;
initial
begin
pc_out=0;
jmp=0;
jmp_val=0;
eop=0;
s1_c0=0;
s1_c1=0;
s2_c0=0;
s2_c1=0;
w_en=0;
aD_rf=0;
wD_rf=0;
inita=3;
initb=4;
end
wire [1:0]k_mux; wire [2:0]kmux2;
mux2_1_1bit m5[1:0](2'b00,2'b11,inita[0]|inita[1],k_mux);
mux2_1_1bit m10[2:0](3'b000,3'b111,initb[0]|initb[1]|initb[2],kmux2); 
wire [1:0]k_sum=inita+k_mux;
wire [2:0]k_sum2=initb+kmux2;
mux2_1_1bit m6(s1_c0,1'b0,inita[0]|inita[1],s1_c0_k);
mux2_1_1bit m7(s2_c0,1'b0,inita[0]|inita[1],s2_c0_k);
mux2_1_1bit m8(s1_c1,1'b0,initb[0]|initb[1]|initb[2],s1_c1_k);
mux2_1_1bit m9(s2_c1,1'b0,initb[0]|initb[1]|initb[2],s2_c1_k);
always@(posedge clk)
begin
inita<=k_sum;
initb<=k_sum2;
end
wire w1;
wire jmp_w=jmp;
wire [2:0]jmp_val_w=jmp_val;
wire [2:0]w2;
assign w1=jmp_w&(jmp_val_w[0]|jmp_val_w[1]|jmp_val_w[2]);

mux2_1_1bit m1[2:0](3'b001,jmp_val,w1,w2);
adder_internal a1(k,w2,pc_in);

//inst_mem IM(pc_out,inst_in);

always@(posedge clk_mod)
begin
pc_out=pc_in;
end

always@(posedge clk_mod)
begin
inst_out=inst_in;

end
//End of Part1

//Start of Processor Part2
wire [15:0]pc;
assign pc=inst_out;
wire jmp_cu,eop_cu,ctrl_sel_in,memwr_in,wrbk_sel_in;
wire [1:0]regwr_in;
wire [3:0]alu_sel_in;
wire[1:0]dir_val_in,w_en_w;
wire[15:0] s1_in,s2_in,wD_rf_w,s1_in_1,s2_in_1;
wire [7:0]dir_s1_in;
assign dir_s1_in=pc[7:0];
wire [2:0]dir_s2_in,aD_rf_w;
assign dir_s2_in=pc[2:0];
assign wD_rf_w=wD_rf;
assign w_en_w=w_en;
assign aD_rf_w=aD_rf;

always@(*)
jmp_val=pc[2:0];

Control_Unit CU(pc[15:12],pc[11],pc[10:9],jmp_cu,eop_cu,ctrl_sel_in,memwr_in,wrbk_sel_in,regwr_in,alu_sel_in,dir_val_in);
reg_file RF(s1_in_1,s2_in_1,clk,pc[10:9],pc[5:3],pc[2:0],aD_rf_w,wD_rf_w,w_en_w);
assign s1_in=({{8{pc[10]}}& s1_in_1[15:8],{8{pc[9]}}& s1_in_1[7:0]});
assign s2_in=({{8{pc[10]}}& s2_in_1[15:8],{8{pc[9]}}& s2_in_1[7:0]});
always@(*)
begin
jmp=jmp_cu;
eop=eop_cu;
end
always@(posedge clk)
begin
regwr_out2<=regwr_in;
dir_val_out2<=dir_val_in;
memwr_out2<=memwr_in;
ctrl_sel_out2<=ctrl_sel_in;
wrbk_sel_out2<=wrbk_sel_in;
aD_out2<=pc[8:6];
dir_s1_out2<=dir_s1_in;
dir_s2_out2<=dir_s2_in;
s1_out2<=s1_in;
s2_out2<=s2_in;
alu_sel_out2<=alu_sel_in;
pc_2<=pc;
reconfig_mul<=pc[10:9];
end
//End of Part2

//For HCU
wire s1_c1_in=s1_c1_k;
wire s2_c1_in=s2_c1_k;
wire s1_c0_in=s1_c0_k;
wire s2_c0_in=s2_c0_k;
wire [15:0]A_scr1=s1_out2;
wire [15:0]A_scr2=s2_out2;
wire [15:0]B_hcu=({{8{pc[10]}}& alu_out3[15:8],{8{pc[9]}}& alu_out3[7:0]});//alu_out3 original assign
wire [15:0]C_hcu=({{8{pc[10]}}& wD_rf[15:8],{8{pc[9]}}& wD_rf[7:0]});//wD_rf original assign

//Start Of Processor Part3
wire [15:0]w3,w4,w5,w6,alu_op,hcu1,hcu2,alu_op_half,w3in1,w3in2,pc_k;
wire w7;
assign pc_k=pc_2;
assign w3in1={{8{1'b0}},dir_s1_out2};
assign w3in2={dir_s1_out2,{8{1'b0}}};
mux2_1_1bit mdirsel[15:0](w3in1,w3in2,regwr_out2[1],w3);
assign w4={{13{1'b0}},dir_s2_out2};


mux4_1_16bit mux1(A_scr1,B_hcu,C_hcu,B_hcu,s1_c0_in,s1_c1_in,hcu1);
mux4_1_16bit mux2(A_scr2,B_hcu,C_hcu,B_hcu,s2_c0_in,s2_c1_in,hcu2);
mux2_1_1bit m2[15:0](hcu1,w3,dir_val_out2[1],w5);
mux2_1_1bit m3[15:0](hcu2,w4,dir_val_out2[0],w6);

ALU alu(w5,w6,alu_sel_out2[3:2],alu_sel_out2[1:0],ctrl_sel_out2,reconfig_mul,alu_op_half,w7);
mux2_1_1bit mdir[15:0](alu_op_half,w3,dir_val_out2[1],alu_op);

always@(posedge clk)
begin
reg_wr_out3<=regwr_out2;
mem_wr_out3<=memwr_out2;
wrbk_sel_out3<=wrbk_sel_out2;
aM_out3<=dir_s2_out2;
aD_out3<=aD_out2;
alu_out3<=alu_op;
dM_out3<=w5;
pc_3<=pc_k;
reconfig_load<=reconfig_mul;
end

//End of Part3

//Start of Processor Part4
wire[15:0]pc_k1,z2;
wire [2:0]z1;
wire z3;
assign pc_k1=pc_3;
assign z1=aM_out3;
assign z2=dM_out3;
assign z3=mem_wr_out3;
wire [15:0]mem_out,wD_in,mem_inter;
data_mem DM(dM_out3,aM_out3,clk,mem_wr_out3,mem_inter);
mux2_1_1bit mload[15:0]({16{1'b0}},mem_inter,reconfig_load[0]&reconfig_load[1],mem_out);
mux2_1_1bit m4[15:0](alu_out3,mem_out,wrbk_sel_out3,wD_in);

always@(posedge clk)
begin
inst_out_tb<=pc_k1;
mem_data_tb<=z2;
mem_en_tb<=z3;
mem_add_tb<=z1;
wD_rf<=wD_in;
w_en<=reg_wr_out3;
aD_rf<=aD_out3;
end
//End of Part4

//Hazard Control Unit
reg [4:0]r1,r2,r4,r5;
reg [2:0]r3,r6;	 	 
wire h1,h2,h3,h4;
always@(posedge clk)
begin
r1<={{inst_in[10:9]},{inst_in[5:3]}};
r2<={{inst_in[10:9]},{inst_in[2:0]}};
r3<=pc[8:6];
end
comp co1(r1,r3,inst_in[15:12],h1);
comp co2(r2,r3,inst_in[15:12],h2);
always@(posedge clk)
begin
s1_c0<=h1;
s2_c0<=h2;
r4<={{inst_in[10:9]},{inst_in[5:3]}};
r5<={{inst_in[10:9]},{inst_in[2:0]}};
r6<=r3;
end
comp c03(r4,r6,inst_in[15:12],h3);
comp co4(r5,r6,inst_in[15:12],h4);
always@(posedge clk)
begin
s1_c1<=h3;
s2_c1<=h4;
end

endmodule

// Code your design here
module mux2_1_1bit(
input a,b,s,
output y
    );
assign y=a&~s|b&s;

endmodule
module adder_internal(
input [7:0]a,
input [2:0]b,
output [7:0]y
    );
assign y=a+({{5{2'b0}},b});

endmodule
module Control_Unit(
input [3:0]op,
input ctrl,
input [1:0]re_config,
output jmp,eop,ctrl_sel,mem_wr,wr_bk_sel,
output [1:0]reg_wr,
output [3:0]alu_sel,
output [1:0]dir_val
    );

wire w1,w2,w3,w4,k,shiftv;

//Regwr
assign w1=(op[3]&~op[2]&op[1]&op[0]);	//store
assign w2=(op[3]&op[2]&~op[1]&op[0]);	//jump
assign w3=(op[3]&op[2]&op[1]&~op[0]);	//NOP
assign w4=(op[3]&op[2]&op[1]&op[0]);	//EOP
assign k=w1|w2|w3|w4;

assign shiftv=re_config[1]&re_config[0]&op[3]&op[2]&~op[1]&~op[0];
assign reg_wr[1]=(re_config[1]|(op[3]&~op[2]&~op[1]&~op[0])|shiftv)&(~k);
assign reg_wr[0]=(re_config[0]|(op[3]&~op[2]&~op[1]&~op[0])|shiftv)&(~k);
//Memwr
assign mem_wr=w1;

//Write Back Select
assign wr_bk_sel=(op[3]&~op[2]&op[1]&~op[0]);

//Dual select in ALU
assign ctrl_sel=ctrl&~w3;

//Jump
assign jmp=(op[3]&op[2]&~op[1]&op[0]);

//EOP
assign eop=(op[3]&op[2]&op[1]&op[0]);

//Direct Value
assign dir_val[1]=op[3]&~op[2]&~op[1]&op[0]&ctrl;
assign dir_val[0]=op[3]&op[2]&~op[1]&~op[0];

//ALU select
assign alu_sel=(op&{4{~w3}})|({~op[3],op[2],op[1],~op[0]}&{4{w3}});

endmodule

module reg_file(
    output reg [15:0] r0,//scr1 o/p
    output reg [15:0] r1,//scr2 o/p
    input clk,
	 input [1:0] reconfig,//active high
    input [2:0] a0,		//source 1
    input [2:0] a1,		//source 2
    input [2:0] d,		//dest register
    input [15:0] wr,		//data to be written
    input [1:0] w_en		//active high
    );

	 reg [15:0]gpr[7:0];
	 integer i;
	 initial 
	  for(i=0;i<8;i=i+1)
	  begin
	  gpr[i]=0;
	  end
	 always@(negedge clk)
		begin
			if(reconfig==2'b11)
				begin
					r0<=gpr[a0];	//read the data
					r1<=gpr[a1];	//at negative edge
				end
			else if(reconfig==2'b10)
				begin
					r0<={gpr[a0][15:8],{8{1'b0}}};
					r1<={gpr[a1][15:8],{8{1'b0}}};
				end
			else if(reconfig==2'b01)
				begin
					r0<={{8{1'b0}},gpr[a0][7:0]};
					r1<={{8{1'b0}},gpr[a1][7:0]};
				end
			else
				begin
					r0<=16'b0;
					r1<=16'b0;
				end
				
		end
		
	always@(posedge clk)	//write at positive
		begin					//edge
			if(w_en==2'b11)
				gpr[d]<=wr;	//16 bit write
			else if(w_en==2'b01)
				gpr[d][7:0]<=wr[7:0];	//lower byte write
			else if(w_en==2'b10)
				gpr[d][15:8]<=wr[15:8];	//higher byte write
		end

endmodule
module mux4_1_16bit(
input [15:0]a,b,c,d,
input s0,s1,
output [15:0]y
    );
wire [15:0]w1,w2;
mux2_1_1bit m1[15:0](a,b,s0,w1);
mux2_1_1bit m2[15:0](c,d,s0,w2);
mux2_1_1bit m3[15:0](w1,w2,s1,y);


endmodule
module ALU(
input [15:0]a,
input [15:0]b,
input [1:0]alu_sel,	//use of alu_sel 
input [1:0]s,			// 4 bits
input sel,
input [1:0]mul,
output [15:0]y,
output cout
    );  
wire [15:0]ar1,ar2,l1,l2,l3,l4,l5,l6,l7,l8,sh1,sh2,sh3,w1,w2,mul1;

wire k_mov=alu_sel[1]&~alu_sel[0]&~s[1]&s[0]; //For move;

//Arithmetic

assign ar1=((~({16{s[0]}}))&b)|((({16{s[0]}})^({16{s[1]}}))&~b)&({16{~k_mov}});	
Adder a1(a,ar1,(s[0]&(~k_mov)),ar2,cout);

//Logical
assign l1=a&b;
assign l2=a|b;
assign l3=a^b;
assign l4=a;
mux2_1_1bit m1[15:0](l1,l2,s[0],l5);
mux2_1_1bit m2[15:0](l3,l4,s[0],l6);
mux2_1_1bit m3[15:0](l5,l6,s[1],l7);
assign l8=l7^({16{sel}});

//Mulitplication
wire[7:0] wmul1,wmul2,wmul11,wmul22;
mux2_1_1bit mmul1[7:0](a[7:0],a[15:8],~mul[0],wmul1);
mux2_1_1bit mmul2[7:0](b[7:0],b[15:8],~mul[0],wmul2);
mux2_1_1bit mmul3[7:0]({8{1'b0}},wmul1,mul[0]|mul[1],wmul11);
mux2_1_1bit mmul4[7:0]({8{1'b0}},wmul2,mul[0]|mul[1],wmul22);
wallace_8bit m4(wmul11,wmul22,mul1); 

//Shifter
assign sh1=a<<b;
assign sh2=a>>b;
mux2_1_1bit m5[15:0](sh1,sh2,sel,sh3);

//Final Mux_logic
mux2_1_1bit m6[15:0](ar2,l8,alu_sel[0],w1);
mux2_1_1bit m7[15:0](mul1,sh3,alu_sel[0],w2);
mux2_1_1bit m8[15:0](w1,w2,alu_sel[1]&(~k_mov),y);

endmodule
module data_mem(
input [15:0]dM,
input [2:0]aM,
input clk,wr,
output reg [15:0]m
    );
reg [15:0]mem[7:0];	 
integer i;
	 initial 
	  for(i=0;i<8;i=i+1)
	  begin
	  mem[i]=0;
	  end
//Store
always@(posedge clk)
begin
 if(wr==1)
  mem[aM]=dM;
end	 

//Load
always@(negedge clk)
begin 
m=mem[aM];
end
endmodule
module comp(
input [4:0]a,
input [2:0]b,
input [3:0]op,
output s
    );
wire s_inter;
wire [2:0]w1;
assign w1=(~(a[2:0])|b)&((a[2:0])|~b);
assign s_inter=w1[0]&w1[1]&w1[2]&(a[4]|a[3]);
assign s=s_inter&(op[3]&op[2]&op[1]&~op[0]);

endmodule
module wallace_8bit(
    input [7:0] a,
    input [7:0] b,
    output [15:0] p
    );
reg [63:0]w;
integer i,j,k,l;
always@(*)
begin
i=63;
l=7;
while(i>=36)
 begin
  k=7;
  for(j=l;j<=7;j=j+1)
    begin
    if(k>=l)	 
     w[i]=a[j]&b[k];
    i=i-1;
	 k=k-1;
    end
  l=l-1;
 end
  l=0;
  i=0;
while(i!=36)
 begin
  j=0;
  for(k=l;k>=0;k=k-1)
   begin
    if(j<=l)
	  w[i]=a[k]&b[j];
    i=i+1;
	 j=j+1;
   end
  l=l+1;
 end
w[0]=a[0]&b[0];
end
 
assign p[0]=w[0];

halfadder hfa1(w[1],w[2],p[1],b1);

halfadder hf2(w[3],w[4],k1,c1);
full_adder fa1(w[5],k1,b1,p[2],c2);

halfadder hf3(w[6],w[7],k2,d1);
full_adder fa2(w[8],k2,c1,k3,d2);
full_adder fa3(w[9],k3,c2,p[3],d3);

halfadder hf4(w[10],w[11],k4,e1);
full_adder fa4(w[12],k4,d1,k5,e2);
full_adder fa5(w[13],k5,d2,k6,e3);
full_adder fa6(w[14],k6,d3,p[4],e4);
	
halfadder hf5(w[15],w[16],k7,f1);
full_adder fa7(w[17],k7,e1,k8,f2);
full_adder fa8(w[18],k8,e2,k9,f3);
full_adder fa9(w[19],k9,e3,k10,f4);
full_adder fa10(w[20],k10,e4,p[5],f5);	
	
halfadder hf6(w[21],w[22],k11,g1);
full_adder fa11(w[23],k11,f1,k12,g2);
full_adder fa12(w[24],k12,f2,k13,g3);
full_adder fa13(w[25],k13,f3,k14,g4);
full_adder fa14(w[26],k14,f4,k15,g5);
full_adder fa15(w[27],k15,f5,p[6],g6);
	
halfadder hf7(w[28],w[29],k16,h1);
full_adder fa16(w[30],k16,g1,k17,h2);
full_adder fa17(w[31],k17,g2,k18,h3);
full_adder fa18(w[32],k18,g3,k19,h4);
full_adder fa19(w[33],k19,g4,k20,h5);
full_adder fa20(w[34],k20,g5,k21,h6);
full_adder fa21(w[35],k21,g6,p[7],h7);

halfadder hf8(w[36],w[37],k22,i1);
full_adder fa22(w[38],k22,h1,k23,i2);
full_adder fa23(w[39],k23,h2,k24,i3);
full_adder fa24(w[40],k24,h3,k25,i4);
full_adder fa25(w[41],k25,h4,k26,i5);
full_adder fa26(w[42],k26,h5,k27,i6);
full_adder fa27(k27,h7,h6,p[8],i7);

full_adder fa28(w[43],w[44],i1,k28,j1);
full_adder fa29(w[45],k28,i2,k29,j2);
full_adder fa30(w[46],k29,i3,k30,j3);
full_adder fa31(w[47],k30,i4,k31,j4);
full_adder fa32(w[48],k31,i5,k32,j5);
full_adder fa33(k32,i7,i6,p[9],j6);

full_adder fa34(w[49],w[50],j1,k33,l1);
full_adder fa35(w[51],k33,j2,k34,l2);
full_adder fa36(w[52],k34,j3,k35,l3);
full_adder fa37(w[53],k35,j4,k36,l4);
full_adder fa38(j5,j6,k36,p[10],l5);

full_adder fa39(w[54],w[55],l1,k37,m1);
full_adder fa40(w[56],k37,l2,k38,m2);
full_adder fa41(w[57],k38,l3,k39,m3);
full_adder fa42(l4,l5,k39,p[11],m4);

full_adder fa43(w[58],w[59],m1,k40,n1);
full_adder fa44(w[60],k40,m2,k41,n2);
full_adder fa45(m3,m4,k41,p[12],n3);

full_adder fa46(w[61],w[62],n1,k42,o1);
full_adder fa47(n2,n3,k42,p[13],o2);

full_adder fa48(w[63],o1,o2,p[14],p[15]);


endmodule
module Adder(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] s,
    output cout
    );

wire [15:0]g,p,GG;

//Bitwise Generate And Propogate Signals.
assign g=a&b;
assign p=a^b;


//Group Generate And Propogate Signals.
assign GG[0]=g[0]|(p[0]&cin);
black_box b1(g[15],p[15],g[14],p[14],g1,p1);
black_box b2(g[14],p[14],g[13],p[13],g2,p2);
black_box b3(g[13],p[13],g[12],p[12],g3,p3);
black_box b4(g[12],p[12],g[11],p[11],g4,p4);
black_box b5(g[11],p[11],g[10],p[10],g5,p5);
black_box b6(g[10],p[10],g[9],p[9],g6,p6);
black_box b7(g[9],p[9],g[8],p[8],g7,p7);
black_box b8(g[8],p[8],g[7],p[7],g8,p8);
black_box b9(g[7],p[7],g[6],p[6],g9,p9);
black_box b10(g[6],p[6],g[5],p[5],g10,p10);
black_box b11(g[5],p[5],g[4],p[4],g11,p11);
black_box b12(g[4],p[4],g[3],p[3],g12,p12);
black_box b13(g[3],p[3],g[2],p[2],g13,p13);
black_box b14(g[2],p[2],g[1],p[1],g14,p14);
gray_box gb1(g[1],p[1],GG[0],GG[1]);

black_box b15(g1,p1,g3,p3,g15,p15);
black_box b16(g2,p2,g4,p4,g16,p16);
black_box b17(g3,p3,g5,p5,g17,p17);
black_box b18(g4,p4,g6,p6,g18,p18);
black_box b19(g5,p5,g7,p7,g19,p19);
black_box b20(g6,p6,g8,p8,g20,p20);
black_box b21(g7,p7,g9,p9,g21,p21);
black_box b22(g8,p8,g10,p10,g22,p22);
black_box b23(g9,p9,g11,p11,g23,p23);
black_box b24(g10,p10,g12,p12,g24,p24);
black_box b25(g11,p11,g13,p13,g25,p25);
black_box b26(g12,p12,g14,p14,g26,p26);
gray_box gb3(g13,p13,GG[1],GG[3]);
gray_box gb2(g14,p14,GG[0],GG[2]);

black_box b27(g15,p15,g19,p19,g27,p27);
black_box b28(g16,p16,g20,p20,g28,p28);
black_box b29(g17,p17,g21,p21,g29,p29);
black_box b30(g18,p18,g22,p22,g30,p30);
black_box b31(g19,p19,g23,p23,g31,p31);
black_box b32(g20,p20,g24,p24,g32,p32);
black_box b33(g21,p21,g25,p25,g33,p33);
black_box b34(g22,p22,g26,p26,g34,p34);
gray_box gb7(g23,p23,GG[3],GG[7]);
gray_box gb6(g24,p24,GG[2],GG[6]);
gray_box gb5(g25,p25,GG[1],GG[5]);
gray_box gb4(g26,p26,GG[0],GG[4]);

gray_box gb15(g27,p27,GG[7],GG[15]);
gray_box gb14(g28,p28,GG[6],GG[14]);
gray_box gb13(g29,p29,GG[5],GG[13]);
gray_box gb12(g30,p30,GG[4],GG[12]);
gray_box gb11(g31,p31,GG[3],GG[11]);
gray_box gb10(g32,p32,GG[2],GG[10]);
gray_box gb9(g33,p33,GG[1],GG[9]);
gray_box gb8(g34,p34,GG[0],GG[8]);


//Final Sum And Cout.
assign s[0]=p[0]^cin;
assign s[1]=p[1]^GG[0]; 
assign s[2]=p[2]^GG[1];
assign s[3]=p[3]^GG[2];
assign s[4]=p[4]^GG[3];
assign s[5]=p[5]^GG[4];
assign s[6]=p[6]^GG[5];
assign s[7]=p[7]^GG[6];
assign s[8]=p[8]^GG[7];
assign s[9]=p[9]^GG[8];
assign s[10]=p[10]^GG[9];
assign s[11]=p[11]^GG[10];
assign s[12]=p[12]^GG[11];
assign s[13]=p[13]^GG[12];
assign s[14]=p[14]^GG[13];
assign s[15]=p[15]^GG[14];
assign cout=GG[15];


endmodule

module full_adder(
	input a,b,cin,
	output s,cout
    );
	assign s=a^b^cin;
	assign cout=(a&b)|(b&cin)|(cin&a);


endmodule
module halfadder(
	input a,b,
	output s,c
    );
assign c=a&b;
assign s=a^b;

endmodule
module gray_box(
    input a,
    input b,
    input c,
    output x
	 
    );

assign x=a|(b&c);
endmodule
module inst_mem(
input [7:0]a,					//Memory Address
output  [15:0]r					//Memory data output
); 

reg [15:0]rom[255:0];				//declaration of 256X16 memory
 
  initial $readmemh("./instructions.txt",rom);	//Read and copy hex code from text file to memory 
 assign r = rom[a];				//Read from memory

endmodule

module stg_final;

	// Inputs
	reg clk;

	// Outputs
	wire [7:0] pc_out;
    wire [15:0] inst_in;
	wire [15:0] inst_out;
	wire [2:0] jmp_val;
	wire jmp;
	wire [1:0] regwr_out2;
	wire [1:0] dir_val_out2;
	wire memwr_out2;
	wire ctrl_sel_out2;
	wire wrbk_sel_out2;
	wire [2:0] aD_out2;
	wire [2:0] dir_s2_out2;
	wire [3:0] alu_sel_out2;
	wire [7:0] dir_s1_out2;
	wire [15:0] s1_out2;
	wire [15:0] s2_out2;
	wire [1:0] reg_wr_out3;
	wire mem_wr_out3;
	wire wrbk_sel_out3;
	wire [2:0] aM_out3;
	wire [2:0] aD_out3;
	wire [15:0] alu_out3;
	wire [15:0] dM_out3;
	wire [15:0] wD_rf;
	wire [1:0] w_en;
	wire [2:0] aD_rf;
	wire s1_c0;
	wire s1_c1;
	wire s2_c0;
	wire s2_c1;
	wire eop;
	wire [1:0]inita;
	wire [2:0]initb;
  wire [2:0]mem_add_tb;
  wire mem_en_tb;
  wire [15:0]mem_data_tb;
  wire [15:0] pc_3;
  wire [15:0]pc_2;
  wire [1:0]reconfig_load;
  wire [1:0]reconfig_mul;
  wire [15:0]inst_out_tb;
  //wire inst_in;
 
	// Instantiate the Unit Under Test (UUT)
	Main_Processor uut (
		.clk(clk), 
      .inst_in(inst_in),
		.pc_out(pc_out), 
		.inst_out(inst_out), 
		.jmp_val(jmp_val), 
		.jmp(jmp), 
		.regwr_out2(regwr_out2), 
		.dir_val_out2(dir_val_out2), 
		.memwr_out2(memwr_out2), 
		.ctrl_sel_out2(ctrl_sel_out2), 
		.wrbk_sel_out2(wrbk_sel_out2), 
		.aD_out2(aD_out2), 
		.dir_s2_out2(dir_s2_out2), 
		.alu_sel_out2(alu_sel_out2), 
		.dir_s1_out2(dir_s1_out2), 
		.s1_out2(s1_out2), 
		.s2_out2(s2_out2), 
		.reg_wr_out3(reg_wr_out3), 
		.mem_wr_out3(mem_wr_out3), 
		.wrbk_sel_out3(wrbk_sel_out3), 
		.aM_out3(aM_out3), 
		.aD_out3(aD_out3), 
		.alu_out3(alu_out3), 
		.dM_out3(dM_out3), 
		.wD_rf(wD_rf), 
		.w_en(w_en), 
		.aD_rf(aD_rf), 
		.s1_c0(s1_c0), 
		.s1_c1(s1_c1), 
		.s2_c0(s2_c0), 
		.s2_c1(s2_c1), 
		.eop(eop),
		.inita(inita),
      .initb(initb),
      .mem_add_tb(mem_add_tb),
      .mem_en_tb(mem_en_tb),
      .mem_data_tb(mem_data_tb),
      .pc_3(pc_3),
      .pc_2(pc_2),
      .reconfig_load(reconfig_load),
      .reconfig_mul(reconfig_mul),
      .inst_out_tb(inst_out_tb)
	);
reg [2:0] count;
always begin
#25 clk=~clk;
$display("%b \t %b",clk, count);
if(eop == 1) begin 
count=count+1;
if(count>10)
$finish;
end
end
	initial begin
		// Initialize Inputs
		clk = 0;
		count = 0;
	end
      	
endmodule

module black_box(
	input a,b,c,d,
	output x,y
    );
	 
assign x=a|(b&c);
assign y=b&d;
	 
endmodule

