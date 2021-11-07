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


; Functions


declare %num @fn.user.main(%struct.builtin.list* %0)

define %num @main() {
  %1 = call %num @fn.user.main(%struct.builtin.list* null);
  ret %num %1;
}

