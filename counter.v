//16bit up/down counter
module counterUpDown (
                    output reg [15:0] A_count,
                    output reg  oFlow,
                    input [15:0] dataIn,
                    input up,
                    input down,
                    input load,
                    input clear,
                    input CLK);
always @ (posedge CLK, negedge clear)
if (~clear)
    A_count <= 16'b0000000000000000;
else
    begin
        if (load) A_count <= dataIn;
        else
            begin
                if (oFlow)
                    oFlow <= 0;
                if (up && A_count == 16'b1111111111111111)
                    oFlow <= 1;
                if (down && A_count == 16'b0000000000000000)
                    oFlow <= 1;
                case ({up, down})
                    2'b00: A_count <= A_count;
                    2'b01: A_count <= A_count-1;
                    2'b10: A_count <= A_count+1;
                    2'b11: A_count <= A_count;
                endcase
                
            end
    end
endmodule







