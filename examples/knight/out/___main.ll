; Prelude
target triple = "x86_64-apple-macosx10.13.0"
%bool = type i64 ; used to be i8, this is just to simplify interfaces
%num = type i64
%struct.builtin.str = type { i8*, i64 } ; (ptr, len)
%struct.builtin.any = type { i8*, i64 } ; (ptr, type)
%struct.builtin.list = type { i8*, i64, i64 } ; (ptr, len, cap)

; Number builtins
declare %struct.builtin.str* @num_to_str(%num ) 
declare %num @powll(%num , %num )

; List builtins builtins
declare %struct.builtin.list* @allocate_list(i64 ) 
declare %struct.builtin.list* @concat_lists(%struct.builtin.list* , %struct.builtin.list* )
declare %struct.builtin.list* @repeat_list(%struct.builtin.list* , %num )
declare %bool @insert_into_list(%struct.builtin.list* , i64 , i8* )
declare %bool @delete_from_list(%struct.builtin.list* , i8* , i64 )

; String builtins
declare %struct.builtin.str* @allocate_str(i64 ) 
declare %num @str_to_num(%struct.builtin.str* ) 
declare %struct.builtin.str* @concat_strs(%struct.builtin.str* , %struct.builtin.str* ) 
declare %struct.builtin.str* @repeat_str(%struct.builtin.str* , %num ) 
declare i32 @compare_strs(%struct.builtin.str* , %struct.builtin.str* ) 
declare %struct.builtin.str* @substr(%struct.builtin.str* , i64 , i64 )
declare %struct.builtin.str* @ascii_to_str(%num )
declare %num @str_to_ascii(%struct.builtin.str* )

; Misc builtins
declare i8* @xmalloc(i64 )
declare void @print(%struct.builtin.str* ) 
declare %struct.builtin.str* @prompt() 
declare %num @random_()
declare void @quit(%num ) 
declare void @abort_msg(%struct.builtin.str* ) 

; Struct declarations


; Enum declarations


; Global declarations


; External declarations


; String declarations


; Functions


declare %num @fn.user.main(%struct.builtin.list* )

define %num @main() {
  %1 = call %num @fn.user.main(%struct.builtin.list* null);
  ret %num %1;
}

