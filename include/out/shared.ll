; ModuleID = 'shared.c'
source_filename = "shared.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct._str = type { i8*, i64 }

@__stderrp = external global %struct.__sFILE*, align 8
@.str = private unnamed_addr constant [5 x i8] c"%*s\0A\00", align 1
@__stdinp = external global %struct.__sFILE*, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable
define i8* @xmalloc(i64 %0) #0 !dbg !15 {
  %2 = alloca i64, align 8
  %3 = alloca i8*, align 8
  store i64 %0, i64* %2, align 8
  call void @llvm.dbg.declare(metadata i64* %2, metadata !22, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata i8** %3, metadata !24, metadata !DIExpression()), !dbg !25
  %4 = load i64, i64* %2, align 8, !dbg !26
  %5 = call i8* @malloc(i64 %4) #7, !dbg !27
  store i8* %5, i8** %3, align 8, !dbg !25
  %6 = load i64, i64* %2, align 8, !dbg !28
  %7 = icmp ne i64 %6, 0, !dbg !28
  br i1 %7, label %8, label %12, !dbg !30

8:                                                ; preds = %1
  %9 = load i8*, i8** %3, align 8, !dbg !31
  %10 = icmp ne i8* %9, null, !dbg !31
  br i1 %10, label %12, label %11, !dbg !32

11:                                               ; preds = %8
  call void @abort() #8, !dbg !33
  unreachable, !dbg !33

12:                                               ; preds = %8, %1
  %13 = load i8*, i8** %3, align 8, !dbg !34
  ret i8* %13, !dbg !35
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2

; Function Attrs: cold noreturn
declare void @abort() #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define i8* @xrealloc(i8* %0, i64 %1) #0 !dbg !36 {
  %3 = alloca i8*, align 8
  %4 = alloca i64, align 8
  store i8* %0, i8** %3, align 8
  call void @llvm.dbg.declare(metadata i8** %3, metadata !39, metadata !DIExpression()), !dbg !40
  store i64 %1, i64* %4, align 8
  call void @llvm.dbg.declare(metadata i64* %4, metadata !41, metadata !DIExpression()), !dbg !42
  %5 = load i8*, i8** %3, align 8, !dbg !43
  %6 = load i64, i64* %4, align 8, !dbg !44
  %7 = call i8* @realloc(i8* %5, i64 %6) #9, !dbg !45
  store i8* %7, i8** %3, align 8, !dbg !46
  %8 = load i64, i64* %4, align 8, !dbg !47
  %9 = icmp ne i64 %8, 0, !dbg !47
  br i1 %9, label %10, label %14, !dbg !49

10:                                               ; preds = %2
  %11 = load i8*, i8** %3, align 8, !dbg !50
  %12 = icmp ne i8* %11, null, !dbg !50
  br i1 %12, label %14, label %13, !dbg !51

13:                                               ; preds = %10
  call void @abort() #8, !dbg !52
  unreachable, !dbg !52

14:                                               ; preds = %10, %2
  %15 = load i8*, i8** %3, align 8, !dbg !53
  ret i8* %15, !dbg !54
}

; Function Attrs: allocsize(1)
declare i8* @realloc(i8*, i64) #4

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @abort_msg(%struct._str* %0) #0 !dbg !55 {
  %2 = alloca %struct._str*, align 8
  store %struct._str* %0, %struct._str** %2, align 8
  call void @llvm.dbg.declare(metadata %struct._str** %2, metadata !67, metadata !DIExpression()), !dbg !68
  %3 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8, !dbg !69
  %4 = load %struct._str*, %struct._str** %2, align 8, !dbg !70
  %5 = getelementptr inbounds %struct._str, %struct._str* %4, i32 0, i32 1, !dbg !71
  %6 = load i64, i64* %5, align 8, !dbg !71
  %7 = trunc i64 %6 to i32, !dbg !72
  %8 = load %struct._str*, %struct._str** %2, align 8, !dbg !73
  %9 = getelementptr inbounds %struct._str, %struct._str* %8, i32 0, i32 0, !dbg !74
  %10 = load i8*, i8** %9, align 8, !dbg !74
  %11 = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %3, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0), i32 %7, i8* %10), !dbg !75
  call void @quit(i64 1), !dbg !76
  ret void, !dbg !77
}

declare i32 @fprintf(%struct.__sFILE*, i8*, ...) #5

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @quit(i64 %0) #0 !dbg !78 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  call void @llvm.dbg.declare(metadata i64* %2, metadata !81, metadata !DIExpression()), !dbg !82
  %3 = load i64, i64* %2, align 8, !dbg !83
  %4 = trunc i64 %3 to i32, !dbg !83
  call void @exit(i32 %4) #10, !dbg !84
  unreachable, !dbg !84
}

; Function Attrs: noreturn
declare void @exit(i32) #6

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @powll(i64 %0, i64 %1) #0 !dbg !85 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  call void @llvm.dbg.declare(metadata i64* %3, metadata !88, metadata !DIExpression()), !dbg !89
  store i64 %1, i64* %4, align 8
  call void @llvm.dbg.declare(metadata i64* %4, metadata !90, metadata !DIExpression()), !dbg !91
  %5 = load i64, i64* %3, align 8, !dbg !92
  %6 = sitofp i64 %5 to double, !dbg !92
  %7 = load i64, i64* %4, align 8, !dbg !93
  %8 = sitofp i64 %7 to double, !dbg !93
  %9 = call double @llvm.pow.f64(double %6, double %8), !dbg !94
  %10 = fptosi double %9 to i64, !dbg !94
  ret i64 %10, !dbg !95
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.pow.f64(double, double) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @random_() #0 !dbg !96 {
  call void @srandomdev(), !dbg !99
  %1 = call i64 @random(), !dbg !100
  ret i64 %1, !dbg !101
}

declare void @srandomdev() #5

declare i64 @random() #5

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct._str* @prompt() #0 !dbg !102 {
  %1 = alloca i8*, align 8
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca %struct._str*, align 8
  call void @llvm.dbg.declare(metadata i8** %1, metadata !106, metadata !DIExpression()), !dbg !107
  store i8* null, i8** %1, align 8, !dbg !107
  call void @llvm.dbg.declare(metadata i64* %2, metadata !108, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.declare(metadata i64* %3, metadata !115, metadata !DIExpression()), !dbg !120
  %5 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8, !dbg !121
  %6 = call i64 @getline(i8** %1, i64* %2, %struct.__sFILE* %5), !dbg !122
  store i64 %6, i64* %3, align 8, !dbg !120
  call void @llvm.dbg.declare(metadata %struct._str** %4, metadata !123, metadata !DIExpression()), !dbg !124
  %7 = call %struct._str* @allocate_str(i64 0), !dbg !125
  store %struct._str* %7, %struct._str** %4, align 8, !dbg !124
  %8 = load %struct._str*, %struct._str** %4, align 8, !dbg !126
  %9 = getelementptr inbounds %struct._str, %struct._str* %8, i32 0, i32 0, !dbg !127
  %10 = load i8*, i8** %9, align 8, !dbg !127
  call void @free(i8* %10), !dbg !128
  %11 = load i64, i64* %3, align 8, !dbg !129
  %12 = load %struct._str*, %struct._str** %4, align 8, !dbg !130
  %13 = getelementptr inbounds %struct._str, %struct._str* %12, i32 0, i32 1, !dbg !131
  store i64 %11, i64* %13, align 8, !dbg !132
  %14 = load i8*, i8** %1, align 8, !dbg !133
  %15 = load %struct._str*, %struct._str** %4, align 8, !dbg !134
  %16 = getelementptr inbounds %struct._str, %struct._str* %15, i32 0, i32 0, !dbg !135
  store i8* %14, i8** %16, align 8, !dbg !136
  %17 = load %struct._str*, %struct._str** %4, align 8, !dbg !137
  ret %struct._str* %17, !dbg !138
}

declare i64 @getline(i8**, i64*, %struct.__sFILE*) #5

declare %struct._str* @allocate_str(i64) #5

declare void @free(i8*) #5

attributes #0 = { noinline nounwind optnone ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { allocsize(0) "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { cold noreturn "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { allocsize(1) "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { allocsize(0) }
attributes #8 = { cold noreturn }
attributes #9 = { allocsize(1) }
attributes #10 = { noreturn }

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
!10 = !DIFile(filename: "shared.c", directory: "/Users/sampersand/code/lance/include")
!11 = !{}
!12 = !{!13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{!"Apple clang version 13.0.0 (clang-1300.0.29.3)"}
!15 = distinct !DISubprogram(name: "xmalloc", scope: !10, file: !10, line: 8, type: !16, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!16 = !DISubroutineType(types: !17)
!17 = !{!18, !19}
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "ll", file: !20, line: 5, baseType: !21)
!20 = !DIFile(filename: "./shared.h", directory: "/Users/sampersand/code/lance/include")
!21 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!22 = !DILocalVariable(name: "len", arg: 1, scope: !15, file: !10, line: 8, type: !19)
!23 = !DILocation(line: 8, column: 18, scope: !15)
!24 = !DILocalVariable(name: "ptr", scope: !15, file: !10, line: 9, type: !18)
!25 = !DILocation(line: 9, column: 8, scope: !15)
!26 = !DILocation(line: 9, column: 21, scope: !15)
!27 = !DILocation(line: 9, column: 14, scope: !15)
!28 = !DILocation(line: 10, column: 6, scope: !29)
!29 = distinct !DILexicalBlock(scope: !15, file: !10, line: 10, column: 6)
!30 = !DILocation(line: 10, column: 10, scope: !29)
!31 = !DILocation(line: 10, column: 14, scope: !29)
!32 = !DILocation(line: 10, column: 6, scope: !15)
!33 = !DILocation(line: 10, column: 19, scope: !29)
!34 = !DILocation(line: 11, column: 9, scope: !15)
!35 = !DILocation(line: 11, column: 2, scope: !15)
!36 = distinct !DISubprogram(name: "xrealloc", scope: !10, file: !10, line: 14, type: !37, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!37 = !DISubroutineType(types: !38)
!38 = !{!18, !18, !19}
!39 = !DILocalVariable(name: "ptr", arg: 1, scope: !36, file: !10, line: 14, type: !18)
!40 = !DILocation(line: 14, column: 22, scope: !36)
!41 = !DILocalVariable(name: "len", arg: 2, scope: !36, file: !10, line: 14, type: !19)
!42 = !DILocation(line: 14, column: 30, scope: !36)
!43 = !DILocation(line: 15, column: 16, scope: !36)
!44 = !DILocation(line: 15, column: 21, scope: !36)
!45 = !DILocation(line: 15, column: 8, scope: !36)
!46 = !DILocation(line: 15, column: 6, scope: !36)
!47 = !DILocation(line: 16, column: 6, scope: !48)
!48 = distinct !DILexicalBlock(scope: !36, file: !10, line: 16, column: 6)
!49 = !DILocation(line: 16, column: 10, scope: !48)
!50 = !DILocation(line: 16, column: 14, scope: !48)
!51 = !DILocation(line: 16, column: 6, scope: !36)
!52 = !DILocation(line: 16, column: 19, scope: !48)
!53 = !DILocation(line: 17, column: 9, scope: !36)
!54 = !DILocation(line: 17, column: 2, scope: !36)
!55 = distinct !DISubprogram(name: "abort_msg", scope: !10, file: !10, line: 20, type: !56, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!56 = !DISubroutineType(types: !57)
!57 = !{null, !58}
!58 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !59, size: 64)
!59 = !DIDerivedType(tag: DW_TAG_typedef, name: "str", file: !60, line: 8, baseType: !61)
!60 = !DIFile(filename: "./str.h", directory: "/Users/sampersand/code/lance/include")
!61 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_str", file: !60, line: 5, size: 128, elements: !62)
!62 = !{!63, !66}
!63 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !61, file: !60, line: 6, baseType: !64, size: 64)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !61, file: !60, line: 7, baseType: !19, size: 64, offset: 64)
!67 = !DILocalVariable(name: "msg", arg: 1, scope: !55, file: !10, line: 20, type: !58)
!68 = !DILocation(line: 20, column: 21, scope: !55)
!69 = !DILocation(line: 21, column: 10, scope: !55)
!70 = !DILocation(line: 21, column: 33, scope: !55)
!71 = !DILocation(line: 21, column: 38, scope: !55)
!72 = !DILocation(line: 21, column: 27, scope: !55)
!73 = !DILocation(line: 21, column: 43, scope: !55)
!74 = !DILocation(line: 21, column: 48, scope: !55)
!75 = !DILocation(line: 21, column: 2, scope: !55)
!76 = !DILocation(line: 22, column: 2, scope: !55)
!77 = !DILocation(line: 23, column: 1, scope: !55)
!78 = distinct !DISubprogram(name: "quit", scope: !10, file: !10, line: 25, type: !79, scopeLine: 25, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!79 = !DISubroutineType(types: !80)
!80 = !{null, !19}
!81 = !DILocalVariable(name: "val", arg: 1, scope: !78, file: !10, line: 25, type: !19)
!82 = !DILocation(line: 25, column: 14, scope: !78)
!83 = !DILocation(line: 26, column: 7, scope: !78)
!84 = !DILocation(line: 26, column: 2, scope: !78)
!85 = distinct !DISubprogram(name: "powll", scope: !10, file: !10, line: 29, type: !86, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!86 = !DISubroutineType(types: !87)
!87 = !{!19, !19, !19}
!88 = !DILocalVariable(name: "base", arg: 1, scope: !85, file: !10, line: 29, type: !19)
!89 = !DILocation(line: 29, column: 13, scope: !85)
!90 = !DILocalVariable(name: "exp", arg: 2, scope: !85, file: !10, line: 29, type: !19)
!91 = !DILocation(line: 29, column: 22, scope: !85)
!92 = !DILocation(line: 30, column: 13, scope: !85)
!93 = !DILocation(line: 30, column: 19, scope: !85)
!94 = !DILocation(line: 30, column: 9, scope: !85)
!95 = !DILocation(line: 30, column: 2, scope: !85)
!96 = distinct !DISubprogram(name: "random_", scope: !10, file: !10, line: 33, type: !97, scopeLine: 33, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!97 = !DISubroutineType(types: !98)
!98 = !{!19}
!99 = !DILocation(line: 34, column: 2, scope: !96)
!100 = !DILocation(line: 35, column: 9, scope: !96)
!101 = !DILocation(line: 35, column: 2, scope: !96)
!102 = distinct !DISubprogram(name: "prompt", scope: !10, file: !10, line: 38, type: !103, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!103 = !DISubroutineType(types: !104)
!104 = !{!105}
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !61, size: 64)
!106 = !DILocalVariable(name: "line", scope: !102, file: !10, line: 39, type: !64)
!107 = !DILocation(line: 39, column: 8, scope: !102)
!108 = !DILocalVariable(name: "alloc_len", scope: !102, file: !10, line: 40, type: !109)
!109 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !110, line: 31, baseType: !111)
!110 = !DIFile(filename: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_size_t.h", directory: "")
!111 = !DIDerivedType(tag: DW_TAG_typedef, name: "__darwin_size_t", file: !112, line: 70, baseType: !113)
!112 = !DIFile(filename: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/arm/_types.h", directory: "")
!113 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!114 = !DILocation(line: 40, column: 9, scope: !102)
!115 = !DILocalVariable(name: "len", scope: !102, file: !10, line: 41, type: !116)
!116 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !117, line: 31, baseType: !118)
!117 = !DIFile(filename: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_ssize_t.h", directory: "")
!118 = !DIDerivedType(tag: DW_TAG_typedef, name: "__darwin_ssize_t", file: !112, line: 97, baseType: !119)
!119 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!120 = !DILocation(line: 41, column: 10, scope: !102)
!121 = !DILocation(line: 41, column: 43, scope: !102)
!122 = !DILocation(line: 41, column: 16, scope: !102)
!123 = !DILocalVariable(name: "s", scope: !102, file: !10, line: 42, type: !58)
!124 = !DILocation(line: 42, column: 7, scope: !102)
!125 = !DILocation(line: 42, column: 11, scope: !102)
!126 = !DILocation(line: 43, column: 7, scope: !102)
!127 = !DILocation(line: 43, column: 10, scope: !102)
!128 = !DILocation(line: 43, column: 2, scope: !102)
!129 = !DILocation(line: 45, column: 11, scope: !102)
!130 = !DILocation(line: 45, column: 2, scope: !102)
!131 = !DILocation(line: 45, column: 5, scope: !102)
!132 = !DILocation(line: 45, column: 9, scope: !102)
!133 = !DILocation(line: 46, column: 11, scope: !102)
!134 = !DILocation(line: 46, column: 2, scope: !102)
!135 = !DILocation(line: 46, column: 5, scope: !102)
!136 = !DILocation(line: 46, column: 9, scope: !102)
!137 = !DILocation(line: 47, column: 9, scope: !102)
!138 = !DILocation(line: 47, column: 2, scope: !102)
