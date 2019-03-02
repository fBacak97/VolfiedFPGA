
`timescale 1ns / 1ps

module deneme(input logic CLOCK, 
              input logic rightButton, leftButton, upButton, downButton, resetButton,
              input logic rightSwitch, leftSwitch, upSwitch, downSwitch,
              output logic a, b, c, d, e, f, g, dp, //individual LED output for the 7-segment along with the digital point
              output logic [3:0] an,              
              output logic SH_CP, ST_CP, reset, DS, OE,
              output logic[7:0] KATOT);
    logic [23:0] msg ;
    logic [7:0] kirmizi, yesil, mavi;
    logic [3:0] in0;
    logic [3:0] in1;
    logic [3:0] in2;
    logic [3:0] in3;
    logic [3:0] redScore = 0; 
    logic [3:0] blueScore = 0;
    
       
    logic [7:0] initialgreen = 0;
    
    logic [7:0] initialred0 = 8'b00000000;
    logic [7:0] initialred1 = 8'b00000010;
    logic [7:0] initialred2 = 8'b00000000;
    logic [7:0] initialred3 = 8'b00000000;
    logic [7:0] initialred4 = 8'b00000000;
    logic [7:0] initialred5 = 8'b00000000;
    logic [7:0] initialred6 = 8'b10000000;
    logic [7:0] initialred7 = 8'b00000000;
     
    logic [7:0] initialblue0 = 8'b00000000;
    logic [7:0] initialblue1 = 8'b00000000;
    logic [7:0] initialblue3 = 8'b00000000;
    logic [7:0] initialblue2 = 8'b00000000;
    logic [7:0] initialblue4 = 8'b00000000;
    logic [7:0] initialblue5 = 8'b00000000;    
    logic [7:0] initialblue6 = 8'b10000000;
    logic [7:0] initialblue7 = 8'b00000000;
    logic [7:0] tmpblue;
    logic [7:0] initialrow = 8'b01000000;
    logic [2:0] initialcolumn = 3'b111;
    logic [7:0] initialrowX = 8'b00000010;
    logic [2:0] initialcolumnX = 3'b001;
    int score = 0;
   
                                    
    assign msg[23:16] = kirmizi;
    assign msg[15:8]  = yesil;
    assign msg[7:0]   = mavi;

    logic t;
    logic z;

    logic [10:0] counter=0;
    logic [8:0] index = 1; //i
    logic [6:0] frame = 0; //d
    logic [2:0] rowNum= 0; //a

    always @(posedge CLOCK)
        counter = counter+1;
    
    assign z = counter[10];
    assign t = ~z;

    always @(posedge t)
        index = index +1;

    always_comb
    begin
        if (index<4)
            reset=0;
       else
            reset=1;


        if (index>3 && index<28)
             DS=msg[index-3];
        else
            DS=0;

        if (index<28)
        begin
            SH_CP=z;
            ST_CP=t;
        end
       else
         begin
        SH_CP=0;
        ST_CP=1;
         end
    end//of always_comb

    always@ (posedge z)
    begin
        if (index>28 && index<409)
            OE<=0;
    else
            OE<=1;
        if (index== 410)
        begin
          rowNum <= rowNum+1;
            if (rowNum==7)
            begin
                if(resetButton)
                begin
                initialblue0 <= 8'b00000000;
                initialblue1 <= 8'b00000000;
                initialblue3 <= 8'b00000000;
                initialblue2 <= 8'b00000000;
                initialblue4 <= 8'b00000000;
                initialblue5 <= 8'b00000000;    
                initialblue6 <= 8'b10000000;
                initialblue7 <= 8'b00000000;
            
                initialred0 <= 8'b00000000;
                initialred1 <= 8'b00000010;
                initialred2 <= 8'b00000000;
                initialred3 <= 8'b00000000;
                initialred4 <= 8'b00000000;
                initialred5 <= 8'b00000000;
                initialred6 <= 8'b10000000;
                initialred7 <= 8'b00000000;
                
                initialrow <= 8'b01000000;
                initialcolumn <= 3'b111;
                initialrowX <= 8'b00000010;
                initialcolumnX <= 3'b001;        
                
                blueScore<= 0;
                redScore<= 0;
                score<=0;
                end                             
            
                if (score >= 25)
                begin
                blueScore <= blueScore + 1;
                initialblue0 <= 8'b00000000;
                initialblue1 <= 8'b00000000;
                initialblue3 <= 8'b00000000;
                initialblue2 <= 8'b00000000;
                initialblue4 <= 8'b00000000;
                initialblue5 <= 8'b00000000;    
                initialblue6 <= 8'b10000000;
                initialblue7 <= 8'b00000000;
                
                initialred0 <= 8'b00000000;
                initialred1 <= 8'b00000010;
                initialred2 <= 8'b00000000;
                initialred3 <= 8'b00000000;
                initialred4 <= 8'b00000000;
                initialred5 <= 8'b00000000;
                initialred6 <= 8'b10000000;
                initialred7 <= 8'b00000000;
                
                initialrow <= 8'b01000000;
                initialcolumn <= 3'b111;
                initialrowX <= 8'b00000010;
                initialcolumnX <= 3'b001;
                score <= 0;
                                                
                end
                else
                begin 
                if(rightButton)
                begin
                if(initialrow == 8'b00001000)
                begin
                if(initialblue2[initialcolumn] == 0)
                    score <= score + 1;
                initialblue2[initialcolumn] <= initialblue3[initialcolumn];
                initialred2[initialcolumn] <= initialred3[initialcolumn];
                initialred3[initialcolumn] <= 0;
                end
                else if(initialrow == 8'b00000100)
                begin
                if(initialblue1[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue1[initialcolumn] <= initialblue2[initialcolumn];
                initialred1[initialcolumn] <= initialred2[initialcolumn];
                initialred2[initialcolumn] <= 0;
                end               
                else if(initialrow == 8'b00000010)
                begin
                if(initialblue0[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue0[initialcolumn] <= initialblue1[initialcolumn];
                initialred0[initialcolumn] <= initialred1[initialcolumn];
                initialred1[initialcolumn] <= 0;
                end
                else if(initialrow == 8'b00000001)
                begin
                if(initialblue7[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue7[initialcolumn] <= initialblue0[initialcolumn];
                initialred7[initialcolumn] <= initialred0[initialcolumn];
                initialred0[initialcolumn] <= 0;
                end
                else if(initialrow == 8'b10000000)
                begin
                if(initialblue6[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue6[initialcolumn] <= initialblue7[initialcolumn];
                initialred6[initialcolumn] <= initialred7[initialcolumn];
                initialred7[initialcolumn] <= 0;
                end
                else if(initialrow == 8'b01000000)
                begin
                if(initialblue5[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue5[initialcolumn] <= initialblue6[initialcolumn];    
                initialred5[initialcolumn] <= initialred6[initialcolumn];
                initialred6[initialcolumn] <= 0;
                end 
                else if(initialrow == 8'b00100000)
                begin
                if(initialblue4[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue4[initialcolumn] <= initialblue5[initialcolumn];
                initialred4[initialcolumn] <= initialred5[initialcolumn];
                initialred5[initialcolumn] <= 0;
                end
                else
                begin
                if(initialblue3[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue3[initialcolumn] <= initialblue4[initialcolumn]; 
                initialred3[initialcolumn] <= initialred4[initialcolumn];
                initialred4[initialcolumn] <= 0;
                end 

                if(initialrow == 1)
                initialrow <= 8'b10000000;
                else
                initialrow <= initialrow/2;
                                  
                end 
                else if(leftButton)
                begin
                if(initialrow == 8'b00001000)
                begin
                if(initialblue4[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue4[initialcolumn] <= initialblue3[initialcolumn];
                initialred4[initialcolumn] <= initialred3[initialcolumn];
                initialred3[initialcolumn] <= 0;
                end
                else if(initialrow == 8'b00000100)
                begin
                if(initialblue3[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue3[initialcolumn] <= initialblue2[initialcolumn];
                initialred3[initialcolumn] <= initialred2[initialcolumn];
                initialred2[initialcolumn] <= 0;
                end
                else if(initialrow == 8'b00000010)
                begin
                if(initialblue2[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue2[initialcolumn] <= initialblue1[initialcolumn];
                initialred2[initialcolumn] <= initialred1[initialcolumn];
                initialred1[initialcolumn] <= 0;
                end
                else if(initialrow == 8'b00000001)
                begin
                if(initialblue1[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue1[initialcolumn] <= initialblue0[initialcolumn];
                initialred1[initialcolumn] <= initialred0[initialcolumn];
                initialred0[initialcolumn] <= 0;
                end
                else if(initialrow == 8'b10000000)
                begin
                if(initialblue0[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue0[initialcolumn] <= initialblue7[initialcolumn];
                initialred0[initialcolumn] <= initialred7[initialcolumn];
                initialred7[initialcolumn] <= 0;
                end
                else if(initialrow == 8'b01000000)
                begin
                if(initialblue7[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue7[initialcolumn] <= initialblue6[initialcolumn];
                initialred7[initialcolumn] <= initialred6[initialcolumn];
                initialred6[initialcolumn] <= 0;
                end 
                else if(initialrow == 8'b00100000)
                begin
                if(initialblue6[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue6[initialcolumn] <= initialblue5[initialcolumn];
                initialred6[initialcolumn] <= initialred5[initialcolumn];
                initialred5[initialcolumn] <= 0;
                end
                else
                begin
                if(initialblue5[initialcolumn] == 0)
                    score <= score + 1;                
                initialblue5[initialcolumn] <= initialblue4[initialcolumn];
                initialred5[initialcolumn] <= initialred4[initialcolumn];
                initialred4[initialcolumn] <= 0;
                end
                if(initialrow == 8'b10000000)
                initialrow <= 8'b00000001;
                else
                initialrow <= initialrow*2;
                             
                end
                
                else if(downButton)
                begin
                if(initialrow == 8'b01000000)
                begin
                  if(initialcolumn == 0)                  
                  begin
                  if(initialblue6[7] == 0)
                      score <= score + 1;                 
                    initialblue6[7] <= initialblue6[initialcolumn];
                    initialred6[7] <= initialred6[initialcolumn];
                    initialred6[initialcolumn] <= 0;
                    end
                  else
                  begin
                    if(initialblue6[initialcolumn-1] == 0)
                      score <= score + 1;                  
                    initialblue6[initialcolumn - 1] <= initialblue6[initialcolumn];
                    initialred6[initialcolumn - 1] <= initialred6[initialcolumn];
                    initialred6[initialcolumn] <= 0;
                    end
                end      
                else if (initialrow == 8'b10000000)
                begin
                  if(initialcolumn == 0) 
                  begin                 
                    if(initialblue7[7] == 0)
                      score <= score + 1;                  
                    initialblue7[7] <= initialblue7[initialcolumn];
                    initialred7[7] <= initialred7[initialcolumn];
                    initialred7[initialcolumn] <= 0;
                    end
                  else
                  begin
                    if(initialblue7[initialcolumn-1] == 0)
                      score <= score + 1;                
                    initialblue7[initialcolumn - 1] <= initialblue7[initialcolumn];    
                    initialred7[initialcolumn - 1] <= initialred7[initialcolumn];
                    initialred7[initialcolumn] <= 0;
                    end
                end            
                
                else if (initialrow == 8'b00100000)
                begin
                  if(initialcolumn == 0)         
                  begin
                    if(initialblue5[7] == 0)
                      score <= score + 1;                          
                    initialblue5[7] <= initialblue5[initialcolumn];
                    initialred5[7] <= initialred5[initialcolumn];
                    initialred5[initialcolumn] <= 0;
                    end                    
                  else
                  begin
                    if(initialblue5[initialcolumn-1] == 0)
                      score <= score + 1;                 
                    initialblue5[initialcolumn - 1] <= initialblue5[initialcolumn];
                    initialred5[initialcolumn - 1] <= initialred5[initialcolumn];
                    initialred5[initialcolumn] <= 0;    
                    end
                end  
                
                else if (initialrow == 8'b00010000)
                begin
                  if(initialcolumn == 0) 
                  begin                 
                    if(initialblue4[7] == 0)
                      score <= score + 1;                
                    initialblue4[7] <= initialblue4[initialcolumn];
                    initialred4[7] <= initialred4[initialcolumn];
                    initialred4[initialcolumn] <= 0;
                    end                    
                  else
                  begin
                    if(initialblue4[initialcolumn-1] == 0)
                      score <= score + 1;                 
                    initialblue4[initialcolumn - 1] <= initialblue4[initialcolumn];
                    initialred4[initialcolumn - 1] <= initialred4[initialcolumn];
                    initialred4[initialcolumn] <= 0;    
                    end
                end            
      
                else if (initialrow == 8'b00001000)
                begin
                  if(initialcolumn == 0)   
                  begin        
                    if(initialblue3[7] == 0)
                      score <= score + 1;                         
                    initialblue3[7] <= initialblue3[initialcolumn];
                    initialred3[7] <= initialred3[initialcolumn];
                    initialred3[initialcolumn] <= 0;
                    end                    
                  else
                  begin
                    if(initialblue3[initialcolumn-1] == 0)
                      score <= score + 1;                
                    initialblue3[initialcolumn - 1] <= initialblue3[initialcolumn];
                    initialred3[initialcolumn - 1] <= initialred3[initialcolumn];
                    initialred3[initialcolumn] <= 0;  
                    end  
                end            
               
                else if (initialrow == 8'b00000100)
                begin
                  if(initialcolumn == 0)   
                  begin             
                    if(initialblue2[7] == 0)
                      score <= score + 1;                   
                    initialblue2[7] <= initialblue2[initialcolumn];
                    initialred2[7] <= initialred2[initialcolumn];
                    initialred2[initialcolumn] <= 0;
                    end                    
                  else
                  begin
                    if(initialblue2[initialcolumn-1] == 0)
                      score <= score + 1;                  
                    initialblue2[initialcolumn - 1] <= initialblue2[initialcolumn];
                    initialred2[initialcolumn - 1] <= initialred2[initialcolumn];
                    initialred2[initialcolumn] <= 0; 
                    end   
                end            
                
                else if (initialrow == 8'b00000010)
                begin
                  if(initialcolumn == 0)   
                  begin               
                    if(initialblue1[7] == 0)
                      score <= score + 1;                  
                    initialblue1[7] <= initialblue1[initialcolumn];
                    initialred1[7] <= initialred1[initialcolumn];
                    initialred1[initialcolumn] <= 0; 
                    end                   
                  else
                  begin
                    if(initialblue1[initialcolumn-1] == 0)
                      score <= score + 1;            
                    initialblue1[initialcolumn - 1] <= initialblue1[initialcolumn];
                    initialred1[initialcolumn - 1] <= initialred1[initialcolumn];
                    initialred1[initialcolumn] <= 0;  
                    end  
                end            
                
                else if (initialrow == 8'b00000001)
                begin
                  if(initialcolumn == 0)
                  begin                  
                    if(initialblue0[7] == 0)
                      score <= score + 1;             
                    initialblue0[7] <= initialblue0[initialcolumn];
                    initialred0[7] <= initialred0[initialcolumn];
                    initialred0[initialcolumn] <= 0; 
                    end                   
                  else
                  begin
                    if(initialblue0[initialcolumn-1] == 0)
                      score <= score + 1;                 
                    initialblue0[initialcolumn - 1] <= initialblue0[initialcolumn];
                    initialred0[initialcolumn - 1] <= initialred0[initialcolumn];
                    initialred0[initialcolumn] <= 0; 
                    end   
                end            
                                                
                if (initialcolumn == 0)
                    initialcolumn <= 7;
                else
                    initialcolumn <= initialcolumn - 1;   
                                                       
                end
                
                else if(upButton)
                begin
                if(initialrow == 8'b01000000)
                begin
                  if(initialcolumn == 7) 
                  begin
                    if(initialblue6[0] == 0)
                      score <= score + 1;                                
                    initialblue6[0] <= initialblue6[initialcolumn];
                    initialred6[0] <= initialred6[initialcolumn];
                    initialred6[initialcolumn] <= 0;
                    end
                  else
                  begin
                   if(initialblue6[initialcolumn+1] == 0)
                      score <= score + 1;                
                    initialblue6[initialcolumn + 1] <= initialblue6[initialcolumn];
                    initialred6[initialcolumn + 1] <= initialred6[initialcolumn];
                    initialred6[initialcolumn] <= 0;
                    end
                end      
                else if (initialrow == 8'b10000000)
                begin
                  if(initialcolumn == 7)
                  begin                  
                    if(initialblue7[0] == 0)
                      score <= score + 1;                  
                    initialblue7[0] <= initialblue7[initialcolumn];
                    initialred7[0] <= initialred7[initialcolumn];
                    initialred7[initialcolumn] <= 0;
                    end
                  else
                  begin
                    if(initialblue7[initialcolumn+1] == 0)
                      score <= score + 1;                  
                    initialblue7[initialcolumn + 1] <= initialblue7[initialcolumn];
                    initialred7[initialcolumn + 1] <= initialred7[initialcolumn];
                    initialred7[initialcolumn] <= 0;   
                    end 
                end            
                
                else if (initialrow == 8'b00100000)
                begin
                  if(initialcolumn == 7)
                  begin                  
                    if(initialblue5[0] == 0)
                      score <= score + 1;                  
                    initialblue5[0] <= initialblue5[initialcolumn];
                    initialred5[0] <= initialred5[initialcolumn];
                    initialred5[initialcolumn] <= 0;
                    end
                  else
                  begin
                    if(initialblue5[initialcolumn+1] == 0)
                      score <= score + 1;
                    initialblue5[initialcolumn + 1] <= initialblue5[initialcolumn];  
                    initialred5[initialcolumn + 1] <= initialred5[initialcolumn];
                    initialred5[initialcolumn] <= 0;
                    end
                end  
                
                else if (initialrow == 8'b00010000)
                begin
                  if(initialcolumn == 7)            
                  begin      
                    if(initialblue4[0] == 0)
                      score <= score + 1;
                    initialblue4[0] <= initialblue4[initialcolumn];
                    initialred4[0] <= initialred4[initialcolumn];
                    initialred4[initialcolumn] <= 0;
                    end
                  else
                  begin
                    if(initialblue4[initialcolumn+1] == 0)
                      score <= score + 1;                  
                    initialblue4[initialcolumn + 1] <= initialblue4[initialcolumn];
                    initialred4[initialcolumn + 1] <= initialred4[initialcolumn];
                    initialred4[initialcolumn] <= 0;
                    end
                end            
      
                else if (initialrow == 8'b00001000)
                begin
                  if(initialcolumn == 7)
                  begin                  
                    if(initialblue3[0] == 0)
                      score <= score + 1;                  
                    initialblue3[0] <= initialblue3[initialcolumn];
                    initialred3[0] <= initialred3[initialcolumn];
                    initialred3[initialcolumn] <= 0;
                    end
                  else
                  begin
                    if(initialblue3[initialcolumn+1] == 0)
                      score <= score + 1;
                    initialblue3[initialcolumn + 1] <= initialblue3[initialcolumn];
                    initialred3[initialcolumn + 1] <= initialred3[initialcolumn];
                    initialred3[initialcolumn] <= 0;
                    end
                end            
               
                else if (initialrow == 8'b00000100)
                begin
                  if(initialcolumn == 7)
                  begin                  
                    if(initialblue2[0] == 0)
                      score <= score + 1;                  
                    initialblue2[0] <= initialblue2[initialcolumn];
                    initialred2[0] <= initialred2[initialcolumn];
                    initialred2[initialcolumn] <= 0;
                    end
                  else
                  begin
                    if(initialblue2[initialcolumn+1] == 0)
                      score <= score + 1;                  
                    initialblue2[initialcolumn + 1] <= initialblue2[initialcolumn];
                    initialred2[initialcolumn + 1] <= initialred2[initialcolumn];
                    initialred2[initialcolumn] <= 0;
                    end
                end            
                
                else if (initialrow == 8'b00000010)
                begin
                  if(initialcolumn == 7)
                  begin                  
                    if(initialblue1[0] == 0)
                      score <= score + 1;                  
                    initialblue1[0] <= initialblue1[initialcolumn];
                    initialred1[0] <= initialred1[initialcolumn];
                    initialred1[initialcolumn] <= 0;
                    end
                  else
                  begin
                    if(initialblue1[initialcolumn+1] == 0)
                      score <= score + 1;                  
                    initialblue1[initialcolumn + 1] <= initialblue1[initialcolumn];
                    initialred1[initialcolumn + 1] <= initialred1[initialcolumn];
                    initialred1[initialcolumn] <= 0;
                    end
                end            
                
                else if (initialrow == 8'b00000001)
                begin
                  if(initialcolumn == 7)
                  begin                  
                    if(initialblue0[0] == 0)
                      score <= score + 1;                  
                    initialblue0[0] <= initialblue0[initialcolumn];
                    initialred0[0] <= initialred0[initialcolumn];
                    initialred0[initialcolumn] <= 0;
                    end
                  else
                  begin
                    if(initialblue0[initialcolumn + 1] == 0)
                      score <= score + 1;                  
                    initialblue0[initialcolumn + 1] <= initialblue0[initialcolumn];
                    initialred0[initialcolumn + 1] <= initialred0[initialcolumn];
                    initialred0[initialcolumn] <= 0;
                    end
                end            
                                                
                if (initialcolumn == 7)
                    initialcolumn <= 0;
                else
                    initialcolumn <= initialcolumn +1;
                                                        
                end
 //////////////////////////////////////////////////////////////////               
                if(rightSwitch)
                begin
                if(initialrowX == 8'b00001000)
                begin
                initialred2[initialcolumnX] <= initialred3[initialcolumnX];
                initialred3[initialcolumnX] <= 0;
                end
                else if(initialrowX == 8'b00000100)
                begin
                initialred1[initialcolumnX] <= initialred2[initialcolumnX];
                initialred2[initialcolumnX] <= 0;
                end               
                else if(initialrowX == 8'b00000010)
                begin
                initialred0[initialcolumnX] <= initialred1[initialcolumnX];
                initialred1[initialcolumnX] <= 0;
                end
                else if(initialrowX == 8'b00000001)
                begin
                initialred7[initialcolumnX] <= initialred0[initialcolumnX];
                initialred0[initialcolumnX] <= 0;
                end
                else if(initialrowX == 8'b10000000)
                begin
                initialred6[initialcolumnX] <= initialred7[initialcolumnX];
                initialred7[initialcolumnX] <= 0;
                end
                else if(initialrowX == 8'b01000000)
                begin    
                initialred5[initialcolumnX] <= initialred6[initialcolumnX];
                initialred6[initialcolumnX] <= 0;
                end 
                else if(initialrowX == 8'b00100000)
                begin
                initialred4[initialcolumnX] <= initialred5[initialcolumnX];
                initialred5[initialcolumnX] <= 0;
                end
                else
                begin 
                initialred3[initialcolumnX] <= initialred4[initialcolumnX];
                initialred4[initialcolumnX] <= 0;
                end 

                if(initialrowX == 1)
                initialrowX <= 8'b10000000;
                else
                initialrowX <= initialrowX/2;      
                end 
                
                else if(leftSwitch)
                begin
                if(initialrowX == 8'b00001000)
                begin
                initialred4[initialcolumnX] <= initialred3[initialcolumnX];
                initialred3[initialcolumnX] <= 0;
                end
                else if(initialrowX == 8'b00000100)
                begin
                initialred3[initialcolumnX] <= initialred2[initialcolumnX];
                initialred2[initialcolumnX] <= 0;
                end
                else if(initialrowX == 8'b00000010)
                begin
                initialred2[initialcolumnX] <= initialred1[initialcolumnX];
                initialred1[initialcolumnX] <= 0;
                end
                else if(initialrowX == 8'b00000001)
                begin
                initialred1[initialcolumnX] <= initialred0[initialcolumnX];
                initialred0[initialcolumnX] <= 0;
                end
                else if(initialrowX == 8'b10000000)
                begin
                initialred0[initialcolumnX] <= initialred7[initialcolumnX];
                initialred7[initialcolumnX] <= 0;
                end
                else if(initialrowX == 8'b01000000)
                begin
                initialred7[initialcolumnX] <= initialred6[initialcolumnX];
                initialred6[initialcolumnX] <= 0;
                end 
                else if(initialrowX == 8'b00100000)
                begin
                initialred6[initialcolumnX] <= initialred5[initialcolumnX];
                initialred5[initialcolumnX] <= 0;
                end
                else
                begin
                initialred5[initialcolumnX] <= initialred4[initialcolumnX];
                initialred4[initialcolumnX] <= 0;
                end
                if(initialrowX == 8'b10000000)
                initialrowX <= 8'b00000001;
                else
                initialrowX <= initialrowX*2;
                end
                
                else if(downSwitch)
                begin
                if(initialrowX == 8'b01000000)
                begin
                  if(initialcolumnX == 0)                  
                  begin
                    initialred6[7] <= initialred6[initialcolumnX];
                    initialred6[initialcolumnX] <= 0;
                    end
                  else
                  begin
                    initialred6[initialcolumnX - 1] <= initialred6[initialcolumnX];
                    initialred6[initialcolumnX] <= 0;
                    end
                end      
                else if (initialrowX == 8'b10000000)
                begin
                  if(initialcolumnX == 0) 
                  begin                 
                    initialred7[7] <= initialred7[initialcolumnX];
                    initialred7[initialcolumnX] <= 0;
                    end
                  else
                  begin    
                    initialred7[initialcolumnX - 1] <= initialred7[initialcolumnX];
                    initialred7[initialcolumnX] <= 0;
                    end
                end            
                
                else if (initialrowX == 8'b00100000)
                begin
                  if(initialcolumnX == 0)         
                  begin         
                    initialred5[7] <= initialred5[initialcolumnX];
                    initialred5[initialcolumnX] <= 0;
                    end                    
                  else
                  begin
                    initialred5[initialcolumnX - 1] <= initialred5[initialcolumnX];
                    initialred5[initialcolumnX] <= 0;    
                    end
                end  
                
                else if (initialrowX == 8'b00010000)
                begin
                  if(initialcolumnX == 0) 
                  begin                 
                    initialred4[7] <= initialred4[initialcolumnX];
                    initialred4[initialcolumnX] <= 0;
                    end                    
                  else
                  begin
                    initialred4[initialcolumnX - 1] <= initialred4[initialcolumnX];
                    initialred4[initialcolumnX] <= 0;    
                    end
                end            
      
                else if (initialrowX == 8'b00001000)
                begin
                  if(initialcolumnX == 0)   
                  begin               
                    initialred3[7] <= initialred3[initialcolumnX];
                    initialred3[initialcolumnX] <= 0;
                    end                    
                  else
                  begin
                    initialred3[initialcolumnX - 1] <= initialred3[initialcolumnX];
                    initialred3[initialcolumnX] <= 0;  
                    end  
                end            
               
                else if (initialrowX == 8'b00000100)
                begin
                  if(initialcolumnX == 0)   
                  begin               
                    initialred2[7] <= initialred2[initialcolumnX];
                    initialred2[initialcolumnX] <= 0;
                    end                    
                  else
                  begin
                    initialred2[initialcolumnX - 1] <= initialred2[initialcolumnX];
                    initialred2[initialcolumnX] <= 0; 
                    end   
                end            
                
                else if (initialrowX == 8'b00000010)
                begin
                  if(initialcolumnX == 0)   
                  begin               
                    initialred1[7] <= initialred1[initialcolumnX];
                    initialred1[initialcolumnX] <= 0; 
                    end                   
                  else
                  begin
                    initialred1[initialcolumnX - 1] <= initialred1[initialcolumnX];
                    initialred1[initialcolumnX] <= 0;  
                    end  
                end            
                
                else if (initialrowX == 8'b00000001)
                begin
                  if(initialcolumnX == 0)
                  begin                  
                    initialred0[7] <= initialred0[initialcolumnX];
                    initialred0[initialcolumnX] <= 0; 
                    end                   
                  else
                  begin
                    initialred0[initialcolumnX - 1] <= initialred0[initialcolumnX];
                    initialred0[initialcolumnX] <= 0; 
                    end   
                end            
                                                
                if (initialcolumnX == 0)
                    initialcolumnX <= 7;
                else
                    initialcolumnX <= initialcolumnX - 1;                                   
                end
                
                else if(upSwitch)
                begin
                if(initialrowX == 8'b01000000)
                begin
                  if(initialcolumnX == 7) 
                  begin                 
                    initialred6[0] <= initialred6[initialcolumnX];
                    initialred6[initialcolumnX] <= 0;
                    end
                  else
                  begin
                    initialred6[initialcolumnX + 1] <= initialred6[initialcolumnX];
                    initialred6[initialcolumnX] <= 0;
                    end
                end      
                else if (initialrowX == 8'b10000000)
                begin
                  if(initialcolumnX == 7)
                  begin                  
                    initialred7[0] <= initialred7[initialcolumnX];
                    initialred7[initialcolumnX] <= 0;
                    end
                  else
                  begin
                    initialred7[initialcolumnX + 1] <= initialred7[initialcolumnX];
                    initialred7[initialcolumnX] <= 0;   
                    end 
                end            
                
                else if (initialrowX == 8'b00100000)
                begin
                  if(initialcolumnX == 7)
                  begin                  
                    initialred5[0] <= initialred5[initialcolumnX];
                    initialred5[initialcolumnX] <= 0;
                    end
                  else
                  begin  
                    initialred5[initialcolumnX + 1] <= initialred5[initialcolumnX];
                    initialred5[initialcolumnX] <= 0;
                    end
                end  
                
                else if (initialrowX == 8'b00010000)
                begin
                  if(initialcolumnX == 7)            
                  begin      
                    initialred4[0] <= initialred4[initialcolumnX];
                    initialred4[initialcolumnX] <= 0;
                    end
                  else
                  begin
                    initialred4[initialcolumnX + 1] <= initialred4[initialcolumnX];
                    initialred4[initialcolumnX] <= 0;
                    end
                end            
      
                else if (initialrowX == 8'b00001000)
                begin
                  if(initialcolumnX == 7)
                  begin                  
                    initialred3[0] <= initialred3[initialcolumnX];
                    initialred3[initialcolumnX] <= 0;
                    end
                  else
                  begin
                    initialred3[initialcolumnX + 1] <= initialred3[initialcolumnX];
                    initialred3[initialcolumnX] <= 0;
                    end
                end            
               
                else if (initialrowX == 8'b00000100)
                begin
                  if(initialcolumnX == 7)
                  begin                  
                    initialred2[0] <= initialred2[initialcolumnX];
                    initialred2[initialcolumnX] <= 0;
                    end
                  else
                  begin
                    initialred2[initialcolumnX + 1] <= initialred2[initialcolumnX];
                    initialred2[initialcolumnX] <= 0;
                    end
                end            
                
                else if (initialrowX == 8'b00000010)
                begin
                  if(initialcolumnX == 7)
                  begin                  
                    initialred1[0] <= initialred1[initialcolumnX];
                    initialred1[initialcolumnX] <= 0;
                    end
                  else
                  begin
                    initialred1[initialcolumnX + 1] <= initialred1[initialcolumnX];
                    initialred1[initialcolumnX] <= 0;
                    end
                end            
                
                else if (initialrowX == 8'b00000001)
                begin
                  if(initialcolumnX == 7)
                  begin                  
                    initialred0[0] <= initialred0[initialcolumnX];
                    initialred0[initialcolumnX] <= 0;
                    end
                  else
                  begin
                    initialred0[initialcolumnX + 1] <= initialred0[initialcolumnX];
                    initialred0[initialcolumnX] <= 0;
                    end
                end            
                                                
                if (initialcolumnX == 7)
                    initialcolumnX <= 0;
                else
                    initialcolumnX <= initialcolumnX +1;                                   
                end
                
                if(initialcolumn == initialcolumnX && initialrow == initialrowX)
                begin
                redScore <= redScore + 1;
                initialblue0 <= 8'b00000000;
                initialblue1 <= 8'b00000000;
                initialblue3 <= 8'b00000000;
                initialblue2 <= 8'b00000000;
                initialblue4 <= 8'b00000000;
                initialblue5 <= 8'b00000000;    
                initialblue6 <= 8'b10000000;
                initialblue7 <= 8'b00000000;
                
                initialred0 <= 8'b00000000;
                initialred1 <= 8'b00000010;
                initialred2 <= 8'b00000000;
                initialred3 <= 8'b00000000;
                initialred4 <= 8'b00000000;
                initialred5 <= 8'b00000000;
                initialred6 <= 8'b10000000;
                initialred7 <= 8'b00000000;
                
                initialrow <= 8'b01000000;
                initialcolumn <= 3'b111;
                initialrowX <= 8'b00000010;
                initialcolumnX <= 3'b001;
                score <= 0;                
                
                end
                                  
               end
            end   
        end
    end

    always_comb//harfler
    begin
        if (rowNum==0) begin
            KATOT<=8'b10000000;
        end
        else if(rowNum==1)  begin
            KATOT<=8'b01000000;
        end
        else if (rowNum==2)  begin
            KATOT<=8'b00100000;
        end
        else if (rowNum==3)  begin
            KATOT<=8'b00010000;
        end
        else if (rowNum==4)  begin
            KATOT<=8'b00001000;
        end
        else if (rowNum==5)  begin
            KATOT<=8'b00000100;
        end
        else if (rowNum==6)  begin
            KATOT<=8'b00000010;
        end
        else
            KATOT<=8'b00000001;
            
        in0 <= redScore;    
        in3 <= blueScore;
        in2 <= score / 10;
        in1 <= score % 10;
                       
        if (rowNum == 0) begin
            kirmizi<=initialred0;
            mavi<=initialblue0;
            yesil<=initialgreen;
        end
        else if (rowNum == 1) begin
            kirmizi<=initialred1;
            mavi<=initialblue1;
            yesil<=initialgreen;
        end
        else if (rowNum == 2) begin
            kirmizi<=initialred2;
            mavi<=initialblue2;
            yesil<=initialgreen;
        end
        else if (rowNum == 3) begin
        kirmizi<=initialred3;
        mavi<=initialblue3;
        yesil<=initialgreen;
        end    
        else if (rowNum == 4) begin
            kirmizi<=initialred4;
            mavi<=initialblue4;
            yesil<=initialgreen;
        end
        else if (rowNum == 5) begin
            kirmizi<=initialred5;
            mavi<=initialblue5;
            yesil<=initialgreen;
        end
        else if (rowNum == 6) begin
            kirmizi<=initialred6;
            mavi<=initialblue6;
            yesil<=initialgreen;
        end
        else begin
            kirmizi<=initialred7;
            mavi<=initialblue7;
            yesil<=initialgreen;
        end
                
end

SevSeg_4digit scoreDisplayer( CLOCK,
 in0, in1, in2,in3 ,a, b, c, d, e, f, g, dp, an);   // anode: 4-bit enable signal (active low)
 
endmodule
