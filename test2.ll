
define i32 @rotateleft32_doubleand1(i32 %v, i8 %r) {
; CHECK-LABEL: @rotateleft32_doubleand1(
; CHECK-NEXT:    [[Z:%.*]] = zext i8 [[R:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = call i32 @llvm.fshl.i32(i32 [[V:%.*]], i32 [[V]], i32 [[Z]])
; CHECK-NEXT:    ret i32 [[OR]]
;
  %m = and i8 %r, 31
  %z = zext i8 %m to i32
  %neg = sub nsw i32 0, %z
  %and2 = and i32 %neg, 31
  %shl = shl i32 %v, %z
  %shr = lshr i32 %v, %and2
  %or = or i32 %shr, %shl
  ret i32 %or
}