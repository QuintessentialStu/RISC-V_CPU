module shifter (
    output reg [31:0] Shift_Result, // Changed to reg for procedural assignment
    input [31:0] num_shift,
    input [4:0] shift_amount, // 5 bits for shift 0 to 31
    input [1:0] shift_op      // Control for SLL, SRL, SRA
);

    wire sign_bit;
    assign sign_bit = num_shift[31];

    always @(*) begin
        case (shift_op)
            2'b00: 
                // SRL: Logical right shift (Fills MSBs with 0s)
                Shift_Result = num_shift >> shift_amount;
            2'b01: 
                // SLL: Logical left shift (Fills LSBs with 0s)
                Shift_Result = num_shift << shift_amount; 
            2'b10: 
                // SRA: Arithmetic right shift (Fills MSBs with sign_bit)
                // Verilog provides the '>>>' operator for arithmetic shift
                Shift_Result = $signed(num_shift) >>> shift_amount; 
            default: 
                Shift_Result = 32'b0; // Default/No Operation
        endcase
    end
endmodule