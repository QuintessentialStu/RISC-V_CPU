module comparator (
    output wire less_out,       // SLT/SLTU result
    output wire equal_out,      // Equality result
    output wire greater_out,    // Greater result
    input  [31:0] A, B,
    input  Signed_Control       // 1: signed (SLT), 0: unsigned (SLTU)
);

    // --- 1. Unsigned 32-bit Comparison using 8 x 4-bit mini_comps ---
    wire [8:0] L_u, E_u, G_u;

    // Initialize LSB stage
    assign L_u[0] = 1'b0;
    assign E_u[0] = 1'b1;
    assign G_u[0] = 1'b0;

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : comp_blocks
            mini_comp comp (
                .less_out(L_u[i+1]),
                .equal_out(E_u[i+1]),
                .greater_out(G_u[i+1]),
                .mini_comp_A(A[i*4 +: 4]),
                .mini_comp_B(B[i*4 +: 4]),
                .less_in(L_u[i]),
                .equal_in(E_u[i]),
                .greater_in(G_u[i])
            );
        end
    endgenerate

    // Equality is same for signed/unsigned
    assign equal_out = E_u[8];

    // --- 2. Signed Comparison Override ---
    // If signs differ, we can decide immediately
    wire less_signed, greater_signed;

    assign less_signed    = (A[31] & ~B[31]) | ((A[31] == B[31]) & L_u[8]);
    assign greater_signed = (~A[31] & B[31]) | ((A[31] == B[31]) & G_u[8]);

    // --- 3. Final Output Selection ---
    assign less_out    = Signed_Control ? less_signed    : L_u[8];
    assign greater_out = Signed_Control ? greater_signed : G_u[8];

endmodule

module mini_comp (
    output less_out,
    output equal_out,
    output greater_out,
    input  [3:0] mini_comp_A,
    input  [3:0] mini_comp_B,
    input  less_in,
    input  equal_in,
    input  greater_in
);

    wire [3:0] X;  // bitwise equality signals
    assign X = ~(mini_comp_A ^ mini_comp_B); // XNOR

    // Local block comparison
    wire less_i, greater_i, equal_i;
    assign equal_i   = &X;
    assign greater_i = (mini_comp_A[3] & ~mini_comp_B[3]) |
                       (X[3] & mini_comp_A[2] & ~mini_comp_B[2]) |
                       (X[3] & X[2] & mini_comp_A[1] & ~mini_comp_B[1]) |
                       (X[3] & X[2] & X[1] & mini_comp_A[0] & ~mini_comp_B[0]);

    assign less_i    = (~mini_comp_A[3] & mini_comp_B[3]) |
                       (X[3] & ~mini_comp_A[2] & mini_comp_B[2]) |
                       (X[3] & X[2] & ~mini_comp_A[1] & mini_comp_B[1]) |
                       (X[3] & X[2] & X[1] & ~mini_comp_A[0] & mini_comp_B[0]);

    // Combine with previous block results
    assign less_out    = less_i    | (equal_i & less_in);
    assign greater_out = greater_i | (equal_i & greater_in);
    assign equal_out   = equal_i   & equal_in;

endmodule