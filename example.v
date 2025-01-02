Alg1 #(
    .BITWIDTH(32)
) alg1(
    .CLK(CLK),
    .RST(RST),
    .start_i(start_i),
    .a_i(a_i),
    .b_i(b_i),
    .done_o(done_o),
    .y_o(y_o)
);

module Alg1 #(parameter BITWIDTH = 10)(
    input wire CLK,
    input wire RST,
    input wire start_i,
    input wire [BITWIDTH:0] a_i,
    input wire [BITWIDTH:0] b_i,
    output wire done_o,
    output wire [`BITWIDTH:0] y_o
);
    parameter IDLE = 3'b000;
    parameter STEP1 = 3'b001;
    parameter STEP2 = 3'b010;
    parameter STEP3 = 3'b011;
    parameter DONE = 3'b111;

    

    // FSM state registers and wires

    reg [3:0] state_r;
    wire [3:0] state_w;

    assign state_w = state_r;

    reg [3:0] next_state_r;
    wire [3:0] next_state_w;

    assign next_state_w = next_state_r;

    // FSM state transition logic
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            state_r <= IDLE;
        end else begin
            state_r <= next_state_w;
        end
    end

    reg [3:0] count_step1_r;
    wire [3:0] count_step1_w;
    
    assign count_step1_w = count_step1_r;

    reg [3:0] step2_res_r;
    wire [3:0] step2_res_w;

    assign step2_res_w = step2_res_r;

    wire finish_step2_w;

    

    reg [3:0] count_step3_r;
    wire [3:0] count_step3_w;

    assign count_step3_w = count_step3_r;


    // Next state logic
    always @(state_w, start_i, count_step1_w, finish_step2_w, count_step3_w) begin
        case (state_w)
            IDLE: begin
                if (start_i) begin
                    next_state_r = STEP1;
                end else begin
                    next_state_r = IDLE;
                end
            end
            STEP1: begin
                if (count_step1_w == 4'd10) begin
                    next_state_r = STEP2;
                end else begin
                    next_state_r = STEP1;
                end
            end
            STEP2: begin
                if(finish_step2_w) begin
                    next_state_r = STEP3;
                end else begin
                    next_state_r = STEP2;
                end
            end
            STEP3: begin
                if(count_step3_w == 4'd10) begin
                    next_state_r = DONE;
                end else begin
                    next_state_r = STEP3;
                end
            end
            DONE: begin
                if(start_i==0) begin
                    next_state_r = IDLE;
                end else begin
                    next_state_r = DONE;
                end
            end
            default: begin
                next_state_r = IDLE;
            end
        endcase
    end

    reg  run_step1_r;
    wire run_step1_w;

    assign run_step1_w = run_step1_r;

    reg  run_step2_r;
    wire run_step2_w;

    assign run_step2_w = run_step2_r;

    reg  run_step3_r;
    wire run_step3_w;

    assign run_step3_w = run_step3_r;

    // FSM state output logic
    always @(state_w) begin
        case (state_w)
            IDLE: begin
                run_step1_r = 1'b0;
                run_step2_r = 1'b0;
                run_step3_r = 1'b0;
                done_o = 1'b0;
            end
            STEP1: begin
                run_step1_r = 1'b1;
                run_step2_r = 1'b0;
                run_step3_r = 1'b0;
                done_o = 1'b0;
            end
            STEP2: begin
                run_step1_r = 1'b0;
                run_step2_r = 1'b1;
                run_step3_r = 1'b0;
                done_o = 1'b0;
            end
            STEP3: begin
                run_step1_r = 1'b0;
                run_step2_r = 1'b0;
                run_step3_r = 1'b1;
                done_o = 1'b0;
            end
            DONE: begin
                run_step1_r = 1'b0;
                run_step2_r = 1'b0;
                run_step3_r = 1'b0;
                done_o = 1'b1;
            end
            default: begin
                run_step1_r = 1'b0;
                run_step2_r = 1'b0;
                run_step3_r = 1'b0;
                done_o = 1'b0;
            end
        endcase
    end


    // Datapath logic - Processing step 1

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            count_step1_r <= 4'd0;
        end else begin
            if (run_step1_w) begin
                count_step1_r <= count_step1_w + 4'd1;
            end
            else begin
                count_step1_r <= count_step1_w;
            end
        end
    end

    // Datapath logic - Processing step 2

    // wire [3:0] cal_step2_res_w;

    // assign cal_step2_res_w = a_i + b_i + step2_res_w;
    
    // always @(posedge CLK or posedge RST) begin
    //     if (RST) begin
    //         step2_res_r <= 4'd0;
    //     end else begin
    //         if (run_step2_w) begin
    //             step2_res_r <= cal_step2_res_w;
    //         end
    //         else begin
    //             step2_res_r <= step2_res_w;
    //         end
    //     end
    // end

    wire [3:0] caluculate_step2_input_w;

    assign cal_step2_input_w = a_i + b_i*count_step1_w;
    funct_step_2 step2(
        .CLK(CLK),
        .RST(RST),
        .a_i(a_i),
        .b_i(b_i),
        .random_input(cal_step2_input_w),
        // .random_input(a_i + b_i*count_step1_w),
        .start_i(run_step2_w),
        .step2_res_w(step2_res_o_w),
        .done(finish_step2_w)
    );

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            step2_res_r <= 4'd0;
        end else begin
            if (finish_step2_w) begin
                step2_res_r <= step2_res_o_w;
            end
            else begin
                step2_res_r <= step2_res_w;
            end
        end
    end

    // Datapath logic - Processing step 3

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            count_step3_r <= 4'd0;
        end else begin
            if (run_step3_w) begin
                count_step3_r <= count_step3_w + 4'd1;
            end
            else begin
                count_step3_r <= count_step3_w;
            end
        end
    end

    assign y_o = count_step3_w + step2_res_w;

endmodule


module pipeline_3step(
    input wire CLK,
    input wire RST,
    input wire valid_i,
    input wire [7:0] a_i,
    input wire [7:0] b_i,
    output wire [7:0] y_o,
    output wire valid_o,
);

    wire [8:0] stage0_w;
    reg  [8:0] stage0_r;

    assign stage0_w = stage0_r;

    wire [8:0] stage1_w;
    reg  [8:0] stage1_r;

    assign stage1_w = stage1_r;

    wire [8:0] stage2_w;
    reg  [8:0] stage2_r;

    assign stage2_w = stage2_r;



    wire valid_stage0_w;
    reg  valid_stage0_r;

    assign valid_stage0_w = valid_stage0_r;

    wire valid_stage1_w;
    reg  valid_stage1_r;

    assign valid_stage1_w = valid_stage1_r;

    wire valid_stage2_w;
    reg  valid_stage2_r;

    assign valid_stage2_w = valid_stage2_r;

    // Stage 0

    // ((a_i + b_i)*b_i + a_i) * b_i
    wire [8:0] cal_stage0_w;

    assign cal_stage0_w = a_i + b_i;

    wire [8:0] cal_stage1_w;
    
    assign cal_stage1_w = a_i + stage0_w*b_i;

    wire [8:0] cal_stage2_w;

    assign cal_stage2_w = stage1_w * b_i;



    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            valid_stage0_r <= 1'b0;
            valid_stage1_r <= 1'b0;
            valid_stage2_r <= 1'b0;

            stage0_r <= 9'd0;
            stage1_r <= 9'd0;
            stage2_r <= 9'd0;

        end else begin
            valid_stage0_r <= valid_i;
            valid_stage1_r <= valid_stage0_w;
            valid_stage2_r <= valid_stage1_w;

            stage0_r <= cal_stage0_w;
            stage1_r <= cal_stage1_w;
            stage2_r <= cal_stage2_w;
        end
    end

    assign y_o = stage2_w;
endmodule