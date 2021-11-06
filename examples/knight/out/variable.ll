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
%struct.user.Value$Null = type {  }
%struct.user.Value$Boolean = type { %bool }
%struct.user.Value$Number = type { %num }
%struct.user.Value$Text = type { %struct.builtin.str* }
%struct.user.Variable = type { %struct.builtin.str*, %struct.user.enum.Value*, %bool }

; Enum declarations
%struct.user.enum.Value = type { i64, [8 x i8] }

; Global declarations
@globals.variables = global %struct.builtin.list* null, align 8

; External declarations


; String declarations


; Functions
define void @fn.user.init_variables() {
  %1 = alloca %struct.builtin.list*, align 8
  %2 = alloca %num, align 8
  store %num 0, %num* %2, align 8
  %3 = load %num, %num* %2, align 8
  %4 = call %struct.builtin.list* @allocate_list(i64 1, i64 8)
  %5 = bitcast %struct.builtin.list* %4 to %num**
  %6 = load %num*, %num** %5, align 8
  store %num %3, %num* %6, align 8
  %7 = getelementptr inbounds %struct.builtin.list, %struct.builtin.list* %4, i64 0, i32 2
  store %num 1, %num* %7, align 8
  store %struct.builtin.list* %4, %struct.builtin.list** %1, align 8
  %8 = load %struct.builtin.list*, %struct.builtin.list** %1, align 8
  %9 = alloca %num, align 8
  store %num 0, %num* %9, align 8
  %10 = load %num, %num* %9, align 8
  %11 = alloca %struct.user.Variable*, align 8
  %12 = bitcast %struct.user.Variable** %11 to i8*
  %13 = call zeroext %bool @delete_from_list(%struct.builtin.list* %8, i8* %12, i64 %10, i64 8)
  %14 = load %struct.builtin.list*, %struct.builtin.list** %1, align 8
  store %struct.builtin.list* %14, %struct.builtin.list** @globals.variables, align 8
  ret void
}

define %struct.user.Variable* @fn.user.get_variable(%struct.builtin.str* %0) {
  %2 = alloca %num, align 8
  %3 = alloca %num, align 8
  store %num 0, %num* %3, align 8
  %4 = load %num, %num* %3, align 8
  store %num %4, %num* %2, align 8
  %5 = alloca %num, align 8
  %6 = getelementptr inbounds %struct.builtin.list, %struct.builtin.list* @globals.variables, i64 0, i32 1
  %7 = load i64, i64* %6, align 8
  store %num %7, %num* %5, align 8
  br label %8
  8:
  %9 = load %num, %num* %2, align 8
  %10 = load %num, %num* %5, align 8
  %11 = icmp slt %num %9, %10
  %12 = zext i1 %11 to %bool
  %13 = icmp ne %bool %12, 0
  br i1 %13, label %14, label %38
  14:
  %15 = load %num, %num* %2, align 8
  %16 = bitcast %struct.builtin.list* @globals.variables to %struct.user.Variable***
  %17 = load %struct.user.Variable**, %struct.user.Variable*** %16, align 8
  %18 = getelementptr inbounds %struct.user.Variable*, %struct.user.Variable** %17, %num %15
  %19 = load %struct.user.Variable*, %struct.user.Variable** %18, align 8
  %20 = getelementptr inbounds %struct.user.Variable, %struct.user.Variable* %19, i32 0, i32 0
  %21 = load %struct.builtin.str*, %struct.builtin.str** %20, align 8
  %22 = call i32 @compare_strs(%struct.builtin.str* %0, %struct.builtin.str* %21)
  %23 = icmp eq i32 %22, 0
  %24 = zext i1 %23 to %bool
  %25 = icmp ne %bool %24, 0
  br i1 %25, label %26, label %33
  26:
  %27 = load %num, %num* %2, align 8
  %28 = bitcast %struct.builtin.list* @globals.variables to %struct.user.Variable***
  %29 = load %struct.user.Variable**, %struct.user.Variable*** %28, align 8
  %30 = getelementptr inbounds %struct.user.Variable*, %struct.user.Variable** %29, %num %27
  %31 = load %struct.user.Variable*, %struct.user.Variable** %30, align 8
  ret %struct.user.Variable* %31
  br label %33
  33:
  %34 = load %num, %num* %2, align 8
  %35 = alloca %num, align 8
  store %num 1, %num* %35, align 8
  %36 = load %num, %num* %35, align 8
  %37 = add nsw %num %34, %36
  store %num %37, %num* %2, align 8
  br label %8
  38:
  %39 = alloca %struct.user.enum.Value*, align 8
  %40 = alloca %num, align 8
  store %num 0, %num* %40, align 8
  %41 = load %num, %num* %40, align 8
  %42 = alloca %struct.user.Value$Null*, align 8
  %43 = call i8* @xmalloc(i64 8)
  %44 = bitcast i8* %43 to %struct.user.Value$Null*
  store %struct.user.Value$Null* %44, %struct.user.Value$Null** %42, align 8
  %45 = alloca %struct.user.enum.Value*, align 8
  %46 = call i8* @xmalloc(i64 8)
  %47 = bitcast i8* %46 to %struct.user.enum.Value*
  store %struct.user.enum.Value* %47, %struct.user.enum.Value** %45, align 8
  %48 = getelementptr inbounds %struct.user.enum.Value, %struct.user.enum.Value* %47, i32 0, i32 0
  store %num %41, %num* %48, align 8;  !
  %49 = getelementptr inbounds %struct.user.enum.Value, %struct.user.enum.Value* %47, i32 0, i32 1
  %50 = bitcast [8 x i8]* %49 to %struct.user.Value$Null**
  store %struct.user.Value$Null* %44, %struct.user.Value$Null** %50, align 8;  !
  store %struct.user.enum.Value* %47, %struct.user.enum.Value** %39, align 8
  %51 = load %num, %num* %2, align 8
  %52 = load %struct.user.enum.Value*, %struct.user.enum.Value** %39, align 8
  %53 = alloca %bool, align 1
  store %bool 0, %bool* %53, align 1
  %54 = load %bool, %bool* %53, align 1
  %55 = alloca %struct.user.Variable*, align 8
  %56 = call i8* @xmalloc(i64 8)
  %57 = bitcast i8* %56 to %struct.user.Variable*
  store %struct.user.Variable* %57, %struct.user.Variable** %55, align 8
  %58 = getelementptr inbounds %struct.user.Variable, %struct.user.Variable* %57, i32 0, i32 0
  store %struct.builtin.str* %0, %struct.builtin.str** %58, align 8;  !
  %59 = getelementptr inbounds %struct.user.Variable, %struct.user.Variable* %57, i32 0, i32 1
  store %struct.user.enum.Value* %52, %struct.user.enum.Value** %59, align 8;  !
  %60 = getelementptr inbounds %struct.user.Variable, %struct.user.Variable* %57, i32 0, i32 2
  store %bool %54, %bool* %60, align 8;  !
  %61 = bitcast %struct.builtin.list* @globals.variables to %struct.user.Variable***
  %62 = load %struct.user.Variable**, %struct.user.Variable*** %61, align 8
  %63 = getelementptr inbounds %struct.user.Variable*, %struct.user.Variable** %62, %num %51
  store %struct.user.Variable* %57, %struct.user.Variable** %63, align 8
  %64 = load %num, %num* %2, align 8
  %65 = bitcast %struct.builtin.list* @globals.variables to %struct.user.Variable***
  %66 = load %struct.user.Variable**, %struct.user.Variable*** %65, align 8
  %67 = getelementptr inbounds %struct.user.Variable*, %struct.user.Variable** %66, %num %64
  %68 = load %struct.user.Variable*, %struct.user.Variable** %67, align 8
  ret %struct.user.Variable* %68
}



