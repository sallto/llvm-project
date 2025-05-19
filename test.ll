define i32 @rotr_i32_smaller_shamt(i32 %x, i16 %y) {
  %z = zext i16 %y to i32
  %neg = sub nsw i32 0, %z
  %and2 = and i32 %neg, 31
  %shl = shl i32 %x, %and2
  %shr = lshr i32 %x, %z
  %or = or i32 %shr, %shl
  ret i32 %or
}

define i64 @rotr_i64_smaller_shamt_different_conversion_points(i64 %x, i32 %y) {
  %z = zext i32 %y to i64
  %neg = sub nsw i32 0, %y
  %and2 = and i32 %neg, 63
  %conv = zext i32 %and2 to i64
  %shl = shl i64 %x, %conv
  %shr = lshr i64 %x, %z
  %or = or i64 %shr, %shl
  ret i64 %or
}

define i64 @rotr_i64_smaller_shamt_different_conversion_points_double_and1(i64 %x, i32 %y) {
  %and = and i32 %y, 63
  %z = zext i32 %and to i64
  %neg = sub nsw i32 0, %y
  %and2 = and i32 %neg, 63
  %conv = zext i32 %and2 to i64
  %shl = shl i64 %x, %conv
  %shr = lshr i64 %x, %z
  %or = or i64 %shr, %shl
  ret i64 %or
}

define i64 @rotr_i64_smaller_shamt_different_conversion_points_double_and2(i64 %x, i32 %y) {
  %and = and i32 %y, 63
  %z = zext i32 %and to i64
  %neg = sub nsw i32 0, %and
  %and2 = and i32 %neg, 63
  %conv = zext i32 %and2 to i64
  %shl = shl i64 %x, %conv
  %shr = lshr i64 %x, %z
  %or = or i64 %shr, %shl
  ret i64 %or
}

;; larger shift amount

define i32 @rotr_i32_larger_shamt(i32 %x, i64 %y) {
  %z = trunc i64 %y to i32
  %neg = sub nsw i32 0, %z
  %and2 = and i32 %neg, 31
  %shl = shl i32 %x, %and2
  %shr = lshr i32 %x, %z
  %or = or i32 %shr, %shl
  ret i32 %or
}

define i32 @rotr_i32_larger_shamt_different_conversion_points(i32 %x, i64 %y) {
  %z = trunc i64 %y to i32
  %neg = sub  i64 0, %y
  %and2 = and i64 %neg, 31
  %conv = trunc i64 %and2 to i32
  %shl = shl i32 %x, %conv
  %shr = lshr i32 %x, %z
  %or = or i32 %shr, %shl
  ret i32 %or
}

define i32 @rotr_i32_larger_shamt_different_conversion_points_double_and1(i32 %x, i64 %y) {
  %and = and i64 %y, 31
  %z = trunc i64 %and to i32
  %neg = sub nsw i64 0, %y
  %and2 = and i64 %neg, 31
  %conv = trunc i64 %and2 to i32
  %shl = shl i32 %x, %conv
  %shr = lshr i32 %x, %z
  %or = or i32 %shr, %shl
  ret i32 %or
}

define i32 @rotateleft32_doubleand1(i32 %v, i64 %r) {
  %m = and i64 %r, 31
  %z = trunc i64 %m to i32
  %neg = sub nsw i64 0, %r
  %and2 = and i64 %neg, 31
  %conv = trunc i64 %and2 to i32
  %shl = shl i32 %v, %z
  %shr = lshr i32 %v, %conv
  %or = or i32 %shr, %shl
  ret i32 %or
}

define i32 @lrotate_i32_simple_restricted_shamt(i32 %x, i32 %shAmt) {
  %and = and i32 %x, 30
  %shl = shl i32 %x, %and
  %sub = sub i32 0, %and
  %shr = lshr i32 %x, %sub
  %or = or i32 %shl, %shr
  ret i32 %or
}

define i32 @lrotate_i32_simple_multi_use(i32 %x, i16 %shAmt) {
  %conv = zext i16 %shAmt to i32
  call void @use(i32 %conv)
  %shl = shl i32 %x, %conv
  %sub = sub i32 0, %conv
  %shr = lshr i32 %x, %sub
  %or = or i32 %shl, %shr
  ret i32 %or
}
;; negative test - could be folded
define i64 @lrotate_i32_simple_and_use(i64 %x, i32 %y) {
  %and = and i32 %y, 63
  %z = zext i32 %and to i64
  call void @use(i64 %z)
  %neg = sub nsw i32 0, %y
  %and2 = and i32 %neg, 63
  %conv = zext i32 %and2 to i64
  %shl = shl i64 %x, %conv
  %shr = lshr i64 %x, %z
  %or = or i64 %shr, %shl
  ret i64 %or
}
define i64 @lrotate_i32_simple_no_use(i64 %x, i32 %y) {
  %and = and i32 %y, 63
  %z = zext i32 %and to i64
  %neg = sub nsw i32 0, %y
  %and2 = and i32 %neg, 63
  %conv = zext i32 %and2 to i64
  %shl = shl i64 %x, %conv
  %shr = lshr i64 %x, %z
  %or = or i64 %shr, %shl
  ret i64 %or
}

declare void @use(i32)