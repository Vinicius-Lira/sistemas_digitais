module batalhaNaval(
                input p1_a,
                input p1_b,
                input p1_c,
                input p2_a,
                input p2_b,
                input p2_c,
                output p1,
                output p2);

    reg s1_e, s2_e;
    //wire [2:0] p1_bundle;
    //wire [2:0] p2_bundle;
    //assign p1 = (p1_a ~^ p2_a) & (p1_b ~^ p2_b) & (p1_c ~^ p2_c);
    //assign p2 = (p1_a ^ p2_a) & (p1_b ^ p2_b) & (p1_c ^ p2_c);

    //assign p1_bundle = {p1_a, p1_b, p1_c};
    //assign p2_bundle = {p2_a, p2_b, p2_c};
    //assign s1_e = p1_bundle ~^ p2_bundle;
    //assign s2_e = p1_bundle ^ p2_bundle;

    always @(p1_a, p1_b, p1_c, p2_a, p2_b, p2_c)
    begin
        s1_e <= (p1_a ~^ p2_a) & (p1_b ~^ p2_b) & (p1_c ~^ p2_c);
        s2_e <= (p1_a ^ p2_a) || (p1_b ^ p2_b) || (p1_c ^ p2_c);
    end
endmodule

module test;

    reg p1_a, p1_b, p1_c, p2_a, p2_b, p2_c;
    wire s1, s2;

    batalhaNaval B(p1_a, p1_b, p1_c, p2_a, p2_b, p2_c, s1, s2);
    initial begin
        $dumpvars (0, B);
        #2;
        p1_a <= 0; p1_b <= 0; p1_c <= 0; p2_a <= 0; p2_b <= 0; p2_c <= 0;
        #2;
        p1_a <= 1; p1_b <= 1; p1_c <= 0; p2_a <= 1; p2_b <= 1; p2_c <= 0;
        #2;
        p1_a <= 0; p1_b <= 0; p1_c <= 1; p2_a <= 0; p2_b <= 1; p2_c <= 1;
        #2;
        p1_a <= 1; p1_b <= 1; p1_c <= 0; p2_a <= 0; p2_b <= 1; p2_c <= 1;
        #2;
    end
endmodule
