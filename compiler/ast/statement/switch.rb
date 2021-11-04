require_relative '../expression'

class Statement
  class Switch
    class TypeName
    end

    def initialize(cond, branches, default)
      @cond = cond
      @branches = branches
      @default = default
    end

    def self.parse(parser)
      parser.guard 'switch' or return

      cond = Expression.parse(parser) or parser.error "missing expression for `switch`"
      parser.expect '{', err: 'missing starting `{` for `switch`'

      branches = []
      default = nil

      until parser.guard '}'
        parser.error 'eof encountered before closing `}`' if parser.eof?
        parser.expect 'case', err: 'missing `case` for `switch` body'
        parser.error '`case` encountered after default case' if default

        if (name = parser.guard :identifier)
          kind = TypeDecl.parse parser
        else
          kind = nil
        end

        body = Statements.parse(parser) or parser.error 'expected brace statements after case'

        if kind
          branches.push [name, kind, body]
        else
          default = body
        end
      end

      new cond, branches, default
    end

    def compile
      enum = @cond.llvm_type
      raise "can only switch on enums" unless enum.is_a? Compiler::Type::Enum

      cond = @cond.compile type: enum
      casted = $fn.write :new, "bitcast #{enum} #{cond} to i64*"
      kind = $fn.write :new, "load i64, i64* #{casted}"
        # tmp1 = $fn.write :new, "bitcast %struct.builtin.list* #{ary} to #{inner_type}**"
      # $fn.write "store "

      targets = @branches.map do |_, type, _|
        ltype = type.llvm_type
        $fn.validate_types expected: enum, given: ltype.enum
        cmp = $fn.write :new, "icmp eq i64 #{kind}, #{ltype.idx}"
        [$fn.write_nop, cmp, $fn.declare_label]
      end

      jmp_to_end = $fn.write_nop

      jmps = @branches.zip(targets).map do |(name, type, body), (jmp_lbl, jmp_cmp, jmp_nxt)|
        jmp_lbl.write "br i1 #{jmp_cmp}, label #{$fn.declare_label}, label #{jmp_nxt}"

        ltype = type.llvm_type
        tmp = $fn.write :new, "getelementptr inbounds i64, i64* #{casted}, i64 1"
        $fn.define_variable name, ltype, local: $fn.write(:new, "bitcast i64* #{tmp} to #{ltype}*")
        body.compile
        $fn.write_nop
      end

      if @default
        jmp_to_end.write "br label #{$fn.declare_label}"
        @default.compile
        jmp_to_end = $fn.write_nop
      end

      last = $fn.declare_label
      jmp_to_end.write "br label #{last}"
      jmps.each do |jmp|
        jmp.write "br label #{last}"
      end
    end
  end
end
