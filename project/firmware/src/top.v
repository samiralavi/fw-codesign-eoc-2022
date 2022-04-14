module top
  (
   // Declare some signals so we can see how I/O works
   input              clk,
   input              fastclk,
   input              reset_l,

   output wire [1:0]  out_small,
   output wire [39:0] out_quad,
   output wire [69:0] out_wide,
   input [1:0]        in_small,
   input [39:0]       in_quad,
   input [69:0]       in_wide
   );

   // Connect up the outputs, using some trivial logic
   assign out_small = ~reset_l ? '0 : (in_small + 2'b1);
   assign out_quad  = ~reset_l ? '0 : (in_quad + 40'b1);
   assign out_wide  = ~reset_l ? '0 : (in_wide + 70'b1);

   // And an example sub module. The submodule will print stuff.
   component sub (/*AUTOINST*/
            // Inputs
            .clk                        (clk),
            .fastclk                    (fastclk),
            .reset_l                    (reset_l));

   // Print some stuff as an example
   initial begin
      $display("[%0t] Model running...\n", $time);
   end

endmodule