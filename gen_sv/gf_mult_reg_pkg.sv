// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package gf_mult_reg_pkg;

  // Address widths within the block
  parameter int BlockAw = 5;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////

  typedef struct packed {
    logic [7:0]  q;
  } gf_mult_reg2hw_op_a_reg_t;

  typedef struct packed {
    logic [7:0]  q;
  } gf_mult_reg2hw_op_b_reg_t;

  typedef struct packed {
    logic [7:0]  q;
  } gf_mult_reg2hw_op_c_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } gf_mult_reg2hw_ctrl1_reg_t;

  typedef struct packed {
    logic [1:0]  q;
    logic        qe;
  } gf_mult_reg2hw_ctrl2_reg_t;

  typedef struct packed {
    logic [7:0]  d;
  } gf_mult_hw2reg_result_reg_t;

  typedef struct packed {
    logic [1:0]  d;
  } gf_mult_hw2reg_ctrl2_reg_t;

  typedef struct packed {
    logic        d;
  } gf_mult_hw2reg_status_reg_t;

  // Register -> HW type
  typedef struct packed {
    gf_mult_reg2hw_op_a_reg_t op_a; // [28:21]
    gf_mult_reg2hw_op_b_reg_t op_b; // [20:13]
    gf_mult_reg2hw_op_c_reg_t op_c; // [12:5]
    gf_mult_reg2hw_ctrl1_reg_t ctrl1; // [4:3]
    gf_mult_reg2hw_ctrl2_reg_t ctrl2; // [2:0]
  } gf_mult_reg2hw_t;

  // HW -> register type
  typedef struct packed {
    gf_mult_hw2reg_result_reg_t result; // [10:3]
    gf_mult_hw2reg_ctrl2_reg_t ctrl2; // [2:1]
    gf_mult_hw2reg_status_reg_t status; // [0:0]
  } gf_mult_hw2reg_t;

  // Register offsets
  parameter logic [BlockAw-1:0] GF_MULT_OP_A_OFFSET = 5'h 0;
  parameter logic [BlockAw-1:0] GF_MULT_OP_B_OFFSET = 5'h 4;
  parameter logic [BlockAw-1:0] GF_MULT_OP_C_OFFSET = 5'h 8;
  parameter logic [BlockAw-1:0] GF_MULT_RESULT_OFFSET = 5'h c;
  parameter logic [BlockAw-1:0] GF_MULT_CTRL1_OFFSET = 5'h 10;
  parameter logic [BlockAw-1:0] GF_MULT_CTRL2_OFFSET = 5'h 14;
  parameter logic [BlockAw-1:0] GF_MULT_STATUS_OFFSET = 5'h 18;

  // Reset values for hwext registers and their fields
  parameter logic [7:0] GF_MULT_RESULT_RESVAL = 8'h 0;
  parameter logic [0:0] GF_MULT_CTRL1_RESVAL = 1'h 0;
  parameter logic [1:0] GF_MULT_CTRL2_RESVAL = 2'h 0;
  parameter logic [0:0] GF_MULT_STATUS_RESVAL = 1'h 0;

  // Register index
  typedef enum int {
    GF_MULT_OP_A,
    GF_MULT_OP_B,
    GF_MULT_OP_C,
    GF_MULT_RESULT,
    GF_MULT_CTRL1,
    GF_MULT_CTRL2,
    GF_MULT_STATUS
  } gf_mult_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] GF_MULT_PERMIT [7] = '{
    4'b 0001, // index[0] GF_MULT_OP_A
    4'b 0001, // index[1] GF_MULT_OP_B
    4'b 0001, // index[2] GF_MULT_OP_C
    4'b 0001, // index[3] GF_MULT_RESULT
    4'b 0001, // index[4] GF_MULT_CTRL1
    4'b 0001, // index[5] GF_MULT_CTRL2
    4'b 0001  // index[6] GF_MULT_STATUS
  };

endpackage

