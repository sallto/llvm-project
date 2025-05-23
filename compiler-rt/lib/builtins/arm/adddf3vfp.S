//===-- adddf3vfp.S - Implement adddf3vfp ---------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "../assembly.h"

// double __adddf3vfp(double a, double b) { return a + b; }
//
// Adds two double precision floating point numbers using the Darwin
// calling convention where double arguments are passsed in GPR pairs

	.syntax unified
	.p2align 2
DEFINE_COMPILERRT_FUNCTION(__adddf3vfp)
#if defined(COMPILER_RT_ARMHF_TARGET)
	vadd.f64 d0, d0, d1
#else
	VMOV_TO_DOUBLE(d6, r0, r1)		// move first param from r0/r1 pair into d6
	VMOV_TO_DOUBLE(d7, r2, r3)		// move second param from r2/r3 pair into d7
	vadd.f64 d6, d6, d7
	VMOV_FROM_DOUBLE(r0, r1, d6)		// move result back to r0/r1 pair
#endif
	bx	lr
END_COMPILERRT_FUNCTION(__adddf3vfp)

NO_EXEC_STACK_DIRECTIVE

