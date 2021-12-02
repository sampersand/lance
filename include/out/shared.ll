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
!15 = distinct !DISubprogram(name: "xmalloc", scope: !10, file: !10, line: 6, type: !16, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!16 = !DISubroutineType(types: !17)
!17 = !{!18, !19}
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "ll", file: !20, line: 3, baseType: !21)
!20 = !DIFile(filename: "./shared.h", directory: "/Users/sampersand/code/lance/include")
!21 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!22 = !DILocalVariable(name: "len", arg: 1, scope: !15, file: !10, line: 6, type: !19)
!23 = !DILocation(line: 6, column: 18, scope: !15)
!24 = !DILocalVariable(name: "ptr", scope: !15, file: !10, line: 7, type: !18)
!25 = !DILocation(line: 7, column: 8, scope: !15)
!26 = !DILocation(line: 7, column: 21, scope: !15)
!27 = !DILocation(line: 7, column: 14, scope: !15)
!28 = !DILocation(line: 8, column: 6, scope: !29)
!29 = distinct !DILexicalBlock(scope: !15, file: !10, line: 8, column: 6)
!30 = !DILocation(line: 8, column: 10, scope: !29)
!31 = !DILocation(line: 8, column: 14, scope: !29)
!32 = !DILocation(line: 8, column: 6, scope: !15)
!33 = !DILocation(line: 8, column: 19, scope: !29)
!34 = !DILocation(line: 9, column: 9, scope: !15)
!35 = !DILocation(line: 9, column: 2, scope: !15)
!36 = distinct !DISubprogram(name: "xrealloc", scope: !10, file: !10, line: 12, type: !37, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!37 = !DISubroutineType(types: !38)
!38 = !{!18, !18, !19}
!39 = !DILocalVariable(name: "ptr", arg: 1, scope: !36, file: !10, line: 12, type: !18)
!40 = !DILocation(line: 12, column: 22, scope: !36)
!41 = !DILocalVariable(name: "len", arg: 2, scope: !36, file: !10, line: 12, type: !19)
!42 = !DILocation(line: 12, column: 30, scope: !36)
!43 = !DILocation(line: 13, column: 16, scope: !36)
!44 = !DILocation(line: 13, column: 21, scope: !36)
!45 = !DILocation(line: 13, column: 8, scope: !36)
!46 = !DILocation(line: 13, column: 6, scope: !36)
!47 = !DILocation(line: 14, column: 6, scope: !48)
!48 = distinct !DILexicalBlock(scope: !36, file: !10, line: 14, column: 6)
!49 = !DILocation(line: 14, column: 10, scope: !48)
!50 = !DILocation(line: 14, column: 14, scope: !48)
!51 = !DILocation(line: 14, column: 6, scope: !36)
!52 = !DILocation(line: 14, column: 19, scope: !48)
!53 = !DILocation(line: 15, column: 9, scope: !36)
!54 = !DILocation(line: 15, column: 2, scope: !36)
!55 = distinct !DISubprogram(name: "abort_msg", scope: !10, file: !10, line: 18, type: !56, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
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
!67 = !DILocalVariable(name: "msg", arg: 1, scope: !55, file: !10, line: 18, type: !58)
!68 = !DILocation(line: 18, column: 21, scope: !55)
!69 = !DILocation(line: 19, column: 10, scope: !55)
!70 = !DILocation(line: 19, column: 33, scope: !55)
!71 = !DILocation(line: 19, column: 38, scope: !55)
!72 = !DILocation(line: 19, column: 27, scope: !55)
!73 = !DILocation(line: 19, column: 43, scope: !55)
!74 = !DILocation(line: 19, column: 48, scope: !55)
!75 = !DILocation(line: 19, column: 2, scope: !55)
!76 = !DILocation(line: 20, column: 2, scope: !55)
!77 = !DILocation(line: 21, column: 1, scope: !55)
!78 = distinct !DISubprogram(name: "quit", scope: !10, file: !10, line: 23, type: !79, scopeLine: 23, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !9, retainedNodes: !11)
!79 = !DISubroutineType(types: !80)
!80 = !{null, !19}
!81 = !DILocalVariable(name: "val", arg: 1, scope: !78, file: !10, line: 23, type: !19)
!82 = !DILocation(line: 23, column: 14, scope: !78)
!83 = !DILocation(line: 24, column: 7, scope: !78)
!84 = !DILocation(line: 24, column: 2, scope: !78)
