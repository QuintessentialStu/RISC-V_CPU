module logic (
    output [31:0] logic_res,
    input [31:0] logic_A, logic_B,
    input [1:0] logic_op
);
    //Getting all the operations
    wire [31:0] and_res, or_res, xor_res;
    
    assign and_res = logic_A & logic_B;
    assign or_res = logic_A | logic_B;
    assign xor_res = logic_A ^ logic_B;
    
    reg [31:0] logic_res_reg;
    always @(*) begin
        case (logic_op)
            2'b00: logic_res_reg = and_res; // and
            2'b01: logic_res_reg = or_res;     // or
            2'b10: logic_res_reg = xor_res; // xor
            default: logic_res_reg = 32'b0;
        endcase
    end
    
    assign logic_res = logic_res_reg;
endmodule 