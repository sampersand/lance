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

; Misc builtins
declare i8* @xmalloc(i64 %0)
declare void @print(%struct.builtin.str* %0) 
declare void @quit(%num %0) 

; Struct declarations
%struct.user.Fraction = type { %num, %num }
%struct.user.FractionResult$ZeroDenom = type {  }
%struct.user.FractionResult$Valid = type { %struct.user.Fraction* }

; Enum declarations
%struct.user.enum.FractionResult = type { i64, [8 x i8] }

; Global declarations


; External declarations


; String declarations
@string.-3552367792083486967.str = private unnamed_addr constant [1 x i8] c"/", align 1
@string.-3552367792083486967 = local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.-3552367792083486967.str, i32 0, i32 0), i64 1 }, align 8

@string.2520111029510741737.str = private unnamed_addr constant [24 x i8] c"oops, zero denominator!\0A", align 1
@string.2520111029510741737 = local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([24 x i8], [24 x i8]* @string.2520111029510741737.str, i32 0, i32 0), i64 24 }, align 8

@string.-4203844281422963399.str = private unnamed_addr constant [15 x i8] c"fraction found:", align 1
@string.-4203844281422963399 = local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @string.-4203844281422963399.str, i32 0, i32 0), i64 15 }, align 8

@string.3293711036717323209.str = private unnamed_addr constant [1 x i8] c"\0A", align 1
@string.3293711036717323209 = local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.3293711036717323209.str, i32 0, i32 0), i64 1 }, align 8


; Functions
define %struct.user.enum.FractionResult* @fn.user.NewFraction(%num %0, %num %1) {
  %3 = alloca %num, align 8
  store %num 0, %num* %3, align 8
  %4 = load %num, %num* %3, align 8
  %5 = icmp eq %num %1, %4
  %6 = zext i1 %5 to %bool
  %7 = icmp ne %bool %6, 0
  br i1 %7, label %8, label %21
  8:
  %9 = alloca %num, align 8
  store %num 0, %num* %9, align 8
  %10 = load %num, %num* %9, align 8
  %11 = alloca %struct.user.FractionResult$ZeroDenom*, align 8
  %12 = call i8* @xmalloc(i64 8)
  %13 = bitcast i8* %12 to %struct.user.FractionResult$ZeroDenom*
  store %struct.user.FractionResult$ZeroDenom* %13, %struct.user.FractionResult$ZeroDenom** %11, align 8
  %14 = alloca %struct.user.enum.FractionResult*, align 8
  %15 = call i8* @xmalloc(i64 8)
  %16 = bitcast i8* %15 to %struct.user.enum.FractionResult*
  store %struct.user.enum.FractionResult* %16, %struct.user.enum.FractionResult** %14, align 8
  %17 = getelementptr inbounds %struct.user.enum.FractionResult, %struct.user.enum.FractionResult* %16, i32 0, i32 0
  store %num %10, %num* %17, align 8;  !
  %18 = getelementptr inbounds %struct.user.enum.FractionResult, %struct.user.enum.FractionResult* %16, i32 0, i32 1
  %19 = bitcast [8 x i8]* %18 to %struct.user.FractionResult$ZeroDenom**
  store %struct.user.FractionResult$ZeroDenom* %13, %struct.user.FractionResult$ZeroDenom** %19, align 8;  !
  ret %struct.user.enum.FractionResult* %16
  br label %21
  21:
  %22 = alloca %num, align 8
  store %num %0, %num* %22, align 8
  %23 = alloca %num, align 8
  store %num %1, %num* %23, align 8
  %24 = alloca %num, align 8
  store %num 0, %num* %24, align 8
  %25 = load %num, %num* %24, align 8
  %26 = icmp slt %num %1, %25
  %27 = zext i1 %26 to %bool
  %28 = icmp ne %bool %27, 0
  br i1 %28, label %29, label %34
  29:
  %30 = load %num, %num* %22, align 8
  %31 = sub nsw %num 0, %30
  store %num %31, %num* %22, align 8
  %32 = load %num, %num* %23, align 8
  %33 = sub nsw %num 0, %32
  store %num %33, %num* %23, align 8
  br label %34
  34:
  %35 = alloca %struct.user.Fraction*, align 8
  %36 = load %num, %num* %22, align 8
  %37 = load %num, %num* %23, align 8
  %38 = alloca %struct.user.Fraction*, align 8
  %39 = call i8* @xmalloc(i64 8)
  %40 = bitcast i8* %39 to %struct.user.Fraction*
  store %struct.user.Fraction* %40, %struct.user.Fraction** %38, align 8
  %41 = getelementptr inbounds %struct.user.Fraction, %struct.user.Fraction* %40, i32 0, i32 0
  store %num %36, %num* %41, align 8;  !
  %42 = getelementptr inbounds %struct.user.Fraction, %struct.user.Fraction* %40, i32 0, i32 1
  store %num %37, %num* %42, align 8;  !
  store %struct.user.Fraction* %40, %struct.user.Fraction** %35, align 8
  %43 = alloca %num, align 8
  store %num 1, %num* %43, align 8
  %44 = load %num, %num* %43, align 8
  %45 = load %struct.user.Fraction*, %struct.user.Fraction** %35, align 8
  %46 = alloca %struct.user.FractionResult$Valid*, align 8
  %47 = call i8* @xmalloc(i64 8)
  %48 = bitcast i8* %47 to %struct.user.FractionResult$Valid*
  store %struct.user.FractionResult$Valid* %48, %struct.user.FractionResult$Valid** %46, align 8
  %49 = getelementptr inbounds %struct.user.FractionResult$Valid, %struct.user.FractionResult$Valid* %48, i32 0, i32 0
  store %struct.user.Fraction* %45, %struct.user.Fraction** %49, align 8;  !
  %50 = alloca %struct.user.enum.FractionResult*, align 8
  %51 = call i8* @xmalloc(i64 8)
  %52 = bitcast i8* %51 to %struct.user.enum.FractionResult*
  store %struct.user.enum.FractionResult* %52, %struct.user.enum.FractionResult** %50, align 8
  %53 = getelementptr inbounds %struct.user.enum.FractionResult, %struct.user.enum.FractionResult* %52, i32 0, i32 0
  store %num %44, %num* %53, align 8;  !
  %54 = getelementptr inbounds %struct.user.enum.FractionResult, %struct.user.enum.FractionResult* %52, i32 0, i32 1
  %55 = bitcast [8 x i8]* %54 to %struct.user.FractionResult$Valid**
  store %struct.user.FractionResult$Valid* %48, %struct.user.FractionResult$Valid** %55, align 8;  !
  ret %struct.user.enum.FractionResult* %52
}

define %struct.builtin.str* @fn.user.ftoa(%struct.user.Fraction* %0) {
  %2 = getelementptr inbounds %struct.user.Fraction, %struct.user.Fraction* %0, i32 0, i32 1
  %3 = load %num, %num* %2, align 8
  %4 = alloca %num, align 8
  store %num 1, %num* %4, align 8
  %5 = load %num, %num* %4, align 8
  %6 = icmp eq %num %3, %5
  %7 = zext i1 %6 to %bool
  %8 = icmp ne %bool %7, 0
  br i1 %8, label %9, label %16
  9:
  %10 = alloca %struct.builtin.str* (%num)*, align 8
  store %struct.builtin.str* (%num)* @num_to_str, %struct.builtin.str* (%num)** %10, align 8
  %11 = load %struct.builtin.str* (%num)*, %struct.builtin.str* (%num)** %10, align 8
  %12 = getelementptr inbounds %struct.user.Fraction, %struct.user.Fraction* %0, i32 0, i32 1
  %13 = load %num, %num* %12, align 8
  %14 = call %struct.builtin.str* %11(%num %13)
  ret %struct.builtin.str* %14
  br label %16
  16:
  %17 = alloca %struct.builtin.str* (%num)*, align 8
  store %struct.builtin.str* (%num)* @num_to_str, %struct.builtin.str* (%num)** %17, align 8
  %18 = load %struct.builtin.str* (%num)*, %struct.builtin.str* (%num)** %17, align 8
  %19 = getelementptr inbounds %struct.user.Fraction, %struct.user.Fraction* %0, i32 0, i32 0
  %20 = load %num, %num* %19, align 8
  %21 = call %struct.builtin.str* %18(%num %20)
  %22 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-3552367792083486967, %struct.builtin.str** %22, align 8
  %23 = load %struct.builtin.str*, %struct.builtin.str** %22, align 8
  %24 = alloca %struct.builtin.str* (%num)*, align 8
  store %struct.builtin.str* (%num)* @num_to_str, %struct.builtin.str* (%num)** %24, align 8
  %25 = load %struct.builtin.str* (%num)*, %struct.builtin.str* (%num)** %24, align 8
  %26 = getelementptr inbounds %struct.user.Fraction, %struct.user.Fraction* %0, i32 0, i32 1
  %27 = load %num, %num* %26, align 8
  %28 = call %struct.builtin.str* %25(%num %27)
  %29 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %23, %struct.builtin.str* %28)
  %30 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %21, %struct.builtin.str* %29)
  ret %struct.builtin.str* %30
}

define void @fn.user.main() {
  %1 = alloca %struct.user.enum.FractionResult* (%num, %num)*, align 8
  store %struct.user.enum.FractionResult* (%num, %num)* @fn.user.NewFraction, %struct.user.enum.FractionResult* (%num, %num)** %1, align 8
  %2 = load %struct.user.enum.FractionResult* (%num, %num)*, %struct.user.enum.FractionResult* (%num, %num)** %1, align 8
  %3 = alloca %num, align 8
  store %num 4, %num* %3, align 8
  %4 = load %num, %num* %3, align 8
  %5 = alloca %num, align 8
  store %num 3, %num* %5, align 8
  %6 = load %num, %num* %5, align 8
  %7 = call %struct.user.enum.FractionResult* %2(%num %4, %num %6)
  %8 = bitcast %struct.user.enum.FractionResult* %7 to i64*
  %9 = load i64, i64* %8
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %14, label %11
  11:
  %12 = icmp eq i64 %9, 1
  br i1 %12, label %24, label %13
  13:
  br label %41
  14:
  %15 = getelementptr inbounds i64, i64* %8, i64 1
  %16 = bitcast i64* %15 to %struct.user.FractionResult$ZeroDenom**
  %17 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @print, void (%struct.builtin.str*)** %17, align 8
  %18 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %17, align 8
  %19 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.2520111029510741737, %struct.builtin.str** %19, align 8
  %20 = load %struct.builtin.str*, %struct.builtin.str** %19, align 8
  call void %18(%struct.builtin.str* %20)
  %21 = alloca %num, align 8
  store %num 1, %num* %21, align 8
  %22 = load %num, %num* %21, align 8
  ret void %22
  br label %41
  24:
  %25 = getelementptr inbounds i64, i64* %8, i64 1
  %26 = bitcast i64* %25 to %struct.user.FractionResult$Valid**
  %27 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @print, void (%struct.builtin.str*)** %27, align 8
  %28 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %27, align 8
  %29 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-4203844281422963399, %struct.builtin.str** %29, align 8
  %30 = load %struct.builtin.str*, %struct.builtin.str** %29, align 8
  %31 = alloca %struct.builtin.str* (%struct.user.Fraction*)*, align 8
  store %struct.builtin.str* (%struct.user.Fraction*)* @fn.user.ftoa, %struct.builtin.str* (%struct.user.Fraction*)** %31, align 8
  %32 = load %struct.builtin.str* (%struct.user.Fraction*)*, %struct.builtin.str* (%struct.user.Fraction*)** %31, align 8
  %33 = load %struct.user.FractionResult$Valid*, %struct.user.FractionResult$Valid** %26, align 8
  %34 = getelementptr inbounds %struct.user.FractionResult$Valid, %struct.user.FractionResult$Valid* %33, i32 0, i32 0
  %35 = load %struct.user.Fraction*, %struct.user.Fraction** %34, align 8
  %36 = call %struct.builtin.str* %32(%struct.user.Fraction* %35)
  %37 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.3293711036717323209, %struct.builtin.str** %37, align 8
  %38 = load %struct.builtin.str*, %struct.builtin.str** %37, align 8
  %39 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %36, %struct.builtin.str* %38)
  %40 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %30, %struct.builtin.str* %39)
  call void %28(%struct.builtin.str* %40)
  br label %41
  41:
  %42 = alloca %num, align 8
  store %num 0, %num* %42, align 8
  %43 = load %num, %num* %42, align 8
  ret void %43
  ret void
}



