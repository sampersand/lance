; ModuleID = 'list.c'
source_filename = "list.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

%struct.list = type { i64*, i64, i64 }
%struct._str = type { i8*, i64 }

@.str = private unnamed_addr constant [26 x i8] c"popped from an empty list\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.list* @allocate_list(i64 %0) #0 !dbg !13 {
  %2 = alloca i64, align 8
  %3 = alloca %struct.list*, align 8
  store i64 %0, i64* %2, align 8
  call void @llvm.dbg.declare(metadata i64* %2, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !30, metadata !DIExpression()), !dbg !31
  %4 = call i8* @xmalloc(i64 24), !dbg !32
  %5 = bitcast i8* %4 to %struct.list*, !dbg !32
  store %struct.list* %5, %struct.list** %3, align 8, !dbg !31
  %6 = load i64, i64* %2, align 8, !dbg !33
  %7 = mul i64 8, %6, !dbg !34
  %8 = call i8* @xmalloc(i64 %7), !dbg !35
  %9 = bitcast i8* %8 to i64*, !dbg !35
  %10 = load %struct.list*, %struct.list** %3, align 8, !dbg !36
  %11 = getelementptr inbounds %struct.list, %struct.list* %10, i32 0, i32 0, !dbg !37
  store i64* %9, i64** %11, align 8, !dbg !38
  %12 = load %struct.list*, %struct.list** %3, align 8, !dbg !39
  %13 = getelementptr inbounds %struct.list, %struct.list* %12, i32 0, i32 1, !dbg !40
  store i64 0, i64* %13, align 8, !dbg !41
  %14 = load i64, i64* %2, align 8, !dbg !42
  %15 = load %struct.list*, %struct.list** %3, align 8, !dbg !43
  %16 = getelementptr inbounds %struct.list, %struct.list* %15, i32 0, i32 2, !dbg !44
  store i64 %14, i64* %16, align 8, !dbg !45
  %17 = load %struct.list*, %struct.list** %3, align 8, !dbg !46
  ret %struct.list* %17, !dbg !47
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @xmalloc(i64) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.list* @concat_lists(%struct.list* %0, %struct.list* %1) #0 !dbg !48 {
  %3 = alloca %struct.list*, align 8
  %4 = alloca %struct.list*, align 8
  %5 = alloca %struct.list*, align 8
  store %struct.list* %0, %struct.list** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !53, metadata !DIExpression()), !dbg !54
  store %struct.list* %1, %struct.list** %4, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %4, metadata !55, metadata !DIExpression()), !dbg !56
  call void @llvm.dbg.declare(metadata %struct.list** %5, metadata !57, metadata !DIExpression()), !dbg !58
  %6 = load %struct.list*, %struct.list** %3, align 8, !dbg !59
  %7 = getelementptr inbounds %struct.list, %struct.list* %6, i32 0, i32 1, !dbg !60
  %8 = load i64, i64* %7, align 8, !dbg !60
  %9 = load %struct.list*, %struct.list** %4, align 8, !dbg !61
  %10 = getelementptr inbounds %struct.list, %struct.list* %9, i32 0, i32 1, !dbg !62
  %11 = load i64, i64* %10, align 8, !dbg !62
  %12 = add nsw i64 %8, %11, !dbg !63
  %13 = call %struct.list* @allocate_list(i64 %12), !dbg !64
  store %struct.list* %13, %struct.list** %5, align 8, !dbg !58
  %14 = load %struct.list*, %struct.list** %3, align 8, !dbg !65
  %15 = getelementptr inbounds %struct.list, %struct.list* %14, i32 0, i32 1, !dbg !66
  %16 = load i64, i64* %15, align 8, !dbg !66
  %17 = load %struct.list*, %struct.list** %4, align 8, !dbg !67
  %18 = getelementptr inbounds %struct.list, %struct.list* %17, i32 0, i32 1, !dbg !68
  %19 = load i64, i64* %18, align 8, !dbg !68
  %20 = add nsw i64 %16, %19, !dbg !69
  %21 = load %struct.list*, %struct.list** %5, align 8, !dbg !70
  %22 = getelementptr inbounds %struct.list, %struct.list* %21, i32 0, i32 1, !dbg !71
  store i64 %20, i64* %22, align 8, !dbg !72
  %23 = load %struct.list*, %struct.list** %5, align 8, !dbg !73
  %24 = getelementptr inbounds %struct.list, %struct.list* %23, i32 0, i32 0, !dbg !73
  %25 = load i64*, i64** %24, align 8, !dbg !73
  %26 = bitcast i64* %25 to i8*, !dbg !73
  %27 = load %struct.list*, %struct.list** %3, align 8, !dbg !73
  %28 = getelementptr inbounds %struct.list, %struct.list* %27, i32 0, i32 0, !dbg !73
  %29 = load i64*, i64** %28, align 8, !dbg !73
  %30 = bitcast i64* %29 to i8*, !dbg !73
  %31 = load %struct.list*, %struct.list** %3, align 8, !dbg !73
  %32 = getelementptr inbounds %struct.list, %struct.list* %31, i32 0, i32 1, !dbg !73
  %33 = load i64, i64* %32, align 8, !dbg !73
  %34 = mul i64 %33, 8, !dbg !73
  %35 = load %struct.list*, %struct.list** %5, align 8, !dbg !73
  %36 = getelementptr inbounds %struct.list, %struct.list* %35, i32 0, i32 0, !dbg !73
  %37 = load i64*, i64** %36, align 8, !dbg !73
  %38 = bitcast i64* %37 to i8*, !dbg !73
  %39 = call i64 @llvm.objectsize.i64.p0i8(i8* %38, i1 false, i1 true, i1 false), !dbg !73
  %40 = call i8* @__memcpy_chk(i8* %26, i8* %30, i64 %34, i64 %39) #4, !dbg !73
  %41 = load %struct.list*, %struct.list** %5, align 8, !dbg !74
  %42 = getelementptr inbounds %struct.list, %struct.list* %41, i32 0, i32 0, !dbg !74
  %43 = load i64*, i64** %42, align 8, !dbg !74
  %44 = load %struct.list*, %struct.list** %3, align 8, !dbg !74
  %45 = getelementptr inbounds %struct.list, %struct.list* %44, i32 0, i32 1, !dbg !74
  %46 = load i64, i64* %45, align 8, !dbg !74
  %47 = getelementptr inbounds i64, i64* %43, i64 %46, !dbg !74
  %48 = bitcast i64* %47 to i8*, !dbg !74
  %49 = load %struct.list*, %struct.list** %4, align 8, !dbg !74
  %50 = getelementptr inbounds %struct.list, %struct.list* %49, i32 0, i32 0, !dbg !74
  %51 = load i64*, i64** %50, align 8, !dbg !74
  %52 = bitcast i64* %51 to i8*, !dbg !74
  %53 = load %struct.list*, %struct.list** %4, align 8, !dbg !74
  %54 = getelementptr inbounds %struct.list, %struct.list* %53, i32 0, i32 1, !dbg !74
  %55 = load i64, i64* %54, align 8, !dbg !74
  %56 = mul i64 %55, 8, !dbg !74
  %57 = load %struct.list*, %struct.list** %5, align 8, !dbg !74
  %58 = getelementptr inbounds %struct.list, %struct.list* %57, i32 0, i32 0, !dbg !74
  %59 = load i64*, i64** %58, align 8, !dbg !74
  %60 = load %struct.list*, %struct.list** %3, align 8, !dbg !74
  %61 = getelementptr inbounds %struct.list, %struct.list* %60, i32 0, i32 1, !dbg !74
  %62 = load i64, i64* %61, align 8, !dbg !74
  %63 = getelementptr inbounds i64, i64* %59, i64 %62, !dbg !74
  %64 = bitcast i64* %63 to i8*, !dbg !74
  %65 = call i64 @llvm.objectsize.i64.p0i8(i8* %64, i1 false, i1 true, i1 false), !dbg !74
  %66 = call i8* @__memcpy_chk(i8* %48, i8* %52, i64 %56, i64 %65) #4, !dbg !74
  %67 = load %struct.list*, %struct.list** %5, align 8, !dbg !75
  ret %struct.list* %67, !dbg !76
}

; Function Attrs: nounwind
declare i8* @__memcpy_chk(i8*, i8*, i64, i64) #3

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1 immarg, i1 immarg, i1 immarg) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.list* @repeat_list(%struct.list* %0, i64 %1) #0 !dbg !77 {
  %3 = alloca %struct.list*, align 8
  %4 = alloca i64, align 8
  %5 = alloca %struct.list*, align 8
  %6 = alloca i64*, align 8
  store %struct.list* %0, %struct.list** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !80, metadata !DIExpression()), !dbg !81
  store i64 %1, i64* %4, align 8
  call void @llvm.dbg.declare(metadata i64* %4, metadata !82, metadata !DIExpression()), !dbg !83
  call void @llvm.dbg.declare(metadata %struct.list** %5, metadata !84, metadata !DIExpression()), !dbg !85
  %7 = load %struct.list*, %struct.list** %3, align 8, !dbg !86
  %8 = getelementptr inbounds %struct.list, %struct.list* %7, i32 0, i32 1, !dbg !87
  %9 = load i64, i64* %8, align 8, !dbg !87
  %10 = load i64, i64* %4, align 8, !dbg !88
  %11 = mul nsw i64 %9, %10, !dbg !89
  %12 = call %struct.list* @allocate_list(i64 %11), !dbg !90
  store %struct.list* %12, %struct.list** %5, align 8, !dbg !85
  %13 = load %struct.list*, %struct.list** %3, align 8, !dbg !91
  %14 = getelementptr inbounds %struct.list, %struct.list* %13, i32 0, i32 1, !dbg !92
  %15 = load i64, i64* %14, align 8, !dbg !92
  %16 = load i64, i64* %4, align 8, !dbg !93
  %17 = mul nsw i64 %15, %16, !dbg !94
  %18 = load %struct.list*, %struct.list** %5, align 8, !dbg !95
  %19 = getelementptr inbounds %struct.list, %struct.list* %18, i32 0, i32 1, !dbg !96
  store i64 %17, i64* %19, align 8, !dbg !97
  call void @llvm.dbg.declare(metadata i64** %6, metadata !98, metadata !DIExpression()), !dbg !100
  %20 = load %struct.list*, %struct.list** %5, align 8, !dbg !101
  %21 = getelementptr inbounds %struct.list, %struct.list* %20, i32 0, i32 0, !dbg !102
  %22 = load i64*, i64** %21, align 8, !dbg !102
  store i64* %22, i64** %6, align 8, !dbg !100
  br label %23, !dbg !103

23:                                               ; preds = %42, %2
  %24 = load i64, i64* %4, align 8, !dbg !104
  %25 = add nsw i64 %24, -1, !dbg !104
  store i64 %25, i64* %4, align 8, !dbg !104
  %26 = icmp ne i64 %24, 0, !dbg !106
  br i1 %26, label %27, label %48, !dbg !106

27:                                               ; preds = %23
  %28 = load i64*, i64** %6, align 8, !dbg !107
  %29 = bitcast i64* %28 to i8*, !dbg !107
  %30 = load %struct.list*, %struct.list** %3, align 8, !dbg !107
  %31 = getelementptr inbounds %struct.list, %struct.list* %30, i32 0, i32 0, !dbg !107
  %32 = load i64*, i64** %31, align 8, !dbg !107
  %33 = bitcast i64* %32 to i8*, !dbg !107
  %34 = load %struct.list*, %struct.list** %3, align 8, !dbg !107
  %35 = getelementptr inbounds %struct.list, %struct.list* %34, i32 0, i32 1, !dbg !107
  %36 = load i64, i64* %35, align 8, !dbg !107
  %37 = mul i64 %36, 8, !dbg !107
  %38 = load i64*, i64** %6, align 8, !dbg !107
  %39 = bitcast i64* %38 to i8*, !dbg !107
  %40 = call i64 @llvm.objectsize.i64.p0i8(i8* %39, i1 false, i1 true, i1 false), !dbg !107
  %41 = call i8* @__memcpy_chk(i8* %29, i8* %33, i64 %37, i64 %40) #4, !dbg !107
  br label %42, !dbg !107

42:                                               ; preds = %27
  %43 = load %struct.list*, %struct.list** %3, align 8, !dbg !108
  %44 = getelementptr inbounds %struct.list, %struct.list* %43, i32 0, i32 1, !dbg !109
  %45 = load i64, i64* %44, align 8, !dbg !109
  %46 = load i64*, i64** %6, align 8, !dbg !110
  %47 = getelementptr inbounds i64, i64* %46, i64 %45, !dbg !110
  store i64* %47, i64** %6, align 8, !dbg !110
  br label %23, !dbg !111, !llvm.loop !112

48:                                               ; preds = %23
  %49 = load %struct.list*, %struct.list** %5, align 8, !dbg !115
  ret %struct.list* %49, !dbg !116
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @insert_into_list(%struct.list* %0, i64 %1, i64* %2) #0 !dbg !117 {
  %4 = alloca i64, align 8
  %5 = alloca %struct.list*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64*, align 8
  %8 = alloca i64, align 8
  store %struct.list* %0, %struct.list** %5, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %5, metadata !120, metadata !DIExpression()), !dbg !121
  store i64 %1, i64* %6, align 8
  call void @llvm.dbg.declare(metadata i64* %6, metadata !122, metadata !DIExpression()), !dbg !123
  store i64* %2, i64** %7, align 8
  call void @llvm.dbg.declare(metadata i64** %7, metadata !124, metadata !DIExpression()), !dbg !125
  %9 = load %struct.list*, %struct.list** %5, align 8, !dbg !126
  %10 = getelementptr inbounds %struct.list, %struct.list* %9, i32 0, i32 1, !dbg !128
  %11 = load i64, i64* %10, align 8, !dbg !128
  %12 = load i64, i64* %6, align 8, !dbg !129
  %13 = icmp slt i64 %11, %12, !dbg !130
  br i1 %13, label %17, label %14, !dbg !131

14:                                               ; preds = %3
  %15 = load i64, i64* %6, align 8, !dbg !132
  %16 = icmp slt i64 %15, 0, !dbg !133
  br i1 %16, label %17, label %18, !dbg !134

17:                                               ; preds = %14, %3
  store i64 0, i64* %4, align 8, !dbg !135
  br label %77, !dbg !135

18:                                               ; preds = %14
  %19 = load %struct.list*, %struct.list** %5, align 8, !dbg !136
  %20 = getelementptr inbounds %struct.list, %struct.list* %19, i32 0, i32 2, !dbg !138
  %21 = load i64, i64* %20, align 8, !dbg !138
  %22 = load %struct.list*, %struct.list** %5, align 8, !dbg !139
  %23 = getelementptr inbounds %struct.list, %struct.list* %22, i32 0, i32 1, !dbg !140
  %24 = load i64, i64* %23, align 8, !dbg !140
  %25 = icmp eq i64 %21, %24, !dbg !141
  br i1 %25, label %26, label %40, !dbg !142

26:                                               ; preds = %18
  %27 = load %struct.list*, %struct.list** %5, align 8, !dbg !143
  %28 = getelementptr inbounds %struct.list, %struct.list* %27, i32 0, i32 0, !dbg !144
  %29 = load i64*, i64** %28, align 8, !dbg !144
  %30 = bitcast i64* %29 to i8*, !dbg !143
  %31 = load %struct.list*, %struct.list** %5, align 8, !dbg !145
  %32 = getelementptr inbounds %struct.list, %struct.list* %31, i32 0, i32 2, !dbg !146
  %33 = load i64, i64* %32, align 8, !dbg !147
  %34 = mul nsw i64 %33, 2, !dbg !147
  store i64 %34, i64* %32, align 8, !dbg !147
  %35 = mul i64 %34, 8, !dbg !148
  %36 = call i8* @xrealloc(i8* %30, i64 %35), !dbg !149
  %37 = bitcast i8* %36 to i64*, !dbg !149
  %38 = load %struct.list*, %struct.list** %5, align 8, !dbg !150
  %39 = getelementptr inbounds %struct.list, %struct.list* %38, i32 0, i32 0, !dbg !151
  store i64* %37, i64** %39, align 8, !dbg !152
  br label %40, !dbg !150

40:                                               ; preds = %26, %18
  call void @llvm.dbg.declare(metadata i64* %8, metadata !153, metadata !DIExpression()), !dbg !155
  %41 = load %struct.list*, %struct.list** %5, align 8, !dbg !156
  %42 = getelementptr inbounds %struct.list, %struct.list* %41, i32 0, i32 1, !dbg !157
  %43 = load i64, i64* %42, align 8, !dbg !157
  %44 = add nsw i64 %43, 1, !dbg !158
  store i64 %44, i64* %8, align 8, !dbg !155
  br label %45, !dbg !159

45:                                               ; preds = %62, %40
  %46 = load i64, i64* %8, align 8, !dbg !160
  %47 = load i64, i64* %6, align 8, !dbg !162
  %48 = icmp sge i64 %46, %47, !dbg !163
  br i1 %48, label %49, label %65, !dbg !164

49:                                               ; preds = %45
  %50 = load %struct.list*, %struct.list** %5, align 8, !dbg !165
  %51 = getelementptr inbounds %struct.list, %struct.list* %50, i32 0, i32 0, !dbg !167
  %52 = load i64*, i64** %51, align 8, !dbg !167
  %53 = load i64, i64* %8, align 8, !dbg !168
  %54 = sub nsw i64 %53, 1, !dbg !169
  %55 = getelementptr inbounds i64, i64* %52, i64 %54, !dbg !165
  %56 = load i64, i64* %55, align 8, !dbg !165
  %57 = load %struct.list*, %struct.list** %5, align 8, !dbg !170
  %58 = getelementptr inbounds %struct.list, %struct.list* %57, i32 0, i32 0, !dbg !171
  %59 = load i64*, i64** %58, align 8, !dbg !171
  %60 = load i64, i64* %8, align 8, !dbg !172
  %61 = getelementptr inbounds i64, i64* %59, i64 %60, !dbg !170
  store i64 %56, i64* %61, align 8, !dbg !173
  br label %62, !dbg !174

62:                                               ; preds = %49
  %63 = load i64, i64* %8, align 8, !dbg !175
  %64 = add nsw i64 %63, -1, !dbg !175
  store i64 %64, i64* %8, align 8, !dbg !175
  br label %45, !dbg !176, !llvm.loop !177

65:                                               ; preds = %45
  %66 = load i64*, i64** %7, align 8, !dbg !179
  %67 = load i64, i64* %66, align 8, !dbg !180
  %68 = load %struct.list*, %struct.list** %5, align 8, !dbg !181
  %69 = getelementptr inbounds %struct.list, %struct.list* %68, i32 0, i32 0, !dbg !182
  %70 = load i64*, i64** %69, align 8, !dbg !182
  %71 = load i64, i64* %6, align 8, !dbg !183
  %72 = getelementptr inbounds i64, i64* %70, i64 %71, !dbg !181
  store i64 %67, i64* %72, align 8, !dbg !184
  %73 = load %struct.list*, %struct.list** %5, align 8, !dbg !185
  %74 = getelementptr inbounds %struct.list, %struct.list* %73, i32 0, i32 1, !dbg !186
  %75 = load i64, i64* %74, align 8, !dbg !187
  %76 = add nsw i64 %75, 1, !dbg !187
  store i64 %76, i64* %74, align 8, !dbg !187
  store i64 1, i64* %4, align 8, !dbg !188
  br label %77, !dbg !188

77:                                               ; preds = %65, %17
  %78 = load i64, i64* %4, align 8, !dbg !189
  ret i64 %78, !dbg !189
}

declare i8* @xrealloc(i8*, i64) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @delete_from_list(%struct.list* %0, i64* %1, i64 %2) #0 !dbg !190 {
  %4 = alloca i64, align 8
  %5 = alloca %struct.list*, align 8
  %6 = alloca i64*, align 8
  %7 = alloca i64, align 8
  store %struct.list* %0, %struct.list** %5, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %5, metadata !193, metadata !DIExpression()), !dbg !194
  store i64* %1, i64** %6, align 8
  call void @llvm.dbg.declare(metadata i64** %6, metadata !195, metadata !DIExpression()), !dbg !196
  store i64 %2, i64* %7, align 8
  call void @llvm.dbg.declare(metadata i64* %7, metadata !197, metadata !DIExpression()), !dbg !198
  %8 = load %struct.list*, %struct.list** %5, align 8, !dbg !199
  %9 = getelementptr inbounds %struct.list, %struct.list* %8, i32 0, i32 1, !dbg !201
  %10 = load i64, i64* %9, align 8, !dbg !201
  %11 = load i64, i64* %7, align 8, !dbg !202
  %12 = icmp sle i64 %10, %11, !dbg !203
  br i1 %12, label %16, label %13, !dbg !204

13:                                               ; preds = %3
  %14 = load i64, i64* %7, align 8, !dbg !205
  %15 = icmp slt i64 %14, 0, !dbg !206
  br i1 %15, label %16, label %17, !dbg !207

16:                                               ; preds = %13, %3
  store i64 0, i64* %4, align 8, !dbg !208
  br label %57, !dbg !208

17:                                               ; preds = %13
  %18 = load %struct.list*, %struct.list** %5, align 8, !dbg !209
  %19 = getelementptr inbounds %struct.list, %struct.list* %18, i32 0, i32 0, !dbg !210
  %20 = load i64*, i64** %19, align 8, !dbg !210
  %21 = load i64, i64* %7, align 8, !dbg !211
  %22 = getelementptr inbounds i64, i64* %20, i64 %21, !dbg !209
  %23 = load i64, i64* %22, align 8, !dbg !209
  %24 = load i64*, i64** %6, align 8, !dbg !212
  store i64 %23, i64* %24, align 8, !dbg !213
  %25 = load %struct.list*, %struct.list** %5, align 8, !dbg !214
  %26 = getelementptr inbounds %struct.list, %struct.list* %25, i32 0, i32 0, !dbg !214
  %27 = load i64*, i64** %26, align 8, !dbg !214
  %28 = load i64, i64* %7, align 8, !dbg !214
  %29 = getelementptr inbounds i64, i64* %27, i64 %28, !dbg !214
  %30 = getelementptr inbounds i64, i64* %29, i64 -1, !dbg !214
  %31 = bitcast i64* %30 to i8*, !dbg !214
  %32 = load %struct.list*, %struct.list** %5, align 8, !dbg !214
  %33 = getelementptr inbounds %struct.list, %struct.list* %32, i32 0, i32 0, !dbg !214
  %34 = load i64*, i64** %33, align 8, !dbg !214
  %35 = load i64, i64* %7, align 8, !dbg !214
  %36 = getelementptr inbounds i64, i64* %34, i64 %35, !dbg !214
  %37 = bitcast i64* %36 to i8*, !dbg !214
  %38 = load %struct.list*, %struct.list** %5, align 8, !dbg !214
  %39 = getelementptr inbounds %struct.list, %struct.list* %38, i32 0, i32 1, !dbg !214
  %40 = load i64, i64* %39, align 8, !dbg !214
  %41 = load i64, i64* %7, align 8, !dbg !214
  %42 = sub nsw i64 %40, %41, !dbg !214
  %43 = mul i64 8, %42, !dbg !214
  %44 = load %struct.list*, %struct.list** %5, align 8, !dbg !214
  %45 = getelementptr inbounds %struct.list, %struct.list* %44, i32 0, i32 0, !dbg !214
  %46 = load i64*, i64** %45, align 8, !dbg !214
  %47 = load i64, i64* %7, align 8, !dbg !214
  %48 = getelementptr inbounds i64, i64* %46, i64 %47, !dbg !214
  %49 = getelementptr inbounds i64, i64* %48, i64 -1, !dbg !214
  %50 = bitcast i64* %49 to i8*, !dbg !214
  %51 = call i64 @llvm.objectsize.i64.p0i8(i8* %50, i1 false, i1 true, i1 false), !dbg !214
  %52 = call i8* @__memmove_chk(i8* %31, i8* %37, i64 %43, i64 %51) #4, !dbg !214
  %53 = load %struct.list*, %struct.list** %5, align 8, !dbg !215
  %54 = getelementptr inbounds %struct.list, %struct.list* %53, i32 0, i32 1, !dbg !216
  %55 = load i64, i64* %54, align 8, !dbg !217
  %56 = add nsw i64 %55, -1, !dbg !217
  store i64 %56, i64* %54, align 8, !dbg !217
  store i64 1, i64* %4, align 8, !dbg !218
  br label %57, !dbg !218

57:                                               ; preds = %17, %16
  %58 = load i64, i64* %4, align 8, !dbg !219
  ret i64 %58, !dbg !219
}

; Function Attrs: nounwind
declare i8* @__memmove_chk(i8*, i8*, i64, i64) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @push_into_list(%struct.list* %0, i64* %1) #0 !dbg !220 {
  %3 = alloca %struct.list*, align 8
  %4 = alloca i64*, align 8
  store %struct.list* %0, %struct.list** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !223, metadata !DIExpression()), !dbg !224
  store i64* %1, i64** %4, align 8
  call void @llvm.dbg.declare(metadata i64** %4, metadata !225, metadata !DIExpression()), !dbg !226
  %5 = load %struct.list*, %struct.list** %3, align 8, !dbg !227
  %6 = getelementptr inbounds %struct.list, %struct.list* %5, i32 0, i32 2, !dbg !229
  %7 = load i64, i64* %6, align 8, !dbg !229
  %8 = load %struct.list*, %struct.list** %3, align 8, !dbg !230
  %9 = getelementptr inbounds %struct.list, %struct.list* %8, i32 0, i32 1, !dbg !231
  %10 = load i64, i64* %9, align 8, !dbg !231
  %11 = icmp eq i64 %7, %10, !dbg !232
  br i1 %11, label %12, label %26, !dbg !233

12:                                               ; preds = %2
  %13 = load %struct.list*, %struct.list** %3, align 8, !dbg !234
  %14 = getelementptr inbounds %struct.list, %struct.list* %13, i32 0, i32 0, !dbg !235
  %15 = load i64*, i64** %14, align 8, !dbg !235
  %16 = bitcast i64* %15 to i8*, !dbg !234
  %17 = load %struct.list*, %struct.list** %3, align 8, !dbg !236
  %18 = getelementptr inbounds %struct.list, %struct.list* %17, i32 0, i32 2, !dbg !237
  %19 = load i64, i64* %18, align 8, !dbg !238
  %20 = mul nsw i64 %19, 2, !dbg !238
  store i64 %20, i64* %18, align 8, !dbg !238
  %21 = mul i64 %20, 8, !dbg !239
  %22 = call i8* @xrealloc(i8* %16, i64 %21), !dbg !240
  %23 = bitcast i8* %22 to i64*, !dbg !240
  %24 = load %struct.list*, %struct.list** %3, align 8, !dbg !241
  %25 = getelementptr inbounds %struct.list, %struct.list* %24, i32 0, i32 0, !dbg !242
  store i64* %23, i64** %25, align 8, !dbg !243
  br label %26, !dbg !241

26:                                               ; preds = %12, %2
  %27 = load i64*, i64** %4, align 8, !dbg !244
  %28 = load i64, i64* %27, align 8, !dbg !245
  %29 = load %struct.list*, %struct.list** %3, align 8, !dbg !246
  %30 = getelementptr inbounds %struct.list, %struct.list* %29, i32 0, i32 0, !dbg !247
  %31 = load i64*, i64** %30, align 8, !dbg !247
  %32 = load %struct.list*, %struct.list** %3, align 8, !dbg !248
  %33 = getelementptr inbounds %struct.list, %struct.list* %32, i32 0, i32 1, !dbg !249
  %34 = load i64, i64* %33, align 8, !dbg !250
  %35 = add nsw i64 %34, 1, !dbg !250
  store i64 %35, i64* %33, align 8, !dbg !250
  %36 = getelementptr inbounds i64, i64* %31, i64 %34, !dbg !246
  store i64 %28, i64* %36, align 8, !dbg !251
  ret void, !dbg !252
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @pop_from_list(%struct.list* %0, i64* %1) #0 !dbg !253 {
  %3 = alloca %struct.list*, align 8
  %4 = alloca i64*, align 8
  store %struct.list* %0, %struct.list** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !254, metadata !DIExpression()), !dbg !255
  store i64* %1, i64** %4, align 8
  call void @llvm.dbg.declare(metadata i64** %4, metadata !256, metadata !DIExpression()), !dbg !257
  %5 = load %struct.list*, %struct.list** %3, align 8, !dbg !258
  %6 = getelementptr inbounds %struct.list, %struct.list* %5, i32 0, i32 1, !dbg !260
  %7 = load i64, i64* %6, align 8, !dbg !260
  %8 = icmp ne i64 %7, 0, !dbg !258
  br i1 %8, label %11, label %9, !dbg !261

9:                                                ; preds = %2
  %10 = call %struct._str* @create_str_from_borrowed(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str, i64 0, i64 0)), !dbg !262
  call void @abort_msg(%struct._str* %10), !dbg !263
  br label %11, !dbg !263

11:                                               ; preds = %9, %2
  %12 = load %struct.list*, %struct.list** %3, align 8, !dbg !264
  %13 = getelementptr inbounds %struct.list, %struct.list* %12, i32 0, i32 0, !dbg !265
  %14 = load i64*, i64** %13, align 8, !dbg !265
  %15 = load %struct.list*, %struct.list** %3, align 8, !dbg !266
  %16 = getelementptr inbounds %struct.list, %struct.list* %15, i32 0, i32 1, !dbg !267
  %17 = load i64, i64* %16, align 8, !dbg !268
  %18 = add nsw i64 %17, -1, !dbg !268
  store i64 %18, i64* %16, align 8, !dbg !268
  %19 = getelementptr inbounds i64, i64* %14, i64 %18, !dbg !264
  %20 = load i64, i64* %19, align 8, !dbg !264
  %21 = load i64*, i64** %4, align 8, !dbg !269
  store i64 %20, i64* %21, align 8, !dbg !270
  ret void, !dbg !271
}

declare void @abort_msg(%struct._str*) #2

declare %struct._str* @create_str_from_borrowed(i8*) #2

attributes #0 = { noinline nounwind optnone ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.dbg.cu = !{!9}
!llvm.ident = !{!12}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 12, i32 0]}
!1 = !{i32 7, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"branch-target-enforcement", i32 0}
!5 = !{i32 1, !"sign-return-address", i32 0}
!6 = !{i32 1, !"sign-return-address-all", i32 0}
!7 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!8 = !{i32 7, !"PIC Level", i32 2}
!9 = distinct !DICompileUnit(language: DW_LANG_C99, file: !10, producer: "Apple clang version 13.0.0 (clang-1300.0.29.3)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !11, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk", sdk: "MacOSX.sdk")
!10 = !DIFile(filename: "list.c", directory: "/Users/sampersand/code/lance/include")
!11 = !{}
!12 = !{!"Apple clang version 13.0.0 (clang-1300.0.29.3)"}
!13 = distinct !DISubprogram(name: "allocate_list", scope: !10, file: !10, line: 8, type: !14, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!14 = !DISubroutineType(types: !15)
!15 = !{!16, !23}
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "list", file: !18, line: 8, baseType: !19)
!18 = !DIFile(filename: "./list.h", directory: "/Users/sampersand/code/lance/include")
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !18, line: 6, size: 192, elements: !20)
!20 = !{!21, !26, !27}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !19, file: !18, line: 7, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "ll", file: !24, line: 5, baseType: !25)
!24 = !DIFile(filename: "./shared.h", directory: "/Users/sampersand/code/lance/include")
!25 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !19, file: !18, line: 7, baseType: !23, size: 64, offset: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "cap", scope: !19, file: !18, line: 7, baseType: !23, size: 64, offset: 128)
!28 = !DILocalVariable(name: "cap", arg: 1, scope: !13, file: !10, line: 8, type: !23)
!29 = !DILocation(line: 8, column: 24, scope: !13)
!30 = !DILocalVariable(name: "l", scope: !13, file: !10, line: 9, type: !16)
!31 = !DILocation(line: 9, column: 8, scope: !13)
!32 = !DILocation(line: 9, column: 12, scope: !13)
!33 = !DILocation(line: 11, column: 26, scope: !13)
!34 = !DILocation(line: 11, column: 25, scope: !13)
!35 = !DILocation(line: 11, column: 11, scope: !13)
!36 = !DILocation(line: 11, column: 2, scope: !13)
!37 = !DILocation(line: 11, column: 5, scope: !13)
!38 = !DILocation(line: 11, column: 9, scope: !13)
!39 = !DILocation(line: 12, column: 2, scope: !13)
!40 = !DILocation(line: 12, column: 5, scope: !13)
!41 = !DILocation(line: 12, column: 9, scope: !13)
!42 = !DILocation(line: 13, column: 11, scope: !13)
!43 = !DILocation(line: 13, column: 2, scope: !13)
!44 = !DILocation(line: 13, column: 5, scope: !13)
!45 = !DILocation(line: 13, column: 9, scope: !13)
!46 = !DILocation(line: 15, column: 9, scope: !13)
!47 = !DILocation(line: 15, column: 2, scope: !13)
!48 = distinct !DISubprogram(name: "concat_lists", scope: !10, file: !10, line: 18, type: !49, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!49 = !DISubroutineType(types: !50)
!50 = !{!16, !51, !51}
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !17)
!53 = !DILocalVariable(name: "lhs", arg: 1, scope: !48, file: !10, line: 18, type: !51)
!54 = !DILocation(line: 18, column: 32, scope: !48)
!55 = !DILocalVariable(name: "rhs", arg: 2, scope: !48, file: !10, line: 18, type: !51)
!56 = !DILocation(line: 18, column: 49, scope: !48)
!57 = !DILocalVariable(name: "l", scope: !48, file: !10, line: 19, type: !16)
!58 = !DILocation(line: 19, column: 8, scope: !48)
!59 = !DILocation(line: 19, column: 26, scope: !48)
!60 = !DILocation(line: 19, column: 31, scope: !48)
!61 = !DILocation(line: 19, column: 37, scope: !48)
!62 = !DILocation(line: 19, column: 42, scope: !48)
!63 = !DILocation(line: 19, column: 35, scope: !48)
!64 = !DILocation(line: 19, column: 12, scope: !48)
!65 = !DILocation(line: 20, column: 11, scope: !48)
!66 = !DILocation(line: 20, column: 16, scope: !48)
!67 = !DILocation(line: 20, column: 22, scope: !48)
!68 = !DILocation(line: 20, column: 27, scope: !48)
!69 = !DILocation(line: 20, column: 20, scope: !48)
!70 = !DILocation(line: 20, column: 2, scope: !48)
!71 = !DILocation(line: 20, column: 5, scope: !48)
!72 = !DILocation(line: 20, column: 9, scope: !48)
!73 = !DILocation(line: 22, column: 2, scope: !48)
!74 = !DILocation(line: 23, column: 2, scope: !48)
!75 = !DILocation(line: 25, column: 9, scope: !48)
!76 = !DILocation(line: 25, column: 2, scope: !48)
!77 = distinct !DISubprogram(name: "repeat_list", scope: !10, file: !10, line: 29, type: !78, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!78 = !DISubroutineType(types: !79)
!79 = !{!16, !51, !23}
!80 = !DILocalVariable(name: "src", arg: 1, scope: !77, file: !10, line: 29, type: !51)
!81 = !DILocation(line: 29, column: 31, scope: !77)
!82 = !DILocalVariable(name: "amnt", arg: 2, scope: !77, file: !10, line: 29, type: !23)
!83 = !DILocation(line: 29, column: 39, scope: !77)
!84 = !DILocalVariable(name: "l", scope: !77, file: !10, line: 30, type: !16)
!85 = !DILocation(line: 30, column: 8, scope: !77)
!86 = !DILocation(line: 30, column: 26, scope: !77)
!87 = !DILocation(line: 30, column: 31, scope: !77)
!88 = !DILocation(line: 30, column: 37, scope: !77)
!89 = !DILocation(line: 30, column: 35, scope: !77)
!90 = !DILocation(line: 30, column: 12, scope: !77)
!91 = !DILocation(line: 31, column: 11, scope: !77)
!92 = !DILocation(line: 31, column: 16, scope: !77)
!93 = !DILocation(line: 31, column: 22, scope: !77)
!94 = !DILocation(line: 31, column: 20, scope: !77)
!95 = !DILocation(line: 31, column: 2, scope: !77)
!96 = !DILocation(line: 31, column: 5, scope: !77)
!97 = !DILocation(line: 31, column: 9, scope: !77)
!98 = !DILocalVariable(name: "ptr", scope: !99, file: !10, line: 33, type: !22)
!99 = distinct !DILexicalBlock(scope: !77, file: !10, line: 33, column: 2)
!100 = !DILocation(line: 33, column: 11, scope: !99)
!101 = !DILocation(line: 33, column: 17, scope: !99)
!102 = !DILocation(line: 33, column: 20, scope: !99)
!103 = !DILocation(line: 33, column: 7, scope: !99)
!104 = !DILocation(line: 33, column: 29, scope: !105)
!105 = distinct !DILexicalBlock(scope: !99, file: !10, line: 33, column: 2)
!106 = !DILocation(line: 33, column: 2, scope: !99)
!107 = !DILocation(line: 34, column: 3, scope: !105)
!108 = !DILocation(line: 33, column: 40, scope: !105)
!109 = !DILocation(line: 33, column: 45, scope: !105)
!110 = !DILocation(line: 33, column: 37, scope: !105)
!111 = !DILocation(line: 33, column: 2, scope: !105)
!112 = distinct !{!112, !106, !113, !114}
!113 = !DILocation(line: 34, column: 3, scope: !99)
!114 = !{!"llvm.loop.mustprogress"}
!115 = !DILocation(line: 36, column: 9, scope: !77)
!116 = !DILocation(line: 36, column: 2, scope: !77)
!117 = distinct !DISubprogram(name: "insert_into_list", scope: !10, file: !10, line: 39, type: !118, scopeLine: 39, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!118 = !DISubroutineType(types: !119)
!119 = !{!23, !16, !23, !22}
!120 = !DILocalVariable(name: "l", arg: 1, scope: !117, file: !10, line: 39, type: !16)
!121 = !DILocation(line: 39, column: 27, scope: !117)
!122 = !DILocalVariable(name: "pos", arg: 2, scope: !117, file: !10, line: 39, type: !23)
!123 = !DILocation(line: 39, column: 33, scope: !117)
!124 = !DILocalVariable(name: "ele", arg: 3, scope: !117, file: !10, line: 39, type: !22)
!125 = !DILocation(line: 39, column: 42, scope: !117)
!126 = !DILocation(line: 40, column: 6, scope: !127)
!127 = distinct !DILexicalBlock(scope: !117, file: !10, line: 40, column: 6)
!128 = !DILocation(line: 40, column: 9, scope: !127)
!129 = !DILocation(line: 40, column: 15, scope: !127)
!130 = !DILocation(line: 40, column: 13, scope: !127)
!131 = !DILocation(line: 40, column: 19, scope: !127)
!132 = !DILocation(line: 40, column: 22, scope: !127)
!133 = !DILocation(line: 40, column: 26, scope: !127)
!134 = !DILocation(line: 40, column: 6, scope: !117)
!135 = !DILocation(line: 41, column: 3, scope: !127)
!136 = !DILocation(line: 43, column: 6, scope: !137)
!137 = distinct !DILexicalBlock(scope: !117, file: !10, line: 43, column: 6)
!138 = !DILocation(line: 43, column: 9, scope: !137)
!139 = !DILocation(line: 43, column: 16, scope: !137)
!140 = !DILocation(line: 43, column: 19, scope: !137)
!141 = !DILocation(line: 43, column: 13, scope: !137)
!142 = !DILocation(line: 43, column: 6, scope: !117)
!143 = !DILocation(line: 44, column: 21, scope: !137)
!144 = !DILocation(line: 44, column: 24, scope: !137)
!145 = !DILocation(line: 44, column: 30, scope: !137)
!146 = !DILocation(line: 44, column: 33, scope: !137)
!147 = !DILocation(line: 44, column: 37, scope: !137)
!148 = !DILocation(line: 44, column: 42, scope: !137)
!149 = !DILocation(line: 44, column: 12, scope: !137)
!150 = !DILocation(line: 44, column: 3, scope: !137)
!151 = !DILocation(line: 44, column: 6, scope: !137)
!152 = !DILocation(line: 44, column: 10, scope: !137)
!153 = !DILocalVariable(name: "i", scope: !154, file: !10, line: 46, type: !23)
!154 = distinct !DILexicalBlock(scope: !117, file: !10, line: 46, column: 2)
!155 = !DILocation(line: 46, column: 10, scope: !154)
!156 = !DILocation(line: 46, column: 14, scope: !154)
!157 = !DILocation(line: 46, column: 17, scope: !154)
!158 = !DILocation(line: 46, column: 21, scope: !154)
!159 = !DILocation(line: 46, column: 7, scope: !154)
!160 = !DILocation(line: 46, column: 26, scope: !161)
!161 = distinct !DILexicalBlock(scope: !154, file: !10, line: 46, column: 2)
!162 = !DILocation(line: 46, column: 31, scope: !161)
!163 = !DILocation(line: 46, column: 28, scope: !161)
!164 = !DILocation(line: 46, column: 2, scope: !154)
!165 = !DILocation(line: 47, column: 15, scope: !166)
!166 = distinct !DILexicalBlock(scope: !161, file: !10, line: 46, column: 41)
!167 = !DILocation(line: 47, column: 18, scope: !166)
!168 = !DILocation(line: 47, column: 22, scope: !166)
!169 = !DILocation(line: 47, column: 23, scope: !166)
!170 = !DILocation(line: 47, column: 3, scope: !166)
!171 = !DILocation(line: 47, column: 6, scope: !166)
!172 = !DILocation(line: 47, column: 10, scope: !166)
!173 = !DILocation(line: 47, column: 13, scope: !166)
!174 = !DILocation(line: 49, column: 2, scope: !166)
!175 = !DILocation(line: 46, column: 36, scope: !161)
!176 = !DILocation(line: 46, column: 2, scope: !161)
!177 = distinct !{!177, !164, !178, !114}
!178 = !DILocation(line: 49, column: 2, scope: !154)
!179 = !DILocation(line: 53, column: 17, scope: !117)
!180 = !DILocation(line: 53, column: 16, scope: !117)
!181 = !DILocation(line: 53, column: 2, scope: !117)
!182 = !DILocation(line: 53, column: 5, scope: !117)
!183 = !DILocation(line: 53, column: 9, scope: !117)
!184 = !DILocation(line: 53, column: 14, scope: !117)
!185 = !DILocation(line: 54, column: 2, scope: !117)
!186 = !DILocation(line: 54, column: 5, scope: !117)
!187 = !DILocation(line: 54, column: 8, scope: !117)
!188 = !DILocation(line: 56, column: 2, scope: !117)
!189 = !DILocation(line: 57, column: 1, scope: !117)
!190 = distinct !DISubprogram(name: "delete_from_list", scope: !10, file: !10, line: 59, type: !191, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!191 = !DISubroutineType(types: !192)
!192 = !{!23, !16, !22, !23}
!193 = !DILocalVariable(name: "l", arg: 1, scope: !190, file: !10, line: 59, type: !16)
!194 = !DILocation(line: 59, column: 27, scope: !190)
!195 = !DILocalVariable(name: "dst", arg: 2, scope: !190, file: !10, line: 59, type: !22)
!196 = !DILocation(line: 59, column: 34, scope: !190)
!197 = !DILocalVariable(name: "pos", arg: 3, scope: !190, file: !10, line: 59, type: !23)
!198 = !DILocation(line: 59, column: 42, scope: !190)
!199 = !DILocation(line: 60, column: 6, scope: !200)
!200 = distinct !DILexicalBlock(scope: !190, file: !10, line: 60, column: 6)
!201 = !DILocation(line: 60, column: 9, scope: !200)
!202 = !DILocation(line: 60, column: 16, scope: !200)
!203 = !DILocation(line: 60, column: 13, scope: !200)
!204 = !DILocation(line: 60, column: 20, scope: !200)
!205 = !DILocation(line: 60, column: 23, scope: !200)
!206 = !DILocation(line: 60, column: 27, scope: !200)
!207 = !DILocation(line: 60, column: 6, scope: !190)
!208 = !DILocation(line: 61, column: 3, scope: !200)
!209 = !DILocation(line: 63, column: 9, scope: !190)
!210 = !DILocation(line: 63, column: 12, scope: !190)
!211 = !DILocation(line: 63, column: 16, scope: !190)
!212 = !DILocation(line: 63, column: 3, scope: !190)
!213 = !DILocation(line: 63, column: 7, scope: !190)
!214 = !DILocation(line: 64, column: 2, scope: !190)
!215 = !DILocation(line: 66, column: 2, scope: !190)
!216 = !DILocation(line: 66, column: 5, scope: !190)
!217 = !DILocation(line: 66, column: 8, scope: !190)
!218 = !DILocation(line: 68, column: 2, scope: !190)
!219 = !DILocation(line: 69, column: 1, scope: !190)
!220 = distinct !DISubprogram(name: "push_into_list", scope: !10, file: !10, line: 71, type: !221, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!221 = !DISubroutineType(types: !222)
!222 = !{null, !16, !22}
!223 = !DILocalVariable(name: "l", arg: 1, scope: !220, file: !10, line: 71, type: !16)
!224 = !DILocation(line: 71, column: 27, scope: !220)
!225 = !DILocalVariable(name: "ele", arg: 2, scope: !220, file: !10, line: 71, type: !22)
!226 = !DILocation(line: 71, column: 34, scope: !220)
!227 = !DILocation(line: 72, column: 6, scope: !228)
!228 = distinct !DILexicalBlock(scope: !220, file: !10, line: 72, column: 6)
!229 = !DILocation(line: 72, column: 9, scope: !228)
!230 = !DILocation(line: 72, column: 16, scope: !228)
!231 = !DILocation(line: 72, column: 19, scope: !228)
!232 = !DILocation(line: 72, column: 13, scope: !228)
!233 = !DILocation(line: 72, column: 6, scope: !220)
!234 = !DILocation(line: 73, column: 21, scope: !228)
!235 = !DILocation(line: 73, column: 24, scope: !228)
!236 = !DILocation(line: 73, column: 30, scope: !228)
!237 = !DILocation(line: 73, column: 33, scope: !228)
!238 = !DILocation(line: 73, column: 37, scope: !228)
!239 = !DILocation(line: 73, column: 42, scope: !228)
!240 = !DILocation(line: 73, column: 12, scope: !228)
!241 = !DILocation(line: 73, column: 3, scope: !228)
!242 = !DILocation(line: 73, column: 6, scope: !228)
!243 = !DILocation(line: 73, column: 10, scope: !228)
!244 = !DILocation(line: 74, column: 22, scope: !220)
!245 = !DILocation(line: 74, column: 21, scope: !220)
!246 = !DILocation(line: 74, column: 2, scope: !220)
!247 = !DILocation(line: 74, column: 5, scope: !220)
!248 = !DILocation(line: 74, column: 9, scope: !220)
!249 = !DILocation(line: 74, column: 12, scope: !220)
!250 = !DILocation(line: 74, column: 15, scope: !220)
!251 = !DILocation(line: 74, column: 19, scope: !220)
!252 = !DILocation(line: 75, column: 1, scope: !220)
!253 = distinct !DISubprogram(name: "pop_from_list", scope: !10, file: !10, line: 77, type: !221, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!254 = !DILocalVariable(name: "l", arg: 1, scope: !253, file: !10, line: 77, type: !16)
!255 = !DILocation(line: 77, column: 26, scope: !253)
!256 = !DILocalVariable(name: "out", arg: 2, scope: !253, file: !10, line: 77, type: !22)
!257 = !DILocation(line: 77, column: 33, scope: !253)
!258 = !DILocation(line: 78, column: 7, scope: !259)
!259 = distinct !DILexicalBlock(scope: !253, file: !10, line: 78, column: 6)
!260 = !DILocation(line: 78, column: 10, scope: !259)
!261 = !DILocation(line: 78, column: 6, scope: !253)
!262 = !DILocation(line: 79, column: 13, scope: !259)
!263 = !DILocation(line: 79, column: 3, scope: !259)
!264 = !DILocation(line: 81, column: 9, scope: !253)
!265 = !DILocation(line: 81, column: 12, scope: !253)
!266 = !DILocation(line: 81, column: 18, scope: !253)
!267 = !DILocation(line: 81, column: 21, scope: !253)
!268 = !DILocation(line: 81, column: 16, scope: !253)
!269 = !DILocation(line: 81, column: 3, scope: !253)
!270 = !DILocation(line: 81, column: 7, scope: !253)
!271 = !DILocation(line: 82, column: 1, scope: !253)
