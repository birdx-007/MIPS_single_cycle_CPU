module ALU(in1, in2, ALUCtrl, Sign, out, zero);
	input [31:0] in1, in2;
	input [4:0] ALUCtrl;
	input Sign;
	output reg [31:0] out;
	output zero;
	
	// Your code below

	parameter NOP=5'h0;
	parameter ADD=5'h1;
	parameter SUB=5'h2;
	parameter AND=5'h3;
	parameter OR=5'h4;
	parameter XOR=5'h5;
	parameter NOR=5'h6;
	parameter SL=5'h7;
	parameter SR=5'h8;
	parameter SLT=5'h9;
	
	assign zero=out==0;
	always@(ALUCtrl,Sign,in1,in2)begin
		case(ALUCtrl)
			NOP:begin
				out<=in2;
			end
			ADD:begin
				out<=in1+in2;
			end
			SUB:begin
				out<=in1-in2;
			end
			AND:begin
				out<=in1&in2;
			end
			OR:begin
				out<=in1|in2;
			end
			XOR:begin
				out<=in1^in2;
			end
			NOR:begin
				out<=~(in1|in2);
			end
			SL:begin
				out<=in2<<in1[4:0];
			end
			SR:begin
				if(Sign==1)begin
					out<={{32{in2[31]}},in2}>>in1[4:0];
				end
				else begin
					out<=in2>>in1[4:0];
				end
			end
			SLT:begin
				if(Sign==1)begin
					out<=(in1-in2)>>31;
				end
				else begin
					out<=(in1-in2+{{in1[31]},{31{1'b0}}}-{{in2[31]},{31{1'b0}}})>>31;
				end
			end
			default:;
		endcase
	end
	     
	// Your code above
	
endmodule