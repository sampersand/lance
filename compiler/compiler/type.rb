class Compiler
  class Type
    def llvm_type
      self
    end

    def align
      8
    end

    class Primitive < Type
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

      def name
        @name
      end

      def to_s
        case @name
        when 'void' then 'void'
        when 'num' then '%num'
        when 'bool' then '%bool'
        when 'str' then '%struct.builtin.str*'
        when 'any' then '%struct.builtin.any*'
        else raise "bad type: #@name (?)"
        end
      end

      def default
        case @name
        when 'num', 'bool' then '0'
        when 'str', 'any' then 'null' # { i8* null, i64 0 }'
        else raise "bad type for default: #{name}"
        end
      end

      def align
        byte_length
      end

      def byte_length
        8
        # @name == 'bool' ? 1 : 8 # everything else is a pointer, or already 64 bit
      end

      def inspect
        "Type::Primitive::#{@name.capitalize}"
      end
    end

    class List < Type
      attr_reader :inner

      def initialize(inner)
        @inner = inner
      end

      def name
        'list'
      end

      def hash
        @hash ||= inner.hash
      end

      def ==(rhs)
        return false unless rhs.is_a? List
        (inner == :empty || rhs.inner == :empty) || inner == rhs.inner
      end

      alias eql? ==

      def inspect
        "Type::List(#{@inner.inspect})"
      end

      def to_s
        '%struct.builtin.list*'
      end

      def default
        'null'
      end

      def byte_length
        8
      end
    end

    class Struct < Type
      attr_reader :name, :fields

      def initialize(name, fields)
        @name = name.to_s
        @fields = fields.transform_values(&:llvm_type)
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
        if $DEBUG
          "Type::Struct(#{@name.inspect}, #{@fields.inspect})"
        else
          "Type::Struct(#{@name.inspect})"
        end
      end

      def to_s
        $llvm.struct_type name, fields
      end

      def default
        'null'
      end

      def byte_length
        @fields.values.map(&:byte_length).reduce(0, &:+)
      end
    end

    class Enum < Type
      attr_reader :name

      def initialize(name, variants)
        @name = name.to_s
        @variants_ = variants
      end

      def variants
        @variants ||= @variants_.each_with_index.map { |s, i| Variant.new(self, i, s.llvm_type) }
      end

      def hash
        @hash ||= @name.hash
      end

      def position(name)
        variants.index { |var| var.struct.name == "#@name-#{name}" }
      end

      def ==(rhs)
        case rhs
        when Enum then @name == rhs.name && variants == rhs.variants
        when Variant then rhs.enum == self
        else false
        end
      end

      alias eql? ==

      def inspect
        if $DEBUG
          "Type::Enum(#{@name.inspect}, #{variants.inspect})"
        else
          "Type::Enum(#{@name.inspect})"
        end
      end

      def to_s
        $llvm.enum_type name, variants
      end

      def default
        'null'
      end

      def byte_length
        8 + variants.map(&:byte_length).max
      end

      def variants_length
        @variants_length ||= variants.map { |x| x.fields.length }.max * 8 # todo: non-8
      end


      class Variant < Type
        attr_reader :enum, :idx, :struct

        def initialize(enum, idx, struct)
          @enum = enum
          @idx = idx
          @struct = struct
          raise "bad name: #{struct.name}" if struct.name !~ /-/
        end

        def name
          @struct.name
        end

        def fields
          @struct.fields
        end

        def hash
          raise
          @hash ||= @name.hash
        end

        def ==(rhs)
          case rhs
          when Variant then rhs.enum == @enum && rhs.idx == @idx && rhs.struct == @struct
          when Enum then @enum == rhs
          else false
          end
        end

        alias eql? ==

        def inspect
          if $DEBUG
            "Type::Variant(#{@enum.name.inspect}, #{name.inspect}=#{@idx.inspect}, #{@struct.inspect})"
          else
            "Type::Variant(#{@enum.name.inspect}, #{name.inspect})"
          end
        end

        def to_s
          $llvm.struct_type name, fields
        end

        def llvm_type
          @enum
        end

        def default
          'null'
        end

        def byte_length
          @struct.byte_length
        end
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
        return true if rhs == :any
        return false unless rhs.is_a? Function
        args.zip(rhs.args).all? {|l, r| l == :any || r == :any || l == r} &&
          (return_type == :any || rhs.return_type == :any || return_type == rhs.return_type)
      end

      alias eql? ==

      def inspect
        "Type::Function(#{@args.inspect}, #{@return_type.inspect})"
      end

      def to_s
        "#{return_type} (#{args.join ', '})*"
      end

      def default
        "null"
      end

      def byte_length
        8
      end
    end
  end
end
