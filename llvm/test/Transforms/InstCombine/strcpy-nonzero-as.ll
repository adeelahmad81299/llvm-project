; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; Test that the strcpy library call simplifier also works when the string
; libcall arguments are in a non-zero address space.
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
target datalayout = "e-m:e-p200:128:128:128:64-p:64:64-A200-P200-G200"

@str = private unnamed_addr addrspace(200) constant [17 x i8] c"exactly 16 chars\00", align 1

declare i8 addrspace(200)* @strcpy(i8 addrspace(200)*, i8 addrspace(200)*) addrspace(200)
declare i8 addrspace(200)* @stpcpy(i8 addrspace(200)*, i8 addrspace(200)*) addrspace(200)
declare i8 addrspace(200)* @strncpy(i8 addrspace(200)*, i8 addrspace(200)*, i64) addrspace(200)
declare i8 addrspace(200)* @stpncpy(i8 addrspace(200)*, i8 addrspace(200)*, i64) addrspace(200)

define void @test_strcpy_to_memcpy(i8 addrspace(200)* %dst) addrspace(200) nounwind {
; CHECK-LABEL: define {{[^@]+}}@test_strcpy_to_memcpy
; CHECK-SAME: (i8 addrspace(200)* [[DST:%.*]]) addrspace(200) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call addrspace(200) void @llvm.memcpy.p200i8.p200i8.i64(i8 addrspace(200)* noundef align 1 dereferenceable(17) [[DST]], i8 addrspace(200)* noundef align 1 dereferenceable(17) getelementptr inbounds ([17 x i8], [17 x i8] addrspace(200)* @str, i64 0, i64 0), i64 17, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %call = call i8 addrspace(200)* @strcpy(i8 addrspace(200)* %dst, i8 addrspace(200)* getelementptr inbounds ([17 x i8], [17 x i8] addrspace(200)* @str, i64 0, i64 0))
  ret void
}

define void @test_stpcpy_to_memcpy(i8 addrspace(200)* %dst) addrspace(200) nounwind {
; CHECK-LABEL: define {{[^@]+}}@test_stpcpy_to_memcpy
; CHECK-SAME: (i8 addrspace(200)* [[DST:%.*]]) addrspace(200) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call addrspace(200) void @llvm.memcpy.p200i8.p200i8.i64(i8 addrspace(200)* noundef align 1 dereferenceable(17) [[DST]], i8 addrspace(200)* noundef align 1 dereferenceable(17) getelementptr inbounds ([17 x i8], [17 x i8] addrspace(200)* @str, i64 0, i64 0), i64 17, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %call = call i8 addrspace(200)* @stpcpy(i8 addrspace(200)* %dst, i8 addrspace(200)* getelementptr inbounds ([17 x i8], [17 x i8] addrspace(200)* @str, i64 0, i64 0))
  ret void
}

define void @test_stpcpy_to_strcpy(i8 addrspace(200)* %dst, i8 addrspace(200)* %src) addrspace(200) nounwind {
; CHECK-LABEL: define {{[^@]+}}@test_stpcpy_to_strcpy
; CHECK-SAME: (i8 addrspace(200)* [[DST:%.*]], i8 addrspace(200)* [[SRC:%.*]]) addrspace(200) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[STRCPY:%.*]] = call addrspace(200) i8 addrspace(200)* @strcpy(i8 addrspace(200)* noundef [[DST]], i8 addrspace(200)* noundef [[SRC]])
; CHECK-NEXT:    ret void
;
entry:
  %call = call i8 addrspace(200)* @stpcpy(i8 addrspace(200)* %dst, i8 addrspace(200)* %src)
  ret void
}


define void @test_strncpy_to_memcpy(i8 addrspace(200)* %dst) addrspace(200) nounwind {
; CHECK-LABEL: define {{[^@]+}}@test_strncpy_to_memcpy
; CHECK-SAME: (i8 addrspace(200)* [[DST:%.*]]) addrspace(200) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call addrspace(200) void @llvm.memcpy.p200i8.p200i8.i128(i8 addrspace(200)* noundef align 1 dereferenceable(17) [[DST]], i8 addrspace(200)* noundef align 1 dereferenceable(17) getelementptr inbounds ([17 x i8], [17 x i8] addrspace(200)* @str, i64 0, i64 0), i128 17, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %call = call i8 addrspace(200)* @strncpy(i8 addrspace(200)* %dst, i8 addrspace(200)* getelementptr inbounds ([17 x i8], [17 x i8] addrspace(200)* @str, i64 0, i64 0), i64 17)
  ret void
}

define void @test_stpncpy_to_memcpy(i8 addrspace(200)* %dst) addrspace(200) nounwind {
; CHECK-LABEL: define {{[^@]+}}@test_stpncpy_to_memcpy
; CHECK-SAME: (i8 addrspace(200)* [[DST:%.*]]) addrspace(200) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call addrspace(200) void @llvm.memcpy.p200i8.p200i8.i128(i8 addrspace(200)* noundef align 1 dereferenceable(17) [[DST]], i8 addrspace(200)* noundef align 1 dereferenceable(17) getelementptr inbounds ([17 x i8], [17 x i8] addrspace(200)* @str, i64 0, i64 0), i128 17, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %call = call i8 addrspace(200)* @stpncpy(i8 addrspace(200)* %dst, i8 addrspace(200)* getelementptr inbounds ([17 x i8], [17 x i8] addrspace(200)* @str, i64 0, i64 0), i64 17)
  ret void
}
