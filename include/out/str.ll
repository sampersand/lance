; ModuleID = 'str.c'
source_filename = "str.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct._str = type { i8*, i64 }

@.str = private unnamed_addr constant [5 x i8] c"%.*s\00", align 1
@__stdoutp = external local_unnamed_addr global %struct.__sFILE*, align 8
@.str.1 = private unnamed_addr constant [6 x i8] c"%.*s\0A\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"%lld\00", align 1

; Function Attrs: nounwind ssp uwtable
define %struct._str* @allocate_str(i64 %0) local_unnamed_addr #0 {
  %2 = tail call i8* @xmalloc(i64 16) #12
  %3 = bitcast i8* %2 to %struct._str*
  %4 = tail call i8* @xmalloc(i64 %0) #12
  %5 = bitcast i8* %2 to i8**
  store i8* %4, i8** %5, align 8, !tbaa !8
  %6 = getelementptr inbounds i8, i8* %2, i64 8
  %7 = bitcast i8* %6 to i64*
  store i64 %0, i64* %7, align 8, !tbaa !14
  ret %struct._str* %3
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare i8* @xmalloc(i64) local_unnamed_addr #2

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind ssp uwtable
define %struct._str* @create_str_from_borrowed(i8* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = tail call i64 @strlen(i8* nonnull dereferenceable(1) %0)
  %3 = tail call i8* @xmalloc(i64 16) #12
  %4 = bitcast i8* %3 to %struct._str*
  %5 = tail call i8* @xmalloc(i64 %2) #12
  %6 = bitcast i8* %3 to i8**
  store i8* %5, i8** %6, align 8, !tbaa !8
  %7 = getelementptr inbounds i8, i8* %3, i64 8
  %8 = bitcast i8* %7 to i64*
  store i64 %2, i64* %8, align 8, !tbaa !14
  %9 = tail call i8* @strdup(i8* %0)
  store i8* %9, i8** %6, align 8, !tbaa !8
  ret %struct._str* %4
}

; Function Attrs: argmemonly nofree nounwind readonly willreturn
declare i64 @strlen(i8* nocapture) local_unnamed_addr #3

; Function Attrs: nofree nounwind willreturn
declare noalias i8* @strdup(i8* nocapture readonly) local_unnamed_addr #4

; Function Attrs: nofree nounwind ssp uwtable
define void @print_str(%struct._str* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %3 = load i64, i64* %2, align 8, !tbaa !14
  %4 = trunc i64 %3 to i32
  %5 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %6 = load i8*, i8** %5, align 8, !tbaa !8
  %7 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0), i32 %4, i8* %6)
  %8 = load %struct.__sFILE*, %struct.__sFILE** @__stdoutp, align 8, !tbaa !15
  %9 = tail call i32 @fflush(%struct.__sFILE* %8)
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @fflush(%struct.__sFILE* nocapture noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind ssp uwtable
define void @println_str(%struct._str* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %3 = load i64, i64* %2, align 8, !tbaa !14
  %4 = trunc i64 %3 to i32
  %5 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %6 = load i8*, i8** %5, align 8, !tbaa !8
  %7 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %4, i8* %6)
  %8 = load %struct.__sFILE*, %struct.__sFILE** @__stdoutp, align 8, !tbaa !15
  %9 = tail call i32 @fflush(%struct.__sFILE* %8)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @substr(%struct._str* nocapture readonly %0, i64 %1, i64 %2) local_unnamed_addr #0 {
  %4 = tail call i8* @xmalloc(i64 16) #12
  %5 = bitcast i8* %4 to %struct._str*
  %6 = tail call i8* @xmalloc(i64 %2) #12
  %7 = bitcast i8* %4 to i8**
  store i8* %6, i8** %7, align 8, !tbaa !8
  %8 = getelementptr inbounds i8, i8* %4, i64 8
  %9 = bitcast i8* %8 to i64*
  store i64 %2, i64* %9, align 8, !tbaa !14
  %10 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %11 = load i8*, i8** %10, align 8, !tbaa !8
  %12 = getelementptr inbounds i8, i8* %11, i64 %1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %6, i8* align 1 %12, i64 %2, i1 false) #12
  ret %struct._str* %5
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @num_to_str(i64 %0) local_unnamed_addr #0 {
  %2 = tail call i8* @xmalloc(i64 16) #12
  %3 = bitcast i8* %2 to %struct._str*
  %4 = tail call i8* @xmalloc(i64 42) #12
  %5 = bitcast i8* %2 to i8**
  store i8* %4, i8** %5, align 8, !tbaa !8
  %6 = getelementptr inbounds i8, i8* %2, i64 8
  %7 = bitcast i8* %6 to i64*
  store i64 42, i64* %7, align 8, !tbaa !14
  %8 = call i32 (i8*, i8*, ...) @sprintf(i8* nonnull dereferenceable(1) %4, i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i64 0, i64 0), i64 %0)
  %9 = load i8*, i8** %5, align 8, !tbaa !8
  %10 = tail call i64 @strlen(i8* nonnull dereferenceable(1) %9)
  store i64 %10, i64* %7, align 8, !tbaa !14
  ret %struct._str* %3
}

; Function Attrs: nofree nounwind ssp uwtable willreturn
define i64 @str_to_num(%struct._str* nocapture readonly %0) local_unnamed_addr #7 {
  %2 = alloca [1024 x i8], align 1
  %3 = getelementptr inbounds [1024 x i8], [1024 x i8]* %2, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 1024, i8* nonnull %3) #12
  %4 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %5 = load i8*, i8** %4, align 8, !tbaa !8
  %6 = call i8* @strncpy(i8* nonnull dereferenceable(1) %3, i8* nonnull dereferenceable(1) %5, i64 1023)
  %7 = call i64 @strtoll(i8* nocapture nonnull %3, i8** null, i32 10)
  call void @llvm.lifetime.end.p0i8(i64 1024, i8* nonnull %3) #12
  ret i64 %7
}

; Function Attrs: nofree nounwind willreturn
declare i64 @strtoll(i8* readonly, i8** nocapture, i32) local_unnamed_addr #4

; Function Attrs: norecurse nounwind readonly ssp uwtable willreturn
define i64 @str_to_ascii(%struct._str* nocapture readonly %0) local_unnamed_addr #8 {
  %2 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %3 = load i8*, i8** %2, align 8, !tbaa !8
  %4 = load i8, i8* %3, align 1, !tbaa !16
  %5 = sext i8 %4 to i64
  ret i64 %5
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @ascii_to_str(i64 %0) local_unnamed_addr #0 {
  %2 = tail call i8* @xmalloc(i64 16) #12
  %3 = bitcast i8* %2 to %struct._str*
  %4 = tail call i8* @xmalloc(i64 1) #12
  %5 = bitcast i8* %2 to i8**
  store i8* %4, i8** %5, align 8, !tbaa !8
  %6 = getelementptr inbounds i8, i8* %2, i64 8
  %7 = bitcast i8* %6 to i64*
  store i64 1, i64* %7, align 8, !tbaa !14
  %8 = trunc i64 %0 to i8
  store i8 %8, i8* %4, align 1, !tbaa !16
  ret %struct._str* %3
}

; Function Attrs: norecurse nounwind readonly ssp uwtable
define i32 @compare_strs(%struct._str* readonly %0, %struct._str* readonly %1) local_unnamed_addr #9 {
  %3 = icmp eq %struct._str* %0, %1
  br i1 %3, label %40, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %6 = load i64, i64* %5, align 8, !tbaa !14
  %7 = icmp sgt i64 %6, 0
  %8 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 1
  %9 = load i64, i64* %8, align 8, !tbaa !14
  br i1 %7, label %10, label %35

10:                                               ; preds = %4
  %11 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %12 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 0
  %13 = icmp sgt i64 %9, 0
  %14 = select i1 %13, i64 %9, i64 0
  br label %17

15:                                               ; preds = %20
  %16 = icmp slt i64 %31, %6
  br i1 %16, label %17, label %35, !llvm.loop !17

17:                                               ; preds = %10, %15
  %18 = phi i64 [ 0, %10 ], [ %31, %15 ]
  %19 = icmp eq i64 %18, %14
  br i1 %19, label %35, label %20

20:                                               ; preds = %17
  %21 = load i8*, i8** %11, align 8, !tbaa !8
  %22 = getelementptr inbounds i8, i8* %21, i64 %18
  %23 = load i8, i8* %22, align 1, !tbaa !16
  %24 = sext i8 %23 to i64
  %25 = load i8*, i8** %12, align 8, !tbaa !8
  %26 = getelementptr inbounds i8, i8* %25, i64 %18
  %27 = load i8, i8* %26, align 1, !tbaa !16
  %28 = sext i8 %27 to i64
  %29 = sub nsw i64 %24, %28
  %30 = icmp eq i64 %29, 0
  %31 = add nuw nsw i64 %18, 1
  br i1 %30, label %15, label %32

32:                                               ; preds = %20
  %33 = icmp slt i64 %29, 0
  %34 = select i1 %33, i32 -1, i32 1
  br label %40

35:                                               ; preds = %17, %15, %4
  %36 = icmp slt i64 %6, %9
  %37 = icmp ne i64 %6, %9
  %38 = zext i1 %37 to i32
  %39 = select i1 %36, i32 -1, i32 %38
  br label %40

40:                                               ; preds = %32, %35, %2
  %41 = phi i32 [ %34, %32 ], [ 0, %2 ], [ %39, %35 ]
  ret i32 %41
}

; Function Attrs: norecurse nounwind readonly ssp uwtable
define zeroext i1 @compare_str(i64 %0, i64 %1) local_unnamed_addr #9 {
  %3 = inttoptr i64 %0 to %struct._str*
  %4 = inttoptr i64 %1 to %struct._str*
  %5 = icmp eq %struct._str* %3, %4
  br i1 %5, label %33, label %6

6:                                                ; preds = %2
  %7 = getelementptr inbounds %struct._str, %struct._str* %3, i64 0, i32 1
  %8 = load i64, i64* %7, align 8, !tbaa !14
  %9 = icmp sgt i64 %8, 0
  %10 = getelementptr inbounds %struct._str, %struct._str* %4, i64 0, i32 1
  %11 = load i64, i64* %10, align 8, !tbaa !14
  br i1 %9, label %12, label %31

12:                                               ; preds = %6
  %13 = getelementptr inbounds %struct._str, %struct._str* %3, i64 0, i32 0
  %14 = getelementptr inbounds %struct._str, %struct._str* %4, i64 0, i32 0
  %15 = icmp sgt i64 %11, 0
  %16 = select i1 %15, i64 %11, i64 0
  br label %19

17:                                               ; preds = %22
  %18 = icmp eq i64 %30, %8
  br i1 %18, label %31, label %19, !llvm.loop !17

19:                                               ; preds = %17, %12
  %20 = phi i64 [ 0, %12 ], [ %30, %17 ]
  %21 = icmp eq i64 %20, %16
  br i1 %21, label %31, label %22

22:                                               ; preds = %19
  %23 = load i8*, i8** %13, align 8, !tbaa !8
  %24 = getelementptr inbounds i8, i8* %23, i64 %20
  %25 = load i8, i8* %24, align 1, !tbaa !16
  %26 = load i8*, i8** %14, align 8, !tbaa !8
  %27 = getelementptr inbounds i8, i8* %26, i64 %20
  %28 = load i8, i8* %27, align 1, !tbaa !16
  %29 = icmp eq i8 %25, %28
  %30 = add nuw nsw i64 %20, 1
  br i1 %29, label %17, label %33

31:                                               ; preds = %19, %17, %6
  %32 = icmp eq i64 %8, %11
  br label %33

33:                                               ; preds = %22, %2, %31
  %34 = phi i1 [ true, %2 ], [ %32, %31 ], [ false, %22 ]
  ret i1 %34
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @concat_strs(%struct._str* nocapture readonly %0, %struct._str* nocapture readonly %1) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %4 = load i64, i64* %3, align 8, !tbaa !14
  %5 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 1
  %6 = load i64, i64* %5, align 8, !tbaa !14
  %7 = add nsw i64 %6, %4
  %8 = tail call i8* @xmalloc(i64 16) #12
  %9 = bitcast i8* %8 to %struct._str*
  %10 = tail call i8* @xmalloc(i64 %7) #12
  %11 = bitcast i8* %8 to i8**
  store i8* %10, i8** %11, align 8, !tbaa !8
  %12 = getelementptr inbounds i8, i8* %8, i64 8
  %13 = bitcast i8* %12 to i64*
  store i64 %7, i64* %13, align 8, !tbaa !14
  %14 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %15 = load i8*, i8** %14, align 8, !tbaa !8
  %16 = load i64, i64* %3, align 8, !tbaa !14
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %10, i8* align 1 %15, i64 %16, i1 false) #12
  %17 = load i8*, i8** %11, align 8, !tbaa !8
  %18 = load i64, i64* %3, align 8, !tbaa !14
  %19 = getelementptr inbounds i8, i8* %17, i64 %18
  %20 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 0
  %21 = load i8*, i8** %20, align 8, !tbaa !8
  %22 = load i64, i64* %5, align 8, !tbaa !14
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %19, i8* align 1 %21, i64 %22, i1 false) #12
  ret %struct._str* %9
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @repeat_str(%struct._str* nocapture readonly %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp slt i64 %1, 1
  br i1 %3, label %26, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %6 = load i64, i64* %5, align 8, !tbaa !14
  %7 = mul nsw i64 %6, %1
  %8 = tail call i8* @xmalloc(i64 16) #12
  %9 = tail call i8* @xmalloc(i64 %7) #12
  %10 = bitcast i8* %8 to i8**
  store i8* %9, i8** %10, align 8, !tbaa !8
  %11 = getelementptr inbounds i8, i8* %8, i64 8
  %12 = bitcast i8* %11 to i64*
  store i64 %7, i64* %12, align 8, !tbaa !14
  %13 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %14 = load i64, i64* %5, align 8, !tbaa !14
  br label %15

15:                                               ; preds = %4, %15
  %16 = phi i64 [ %14, %4 ], [ %21, %15 ]
  %17 = phi i8* [ %9, %4 ], [ %22, %15 ]
  %18 = phi i64 [ %1, %4 ], [ %19, %15 ]
  %19 = add nsw i64 %18, -1
  %20 = load i8*, i8** %13, align 8, !tbaa !8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %17, i8* align 1 %20, i64 %16, i1 false) #12
  %21 = load i64, i64* %5, align 8, !tbaa !14
  %22 = getelementptr inbounds i8, i8* %17, i64 %21
  %23 = icmp eq i64 %19, 0
  br i1 %23, label %24, label %15, !llvm.loop !19

24:                                               ; preds = %15
  %25 = bitcast i8* %8 to %struct._str*
  br label %26

26:                                               ; preds = %24, %2
  %27 = phi %struct._str* [ null, %2 ], [ %25, %24 ]
  ret %struct._str* %27
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare i8* @strncpy(i8* noalias returned writeonly, i8* noalias nocapture readonly, i64) local_unnamed_addr #10

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nofree nounwind
declare noundef i32 @sprintf(i8* noalias nocapture noundef writeonly, i8* nocapture noundef readonly, ...) #11

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nofree nounwind readonly willreturn "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nofree nounwind willreturn "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree nounwind ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nofree nounwind "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nofree nounwind ssp uwtable willreturn "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { norecurse nounwind readonly ssp uwtable willreturn "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { norecurse nounwind readonly ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { argmemonly nofree nounwind willreturn }
attributes #11 = { nofree nounwind }
attributes #12 = { nounwind }

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
!9 = !{!"_str", !10, i64 0, !13, i64 8}
!10 = !{!"any pointer", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{!"long long", !11, i64 0}
!14 = !{!9, !13, i64 8}
!15 = !{!10, !10, i64 0}
!16 = !{!11, !11, i64 0}
!17 = distinct !{!17, !18}
!18 = !{!"llvm.loop.mustprogress"}
!19 = distinct !{!19, !18}
