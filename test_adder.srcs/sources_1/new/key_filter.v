module key_filter(
    input clk,
    input rst,
    input key_in,
    output key_out
);
    reg key_in_sync1,key_in_sync2;
    reg key_in_reg1,key_in_reg2;
    wire key_in_negedge,key_in_posedge;

//---------------按键输入边沿检测----------------    
    always @(posedge clk or posedge rst)
        if (rst) begin
            key_in_sync1 <= 1'b0;
            key_in_sync2 <= 1'b0;
        end
        else begin
            key_in_sync1 <= key_in;
            key_in_sync2 <= key_in_sync1;  //将按键输入信号同步到clk时钟域，消除亚稳态
        end

    always @(posedge clk or posedge rst)
        if (rst) begin
            key_in_reg1 <= 1'b0;
            key_in_reg2 <= 1'b0;
        end
        else begin
            key_in_reg1 <= key_in_sync2;   //key_in_reg1存储当前拍的按键输入信号
            key_in_reg2 <= key_in_reg1;    //key_in_reg2存储上一拍的按键输入信号 
        end
    
    assign key_in_negedge = (!key_in_reg1) & key_in_reg2;
    assign key_in_posedge = key_in_reg1 & (!key_in_reg2);
    
//--------------20ms计数器-----------------------
    reg [19:0] cnt;
    reg en_cnt;
    reg cnt_full;
    always @(posedge clk or posedge rst)
        if (rst)
            cnt <= 20'd0;
        else if(en_cnt)
            cnt <= cnt + 1'b1;
        else
            cnt <= 20'd0;
            
    always @(posedge clk or posedge rst)
        if (rst)
            cnt_full <= 1'b0;
        else if (cnt == 20'd999_999)
            cnt_full <= 1'b1;
        else
            cnt_full <= 1'b0;
            
//--------------------消抖状态机-------------------------    
    localparam
        IDLE = 4'b0001,
        FILTER0 = 4'b0010,
        DOWN = 4'b0100,
        FILTER1 = 4'b1000; //状态定义
    reg [3:0] state;
    reg key_flag,key_state;
        
    always @(posedge clk or posedge rst)
        if (rst) begin
            en_cnt <= 1'b0;
            state <= IDLE;
            key_flag <= 1'b0;
            key_state <= 1'b1;  //复位信号位于高电平时，所有状态都回到初始态
        end
        else begin
            case(state)
                default:begin
                    state <= IDLE;
                    en_cnt <= 1'b0;
                    key_flag <= 1'b0;
                    key_state <= 1'b1;
                end
                IDLE:begin
                    key_flag <= 1'b0;
                    if(key_in_negedge)begin
                        state <= FILTER0;
                        en_cnt <= 1'b1;     //如果检测到按键输入信号下降沿，则进入按下消抖状态，同时20ms计数器开始计数
                    end
                    else
                        state <= IDLE;      //否则循环初始态
                    end
                FILTER0:begin
                    if(cnt_full)begin
                        key_flag <= 1'b1;
                        key_state <= 1'b0;
                        en_cnt <= 1'b0;
                        state <= DOWN;      //20ms计数器计满，即20ms内无抖动后，确定按键为按下状态，清空计数器，进入按下稳定状态
                    end
                    else if(key_in_posedge)begin
                        state <= IDLE;
                        en_cnt <= 1'b0;     //20ms计数器未计满时，检测到按键输入信号上升沿，说明存在抖动，回到初始态并清零计数器
                    end
                    else 
                        state <= FILTER0;   //未检测到复位信号和按键输入信号上升沿，不断循环按下消抖状态，直到计数器计满
                    end
                DOWN:begin
                    key_flag <= 1'b0;
                    if(key_in_posedge)begin
                        en_cnt <= 1'b1;
                        state <= FILTER1;   //检测到输入信号上升沿，计数器开始计数，进入按键释放消抖状态
                    end
                    else
                        state <= DOWN;      //否则循环按下稳定状态
                    end
                FILTER1:begin
                    if(cnt_full)begin
                        key_flag <= 1'b1;
                        key_state <= 1'b1;
                        en_cnt <= 1'b0;
                        state <= IDLE;      //20ms计数器计满，即20ms内无抖动后，确定按键为释放状态，清空计数器，回到初始态
                    end
                    else if(key_in_negedge)begin
                        state <= DOWN;
                        en_cnt <= 1'b0;     //20ms计数器未计满时，检测到按键输入信号下降沿，说明存在抖动，回到按下稳定状态并清零计数器
                    end
                    else 
                        state <= FILTER1;   //未检测到复位信号和按键输入信号下降沿，不断循环释放消抖状态，直到计数器计满
                    end
            endcase                        
        end    
    assign key_out = key_state;
        
endmodule