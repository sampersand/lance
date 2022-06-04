; ModuleID = 'shared.c'
source_filename = "shared.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct._str = type { i8*, i64 }

@__stderrp = external local_unnamed_addr global %struct.__sFILE*, align 8
@.str = private unnamed_addr constant [5 x i8] c"%*s\0A\00", align 1
@__stdinp = external local_unnamed_addr global %struct.__sFILE*, align 8

; Function Attrs: nounwind ssp uwtable
define noalias i8* @xmalloc(i64 %0) local_unnamed_addr #0 {
  %2 = tail call i8* @malloc(i64 %0) #13
  %3 = icmp eq i64 %0, 0
  %4 = icmp ne i8* %2, null
  %5 = or i1 %3, %4
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @abort() #14
  unreachable

7:                                                ; preds = %1
  ret i8* %2
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind willreturn allocsize(0)
declare noalias noundef i8* @malloc(i64 noundef) local_unnamed_addr #2

; Function Attrs: cold noreturn
declare void @abort() local_unnamed_addr #3

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind ssp uwtable
define noalias i8* @xrealloc(i8* nocapture %0, i64 %1) local_unnamed_addr #0 {
  %3 = tail call i8* @realloc(i8* %0, i64 %1) #15
  %4 = icmp eq i64 %1, 0
  %5 = icmp ne i8* %3, null
  %6 = or i1 %4, %5
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  tail call void @abort() #14
  unreachable

8:                                                ; preds = %2
  ret i8* %3
}

; Function Attrs: inaccessiblemem_or_argmemonly mustprogress nounwind willreturn allocsize(1)
declare noalias noundef i8* @realloc(i8* nocapture, i64 noundef) local_unnamed_addr #4

; Function Attrs: noreturn nounwind ssp uwtable
define void @abort_msg(%struct._str* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8, !tbaa !10
  %3 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %4 = load i64, i64* %3, align 8, !tbaa !14
  %5 = trunc i64 %4 to i32
  %6 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %7 = load i8*, i8** %6, align 8, !tbaa !17
  %8 = tail call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %2, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0), i32 %5, i8* %7)
  tail call void @quit(i64 1)
  unreachable
}

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(%struct.__sFILE* nocapture noundef, i8* nocapture noundef readonly, ...) local_unnamed_addr #6

; Function Attrs: noreturn nounwind ssp uwtable
define void @quit(i64 %0) local_unnamed_addr #5 {
  %2 = trunc i64 %0 to i32
  tail call void @exit(i32 %2) #16
  unreachable
}

; Function Attrs: noreturn
declare void @exit(i32) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nosync nounwind readnone ssp uwtable willreturn
define i64 @powll(i64 %0, i64 %1) local_unnamed_addr #8 {
  %3 = sitofp i64 %0 to double
  %4 = sitofp i64 %1 to double
  %5 = tail call double @llvm.pow.f64(double %3, double %4)
  %6 = fptosi double %5 to i64
  ret i64 %6
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.pow.f64(double, double) #9

; Function Attrs: nounwind ssp uwtable
define i64 @random_() local_unnamed_addr #0 {
  tail call void @srandomdev() #17
  %1 = tail call i64 @random() #17
  ret i64 %1
}

declare void @srandomdev() local_unnamed_addr #10

declare i64 @random() local_unnamed_addr #10

; Function Attrs: nounwind ssp uwtable
define %struct._str* @prompt() local_unnamed_addr #0 {
  %1 = alloca i8*, align 8
  %2 = alloca i64, align 8
  %3 = bitcast i8** %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3) #17
  store i8* null, i8** %1, align 8, !tbaa !10
  %4 = bitcast i64* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4) #17
  %5 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8, !tbaa !10
  %6 = call i64 @getline(i8** nonnull %1, i64* nonnull %2, %struct.__sFILE* %5) #17
  %7 = call %struct._str* @allocate_str(i64 0) #17
  %8 = getelementptr inbounds %struct._str, %struct._str* %7, i64 0, i32 0
  %9 = load i8*, i8** %8, align 8, !tbaa !17
  call void @free(i8* %9)
  %10 = getelementptr inbounds %struct._str, %struct._str* %7, i64 0, i32 1
  store i64 %6, i64* %10, align 8, !tbaa !14
  %11 = load i8*, i8** %1, align 8, !tbaa !10
  store i8* %11, i8** %8, align 8, !tbaa !17
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4) #17
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3) #17
  ret %struct._str* %7
}

declare i64 @getline(i8**, i64*, %struct.__sFILE*) local_unnamed_addr #10

declare %struct._str* @allocate_str(i64) local_unnamed_addr #10

; Function Attrs: inaccessiblemem_or_argmemonly mustprogress nounwind willreturn
declare void @free(i8* nocapture noundef) local_unnamed_addr #11

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn
define zeroext i1 @compare_val(i64 %0, i64 %1) local_unnamed_addr #12 {
  %3 = icmp eq i64 %0, %1
  ret i1 %3
}

attributes #0 = { nounwind ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #1 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #2 = { inaccessiblememonly mustprogress nofree nounwind willreturn allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #3 = { cold noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #4 = { inaccessiblemem_or_argmemonly mustprogress nounwind willreturn allocsize(1) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #5 = { noreturn nounwind ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #6 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #7 = { noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #8 = { mustprogress nofree nosync nounwind readnone ssp uwtable willreturn "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #9 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #10 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #11 = { inaccessiblemem_or_argmemonly mustprogress nounwind willreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #12 = { mustprogress nofree norecurse nosync nounwind readnone ssp uwtable willreturn "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #13 = { allocsize(0) }
attributes #14 = { cold noreturn nounwind }
attributes #15 = { allocsize(1) }
attributes #16 = { noreturn nounwind }
attributes #17 = { nounwind }

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
!10 = !{!11, !11, i64 0}
!11 = !{!"any pointer", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{!15, !16, i64 8}
!15 = !{!"_str", !11, i64 0, !16, i64 8}
!16 = !{!"long long", !12, i64 0}
!17 = !{!15, !11, i64 0}
