class Compiler
  class Type
    class Primitive
      def initialize(name)
        @name = name
      end

      singleton_class.send :private, :new

      def self.lookup(name)
        TYPES[name]
      end

      TYPES = {
        'void' => (Void = new 'void'),
        'num' => (Num = new 'num'),
        'str' => (Str = new 'str'),
        'bool' => (Bool = new 'bool'),
        'any' => (Any = new 'any'),
      }

      def llvm_type(_llvm)
        case @name
        when 'void' then 'void'
        when 'num' then '%num'
        when 'bool' then '%bool'
        when 'str' then '%struct.builtin.str*'
        when 'any' then '%struct.builtin.any*'
        else raise "bad type: #@name (?)"
        end
      end

      def default(_llvm)
        case @name
        when 'num', 'bool' then '0'
        when 'str', 'any' then 'null' # { i8* null, i64 0 }'
        else raise "bad type for default: #{name}"
        end
      end

      def inspect
        "Type::Primitive::#{@name.capitalize}"
      end
    end

    class Array < Type
      attr_reader :inner

      def initialize(inner)
        @inner = inner
      end

      def hash
        @hash ||= inner.hash
      end

      def ==(rhs)
        rhs.is_a?(Array) && inner == rhs.inner
      end

      alias eql? ==

      def inspect
        "Type::Array(#{@inner.inspect})"
      end

      def llvm_type(llvm)
        llvm.array_type inner
      end

      def default(llvm)
        'null' # "{ #{inner.llvm_type llvm}* null, i64 0, i64 0 }"
      end
    end

    class Struct < Type
      attr_reader :name, :fields

      def initialize(name, fields)
        @name = name
        @fields = fields
      end

      def hash
        @hash ||= @name.hash
      end

      def ==(rhs)
        case rhs
        when Struct then name == rhs.name && fields == rhs.fields
        when String then name == rhs
        else false
        end
      end

      alias eql? ==

      def inspect
        "Type::Struct(#{@name.inspect}, #{@fields.inspect})"
      end

      def llvm_type(llvm)
        llvm.struct_type name, fields.values
      end

      def default(llvm)
        'null'
        #"{ #{@fields.values.map {|v| "#{v.llvm_type llvm} #{v.default llvm}" }.join ', ' } }"
      end
    end

    class Function < Type
      attr_reader :args, :return_type

      def initialize(args, return_type)
        @args = args
        @return_type = return_type || Primitive::Void
      end

      def hash
        @hash ||= [@args, @return_type].hash
      end

      def ==(rhs)
        rhs.is_a?(Function) && args == rhs.args && return_type == rhs.return_type
      end

      alias eql? ==

      def inspect
        "Type::Function(#{@args.inspect}, #{@return_type.inspect})"
      end

      def llvm_type(llvm)
        "#{return_type.llvm_type llvm} (#{args.map{|a| a.llvm_type llvm}.join ', '})*"
      end

      def default(_llvm)
        "null"
      end
    end
  end
end
