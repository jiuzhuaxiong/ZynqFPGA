// -------------------------------------------------------------
// 
// File Name: hdl_prj\hdlsrc\controllerPeripheralHdlAdi\controllerHdl\controllerHdl_Encoder_To_Position_And_Velocity.v
// Created: 2014-09-08 14:12:04
// 
// Generated by MATLAB 8.2 and HDL Coder 3.3
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: controllerHdl_Encoder_To_Position_And_Velocity
// Source Path: controllerHdl/Encoder_To_Position_And_Velocity
// Hierarchy Level: 2
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module controllerHdl_Encoder_To_Position_And_Velocity
          (
           CLK_IN,
           reset,
           enb_1_2000_0,
           encoder_valid,
           encoder_counter,
           param_zero_offset,
           position_valid,
           rotor_position,
           electrical_position,
           rotor_velocity
          );


  input   CLK_IN;
  input   reset;
  input   enb_1_2000_0;
  input   encoder_valid;
  input   [15:0] encoder_counter;  // uint16
  input   signed [17:0] param_zero_offset;  // sfix18_En14
  output  position_valid;
  output  signed [17:0] rotor_position;  // sfix18_En14
  output  signed [17:0] electrical_position;  // sfix18_En14
  output  signed [17:0] rotor_velocity;  // sfix18_En8


  wire signed [17:0] Rotor_To_Electrical_Position_out1;  // sfix18_En14
  wire signed [17:0] Calculate_Rotor_Velocity_out1;  // sfix18_En8

  // Quadrature Encoder To Position And Velocity


  assign position_valid = encoder_valid;

  // <S2>/Encoder_To_Rotor_Position
  controllerHdl_Encoder_To_Rotor_Position   u_Encoder_To_Rotor_Position   (.counter(encoder_counter),  // uint16
                                                                           .param_zero_offset(param_zero_offset),  // sfix18_En14
                                                                           .position(rotor_position)  // sfix18_En14
                                                                           );

  // <S2>/Rotor_To_Electrical_Position
  controllerHdl_Rotor_To_Electrical_Position   u_Rotor_To_Electrical_Position   (.R(rotor_position),  // sfix18_En14
                                                                                 .E(Rotor_To_Electrical_Position_out1)  // sfix18_En14
                                                                                 );

  assign electrical_position = Rotor_To_Electrical_Position_out1;

  // <S2>/Calculate_Rotor_Velocity
  controllerHdl_Calculate_Rotor_Velocity   u_Calculate_Rotor_Velocity   (.CLK_IN(CLK_IN),
                                                                         .reset(reset),
                                                                         .enb_1_2000_0(enb_1_2000_0),
                                                                         .valid(encoder_valid),
                                                                         .position(rotor_position),  // sfix18_En14
                                                                         .rotor_velocity(Calculate_Rotor_Velocity_out1)  // sfix18_En8
                                                                         );

  assign rotor_velocity = Calculate_Rotor_Velocity_out1;

endmodule  // controllerHdl_Encoder_To_Position_And_Velocity

