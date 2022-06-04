; ModuleID = 'io.c'
source_filename = "io.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

%struct.io = type { %struct._str*, %struct._str*, %struct.__sFILE* }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct._str = type { i8*, i64 }

@.str = private unnamed_addr constant [21 x i8] c"unable to open file.\00", align 1
@.str.1 = private unnamed_addr constant [27 x i8] c"unable to read input line.\00", align 1

; Function Attrs: nounwind ssp uwtable
define %struct.io* @open_io(%struct._str* %0, %struct._str* %1) local_unnamed_addr #0 {
  %3 = tail call i8* @xmalloc(i64 24) #6
  %4 = bitcast i8* %3 to %struct._str**
  store %struct._str* %0, %struct._str** %4, align 8, !tbaa !10
  %5 = getelementptr inbounds i8, i8* %3, i64 8
  %6 = bitcast i8* %5 to %struct._str**
  store %struct._str* %1, %struct._str** %6, align 8, !tbaa !15
  %7 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %8 = load i64, i64* %7, align 8, !tbaa !16
  %9 = add nsw i64 %8, 1
  %10 = alloca i8, i64 %9, align 1
  %11 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %12 = load i8*, i8** %11, align 8, !tbaa !19
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %10, i8* align 1 %12, i64 %8, i1 false) #6
  %13 = getelementptr inbounds i8, i8* %10, i64 %8
  store i8 0, i8* %13, align 1, !tbaa !20
  %14 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 1
  %15 = load i64, i64* %14, align 8, !tbaa !16
  %16 = add nsw i64 %15, 1
  %17 = alloca i8, i64 %16, align 1
  %18 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 0
  %19 = load i8*, i8** %18, align 8, !tbaa !19
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %17, i8* align 1 %19, i64 %15, i1 false) #6
  %20 = getelementptr inbounds i8, i8* %17, i64 %15
  store i8 0, i8* %20, align 1, !tbaa !20
  %21 = call %struct.__sFILE* @"\01_fopen"(i8* nonnull %10, i8* nonnull %17) #6
  %22 = getelementptr inbounds i8, i8* %3, i64 16
  %23 = bitcast i8* %22 to %struct.__sFILE**
  store %struct.__sFILE* %21, %struct.__sFILE** %23, align 8, !tbaa !21
  %24 = icmp eq %struct.__sFILE* %21, null
  br i1 %24, label %25, label %27

25:                                               ; preds = %2
  %26 = call %struct._str* @create_str_from_borrowed(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0)) #6
  call void @abort_msg(%struct._str* %26) #6
  br label %27

27:                                               ; preds = %25, %2
  %28 = bitcast i8* %3 to %struct.io*
  ret %struct.io* %28
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare i8* @xmalloc(i64) local_unnamed_addr #2

declare %struct.__sFILE* @"\01_fopen"(i8*, i8*) local_unnamed_addr #2

declare void @abort_msg(%struct._str*) local_unnamed_addr #2

declare %struct._str* @create_str_from_borrowed(i8*) local_unnamed_addr #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind ssp uwtable
define %struct._str* @readline_io(%struct.io* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = alloca i64, align 8
  %3 = bitcast i64* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3) #6
  %4 = getelementptr inbounds %struct.io, %struct.io* %0, i64 0, i32 2
  %5 = load %struct.__sFILE*, %struct.__sFILE** %4, align 8, !tbaa !21
  %6 = call i8* @fgetln(%struct.__sFILE* %5, i64* nonnull %2) #6
  %7 = icmp eq i8* %6, null
  br i1 %7, label %8, label %16

8:                                                ; preds = %1
  %9 = load %struct.__sFILE*, %struct.__sFILE** %4, align 8, !tbaa !21
  %10 = call i32 @feof(%struct.__sFILE* %9)
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %14, label %12

12:                                               ; preds = %8
  %13 = call %struct._str* @allocate_str(i64 0) #6
  br label %22

14:                                               ; preds = %8
  %15 = call %struct._str* @create_str_from_borrowed(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.1, i64 0, i64 0)) #6
  call void @abort_msg(%struct._str* %15) #6
  br label %16

16:                                               ; preds = %14, %1
  %17 = load i64, i64* %2, align 8, !tbaa !22
  %18 = call %struct._str* @allocate_str(i64 %17) #6
  %19 = load i64, i64* %2, align 8, !tbaa !22
  %20 = call i8* @strndup(i8* %6, i64 %19)
  %21 = getelementptr inbounds %struct._str, %struct._str* %18, i64 0, i32 0
  store i8* %20, i8** %21, align 8, !tbaa !19
  br label %22

22:                                               ; preds = %16, %12
  %23 = phi %struct._str* [ %13, %12 ], [ %18, %16 ]
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3) #6
  ret %struct._str* %23
}

declare i8* @fgetln(%struct.__sFILE*, i64*) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @feof(%struct.__sFILE* nocapture noundef) local_unnamed_addr #3

declare %struct._str* @allocate_str(i64) local_unnamed_addr #2

; Function Attrs: inaccessiblemem_or_argmemonly mustprogress nofree nounwind willreturn
declare noalias i8* @strndup(i8* nocapture readonly, i64 noundef) local_unnamed_addr #4

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #5

attributes #0 = { nounwind ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #1 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #3 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #4 = { inaccessiblemem_or_argmemonly mustprogress nofree nounwind willreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #5 = { argmemonly nofree nounwind willreturn }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 12, i32 3]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 1, !"branch-target-enforcement", i32 0}
!3 = !{i32 1, !"sign-return-address", i32 0}
!4 = !{i32 1, !"sign-return-address-all", i32 0}
!5 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 1}
!9 = !{!"Apple clang version 13.1.6 (clang-1316.0.21.2.5)"}
!10 = !{!11, !12, i64 0}
!11 = !{!"", !12, i64 0, !12, i64 8, !12, i64 16}
!12 = !{!"any pointer", !13, i64 0}
!13 = !{!"omnipotent char", !14, i64 0}
!14 = !{!"Simple C/C++ TBAA"}
!15 = !{!11, !12, i64 8}
!16 = !{!17, !18, i64 8}
!17 = !{!"_str", !12, i64 0, !18, i64 8}
!18 = !{!"long long", !13, i64 0}
!19 = !{!17, !12, i64 0}
!20 = !{!13, !13, i64 0}
!21 = !{!11, !12, i64 16}
!22 = !{!23, !23, i64 0}
!23 = !{!"long", !13, i64 0}
