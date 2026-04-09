module key_cnt(
    input key0,key1
    );
    reg [4:0] key0_cnt = 0;
    reg sel = 0;
    reg [4:0] sum1_1,sum1_2,sum2_1,sum2_2;
    
    always @(posedge key1) begin
        sel = sel + 1;
        key0_cnt = 0;
            
    end
    
    always @(posedge key0) begin
        if (key0_cnt < 9)
            key0_cnt = key0_cnt + 1;
        else
            key0_cnt = 0;
        case(sel)
            0: sum1_1 = key0_cnt;
            1: sum1_2 = key0_cnt;
            2: sum2_1 = key0_cnt;
            3: sum2_2 = key0_cnt;
        endcase
    end        
    
    num_input u1(.sel(sel),.sum(key0_cnt)); //按5次key1以后，进行加法运算
    
endmodule