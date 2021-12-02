; ModuleID = 'str.c'
source_filename = "str.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct._str = type { i8*, i64 }

@.str = private unnamed_addr constant [5 x i8] c"%.*s\00", align 1
@__stdoutp = external global %struct.__sFILE*, align 8
@.str.1 = private unnamed_addr constant [5 x i8] c"%lld\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @allocate_str(i64 %0) #0 !dbg !15 {
  %2 = alloca i64, align 8
  %3 = alloca %struct._str*, align 8
  store i64 %0, i64* %2, align 8
  call void @llvm.dbg.declare(metadata i64* %2, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata %struct._str** %3, metadata !32, metadata !DIExpression()), !dbg !33
  %4 = call i8* @xmalloc(i64 16), !dbg !34
  %5 = bitcast i8* %4 to %struct._str*, !dbg !34
  store %struct._str* %5, %struct._str** %3, align 8, !dbg !33
  %6 = load i64, i64* %2, align 8, !dbg !35
  %7 = call i8* @xmalloc(i64 %6), !dbg !36
  %8 = load %struct._str*, %struct._str** %3, align 8, !dbg !37
  %9 = getelementptr inbounds %struct._str, %struct._str* %8, i32 0, i32 0, !dbg !38
  store i8* %7, i8** %9, align 8, !dbg !39
  %10 = load i64, i64* %2, align 8, !dbg !40
  %11 = load %struct._str*, %struct._str** %3, align 8, !dbg !41
  %12 = getelementptr inbounds %struct._str, %struct._str* %11, i32 0, i32 1, !dbg !42
  store i64 %10, i64* %12, align 8, !dbg !43
  %13 = load %struct._str*, %struct._str** %3, align 8, !dbg !44
  ret %struct._str* %13, !dbg !45
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @xmalloc(i64) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @create_str_from_borrowed(i8* %0) #0 !dbg !46 {
  %2 = alloca i8*, align 8
  %3 = alloca %struct._str*, align 8
  store i8* %0, i8** %2, align 8
  call void @llvm.dbg.declare(metadata i8** %2, metadata !51, metadata !DIExpression()), !dbg !52
  call void @llvm.dbg.declare(metadata %struct._str** %3, metadata !53, metadata !DIExpression()), !dbg !54
  %4 = load i8*, i8** %2, align 8, !dbg !55
  %5 = call i64 @strlen(i8* %4), !dbg !56
  %6 = call %struct._str* @allocate_str(i64 %5), !dbg !57
  store %struct._str* %6, %struct._str** %3, align 8, !dbg !54
  %7 = load i8*, i8** %2, align 8, !dbg !58
  %8 = call i8* @strdup(i8* %7), !dbg !59
  %9 = load %struct._str*, %struct._str** %3, align 8, !dbg !60
  %10 = getelementptr inbounds %struct._str, %struct._str* %9, i32 0, i32 0, !dbg !61
  store i8* %8, i8** %10, align 8, !dbg !62
  %11 = load %struct._str*, %struct._str** %3, align 8, !dbg !63
  ret %struct._str* %11, !dbg !64
}

declare i64 @strlen(i8*) #2

declare i8* @strdup(i8*) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print(%struct._str* %0) #0 !dbg !65 {
  %2 = alloca %struct._str*, align 8
  store %struct._str* %0, %struct._str** %2, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %2, metadata !70, metadata !DIExpression()), !dbg !71
  %3 = load %struct._str*, %struct._str** %2, align 8, !dbg !72
  %4 = getelementptr inbounds %struct._str, %struct._str* %3, i32 0, i32 1, !dbg !73
  %5 = load i64, i64* %4, align 8, !dbg !73
  %6 = trunc i64 %5 to i32, !dbg !74
  %7 = load %struct._str*, %struct._str** %2, align 8, !dbg !75
  %8 = getelementptr inbounds %struct._str, %struct._str* %7, i32 0, i32 0, !dbg !76
  %9 = load i8*, i8** %8, align 8, !dbg !76
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0), i32 %6, i8* %9), !dbg !77
  %11 = load %struct.__sFILE*, %struct.__sFILE** @__stdoutp, align 8, !dbg !78
  %12 = call i32 @fflush(%struct.__sFILE* %11), !dbg !79
  ret void, !dbg !80
}

declare i32 @printf(i8*, ...) #2

declare i32 @fflush(%struct.__sFILE*) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @substr(%struct._str* %0, i64 %1, i64 %2) #0 !dbg !81 {
  %4 = alloca %struct._str*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca %struct._str*, align 8
  store %struct._str* %0, %struct._str** %4, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !84, metadata !DIExpression()), !dbg !85
  store i64 %1, i64* %5, align 8
  call void @llvm.dbg.declare(metadata i64* %5, metadata !86, metadata !DIExpression()), !dbg !87
  store i64 %2, i64* %6, align 8
  call void @llvm.dbg.declare(metadata i64* %6, metadata !88, metadata !DIExpression()), !dbg !89
  call void @llvm.dbg.declare(metadata %struct._str** %7, metadata !90, metadata !DIExpression()), !dbg !91
  %8 = load i64, i64* %6, align 8, !dbg !92
  %9 = call %struct._str* @allocate_str(i64 %8), !dbg !93
  store %struct._str* %9, %struct._str** %7, align 8, !dbg !91
  %10 = load %struct._str*, %struct._str** %7, align 8, !dbg !94
  %11 = getelementptr inbounds %struct._str, %struct._str* %10, i32 0, i32 0, !dbg !94
  %12 = load i8*, i8** %11, align 8, !dbg !94
  %13 = load %struct._str*, %struct._str** %4, align 8, !dbg !94
  %14 = getelementptr inbounds %struct._str, %struct._str* %13, i32 0, i32 0, !dbg !94
  %15 = load i8*, i8** %14, align 8, !dbg !94
  %16 = load i64, i64* %5, align 8, !dbg !94
  %17 = getelementptr inbounds i8, i8* %15, i64 %16, !dbg !94
  %18 = load i64, i64* %6, align 8, !dbg !94
  %19 = load %struct._str*, %struct._str** %7, align 8, !dbg !94
  %20 = getelementptr inbounds %struct._str, %struct._str* %19, i32 0, i32 0, !dbg !94
  %21 = load i8*, i8** %20, align 8, !dbg !94
  %22 = call i64 @llvm.objectsize.i64.p0i8(i8* %21, i1 false, i1 true, i1 false), !dbg !94
  %23 = call i8* @__memcpy_chk(i8* %12, i8* %17, i64 %18, i64 %22) #4, !dbg !94
  %24 = load %struct._str*, %struct._str** %7, align 8, !dbg !95
  ret %struct._str* %24, !dbg !96
}

; Function Attrs: nounwind
declare i8* @__memcpy_chk(i8*, i8*, i64, i64) #3

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1 immarg, i1 immarg, i1 immarg) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @num_to_str(i64 %0) #0 !dbg !97 {
  %2 = alloca i64, align 8
  %3 = alloca %struct._str*, align 8
  store i64 %0, i64* %2, align 8
  call void @llvm.dbg.declare(metadata i64* %2, metadata !98, metadata !DIExpression()), !dbg !99
  call void @llvm.dbg.declare(metadata %struct._str** %3, metadata !100, metadata !DIExpression()), !dbg !101
  %4 = call %struct._str* @allocate_str(i64 42), !dbg !102
  store %struct._str* %4, %struct._str** %3, align 8, !dbg !101
  %5 = load %struct._str*, %struct._str** %3, align 8, !dbg !103
  %6 = getelementptr inbounds %struct._str, %struct._str* %5, i32 0, i32 0, !dbg !103
  %7 = load i8*, i8** %6, align 8, !dbg !103
  %8 = load %struct._str*, %struct._str** %3, align 8, !dbg !103
  %9 = getelementptr inbounds %struct._str, %struct._str* %8, i32 0, i32 0, !dbg !103
  %10 = load i8*, i8** %9, align 8, !dbg !103
  %11 = call i64 @llvm.objectsize.i64.p0i8(i8* %10, i1 false, i1 true, i1 false), !dbg !103
  %12 = load i64, i64* %2, align 8, !dbg !103
  %13 = call i32 (i8*, i32, i64, i8*, ...) @__sprintf_chk(i8* %7, i32 0, i64 %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i64 %12), !dbg !103
  %14 = load %struct._str*, %struct._str** %3, align 8, !dbg !104
  %15 = getelementptr inbounds %struct._str, %struct._str* %14, i32 0, i32 0, !dbg !105
  %16 = load i8*, i8** %15, align 8, !dbg !105
  %17 = call i64 @strlen(i8* %16), !dbg !106
  %18 = load %struct._str*, %struct._str** %3, align 8, !dbg !107
  %19 = getelementptr inbounds %struct._str, %struct._str* %18, i32 0, i32 1, !dbg !108
  store i64 %17, i64* %19, align 8, !dbg !109
  %20 = load %struct._str*, %struct._str** %3, align 8, !dbg !110
  ret %struct._str* %20, !dbg !111
}

declare i32 @__sprintf_chk(i8*, i32, i64, i8*, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @str_to_num(%struct._str* %0) #0 !dbg !112 {
  %2 = alloca %struct._str*, align 8
  %3 = alloca [1024 x i8], align 1
  store %struct._str* %0, %struct._str** %2, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %2, metadata !115, metadata !DIExpression()), !dbg !116
  call void @llvm.dbg.declare(metadata [1024 x i8]* %3, metadata !117, metadata !DIExpression()), !dbg !121
  %4 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0, !dbg !122
  %5 = load %struct._str*, %struct._str** %2, align 8, !dbg !122
  %6 = getelementptr inbounds %struct._str, %struct._str* %5, i32 0, i32 0, !dbg !122
  %7 = load i8*, i8** %6, align 8, !dbg !122
  %8 = call i8* @__strncpy_chk(i8* %4, i8* %7, i64 1023, i64 1024) #4, !dbg !122
  %9 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0, !dbg !123
  %10 = call i64 @strtoll(i8* %9, i8** null, i32 10), !dbg !124
  ret i64 %10, !dbg !125
}

; Function Attrs: nounwind
declare i8* @__strncpy_chk(i8*, i8*, i64, i64) #3

declare i64 @strtoll(i8*, i8**, i32) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @str_to_ascii(%struct._str* %0) #0 !dbg !126 {
  %2 = alloca %struct._str*, align 8
  store %struct._str* %0, %struct._str** %2, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %2, metadata !127, metadata !DIExpression()), !dbg !128
  %3 = load %struct._str*, %struct._str** %2, align 8, !dbg !129
  %4 = getelementptr inbounds %struct._str, %struct._str* %3, i32 0, i32 0, !dbg !130
  %5 = load i8*, i8** %4, align 8, !dbg !130
  %6 = getelementptr inbounds i8, i8* %5, i64 0, !dbg !129
  %7 = load i8, i8* %6, align 1, !dbg !129
  %8 = sext i8 %7 to i64, !dbg !129
  ret i64 %8, !dbg !131
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @ascii_to_str(i64 %0) #0 !dbg !132 {
  %2 = alloca i64, align 8
  %3 = alloca %struct._str*, align 8
  store i64 %0, i64* %2, align 8
  call void @llvm.dbg.declare(metadata i64* %2, metadata !133, metadata !DIExpression()), !dbg !134
  call void @llvm.dbg.declare(metadata %struct._str** %3, metadata !135, metadata !DIExpression()), !dbg !136
  %4 = call %struct._str* @allocate_str(i64 1), !dbg !137
  store %struct._str* %4, %struct._str** %3, align 8, !dbg !136
  %5 = load i64, i64* %2, align 8, !dbg !138
  %6 = trunc i64 %5 to i8, !dbg !138
  %7 = load %struct._str*, %struct._str** %3, align 8, !dbg !139
  %8 = getelementptr inbounds %struct._str, %struct._str* %7, i32 0, i32 0, !dbg !140
  %9 = load i8*, i8** %8, align 8, !dbg !140
  %10 = getelementptr inbounds i8, i8* %9, i64 0, !dbg !139
  store i8 %6, i8* %10, align 1, !dbg !141
  %11 = load %struct._str*, %struct._str** %3, align 8, !dbg !142
  ret %struct._str* %11, !dbg !143
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @compare_strs(%struct._str* %0, %struct._str* %1) #0 !dbg !144 {
  %3 = alloca i32, align 4
  %4 = alloca %struct._str*, align 8
  %5 = alloca %struct._str*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store %struct._str* %0, %struct._str** %4, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !147, metadata !DIExpression()), !dbg !148
  store %struct._str* %1, %struct._str** %5, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %5, metadata !149, metadata !DIExpression()), !dbg !150
  %8 = load %struct._str*, %struct._str** %4, align 8, !dbg !151
  %9 = load %struct._str*, %struct._str** %5, align 8, !dbg !153
  %10 = icmp eq %struct._str* %8, %9, !dbg !154
  br i1 %10, label %11, label %12, !dbg !155

11:                                               ; preds = %2
  store i32 0, i32* %3, align 4, !dbg !156
  br label %75, !dbg !156

12:                                               ; preds = %2
  call void @llvm.dbg.declare(metadata i64* %6, metadata !157, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.declare(metadata i64* %7, metadata !160, metadata !DIExpression()), !dbg !161
  store i64 0, i64* %7, align 8, !dbg !161
  br label %13, !dbg !162

13:                                               ; preds = %51, %12
  %14 = load i64, i64* %7, align 8, !dbg !163
  %15 = load %struct._str*, %struct._str** %4, align 8, !dbg !165
  %16 = getelementptr inbounds %struct._str, %struct._str* %15, i32 0, i32 1, !dbg !166
  %17 = load i64, i64* %16, align 8, !dbg !166
  %18 = icmp slt i64 %14, %17, !dbg !167
  br i1 %18, label %19, label %25, !dbg !168

19:                                               ; preds = %13
  %20 = load i64, i64* %7, align 8, !dbg !169
  %21 = load %struct._str*, %struct._str** %5, align 8, !dbg !170
  %22 = getelementptr inbounds %struct._str, %struct._str* %21, i32 0, i32 1, !dbg !171
  %23 = load i64, i64* %22, align 8, !dbg !171
  %24 = icmp slt i64 %20, %23, !dbg !172
  br label %25

25:                                               ; preds = %19, %13
  %26 = phi i1 [ false, %13 ], [ %24, %19 ], !dbg !173
  br i1 %26, label %27, label %54, !dbg !174

27:                                               ; preds = %25
  %28 = load %struct._str*, %struct._str** %4, align 8, !dbg !175
  %29 = getelementptr inbounds %struct._str, %struct._str* %28, i32 0, i32 0, !dbg !177
  %30 = load i8*, i8** %29, align 8, !dbg !177
  %31 = load i64, i64* %7, align 8, !dbg !178
  %32 = getelementptr inbounds i8, i8* %30, i64 %31, !dbg !175
  %33 = load i8, i8* %32, align 1, !dbg !175
  %34 = sext i8 %33 to i32, !dbg !175
  %35 = load %struct._str*, %struct._str** %5, align 8, !dbg !179
  %36 = getelementptr inbounds %struct._str, %struct._str* %35, i32 0, i32 0, !dbg !180
  %37 = load i8*, i8** %36, align 8, !dbg !180
  %38 = load i64, i64* %7, align 8, !dbg !181
  %39 = getelementptr inbounds i8, i8* %37, i64 %38, !dbg !179
  %40 = load i8, i8* %39, align 1, !dbg !179
  %41 = sext i8 %40 to i32, !dbg !179
  %42 = sub nsw i32 %34, %41, !dbg !182
  %43 = sext i32 %42 to i64, !dbg !175
  store i64 %43, i64* %6, align 8, !dbg !183
  %44 = icmp ne i64 %43, 0, !dbg !183
  br i1 %44, label %45, label %50, !dbg !184

45:                                               ; preds = %27
  %46 = load i64, i64* %6, align 8, !dbg !185
  %47 = icmp slt i64 %46, 0, !dbg !186
  %48 = zext i1 %47 to i64, !dbg !185
  %49 = select i1 %47, i32 -1, i32 1, !dbg !185
  store i32 %49, i32* %3, align 4, !dbg !187
  br label %75, !dbg !187

50:                                               ; preds = %27
  br label %51, !dbg !188

51:                                               ; preds = %50
  %52 = load i64, i64* %7, align 8, !dbg !189
  %53 = add nsw i64 %52, 1, !dbg !189
  store i64 %53, i64* %7, align 8, !dbg !189
  br label %13, !dbg !190, !llvm.loop !191

54:                                               ; preds = %25
  %55 = load %struct._str*, %struct._str** %4, align 8, !dbg !194
  %56 = getelementptr inbounds %struct._str, %struct._str* %55, i32 0, i32 1, !dbg !195
  %57 = load i64, i64* %56, align 8, !dbg !195
  %58 = load %struct._str*, %struct._str** %5, align 8, !dbg !196
  %59 = getelementptr inbounds %struct._str, %struct._str* %58, i32 0, i32 1, !dbg !197
  %60 = load i64, i64* %59, align 8, !dbg !197
  %61 = icmp slt i64 %57, %60, !dbg !198
  br i1 %61, label %62, label %63, !dbg !194

62:                                               ; preds = %54
  br label %73, !dbg !194

63:                                               ; preds = %54
  %64 = load %struct._str*, %struct._str** %4, align 8, !dbg !199
  %65 = getelementptr inbounds %struct._str, %struct._str* %64, i32 0, i32 1, !dbg !200
  %66 = load i64, i64* %65, align 8, !dbg !200
  %67 = load %struct._str*, %struct._str** %5, align 8, !dbg !201
  %68 = getelementptr inbounds %struct._str, %struct._str* %67, i32 0, i32 1, !dbg !202
  %69 = load i64, i64* %68, align 8, !dbg !202
  %70 = icmp eq i64 %66, %69, !dbg !203
  %71 = zext i1 %70 to i64, !dbg !199
  %72 = select i1 %70, i32 0, i32 1, !dbg !199
  br label %73, !dbg !194

73:                                               ; preds = %63, %62
  %74 = phi i32 [ -1, %62 ], [ %72, %63 ], !dbg !194
  store i32 %74, i32* %3, align 4, !dbg !204
  br label %75, !dbg !204

75:                                               ; preds = %73, %45, %11
  %76 = load i32, i32* %3, align 4, !dbg !205
  ret i32 %76, !dbg !205
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @concat_strs(%struct._str* %0, %struct._str* %1) #0 !dbg !206 {
  %3 = alloca %struct._str*, align 8
  %4 = alloca %struct._str*, align 8
  %5 = alloca %struct._str*, align 8
  store %struct._str* %0, %struct._str** %3, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %3, metadata !209, metadata !DIExpression()), !dbg !210
  store %struct._str* %1, %struct._str** %4, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !211, metadata !DIExpression()), !dbg !212
  call void @llvm.dbg.declare(metadata %struct._str** %5, metadata !213, metadata !DIExpression()), !dbg !214
  %6 = load %struct._str*, %struct._str** %3, align 8, !dbg !215
  %7 = getelementptr inbounds %struct._str, %struct._str* %6, i32 0, i32 1, !dbg !216
  %8 = load i64, i64* %7, align 8, !dbg !216
  %9 = load %struct._str*, %struct._str** %4, align 8, !dbg !217
  %10 = getelementptr inbounds %struct._str, %struct._str* %9, i32 0, i32 1, !dbg !218
  %11 = load i64, i64* %10, align 8, !dbg !218
  %12 = add nsw i64 %8, %11, !dbg !219
  %13 = call %struct._str* @allocate_str(i64 %12), !dbg !220
  store %struct._str* %13, %struct._str** %5, align 8, !dbg !214
  %14 = load %struct._str*, %struct._str** %5, align 8, !dbg !221
  %15 = getelementptr inbounds %struct._str, %struct._str* %14, i32 0, i32 0, !dbg !221
  %16 = load i8*, i8** %15, align 8, !dbg !221
  %17 = load %struct._str*, %struct._str** %3, align 8, !dbg !221
  %18 = getelementptr inbounds %struct._str, %struct._str* %17, i32 0, i32 0, !dbg !221
  %19 = load i8*, i8** %18, align 8, !dbg !221
  %20 = load %struct._str*, %struct._str** %3, align 8, !dbg !221
  %21 = getelementptr inbounds %struct._str, %struct._str* %20, i32 0, i32 1, !dbg !221
  %22 = load i64, i64* %21, align 8, !dbg !221
  %23 = load %struct._str*, %struct._str** %5, align 8, !dbg !221
  %24 = getelementptr inbounds %struct._str, %struct._str* %23, i32 0, i32 0, !dbg !221
  %25 = load i8*, i8** %24, align 8, !dbg !221
  %26 = call i64 @llvm.objectsize.i64.p0i8(i8* %25, i1 false, i1 true, i1 false), !dbg !221
  %27 = call i8* @__memcpy_chk(i8* %16, i8* %19, i64 %22, i64 %26) #4, !dbg !221
  %28 = load %struct._str*, %struct._str** %5, align 8, !dbg !222
  %29 = getelementptr inbounds %struct._str, %struct._str* %28, i32 0, i32 0, !dbg !222
  %30 = load i8*, i8** %29, align 8, !dbg !222
  %31 = load %struct._str*, %struct._str** %3, align 8, !dbg !222
  %32 = getelementptr inbounds %struct._str, %struct._str* %31, i32 0, i32 1, !dbg !222
  %33 = load i64, i64* %32, align 8, !dbg !222
  %34 = getelementptr inbounds i8, i8* %30, i64 %33, !dbg !222
  %35 = load %struct._str*, %struct._str** %4, align 8, !dbg !222
  %36 = getelementptr inbounds %struct._str, %struct._str* %35, i32 0, i32 0, !dbg !222
  %37 = load i8*, i8** %36, align 8, !dbg !222
  %38 = load %struct._str*, %struct._str** %4, align 8, !dbg !222
  %39 = getelementptr inbounds %struct._str, %struct._str* %38, i32 0, i32 1, !dbg !222
  %40 = load i64, i64* %39, align 8, !dbg !222
  %41 = load %struct._str*, %struct._str** %5, align 8, !dbg !222
  %42 = getelementptr inbounds %struct._str, %struct._str* %41, i32 0, i32 0, !dbg !222
  %43 = load i8*, i8** %42, align 8, !dbg !222
  %44 = load %struct._str*, %struct._str** %3, align 8, !dbg !222
  %45 = getelementptr inbounds %struct._str, %struct._str* %44, i32 0, i32 1, !dbg !222
  %46 = load i64, i64* %45, align 8, !dbg !222
  %47 = getelementptr inbounds i8, i8* %43, i64 %46, !dbg !222
  %48 = call i64 @llvm.objectsize.i64.p0i8(i8* %47, i1 false, i1 true, i1 false), !dbg !222
  %49 = call i8* @__memcpy_chk(i8* %34, i8* %37, i64 %40, i64 %48) #4, !dbg !222
  %50 = load %struct._str*, %struct._str** %5, align 8, !dbg !223
  ret %struct._str* %50, !dbg !224
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @repeat_str(%struct._str* %0, i64 %1) #0 !dbg !225 {
  %3 = alloca %struct._str*, align 8
  %4 = alloca %struct._str*, align 8
  %5 = alloca i64, align 8
  %6 = alloca %struct._str*, align 8
  %7 = alloca i8*, align 8
  store %struct._str* %0, %struct._str** %4, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !228, metadata !DIExpression()), !dbg !229
  store i64 %1, i64* %5, align 8
  call void @llvm.dbg.declare(metadata i64* %5, metadata !230, metadata !DIExpression()), !dbg !231
  %8 = load i64, i64* %5, align 8, !dbg !232
  %9 = icmp sle i64 %8, 0, !dbg !234
  br i1 %9, label %10, label %11, !dbg !235

10:                                               ; preds = %2
  store %struct._str* null, %struct._str** %3, align 8, !dbg !236
  br label %44, !dbg !236

11:                                               ; preds = %2
  call void @llvm.dbg.declare(metadata %struct._str** %6, metadata !237, metadata !DIExpression()), !dbg !238
  %12 = load %struct._str*, %struct._str** %4, align 8, !dbg !239
  %13 = getelementptr inbounds %struct._str, %struct._str* %12, i32 0, i32 1, !dbg !240
  %14 = load i64, i64* %13, align 8, !dbg !240
  %15 = load i64, i64* %5, align 8, !dbg !241
  %16 = mul nsw i64 %14, %15, !dbg !242
  %17 = call %struct._str* @allocate_str(i64 %16), !dbg !243
  store %struct._str* %17, %struct._str** %6, align 8, !dbg !238
  call void @llvm.dbg.declare(metadata i8** %7, metadata !244, metadata !DIExpression()), !dbg !246
  %18 = load %struct._str*, %struct._str** %6, align 8, !dbg !247
  %19 = getelementptr inbounds %struct._str, %struct._str* %18, i32 0, i32 0, !dbg !248
  %20 = load i8*, i8** %19, align 8, !dbg !248
  store i8* %20, i8** %7, align 8, !dbg !246
  br label %21, !dbg !249

21:                                               ; preds = %36, %11
  %22 = load i64, i64* %5, align 8, !dbg !250
  %23 = add nsw i64 %22, -1, !dbg !250
  store i64 %23, i64* %5, align 8, !dbg !250
  %24 = icmp ne i64 %22, 0, !dbg !252
  br i1 %24, label %25, label %42, !dbg !252

25:                                               ; preds = %21
  %26 = load i8*, i8** %7, align 8, !dbg !253
  %27 = load %struct._str*, %struct._str** %4, align 8, !dbg !253
  %28 = getelementptr inbounds %struct._str, %struct._str* %27, i32 0, i32 0, !dbg !253
  %29 = load i8*, i8** %28, align 8, !dbg !253
  %30 = load %struct._str*, %struct._str** %4, align 8, !dbg !253
  %31 = getelementptr inbounds %struct._str, %struct._str* %30, i32 0, i32 1, !dbg !253
  %32 = load i64, i64* %31, align 8, !dbg !253
  %33 = load i8*, i8** %7, align 8, !dbg !253
  %34 = call i64 @llvm.objectsize.i64.p0i8(i8* %33, i1 false, i1 true, i1 false), !dbg !253
  %35 = call i8* @__memcpy_chk(i8* %26, i8* %29, i64 %32, i64 %34) #4, !dbg !253
  br label %36, !dbg !253

36:                                               ; preds = %25
  %37 = load %struct._str*, %struct._str** %4, align 8, !dbg !254
  %38 = getelementptr inbounds %struct._str, %struct._str* %37, i32 0, i32 1, !dbg !255
  %39 = load i64, i64* %38, align 8, !dbg !255
  %40 = load i8*, i8** %7, align 8, !dbg !256
  %41 = getelementptr inbounds i8, i8* %40, i64 %39, !dbg !256
  store i8* %41, i8** %7, align 8, !dbg !256
  br label %21, !dbg !257, !llvm.loop !258

42:                                               ; preds = %21
  %43 = load %struct._str*, %struct._str** %6, align 8, !dbg !260
  store %struct._str* %43, %struct._str** %3, align 8, !dbg !261
  br label %44, !dbg !261

44:                                               ; preds = %42, %10
  %45 = load %struct._str*, %struct._str** %3, align 8, !dbg !262
  ret %struct._str* %45, !dbg !262
}

attributes #0 = { noinline nounwind optnone ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.dbg.cu = !{!9}
!llvm.ident = !{!14}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 12, i32 0]}
!1 = !{i32 7, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"branch-target-enforcement", i32 0}
!5 = !{i32 1, !"sign-return-address", i32 0}
!6 = !{i32 1, !"sign-return-address-all", i32 0}
!7 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!8 = !{i32 7, !"PIC Level", i32 2}
!9 = distinct !DICompileUnit(language: DW_LANG_C99, file: !10, producer: "Apple clang version 13.0.0 (clang-1300.0.29.3)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !11, retainedTypes: !12, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk", sdk: "MacOSX.sdk")
!10 = !DIFile(filename: "str.c", directory: "/Users/sampersand/code/lance/include")
!11 = !{}
!12 = !{!13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{!"Apple clang version 13.0.0 (clang-1300.0.29.3)"}
!15 = distinct !DISubprogram(name: "allocate_str", scope: !10, file: !10, line: 6, type: !16, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!16 = !DISubroutineType(types: !17)
!17 = !{!18, !27}
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "str", file: !20, line: 8, baseType: !21)
!20 = !DIFile(filename: "./str.h", directory: "/Users/sampersand/code/lance/include")
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_str", file: !20, line: 5, size: 128, elements: !22)
!22 = !{!23, !26}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !21, file: !20, line: 6, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !21, file: !20, line: 7, baseType: !27, size: 64, offset: 64)
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "ll", file: !28, line: 5, baseType: !29)
!28 = !DIFile(filename: "./shared.h", directory: "/Users/sampersand/code/lance/include")
!29 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!30 = !DILocalVariable(name: "length", arg: 1, scope: !15, file: !10, line: 6, type: !27)
!31 = !DILocation(line: 6, column: 22, scope: !15)
!32 = !DILocalVariable(name: "s", scope: !15, file: !10, line: 7, type: !18)
!33 = !DILocation(line: 7, column: 7, scope: !15)
!34 = !DILocation(line: 7, column: 11, scope: !15)
!35 = !DILocation(line: 9, column: 19, scope: !15)
!36 = !DILocation(line: 9, column: 11, scope: !15)
!37 = !DILocation(line: 9, column: 2, scope: !15)
!38 = !DILocation(line: 9, column: 5, scope: !15)
!39 = !DILocation(line: 9, column: 9, scope: !15)
!40 = !DILocation(line: 10, column: 11, scope: !15)
!41 = !DILocation(line: 10, column: 2, scope: !15)
!42 = !DILocation(line: 10, column: 5, scope: !15)
!43 = !DILocation(line: 10, column: 9, scope: !15)
!44 = !DILocation(line: 12, column: 9, scope: !15)
!45 = !DILocation(line: 12, column: 2, scope: !15)
!46 = distinct !DISubprogram(name: "create_str_from_borrowed", scope: !10, file: !10, line: 15, type: !47, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!47 = !DISubroutineType(types: !48)
!48 = !{!18, !49}
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!50 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !25)
!51 = !DILocalVariable(name: "c", arg: 1, scope: !46, file: !10, line: 15, type: !49)
!52 = !DILocation(line: 15, column: 43, scope: !46)
!53 = !DILocalVariable(name: "s", scope: !46, file: !10, line: 16, type: !18)
!54 = !DILocation(line: 16, column: 7, scope: !46)
!55 = !DILocation(line: 16, column: 31, scope: !46)
!56 = !DILocation(line: 16, column: 24, scope: !46)
!57 = !DILocation(line: 16, column: 11, scope: !46)
!58 = !DILocation(line: 17, column: 18, scope: !46)
!59 = !DILocation(line: 17, column: 11, scope: !46)
!60 = !DILocation(line: 17, column: 2, scope: !46)
!61 = !DILocation(line: 17, column: 5, scope: !46)
!62 = !DILocation(line: 17, column: 9, scope: !46)
!63 = !DILocation(line: 18, column: 9, scope: !46)
!64 = !DILocation(line: 18, column: 2, scope: !46)
!65 = distinct !DISubprogram(name: "print", scope: !10, file: !10, line: 21, type: !66, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!66 = !DISubroutineType(types: !67)
!67 = !{null, !68}
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !19)
!70 = !DILocalVariable(name: "s", arg: 1, scope: !65, file: !10, line: 21, type: !68)
!71 = !DILocation(line: 21, column: 23, scope: !65)
!72 = !DILocation(line: 22, column: 23, scope: !65)
!73 = !DILocation(line: 22, column: 26, scope: !65)
!74 = !DILocation(line: 22, column: 17, scope: !65)
!75 = !DILocation(line: 22, column: 31, scope: !65)
!76 = !DILocation(line: 22, column: 34, scope: !65)
!77 = !DILocation(line: 22, column: 2, scope: !65)
!78 = !DILocation(line: 23, column: 9, scope: !65)
!79 = !DILocation(line: 23, column: 2, scope: !65)
!80 = !DILocation(line: 24, column: 1, scope: !65)
!81 = distinct !DISubprogram(name: "substr", scope: !10, file: !10, line: 26, type: !82, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!82 = !DISubroutineType(types: !83)
!83 = !{!18, !68, !27, !27}
!84 = !DILocalVariable(name: "s", arg: 1, scope: !81, file: !10, line: 26, type: !68)
!85 = !DILocation(line: 26, column: 24, scope: !81)
!86 = !DILocalVariable(name: "start", arg: 2, scope: !81, file: !10, line: 26, type: !27)
!87 = !DILocation(line: 26, column: 30, scope: !81)
!88 = !DILocalVariable(name: "len", arg: 3, scope: !81, file: !10, line: 26, type: !27)
!89 = !DILocation(line: 26, column: 40, scope: !81)
!90 = !DILocalVariable(name: "sub", scope: !81, file: !10, line: 27, type: !18)
!91 = !DILocation(line: 27, column: 7, scope: !81)
!92 = !DILocation(line: 27, column: 26, scope: !81)
!93 = !DILocation(line: 27, column: 13, scope: !81)
!94 = !DILocation(line: 28, column: 2, scope: !81)
!95 = !DILocation(line: 29, column: 9, scope: !81)
!96 = !DILocation(line: 29, column: 2, scope: !81)
!97 = distinct !DISubprogram(name: "num_to_str", scope: !10, file: !10, line: 32, type: !16, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!98 = !DILocalVariable(name: "num", arg: 1, scope: !97, file: !10, line: 32, type: !27)
!99 = !DILocation(line: 32, column: 20, scope: !97)
!100 = !DILocalVariable(name: "s", scope: !97, file: !10, line: 33, type: !18)
!101 = !DILocation(line: 33, column: 7, scope: !97)
!102 = !DILocation(line: 33, column: 11, scope: !97)
!103 = !DILocation(line: 35, column: 2, scope: !97)
!104 = !DILocation(line: 36, column: 18, scope: !97)
!105 = !DILocation(line: 36, column: 21, scope: !97)
!106 = !DILocation(line: 36, column: 11, scope: !97)
!107 = !DILocation(line: 36, column: 2, scope: !97)
!108 = !DILocation(line: 36, column: 5, scope: !97)
!109 = !DILocation(line: 36, column: 9, scope: !97)
!110 = !DILocation(line: 38, column: 9, scope: !97)
!111 = !DILocation(line: 38, column: 2, scope: !97)
!112 = distinct !DISubprogram(name: "str_to_num", scope: !10, file: !10, line: 41, type: !113, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!113 = !DISubroutineType(types: !114)
!114 = !{!27, !68}
!115 = !DILocalVariable(name: "s", arg: 1, scope: !112, file: !10, line: 41, type: !68)
!116 = !DILocation(line: 41, column: 26, scope: !112)
!117 = !DILocalVariable(name: "tmp", scope: !112, file: !10, line: 43, type: !118)
!118 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 8192, elements: !119)
!119 = !{!120}
!120 = !DISubrange(count: 1024)
!121 = !DILocation(line: 43, column: 7, scope: !112)
!122 = !DILocation(line: 44, column: 2, scope: !112)
!123 = !DILocation(line: 45, column: 17, scope: !112)
!124 = !DILocation(line: 45, column: 9, scope: !112)
!125 = !DILocation(line: 45, column: 2, scope: !112)
!126 = distinct !DISubprogram(name: "str_to_ascii", scope: !10, file: !10, line: 48, type: !113, scopeLine: 48, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!127 = !DILocalVariable(name: "s", arg: 1, scope: !126, file: !10, line: 48, type: !68)
!128 = !DILocation(line: 48, column: 28, scope: !126)
!129 = !DILocation(line: 49, column: 9, scope: !126)
!130 = !DILocation(line: 49, column: 12, scope: !126)
!131 = !DILocation(line: 49, column: 2, scope: !126)
!132 = distinct !DISubprogram(name: "ascii_to_str", scope: !10, file: !10, line: 52, type: !16, scopeLine: 52, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!133 = !DILocalVariable(name: "ascii", arg: 1, scope: !132, file: !10, line: 52, type: !27)
!134 = !DILocation(line: 52, column: 22, scope: !132)
!135 = !DILocalVariable(name: "s", scope: !132, file: !10, line: 53, type: !18)
!136 = !DILocation(line: 53, column: 7, scope: !132)
!137 = !DILocation(line: 53, column: 11, scope: !132)
!138 = !DILocation(line: 55, column: 14, scope: !132)
!139 = !DILocation(line: 55, column: 2, scope: !132)
!140 = !DILocation(line: 55, column: 5, scope: !132)
!141 = !DILocation(line: 55, column: 12, scope: !132)
!142 = !DILocation(line: 57, column: 9, scope: !132)
!143 = !DILocation(line: 57, column: 2, scope: !132)
!144 = distinct !DISubprogram(name: "compare_strs", scope: !10, file: !10, line: 60, type: !145, scopeLine: 60, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!145 = !DISubroutineType(types: !146)
!146 = !{!13, !68, !68}
!147 = !DILocalVariable(name: "lhs", arg: 1, scope: !144, file: !10, line: 60, type: !68)
!148 = !DILocation(line: 60, column: 29, scope: !144)
!149 = !DILocalVariable(name: "rhs", arg: 2, scope: !144, file: !10, line: 60, type: !68)
!150 = !DILocation(line: 60, column: 45, scope: !144)
!151 = !DILocation(line: 61, column: 6, scope: !152)
!152 = distinct !DILexicalBlock(scope: !144, file: !10, line: 61, column: 6)
!153 = !DILocation(line: 61, column: 13, scope: !152)
!154 = !DILocation(line: 61, column: 10, scope: !152)
!155 = !DILocation(line: 61, column: 6, scope: !144)
!156 = !DILocation(line: 62, column: 3, scope: !152)
!157 = !DILocalVariable(name: "diff", scope: !158, file: !10, line: 65, type: !27)
!158 = distinct !DILexicalBlock(scope: !144, file: !10, line: 65, column: 2)
!159 = !DILocation(line: 65, column: 10, scope: !158)
!160 = !DILocalVariable(name: "i", scope: !158, file: !10, line: 65, type: !27)
!161 = !DILocation(line: 65, column: 16, scope: !158)
!162 = !DILocation(line: 65, column: 7, scope: !158)
!163 = !DILocation(line: 65, column: 23, scope: !164)
!164 = distinct !DILexicalBlock(scope: !158, file: !10, line: 65, column: 2)
!165 = !DILocation(line: 65, column: 27, scope: !164)
!166 = !DILocation(line: 65, column: 32, scope: !164)
!167 = !DILocation(line: 65, column: 25, scope: !164)
!168 = !DILocation(line: 65, column: 36, scope: !164)
!169 = !DILocation(line: 65, column: 39, scope: !164)
!170 = !DILocation(line: 65, column: 43, scope: !164)
!171 = !DILocation(line: 65, column: 48, scope: !164)
!172 = !DILocation(line: 65, column: 41, scope: !164)
!173 = !DILocation(line: 0, scope: !164)
!174 = !DILocation(line: 65, column: 2, scope: !158)
!175 = !DILocation(line: 66, column: 15, scope: !176)
!176 = distinct !DILexicalBlock(scope: !164, file: !10, line: 66, column: 7)
!177 = !DILocation(line: 66, column: 20, scope: !176)
!178 = !DILocation(line: 66, column: 24, scope: !176)
!179 = !DILocation(line: 66, column: 29, scope: !176)
!180 = !DILocation(line: 66, column: 34, scope: !176)
!181 = !DILocation(line: 66, column: 38, scope: !176)
!182 = !DILocation(line: 66, column: 27, scope: !176)
!183 = !DILocation(line: 66, column: 13, scope: !176)
!184 = !DILocation(line: 66, column: 7, scope: !164)
!185 = !DILocation(line: 67, column: 11, scope: !176)
!186 = !DILocation(line: 67, column: 16, scope: !176)
!187 = !DILocation(line: 67, column: 4, scope: !176)
!188 = !DILocation(line: 66, column: 40, scope: !176)
!189 = !DILocation(line: 65, column: 53, scope: !164)
!190 = !DILocation(line: 65, column: 2, scope: !164)
!191 = distinct !{!191, !174, !192, !193}
!192 = !DILocation(line: 67, column: 27, scope: !158)
!193 = !{!"llvm.loop.mustprogress"}
!194 = !DILocation(line: 69, column: 9, scope: !144)
!195 = !DILocation(line: 69, column: 14, scope: !144)
!196 = !DILocation(line: 69, column: 20, scope: !144)
!197 = !DILocation(line: 69, column: 25, scope: !144)
!198 = !DILocation(line: 69, column: 18, scope: !144)
!199 = !DILocation(line: 69, column: 36, scope: !144)
!200 = !DILocation(line: 69, column: 41, scope: !144)
!201 = !DILocation(line: 69, column: 48, scope: !144)
!202 = !DILocation(line: 69, column: 53, scope: !144)
!203 = !DILocation(line: 69, column: 45, scope: !144)
!204 = !DILocation(line: 69, column: 2, scope: !144)
!205 = !DILocation(line: 70, column: 1, scope: !144)
!206 = distinct !DISubprogram(name: "concat_strs", scope: !10, file: !10, line: 72, type: !207, scopeLine: 72, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!207 = !DISubroutineType(types: !208)
!208 = !{!18, !68, !68}
!209 = !DILocalVariable(name: "lhs", arg: 1, scope: !206, file: !10, line: 72, type: !68)
!210 = !DILocation(line: 72, column: 29, scope: !206)
!211 = !DILocalVariable(name: "rhs", arg: 2, scope: !206, file: !10, line: 72, type: !68)
!212 = !DILocation(line: 72, column: 45, scope: !206)
!213 = !DILocalVariable(name: "s", scope: !206, file: !10, line: 73, type: !18)
!214 = !DILocation(line: 73, column: 7, scope: !206)
!215 = !DILocation(line: 73, column: 24, scope: !206)
!216 = !DILocation(line: 73, column: 29, scope: !206)
!217 = !DILocation(line: 73, column: 35, scope: !206)
!218 = !DILocation(line: 73, column: 40, scope: !206)
!219 = !DILocation(line: 73, column: 33, scope: !206)
!220 = !DILocation(line: 73, column: 11, scope: !206)
!221 = !DILocation(line: 75, column: 2, scope: !206)
!222 = !DILocation(line: 76, column: 2, scope: !206)
!223 = !DILocation(line: 78, column: 9, scope: !206)
!224 = !DILocation(line: 78, column: 2, scope: !206)
!225 = distinct !DISubprogram(name: "repeat_str", scope: !10, file: !10, line: 81, type: !226, scopeLine: 81, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!226 = !DISubroutineType(types: !227)
!227 = !{!18, !68, !27}
!228 = !DILocalVariable(name: "src", arg: 1, scope: !225, file: !10, line: 81, type: !68)
!229 = !DILocation(line: 81, column: 28, scope: !225)
!230 = !DILocalVariable(name: "amnt", arg: 2, scope: !225, file: !10, line: 81, type: !27)
!231 = !DILocation(line: 81, column: 36, scope: !225)
!232 = !DILocation(line: 82, column: 6, scope: !233)
!233 = distinct !DILexicalBlock(scope: !225, file: !10, line: 82, column: 6)
!234 = !DILocation(line: 82, column: 11, scope: !233)
!235 = !DILocation(line: 82, column: 6, scope: !225)
!236 = !DILocation(line: 83, column: 3, scope: !233)
!237 = !DILocalVariable(name: "s", scope: !225, file: !10, line: 85, type: !18)
!238 = !DILocation(line: 85, column: 7, scope: !225)
!239 = !DILocation(line: 85, column: 24, scope: !225)
!240 = !DILocation(line: 85, column: 29, scope: !225)
!241 = !DILocation(line: 85, column: 35, scope: !225)
!242 = !DILocation(line: 85, column: 33, scope: !225)
!243 = !DILocation(line: 85, column: 11, scope: !225)
!244 = !DILocalVariable(name: "ptr", scope: !245, file: !10, line: 87, type: !24)
!245 = distinct !DILexicalBlock(scope: !225, file: !10, line: 87, column: 2)
!246 = !DILocation(line: 87, column: 13, scope: !245)
!247 = !DILocation(line: 87, column: 19, scope: !245)
!248 = !DILocation(line: 87, column: 22, scope: !245)
!249 = !DILocation(line: 87, column: 7, scope: !245)
!250 = !DILocation(line: 87, column: 31, scope: !251)
!251 = distinct !DILexicalBlock(scope: !245, file: !10, line: 87, column: 2)
!252 = !DILocation(line: 87, column: 2, scope: !245)
!253 = !DILocation(line: 88, column: 3, scope: !251)
!254 = !DILocation(line: 87, column: 42, scope: !251)
!255 = !DILocation(line: 87, column: 47, scope: !251)
!256 = !DILocation(line: 87, column: 39, scope: !251)
!257 = !DILocation(line: 87, column: 2, scope: !251)
!258 = distinct !{!258, !252, !259, !193}
!259 = !DILocation(line: 88, column: 3, scope: !245)
!260 = !DILocation(line: 90, column: 9, scope: !225)
!261 = !DILocation(line: 90, column: 2, scope: !225)
!262 = !DILocation(line: 91, column: 1, scope: !225)
