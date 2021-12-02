; Prelude
target triple = "arm64-apple-macosx12.0.0"
%bool = type i64 ; used to be i8, this is just to simplify interfaces
%num = type i64
%struct.builtin.str = type { i8*, i64 } ; (ptr, len)
%struct.builtin.any = type { i8*, i64 } ; (ptr, type)
%struct.builtin.list = type { i8*, i64, i64 } ; (ptr, len, cap)

; List builtins builtins
declare %struct.builtin.list* @allocate_list(i64 %0) 
declare %struct.builtin.list* @concat_lists(%struct.builtin.list* %0, %struct.builtin.list* %1)
declare %struct.builtin.list* @repeat_list(%struct.builtin.list* %0, %num %1)
declare %bool @insert_into_list(%struct.builtin.list* %0, i8* %1, i64 %2)
declare %bool @delete_from_list(%struct.builtin.list* %0, i8* %1, i64 %2)

; String builtins
declare %struct.builtin.str* @allocate_str(i64 %0) 
declare %struct.builtin.str* @num_to_str(%num %0) 
declare %num @str_to_num(%struct.builtin.str* %0) 
declare %struct.builtin.str* @concat_strs(%struct.builtin.str* %0, %struct.builtin.str* %1) 
declare %struct.builtin.str* @repeat_str(%struct.builtin.str* %0, %num %1) 
declare i32 @compare_strs(%struct.builtin.str* %0, %struct.builtin.str* %1) 
declare %struct.builtin.str* @substr(%struct.builtin.str* %0, i64 %1, i64 %2)
declare %struct.builtin.str* @ascii_to_str(%num %0)
declare %num @str_to_ascii(%struct.builtin.str* %0)

; Misc builtins
declare i8* @xmalloc(i64 %0)
declare void @print(%struct.builtin.str* %0) 
declare void @quit(%num %0) 

; Struct declarations


; Enum declarations


; Global declarations


; External declarations


; String declarations
@string.4076664174402442571.str = private unnamed_addr constant [1 x i8] c"a", align 1
@string.4076664174402442571 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.4076664174402442571.str, i32 0, i32 0), i64 1 }, align 8

@string.935101049360915472.str = private unnamed_addr constant [1 x i8] c"b", align 1
@string.935101049360915472 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.935101049360915472.str, i32 0, i32 0), i64 1 }, align 8

@string.-2960687067569657581.str = private unnamed_addr constant [1 x i8] c"c", align 1
@string.-2960687067569657581 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.-2960687067569657581.str, i32 0, i32 0), i64 1 }, align 8

@string.-3521993435047761291.str = private unnamed_addr constant [1 x i8] c"q", align 1
@string.-3521993435047761291 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.-3521993435047761291.str, i32 0, i32 0), i64 1 }, align 8


; Functions
define %num @fn.user.main() {
  %1 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @print, void (%struct.builtin.str*)** %1, align 8
  %2 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %1, align 8
  %3 = alloca %struct.builtin.str* (%num)*, align 8
  store %struct.builtin.str* (%num)* @ascii_to_str, %struct.builtin.str* (%num)** %3, align 8
  %4 = load %struct.builtin.str* (%num)*, %struct.builtin.str* (%num)** %3, align 8
  %5 = alloca %num, align 8
  store %num 83, %num* %5, align 8
  %6 = load %num, %num* %5, align 8
  %7 = call %struct.builtin.str* %4(%num %6)
  call void %2(%struct.builtin.str* %7)
  %8 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @print, void (%struct.builtin.str*)** %8, align 8
  %9 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %8, align 8
  %10 = alloca %struct.builtin.str* (%num)*, align 8
  store %struct.builtin.str* (%num)* @ascii_to_str, %struct.builtin.str* (%num)** %10, align 8
  %11 = load %struct.builtin.str* (%num)*, %struct.builtin.str* (%num)** %10, align 8
  %12 = alloca %num, align 8
  store %num 38, %num* %12, align 8
  %13 = load %num, %num* %12, align 8
  %14 = call %struct.builtin.str* %11(%num %13)
  call void %9(%struct.builtin.str* %14)
  %15 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @print, void (%struct.builtin.str*)** %15, align 8
  %16 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %15, align 8
  %17 = alloca %struct.builtin.str* (%num)*, align 8
  store %struct.builtin.str* (%num)* @ascii_to_str, %struct.builtin.str* (%num)** %17, align 8
  %18 = load %struct.builtin.str* (%num)*, %struct.builtin.str* (%num)** %17, align 8
  %19 = alloca %num, align 8
  store %num 10, %num* %19, align 8
  %20 = load %num, %num* %19, align 8
  %21 = call %struct.builtin.str* %18(%num %20)
  call void %16(%struct.builtin.str* %21)
  %22 = alloca %num, align 8
  %23 = alloca %num, align 8
  store %num 1, %num* %23, align 8
  %24 = load %num, %num* %23, align 8
  %25 = alloca %num, align 8
  store %num 2, %num* %25, align 8
  %26 = load %num, %num* %25, align 8
  %27 = alloca %num, align 8
  store %num 3, %num* %27, align 8
  %28 = load %num, %num* %27, align 8
  %29 = alloca %num, align 8
  store %num 4, %num* %29, align 8
  %30 = load %num, %num* %29, align 8
  %31 = call %struct.builtin.list* @allocate_list(i64 4)
  %32 = bitcast %struct.builtin.list* %31 to %num**
  %33 = load %num*, %num** %32, align 8
  store %num %24, %num* %33, align 8
  %34 = getelementptr inbounds %num, %num* %33, i64 1
  store %num %26, %num* %34, align 8
  %35 = getelementptr inbounds %num, %num* %33, i64 2
  store %num %28, %num* %35, align 8
  %36 = getelementptr inbounds %num, %num* %33, i64 3
  store %num %30, %num* %36, align 8
  %37 = getelementptr inbounds %struct.builtin.list, %struct.builtin.list* %31, i64 0, i32 2
  store %num 4, %num* %37, align 8
  %38 = getelementptr inbounds %struct.builtin.list, %struct.builtin.list* %31, i64 0, i32 1
  %39 = load i64, i64* %38, align 8
  store %num %39, %num* %22, align 8
  %40 = alloca %struct.builtin.list*, align 8
  %41 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.4076664174402442571, %struct.builtin.str** %41, align 8
  %42 = load %struct.builtin.str*, %struct.builtin.str** %41, align 8
  %43 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.935101049360915472, %struct.builtin.str** %43, align 8
  %44 = load %struct.builtin.str*, %struct.builtin.str** %43, align 8
  %45 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-2960687067569657581, %struct.builtin.str** %45, align 8
  %46 = load %struct.builtin.str*, %struct.builtin.str** %45, align 8
  %47 = call %struct.builtin.list* @allocate_list(i64 3)
  %48 = bitcast %struct.builtin.list* %47 to %struct.builtin.str***
  %49 = load %struct.builtin.str**, %struct.builtin.str*** %48, align 8
  store %struct.builtin.str* %42, %struct.builtin.str** %49, align 8
  %50 = getelementptr inbounds %struct.builtin.str*, %struct.builtin.str** %49, i64 1
  store %struct.builtin.str* %44, %struct.builtin.str** %50, align 8
  %51 = getelementptr inbounds %struct.builtin.str*, %struct.builtin.str** %49, i64 2
  store %struct.builtin.str* %46, %struct.builtin.str** %51, align 8
  %52 = getelementptr inbounds %struct.builtin.list, %struct.builtin.list* %47, i64 0, i32 2
  store %num 3, %num* %52, align 8
  store %struct.builtin.list* %47, %struct.builtin.list** %40, align 8
  %53 = load %struct.builtin.list*, %struct.builtin.list** %40, align 8
  %54 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-3521993435047761291, %struct.builtin.str** %54, align 8
  %55 = load %struct.builtin.str*, %struct.builtin.str** %54, align 8
  %56 = alloca %num, align 8
  store %num 0, %num* %56, align 8
  %57 = load %num, %num* %56, align 8
  %58 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* %55, %struct.builtin.str** %58, align 8
  %59 = bitcast %struct.builtin.str** %58 to i8*
  %60 = call zeroext %bool @insert_into_list(%struct.builtin.list* %53, i8* %59, i64 %57)
  %61 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @print, void (%struct.builtin.str*)** %61, align 8
  %62 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %61, align 8
  %63 = load %struct.builtin.list*, %struct.builtin.list** %40, align 8
  %64 = alloca %num, align 8
  store %num 3, %num* %64, align 8
  %65 = load %num, %num* %64, align 8
  %66 = bitcast %struct.builtin.list* %63 to %struct.builtin.str***
  %67 = load %struct.builtin.str**, %struct.builtin.str*** %66, align 8
  %68 = getelementptr inbounds %struct.builtin.str*, %struct.builtin.str** %67, %num %65
  %69 = load %struct.builtin.str*, %struct.builtin.str** %68, align 8
  call void %62(%struct.builtin.str* %69)
  %70 = alloca %num, align 8
  store %num 0, %num* %70, align 8
  %71 = load %num, %num* %70, align 8
  ret %num %71
}



