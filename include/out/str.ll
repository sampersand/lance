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
@.str.1 = private unnamed_addr constant [6 x i8] c"%.*s\0A\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"%lld\00", align 1

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
define void @print_str(%struct._str* %0) #0 !dbg !65 {
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
define void @println_str(%struct._str* %0) #0 !dbg !81 {
  %2 = alloca %struct._str*, align 8
  store %struct._str* %0, %struct._str** %2, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %2, metadata !82, metadata !DIExpression()), !dbg !83
  %3 = load %struct._str*, %struct._str** %2, align 8, !dbg !84
  %4 = getelementptr inbounds %struct._str, %struct._str* %3, i32 0, i32 1, !dbg !85
  %5 = load i64, i64* %4, align 8, !dbg !85
  %6 = trunc i64 %5 to i32, !dbg !86
  %7 = load %struct._str*, %struct._str** %2, align 8, !dbg !87
  %8 = getelementptr inbounds %struct._str, %struct._str* %7, i32 0, i32 0, !dbg !88
  %9 = load i8*, i8** %8, align 8, !dbg !88
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %6, i8* %9), !dbg !89
  %11 = load %struct.__sFILE*, %struct.__sFILE** @__stdoutp, align 8, !dbg !90
  %12 = call i32 @fflush(%struct.__sFILE* %11), !dbg !91
  ret void, !dbg !92
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @substr(%struct._str* %0, i64 %1, i64 %2) #0 !dbg !93 {
  %4 = alloca %struct._str*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca %struct._str*, align 8
  store %struct._str* %0, %struct._str** %4, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !96, metadata !DIExpression()), !dbg !97
  store i64 %1, i64* %5, align 8
  call void @llvm.dbg.declare(metadata i64* %5, metadata !98, metadata !DIExpression()), !dbg !99
  store i64 %2, i64* %6, align 8
  call void @llvm.dbg.declare(metadata i64* %6, metadata !100, metadata !DIExpression()), !dbg !101
  call void @llvm.dbg.declare(metadata %struct._str** %7, metadata !102, metadata !DIExpression()), !dbg !103
  %8 = load i64, i64* %6, align 8, !dbg !104
  %9 = call %struct._str* @allocate_str(i64 %8), !dbg !105
  store %struct._str* %9, %struct._str** %7, align 8, !dbg !103
  %10 = load %struct._str*, %struct._str** %7, align 8, !dbg !106
  %11 = getelementptr inbounds %struct._str, %struct._str* %10, i32 0, i32 0, !dbg !106
  %12 = load i8*, i8** %11, align 8, !dbg !106
  %13 = load %struct._str*, %struct._str** %4, align 8, !dbg !106
  %14 = getelementptr inbounds %struct._str, %struct._str* %13, i32 0, i32 0, !dbg !106
  %15 = load i8*, i8** %14, align 8, !dbg !106
  %16 = load i64, i64* %5, align 8, !dbg !106
  %17 = getelementptr inbounds i8, i8* %15, i64 %16, !dbg !106
  %18 = load i64, i64* %6, align 8, !dbg !106
  %19 = load %struct._str*, %struct._str** %7, align 8, !dbg !106
  %20 = getelementptr inbounds %struct._str, %struct._str* %19, i32 0, i32 0, !dbg !106
  %21 = load i8*, i8** %20, align 8, !dbg !106
  %22 = call i64 @llvm.objectsize.i64.p0i8(i8* %21, i1 false, i1 true, i1 false), !dbg !106
  %23 = call i8* @__memcpy_chk(i8* %12, i8* %17, i64 %18, i64 %22) #4, !dbg !106
  %24 = load %struct._str*, %struct._str** %7, align 8, !dbg !107
  ret %struct._str* %24, !dbg !108
}

; Function Attrs: nounwind
declare i8* @__memcpy_chk(i8*, i8*, i64, i64) #3

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1 immarg, i1 immarg, i1 immarg) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @num_to_str(i64 %0) #0 !dbg !109 {
  %2 = alloca i64, align 8
  %3 = alloca %struct._str*, align 8
  store i64 %0, i64* %2, align 8
  call void @llvm.dbg.declare(metadata i64* %2, metadata !110, metadata !DIExpression()), !dbg !111
  call void @llvm.dbg.declare(metadata %struct._str** %3, metadata !112, metadata !DIExpression()), !dbg !113
  %4 = call %struct._str* @allocate_str(i64 42), !dbg !114
  store %struct._str* %4, %struct._str** %3, align 8, !dbg !113
  %5 = load %struct._str*, %struct._str** %3, align 8, !dbg !115
  %6 = getelementptr inbounds %struct._str, %struct._str* %5, i32 0, i32 0, !dbg !115
  %7 = load i8*, i8** %6, align 8, !dbg !115
  %8 = load %struct._str*, %struct._str** %3, align 8, !dbg !115
  %9 = getelementptr inbounds %struct._str, %struct._str* %8, i32 0, i32 0, !dbg !115
  %10 = load i8*, i8** %9, align 8, !dbg !115
  %11 = call i64 @llvm.objectsize.i64.p0i8(i8* %10, i1 false, i1 true, i1 false), !dbg !115
  %12 = load i64, i64* %2, align 8, !dbg !115
  %13 = call i32 (i8*, i32, i64, i8*, ...) @__sprintf_chk(i8* %7, i32 0, i64 %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i64 0, i64 0), i64 %12), !dbg !115
  %14 = load %struct._str*, %struct._str** %3, align 8, !dbg !116
  %15 = getelementptr inbounds %struct._str, %struct._str* %14, i32 0, i32 0, !dbg !117
  %16 = load i8*, i8** %15, align 8, !dbg !117
  %17 = call i64 @strlen(i8* %16), !dbg !118
  %18 = load %struct._str*, %struct._str** %3, align 8, !dbg !119
  %19 = getelementptr inbounds %struct._str, %struct._str* %18, i32 0, i32 1, !dbg !120
  store i64 %17, i64* %19, align 8, !dbg !121
  %20 = load %struct._str*, %struct._str** %3, align 8, !dbg !122
  ret %struct._str* %20, !dbg !123
}

declare i32 @__sprintf_chk(i8*, i32, i64, i8*, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @str_to_num(%struct._str* %0) #0 !dbg !124 {
  %2 = alloca %struct._str*, align 8
  %3 = alloca [1024 x i8], align 1
  store %struct._str* %0, %struct._str** %2, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %2, metadata !127, metadata !DIExpression()), !dbg !128
  call void @llvm.dbg.declare(metadata [1024 x i8]* %3, metadata !129, metadata !DIExpression()), !dbg !133
  %4 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0, !dbg !134
  %5 = load %struct._str*, %struct._str** %2, align 8, !dbg !134
  %6 = getelementptr inbounds %struct._str, %struct._str* %5, i32 0, i32 0, !dbg !134
  %7 = load i8*, i8** %6, align 8, !dbg !134
  %8 = call i8* @__strncpy_chk(i8* %4, i8* %7, i64 1023, i64 1024) #4, !dbg !134
  %9 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0, !dbg !135
  %10 = call i64 @strtoll(i8* %9, i8** null, i32 10), !dbg !136
  ret i64 %10, !dbg !137
}

; Function Attrs: nounwind
declare i8* @__strncpy_chk(i8*, i8*, i64, i64) #3

declare i64 @strtoll(i8*, i8**, i32) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @str_to_ascii(%struct._str* %0) #0 !dbg !138 {
  %2 = alloca %struct._str*, align 8
  store %struct._str* %0, %struct._str** %2, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %2, metadata !139, metadata !DIExpression()), !dbg !140
  %3 = load %struct._str*, %struct._str** %2, align 8, !dbg !141
  %4 = getelementptr inbounds %struct._str, %struct._str* %3, i32 0, i32 0, !dbg !142
  %5 = load i8*, i8** %4, align 8, !dbg !142
  %6 = getelementptr inbounds i8, i8* %5, i64 0, !dbg !141
  %7 = load i8, i8* %6, align 1, !dbg !141
  %8 = sext i8 %7 to i64, !dbg !141
  ret i64 %8, !dbg !143
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @ascii_to_str(i64 %0) #0 !dbg !144 {
  %2 = alloca i64, align 8
  %3 = alloca %struct._str*, align 8
  store i64 %0, i64* %2, align 8
  call void @llvm.dbg.declare(metadata i64* %2, metadata !145, metadata !DIExpression()), !dbg !146
  call void @llvm.dbg.declare(metadata %struct._str** %3, metadata !147, metadata !DIExpression()), !dbg !148
  %4 = call %struct._str* @allocate_str(i64 1), !dbg !149
  store %struct._str* %4, %struct._str** %3, align 8, !dbg !148
  %5 = load i64, i64* %2, align 8, !dbg !150
  %6 = trunc i64 %5 to i8, !dbg !150
  %7 = load %struct._str*, %struct._str** %3, align 8, !dbg !151
  %8 = getelementptr inbounds %struct._str, %struct._str* %7, i32 0, i32 0, !dbg !152
  %9 = load i8*, i8** %8, align 8, !dbg !152
  %10 = getelementptr inbounds i8, i8* %9, i64 0, !dbg !151
  store i8 %6, i8* %10, align 1, !dbg !153
  %11 = load %struct._str*, %struct._str** %3, align 8, !dbg !154
  ret %struct._str* %11, !dbg !155
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @compare_strs(%struct._str* %0, %struct._str* %1) #0 !dbg !156 {
  %3 = alloca i32, align 4
  %4 = alloca %struct._str*, align 8
  %5 = alloca %struct._str*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store %struct._str* %0, %struct._str** %4, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !159, metadata !DIExpression()), !dbg !160
  store %struct._str* %1, %struct._str** %5, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %5, metadata !161, metadata !DIExpression()), !dbg !162
  %8 = load %struct._str*, %struct._str** %4, align 8, !dbg !163
  %9 = load %struct._str*, %struct._str** %5, align 8, !dbg !165
  %10 = icmp eq %struct._str* %8, %9, !dbg !166
  br i1 %10, label %11, label %12, !dbg !167

11:                                               ; preds = %2
  store i32 0, i32* %3, align 4, !dbg !168
  br label %75, !dbg !168

12:                                               ; preds = %2
  call void @llvm.dbg.declare(metadata i64* %6, metadata !169, metadata !DIExpression()), !dbg !171
  call void @llvm.dbg.declare(metadata i64* %7, metadata !172, metadata !DIExpression()), !dbg !173
  store i64 0, i64* %7, align 8, !dbg !173
  br label %13, !dbg !174

13:                                               ; preds = %51, %12
  %14 = load i64, i64* %7, align 8, !dbg !175
  %15 = load %struct._str*, %struct._str** %4, align 8, !dbg !177
  %16 = getelementptr inbounds %struct._str, %struct._str* %15, i32 0, i32 1, !dbg !178
  %17 = load i64, i64* %16, align 8, !dbg !178
  %18 = icmp slt i64 %14, %17, !dbg !179
  br i1 %18, label %19, label %25, !dbg !180

19:                                               ; preds = %13
  %20 = load i64, i64* %7, align 8, !dbg !181
  %21 = load %struct._str*, %struct._str** %5, align 8, !dbg !182
  %22 = getelementptr inbounds %struct._str, %struct._str* %21, i32 0, i32 1, !dbg !183
  %23 = load i64, i64* %22, align 8, !dbg !183
  %24 = icmp slt i64 %20, %23, !dbg !184
  br label %25

25:                                               ; preds = %19, %13
  %26 = phi i1 [ false, %13 ], [ %24, %19 ], !dbg !185
  br i1 %26, label %27, label %54, !dbg !186

27:                                               ; preds = %25
  %28 = load %struct._str*, %struct._str** %4, align 8, !dbg !187
  %29 = getelementptr inbounds %struct._str, %struct._str* %28, i32 0, i32 0, !dbg !189
  %30 = load i8*, i8** %29, align 8, !dbg !189
  %31 = load i64, i64* %7, align 8, !dbg !190
  %32 = getelementptr inbounds i8, i8* %30, i64 %31, !dbg !187
  %33 = load i8, i8* %32, align 1, !dbg !187
  %34 = sext i8 %33 to i32, !dbg !187
  %35 = load %struct._str*, %struct._str** %5, align 8, !dbg !191
  %36 = getelementptr inbounds %struct._str, %struct._str* %35, i32 0, i32 0, !dbg !192
  %37 = load i8*, i8** %36, align 8, !dbg !192
  %38 = load i64, i64* %7, align 8, !dbg !193
  %39 = getelementptr inbounds i8, i8* %37, i64 %38, !dbg !191
  %40 = load i8, i8* %39, align 1, !dbg !191
  %41 = sext i8 %40 to i32, !dbg !191
  %42 = sub nsw i32 %34, %41, !dbg !194
  %43 = sext i32 %42 to i64, !dbg !187
  store i64 %43, i64* %6, align 8, !dbg !195
  %44 = icmp ne i64 %43, 0, !dbg !195
  br i1 %44, label %45, label %50, !dbg !196

45:                                               ; preds = %27
  %46 = load i64, i64* %6, align 8, !dbg !197
  %47 = icmp slt i64 %46, 0, !dbg !198
  %48 = zext i1 %47 to i64, !dbg !197
  %49 = select i1 %47, i32 -1, i32 1, !dbg !197
  store i32 %49, i32* %3, align 4, !dbg !199
  br label %75, !dbg !199

50:                                               ; preds = %27
  br label %51, !dbg !200

51:                                               ; preds = %50
  %52 = load i64, i64* %7, align 8, !dbg !201
  %53 = add nsw i64 %52, 1, !dbg !201
  store i64 %53, i64* %7, align 8, !dbg !201
  br label %13, !dbg !202, !llvm.loop !203

54:                                               ; preds = %25
  %55 = load %struct._str*, %struct._str** %4, align 8, !dbg !206
  %56 = getelementptr inbounds %struct._str, %struct._str* %55, i32 0, i32 1, !dbg !207
  %57 = load i64, i64* %56, align 8, !dbg !207
  %58 = load %struct._str*, %struct._str** %5, align 8, !dbg !208
  %59 = getelementptr inbounds %struct._str, %struct._str* %58, i32 0, i32 1, !dbg !209
  %60 = load i64, i64* %59, align 8, !dbg !209
  %61 = icmp slt i64 %57, %60, !dbg !210
  br i1 %61, label %62, label %63, !dbg !206

62:                                               ; preds = %54
  br label %73, !dbg !206

63:                                               ; preds = %54
  %64 = load %struct._str*, %struct._str** %4, align 8, !dbg !211
  %65 = getelementptr inbounds %struct._str, %struct._str* %64, i32 0, i32 1, !dbg !212
  %66 = load i64, i64* %65, align 8, !dbg !212
  %67 = load %struct._str*, %struct._str** %5, align 8, !dbg !213
  %68 = getelementptr inbounds %struct._str, %struct._str* %67, i32 0, i32 1, !dbg !214
  %69 = load i64, i64* %68, align 8, !dbg !214
  %70 = icmp eq i64 %66, %69, !dbg !215
  %71 = zext i1 %70 to i64, !dbg !211
  %72 = select i1 %70, i32 0, i32 1, !dbg !211
  br label %73, !dbg !206

73:                                               ; preds = %63, %62
  %74 = phi i32 [ -1, %62 ], [ %72, %63 ], !dbg !206
  store i32 %74, i32* %3, align 4, !dbg !216
  br label %75, !dbg !216

75:                                               ; preds = %73, %45, %11
  %76 = load i32, i32* %3, align 4, !dbg !217
  ret i32 %76, !dbg !217
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @concat_strs(%struct._str* %0, %struct._str* %1) #0 !dbg !218 {
  %3 = alloca %struct._str*, align 8
  %4 = alloca %struct._str*, align 8
  %5 = alloca %struct._str*, align 8
  store %struct._str* %0, %struct._str** %3, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %3, metadata !221, metadata !DIExpression()), !dbg !222
  store %struct._str* %1, %struct._str** %4, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !223, metadata !DIExpression()), !dbg !224
  call void @llvm.dbg.declare(metadata %struct._str** %5, metadata !225, metadata !DIExpression()), !dbg !226
  %6 = load %struct._str*, %struct._str** %3, align 8, !dbg !227
  %7 = getelementptr inbounds %struct._str, %struct._str* %6, i32 0, i32 1, !dbg !228
  %8 = load i64, i64* %7, align 8, !dbg !228
  %9 = load %struct._str*, %struct._str** %4, align 8, !dbg !229
  %10 = getelementptr inbounds %struct._str, %struct._str* %9, i32 0, i32 1, !dbg !230
  %11 = load i64, i64* %10, align 8, !dbg !230
  %12 = add nsw i64 %8, %11, !dbg !231
  %13 = call %struct._str* @allocate_str(i64 %12), !dbg !232
  store %struct._str* %13, %struct._str** %5, align 8, !dbg !226
  %14 = load %struct._str*, %struct._str** %5, align 8, !dbg !233
  %15 = getelementptr inbounds %struct._str, %struct._str* %14, i32 0, i32 0, !dbg !233
  %16 = load i8*, i8** %15, align 8, !dbg !233
  %17 = load %struct._str*, %struct._str** %3, align 8, !dbg !233
  %18 = getelementptr inbounds %struct._str, %struct._str* %17, i32 0, i32 0, !dbg !233
  %19 = load i8*, i8** %18, align 8, !dbg !233
  %20 = load %struct._str*, %struct._str** %3, align 8, !dbg !233
  %21 = getelementptr inbounds %struct._str, %struct._str* %20, i32 0, i32 1, !dbg !233
  %22 = load i64, i64* %21, align 8, !dbg !233
  %23 = load %struct._str*, %struct._str** %5, align 8, !dbg !233
  %24 = getelementptr inbounds %struct._str, %struct._str* %23, i32 0, i32 0, !dbg !233
  %25 = load i8*, i8** %24, align 8, !dbg !233
  %26 = call i64 @llvm.objectsize.i64.p0i8(i8* %25, i1 false, i1 true, i1 false), !dbg !233
  %27 = call i8* @__memcpy_chk(i8* %16, i8* %19, i64 %22, i64 %26) #4, !dbg !233
  %28 = load %struct._str*, %struct._str** %5, align 8, !dbg !234
  %29 = getelementptr inbounds %struct._str, %struct._str* %28, i32 0, i32 0, !dbg !234
  %30 = load i8*, i8** %29, align 8, !dbg !234
  %31 = load %struct._str*, %struct._str** %3, align 8, !dbg !234
  %32 = getelementptr inbounds %struct._str, %struct._str* %31, i32 0, i32 1, !dbg !234
  %33 = load i64, i64* %32, align 8, !dbg !234
  %34 = getelementptr inbounds i8, i8* %30, i64 %33, !dbg !234
  %35 = load %struct._str*, %struct._str** %4, align 8, !dbg !234
  %36 = getelementptr inbounds %struct._str, %struct._str* %35, i32 0, i32 0, !dbg !234
  %37 = load i8*, i8** %36, align 8, !dbg !234
  %38 = load %struct._str*, %struct._str** %4, align 8, !dbg !234
  %39 = getelementptr inbounds %struct._str, %struct._str* %38, i32 0, i32 1, !dbg !234
  %40 = load i64, i64* %39, align 8, !dbg !234
  %41 = load %struct._str*, %struct._str** %5, align 8, !dbg !234
  %42 = getelementptr inbounds %struct._str, %struct._str* %41, i32 0, i32 0, !dbg !234
  %43 = load i8*, i8** %42, align 8, !dbg !234
  %44 = load %struct._str*, %struct._str** %3, align 8, !dbg !234
  %45 = getelementptr inbounds %struct._str, %struct._str* %44, i32 0, i32 1, !dbg !234
  %46 = load i64, i64* %45, align 8, !dbg !234
  %47 = getelementptr inbounds i8, i8* %43, i64 %46, !dbg !234
  %48 = call i64 @llvm.objectsize.i64.p0i8(i8* %47, i1 false, i1 true, i1 false), !dbg !234
  %49 = call i8* @__memcpy_chk(i8* %34, i8* %37, i64 %40, i64 %48) #4, !dbg !234
  %50 = load %struct._str*, %struct._str** %5, align 8, !dbg !235
  ret %struct._str* %50, !dbg !236
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @repeat_str(%struct._str* %0, i64 %1) #0 !dbg !237 {
  %3 = alloca %struct._str*, align 8
  %4 = alloca %struct._str*, align 8
  %5 = alloca i64, align 8
  %6 = alloca %struct._str*, align 8
  %7 = alloca i8*, align 8
  store %struct._str* %0, %struct._str** %4, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !240, metadata !DIExpression()), !dbg !241
  store i64 %1, i64* %5, align 8
  call void @llvm.dbg.declare(metadata i64* %5, metadata !242, metadata !DIExpression()), !dbg !243
  %8 = load i64, i64* %5, align 8, !dbg !244
  %9 = icmp sle i64 %8, 0, !dbg !246
  br i1 %9, label %10, label %11, !dbg !247

10:                                               ; preds = %2
  store %struct._str* null, %struct._str** %3, align 8, !dbg !248
  br label %44, !dbg !248

11:                                               ; preds = %2
  call void @llvm.dbg.declare(metadata %struct._str** %6, metadata !249, metadata !DIExpression()), !dbg !250
  %12 = load %struct._str*, %struct._str** %4, align 8, !dbg !251
  %13 = getelementptr inbounds %struct._str, %struct._str* %12, i32 0, i32 1, !dbg !252
  %14 = load i64, i64* %13, align 8, !dbg !252
  %15 = load i64, i64* %5, align 8, !dbg !253
  %16 = mul nsw i64 %14, %15, !dbg !254
  %17 = call %struct._str* @allocate_str(i64 %16), !dbg !255
  store %struct._str* %17, %struct._str** %6, align 8, !dbg !250
  call void @llvm.dbg.declare(metadata i8** %7, metadata !256, metadata !DIExpression()), !dbg !258
  %18 = load %struct._str*, %struct._str** %6, align 8, !dbg !259
  %19 = getelementptr inbounds %struct._str, %struct._str* %18, i32 0, i32 0, !dbg !260
  %20 = load i8*, i8** %19, align 8, !dbg !260
  store i8* %20, i8** %7, align 8, !dbg !258
  br label %21, !dbg !261

21:                                               ; preds = %36, %11
  %22 = load i64, i64* %5, align 8, !dbg !262
  %23 = add nsw i64 %22, -1, !dbg !262
  store i64 %23, i64* %5, align 8, !dbg !262
  %24 = icmp ne i64 %22, 0, !dbg !264
  br i1 %24, label %25, label %42, !dbg !264

25:                                               ; preds = %21
  %26 = load i8*, i8** %7, align 8, !dbg !265
  %27 = load %struct._str*, %struct._str** %4, align 8, !dbg !265
  %28 = getelementptr inbounds %struct._str, %struct._str* %27, i32 0, i32 0, !dbg !265
  %29 = load i8*, i8** %28, align 8, !dbg !265
  %30 = load %struct._str*, %struct._str** %4, align 8, !dbg !265
  %31 = getelementptr inbounds %struct._str, %struct._str* %30, i32 0, i32 1, !dbg !265
  %32 = load i64, i64* %31, align 8, !dbg !265
  %33 = load i8*, i8** %7, align 8, !dbg !265
  %34 = call i64 @llvm.objectsize.i64.p0i8(i8* %33, i1 false, i1 true, i1 false), !dbg !265
  %35 = call i8* @__memcpy_chk(i8* %26, i8* %29, i64 %32, i64 %34) #4, !dbg !265
  br label %36, !dbg !265

36:                                               ; preds = %25
  %37 = load %struct._str*, %struct._str** %4, align 8, !dbg !266
  %38 = getelementptr inbounds %struct._str, %struct._str* %37, i32 0, i32 1, !dbg !267
  %39 = load i64, i64* %38, align 8, !dbg !267
  %40 = load i8*, i8** %7, align 8, !dbg !268
  %41 = getelementptr inbounds i8, i8* %40, i64 %39, !dbg !268
  store i8* %41, i8** %7, align 8, !dbg !268
  br label %21, !dbg !269, !llvm.loop !270

42:                                               ; preds = %21
  %43 = load %struct._str*, %struct._str** %6, align 8, !dbg !272
  store %struct._str* %43, %struct._str** %3, align 8, !dbg !273
  br label %44, !dbg !273

44:                                               ; preds = %42, %10
  %45 = load %struct._str*, %struct._str** %3, align 8, !dbg !274
  ret %struct._str* %45, !dbg !274
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
!65 = distinct !DISubprogram(name: "print_str", scope: !10, file: !10, line: 21, type: !66, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!66 = !DISubroutineType(types: !67)
!67 = !{null, !68}
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !19)
!70 = !DILocalVariable(name: "s", arg: 1, scope: !65, file: !10, line: 21, type: !68)
!71 = !DILocation(line: 21, column: 27, scope: !65)
!72 = !DILocation(line: 22, column: 23, scope: !65)
!73 = !DILocation(line: 22, column: 26, scope: !65)
!74 = !DILocation(line: 22, column: 17, scope: !65)
!75 = !DILocation(line: 22, column: 31, scope: !65)
!76 = !DILocation(line: 22, column: 34, scope: !65)
!77 = !DILocation(line: 22, column: 2, scope: !65)
!78 = !DILocation(line: 23, column: 9, scope: !65)
!79 = !DILocation(line: 23, column: 2, scope: !65)
!80 = !DILocation(line: 24, column: 1, scope: !65)
!81 = distinct !DISubprogram(name: "println_str", scope: !10, file: !10, line: 26, type: !66, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!82 = !DILocalVariable(name: "s", arg: 1, scope: !81, file: !10, line: 26, type: !68)
!83 = !DILocation(line: 26, column: 29, scope: !81)
!84 = !DILocation(line: 27, column: 25, scope: !81)
!85 = !DILocation(line: 27, column: 28, scope: !81)
!86 = !DILocation(line: 27, column: 19, scope: !81)
!87 = !DILocation(line: 27, column: 33, scope: !81)
!88 = !DILocation(line: 27, column: 36, scope: !81)
!89 = !DILocation(line: 27, column: 2, scope: !81)
!90 = !DILocation(line: 28, column: 9, scope: !81)
!91 = !DILocation(line: 28, column: 2, scope: !81)
!92 = !DILocation(line: 29, column: 1, scope: !81)
!93 = distinct !DISubprogram(name: "substr", scope: !10, file: !10, line: 31, type: !94, scopeLine: 31, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!94 = !DISubroutineType(types: !95)
!95 = !{!18, !68, !27, !27}
!96 = !DILocalVariable(name: "s", arg: 1, scope: !93, file: !10, line: 31, type: !68)
!97 = !DILocation(line: 31, column: 24, scope: !93)
!98 = !DILocalVariable(name: "start", arg: 2, scope: !93, file: !10, line: 31, type: !27)
!99 = !DILocation(line: 31, column: 30, scope: !93)
!100 = !DILocalVariable(name: "len", arg: 3, scope: !93, file: !10, line: 31, type: !27)
!101 = !DILocation(line: 31, column: 40, scope: !93)
!102 = !DILocalVariable(name: "sub", scope: !93, file: !10, line: 32, type: !18)
!103 = !DILocation(line: 32, column: 7, scope: !93)
!104 = !DILocation(line: 32, column: 26, scope: !93)
!105 = !DILocation(line: 32, column: 13, scope: !93)
!106 = !DILocation(line: 33, column: 2, scope: !93)
!107 = !DILocation(line: 34, column: 9, scope: !93)
!108 = !DILocation(line: 34, column: 2, scope: !93)
!109 = distinct !DISubprogram(name: "num_to_str", scope: !10, file: !10, line: 37, type: !16, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!110 = !DILocalVariable(name: "num", arg: 1, scope: !109, file: !10, line: 37, type: !27)
!111 = !DILocation(line: 37, column: 20, scope: !109)
!112 = !DILocalVariable(name: "s", scope: !109, file: !10, line: 38, type: !18)
!113 = !DILocation(line: 38, column: 7, scope: !109)
!114 = !DILocation(line: 38, column: 11, scope: !109)
!115 = !DILocation(line: 40, column: 2, scope: !109)
!116 = !DILocation(line: 41, column: 18, scope: !109)
!117 = !DILocation(line: 41, column: 21, scope: !109)
!118 = !DILocation(line: 41, column: 11, scope: !109)
!119 = !DILocation(line: 41, column: 2, scope: !109)
!120 = !DILocation(line: 41, column: 5, scope: !109)
!121 = !DILocation(line: 41, column: 9, scope: !109)
!122 = !DILocation(line: 43, column: 9, scope: !109)
!123 = !DILocation(line: 43, column: 2, scope: !109)
!124 = distinct !DISubprogram(name: "str_to_num", scope: !10, file: !10, line: 46, type: !125, scopeLine: 46, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!125 = !DISubroutineType(types: !126)
!126 = !{!27, !68}
!127 = !DILocalVariable(name: "s", arg: 1, scope: !124, file: !10, line: 46, type: !68)
!128 = !DILocation(line: 46, column: 26, scope: !124)
!129 = !DILocalVariable(name: "tmp", scope: !124, file: !10, line: 48, type: !130)
!130 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 8192, elements: !131)
!131 = !{!132}
!132 = !DISubrange(count: 1024)
!133 = !DILocation(line: 48, column: 7, scope: !124)
!134 = !DILocation(line: 49, column: 2, scope: !124)
!135 = !DILocation(line: 50, column: 17, scope: !124)
!136 = !DILocation(line: 50, column: 9, scope: !124)
!137 = !DILocation(line: 50, column: 2, scope: !124)
!138 = distinct !DISubprogram(name: "str_to_ascii", scope: !10, file: !10, line: 53, type: !125, scopeLine: 53, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!139 = !DILocalVariable(name: "s", arg: 1, scope: !138, file: !10, line: 53, type: !68)
!140 = !DILocation(line: 53, column: 28, scope: !138)
!141 = !DILocation(line: 54, column: 9, scope: !138)
!142 = !DILocation(line: 54, column: 12, scope: !138)
!143 = !DILocation(line: 54, column: 2, scope: !138)
!144 = distinct !DISubprogram(name: "ascii_to_str", scope: !10, file: !10, line: 57, type: !16, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!145 = !DILocalVariable(name: "ascii", arg: 1, scope: !144, file: !10, line: 57, type: !27)
!146 = !DILocation(line: 57, column: 22, scope: !144)
!147 = !DILocalVariable(name: "s", scope: !144, file: !10, line: 58, type: !18)
!148 = !DILocation(line: 58, column: 7, scope: !144)
!149 = !DILocation(line: 58, column: 11, scope: !144)
!150 = !DILocation(line: 60, column: 14, scope: !144)
!151 = !DILocation(line: 60, column: 2, scope: !144)
!152 = !DILocation(line: 60, column: 5, scope: !144)
!153 = !DILocation(line: 60, column: 12, scope: !144)
!154 = !DILocation(line: 62, column: 9, scope: !144)
!155 = !DILocation(line: 62, column: 2, scope: !144)
!156 = distinct !DISubprogram(name: "compare_strs", scope: !10, file: !10, line: 65, type: !157, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!157 = !DISubroutineType(types: !158)
!158 = !{!13, !68, !68}
!159 = !DILocalVariable(name: "lhs", arg: 1, scope: !156, file: !10, line: 65, type: !68)
!160 = !DILocation(line: 65, column: 29, scope: !156)
!161 = !DILocalVariable(name: "rhs", arg: 2, scope: !156, file: !10, line: 65, type: !68)
!162 = !DILocation(line: 65, column: 45, scope: !156)
!163 = !DILocation(line: 66, column: 6, scope: !164)
!164 = distinct !DILexicalBlock(scope: !156, file: !10, line: 66, column: 6)
!165 = !DILocation(line: 66, column: 13, scope: !164)
!166 = !DILocation(line: 66, column: 10, scope: !164)
!167 = !DILocation(line: 66, column: 6, scope: !156)
!168 = !DILocation(line: 67, column: 3, scope: !164)
!169 = !DILocalVariable(name: "diff", scope: !170, file: !10, line: 70, type: !27)
!170 = distinct !DILexicalBlock(scope: !156, file: !10, line: 70, column: 2)
!171 = !DILocation(line: 70, column: 10, scope: !170)
!172 = !DILocalVariable(name: "i", scope: !170, file: !10, line: 70, type: !27)
!173 = !DILocation(line: 70, column: 16, scope: !170)
!174 = !DILocation(line: 70, column: 7, scope: !170)
!175 = !DILocation(line: 70, column: 23, scope: !176)
!176 = distinct !DILexicalBlock(scope: !170, file: !10, line: 70, column: 2)
!177 = !DILocation(line: 70, column: 27, scope: !176)
!178 = !DILocation(line: 70, column: 32, scope: !176)
!179 = !DILocation(line: 70, column: 25, scope: !176)
!180 = !DILocation(line: 70, column: 36, scope: !176)
!181 = !DILocation(line: 70, column: 39, scope: !176)
!182 = !DILocation(line: 70, column: 43, scope: !176)
!183 = !DILocation(line: 70, column: 48, scope: !176)
!184 = !DILocation(line: 70, column: 41, scope: !176)
!185 = !DILocation(line: 0, scope: !176)
!186 = !DILocation(line: 70, column: 2, scope: !170)
!187 = !DILocation(line: 71, column: 15, scope: !188)
!188 = distinct !DILexicalBlock(scope: !176, file: !10, line: 71, column: 7)
!189 = !DILocation(line: 71, column: 20, scope: !188)
!190 = !DILocation(line: 71, column: 24, scope: !188)
!191 = !DILocation(line: 71, column: 29, scope: !188)
!192 = !DILocation(line: 71, column: 34, scope: !188)
!193 = !DILocation(line: 71, column: 38, scope: !188)
!194 = !DILocation(line: 71, column: 27, scope: !188)
!195 = !DILocation(line: 71, column: 13, scope: !188)
!196 = !DILocation(line: 71, column: 7, scope: !176)
!197 = !DILocation(line: 72, column: 11, scope: !188)
!198 = !DILocation(line: 72, column: 16, scope: !188)
!199 = !DILocation(line: 72, column: 4, scope: !188)
!200 = !DILocation(line: 71, column: 40, scope: !188)
!201 = !DILocation(line: 70, column: 53, scope: !176)
!202 = !DILocation(line: 70, column: 2, scope: !176)
!203 = distinct !{!203, !186, !204, !205}
!204 = !DILocation(line: 72, column: 27, scope: !170)
!205 = !{!"llvm.loop.mustprogress"}
!206 = !DILocation(line: 74, column: 9, scope: !156)
!207 = !DILocation(line: 74, column: 14, scope: !156)
!208 = !DILocation(line: 74, column: 20, scope: !156)
!209 = !DILocation(line: 74, column: 25, scope: !156)
!210 = !DILocation(line: 74, column: 18, scope: !156)
!211 = !DILocation(line: 74, column: 36, scope: !156)
!212 = !DILocation(line: 74, column: 41, scope: !156)
!213 = !DILocation(line: 74, column: 48, scope: !156)
!214 = !DILocation(line: 74, column: 53, scope: !156)
!215 = !DILocation(line: 74, column: 45, scope: !156)
!216 = !DILocation(line: 74, column: 2, scope: !156)
!217 = !DILocation(line: 75, column: 1, scope: !156)
!218 = distinct !DISubprogram(name: "concat_strs", scope: !10, file: !10, line: 77, type: !219, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!219 = !DISubroutineType(types: !220)
!220 = !{!18, !68, !68}
!221 = !DILocalVariable(name: "lhs", arg: 1, scope: !218, file: !10, line: 77, type: !68)
!222 = !DILocation(line: 77, column: 29, scope: !218)
!223 = !DILocalVariable(name: "rhs", arg: 2, scope: !218, file: !10, line: 77, type: !68)
!224 = !DILocation(line: 77, column: 45, scope: !218)
!225 = !DILocalVariable(name: "s", scope: !218, file: !10, line: 78, type: !18)
!226 = !DILocation(line: 78, column: 7, scope: !218)
!227 = !DILocation(line: 78, column: 24, scope: !218)
!228 = !DILocation(line: 78, column: 29, scope: !218)
!229 = !DILocation(line: 78, column: 35, scope: !218)
!230 = !DILocation(line: 78, column: 40, scope: !218)
!231 = !DILocation(line: 78, column: 33, scope: !218)
!232 = !DILocation(line: 78, column: 11, scope: !218)
!233 = !DILocation(line: 80, column: 2, scope: !218)
!234 = !DILocation(line: 81, column: 2, scope: !218)
!235 = !DILocation(line: 83, column: 9, scope: !218)
!236 = !DILocation(line: 83, column: 2, scope: !218)
!237 = distinct !DISubprogram(name: "repeat_str", scope: !10, file: !10, line: 86, type: !238, scopeLine: 86, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!238 = !DISubroutineType(types: !239)
!239 = !{!18, !68, !27}
!240 = !DILocalVariable(name: "src", arg: 1, scope: !237, file: !10, line: 86, type: !68)
!241 = !DILocation(line: 86, column: 28, scope: !237)
!242 = !DILocalVariable(name: "amnt", arg: 2, scope: !237, file: !10, line: 86, type: !27)
!243 = !DILocation(line: 86, column: 36, scope: !237)
!244 = !DILocation(line: 87, column: 6, scope: !245)
!245 = distinct !DILexicalBlock(scope: !237, file: !10, line: 87, column: 6)
!246 = !DILocation(line: 87, column: 11, scope: !245)
!247 = !DILocation(line: 87, column: 6, scope: !237)
!248 = !DILocation(line: 88, column: 3, scope: !245)
!249 = !DILocalVariable(name: "s", scope: !237, file: !10, line: 90, type: !18)
!250 = !DILocation(line: 90, column: 7, scope: !237)
!251 = !DILocation(line: 90, column: 24, scope: !237)
!252 = !DILocation(line: 90, column: 29, scope: !237)
!253 = !DILocation(line: 90, column: 35, scope: !237)
!254 = !DILocation(line: 90, column: 33, scope: !237)
!255 = !DILocation(line: 90, column: 11, scope: !237)
!256 = !DILocalVariable(name: "ptr", scope: !257, file: !10, line: 92, type: !24)
!257 = distinct !DILexicalBlock(scope: !237, file: !10, line: 92, column: 2)
!258 = !DILocation(line: 92, column: 13, scope: !257)
!259 = !DILocation(line: 92, column: 19, scope: !257)
!260 = !DILocation(line: 92, column: 22, scope: !257)
!261 = !DILocation(line: 92, column: 7, scope: !257)
!262 = !DILocation(line: 92, column: 31, scope: !263)
!263 = distinct !DILexicalBlock(scope: !257, file: !10, line: 92, column: 2)
!264 = !DILocation(line: 92, column: 2, scope: !257)
!265 = !DILocation(line: 93, column: 3, scope: !263)
!266 = !DILocation(line: 92, column: 42, scope: !263)
!267 = !DILocation(line: 92, column: 47, scope: !263)
!268 = !DILocation(line: 92, column: 39, scope: !263)
!269 = !DILocation(line: 92, column: 2, scope: !263)
!270 = distinct !{!270, !264, !271, !205}
!271 = !DILocation(line: 93, column: 3, scope: !257)
!272 = !DILocation(line: 95, column: 9, scope: !237)
!273 = !DILocation(line: 95, column: 2, scope: !237)
!274 = !DILocation(line: 96, column: 1, scope: !237)
