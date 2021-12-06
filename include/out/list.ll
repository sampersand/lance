; ModuleID = 'list.c'
source_filename = "list.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

%struct.list = type { i64*, i64, i64 }
%struct._str = type { i8*, i64 }

@.str = private unnamed_addr constant [26 x i8] c"popped from an empty list\00", align 1

; Function Attrs: nounwind ssp uwtable
define %struct.list* @allocate_list(i64 %0) local_unnamed_addr #0 {
  %2 = icmp eq i64 %0, 0
  %3 = select i1 %2, i64 1, i64 %0
  %4 = tail call i8* @xmalloc(i64 24) #4
  %5 = bitcast i8* %4 to %struct.list*
  %6 = shl i64 %3, 3
  %7 = tail call i8* @xmalloc(i64 %6) #4
  %8 = bitcast i8* %4 to i8**
  store i8* %7, i8** %8, align 8, !tbaa !8
  %9 = getelementptr inbounds i8, i8* %4, i64 8
  %10 = bitcast i8* %9 to i64*
  store i64 0, i64* %10, align 8, !tbaa !14
  %11 = getelementptr inbounds i8, i8* %4, i64 16
  %12 = bitcast i8* %11 to i64*
  store i64 %3, i64* %12, align 8, !tbaa !15
  ret %struct.list* %5
}

declare i8* @xmalloc(i64) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
define %struct.list* @concat_lists(%struct.list* nocapture readonly %0, %struct.list* nocapture readonly %1) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 1
  %4 = load i64, i64* %3, align 8, !tbaa !14
  %5 = getelementptr inbounds %struct.list, %struct.list* %1, i64 0, i32 1
  %6 = load i64, i64* %5, align 8, !tbaa !14
  %7 = add nsw i64 %6, %4
  %8 = icmp eq i64 %7, 0
  %9 = select i1 %8, i64 1, i64 %7
  %10 = tail call i8* @xmalloc(i64 24) #4
  %11 = bitcast i8* %10 to %struct.list*
  %12 = shl i64 %9, 3
  %13 = tail call i8* @xmalloc(i64 %12) #4
  %14 = bitcast i8* %10 to i8**
  store i8* %13, i8** %14, align 8, !tbaa !8
  %15 = getelementptr inbounds i8, i8* %10, i64 8
  %16 = bitcast i8* %15 to i64*
  store i64 0, i64* %16, align 8, !tbaa !14
  %17 = getelementptr inbounds i8, i8* %10, i64 16
  %18 = bitcast i8* %17 to i64*
  store i64 %9, i64* %18, align 8, !tbaa !15
  %19 = load i64, i64* %3, align 8, !tbaa !14
  %20 = load i64, i64* %5, align 8, !tbaa !14
  %21 = add nsw i64 %20, %19
  store i64 %21, i64* %16, align 8, !tbaa !14
  %22 = bitcast i8* %10 to i64**
  %23 = bitcast %struct.list* %0 to i8**
  %24 = load i8*, i8** %23, align 8, !tbaa !8
  %25 = load i64, i64* %3, align 8, !tbaa !14
  %26 = shl i64 %25, 3
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %13, i8* align 1 %24, i64 %26, i1 false) #4
  %27 = load i64*, i64** %22, align 8, !tbaa !8
  %28 = load i64, i64* %3, align 8, !tbaa !14
  %29 = getelementptr inbounds i64, i64* %27, i64 %28
  %30 = bitcast i64* %29 to i8*
  %31 = bitcast %struct.list* %1 to i8**
  %32 = load i8*, i8** %31, align 8, !tbaa !8
  %33 = load i64, i64* %5, align 8, !tbaa !14
  %34 = shl i64 %33, 3
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %30, i8* align 1 %32, i64 %34, i1 false) #4
  ret %struct.list* %11
}

; Function Attrs: nounwind ssp uwtable
define %struct.list* @repeat_list(%struct.list* nocapture readonly %0, i64 %1) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 1
  %4 = load i64, i64* %3, align 8, !tbaa !14
  %5 = mul nsw i64 %4, %1
  %6 = icmp eq i64 %5, 0
  %7 = select i1 %6, i64 1, i64 %5
  %8 = tail call i8* @xmalloc(i64 24) #4
  %9 = shl i64 %7, 3
  %10 = tail call i8* @xmalloc(i64 %9) #4
  %11 = bitcast i8* %8 to i8**
  store i8* %10, i8** %11, align 8, !tbaa !8
  %12 = getelementptr inbounds i8, i8* %8, i64 8
  %13 = bitcast i8* %12 to i64*
  store i64 0, i64* %13, align 8, !tbaa !14
  %14 = getelementptr inbounds i8, i8* %8, i64 16
  %15 = bitcast i8* %14 to i64*
  store i64 %7, i64* %15, align 8, !tbaa !15
  %16 = load i64, i64* %3, align 8, !tbaa !14
  %17 = mul nsw i64 %16, %1
  store i64 %17, i64* %13, align 8, !tbaa !14
  %18 = icmp eq i64 %1, 0
  br i1 %18, label %23, label %19

19:                                               ; preds = %2
  %20 = bitcast i8* %10 to i64*
  %21 = bitcast %struct.list* %0 to i8**
  %22 = load i64, i64* %3, align 8, !tbaa !14
  br label %25

23:                                               ; preds = %25, %2
  %24 = bitcast i8* %8 to %struct.list*
  ret %struct.list* %24

25:                                               ; preds = %19, %25
  %26 = phi i64 [ %22, %19 ], [ %33, %25 ]
  %27 = phi i64* [ %20, %19 ], [ %34, %25 ]
  %28 = phi i64 [ %1, %19 ], [ %29, %25 ]
  %29 = add nsw i64 %28, -1
  %30 = bitcast i64* %27 to i8*
  %31 = load i8*, i8** %21, align 8, !tbaa !8
  %32 = shl i64 %26, 3
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %30, i8* align 1 %31, i64 %32, i1 false) #4
  %33 = load i64, i64* %3, align 8, !tbaa !14
  %34 = getelementptr inbounds i64, i64* %27, i64 %33
  %35 = icmp eq i64 %29, 0
  br i1 %35, label %23, label %25, !llvm.loop !16
}

; Function Attrs: nounwind ssp uwtable
define i64 @insert_into_list(%struct.list* nocapture %0, i64 %1, i64* nocapture readonly %2) local_unnamed_addr #0 {
  %4 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 1
  %5 = load i64, i64* %4, align 8, !tbaa !14
  %6 = icmp slt i64 %5, %1
  %7 = icmp slt i64 %1, 0
  %8 = or i1 %7, %6
  br i1 %8, label %38, label %9

9:                                                ; preds = %3
  %10 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 2
  %11 = load i64, i64* %10, align 8, !tbaa !15
  %12 = icmp eq i64 %11, %5
  br i1 %12, label %13, label %20

13:                                               ; preds = %9
  %14 = bitcast %struct.list* %0 to i8**
  %15 = load i8*, i8** %14, align 8, !tbaa !8
  %16 = shl nsw i64 %5, 1
  store i64 %16, i64* %10, align 8, !tbaa !15
  %17 = shl i64 %5, 4
  %18 = tail call i8* @xrealloc(i8* %15, i64 %17) #4
  store i8* %18, i8** %14, align 8, !tbaa !8
  %19 = load i64, i64* %4, align 8, !tbaa !14
  br label %20

20:                                               ; preds = %13, %9
  %21 = phi i64 [ %19, %13 ], [ %5, %9 ]
  %22 = add nsw i64 %21, 1
  %23 = icmp slt i64 %22, %1
  %24 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 0
  %25 = load i64*, i64** %24, align 8, !tbaa !8
  br i1 %23, label %26, label %31

26:                                               ; preds = %31, %20
  %27 = load i64, i64* %2, align 8, !tbaa !18
  %28 = getelementptr inbounds i64, i64* %25, i64 %1
  store i64 %27, i64* %28, align 8, !tbaa !18
  %29 = load i64, i64* %4, align 8, !tbaa !14
  %30 = add nsw i64 %29, 1
  store i64 %30, i64* %4, align 8, !tbaa !14
  br label %38

31:                                               ; preds = %20, %31
  %32 = phi i64 [ %33, %31 ], [ %22, %20 ]
  %33 = add nsw i64 %32, -1
  %34 = getelementptr inbounds i64, i64* %25, i64 %33
  %35 = load i64, i64* %34, align 8, !tbaa !18
  %36 = getelementptr inbounds i64, i64* %25, i64 %32
  store i64 %35, i64* %36, align 8, !tbaa !18
  %37 = icmp sgt i64 %32, %1
  br i1 %37, label %31, label %26, !llvm.loop !19

38:                                               ; preds = %3, %26
  %39 = phi i64 [ 1, %26 ], [ 0, %3 ]
  ret i64 %39
}

declare i8* @xrealloc(i8*, i64) local_unnamed_addr #1

; Function Attrs: nofree nounwind ssp uwtable
define i64 @delete_from_list(%struct.list* nocapture %0, i64* nocapture %1, i64 %2) local_unnamed_addr #2 {
  %4 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 1
  %5 = load i64, i64* %4, align 8, !tbaa !14
  %6 = icmp sle i64 %5, %2
  %7 = icmp slt i64 %2, 0
  %8 = or i1 %7, %6
  br i1 %8, label %22, label %9

9:                                                ; preds = %3
  %10 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 0
  %11 = load i64*, i64** %10, align 8, !tbaa !8
  %12 = getelementptr inbounds i64, i64* %11, i64 %2
  %13 = load i64, i64* %12, align 8, !tbaa !18
  store i64 %13, i64* %1, align 8, !tbaa !18
  %14 = getelementptr inbounds i64, i64* %12, i64 -1
  %15 = bitcast i64* %14 to i8*
  %16 = bitcast i64* %12 to i8*
  %17 = load i64, i64* %4, align 8, !tbaa !14
  %18 = sub nsw i64 %17, %2
  %19 = shl i64 %18, 3
  call void @llvm.memmove.p0i8.p0i8.i64(i8* nonnull align 1 %15, i8* nonnull align 1 %16, i64 %19, i1 false) #4
  %20 = load i64, i64* %4, align 8, !tbaa !14
  %21 = add nsw i64 %20, -1
  store i64 %21, i64* %4, align 8, !tbaa !14
  br label %22

22:                                               ; preds = %3, %9
  %23 = phi i64 [ 1, %9 ], [ 0, %3 ]
  ret i64 %23
}

; Function Attrs: nounwind ssp uwtable
define void @push_into_list(%struct.list* nocapture %0, i64* nocapture readonly %1) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 2
  %4 = load i64, i64* %3, align 8, !tbaa !15
  %5 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 1
  %6 = load i64, i64* %5, align 8, !tbaa !14
  %7 = icmp eq i64 %4, %6
  br i1 %7, label %11, label %8

8:                                                ; preds = %2
  %9 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 0
  %10 = load i64*, i64** %9, align 8, !tbaa !8
  br label %19

11:                                               ; preds = %2
  %12 = bitcast %struct.list* %0 to i8**
  %13 = load i8*, i8** %12, align 8, !tbaa !8
  %14 = shl nsw i64 %4, 1
  store i64 %14, i64* %3, align 8, !tbaa !15
  %15 = shl i64 %4, 4
  %16 = tail call i8* @xrealloc(i8* %13, i64 %15) #4
  store i8* %16, i8** %12, align 8, !tbaa !8
  %17 = bitcast i8* %16 to i64*
  %18 = load i64, i64* %5, align 8, !tbaa !14
  br label %19

19:                                               ; preds = %8, %11
  %20 = phi i64 [ %6, %8 ], [ %18, %11 ]
  %21 = phi i64* [ %10, %8 ], [ %17, %11 ]
  %22 = load i64, i64* %1, align 8, !tbaa !18
  %23 = add nsw i64 %20, 1
  store i64 %23, i64* %5, align 8, !tbaa !14
  %24 = getelementptr inbounds i64, i64* %21, i64 %20
  store i64 %22, i64* %24, align 8, !tbaa !18
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @pop_from_list(%struct.list* nocapture %0, i64* nocapture %1) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 1
  %4 = load i64, i64* %3, align 8, !tbaa !14
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %6, label %9

6:                                                ; preds = %2
  %7 = tail call %struct._str* @create_str_from_borrowed(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str, i64 0, i64 0)) #4
  tail call void @abort_msg(%struct._str* %7) #4
  %8 = load i64, i64* %3, align 8, !tbaa !14
  br label %9

9:                                                ; preds = %6, %2
  %10 = phi i64 [ %8, %6 ], [ %4, %2 ]
  %11 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 0
  %12 = load i64*, i64** %11, align 8, !tbaa !8
  %13 = add nsw i64 %10, -1
  store i64 %13, i64* %3, align 8, !tbaa !14
  %14 = getelementptr inbounds i64, i64* %12, i64 %13
  %15 = load i64, i64* %14, align 8, !tbaa !18
  store i64 %15, i64* %1, align 8, !tbaa !18
  ret void
}

declare void @abort_msg(%struct._str*) local_unnamed_addr #1

declare %struct._str* @create_str_from_borrowed(i8*) local_unnamed_addr #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #3

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nofree nosync nounwind willreturn }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 12, i32 0]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 1, !"branch-target-enforcement", i32 0}
!3 = !{i32 1, !"sign-return-address", i32 0}
!4 = !{i32 1, !"sign-return-address-all", i32 0}
!5 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"Apple clang version 13.0.0 (clang-1300.0.29.3)"}
!8 = !{!9, !10, i64 0}
!9 = !{!"", !10, i64 0, !13, i64 8, !13, i64 16}
!10 = !{!"any pointer", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{!"long long", !11, i64 0}
!14 = !{!9, !13, i64 8}
!15 = !{!9, !13, i64 16}
!16 = distinct !{!16, !17}
!17 = !{!"llvm.loop.mustprogress"}
!18 = !{!13, !13, i64 0}
!19 = distinct !{!19, !17}
