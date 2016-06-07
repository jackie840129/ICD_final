`timescale 1ns/10ps
module CLE ( clk, reset, rom_q, rom_a, sram_q, sram_a, sram_d, sram_wen, finish);
input         clk;
input         reset;
input  [7:0]  rom_q;
output [6:0]  rom_a;
input  [7:0]  sram_q;
output [9:0]  sram_a;
output [7:0]  sram_d;
output        sram_wen;
output        finish;

//parameter declaration
parameter IDLE      =3'd0;
parameter READ      =3'd1;
parameter PROCCESS  =3'd2;
parameter BFS       =3'd3;
parameter DONE      =3'd4;

//reg declaration
reg [9:0]   sum;      n_sum;
reg [6:0]   rom_a,    n_rom_a;
reg [9:0]   sram_a,   n_sram_a;
reg [7:0]   sram_d,   n_sram_d;
reg [2:0]   state,    next_state;
reg         sram_wen, n_sram_wen;
reg         finish,   n_finish;
reg         temp[0:1024];
reg         queue[0:1024];
reg [7:0]   count,n_count;
reg [9:0]   count2,n_count2; //count index of temp
reg [3:0]   count3,n_count3; //count from 1 to 9
reg [7:0]   group_num, n_group_num;
reg [9:0]   _head, n_head, _end, n_end;
//reg         s1, s2, s3, s4, s5, s6, s7, s8;


//combinational part
always@(*) begin
    _head = n_head;
    _end = n_end;
    n_finish = finish;
    n_count = count;
    n_count2 = count2;
    n_count3 = count3;
    n_sram_wen = sram_wen;
    n_sram_d = sram_d;
    n_sram_a = sram_a;
    n_rom_a = rom_a;
    n_group_num = group_num;
    case(state)
        IDLE: begin
            next_state = READ;
            n_rom_a = 0;
        end
        READ: begin   //iteration 128 times to read
            if(count < 128)begin
                for(i=0;i<8;i=i+1)
                    temp[8*count+i] = rom_q[i];
                n_count = count+1;
                n_rom_a = rom_a+1;
                next_state = READ;
            end
            else begin
                next_state = PROCESS;
            end
        end
        
        PROCCESS: begin
            if(count2 < 1024)begin
                if(temp[count2] == 1 )begin
                    queue[_head] = temp[count2];
                    n_group_num = group_num+1;
                    next_sate = BFS;
                end
                else begin
                    n_count2 = count2+1;
                end
            end
        end

        BFS: begin
            //read one of the eight index around temp[count2] each time
            if(count3 < 9)begin
                if(count2-32+(count3/3)*32-1+(count3%3) && count3!=4)begin
                    if(temp[count2-32+(count3/3)*32-1+(count3%3)] == 1)begin
                        queue[_end] = count2-32+(count3/3)*32-1+(count3%3);
                        n_end = _end+1;
                    end
                end
            end
            n_end = _end + sum;
        end

        DONE: begin
        end

end

//sequential part
always@(posedge clk or posedge reset) begin
    if(reset) begin
        state <= IDLE;
        rom_a <= 0;
        sram_a <= 0;
        sram_d <= 0;
        sram_wen <= 0 ;
        finish <= 0;
        count <= 0;
        count2 <= 0;
        count3 <= 0;
        _head <= 0;
        _end <= 0;
        group_num <= 1;
    end
    else begin
        state <= next_state;
        rom_a <= n_rom_a;
        sram_a <=n_sram_a;
        sram_d <=n_sram_d;
        sram_wem <=n_sram_wen;
        count <= n_count;
        count2 <= n_count2;
        count3 <= n_count3;
        finish <= n_finish;
        _head <= n_head;
        _end <= n_end;
        group_num <= n_group_num;
    end
end
endmodule
