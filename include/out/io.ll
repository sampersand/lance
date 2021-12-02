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

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.io* @open_io(%struct._str* %0, %struct._str* %1) #0 !dbg !15 {
  %3 = alloca %struct._str*, align 8
  %4 = alloca %struct._str*, align 8
  %5 = alloca %struct.io*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  store %struct._str* %0, %struct._str** %3, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %3, metadata !98, metadata !DIExpression()), !dbg !99
  store %struct._str* %1, %struct._str** %4, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !100, metadata !DIExpression()), !dbg !101
  call void @llvm.dbg.declare(metadata %struct.io** %5, metadata !102, metadata !DIExpression()), !dbg !103
  %9 = call i8* @xmalloc(i64 24), !dbg !104
  %10 = bitcast i8* %9 to %struct.io*, !dbg !104
  store %struct.io* %10, %struct.io** %5, align 8, !dbg !103
  %11 = load %struct._str*, %struct._str** %3, align 8, !dbg !105
  %12 = load %struct.io*, %struct.io** %5, align 8, !dbg !106
  %13 = getelementptr inbounds %struct.io, %struct.io* %12, i32 0, i32 0, !dbg !107
  store %struct._str* %11, %struct._str** %13, align 8, !dbg !108
  %14 = load %struct._str*, %struct._str** %4, align 8, !dbg !109
  %15 = load %struct.io*, %struct.io** %5, align 8, !dbg !110
  %16 = getelementptr inbounds %struct.io, %struct.io* %15, i32 0, i32 1, !dbg !111
  store %struct._str* %14, %struct._str** %16, align 8, !dbg !112
  %17 = load %struct._str*, %struct._str** %3, align 8, !dbg !113
  %18 = getelementptr inbounds %struct._str, %struct._str* %17, i32 0, i32 1, !dbg !114
  %19 = load i64, i64* %18, align 8, !dbg !114
  %20 = add nsw i64 %19, 1, !dbg !115
  %21 = call i8* @llvm.stacksave(), !dbg !116
  store i8* %21, i8** %6, align 8, !dbg !116
  %22 = alloca i8, i64 %20, align 1, !dbg !116
  store i64 %20, i64* %7, align 8, !dbg !116
  call void @llvm.dbg.declare(metadata i64* %7, metadata !117, metadata !DIExpression()), !dbg !119
  call void @llvm.dbg.declare(metadata i8* %22, metadata !120, metadata !DIExpression()), !dbg !124
  %23 = load %struct._str*, %struct._str** %3, align 8, !dbg !125
  %24 = getelementptr inbounds %struct._str, %struct._str* %23, i32 0, i32 0, !dbg !125
  %25 = load i8*, i8** %24, align 8, !dbg !125
  %26 = load %struct._str*, %struct._str** %3, align 8, !dbg !125
  %27 = getelementptr inbounds %struct._str, %struct._str* %26, i32 0, i32 1, !dbg !125
  %28 = load i64, i64* %27, align 8, !dbg !125
  %29 = call i64 @llvm.objectsize.i64.p0i8(i8* %22, i1 false, i1 true, i1 false), !dbg !125
  %30 = call i8* @__memcpy_chk(i8* %22, i8* %25, i64 %28, i64 %29) #5, !dbg !125
  %31 = load %struct._str*, %struct._str** %3, align 8, !dbg !126
  %32 = getelementptr inbounds %struct._str, %struct._str* %31, i32 0, i32 1, !dbg !127
  %33 = load i64, i64* %32, align 8, !dbg !127
  %34 = getelementptr inbounds i8, i8* %22, i64 %33, !dbg !128
  store i8 0, i8* %34, align 1, !dbg !129
  %35 = load %struct._str*, %struct._str** %4, align 8, !dbg !130
  %36 = getelementptr inbounds %struct._str, %struct._str* %35, i32 0, i32 1, !dbg !131
  %37 = load i64, i64* %36, align 8, !dbg !131
  %38 = add nsw i64 %37, 1, !dbg !132
  %39 = alloca i8, i64 %38, align 1, !dbg !133
  store i64 %38, i64* %8, align 8, !dbg !133
  call void @llvm.dbg.declare(metadata i64* %8, metadata !134, metadata !DIExpression()), !dbg !119
  call void @llvm.dbg.declare(metadata i8* %39, metadata !135, metadata !DIExpression()), !dbg !139
  %40 = load %struct._str*, %struct._str** %4, align 8, !dbg !140
  %41 = getelementptr inbounds %struct._str, %struct._str* %40, i32 0, i32 0, !dbg !140
  %42 = load i8*, i8** %41, align 8, !dbg !140
  %43 = load %struct._str*, %struct._str** %4, align 8, !dbg !140
  %44 = getelementptr inbounds %struct._str, %struct._str* %43, i32 0, i32 1, !dbg !140
  %45 = load i64, i64* %44, align 8, !dbg !140
  %46 = call i64 @llvm.objectsize.i64.p0i8(i8* %39, i1 false, i1 true, i1 false), !dbg !140
  %47 = call i8* @__memcpy_chk(i8* %39, i8* %42, i64 %45, i64 %46) #5, !dbg !140
  %48 = load %struct._str*, %struct._str** %4, align 8, !dbg !141
  %49 = getelementptr inbounds %struct._str, %struct._str* %48, i32 0, i32 1, !dbg !142
  %50 = load i64, i64* %49, align 8, !dbg !142
  %51 = getelementptr inbounds i8, i8* %39, i64 %50, !dbg !143
  store i8 0, i8* %51, align 1, !dbg !144
  %52 = call %struct.__sFILE* @"\01_fopen"(i8* %22, i8* %39), !dbg !145
  %53 = load %struct.io*, %struct.io** %5, align 8, !dbg !147
  %54 = getelementptr inbounds %struct.io, %struct.io* %53, i32 0, i32 2, !dbg !148
  store %struct.__sFILE* %52, %struct.__sFILE** %54, align 8, !dbg !149
  %55 = icmp ne %struct.__sFILE* %52, null, !dbg !149
  br i1 %55, label %58, label %56, !dbg !150

56:                                               ; preds = %2
  %57 = call %struct._str* @create_str_from_borrowed(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0)), !dbg !151
  call void @abort_msg(%struct._str* %57), !dbg !152
  br label %58, !dbg !152

58:                                               ; preds = %56, %2
  %59 = load %struct.io*, %struct.io** %5, align 8, !dbg !153
  %60 = load i8*, i8** %6, align 8, !dbg !154
  call void @llvm.stackrestore(i8* %60), !dbg !154
  ret %struct.io* %59, !dbg !154
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i8* @xmalloc(i64) #2

; Function Attrs: nofree nosync nounwind willreturn
declare i8* @llvm.stacksave() #3

; Function Attrs: nounwind
declare i8* @__memcpy_chk(i8*, i8*, i64, i64) #4

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1 immarg, i1 immarg, i1 immarg) #1

declare %struct.__sFILE* @"\01_fopen"(i8*, i8*) #2

declare void @abort_msg(%struct._str*) #2

declare %struct._str* @create_str_from_borrowed(i8*) #2

; Function Attrs: nofree nosync nounwind willreturn
declare void @llvm.stackrestore(i8*) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @readline_io(%struct.io* %0) #0 !dbg !155 {
  %2 = alloca %struct._str*, align 8
  %3 = alloca %struct.io*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i64, align 8
  %6 = alloca %struct._str*, align 8
  store %struct.io* %0, %struct.io** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.io** %3, metadata !158, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.declare(metadata i8** %4, metadata !160, metadata !DIExpression()), !dbg !161
  store i8* null, i8** %4, align 8, !dbg !161
  call void @llvm.dbg.declare(metadata i64* %5, metadata !162, metadata !DIExpression()), !dbg !166
  %7 = load %struct.io*, %struct.io** %3, align 8, !dbg !167
  %8 = getelementptr inbounds %struct.io, %struct.io* %7, i32 0, i32 2, !dbg !169
  %9 = load %struct.__sFILE*, %struct.__sFILE** %8, align 8, !dbg !169
  %10 = call i8* @fgetln(%struct.__sFILE* %9, i64* %5), !dbg !170
  store i8* %10, i8** %4, align 8, !dbg !171
  %11 = icmp eq i8* %10, null, !dbg !172
  br i1 %11, label %12, label %22, !dbg !173

12:                                               ; preds = %1
  %13 = load %struct.io*, %struct.io** %3, align 8, !dbg !174
  %14 = getelementptr inbounds %struct.io, %struct.io* %13, i32 0, i32 2, !dbg !177
  %15 = load %struct.__sFILE*, %struct.__sFILE** %14, align 8, !dbg !177
  %16 = call i32 @feof(%struct.__sFILE* %15), !dbg !178
  %17 = icmp ne i32 %16, 0, !dbg !178
  br i1 %17, label %18, label %20, !dbg !179

18:                                               ; preds = %12
  %19 = call %struct._str* @allocate_str(i64 0), !dbg !180
  store %struct._str* %19, %struct._str** %2, align 8, !dbg !181
  br label %31, !dbg !181

20:                                               ; preds = %12
  %21 = call %struct._str* @create_str_from_borrowed(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.1, i64 0, i64 0)), !dbg !182
  call void @abort_msg(%struct._str* %21), !dbg !183
  br label %22, !dbg !184

22:                                               ; preds = %20, %1
  call void @llvm.dbg.declare(metadata %struct._str** %6, metadata !185, metadata !DIExpression()), !dbg !186
  %23 = load i64, i64* %5, align 8, !dbg !187
  %24 = call %struct._str* @allocate_str(i64 %23), !dbg !188
  store %struct._str* %24, %struct._str** %6, align 8, !dbg !186
  %25 = load i8*, i8** %4, align 8, !dbg !189
  %26 = load i64, i64* %5, align 8, !dbg !190
  %27 = call i8* @strndup(i8* %25, i64 %26), !dbg !191
  %28 = load %struct._str*, %struct._str** %6, align 8, !dbg !192
  %29 = getelementptr inbounds %struct._str, %struct._str* %28, i32 0, i32 0, !dbg !193
  store i8* %27, i8** %29, align 8, !dbg !194
  %30 = load %struct._str*, %struct._str** %6, align 8, !dbg !195
  store %struct._str* %30, %struct._str** %2, align 8, !dbg !196
  br label %31, !dbg !196

31:                                               ; preds = %22, %18
  %32 = load %struct._str*, %struct._str** %2, align 8, !dbg !197
  ret %struct._str* %32, !dbg !197
}

declare i8* @fgetln(%struct.__sFILE*, i64*) #2

declare i32 @feof(%struct.__sFILE*) #2

declare %struct._str* @allocate_str(i64) #2

declare i8* @strndup(i8*, i64) #2

attributes #0 = { noinline nounwind optnone ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nofree nosync nounwind willreturn }
attributes #4 = { nounwind "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }

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
!10 = !DIFile(filename: "io.c", directory: "/Users/sampersand/code/lance/include")
!11 = !{}
!12 = !{!13}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!14 = !{!"Apple clang version 13.0.0 (clang-1300.0.29.3)"}
!15 = distinct !DISubprogram(name: "open_io", scope: !10, file: !10, line: 4, type: !16, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!16 = !DISubroutineType(types: !17)
!17 = !{!18, !24, !24}
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "io", file: !20, line: 9, baseType: !21)
!20 = !DIFile(filename: "./io.h", directory: "/Users/sampersand/code/lance/include")
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !20, line: 6, size: 192, elements: !22)
!22 = !{!23, !36, !37}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !21, file: !20, line: 7, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DIDerivedType(tag: DW_TAG_typedef, name: "str", file: !26, line: 8, baseType: !27)
!26 = !DIFile(filename: "./str.h", directory: "/Users/sampersand/code/lance/include")
!27 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_str", file: !26, line: 5, size: 128, elements: !28)
!28 = !{!29, !32}
!29 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !27, file: !26, line: 6, baseType: !30, size: 64)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!31 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !27, file: !26, line: 7, baseType: !33, size: 64, offset: 64)
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "ll", file: !34, line: 3, baseType: !35)
!34 = !DIFile(filename: "./shared.h", directory: "/Users/sampersand/code/lance/include")
!35 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "mode", scope: !21, file: !20, line: 7, baseType: !24, size: 64, offset: 64)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "file", scope: !21, file: !20, line: 8, baseType: !38, size: 64, offset: 128)
!38 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !40, line: 157, baseType: !41)
!40 = !DIFile(filename: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_stdio.h", directory: "")
!41 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__sFILE", file: !40, line: 126, size: 1216, elements: !42)
!42 = !{!43, !46, !48, !49, !51, !52, !57, !58, !59, !63, !67, !76, !82, !83, !86, !87, !91, !95, !96, !97}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "_p", scope: !41, file: !40, line: 127, baseType: !44, size: 64)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!45 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "_r", scope: !41, file: !40, line: 128, baseType: !47, size: 32, offset: 64)
!47 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "_w", scope: !41, file: !40, line: 129, baseType: !47, size: 32, offset: 96)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !41, file: !40, line: 130, baseType: !50, size: 16, offset: 128)
!50 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "_file", scope: !41, file: !40, line: 131, baseType: !50, size: 16, offset: 144)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "_bf", scope: !41, file: !40, line: 132, baseType: !53, size: 128, offset: 192)
!53 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__sbuf", file: !40, line: 92, size: 128, elements: !54)
!54 = !{!55, !56}
!55 = !DIDerivedType(tag: DW_TAG_member, name: "_base", scope: !53, file: !40, line: 93, baseType: !44, size: 64)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "_size", scope: !53, file: !40, line: 94, baseType: !47, size: 32, offset: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "_lbfsize", scope: !41, file: !40, line: 133, baseType: !47, size: 32, offset: 320)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "_cookie", scope: !41, file: !40, line: 136, baseType: !13, size: 64, offset: 384)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "_close", scope: !41, file: !40, line: 137, baseType: !60, size: 64, offset: 448)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !61, size: 64)
!61 = !DISubroutineType(types: !62)
!62 = !{!47, !13}
!63 = !DIDerivedType(tag: DW_TAG_member, name: "_read", scope: !41, file: !40, line: 138, baseType: !64, size: 64, offset: 512)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = !DISubroutineType(types: !66)
!66 = !{!47, !13, !30, !47}
!67 = !DIDerivedType(tag: DW_TAG_member, name: "_seek", scope: !41, file: !40, line: 139, baseType: !68, size: 64, offset: 576)
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DISubroutineType(types: !70)
!70 = !{!71, !13, !71, !47}
!71 = !DIDerivedType(tag: DW_TAG_typedef, name: "fpos_t", file: !40, line: 81, baseType: !72)
!72 = !DIDerivedType(tag: DW_TAG_typedef, name: "__darwin_off_t", file: !73, line: 71, baseType: !74)
!73 = !DIFile(filename: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types.h", directory: "")
!74 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !75, line: 24, baseType: !35)
!75 = !DIFile(filename: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/arm/_types.h", directory: "")
!76 = !DIDerivedType(tag: DW_TAG_member, name: "_write", scope: !41, file: !40, line: 140, baseType: !77, size: 64, offset: 640)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DISubroutineType(types: !79)
!79 = !{!47, !13, !80, !47}
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !31)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "_ub", scope: !41, file: !40, line: 143, baseType: !53, size: 128, offset: 704)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "_extra", scope: !41, file: !40, line: 144, baseType: !84, size: 64, offset: 832)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = !DICompositeType(tag: DW_TAG_structure_type, name: "__sFILEX", file: !40, line: 98, flags: DIFlagFwdDecl)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "_ur", scope: !41, file: !40, line: 145, baseType: !47, size: 32, offset: 896)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "_ubuf", scope: !41, file: !40, line: 148, baseType: !88, size: 24, offset: 928)
!88 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 24, elements: !89)
!89 = !{!90}
!90 = !DISubrange(count: 3)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "_nbuf", scope: !41, file: !40, line: 149, baseType: !92, size: 8, offset: 952)
!92 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 8, elements: !93)
!93 = !{!94}
!94 = !DISubrange(count: 1)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "_lb", scope: !41, file: !40, line: 152, baseType: !53, size: 128, offset: 960)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "_blksize", scope: !41, file: !40, line: 155, baseType: !47, size: 32, offset: 1088)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !41, file: !40, line: 156, baseType: !71, size: 64, offset: 1152)
!98 = !DILocalVariable(name: "name", arg: 1, scope: !15, file: !10, line: 4, type: !24)
!99 = !DILocation(line: 4, column: 18, scope: !15)
!100 = !DILocalVariable(name: "mode", arg: 2, scope: !15, file: !10, line: 4, type: !24)
!101 = !DILocation(line: 4, column: 29, scope: !15)
!102 = !DILocalVariable(name: "f", scope: !15, file: !10, line: 5, type: !18)
!103 = !DILocation(line: 5, column: 6, scope: !15)
!104 = !DILocation(line: 5, column: 10, scope: !15)
!105 = !DILocation(line: 6, column: 12, scope: !15)
!106 = !DILocation(line: 6, column: 2, scope: !15)
!107 = !DILocation(line: 6, column: 5, scope: !15)
!108 = !DILocation(line: 6, column: 10, scope: !15)
!109 = !DILocation(line: 7, column: 12, scope: !15)
!110 = !DILocation(line: 7, column: 2, scope: !15)
!111 = !DILocation(line: 7, column: 5, scope: !15)
!112 = !DILocation(line: 7, column: 10, scope: !15)
!113 = !DILocation(line: 9, column: 21, scope: !15)
!114 = !DILocation(line: 9, column: 27, scope: !15)
!115 = !DILocation(line: 9, column: 31, scope: !15)
!116 = !DILocation(line: 9, column: 2, scope: !15)
!117 = !DILocalVariable(name: "__vla_expr0", scope: !15, type: !118, flags: DIFlagArtificial)
!118 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!119 = !DILocation(line: 0, scope: !15)
!120 = !DILocalVariable(name: "nullterm_name", scope: !15, file: !10, line: 9, type: !121)
!121 = !DICompositeType(tag: DW_TAG_array_type, baseType: !31, elements: !122)
!122 = !{!123}
!123 = !DISubrange(count: !117)
!124 = !DILocation(line: 9, column: 7, scope: !15)
!125 = !DILocation(line: 10, column: 2, scope: !15)
!126 = !DILocation(line: 11, column: 16, scope: !15)
!127 = !DILocation(line: 11, column: 22, scope: !15)
!128 = !DILocation(line: 11, column: 2, scope: !15)
!129 = !DILocation(line: 11, column: 27, scope: !15)
!130 = !DILocation(line: 13, column: 21, scope: !15)
!131 = !DILocation(line: 13, column: 27, scope: !15)
!132 = !DILocation(line: 13, column: 31, scope: !15)
!133 = !DILocation(line: 13, column: 2, scope: !15)
!134 = !DILocalVariable(name: "__vla_expr1", scope: !15, type: !118, flags: DIFlagArtificial)
!135 = !DILocalVariable(name: "nullterm_mode", scope: !15, file: !10, line: 13, type: !136)
!136 = !DICompositeType(tag: DW_TAG_array_type, baseType: !31, elements: !137)
!137 = !{!138}
!138 = !DISubrange(count: !134)
!139 = !DILocation(line: 13, column: 7, scope: !15)
!140 = !DILocation(line: 14, column: 2, scope: !15)
!141 = !DILocation(line: 15, column: 16, scope: !15)
!142 = !DILocation(line: 15, column: 22, scope: !15)
!143 = !DILocation(line: 15, column: 2, scope: !15)
!144 = !DILocation(line: 15, column: 27, scope: !15)
!145 = !DILocation(line: 17, column: 18, scope: !146)
!146 = distinct !DILexicalBlock(scope: !15, file: !10, line: 17, column: 6)
!147 = !DILocation(line: 17, column: 8, scope: !146)
!148 = !DILocation(line: 17, column: 11, scope: !146)
!149 = !DILocation(line: 17, column: 16, scope: !146)
!150 = !DILocation(line: 17, column: 6, scope: !15)
!151 = !DILocation(line: 18, column: 13, scope: !146)
!152 = !DILocation(line: 18, column: 3, scope: !146)
!153 = !DILocation(line: 20, column: 9, scope: !15)
!154 = !DILocation(line: 21, column: 1, scope: !15)
!155 = distinct !DISubprogram(name: "readline_io", scope: !10, file: !10, line: 23, type: !156, scopeLine: 23, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!156 = !DISubroutineType(types: !157)
!157 = !{!24, !18}
!158 = !DILocalVariable(name: "io", arg: 1, scope: !155, file: !10, line: 23, type: !18)
!159 = !DILocation(line: 23, column: 22, scope: !155)
!160 = !DILocalVariable(name: "line", scope: !155, file: !10, line: 24, type: !30)
!161 = !DILocation(line: 24, column: 8, scope: !155)
!162 = !DILocalVariable(name: "len", scope: !155, file: !10, line: 25, type: !163)
!163 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !164, line: 31, baseType: !165)
!164 = !DIFile(filename: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_size_t.h", directory: "")
!165 = !DIDerivedType(tag: DW_TAG_typedef, name: "__darwin_size_t", file: !75, line: 70, baseType: !118)
!166 = !DILocation(line: 25, column: 9, scope: !155)
!167 = !DILocation(line: 27, column: 21, scope: !168)
!168 = distinct !DILexicalBlock(scope: !155, file: !10, line: 27, column: 6)
!169 = !DILocation(line: 27, column: 25, scope: !168)
!170 = !DILocation(line: 27, column: 14, scope: !168)
!171 = !DILocation(line: 27, column: 12, scope: !168)
!172 = !DILocation(line: 27, column: 38, scope: !168)
!173 = !DILocation(line: 27, column: 6, scope: !155)
!174 = !DILocation(line: 28, column: 12, scope: !175)
!175 = distinct !DILexicalBlock(scope: !176, file: !10, line: 28, column: 7)
!176 = distinct !DILexicalBlock(scope: !168, file: !10, line: 27, column: 47)
!177 = !DILocation(line: 28, column: 16, scope: !175)
!178 = !DILocation(line: 28, column: 7, scope: !175)
!179 = !DILocation(line: 28, column: 7, scope: !176)
!180 = !DILocation(line: 28, column: 30, scope: !175)
!181 = !DILocation(line: 28, column: 23, scope: !175)
!182 = !DILocation(line: 29, column: 13, scope: !176)
!183 = !DILocation(line: 29, column: 3, scope: !176)
!184 = !DILocation(line: 30, column: 2, scope: !176)
!185 = !DILocalVariable(name: "s", scope: !155, file: !10, line: 32, type: !24)
!186 = !DILocation(line: 32, column: 7, scope: !155)
!187 = !DILocation(line: 32, column: 24, scope: !155)
!188 = !DILocation(line: 32, column: 11, scope: !155)
!189 = !DILocation(line: 33, column: 19, scope: !155)
!190 = !DILocation(line: 33, column: 25, scope: !155)
!191 = !DILocation(line: 33, column: 11, scope: !155)
!192 = !DILocation(line: 33, column: 2, scope: !155)
!193 = !DILocation(line: 33, column: 5, scope: !155)
!194 = !DILocation(line: 33, column: 9, scope: !155)
!195 = !DILocation(line: 34, column: 9, scope: !155)
!196 = !DILocation(line: 34, column: 2, scope: !155)
!197 = !DILocation(line: 35, column: 1, scope: !155)
