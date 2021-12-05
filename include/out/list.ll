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
  %4 = load i64, i64* %2, align 8, !dbg !30
  %5 = icmp eq i64 %4, 0, !dbg !32
  br i1 %5, label %6, label %7, !dbg !33

6:                                                ; preds = %1
  store i64 1, i64* %2, align 8, !dbg !34
  br label %7, !dbg !35

7:                                                ; preds = %6, %1
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !36, metadata !DIExpression()), !dbg !37
  %8 = call i8* @xmalloc(i64 24), !dbg !38
  %9 = bitcast i8* %8 to %struct.list*, !dbg !38
  store %struct.list* %9, %struct.list** %3, align 8, !dbg !37
  %10 = load i64, i64* %2, align 8, !dbg !39
  %11 = mul i64 8, %10, !dbg !40
  %12 = call i8* @xmalloc(i64 %11), !dbg !41
  %13 = bitcast i8* %12 to i64*, !dbg !41
  %14 = load %struct.list*, %struct.list** %3, align 8, !dbg !42
  %15 = getelementptr inbounds %struct.list, %struct.list* %14, i32 0, i32 0, !dbg !43
  store i64* %13, i64** %15, align 8, !dbg !44
  %16 = load %struct.list*, %struct.list** %3, align 8, !dbg !45
  %17 = getelementptr inbounds %struct.list, %struct.list* %16, i32 0, i32 1, !dbg !46
  store i64 0, i64* %17, align 8, !dbg !47
  %18 = load i64, i64* %2, align 8, !dbg !48
  %19 = load %struct.list*, %struct.list** %3, align 8, !dbg !49
  %20 = getelementptr inbounds %struct.list, %struct.list* %19, i32 0, i32 2, !dbg !50
  store i64 %18, i64* %20, align 8, !dbg !51
  %21 = load %struct.list*, %struct.list** %3, align 8, !dbg !52
  ret %struct.list* %21, !dbg !53
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @xmalloc(i64) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.list* @concat_lists(%struct.list* %0, %struct.list* %1) #0 !dbg !54 {
  %3 = alloca %struct.list*, align 8
  %4 = alloca %struct.list*, align 8
  %5 = alloca %struct.list*, align 8
  store %struct.list* %0, %struct.list** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !59, metadata !DIExpression()), !dbg !60
  store %struct.list* %1, %struct.list** %4, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %4, metadata !61, metadata !DIExpression()), !dbg !62
  call void @llvm.dbg.declare(metadata %struct.list** %5, metadata !63, metadata !DIExpression()), !dbg !64
  %6 = load %struct.list*, %struct.list** %3, align 8, !dbg !65
  %7 = getelementptr inbounds %struct.list, %struct.list* %6, i32 0, i32 1, !dbg !66
  %8 = load i64, i64* %7, align 8, !dbg !66
  %9 = load %struct.list*, %struct.list** %4, align 8, !dbg !67
  %10 = getelementptr inbounds %struct.list, %struct.list* %9, i32 0, i32 1, !dbg !68
  %11 = load i64, i64* %10, align 8, !dbg !68
  %12 = add nsw i64 %8, %11, !dbg !69
  %13 = call %struct.list* @allocate_list(i64 %12), !dbg !70
  store %struct.list* %13, %struct.list** %5, align 8, !dbg !64
  %14 = load %struct.list*, %struct.list** %3, align 8, !dbg !71
  %15 = getelementptr inbounds %struct.list, %struct.list* %14, i32 0, i32 1, !dbg !72
  %16 = load i64, i64* %15, align 8, !dbg !72
  %17 = load %struct.list*, %struct.list** %4, align 8, !dbg !73
  %18 = getelementptr inbounds %struct.list, %struct.list* %17, i32 0, i32 1, !dbg !74
  %19 = load i64, i64* %18, align 8, !dbg !74
  %20 = add nsw i64 %16, %19, !dbg !75
  %21 = load %struct.list*, %struct.list** %5, align 8, !dbg !76
  %22 = getelementptr inbounds %struct.list, %struct.list* %21, i32 0, i32 1, !dbg !77
  store i64 %20, i64* %22, align 8, !dbg !78
  %23 = load %struct.list*, %struct.list** %5, align 8, !dbg !79
  %24 = getelementptr inbounds %struct.list, %struct.list* %23, i32 0, i32 0, !dbg !79
  %25 = load i64*, i64** %24, align 8, !dbg !79
  %26 = bitcast i64* %25 to i8*, !dbg !79
  %27 = load %struct.list*, %struct.list** %3, align 8, !dbg !79
  %28 = getelementptr inbounds %struct.list, %struct.list* %27, i32 0, i32 0, !dbg !79
  %29 = load i64*, i64** %28, align 8, !dbg !79
  %30 = bitcast i64* %29 to i8*, !dbg !79
  %31 = load %struct.list*, %struct.list** %3, align 8, !dbg !79
  %32 = getelementptr inbounds %struct.list, %struct.list* %31, i32 0, i32 1, !dbg !79
  %33 = load i64, i64* %32, align 8, !dbg !79
  %34 = mul i64 %33, 8, !dbg !79
  %35 = load %struct.list*, %struct.list** %5, align 8, !dbg !79
  %36 = getelementptr inbounds %struct.list, %struct.list* %35, i32 0, i32 0, !dbg !79
  %37 = load i64*, i64** %36, align 8, !dbg !79
  %38 = bitcast i64* %37 to i8*, !dbg !79
  %39 = call i64 @llvm.objectsize.i64.p0i8(i8* %38, i1 false, i1 true, i1 false), !dbg !79
  %40 = call i8* @__memcpy_chk(i8* %26, i8* %30, i64 %34, i64 %39) #4, !dbg !79
  %41 = load %struct.list*, %struct.list** %5, align 8, !dbg !80
  %42 = getelementptr inbounds %struct.list, %struct.list* %41, i32 0, i32 0, !dbg !80
  %43 = load i64*, i64** %42, align 8, !dbg !80
  %44 = load %struct.list*, %struct.list** %3, align 8, !dbg !80
  %45 = getelementptr inbounds %struct.list, %struct.list* %44, i32 0, i32 1, !dbg !80
  %46 = load i64, i64* %45, align 8, !dbg !80
  %47 = getelementptr inbounds i64, i64* %43, i64 %46, !dbg !80
  %48 = bitcast i64* %47 to i8*, !dbg !80
  %49 = load %struct.list*, %struct.list** %4, align 8, !dbg !80
  %50 = getelementptr inbounds %struct.list, %struct.list* %49, i32 0, i32 0, !dbg !80
  %51 = load i64*, i64** %50, align 8, !dbg !80
  %52 = bitcast i64* %51 to i8*, !dbg !80
  %53 = load %struct.list*, %struct.list** %4, align 8, !dbg !80
  %54 = getelementptr inbounds %struct.list, %struct.list* %53, i32 0, i32 1, !dbg !80
  %55 = load i64, i64* %54, align 8, !dbg !80
  %56 = mul i64 %55, 8, !dbg !80
  %57 = load %struct.list*, %struct.list** %5, align 8, !dbg !80
  %58 = getelementptr inbounds %struct.list, %struct.list* %57, i32 0, i32 0, !dbg !80
  %59 = load i64*, i64** %58, align 8, !dbg !80
  %60 = load %struct.list*, %struct.list** %3, align 8, !dbg !80
  %61 = getelementptr inbounds %struct.list, %struct.list* %60, i32 0, i32 1, !dbg !80
  %62 = load i64, i64* %61, align 8, !dbg !80
  %63 = getelementptr inbounds i64, i64* %59, i64 %62, !dbg !80
  %64 = bitcast i64* %63 to i8*, !dbg !80
  %65 = call i64 @llvm.objectsize.i64.p0i8(i8* %64, i1 false, i1 true, i1 false), !dbg !80
  %66 = call i8* @__memcpy_chk(i8* %48, i8* %52, i64 %56, i64 %65) #4, !dbg !80
  %67 = load %struct.list*, %struct.list** %5, align 8, !dbg !81
  ret %struct.list* %67, !dbg !82
}

; Function Attrs: nounwind
declare i8* @__memcpy_chk(i8*, i8*, i64, i64) #3

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1 immarg, i1 immarg, i1 immarg) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.list* @repeat_list(%struct.list* %0, i64 %1) #0 !dbg !83 {
  %3 = alloca %struct.list*, align 8
  %4 = alloca i64, align 8
  %5 = alloca %struct.list*, align 8
  %6 = alloca i64*, align 8
  store %struct.list* %0, %struct.list** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !86, metadata !DIExpression()), !dbg !87
  store i64 %1, i64* %4, align 8
  call void @llvm.dbg.declare(metadata i64* %4, metadata !88, metadata !DIExpression()), !dbg !89
  call void @llvm.dbg.declare(metadata %struct.list** %5, metadata !90, metadata !DIExpression()), !dbg !91
  %7 = load %struct.list*, %struct.list** %3, align 8, !dbg !92
  %8 = getelementptr inbounds %struct.list, %struct.list* %7, i32 0, i32 1, !dbg !93
  %9 = load i64, i64* %8, align 8, !dbg !93
  %10 = load i64, i64* %4, align 8, !dbg !94
  %11 = mul nsw i64 %9, %10, !dbg !95
  %12 = call %struct.list* @allocate_list(i64 %11), !dbg !96
  store %struct.list* %12, %struct.list** %5, align 8, !dbg !91
  %13 = load %struct.list*, %struct.list** %3, align 8, !dbg !97
  %14 = getelementptr inbounds %struct.list, %struct.list* %13, i32 0, i32 1, !dbg !98
  %15 = load i64, i64* %14, align 8, !dbg !98
  %16 = load i64, i64* %4, align 8, !dbg !99
  %17 = mul nsw i64 %15, %16, !dbg !100
  %18 = load %struct.list*, %struct.list** %5, align 8, !dbg !101
  %19 = getelementptr inbounds %struct.list, %struct.list* %18, i32 0, i32 1, !dbg !102
  store i64 %17, i64* %19, align 8, !dbg !103
  call void @llvm.dbg.declare(metadata i64** %6, metadata !104, metadata !DIExpression()), !dbg !106
  %20 = load %struct.list*, %struct.list** %5, align 8, !dbg !107
  %21 = getelementptr inbounds %struct.list, %struct.list* %20, i32 0, i32 0, !dbg !108
  %22 = load i64*, i64** %21, align 8, !dbg !108
  store i64* %22, i64** %6, align 8, !dbg !106
  br label %23, !dbg !109

23:                                               ; preds = %42, %2
  %24 = load i64, i64* %4, align 8, !dbg !110
  %25 = add nsw i64 %24, -1, !dbg !110
  store i64 %25, i64* %4, align 8, !dbg !110
  %26 = icmp ne i64 %24, 0, !dbg !112
  br i1 %26, label %27, label %48, !dbg !112

27:                                               ; preds = %23
  %28 = load i64*, i64** %6, align 8, !dbg !113
  %29 = bitcast i64* %28 to i8*, !dbg !113
  %30 = load %struct.list*, %struct.list** %3, align 8, !dbg !113
  %31 = getelementptr inbounds %struct.list, %struct.list* %30, i32 0, i32 0, !dbg !113
  %32 = load i64*, i64** %31, align 8, !dbg !113
  %33 = bitcast i64* %32 to i8*, !dbg !113
  %34 = load %struct.list*, %struct.list** %3, align 8, !dbg !113
  %35 = getelementptr inbounds %struct.list, %struct.list* %34, i32 0, i32 1, !dbg !113
  %36 = load i64, i64* %35, align 8, !dbg !113
  %37 = mul i64 %36, 8, !dbg !113
  %38 = load i64*, i64** %6, align 8, !dbg !113
  %39 = bitcast i64* %38 to i8*, !dbg !113
  %40 = call i64 @llvm.objectsize.i64.p0i8(i8* %39, i1 false, i1 true, i1 false), !dbg !113
  %41 = call i8* @__memcpy_chk(i8* %29, i8* %33, i64 %37, i64 %40) #4, !dbg !113
  br label %42, !dbg !113

42:                                               ; preds = %27
  %43 = load %struct.list*, %struct.list** %3, align 8, !dbg !114
  %44 = getelementptr inbounds %struct.list, %struct.list* %43, i32 0, i32 1, !dbg !115
  %45 = load i64, i64* %44, align 8, !dbg !115
  %46 = load i64*, i64** %6, align 8, !dbg !116
  %47 = getelementptr inbounds i64, i64* %46, i64 %45, !dbg !116
  store i64* %47, i64** %6, align 8, !dbg !116
  br label %23, !dbg !117, !llvm.loop !118

48:                                               ; preds = %23
  %49 = load %struct.list*, %struct.list** %5, align 8, !dbg !121
  ret %struct.list* %49, !dbg !122
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @insert_into_list(%struct.list* %0, i64 %1, i64* %2) #0 !dbg !123 {
  %4 = alloca i64, align 8
  %5 = alloca %struct.list*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64*, align 8
  %8 = alloca i64, align 8
  store %struct.list* %0, %struct.list** %5, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %5, metadata !126, metadata !DIExpression()), !dbg !127
  store i64 %1, i64* %6, align 8
  call void @llvm.dbg.declare(metadata i64* %6, metadata !128, metadata !DIExpression()), !dbg !129
  store i64* %2, i64** %7, align 8
  call void @llvm.dbg.declare(metadata i64** %7, metadata !130, metadata !DIExpression()), !dbg !131
  %9 = load %struct.list*, %struct.list** %5, align 8, !dbg !132
  %10 = getelementptr inbounds %struct.list, %struct.list* %9, i32 0, i32 1, !dbg !134
  %11 = load i64, i64* %10, align 8, !dbg !134
  %12 = load i64, i64* %6, align 8, !dbg !135
  %13 = icmp slt i64 %11, %12, !dbg !136
  br i1 %13, label %17, label %14, !dbg !137

14:                                               ; preds = %3
  %15 = load i64, i64* %6, align 8, !dbg !138
  %16 = icmp slt i64 %15, 0, !dbg !139
  br i1 %16, label %17, label %18, !dbg !140

17:                                               ; preds = %14, %3
  store i64 0, i64* %4, align 8, !dbg !141
  br label %77, !dbg !141

18:                                               ; preds = %14
  %19 = load %struct.list*, %struct.list** %5, align 8, !dbg !142
  %20 = getelementptr inbounds %struct.list, %struct.list* %19, i32 0, i32 2, !dbg !144
  %21 = load i64, i64* %20, align 8, !dbg !144
  %22 = load %struct.list*, %struct.list** %5, align 8, !dbg !145
  %23 = getelementptr inbounds %struct.list, %struct.list* %22, i32 0, i32 1, !dbg !146
  %24 = load i64, i64* %23, align 8, !dbg !146
  %25 = icmp eq i64 %21, %24, !dbg !147
  br i1 %25, label %26, label %40, !dbg !148

26:                                               ; preds = %18
  %27 = load %struct.list*, %struct.list** %5, align 8, !dbg !149
  %28 = getelementptr inbounds %struct.list, %struct.list* %27, i32 0, i32 0, !dbg !150
  %29 = load i64*, i64** %28, align 8, !dbg !150
  %30 = bitcast i64* %29 to i8*, !dbg !149
  %31 = load %struct.list*, %struct.list** %5, align 8, !dbg !151
  %32 = getelementptr inbounds %struct.list, %struct.list* %31, i32 0, i32 2, !dbg !152
  %33 = load i64, i64* %32, align 8, !dbg !153
  %34 = mul nsw i64 %33, 2, !dbg !153
  store i64 %34, i64* %32, align 8, !dbg !153
  %35 = mul i64 %34, 8, !dbg !154
  %36 = call i8* @xrealloc(i8* %30, i64 %35), !dbg !155
  %37 = bitcast i8* %36 to i64*, !dbg !155
  %38 = load %struct.list*, %struct.list** %5, align 8, !dbg !156
  %39 = getelementptr inbounds %struct.list, %struct.list* %38, i32 0, i32 0, !dbg !157
  store i64* %37, i64** %39, align 8, !dbg !158
  br label %40, !dbg !156

40:                                               ; preds = %26, %18
  call void @llvm.dbg.declare(metadata i64* %8, metadata !159, metadata !DIExpression()), !dbg !161
  %41 = load %struct.list*, %struct.list** %5, align 8, !dbg !162
  %42 = getelementptr inbounds %struct.list, %struct.list* %41, i32 0, i32 1, !dbg !163
  %43 = load i64, i64* %42, align 8, !dbg !163
  %44 = add nsw i64 %43, 1, !dbg !164
  store i64 %44, i64* %8, align 8, !dbg !161
  br label %45, !dbg !165

45:                                               ; preds = %62, %40
  %46 = load i64, i64* %8, align 8, !dbg !166
  %47 = load i64, i64* %6, align 8, !dbg !168
  %48 = icmp sge i64 %46, %47, !dbg !169
  br i1 %48, label %49, label %65, !dbg !170

49:                                               ; preds = %45
  %50 = load %struct.list*, %struct.list** %5, align 8, !dbg !171
  %51 = getelementptr inbounds %struct.list, %struct.list* %50, i32 0, i32 0, !dbg !173
  %52 = load i64*, i64** %51, align 8, !dbg !173
  %53 = load i64, i64* %8, align 8, !dbg !174
  %54 = sub nsw i64 %53, 1, !dbg !175
  %55 = getelementptr inbounds i64, i64* %52, i64 %54, !dbg !171
  %56 = load i64, i64* %55, align 8, !dbg !171
  %57 = load %struct.list*, %struct.list** %5, align 8, !dbg !176
  %58 = getelementptr inbounds %struct.list, %struct.list* %57, i32 0, i32 0, !dbg !177
  %59 = load i64*, i64** %58, align 8, !dbg !177
  %60 = load i64, i64* %8, align 8, !dbg !178
  %61 = getelementptr inbounds i64, i64* %59, i64 %60, !dbg !176
  store i64 %56, i64* %61, align 8, !dbg !179
  br label %62, !dbg !180

62:                                               ; preds = %49
  %63 = load i64, i64* %8, align 8, !dbg !181
  %64 = add nsw i64 %63, -1, !dbg !181
  store i64 %64, i64* %8, align 8, !dbg !181
  br label %45, !dbg !182, !llvm.loop !183

65:                                               ; preds = %45
  %66 = load i64*, i64** %7, align 8, !dbg !185
  %67 = load i64, i64* %66, align 8, !dbg !186
  %68 = load %struct.list*, %struct.list** %5, align 8, !dbg !187
  %69 = getelementptr inbounds %struct.list, %struct.list* %68, i32 0, i32 0, !dbg !188
  %70 = load i64*, i64** %69, align 8, !dbg !188
  %71 = load i64, i64* %6, align 8, !dbg !189
  %72 = getelementptr inbounds i64, i64* %70, i64 %71, !dbg !187
  store i64 %67, i64* %72, align 8, !dbg !190
  %73 = load %struct.list*, %struct.list** %5, align 8, !dbg !191
  %74 = getelementptr inbounds %struct.list, %struct.list* %73, i32 0, i32 1, !dbg !192
  %75 = load i64, i64* %74, align 8, !dbg !193
  %76 = add nsw i64 %75, 1, !dbg !193
  store i64 %76, i64* %74, align 8, !dbg !193
  store i64 1, i64* %4, align 8, !dbg !194
  br label %77, !dbg !194

77:                                               ; preds = %65, %17
  %78 = load i64, i64* %4, align 8, !dbg !195
  ret i64 %78, !dbg !195
}

declare i8* @xrealloc(i8*, i64) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @delete_from_list(%struct.list* %0, i64* %1, i64 %2) #0 !dbg !196 {
  %4 = alloca i64, align 8
  %5 = alloca %struct.list*, align 8
  %6 = alloca i64*, align 8
  %7 = alloca i64, align 8
  store %struct.list* %0, %struct.list** %5, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %5, metadata !199, metadata !DIExpression()), !dbg !200
  store i64* %1, i64** %6, align 8
  call void @llvm.dbg.declare(metadata i64** %6, metadata !201, metadata !DIExpression()), !dbg !202
  store i64 %2, i64* %7, align 8
  call void @llvm.dbg.declare(metadata i64* %7, metadata !203, metadata !DIExpression()), !dbg !204
  %8 = load %struct.list*, %struct.list** %5, align 8, !dbg !205
  %9 = getelementptr inbounds %struct.list, %struct.list* %8, i32 0, i32 1, !dbg !207
  %10 = load i64, i64* %9, align 8, !dbg !207
  %11 = load i64, i64* %7, align 8, !dbg !208
  %12 = icmp sle i64 %10, %11, !dbg !209
  br i1 %12, label %16, label %13, !dbg !210

13:                                               ; preds = %3
  %14 = load i64, i64* %7, align 8, !dbg !211
  %15 = icmp slt i64 %14, 0, !dbg !212
  br i1 %15, label %16, label %17, !dbg !213

16:                                               ; preds = %13, %3
  store i64 0, i64* %4, align 8, !dbg !214
  br label %57, !dbg !214

17:                                               ; preds = %13
  %18 = load %struct.list*, %struct.list** %5, align 8, !dbg !215
  %19 = getelementptr inbounds %struct.list, %struct.list* %18, i32 0, i32 0, !dbg !216
  %20 = load i64*, i64** %19, align 8, !dbg !216
  %21 = load i64, i64* %7, align 8, !dbg !217
  %22 = getelementptr inbounds i64, i64* %20, i64 %21, !dbg !215
  %23 = load i64, i64* %22, align 8, !dbg !215
  %24 = load i64*, i64** %6, align 8, !dbg !218
  store i64 %23, i64* %24, align 8, !dbg !219
  %25 = load %struct.list*, %struct.list** %5, align 8, !dbg !220
  %26 = getelementptr inbounds %struct.list, %struct.list* %25, i32 0, i32 0, !dbg !220
  %27 = load i64*, i64** %26, align 8, !dbg !220
  %28 = load i64, i64* %7, align 8, !dbg !220
  %29 = getelementptr inbounds i64, i64* %27, i64 %28, !dbg !220
  %30 = getelementptr inbounds i64, i64* %29, i64 -1, !dbg !220
  %31 = bitcast i64* %30 to i8*, !dbg !220
  %32 = load %struct.list*, %struct.list** %5, align 8, !dbg !220
  %33 = getelementptr inbounds %struct.list, %struct.list* %32, i32 0, i32 0, !dbg !220
  %34 = load i64*, i64** %33, align 8, !dbg !220
  %35 = load i64, i64* %7, align 8, !dbg !220
  %36 = getelementptr inbounds i64, i64* %34, i64 %35, !dbg !220
  %37 = bitcast i64* %36 to i8*, !dbg !220
  %38 = load %struct.list*, %struct.list** %5, align 8, !dbg !220
  %39 = getelementptr inbounds %struct.list, %struct.list* %38, i32 0, i32 1, !dbg !220
  %40 = load i64, i64* %39, align 8, !dbg !220
  %41 = load i64, i64* %7, align 8, !dbg !220
  %42 = sub nsw i64 %40, %41, !dbg !220
  %43 = mul i64 8, %42, !dbg !220
  %44 = load %struct.list*, %struct.list** %5, align 8, !dbg !220
  %45 = getelementptr inbounds %struct.list, %struct.list* %44, i32 0, i32 0, !dbg !220
  %46 = load i64*, i64** %45, align 8, !dbg !220
  %47 = load i64, i64* %7, align 8, !dbg !220
  %48 = getelementptr inbounds i64, i64* %46, i64 %47, !dbg !220
  %49 = getelementptr inbounds i64, i64* %48, i64 -1, !dbg !220
  %50 = bitcast i64* %49 to i8*, !dbg !220
  %51 = call i64 @llvm.objectsize.i64.p0i8(i8* %50, i1 false, i1 true, i1 false), !dbg !220
  %52 = call i8* @__memmove_chk(i8* %31, i8* %37, i64 %43, i64 %51) #4, !dbg !220
  %53 = load %struct.list*, %struct.list** %5, align 8, !dbg !221
  %54 = getelementptr inbounds %struct.list, %struct.list* %53, i32 0, i32 1, !dbg !222
  %55 = load i64, i64* %54, align 8, !dbg !223
  %56 = add nsw i64 %55, -1, !dbg !223
  store i64 %56, i64* %54, align 8, !dbg !223
  store i64 1, i64* %4, align 8, !dbg !224
  br label %57, !dbg !224

57:                                               ; preds = %17, %16
  %58 = load i64, i64* %4, align 8, !dbg !225
  ret i64 %58, !dbg !225
}

; Function Attrs: nounwind
declare i8* @__memmove_chk(i8*, i8*, i64, i64) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @push_into_list(%struct.list* %0, i64* %1) #0 !dbg !226 {
  %3 = alloca %struct.list*, align 8
  %4 = alloca i64*, align 8
  store %struct.list* %0, %struct.list** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !229, metadata !DIExpression()), !dbg !230
  store i64* %1, i64** %4, align 8
  call void @llvm.dbg.declare(metadata i64** %4, metadata !231, metadata !DIExpression()), !dbg !232
  %5 = load %struct.list*, %struct.list** %3, align 8, !dbg !233
  %6 = getelementptr inbounds %struct.list, %struct.list* %5, i32 0, i32 2, !dbg !235
  %7 = load i64, i64* %6, align 8, !dbg !235
  %8 = load %struct.list*, %struct.list** %3, align 8, !dbg !236
  %9 = getelementptr inbounds %struct.list, %struct.list* %8, i32 0, i32 1, !dbg !237
  %10 = load i64, i64* %9, align 8, !dbg !237
  %11 = icmp eq i64 %7, %10, !dbg !238
  br i1 %11, label %12, label %26, !dbg !239

12:                                               ; preds = %2
  %13 = load %struct.list*, %struct.list** %3, align 8, !dbg !240
  %14 = getelementptr inbounds %struct.list, %struct.list* %13, i32 0, i32 0, !dbg !241
  %15 = load i64*, i64** %14, align 8, !dbg !241
  %16 = bitcast i64* %15 to i8*, !dbg !240
  %17 = load %struct.list*, %struct.list** %3, align 8, !dbg !242
  %18 = getelementptr inbounds %struct.list, %struct.list* %17, i32 0, i32 2, !dbg !243
  %19 = load i64, i64* %18, align 8, !dbg !244
  %20 = mul nsw i64 %19, 2, !dbg !244
  store i64 %20, i64* %18, align 8, !dbg !244
  %21 = mul i64 %20, 8, !dbg !245
  %22 = call i8* @xrealloc(i8* %16, i64 %21), !dbg !246
  %23 = bitcast i8* %22 to i64*, !dbg !246
  %24 = load %struct.list*, %struct.list** %3, align 8, !dbg !247
  %25 = getelementptr inbounds %struct.list, %struct.list* %24, i32 0, i32 0, !dbg !248
  store i64* %23, i64** %25, align 8, !dbg !249
  br label %26, !dbg !247

26:                                               ; preds = %12, %2
  %27 = load i64*, i64** %4, align 8, !dbg !250
  %28 = load i64, i64* %27, align 8, !dbg !251
  %29 = load %struct.list*, %struct.list** %3, align 8, !dbg !252
  %30 = getelementptr inbounds %struct.list, %struct.list* %29, i32 0, i32 0, !dbg !253
  %31 = load i64*, i64** %30, align 8, !dbg !253
  %32 = load %struct.list*, %struct.list** %3, align 8, !dbg !254
  %33 = getelementptr inbounds %struct.list, %struct.list* %32, i32 0, i32 1, !dbg !255
  %34 = load i64, i64* %33, align 8, !dbg !256
  %35 = add nsw i64 %34, 1, !dbg !256
  store i64 %35, i64* %33, align 8, !dbg !256
  %36 = getelementptr inbounds i64, i64* %31, i64 %34, !dbg !252
  store i64 %28, i64* %36, align 8, !dbg !257
  ret void, !dbg !258
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @pop_from_list(%struct.list* %0, i64* %1) #0 !dbg !259 {
  %3 = alloca %struct.list*, align 8
  %4 = alloca i64*, align 8
  store %struct.list* %0, %struct.list** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.list** %3, metadata !260, metadata !DIExpression()), !dbg !261
  store i64* %1, i64** %4, align 8
  call void @llvm.dbg.declare(metadata i64** %4, metadata !262, metadata !DIExpression()), !dbg !263
  %5 = load %struct.list*, %struct.list** %3, align 8, !dbg !264
  %6 = getelementptr inbounds %struct.list, %struct.list* %5, i32 0, i32 1, !dbg !266
  %7 = load i64, i64* %6, align 8, !dbg !266
  %8 = icmp ne i64 %7, 0, !dbg !264
  br i1 %8, label %11, label %9, !dbg !267

9:                                                ; preds = %2
  %10 = call %struct._str* @create_str_from_borrowed(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str, i64 0, i64 0)), !dbg !268
  call void @abort_msg(%struct._str* %10), !dbg !269
  br label %11, !dbg !269

11:                                               ; preds = %9, %2
  %12 = load %struct.list*, %struct.list** %3, align 8, !dbg !270
  %13 = getelementptr inbounds %struct.list, %struct.list* %12, i32 0, i32 0, !dbg !271
  %14 = load i64*, i64** %13, align 8, !dbg !271
  %15 = load %struct.list*, %struct.list** %3, align 8, !dbg !272
  %16 = getelementptr inbounds %struct.list, %struct.list* %15, i32 0, i32 1, !dbg !273
  %17 = load i64, i64* %16, align 8, !dbg !274
  %18 = add nsw i64 %17, -1, !dbg !274
  store i64 %18, i64* %16, align 8, !dbg !274
  %19 = getelementptr inbounds i64, i64* %14, i64 %18, !dbg !270
  %20 = load i64, i64* %19, align 8, !dbg !270
  %21 = load i64*, i64** %4, align 8, !dbg !275
  store i64 %20, i64* %21, align 8, !dbg !276
  ret void, !dbg !277
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
!30 = !DILocation(line: 9, column: 6, scope: !31)
!31 = distinct !DILexicalBlock(scope: !13, file: !10, line: 9, column: 6)
!32 = !DILocation(line: 9, column: 10, scope: !31)
!33 = !DILocation(line: 9, column: 6, scope: !13)
!34 = !DILocation(line: 9, column: 20, scope: !31)
!35 = !DILocation(line: 9, column: 16, scope: !31)
!36 = !DILocalVariable(name: "l", scope: !13, file: !10, line: 11, type: !16)
!37 = !DILocation(line: 11, column: 8, scope: !13)
!38 = !DILocation(line: 11, column: 12, scope: !13)
!39 = !DILocation(line: 13, column: 26, scope: !13)
!40 = !DILocation(line: 13, column: 25, scope: !13)
!41 = !DILocation(line: 13, column: 11, scope: !13)
!42 = !DILocation(line: 13, column: 2, scope: !13)
!43 = !DILocation(line: 13, column: 5, scope: !13)
!44 = !DILocation(line: 13, column: 9, scope: !13)
!45 = !DILocation(line: 14, column: 2, scope: !13)
!46 = !DILocation(line: 14, column: 5, scope: !13)
!47 = !DILocation(line: 14, column: 9, scope: !13)
!48 = !DILocation(line: 15, column: 11, scope: !13)
!49 = !DILocation(line: 15, column: 2, scope: !13)
!50 = !DILocation(line: 15, column: 5, scope: !13)
!51 = !DILocation(line: 15, column: 9, scope: !13)
!52 = !DILocation(line: 17, column: 9, scope: !13)
!53 = !DILocation(line: 17, column: 2, scope: !13)
!54 = distinct !DISubprogram(name: "concat_lists", scope: !10, file: !10, line: 20, type: !55, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!55 = !DISubroutineType(types: !56)
!56 = !{!16, !57, !57}
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !58, size: 64)
!58 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !17)
!59 = !DILocalVariable(name: "lhs", arg: 1, scope: !54, file: !10, line: 20, type: !57)
!60 = !DILocation(line: 20, column: 32, scope: !54)
!61 = !DILocalVariable(name: "rhs", arg: 2, scope: !54, file: !10, line: 20, type: !57)
!62 = !DILocation(line: 20, column: 49, scope: !54)
!63 = !DILocalVariable(name: "l", scope: !54, file: !10, line: 21, type: !16)
!64 = !DILocation(line: 21, column: 8, scope: !54)
!65 = !DILocation(line: 21, column: 26, scope: !54)
!66 = !DILocation(line: 21, column: 31, scope: !54)
!67 = !DILocation(line: 21, column: 37, scope: !54)
!68 = !DILocation(line: 21, column: 42, scope: !54)
!69 = !DILocation(line: 21, column: 35, scope: !54)
!70 = !DILocation(line: 21, column: 12, scope: !54)
!71 = !DILocation(line: 22, column: 11, scope: !54)
!72 = !DILocation(line: 22, column: 16, scope: !54)
!73 = !DILocation(line: 22, column: 22, scope: !54)
!74 = !DILocation(line: 22, column: 27, scope: !54)
!75 = !DILocation(line: 22, column: 20, scope: !54)
!76 = !DILocation(line: 22, column: 2, scope: !54)
!77 = !DILocation(line: 22, column: 5, scope: !54)
!78 = !DILocation(line: 22, column: 9, scope: !54)
!79 = !DILocation(line: 24, column: 2, scope: !54)
!80 = !DILocation(line: 25, column: 2, scope: !54)
!81 = !DILocation(line: 27, column: 9, scope: !54)
!82 = !DILocation(line: 27, column: 2, scope: !54)
!83 = distinct !DISubprogram(name: "repeat_list", scope: !10, file: !10, line: 31, type: !84, scopeLine: 31, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!84 = !DISubroutineType(types: !85)
!85 = !{!16, !57, !23}
!86 = !DILocalVariable(name: "src", arg: 1, scope: !83, file: !10, line: 31, type: !57)
!87 = !DILocation(line: 31, column: 31, scope: !83)
!88 = !DILocalVariable(name: "amnt", arg: 2, scope: !83, file: !10, line: 31, type: !23)
!89 = !DILocation(line: 31, column: 39, scope: !83)
!90 = !DILocalVariable(name: "l", scope: !83, file: !10, line: 32, type: !16)
!91 = !DILocation(line: 32, column: 8, scope: !83)
!92 = !DILocation(line: 32, column: 26, scope: !83)
!93 = !DILocation(line: 32, column: 31, scope: !83)
!94 = !DILocation(line: 32, column: 37, scope: !83)
!95 = !DILocation(line: 32, column: 35, scope: !83)
!96 = !DILocation(line: 32, column: 12, scope: !83)
!97 = !DILocation(line: 33, column: 11, scope: !83)
!98 = !DILocation(line: 33, column: 16, scope: !83)
!99 = !DILocation(line: 33, column: 22, scope: !83)
!100 = !DILocation(line: 33, column: 20, scope: !83)
!101 = !DILocation(line: 33, column: 2, scope: !83)
!102 = !DILocation(line: 33, column: 5, scope: !83)
!103 = !DILocation(line: 33, column: 9, scope: !83)
!104 = !DILocalVariable(name: "ptr", scope: !105, file: !10, line: 35, type: !22)
!105 = distinct !DILexicalBlock(scope: !83, file: !10, line: 35, column: 2)
!106 = !DILocation(line: 35, column: 11, scope: !105)
!107 = !DILocation(line: 35, column: 17, scope: !105)
!108 = !DILocation(line: 35, column: 20, scope: !105)
!109 = !DILocation(line: 35, column: 7, scope: !105)
!110 = !DILocation(line: 35, column: 29, scope: !111)
!111 = distinct !DILexicalBlock(scope: !105, file: !10, line: 35, column: 2)
!112 = !DILocation(line: 35, column: 2, scope: !105)
!113 = !DILocation(line: 36, column: 3, scope: !111)
!114 = !DILocation(line: 35, column: 40, scope: !111)
!115 = !DILocation(line: 35, column: 45, scope: !111)
!116 = !DILocation(line: 35, column: 37, scope: !111)
!117 = !DILocation(line: 35, column: 2, scope: !111)
!118 = distinct !{!118, !112, !119, !120}
!119 = !DILocation(line: 36, column: 3, scope: !105)
!120 = !{!"llvm.loop.mustprogress"}
!121 = !DILocation(line: 38, column: 9, scope: !83)
!122 = !DILocation(line: 38, column: 2, scope: !83)
!123 = distinct !DISubprogram(name: "insert_into_list", scope: !10, file: !10, line: 41, type: !124, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!124 = !DISubroutineType(types: !125)
!125 = !{!23, !16, !23, !22}
!126 = !DILocalVariable(name: "l", arg: 1, scope: !123, file: !10, line: 41, type: !16)
!127 = !DILocation(line: 41, column: 27, scope: !123)
!128 = !DILocalVariable(name: "pos", arg: 2, scope: !123, file: !10, line: 41, type: !23)
!129 = !DILocation(line: 41, column: 33, scope: !123)
!130 = !DILocalVariable(name: "ele", arg: 3, scope: !123, file: !10, line: 41, type: !22)
!131 = !DILocation(line: 41, column: 42, scope: !123)
!132 = !DILocation(line: 42, column: 6, scope: !133)
!133 = distinct !DILexicalBlock(scope: !123, file: !10, line: 42, column: 6)
!134 = !DILocation(line: 42, column: 9, scope: !133)
!135 = !DILocation(line: 42, column: 15, scope: !133)
!136 = !DILocation(line: 42, column: 13, scope: !133)
!137 = !DILocation(line: 42, column: 19, scope: !133)
!138 = !DILocation(line: 42, column: 22, scope: !133)
!139 = !DILocation(line: 42, column: 26, scope: !133)
!140 = !DILocation(line: 42, column: 6, scope: !123)
!141 = !DILocation(line: 43, column: 3, scope: !133)
!142 = !DILocation(line: 45, column: 6, scope: !143)
!143 = distinct !DILexicalBlock(scope: !123, file: !10, line: 45, column: 6)
!144 = !DILocation(line: 45, column: 9, scope: !143)
!145 = !DILocation(line: 45, column: 16, scope: !143)
!146 = !DILocation(line: 45, column: 19, scope: !143)
!147 = !DILocation(line: 45, column: 13, scope: !143)
!148 = !DILocation(line: 45, column: 6, scope: !123)
!149 = !DILocation(line: 46, column: 21, scope: !143)
!150 = !DILocation(line: 46, column: 24, scope: !143)
!151 = !DILocation(line: 46, column: 30, scope: !143)
!152 = !DILocation(line: 46, column: 33, scope: !143)
!153 = !DILocation(line: 46, column: 37, scope: !143)
!154 = !DILocation(line: 46, column: 42, scope: !143)
!155 = !DILocation(line: 46, column: 12, scope: !143)
!156 = !DILocation(line: 46, column: 3, scope: !143)
!157 = !DILocation(line: 46, column: 6, scope: !143)
!158 = !DILocation(line: 46, column: 10, scope: !143)
!159 = !DILocalVariable(name: "i", scope: !160, file: !10, line: 48, type: !23)
!160 = distinct !DILexicalBlock(scope: !123, file: !10, line: 48, column: 2)
!161 = !DILocation(line: 48, column: 10, scope: !160)
!162 = !DILocation(line: 48, column: 14, scope: !160)
!163 = !DILocation(line: 48, column: 17, scope: !160)
!164 = !DILocation(line: 48, column: 21, scope: !160)
!165 = !DILocation(line: 48, column: 7, scope: !160)
!166 = !DILocation(line: 48, column: 26, scope: !167)
!167 = distinct !DILexicalBlock(scope: !160, file: !10, line: 48, column: 2)
!168 = !DILocation(line: 48, column: 31, scope: !167)
!169 = !DILocation(line: 48, column: 28, scope: !167)
!170 = !DILocation(line: 48, column: 2, scope: !160)
!171 = !DILocation(line: 49, column: 15, scope: !172)
!172 = distinct !DILexicalBlock(scope: !167, file: !10, line: 48, column: 41)
!173 = !DILocation(line: 49, column: 18, scope: !172)
!174 = !DILocation(line: 49, column: 22, scope: !172)
!175 = !DILocation(line: 49, column: 23, scope: !172)
!176 = !DILocation(line: 49, column: 3, scope: !172)
!177 = !DILocation(line: 49, column: 6, scope: !172)
!178 = !DILocation(line: 49, column: 10, scope: !172)
!179 = !DILocation(line: 49, column: 13, scope: !172)
!180 = !DILocation(line: 51, column: 2, scope: !172)
!181 = !DILocation(line: 48, column: 36, scope: !167)
!182 = !DILocation(line: 48, column: 2, scope: !167)
!183 = distinct !{!183, !170, !184, !120}
!184 = !DILocation(line: 51, column: 2, scope: !160)
!185 = !DILocation(line: 55, column: 17, scope: !123)
!186 = !DILocation(line: 55, column: 16, scope: !123)
!187 = !DILocation(line: 55, column: 2, scope: !123)
!188 = !DILocation(line: 55, column: 5, scope: !123)
!189 = !DILocation(line: 55, column: 9, scope: !123)
!190 = !DILocation(line: 55, column: 14, scope: !123)
!191 = !DILocation(line: 56, column: 2, scope: !123)
!192 = !DILocation(line: 56, column: 5, scope: !123)
!193 = !DILocation(line: 56, column: 8, scope: !123)
!194 = !DILocation(line: 58, column: 2, scope: !123)
!195 = !DILocation(line: 59, column: 1, scope: !123)
!196 = distinct !DISubprogram(name: "delete_from_list", scope: !10, file: !10, line: 61, type: !197, scopeLine: 61, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!197 = !DISubroutineType(types: !198)
!198 = !{!23, !16, !22, !23}
!199 = !DILocalVariable(name: "l", arg: 1, scope: !196, file: !10, line: 61, type: !16)
!200 = !DILocation(line: 61, column: 27, scope: !196)
!201 = !DILocalVariable(name: "dst", arg: 2, scope: !196, file: !10, line: 61, type: !22)
!202 = !DILocation(line: 61, column: 34, scope: !196)
!203 = !DILocalVariable(name: "pos", arg: 3, scope: !196, file: !10, line: 61, type: !23)
!204 = !DILocation(line: 61, column: 42, scope: !196)
!205 = !DILocation(line: 62, column: 6, scope: !206)
!206 = distinct !DILexicalBlock(scope: !196, file: !10, line: 62, column: 6)
!207 = !DILocation(line: 62, column: 9, scope: !206)
!208 = !DILocation(line: 62, column: 16, scope: !206)
!209 = !DILocation(line: 62, column: 13, scope: !206)
!210 = !DILocation(line: 62, column: 20, scope: !206)
!211 = !DILocation(line: 62, column: 23, scope: !206)
!212 = !DILocation(line: 62, column: 27, scope: !206)
!213 = !DILocation(line: 62, column: 6, scope: !196)
!214 = !DILocation(line: 63, column: 3, scope: !206)
!215 = !DILocation(line: 65, column: 9, scope: !196)
!216 = !DILocation(line: 65, column: 12, scope: !196)
!217 = !DILocation(line: 65, column: 16, scope: !196)
!218 = !DILocation(line: 65, column: 3, scope: !196)
!219 = !DILocation(line: 65, column: 7, scope: !196)
!220 = !DILocation(line: 66, column: 2, scope: !196)
!221 = !DILocation(line: 68, column: 2, scope: !196)
!222 = !DILocation(line: 68, column: 5, scope: !196)
!223 = !DILocation(line: 68, column: 8, scope: !196)
!224 = !DILocation(line: 70, column: 2, scope: !196)
!225 = !DILocation(line: 71, column: 1, scope: !196)
!226 = distinct !DISubprogram(name: "push_into_list", scope: !10, file: !10, line: 73, type: !227, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!227 = !DISubroutineType(types: !228)
!228 = !{null, !16, !22}
!229 = !DILocalVariable(name: "l", arg: 1, scope: !226, file: !10, line: 73, type: !16)
!230 = !DILocation(line: 73, column: 27, scope: !226)
!231 = !DILocalVariable(name: "ele", arg: 2, scope: !226, file: !10, line: 73, type: !22)
!232 = !DILocation(line: 73, column: 34, scope: !226)
!233 = !DILocation(line: 74, column: 6, scope: !234)
!234 = distinct !DILexicalBlock(scope: !226, file: !10, line: 74, column: 6)
!235 = !DILocation(line: 74, column: 9, scope: !234)
!236 = !DILocation(line: 74, column: 16, scope: !234)
!237 = !DILocation(line: 74, column: 19, scope: !234)
!238 = !DILocation(line: 74, column: 13, scope: !234)
!239 = !DILocation(line: 74, column: 6, scope: !226)
!240 = !DILocation(line: 75, column: 21, scope: !234)
!241 = !DILocation(line: 75, column: 24, scope: !234)
!242 = !DILocation(line: 75, column: 30, scope: !234)
!243 = !DILocation(line: 75, column: 33, scope: !234)
!244 = !DILocation(line: 75, column: 37, scope: !234)
!245 = !DILocation(line: 75, column: 42, scope: !234)
!246 = !DILocation(line: 75, column: 12, scope: !234)
!247 = !DILocation(line: 75, column: 3, scope: !234)
!248 = !DILocation(line: 75, column: 6, scope: !234)
!249 = !DILocation(line: 75, column: 10, scope: !234)
!250 = !DILocation(line: 76, column: 22, scope: !226)
!251 = !DILocation(line: 76, column: 21, scope: !226)
!252 = !DILocation(line: 76, column: 2, scope: !226)
!253 = !DILocation(line: 76, column: 5, scope: !226)
!254 = !DILocation(line: 76, column: 9, scope: !226)
!255 = !DILocation(line: 76, column: 12, scope: !226)
!256 = !DILocation(line: 76, column: 15, scope: !226)
!257 = !DILocation(line: 76, column: 19, scope: !226)
!258 = !DILocation(line: 77, column: 1, scope: !226)
!259 = distinct !DISubprogram(name: "pop_from_list", scope: !10, file: !10, line: 79, type: !227, scopeLine: 79, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!260 = !DILocalVariable(name: "l", arg: 1, scope: !259, file: !10, line: 79, type: !16)
!261 = !DILocation(line: 79, column: 26, scope: !259)
!262 = !DILocalVariable(name: "out", arg: 2, scope: !259, file: !10, line: 79, type: !22)
!263 = !DILocation(line: 79, column: 33, scope: !259)
!264 = !DILocation(line: 80, column: 7, scope: !265)
!265 = distinct !DILexicalBlock(scope: !259, file: !10, line: 80, column: 6)
!266 = !DILocation(line: 80, column: 10, scope: !265)
!267 = !DILocation(line: 80, column: 6, scope: !259)
!268 = !DILocation(line: 81, column: 13, scope: !265)
!269 = !DILocation(line: 81, column: 3, scope: !265)
!270 = !DILocation(line: 83, column: 9, scope: !259)
!271 = !DILocation(line: 83, column: 12, scope: !259)
!272 = !DILocation(line: 83, column: 18, scope: !259)
!273 = !DILocation(line: 83, column: 21, scope: !259)
!274 = !DILocation(line: 83, column: 16, scope: !259)
!275 = !DILocation(line: 83, column: 3, scope: !259)
!276 = !DILocation(line: 83, column: 7, scope: !259)
!277 = !DILocation(line: 84, column: 1, scope: !259)
