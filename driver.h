// Copyright information found in source file:
// Copyright lowRISC contributors.

// Licensing information found in source file:
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#ifndef _GF_MULT_REG_DEFS_
#define _GF_MULT_REG_DEFS_

#ifdef __cplusplus
extern "C" {
#endif
// Register width
#define GF_MULT_PARAM_REG_WIDTH 32

// Subword of Operand A.
#define GF_MULT_OP_A(id) (GF_MULT ## id ## _BASE_ADDR  + 0x0)
#define GF_MULT_OP_A_REG_OFFSET 0x0
#define GF_MULT_OP_A_OP_A_MASK 0xff
#define GF_MULT_OP_A_OP_A_OFFSET 0
#define GF_MULT_OP_A_OP_A_FIELD \
  ((bitfield_field32_t) { .mask = GF_MULT_OP_A_OP_A_MASK, .index = GF_MULT_OP_A_OP_A_OFFSET })

// Subword of Operand B.
#define GF_MULT_OP_B(id) (GF_MULT ## id ## _BASE_ADDR + 0x4)
#define GF_MULT_OP_B_REG_OFFSET 0x4
#define GF_MULT_OP_B_OP_B_MASK 0xff
#define GF_MULT_OP_B_OP_B_OFFSET 0
#define GF_MULT_OP_B_OP_B_FIELD \
  ((bitfield_field32_t) { .mask = GF_MULT_OP_B_OP_B_MASK, .index = GF_MULT_OP_B_OP_B_OFFSET })

// Operand for MAC Operation (Addition term)
#define GF_MULT_OP_C(id) (GF_MULT ## id ## _BASE_ADDR + 0x8)
#define GF_MULT_OP_C_REG_OFFSET 0x8
#define GF_MULT_OP_C_OP_B_MASK 0xff
#define GF_MULT_OP_C_OP_B_OFFSET 0
#define GF_MULT_OP_C_OP_B_FIELD \
  ((bitfield_field32_t) { .mask = GF_MULT_OP_C_OP_B_MASK, .index = GF_MULT_OP_C_OP_B_OFFSET })

// results
#define GF_MULT_RESULT(id) (GF_MULT ## id ## _BASE_ADDR + 0xc)
#define GF_MULT_RESULT_REG_OFFSET 0xc
#define GF_MULT_RESULT_RESULT_MASK 0xff
#define GF_MULT_RESULT_RESULT_OFFSET 0
#define GF_MULT_RESULT_RESULT_FIELD \
  ((bitfield_field32_t) { .mask = GF_MULT_RESULT_RESULT_MASK, .index = GF_MULT_RESULT_RESULT_OFFSET })

// Controls trigger signal of the gf arithmetic.
#define GF_MULT_CTRL1(id) (GF_MULT ## id ## _BASE_ADDR + 0x10)
#define GF_MULT_CTRL1_REG_OFFSET 0x10
#define GF_MULT_CTRL1_TRIGGER_BIT 0

// Controls trigger signal of the gf arithmetic.
#define GF_MULT_CTRL2(id) (GF_MULT ## id ## _BASE_ADDR + 0x14)
#define GF_MULT_CTRL2_REG_OFFSET 0x14
#define GF_MULT_CTRL2_OP_SEL_MASK 0x3
#define GF_MULT_CTRL2_OP_SEL_OFFSET 0
#define GF_MULT_CTRL2_OP_SEL_FIELD \
  ((bitfield_field32_t) { .mask = GF_MULT_CTRL2_OP_SEL_MASK, .index = GF_MULT_CTRL2_OP_SEL_OFFSET })
#define GF_MULT_CTRL2_OP_SEL_VALUE_ADD 0x0
#define GF_MULT_CTRL2_OP_SEL_VALUE_MUL 0x1
#define GF_MULT_CTRL2_OP_SEL_VALUE_MAC 0x2

// Contains the current status of the accelerator.
#define GF_MULT_STATUS(id) (GF_MULT ## id ## _BASE_ADDR + 0x18)
#define GF_MULT_STATUS_REG_OFFSET 0x18
#define GF_MULT_STATUS_STATUS_BIT 0

#ifdef __cplusplus
}  // extern "C"
#endif
#endif  // _GF_MULT_REG_DEFS_
// End generated register defines for gf_mult