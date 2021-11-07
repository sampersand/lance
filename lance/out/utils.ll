; Prelude
target triple = "arm64-apple-macosx12.0.0"
%bool = type i64 ; used to be i8, this is just to simplify interfaces
%num = type i64
%struct.builtin.str = type { i8*, i64 } ; (ptr, len)
%struct.builtin.any = type { i8*, i64 } ; (ptr, type)
%struct.builtin.list = type { i8*, i64, i64 } ; (ptr, len, cap)

; List builtins builtins
declare %struct.builtin.list* @allocate_list(i64 %0, i64 %1) 
declare %struct.builtin.list* @concat_lists(%struct.builtin.list* %0, %struct.builtin.list* %1, i64 %2)
declare %struct.builtin.list* @repeat_list(%struct.builtin.list* %0, %num %1, i64 %2)
declare %bool @insert_into_list(%struct.builtin.list* %0, i8* %1, i64 %2, i64 %3)
declare %bool @delete_from_list(%struct.builtin.list* %0, i8* %1, i64 %2, i64 %3)

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
@string.-906412184414141813.str = private unnamed_addr constant [7 x i8] c"error: ", align 1
@string.-906412184414141813 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @string.-906412184414141813.str, i32 0, i32 0), i64 7 }, align 8

@string.-1217805747574612452.str = private unnamed_addr constant [1 x i8] c"\0A", align 1
@string.-1217805747574612452 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.-1217805747574612452.str, i32 0, i32 0), i64 1 }, align 8


; Functions
define internal %num @fn.user.CountCharOccurrences(%struct.builtin.str* %0, %struct.builtin.str* %1) {
  %3 = alloca %num, align 8
  %4 = alloca %num, align 8
  store %num 0, %num* %4, align 8
  %5 = load %num, %num* %4, align 8
  store %num %5, %num* %3, align 8
  %6 = alloca %num, align 8
  %7 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %0, i64 0, i32 1
  %8 = load i64, i64* %7, align 8
  store %num %8, %num* %6, align 8
  %9 = alloca %num, align 8
  %10 = alloca %num, align 8
  store %num 0, %num* %10, align 8
  %11 = load %num, %num* %10, align 8
  store %num %11, %num* %9, align 8
  br label %12
  12:
  %13 = load %num, %num* %3, align 8
  %14 = load %num, %num* %6, align 8
  %15 = icmp slt %num %13, %14
  %16 = zext i1 %15 to %bool
  %17 = icmp ne %bool %16, 0
  br i1 %17, label %18, label %42
  18:
  %19 = load %num, %num* %3, align 8
  %20 = call %struct.builtin.str* @allocate_str(i64 1)
  %21 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %0, i64 0, i32 0
  %22 = load i8*, i8** %21, align 8
  %23 = getelementptr inbounds i8, i8* %22, i64 %19
  %24 = load i8, i8* %23, align 1
  %25 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %20, i64 0, i32 0
  %26 = load i8*, i8** %25, align 8
  %27 = getelementptr inbounds i8, i8* %26, i64 0
  store i8 %24, i8* %27, align 1
  %28 = call i32 @compare_strs(%struct.builtin.str* %20, %struct.builtin.str* %1)
  %29 = icmp eq i32 %28, 0
  %30 = zext i1 %29 to %bool
  %31 = icmp ne %bool %30, 0
  br i1 %31, label %32, label %37
  32:
  %33 = load %num, %num* %9, align 8
  %34 = alloca %num, align 8
  store %num 1, %num* %34, align 8
  %35 = load %num, %num* %34, align 8
  %36 = add nsw %num %33, %35
  store %num %36, %num* %9, align 8
  br label %37
  37:
  %38 = load %num, %num* %3, align 8
  %39 = alloca %num, align 8
  store %num 1, %num* %39, align 8
  %40 = load %num, %num* %39, align 8
  %41 = add nsw %num %38, %40
  store %num %41, %num* %3, align 8
  br label %12
  42:
  %43 = load %num, %num* %9, align 8
  ret %num %43
}

define internal %bool @fn.user.StringContains(%struct.builtin.str* %0, %struct.builtin.str* %1) {
  %3 = alloca %num (%struct.builtin.str*, %struct.builtin.str*)*, align 8
  store %num (%struct.builtin.str*, %struct.builtin.str*)* @fn.user.CountCharOccurrences, %num (%struct.builtin.str*, %struct.builtin.str*)** %3, align 8
  %4 = load %num (%struct.builtin.str*, %struct.builtin.str*)*, %num (%struct.builtin.str*, %struct.builtin.str*)** %3, align 8
  %5 = call %num %4(%struct.builtin.str* %0, %struct.builtin.str* %1)
  %6 = alloca %num, align 8
  store %num 0, %num* %6, align 8
  %7 = load %num, %num* %6, align 8
  %8 = icmp ne %num %5, %7
  %9 = zext i1 %8 to %bool
  ret %bool %9
}

define internal void @fn.user.Abort(%struct.builtin.str* %0) {
  %2 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @print, void (%struct.builtin.str*)** %2, align 8
  %3 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %2, align 8
  %4 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-906412184414141813, %struct.builtin.str** %4, align 8
  %5 = load %struct.builtin.str*, %struct.builtin.str** %4, align 8
  %6 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-1217805747574612452, %struct.builtin.str** %6, align 8
  %7 = load %struct.builtin.str*, %struct.builtin.str** %6, align 8
  %8 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %0, %struct.builtin.str* %7)
  %9 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %5, %struct.builtin.str* %8)
  call void %3(%struct.builtin.str* %9)
  %10 = alloca void (%num)*, align 8
  store void (%num)* @quit, void (%num)** %10, align 8
  %11 = load void (%num)*, void (%num)** %10, align 8
  %12 = alloca %num, align 8
  store %num 1, %num* %12, align 8
  %13 = load %num, %num* %12, align 8
  call void %11(%num %13)
  ret void
}



