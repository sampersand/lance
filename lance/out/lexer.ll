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
%struct.user.Lexer = type { %struct.builtin.str*, %num, %struct.builtin.str*, %num }
%struct.user.TokenKind$Number = type { %num }
%struct.user.TokenKind$String = type { %struct.builtin.str* }
%struct.user.TokenKind$Identifier = type { %struct.builtin.str* }
%struct.user.TokenKind$Symbol = type { %struct.builtin.str* }
%struct.user.StreamPos = type { %num, %struct.builtin.str* }
%struct.user.Token = type { %struct.user.enum.TokenKind*, %struct.user.StreamPos* }

; Enum declarations
%struct.user.enum.TokenKind = type { i64, [8 x i8] }

; Global declarations


; External declarations
declare %bool @fn.user.string_contains(%struct.builtin.str*, %struct.builtin.str*)
declare %num @fn.user.count_char_occurrences(%struct.builtin.str*, %struct.builtin.str*)
declare void @fn.user.abort(%struct.builtin.str*)

; String declarations
@string.-1757590359328760056.str = private unnamed_addr constant [1 x i8] c":", align 1
@string.-1757590359328760056 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.-1757590359328760056.str, i32 0, i32 0), i64 1 }, align 8

@string.1260141971555858818.str = private unnamed_addr constant [0 x i8] c"", align 1
@string.1260141971555858818 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([0 x i8], [0 x i8]* @string.1260141971555858818.str, i32 0, i32 0), i64 0 }, align 8

@string.-4208788077235029184.str = private unnamed_addr constant [18 x i8] c"advancing past EOF", align 1
@string.-4208788077235029184 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([18 x i8], [18 x i8]* @string.-4208788077235029184.str, i32 0, i32 0), i64 18 }, align 8

@string.-1742558158085802614.str = private unnamed_addr constant [1 x i8] c"\0A", align 1
@string.-1742558158085802614 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.-1742558158085802614.str, i32 0, i32 0), i64 1 }, align 8

@string.-4180026235367867837.str = private unnamed_addr constant [5 x i8] c" \0A\09\0D\0C", align 1
@string.-4180026235367867837 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @string.-4180026235367867837.str, i32 0, i32 0), i64 5 }, align 8

@string.-2217190466276382044.str = private unnamed_addr constant [2 x i8] c"/*", align 1
@string.-2217190466276382044 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.-2217190466276382044.str, i32 0, i32 0), i64 2 }, align 8

@string.-1726298304654453038.str = private unnamed_addr constant [41 x i8] c"Missing closing `*/`. Comment started at ", align 1
@string.-1726298304654453038 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([41 x i8], [41 x i8]* @string.-1726298304654453038.str, i32 0, i32 0), i64 41 }, align 8

@string.1435830963709955007.str = private unnamed_addr constant [2 x i8] c"*/", align 1
@string.1435830963709955007 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.1435830963709955007.str, i32 0, i32 0), i64 2 }, align 8

@string.-2513005844087594796.str = private unnamed_addr constant [2 x i8] c"//", align 1
@string.-2513005844087594796 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.-2513005844087594796.str, i32 0, i32 0), i64 2 }, align 8

@string.2770592000206203416.str = private unnamed_addr constant [2 x i8] c": ", align 1
@string.2770592000206203416 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.2770592000206203416.str, i32 0, i32 0), i64 2 }, align 8

@string.2592926100660974330.str = private unnamed_addr constant [1 x i8] c"0", align 1
@string.2592926100660974330 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.2592926100660974330.str, i32 0, i32 0), i64 1 }, align 8

@string.910778915473643830.str = private unnamed_addr constant [1 x i8] c"9", align 1
@string.910778915473643830 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.910778915473643830.str, i32 0, i32 0), i64 1 }, align 8

@string.-4032468888101370109.str = private unnamed_addr constant [39 x i8] c"invalid suffix for number encountered: ", align 1
@string.-4032468888101370109 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([39 x i8], [39 x i8]* @string.-4032468888101370109.str, i32 0, i32 0), i64 39 }, align 8

@string.2942763563195962169.str = private unnamed_addr constant [4 x i8] c"oops", align 1
@string.2942763563195962169 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @string.2942763563195962169.str, i32 0, i32 0), i64 4 }, align 8

@string.549447362553987882.str = private unnamed_addr constant [49 x i8] c"//what\0A  /* in the\0A/*world is*/ happening*/  here", align 1
@string.549447362553987882 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([49 x i8], [49 x i8]* @string.549447362553987882.str, i32 0, i32 0), i64 49 }, align 8

@string.-347553302453449562.str = private unnamed_addr constant [1 x i8] c"!", align 1
@string.-347553302453449562 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.-347553302453449562.str, i32 0, i32 0), i64 1 }, align 8

@string.2518382205935613978.str = private unnamed_addr constant [4 x i8] c"here", align 1
@string.2518382205935613978 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @string.2518382205935613978.str, i32 0, i32 0), i64 4 }, align 8

@string.-3625442950589490249.str = private unnamed_addr constant [3 x i8] c"yup", align 1
@string.-3625442950589490249 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string.-3625442950589490249.str, i32 0, i32 0), i64 3 }, align 8

@string.1016392630143844927.str = private unnamed_addr constant [4 x i8] c"nope", align 1
@string.1016392630143844927 = private local_unnamed_addr global %struct.builtin.str { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @string.1016392630143844927.str, i32 0, i32 0), i64 4 }, align 8


; Functions
define %struct.user.Lexer* @fn.user.Lexer_new(%struct.builtin.str* %0, %struct.builtin.str* %1) {
  %3 = alloca %num, align 8
  store %num 0, %num* %3, align 8
  %4 = load %num, %num* %3, align 8
  %5 = alloca %num, align 8
  store %num 1, %num* %5, align 8
  %6 = load %num, %num* %5, align 8
  %7 = alloca %struct.user.Lexer*, align 8
  %8 = call i8* @xmalloc(i64 8)
  %9 = bitcast i8* %8 to %struct.user.Lexer*
  store %struct.user.Lexer* %9, %struct.user.Lexer** %7, align 8
  %10 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %9, i32 0, i32 0
  store %struct.builtin.str* %0, %struct.builtin.str** %10, align 8;  !
  %11 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %9, i32 0, i32 1
  store %num %4, %num* %11, align 8;  !
  %12 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %9, i32 0, i32 2
  store %struct.builtin.str* %1, %struct.builtin.str** %12, align 8;  !
  %13 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %9, i32 0, i32 3
  store %num %6, %num* %13, align 8;  !
  ret %struct.user.Lexer* %9
}

define %struct.user.StreamPos* @fn.user.Lexer.member.pos(%struct.user.Lexer* %0) {
  %2 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 3
  %3 = load %num, %num* %2, align 8
  %4 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 2
  %5 = load %struct.builtin.str*, %struct.builtin.str** %4, align 8
  %6 = alloca %struct.user.StreamPos*, align 8
  %7 = call i8* @xmalloc(i64 8)
  %8 = bitcast i8* %7 to %struct.user.StreamPos*
  store %struct.user.StreamPos* %8, %struct.user.StreamPos** %6, align 8
  %9 = getelementptr inbounds %struct.user.StreamPos, %struct.user.StreamPos* %8, i32 0, i32 0
  store %num %3, %num* %9, align 8;  !
  %10 = getelementptr inbounds %struct.user.StreamPos, %struct.user.StreamPos* %8, i32 0, i32 1
  store %struct.builtin.str* %5, %struct.builtin.str** %10, align 8;  !
  ret %struct.user.StreamPos* %8
}

define %struct.builtin.str* @fn.user.StreamPos.member.tostr(%struct.user.StreamPos* %0) {
  %2 = getelementptr inbounds %struct.user.StreamPos, %struct.user.StreamPos* %0, i32 0, i32 1
  %3 = load %struct.builtin.str*, %struct.builtin.str** %2, align 8
  %4 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-1757590359328760056, %struct.builtin.str** %4, align 8
  %5 = load %struct.builtin.str*, %struct.builtin.str** %4, align 8
  %6 = alloca %struct.builtin.str* (%num)*, align 8
  store %struct.builtin.str* (%num)* @num_to_str, %struct.builtin.str* (%num)** %6, align 8
  %7 = load %struct.builtin.str* (%num)*, %struct.builtin.str* (%num)** %6, align 8
  %8 = getelementptr inbounds %struct.user.StreamPos, %struct.user.StreamPos* %0, i32 0, i32 0
  %9 = load %num, %num* %8, align 8
  %10 = call %struct.builtin.str* %7(%num %9)
  %11 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %5, %struct.builtin.str* %10)
  %12 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %3, %struct.builtin.str* %11)
  ret %struct.builtin.str* %12
}

define internal %bool @fn.user.Lexer.member.is_eof(%struct.user.Lexer* %0) {
  %2 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 1
  %3 = load %num, %num* %2, align 8
  %4 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 0
  %5 = load %struct.builtin.str*, %struct.builtin.str** %4, align 8
  %6 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %5, i64 0, i32 1
  %7 = load i64, i64* %6, align 8
  %8 = icmp sge %num %3, %7
  %9 = zext i1 %8 to %bool
  ret %bool %9
}

define internal %struct.builtin.str* @fn.user.Lexer.member.peek(%struct.user.Lexer* %0) {
  %2 = alloca %bool (%struct.user.Lexer*)*, align 8
  store %bool (%struct.user.Lexer*)* @fn.user.Lexer.member.is_eof, %bool (%struct.user.Lexer*)** %2, align 8
  %3 = load %bool (%struct.user.Lexer*)*, %bool (%struct.user.Lexer*)** %2, align 8
  %4 = call %bool %3(%struct.user.Lexer* %0)
  %5 = icmp ne %bool %4, 0
  br i1 %5, label %6, label %10
  6:
  %7 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.1260141971555858818, %struct.builtin.str** %7, align 8
  %8 = load %struct.builtin.str*, %struct.builtin.str** %7, align 8
  ret %struct.builtin.str* %8
  br label %10
  10:
  %11 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 0
  %12 = load %struct.builtin.str*, %struct.builtin.str** %11, align 8
  %13 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 1
  %14 = load %num, %num* %13, align 8
  %15 = call %struct.builtin.str* @allocate_str(i64 1)
  %16 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %12, i64 0, i32 0
  %17 = load i8*, i8** %16, align 8
  %18 = getelementptr inbounds i8, i8* %17, i64 %14
  %19 = load i8, i8* %18, align 1
  %20 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %15, i64 0, i32 0
  %21 = load i8*, i8** %20, align 8
  %22 = getelementptr inbounds i8, i8* %21, i64 0
  store i8 %19, i8* %22, align 1
  ret %struct.builtin.str* %15
}

define internal void @fn.user.Lexer.member.advance(%struct.user.Lexer* %0) {
  %2 = alloca %bool (%struct.user.Lexer*)*, align 8
  store %bool (%struct.user.Lexer*)* @fn.user.Lexer.member.is_eof, %bool (%struct.user.Lexer*)** %2, align 8
  %3 = load %bool (%struct.user.Lexer*)*, %bool (%struct.user.Lexer*)** %2, align 8
  %4 = call %bool %3(%struct.user.Lexer* %0)
  %5 = icmp ne %bool %4, 0
  br i1 %5, label %6, label %11
  6:
  %7 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @fn.user.abort, void (%struct.builtin.str*)** %7, align 8
  %8 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %7, align 8
  %9 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-4208788077235029184, %struct.builtin.str** %9, align 8
  %10 = load %struct.builtin.str*, %struct.builtin.str** %9, align 8
  call void %8(%struct.builtin.str* %10)
  br label %11
  11:
  %12 = alloca %struct.builtin.str* (%struct.user.Lexer*)*, align 8
  store %struct.builtin.str* (%struct.user.Lexer*)* @fn.user.Lexer.member.peek, %struct.builtin.str* (%struct.user.Lexer*)** %12, align 8
  %13 = load %struct.builtin.str* (%struct.user.Lexer*)*, %struct.builtin.str* (%struct.user.Lexer*)** %12, align 8
  %14 = call %struct.builtin.str* %13(%struct.user.Lexer* %0)
  %15 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-1742558158085802614, %struct.builtin.str** %15, align 8
  %16 = load %struct.builtin.str*, %struct.builtin.str** %15, align 8
  %17 = call i32 @compare_strs(%struct.builtin.str* %14, %struct.builtin.str* %16)
  %18 = icmp eq i32 %17, 0
  %19 = zext i1 %18 to %bool
  %20 = icmp ne %bool %19, 0
  br i1 %20, label %21, label %28
  21:
  %22 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 3
  %23 = load %num, %num* %22, align 8
  %24 = alloca %num, align 8
  store %num 1, %num* %24, align 8
  %25 = load %num, %num* %24, align 8
  %26 = add nsw %num %23, %25
  %27 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 3
  store %num %26, %num* %27, align 8
  br label %28
  28:
  %29 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 1
  %30 = load %num, %num* %29, align 8
  %31 = alloca %num, align 8
  store %num 1, %num* %31, align 8
  %32 = load %num, %num* %31, align 8
  %33 = add nsw %num %30, %32
  %34 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 1
  store %num %33, %num* %34, align 8
  ret void
}

define internal %struct.builtin.str* @fn.user.Lexer.member.peek_advance(%struct.user.Lexer* %0) {
  %2 = alloca %struct.builtin.str*, align 8
  %3 = alloca %struct.builtin.str* (%struct.user.Lexer*)*, align 8
  store %struct.builtin.str* (%struct.user.Lexer*)* @fn.user.Lexer.member.peek, %struct.builtin.str* (%struct.user.Lexer*)** %3, align 8
  %4 = load %struct.builtin.str* (%struct.user.Lexer*)*, %struct.builtin.str* (%struct.user.Lexer*)** %3, align 8
  %5 = call %struct.builtin.str* %4(%struct.user.Lexer* %0)
  store %struct.builtin.str* %5, %struct.builtin.str** %2, align 8
  %6 = alloca void (%struct.user.Lexer*)*, align 8
  store void (%struct.user.Lexer*)* @fn.user.Lexer.member.advance, void (%struct.user.Lexer*)** %6, align 8
  %7 = load void (%struct.user.Lexer*)*, void (%struct.user.Lexer*)** %6, align 8
  call void %7(%struct.user.Lexer* %0)
  %8 = load %struct.builtin.str*, %struct.builtin.str** %2, align 8
  ret %struct.builtin.str* %8
}

define internal %bool @fn.user.Lexer.member.take_if_starts_with(%struct.user.Lexer* %0, %struct.builtin.str* %1) {
  %3 = alloca %num, align 8
  %4 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %1, i64 0, i32 1
  %5 = load i64, i64* %4, align 8
  store %num %5, %num* %3, align 8
  %6 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 0
  %7 = load %struct.builtin.str*, %struct.builtin.str** %6, align 8
  %8 = getelementptr inbounds %struct.builtin.str, %struct.builtin.str* %7, i64 0, i32 1
  %9 = load i64, i64* %8, align 8
  %10 = load %num, %num* %3, align 8
  %11 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 1
  %12 = load %num, %num* %11, align 8
  %13 = add nsw %num %10, %12
  %14 = icmp slt %num %9, %13
  %15 = zext i1 %14 to %bool
  %16 = icmp ne %bool %15, 0
  br i1 %16, label %17, label %21
  17:
  %18 = alloca %bool, align 1
  store %bool 0, %bool* %18, align 1
  %19 = load %bool, %bool* %18, align 1
  ret %bool %19
  br label %21
  21:
  %22 = alloca %struct.builtin.str* (%struct.builtin.str*, %num, %num)*, align 8
  store %struct.builtin.str* (%struct.builtin.str*, %num, %num)* @substr, %struct.builtin.str* (%struct.builtin.str*, %num, %num)** %22, align 8
  %23 = load %struct.builtin.str* (%struct.builtin.str*, %num, %num)*, %struct.builtin.str* (%struct.builtin.str*, %num, %num)** %22, align 8
  %24 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 0
  %25 = load %struct.builtin.str*, %struct.builtin.str** %24, align 8
  %26 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 1
  %27 = load %num, %num* %26, align 8
  %28 = load %num, %num* %3, align 8
  %29 = call %struct.builtin.str* %23(%struct.builtin.str* %25, %num %27, %num %28)
  %30 = call i32 @compare_strs(%struct.builtin.str* %29, %struct.builtin.str* %1)
  %31 = icmp eq i32 %30, 0
  %32 = zext i1 %31 to %bool
  %33 = icmp ne %bool %32, 0
  br i1 %33, label %34, label %52
  34:
  %35 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 3
  %36 = load %num, %num* %35, align 8
  %37 = alloca %num (%struct.builtin.str*, %struct.builtin.str*)*, align 8
  store %num (%struct.builtin.str*, %struct.builtin.str*)* @fn.user.count_char_occurrences, %num (%struct.builtin.str*, %struct.builtin.str*)** %37, align 8
  %38 = load %num (%struct.builtin.str*, %struct.builtin.str*)*, %num (%struct.builtin.str*, %struct.builtin.str*)** %37, align 8
  %39 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-1742558158085802614, %struct.builtin.str** %39, align 8
  %40 = load %struct.builtin.str*, %struct.builtin.str** %39, align 8
  %41 = call %num %38(%struct.builtin.str* %1, %struct.builtin.str* %40)
  %42 = add nsw %num %36, %41
  %43 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 3
  store %num %42, %num* %43, align 8
  %44 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 1
  %45 = load %num, %num* %44, align 8
  %46 = load %num, %num* %3, align 8
  %47 = add nsw %num %45, %46
  %48 = getelementptr inbounds %struct.user.Lexer, %struct.user.Lexer* %0, i32 0, i32 1
  store %num %47, %num* %48, align 8
  %49 = alloca %bool, align 1
  store %bool 1, %bool* %49, align 1
  %50 = load %bool, %bool* %49, align 1
  ret %bool %50
  br label %52
  52:
  %53 = alloca %bool, align 1
  store %bool 0, %bool* %53, align 1
  %54 = load %bool, %bool* %53, align 1
  ret %bool %54
}

define internal %bool @fn.user.iswhitespace(%struct.builtin.str* %0) {
  %2 = alloca %bool (%struct.builtin.str*, %struct.builtin.str*)*, align 8
  store %bool (%struct.builtin.str*, %struct.builtin.str*)* @fn.user.string_contains, %bool (%struct.builtin.str*, %struct.builtin.str*)** %2, align 8
  %3 = load %bool (%struct.builtin.str*, %struct.builtin.str*)*, %bool (%struct.builtin.str*, %struct.builtin.str*)** %2, align 8
  %4 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-4180026235367867837, %struct.builtin.str** %4, align 8
  %5 = load %struct.builtin.str*, %struct.builtin.str** %4, align 8
  %6 = call %bool %3(%struct.builtin.str* %5, %struct.builtin.str* %0)
  ret %bool %6
}

define internal void @fn.user.Lexer.member.strip(%struct.user.Lexer* %0) {
  br label %2
  2:
  %3 = alloca %bool, align 1
  store %bool 1, %bool* %3, align 1
  %4 = load %bool, %bool* %3, align 1
  %5 = icmp ne %bool %4, 0
  br i1 %5, label %6, label %124
  6:
  br label %7
  7:
  %8 = alloca %bool (%struct.builtin.str*)*, align 8
  store %bool (%struct.builtin.str*)* @fn.user.iswhitespace, %bool (%struct.builtin.str*)** %8, align 8
  %9 = load %bool (%struct.builtin.str*)*, %bool (%struct.builtin.str*)** %8, align 8
  %10 = alloca %struct.builtin.str* (%struct.user.Lexer*)*, align 8
  store %struct.builtin.str* (%struct.user.Lexer*)* @fn.user.Lexer.member.peek, %struct.builtin.str* (%struct.user.Lexer*)** %10, align 8
  %11 = load %struct.builtin.str* (%struct.user.Lexer*)*, %struct.builtin.str* (%struct.user.Lexer*)** %10, align 8
  %12 = call %struct.builtin.str* %11(%struct.user.Lexer* %0)
  %13 = call %bool %9(%struct.builtin.str* %12)
  %14 = icmp ne %bool %13, 0
  br i1 %14, label %15, label %18
  15:
  %16 = alloca void (%struct.user.Lexer*)*, align 8
  store void (%struct.user.Lexer*)* @fn.user.Lexer.member.advance, void (%struct.user.Lexer*)** %16, align 8
  %17 = load void (%struct.user.Lexer*)*, void (%struct.user.Lexer*)** %16, align 8
  call void %17(%struct.user.Lexer* %0)
  br label %7
  18:
  %19 = alloca %bool (%struct.user.Lexer*, %struct.builtin.str*)*, align 8
  store %bool (%struct.user.Lexer*, %struct.builtin.str*)* @fn.user.Lexer.member.take_if_starts_with, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %19, align 8
  %20 = load %bool (%struct.user.Lexer*, %struct.builtin.str*)*, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %19, align 8
  %21 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-2217190466276382044, %struct.builtin.str** %21, align 8
  %22 = load %struct.builtin.str*, %struct.builtin.str** %21, align 8
  %23 = call %bool %20(%struct.user.Lexer* %0, %struct.builtin.str* %22)
  %24 = icmp ne %bool %23, 0
  br i1 %24, label %25, label %85
  25:
  %26 = alloca %struct.user.StreamPos*, align 8
  %27 = alloca %struct.user.StreamPos* (%struct.user.Lexer*)*, align 8
  store %struct.user.StreamPos* (%struct.user.Lexer*)* @fn.user.Lexer.member.pos, %struct.user.StreamPos* (%struct.user.Lexer*)** %27, align 8
  %28 = load %struct.user.StreamPos* (%struct.user.Lexer*)*, %struct.user.StreamPos* (%struct.user.Lexer*)** %27, align 8
  %29 = call %struct.user.StreamPos* %28(%struct.user.Lexer* %0)
  store %struct.user.StreamPos* %29, %struct.user.StreamPos** %26, align 8
  %30 = alloca %num, align 8
  %31 = alloca %num, align 8
  store %num 1, %num* %31, align 8
  %32 = load %num, %num* %31, align 8
  store %num %32, %num* %30, align 8
  br label %33
  33:
  %34 = load %num, %num* %30, align 8
  %35 = alloca %num, align 8
  store %num 0, %num* %35, align 8
  %36 = load %num, %num* %35, align 8
  %37 = icmp ne %num %34, %36
  %38 = zext i1 %37 to %bool
  %39 = icmp ne %bool %38, 0
  br i1 %39, label %40, label %84
  40:
  %41 = alloca %bool (%struct.user.Lexer*)*, align 8
  store %bool (%struct.user.Lexer*)* @fn.user.Lexer.member.is_eof, %bool (%struct.user.Lexer*)** %41, align 8
  %42 = load %bool (%struct.user.Lexer*)*, %bool (%struct.user.Lexer*)** %41, align 8
  %43 = call %bool %42(%struct.user.Lexer* %0)
  %44 = icmp ne %bool %43, 0
  br i1 %44, label %45, label %55
  45:
  %46 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @fn.user.abort, void (%struct.builtin.str*)** %46, align 8
  %47 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %46, align 8
  %48 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-1726298304654453038, %struct.builtin.str** %48, align 8
  %49 = load %struct.builtin.str*, %struct.builtin.str** %48, align 8
  %50 = alloca %struct.builtin.str* (%struct.user.StreamPos*)*, align 8
  store %struct.builtin.str* (%struct.user.StreamPos*)* @fn.user.StreamPos.member.tostr, %struct.builtin.str* (%struct.user.StreamPos*)** %50, align 8
  %51 = load %struct.builtin.str* (%struct.user.StreamPos*)*, %struct.builtin.str* (%struct.user.StreamPos*)** %50, align 8
  %52 = load %struct.user.StreamPos*, %struct.user.StreamPos** %26, align 8
  %53 = call %struct.builtin.str* %51(%struct.user.StreamPos* %52)
  %54 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %49, %struct.builtin.str* %53)
  call void %47(%struct.builtin.str* %54)
  br label %55
  55:
  %56 = alloca %bool (%struct.user.Lexer*, %struct.builtin.str*)*, align 8
  store %bool (%struct.user.Lexer*, %struct.builtin.str*)* @fn.user.Lexer.member.take_if_starts_with, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %56, align 8
  %57 = load %bool (%struct.user.Lexer*, %struct.builtin.str*)*, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %56, align 8
  %58 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-2217190466276382044, %struct.builtin.str** %58, align 8
  %59 = load %struct.builtin.str*, %struct.builtin.str** %58, align 8
  %60 = call %bool %57(%struct.user.Lexer* %0, %struct.builtin.str* %59)
  %61 = icmp ne %bool %60, 0
  br i1 %61, label %62, label %67
  62:
  %63 = load %num, %num* %30, align 8
  %64 = alloca %num, align 8
  store %num 1, %num* %64, align 8
  %65 = load %num, %num* %64, align 8
  %66 = add nsw %num %63, %65
  store %num %66, %num* %30, align 8
  br label %83
  67:
  %68 = alloca %bool (%struct.user.Lexer*, %struct.builtin.str*)*, align 8
  store %bool (%struct.user.Lexer*, %struct.builtin.str*)* @fn.user.Lexer.member.take_if_starts_with, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %68, align 8
  %69 = load %bool (%struct.user.Lexer*, %struct.builtin.str*)*, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %68, align 8
  %70 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.1435830963709955007, %struct.builtin.str** %70, align 8
  %71 = load %struct.builtin.str*, %struct.builtin.str** %70, align 8
  %72 = call %bool %69(%struct.user.Lexer* %0, %struct.builtin.str* %71)
  %73 = icmp ne %bool %72, 0
  br i1 %73, label %74, label %79
  74:
  %75 = load %num, %num* %30, align 8
  %76 = alloca %num, align 8
  store %num 1, %num* %76, align 8
  %77 = load %num, %num* %76, align 8
  %78 = sub nsw %num %75, %77
  store %num %78, %num* %30, align 8
  br label %82
  79:
  %80 = alloca void (%struct.user.Lexer*)*, align 8
  store void (%struct.user.Lexer*)* @fn.user.Lexer.member.advance, void (%struct.user.Lexer*)** %80, align 8
  %81 = load void (%struct.user.Lexer*)*, void (%struct.user.Lexer*)** %80, align 8
  call void %81(%struct.user.Lexer* %0)
  br label %82
  82:
  br label %83
  83:
  br label %33
  84:
  br label %123
  85:
  %86 = alloca %bool (%struct.user.Lexer*, %struct.builtin.str*)*, align 8
  store %bool (%struct.user.Lexer*, %struct.builtin.str*)* @fn.user.Lexer.member.take_if_starts_with, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %86, align 8
  %87 = load %bool (%struct.user.Lexer*, %struct.builtin.str*)*, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %86, align 8
  %88 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-2513005844087594796, %struct.builtin.str** %88, align 8
  %89 = load %struct.builtin.str*, %struct.builtin.str** %88, align 8
  %90 = call %bool %87(%struct.user.Lexer* %0, %struct.builtin.str* %89)
  %91 = icmp ne %bool %90, 0
  br i1 %91, label %92, label %120
  92:
  br label %93
  93:
  %94 = alloca %bool, align 8
  %95 = alloca %bool (%struct.user.Lexer*)*, align 8
  store %bool (%struct.user.Lexer*)* @fn.user.Lexer.member.is_eof, %bool (%struct.user.Lexer*)** %95, align 8
  %96 = load %bool (%struct.user.Lexer*)*, %bool (%struct.user.Lexer*)** %95, align 8
  %97 = call %bool %96(%struct.user.Lexer* %0)
  %98 = icmp eq %num %97, 0
  %99 = zext i1 %98 to %bool
  %100 = icmp ne %bool %99, 0
  br i1 %100, label %101, label %110
  101:
  %102 = alloca %struct.builtin.str* (%struct.user.Lexer*)*, align 8
  store %struct.builtin.str* (%struct.user.Lexer*)* @fn.user.Lexer.member.peek, %struct.builtin.str* (%struct.user.Lexer*)** %102, align 8
  %103 = load %struct.builtin.str* (%struct.user.Lexer*)*, %struct.builtin.str* (%struct.user.Lexer*)** %102, align 8
  %104 = call %struct.builtin.str* %103(%struct.user.Lexer* %0)
  %105 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-1742558158085802614, %struct.builtin.str** %105, align 8
  %106 = load %struct.builtin.str*, %struct.builtin.str** %105, align 8
  %107 = call i32 @compare_strs(%struct.builtin.str* %104, %struct.builtin.str* %106)
  %108 = icmp ne i32 %107, 0
  %109 = zext i1 %108 to %bool
  store %bool %109, %bool* %94, align 8
  br label %113
  110:
  %111 = alloca %bool, align 1
  store %bool 0, %bool* %111, align 1
  %112 = load %bool, %bool* %111, align 1
  store %bool %112, %bool* %94, align 8
  br label %113
  113:
  %114 = load %bool, %bool* %94
  %115 = icmp ne %bool %114, 0
  br i1 %115, label %116, label %119
  116:
  %117 = alloca void (%struct.user.Lexer*)*, align 8
  store void (%struct.user.Lexer*)* @fn.user.Lexer.member.advance, void (%struct.user.Lexer*)** %117, align 8
  %118 = load void (%struct.user.Lexer*)*, void (%struct.user.Lexer*)** %117, align 8
  call void %118(%struct.user.Lexer* %0)
  br label %93
  119:
  br label %122
  120:
  br label %124
  121:
  br label %122
  122:
  br label %123
  123:
  br label %2
  124:
  ret void
}

define internal void @fn.user.StreamPos.member.abort(%struct.user.StreamPos* %0, %struct.builtin.str* %1) {
  %3 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @fn.user.abort, void (%struct.builtin.str*)** %3, align 8
  %4 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %3, align 8
  %5 = alloca %struct.builtin.str* (%struct.user.StreamPos*)*, align 8
  store %struct.builtin.str* (%struct.user.StreamPos*)* @fn.user.StreamPos.member.tostr, %struct.builtin.str* (%struct.user.StreamPos*)** %5, align 8
  %6 = load %struct.builtin.str* (%struct.user.StreamPos*)*, %struct.builtin.str* (%struct.user.StreamPos*)** %5, align 8
  %7 = call %struct.builtin.str* %6(%struct.user.StreamPos* %0)
  %8 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.2770592000206203416, %struct.builtin.str** %8, align 8
  %9 = load %struct.builtin.str*, %struct.builtin.str** %8, align 8
  %10 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %9, %struct.builtin.str* %1)
  %11 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %7, %struct.builtin.str* %10)
  call void %4(%struct.builtin.str* %11)
  ret void
}

define internal void @fn.user.Lexer.member.abort(%struct.user.Lexer* %0, %struct.builtin.str* %1) {
  %3 = alloca void (%struct.user.StreamPos*, %struct.builtin.str*)*, align 8
  store void (%struct.user.StreamPos*, %struct.builtin.str*)* @fn.user.StreamPos.member.abort, void (%struct.user.StreamPos*, %struct.builtin.str*)** %3, align 8
  %4 = load void (%struct.user.StreamPos*, %struct.builtin.str*)*, void (%struct.user.StreamPos*, %struct.builtin.str*)** %3, align 8
  %5 = alloca %struct.user.StreamPos* (%struct.user.Lexer*)*, align 8
  store %struct.user.StreamPos* (%struct.user.Lexer*)* @fn.user.Lexer.member.pos, %struct.user.StreamPos* (%struct.user.Lexer*)** %5, align 8
  %6 = load %struct.user.StreamPos* (%struct.user.Lexer*)*, %struct.user.StreamPos* (%struct.user.Lexer*)** %5, align 8
  %7 = call %struct.user.StreamPos* %6(%struct.user.Lexer* %0)
  call void %4(%struct.user.StreamPos* %7, %struct.builtin.str* %1)
  ret void
}

define internal %bool @fn.user.isdigit(%struct.builtin.str* %0) {
  %2 = alloca %bool, align 8
  %3 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.2592926100660974330, %struct.builtin.str** %3, align 8
  %4 = load %struct.builtin.str*, %struct.builtin.str** %3, align 8
  %5 = call i32 @compare_strs(%struct.builtin.str* %4, %struct.builtin.str* %0)
  %6 = icmp sle i32 %5, 0
  %7 = zext i1 %6 to %bool
  %8 = icmp ne %bool %7, 0
  br i1 %8, label %9, label %15
  9:
  %10 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.910778915473643830, %struct.builtin.str** %10, align 8
  %11 = load %struct.builtin.str*, %struct.builtin.str** %10, align 8
  %12 = call i32 @compare_strs(%struct.builtin.str* %0, %struct.builtin.str* %11)
  %13 = icmp sle i32 %12, 0
  %14 = zext i1 %13 to %bool
  store %bool %14, %bool* %2, align 8
  br label %18
  15:
  %16 = alloca %bool, align 1
  store %bool 0, %bool* %16, align 1
  %17 = load %bool, %bool* %16, align 1
  store %bool %17, %bool* %2, align 8
  br label %18
  18:
  %19 = load %bool, %bool* %2
  ret %bool %19
}

define internal %bool @fn.user.isalnum(%struct.builtin.str* %0) {
  %2 = alloca %bool, align 1
  store %bool 0, %bool* %2, align 1
  %3 = load %bool, %bool* %2, align 1
  ret %bool %3
}

define internal %struct.user.Token* @fn.user.Lexer.member.new_token(%struct.user.Lexer* %0, %struct.user.enum.TokenKind* %1) {
  %3 = alloca %struct.user.StreamPos* (%struct.user.Lexer*)*, align 8
  store %struct.user.StreamPos* (%struct.user.Lexer*)* @fn.user.Lexer.member.pos, %struct.user.StreamPos* (%struct.user.Lexer*)** %3, align 8
  %4 = load %struct.user.StreamPos* (%struct.user.Lexer*)*, %struct.user.StreamPos* (%struct.user.Lexer*)** %3, align 8
  %5 = call %struct.user.StreamPos* %4(%struct.user.Lexer* %0)
  %6 = alloca %struct.user.Token*, align 8
  %7 = call i8* @xmalloc(i64 8)
  %8 = bitcast i8* %7 to %struct.user.Token*
  store %struct.user.Token* %8, %struct.user.Token** %6, align 8
  %9 = getelementptr inbounds %struct.user.Token, %struct.user.Token* %8, i32 0, i32 0
  store %struct.user.enum.TokenKind* %1, %struct.user.enum.TokenKind** %9, align 8;  !
  %10 = getelementptr inbounds %struct.user.Token, %struct.user.Token* %8, i32 0, i32 1
  store %struct.user.StreamPos* %5, %struct.user.StreamPos** %10, align 8;  !
  ret %struct.user.Token* %8
}

define internal %struct.user.Token* @fn.user.Lexer.member.parse_number(%struct.user.Lexer* %0) {
  %2 = alloca %struct.builtin.str*, align 8
  %3 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.1260141971555858818, %struct.builtin.str** %3, align 8
  %4 = load %struct.builtin.str*, %struct.builtin.str** %3, align 8
  store %struct.builtin.str* %4, %struct.builtin.str** %2, align 8
  br label %5
  5:
  %6 = alloca %bool (%struct.builtin.str*)*, align 8
  store %bool (%struct.builtin.str*)* @fn.user.isdigit, %bool (%struct.builtin.str*)** %6, align 8
  %7 = load %bool (%struct.builtin.str*)*, %bool (%struct.builtin.str*)** %6, align 8
  %8 = alloca %struct.builtin.str* (%struct.user.Lexer*)*, align 8
  store %struct.builtin.str* (%struct.user.Lexer*)* @fn.user.Lexer.member.peek, %struct.builtin.str* (%struct.user.Lexer*)** %8, align 8
  %9 = load %struct.builtin.str* (%struct.user.Lexer*)*, %struct.builtin.str* (%struct.user.Lexer*)** %8, align 8
  %10 = call %struct.builtin.str* %9(%struct.user.Lexer* %0)
  %11 = call %bool %7(%struct.builtin.str* %10)
  %12 = icmp ne %bool %11, 0
  br i1 %12, label %13, label %21
  13:
  %14 = load %struct.builtin.str*, %struct.builtin.str** %2, align 8
  %15 = alloca %struct.builtin.str* (%struct.user.Lexer*)*, align 8
  store %struct.builtin.str* (%struct.user.Lexer*)* @fn.user.Lexer.member.peek, %struct.builtin.str* (%struct.user.Lexer*)** %15, align 8
  %16 = load %struct.builtin.str* (%struct.user.Lexer*)*, %struct.builtin.str* (%struct.user.Lexer*)** %15, align 8
  %17 = call %struct.builtin.str* %16(%struct.user.Lexer* %0)
  %18 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %14, %struct.builtin.str* %17)
  store %struct.builtin.str* %18, %struct.builtin.str** %2, align 8
  %19 = alloca void (%struct.user.Lexer*)*, align 8
  store void (%struct.user.Lexer*)* @fn.user.Lexer.member.advance, void (%struct.user.Lexer*)** %19, align 8
  %20 = load void (%struct.user.Lexer*)*, void (%struct.user.Lexer*)** %19, align 8
  call void %20(%struct.user.Lexer* %0)
  br label %5
  21:
  %22 = alloca %bool (%struct.builtin.str*)*, align 8
  store %bool (%struct.builtin.str*)* @fn.user.isalnum, %bool (%struct.builtin.str*)** %22, align 8
  %23 = load %bool (%struct.builtin.str*)*, %bool (%struct.builtin.str*)** %22, align 8
  %24 = alloca %struct.builtin.str* (%struct.user.Lexer*)*, align 8
  store %struct.builtin.str* (%struct.user.Lexer*)* @fn.user.Lexer.member.peek, %struct.builtin.str* (%struct.user.Lexer*)** %24, align 8
  %25 = load %struct.builtin.str* (%struct.user.Lexer*)*, %struct.builtin.str* (%struct.user.Lexer*)** %24, align 8
  %26 = call %struct.builtin.str* %25(%struct.user.Lexer* %0)
  %27 = call %bool %23(%struct.builtin.str* %26)
  %28 = icmp ne %bool %27, 0
  br i1 %28, label %29, label %38
  29:
  %30 = alloca void (%struct.user.Lexer*, %struct.builtin.str*)*, align 8
  store void (%struct.user.Lexer*, %struct.builtin.str*)* @fn.user.Lexer.member.abort, void (%struct.user.Lexer*, %struct.builtin.str*)** %30, align 8
  %31 = load void (%struct.user.Lexer*, %struct.builtin.str*)*, void (%struct.user.Lexer*, %struct.builtin.str*)** %30, align 8
  %32 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-4032468888101370109, %struct.builtin.str** %32, align 8
  %33 = load %struct.builtin.str*, %struct.builtin.str** %32, align 8
  %34 = alloca %struct.builtin.str* (%struct.user.Lexer*)*, align 8
  store %struct.builtin.str* (%struct.user.Lexer*)* @fn.user.Lexer.member.peek, %struct.builtin.str* (%struct.user.Lexer*)** %34, align 8
  %35 = load %struct.builtin.str* (%struct.user.Lexer*)*, %struct.builtin.str* (%struct.user.Lexer*)** %34, align 8
  %36 = call %struct.builtin.str* %35(%struct.user.Lexer* %0)
  %37 = call %struct.builtin.str* @concat_strs(%struct.builtin.str* %33, %struct.builtin.str* %36)
  call void %31(%struct.user.Lexer* %0, %struct.builtin.str* %37)
  br label %38
  38:
  %39 = alloca %struct.user.enum.TokenKind*, align 8
  %40 = alloca %num, align 8
  store %num 0, %num* %40, align 8
  %41 = load %num, %num* %40, align 8
  %42 = alloca %num (%struct.builtin.str*)*, align 8
  store %num (%struct.builtin.str*)* @str_to_num, %num (%struct.builtin.str*)** %42, align 8
  %43 = load %num (%struct.builtin.str*)*, %num (%struct.builtin.str*)** %42, align 8
  %44 = load %struct.builtin.str*, %struct.builtin.str** %2, align 8
  %45 = call %num %43(%struct.builtin.str* %44)
  %46 = alloca %struct.user.TokenKind$Number*, align 8
  %47 = call i8* @xmalloc(i64 8)
  %48 = bitcast i8* %47 to %struct.user.TokenKind$Number*
  store %struct.user.TokenKind$Number* %48, %struct.user.TokenKind$Number** %46, align 8
  %49 = getelementptr inbounds %struct.user.TokenKind$Number, %struct.user.TokenKind$Number* %48, i32 0, i32 0
  store %num %45, %num* %49, align 8;  !
  %50 = alloca %struct.user.enum.TokenKind*, align 8
  %51 = call i8* @xmalloc(i64 8)
  %52 = bitcast i8* %51 to %struct.user.enum.TokenKind*
  store %struct.user.enum.TokenKind* %52, %struct.user.enum.TokenKind** %50, align 8
  %53 = getelementptr inbounds %struct.user.enum.TokenKind, %struct.user.enum.TokenKind* %52, i32 0, i32 0
  store %num %41, %num* %53, align 8;  !
  %54 = getelementptr inbounds %struct.user.enum.TokenKind, %struct.user.enum.TokenKind* %52, i32 0, i32 1
  %55 = bitcast [8 x i8]* %54 to %struct.user.TokenKind$Number**
  store %struct.user.TokenKind$Number* %48, %struct.user.TokenKind$Number** %55, align 8;  !
  store %struct.user.enum.TokenKind* %52, %struct.user.enum.TokenKind** %39, align 8
  %56 = alloca %struct.user.Token* (%struct.user.Lexer*, %struct.user.enum.TokenKind*)*, align 8
  store %struct.user.Token* (%struct.user.Lexer*, %struct.user.enum.TokenKind*)* @fn.user.Lexer.member.new_token, %struct.user.Token* (%struct.user.Lexer*, %struct.user.enum.TokenKind*)** %56, align 8
  %57 = load %struct.user.Token* (%struct.user.Lexer*, %struct.user.enum.TokenKind*)*, %struct.user.Token* (%struct.user.Lexer*, %struct.user.enum.TokenKind*)** %56, align 8
  %58 = load %struct.user.enum.TokenKind*, %struct.user.enum.TokenKind** %39, align 8
  %59 = call %struct.user.Token* %57(%struct.user.Lexer* %0, %struct.user.enum.TokenKind* %58)
  ret %struct.user.Token* %59
}

define internal %struct.user.Token* @fn.user.Lexer.member.next(%struct.user.Lexer* %0) {
  %2 = alloca void (%struct.user.Lexer*)*, align 8
  store void (%struct.user.Lexer*)* @fn.user.Lexer.member.strip, void (%struct.user.Lexer*)** %2, align 8
  %3 = load void (%struct.user.Lexer*)*, void (%struct.user.Lexer*)** %2, align 8
  call void %3(%struct.user.Lexer* %0)
  %4 = alloca %struct.builtin.str*, align 8
  %5 = alloca %struct.builtin.str* (%struct.user.Lexer*)*, align 8
  store %struct.builtin.str* (%struct.user.Lexer*)* @fn.user.Lexer.member.peek, %struct.builtin.str* (%struct.user.Lexer*)** %5, align 8
  %6 = load %struct.builtin.str* (%struct.user.Lexer*)*, %struct.builtin.str* (%struct.user.Lexer*)** %5, align 8
  %7 = call %struct.builtin.str* %6(%struct.user.Lexer* %0)
  store %struct.builtin.str* %7, %struct.builtin.str** %4, align 8
  %8 = alloca %bool (%struct.builtin.str*)*, align 8
  store %bool (%struct.builtin.str*)* @fn.user.isdigit, %bool (%struct.builtin.str*)** %8, align 8
  %9 = load %bool (%struct.builtin.str*)*, %bool (%struct.builtin.str*)** %8, align 8
  %10 = load %struct.builtin.str*, %struct.builtin.str** %4, align 8
  %11 = call %bool %9(%struct.builtin.str* %10)
  %12 = icmp ne %bool %11, 0
  br i1 %12, label %13, label %18
  13:
  %14 = alloca %struct.user.Token* (%struct.user.Lexer*)*, align 8
  store %struct.user.Token* (%struct.user.Lexer*)* @fn.user.Lexer.member.parse_number, %struct.user.Token* (%struct.user.Lexer*)** %14, align 8
  %15 = load %struct.user.Token* (%struct.user.Lexer*)*, %struct.user.Token* (%struct.user.Lexer*)** %14, align 8
  %16 = call %struct.user.Token* %15(%struct.user.Lexer* %0)
  ret %struct.user.Token* %16
  br label %18
  18:
  %19 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @fn.user.abort, void (%struct.builtin.str*)** %19, align 8
  %20 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %19, align 8
  %21 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.2942763563195962169, %struct.builtin.str** %21, align 8
  %22 = load %struct.builtin.str*, %struct.builtin.str** %21, align 8
  call void %20(%struct.builtin.str* %22)
  %23 = alloca %struct.user.Token*, align 8
  %24 = call i8* @xmalloc(i64 8)
  %25 = bitcast i8* %24 to %struct.user.Token*
  store %struct.user.Token* %25, %struct.user.Token** %23, align 8
  ret %struct.user.Token* %25
}

define %num @fn.user.main() {
  %1 = alloca %struct.user.Lexer*, align 8
  %2 = alloca %struct.user.Lexer* (%struct.builtin.str*, %struct.builtin.str*)*, align 8
  store %struct.user.Lexer* (%struct.builtin.str*, %struct.builtin.str*)* @fn.user.Lexer_new, %struct.user.Lexer* (%struct.builtin.str*, %struct.builtin.str*)** %2, align 8
  %3 = load %struct.user.Lexer* (%struct.builtin.str*, %struct.builtin.str*)*, %struct.user.Lexer* (%struct.builtin.str*, %struct.builtin.str*)** %2, align 8
  %4 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.549447362553987882, %struct.builtin.str** %4, align 8
  %5 = load %struct.builtin.str*, %struct.builtin.str** %4, align 8
  %6 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-347553302453449562, %struct.builtin.str** %6, align 8
  %7 = load %struct.builtin.str*, %struct.builtin.str** %6, align 8
  %8 = call %struct.user.Lexer* %3(%struct.builtin.str* %5, %struct.builtin.str* %7)
  store %struct.user.Lexer* %8, %struct.user.Lexer** %1, align 8
  %9 = alloca void (%struct.user.Lexer*)*, align 8
  store void (%struct.user.Lexer*)* @fn.user.Lexer.member.strip, void (%struct.user.Lexer*)** %9, align 8
  %10 = load void (%struct.user.Lexer*)*, void (%struct.user.Lexer*)** %9, align 8
  %11 = load %struct.user.Lexer*, %struct.user.Lexer** %1, align 8
  call void %10(%struct.user.Lexer* %11)
  %12 = alloca void (%struct.builtin.str*)*, align 8
  store void (%struct.builtin.str*)* @print, void (%struct.builtin.str*)** %12, align 8
  %13 = load void (%struct.builtin.str*)*, void (%struct.builtin.str*)** %12, align 8
  %14 = alloca %struct.builtin.str*, align 8
  %15 = alloca %bool (%struct.user.Lexer*, %struct.builtin.str*)*, align 8
  store %bool (%struct.user.Lexer*, %struct.builtin.str*)* @fn.user.Lexer.member.take_if_starts_with, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %15, align 8
  %16 = load %bool (%struct.user.Lexer*, %struct.builtin.str*)*, %bool (%struct.user.Lexer*, %struct.builtin.str*)** %15, align 8
  %17 = load %struct.user.Lexer*, %struct.user.Lexer** %1, align 8
  %18 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.2518382205935613978, %struct.builtin.str** %18, align 8
  %19 = load %struct.builtin.str*, %struct.builtin.str** %18, align 8
  %20 = call %bool %16(%struct.user.Lexer* %17, %struct.builtin.str* %19)
  %21 = icmp ne %bool %20, 0
  br i1 %21, label %22, label %25
  22:
  %23 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.-3625442950589490249, %struct.builtin.str** %23, align 8
  %24 = load %struct.builtin.str*, %struct.builtin.str** %23, align 8
  store %struct.builtin.str* %24, %struct.builtin.str** %14, align 8
  br label %28
  25:
  %26 = alloca %struct.builtin.str*, align 8
  store %struct.builtin.str* @string.1016392630143844927, %struct.builtin.str** %26, align 8
  %27 = load %struct.builtin.str*, %struct.builtin.str** %26, align 8
  store %struct.builtin.str* %27, %struct.builtin.str** %14, align 8
  br label %28
  28:
  %29 = load %struct.builtin.str*, %struct.builtin.str** %14
  call void %13(%struct.builtin.str* %29)
  %30 = alloca %num, align 8
  store %num 0, %num* %30, align 8
  %31 = load %num, %num* %30, align 8
  ret %num %31
}



