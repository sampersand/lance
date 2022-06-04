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
  %2 = tail call i8* @xmalloc(i64 16) #16
  %3 = bitcast i8* %2 to %struct._str*
  %4 = tail call i8* @xmalloc(i64 %0) #16
  %5 = bitcast i8* %2 to i8**
  store i8* %4, i8** %5, align 8, !tbaa !10
  %6 = getelementptr inbounds i8, i8* %2, i64 8
  %7 = bitcast i8* %6 to i64*
  store i64 %0, i64* %7, align 8, !tbaa !16
  ret %struct._str* %3
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare i8* @xmalloc(i64) local_unnamed_addr #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind ssp uwtable
define %struct._str* @create_str_from_borrowed(i8* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = tail call i64 @strlen(i8* noundef nonnull dereferenceable(1) %0)
  %3 = tail call i8* @xmalloc(i64 16) #16
  %4 = bitcast i8* %3 to %struct._str*
  %5 = tail call i8* @xmalloc(i64 %2) #16
  %6 = bitcast i8* %3 to i8**
  store i8* %5, i8** %6, align 8, !tbaa !10
  %7 = getelementptr inbounds i8, i8* %3, i64 8
  %8 = bitcast i8* %7 to i64*
  store i64 %2, i64* %8, align 8, !tbaa !16
  %9 = tail call i8* @strdup(i8* %0)
  store i8* %9, i8** %6, align 8, !tbaa !10
  ret %struct._str* %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i64 @strlen(i8* nocapture) local_unnamed_addr #3

; Function Attrs: inaccessiblemem_or_argmemonly mustprogress nofree nounwind willreturn
declare noalias i8* @strdup(i8* nocapture readonly) local_unnamed_addr #4

; Function Attrs: nofree nounwind ssp uwtable
define void @print_str(%struct._str* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %3 = load i64, i64* %2, align 8, !tbaa !16
  %4 = trunc i64 %3 to i32
  %5 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %6 = load i8*, i8** %5, align 8, !tbaa !10
  %7 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0), i32 %4, i8* %6)
  %8 = load %struct.__sFILE*, %struct.__sFILE** @__stdoutp, align 8, !tbaa !17
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
  %3 = load i64, i64* %2, align 8, !tbaa !16
  %4 = trunc i64 %3 to i32
  %5 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %6 = load i8*, i8** %5, align 8, !tbaa !10
  %7 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %4, i8* %6)
  %8 = load %struct.__sFILE*, %struct.__sFILE** @__stdoutp, align 8, !tbaa !17
  %9 = tail call i32 @fflush(%struct.__sFILE* %8)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @substr(%struct._str* nocapture readonly %0, i64 %1, i64 %2) local_unnamed_addr #0 {
  %4 = tail call i8* @xmalloc(i64 16) #16
  %5 = bitcast i8* %4 to %struct._str*
  %6 = tail call i8* @xmalloc(i64 %2) #16
  %7 = bitcast i8* %4 to i8**
  store i8* %6, i8** %7, align 8, !tbaa !10
  %8 = getelementptr inbounds i8, i8* %4, i64 8
  %9 = bitcast i8* %8 to i64*
  store i64 %2, i64* %9, align 8, !tbaa !16
  %10 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %11 = load i8*, i8** %10, align 8, !tbaa !10
  %12 = getelementptr inbounds i8, i8* %11, i64 %1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %6, i8* align 1 %12, i64 %2, i1 false) #16
  ret %struct._str* %5
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @num_to_str(i64 %0) local_unnamed_addr #0 {
  %2 = tail call i8* @xmalloc(i64 16) #16
  %3 = bitcast i8* %2 to %struct._str*
  %4 = tail call i8* @xmalloc(i64 42) #16
  %5 = bitcast i8* %2 to i8**
  store i8* %4, i8** %5, align 8, !tbaa !10
  %6 = getelementptr inbounds i8, i8* %2, i64 8
  %7 = bitcast i8* %6 to i64*
  store i64 42, i64* %7, align 8, !tbaa !16
  %8 = call i32 (i8*, i8*, ...) @sprintf(i8* nonnull dereferenceable(1) %4, i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i64 0, i64 0), i64 %0)
  %9 = load i8*, i8** %5, align 8, !tbaa !10
  %10 = tail call i64 @strlen(i8* noundef nonnull dereferenceable(1) %9)
  store i64 %10, i64* %7, align 8, !tbaa !16
  ret %struct._str* %3
}

; Function Attrs: mustprogress nofree nounwind ssp uwtable willreturn
define i64 @str_to_num(%struct._str* nocapture readonly %0) local_unnamed_addr #7 {
  %2 = alloca [1024 x i8], align 1
  %3 = getelementptr inbounds [1024 x i8], [1024 x i8]* %2, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 1024, i8* nonnull %3) #16
  %4 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %5 = load i8*, i8** %4, align 8, !tbaa !10
  %6 = call i8* @strncpy(i8* noundef nonnull dereferenceable(1) %3, i8* noundef nonnull dereferenceable(1) %5, i64 1023)
  %7 = call i64 @strtoll(i8* nocapture nonnull %3, i8** null, i32 10)
  call void @llvm.lifetime.end.p0i8(i64 1024, i8* nonnull %3) #16
  ret i64 %7
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare i64 @strtoll(i8* readonly, i8** nocapture, i32) local_unnamed_addr #8

; Function Attrs: mustprogress nofree norecurse nosync nounwind readonly ssp uwtable willreturn
define i64 @str_to_ascii(%struct._str* nocapture readonly %0) local_unnamed_addr #9 {
  %2 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %3 = load i8*, i8** %2, align 8, !tbaa !10
  %4 = load i8, i8* %3, align 1, !tbaa !18
  %5 = sext i8 %4 to i64
  ret i64 %5
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @ascii_to_str(i64 %0) local_unnamed_addr #0 {
  %2 = tail call i8* @xmalloc(i64 16) #16
  %3 = bitcast i8* %2 to %struct._str*
  %4 = tail call i8* @xmalloc(i64 1) #16
  %5 = bitcast i8* %2 to i8**
  store i8* %4, i8** %5, align 8, !tbaa !10
  %6 = getelementptr inbounds i8, i8* %2, i64 8
  %7 = bitcast i8* %6 to i64*
  store i64 1, i64* %7, align 8, !tbaa !16
  %8 = trunc i64 %0 to i8
  store i8 %8, i8* %4, align 1, !tbaa !18
  ret %struct._str* %3
}

; Function Attrs: nofree norecurse nosync nounwind readonly ssp uwtable
define i32 @compare_strs(%struct._str* readonly %0, %struct._str* readonly %1) local_unnamed_addr #10 {
  %3 = icmp eq %struct._str* %0, %1
  br i1 %3, label %39, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %6 = load i64, i64* %5, align 8, !tbaa !16
  %7 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %8 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 0
  %9 = icmp sgt i64 %6, 0
  %10 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 1
  %11 = load i64, i64* %10, align 8, !tbaa !16
  br i1 %9, label %12, label %34

12:                                               ; preds = %4
  %13 = call i64 @llvm.smax.i64(i64 %11, i64 0)
  br label %16

14:                                               ; preds = %19
  %15 = icmp eq i64 %30, %6
  br i1 %15, label %34, label %16, !llvm.loop !19

16:                                               ; preds = %12, %14
  %17 = phi i64 [ 0, %12 ], [ %30, %14 ]
  %18 = icmp eq i64 %17, %13
  br i1 %18, label %34, label %19

19:                                               ; preds = %16
  %20 = load i8*, i8** %7, align 8, !tbaa !10
  %21 = getelementptr inbounds i8, i8* %20, i64 %17
  %22 = load i8, i8* %21, align 1, !tbaa !18
  %23 = sext i8 %22 to i64
  %24 = load i8*, i8** %8, align 8, !tbaa !10
  %25 = getelementptr inbounds i8, i8* %24, i64 %17
  %26 = load i8, i8* %25, align 1, !tbaa !18
  %27 = sext i8 %26 to i64
  %28 = sub nsw i64 %23, %27
  %29 = icmp eq i64 %28, 0
  %30 = add nuw nsw i64 %17, 1
  br i1 %29, label %14, label %31

31:                                               ; preds = %19
  %32 = icmp slt i64 %28, 0
  %33 = select i1 %32, i32 -1, i32 1
  br label %39

34:                                               ; preds = %16, %14, %4
  %35 = icmp slt i64 %6, %11
  %36 = icmp ne i64 %6, %11
  %37 = zext i1 %36 to i32
  %38 = select i1 %35, i32 -1, i32 %37
  br label %39

39:                                               ; preds = %31, %34, %2
  %40 = phi i32 [ %33, %31 ], [ 0, %2 ], [ %38, %34 ]
  ret i32 %40
}

; Function Attrs: nofree nosync nounwind readonly ssp uwtable
define zeroext i1 @compare_str(i64 %0, i64 %1) local_unnamed_addr #11 {
  %3 = inttoptr i64 %0 to %struct._str*
  %4 = inttoptr i64 %1 to %struct._str*
  %5 = icmp eq %struct._str* %3, %4
  br i1 %5, label %32, label %6

6:                                                ; preds = %2
  %7 = getelementptr inbounds %struct._str, %struct._str* %3, i64 0, i32 1
  %8 = load i64, i64* %7, align 8, !tbaa !16
  %9 = getelementptr inbounds %struct._str, %struct._str* %3, i64 0, i32 0
  %10 = getelementptr inbounds %struct._str, %struct._str* %4, i64 0, i32 0
  %11 = icmp sgt i64 %8, 0
  %12 = getelementptr inbounds %struct._str, %struct._str* %4, i64 0, i32 1
  %13 = load i64, i64* %12, align 8, !tbaa !16
  br i1 %11, label %14, label %30

14:                                               ; preds = %6
  %15 = tail call i64 @llvm.smax.i64(i64 %13, i64 0) #16
  br label %18

16:                                               ; preds = %21
  %17 = icmp eq i64 %29, %8
  br i1 %17, label %30, label %18, !llvm.loop !19

18:                                               ; preds = %16, %14
  %19 = phi i64 [ 0, %14 ], [ %29, %16 ]
  %20 = icmp eq i64 %19, %15
  br i1 %20, label %30, label %21

21:                                               ; preds = %18
  %22 = load i8*, i8** %9, align 8, !tbaa !10
  %23 = getelementptr inbounds i8, i8* %22, i64 %19
  %24 = load i8, i8* %23, align 1, !tbaa !18
  %25 = load i8*, i8** %10, align 8, !tbaa !10
  %26 = getelementptr inbounds i8, i8* %25, i64 %19
  %27 = load i8, i8* %26, align 1, !tbaa !18
  %28 = icmp eq i8 %24, %27
  %29 = add nuw nsw i64 %19, 1
  br i1 %28, label %16, label %32

30:                                               ; preds = %18, %16, %6
  %31 = icmp eq i64 %8, %13
  br label %32

32:                                               ; preds = %21, %2, %30
  %33 = phi i1 [ true, %2 ], [ %31, %30 ], [ false, %21 ]
  ret i1 %33
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @concat_strs(%struct._str* nocapture readonly %0, %struct._str* nocapture readonly %1) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %4 = load i64, i64* %3, align 8, !tbaa !16
  %5 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 1
  %6 = load i64, i64* %5, align 8, !tbaa !16
  %7 = add nsw i64 %6, %4
  %8 = tail call i8* @xmalloc(i64 16) #16
  %9 = bitcast i8* %8 to %struct._str*
  %10 = tail call i8* @xmalloc(i64 %7) #16
  %11 = bitcast i8* %8 to i8**
  store i8* %10, i8** %11, align 8, !tbaa !10
  %12 = getelementptr inbounds i8, i8* %8, i64 8
  %13 = bitcast i8* %12 to i64*
  store i64 %7, i64* %13, align 8, !tbaa !16
  %14 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %15 = load i8*, i8** %14, align 8, !tbaa !10
  %16 = load i64, i64* %3, align 8, !tbaa !16
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %10, i8* align 1 %15, i64 %16, i1 false) #16
  %17 = load i8*, i8** %11, align 8, !tbaa !10
  %18 = load i64, i64* %3, align 8, !tbaa !16
  %19 = getelementptr inbounds i8, i8* %17, i64 %18
  %20 = getelementptr inbounds %struct._str, %struct._str* %1, i64 0, i32 0
  %21 = load i8*, i8** %20, align 8, !tbaa !10
  %22 = load i64, i64* %5, align 8, !tbaa !16
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %19, i8* align 1 %21, i64 %22, i1 false) #16
  ret %struct._str* %9
}

; Function Attrs: nounwind ssp uwtable
define %struct._str* @repeat_str(%struct._str* nocapture readonly %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp slt i64 %1, 1
  br i1 %3, label %26, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 1
  %6 = load i64, i64* %5, align 8, !tbaa !16
  %7 = mul nsw i64 %6, %1
  %8 = tail call i8* @xmalloc(i64 16) #16
  %9 = tail call i8* @xmalloc(i64 %7) #16
  %10 = bitcast i8* %8 to i8**
  store i8* %9, i8** %10, align 8, !tbaa !10
  %11 = getelementptr inbounds i8, i8* %8, i64 8
  %12 = bitcast i8* %11 to i64*
  store i64 %7, i64* %12, align 8, !tbaa !16
  %13 = getelementptr inbounds %struct._str, %struct._str* %0, i64 0, i32 0
  %14 = load i64, i64* %5, align 8, !tbaa !16
  br label %15

15:                                               ; preds = %4, %15
  %16 = phi i64 [ %14, %4 ], [ %21, %15 ]
  %17 = phi i8* [ %9, %4 ], [ %22, %15 ]
  %18 = phi i64 [ %1, %4 ], [ %19, %15 ]
  %19 = add nsw i64 %18, -1
  %20 = load i8*, i8** %13, align 8, !tbaa !10
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %17, i8* align 1 %20, i64 %16, i1 false) #16
  %21 = load i64, i64* %5, align 8, !tbaa !16
  %22 = getelementptr inbounds i8, i8* %17, i64 %21
  %23 = icmp eq i64 %19, 0
  br i1 %23, label %24, label %15, !llvm.loop !21

24:                                               ; preds = %15
  %25 = bitcast i8* %8 to %struct._str*
  br label %26

26:                                               ; preds = %24, %2
  %27 = phi %struct._str* [ null, %2 ], [ %25, %24 ]
  ret %struct._str* %27
}

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare i8* @strncpy(i8* noalias returned writeonly, i8* noalias nocapture readonly, i64) local_unnamed_addr #12

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.smax.i64(i64, i64) #13

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #14

; Function Attrs: nofree nounwind
declare noundef i32 @sprintf(i8* noalias nocapture noundef writeonly, i8* nocapture noundef readonly, ...) #15

attributes #0 = { nounwind ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #1 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #3 = { argmemonly mustprogress nofree nounwind readonly willreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #4 = { inaccessiblemem_or_argmemonly mustprogress nofree nounwind willreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #5 = { nofree nounwind ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #6 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #7 = { mustprogress nofree nounwind ssp uwtable willreturn "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #8 = { mustprogress nofree nounwind willreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #9 = { mustprogress nofree norecurse nosync nounwind readonly ssp uwtable willreturn "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #10 = { nofree norecurse nosync nounwind readonly ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #11 = { nofree nosync nounwind readonly ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #12 = { argmemonly mustprogress nofree nounwind willreturn }
attributes #13 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #14 = { argmemonly nofree nounwind willreturn }
attributes #15 = { nofree nounwind }
attributes #16 = { nounwind }

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
!11 = !{!"_str", !12, i64 0, !15, i64 8}
!12 = !{!"any pointer", !13, i64 0}
!13 = !{!"omnipotent char", !14, i64 0}
!14 = !{!"Simple C/C++ TBAA"}
!15 = !{!"long long", !13, i64 0}
!16 = !{!11, !15, i64 8}
!17 = !{!12, !12, i64 0}
!18 = !{!13, !13, i64 0}
!19 = distinct !{!19, !20}
!20 = !{!"llvm.loop.mustprogress"}
!21 = distinct !{!21, !20}
