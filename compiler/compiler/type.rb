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
      }

      def to_s
        @name
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
    end

    class Function < Type
      attr_reader :args, :return_type

      def initialize(args, return_type)
        @args = args
        @return_type = return_type
      end

      def hash
        @hash ||= [@args, @return_type].hash
      end

      def ==(rhs)
        rhs.is_a?(Function) && args == rhs.args && fields == rhs.fields
      end

      alias eql? ==

      def inspect
        "Type::Function(#{@args.inspect}, #{@return_type.inspect})"
      end
    end
  end
end
