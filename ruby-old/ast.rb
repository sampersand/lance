module Ast
  Global = Struct.new :name, :kind
  Import = Struct.new :file
  Function = Struct.new :name, :args, :ret_type, :body
  
  If = Struct.new :cond, :body, :else
  While = Struct.new :cond, :body
  Return = Struct.new :value # value is optional
  Do = Struct.new :expr
  Let = Struct.new :name, :kind, :value
  Set = Struct.new :name, :indices, :kind, :value # indices is optional

  BinaryOperator = Struct.new :lhs, :op, :rhs
  Unary = Struct.new :op, :value
  Literal = Struct.new :value
  FunctionCall = Struct.new :fn, :args
  ArrayIndex = Struct.new :ary, :expr
end

puts