require 'php_serialize'
require 'dm-core'
require 'dm-types/support/dirty_minder'

module DataMapper
  class Property
    class SerializedPHP < Text
      load_as ::Object

      def load(value)
        if value.nil?
          nil
        elsif value.is_a?(::String)
          ::PHP.unserialize(value)
        else
          raise ArgumentError, '+value+ of a property of PHP type must be nil or a String'
        end
      end

      def dump(value)
        if value.nil?
          nil
        elsif value.is_a?(::String)
          value
        else
          ::PHP.serialize(value)
        end
      end

      def typecast(value)
        value
      end

      include ::DataMapper::Property::DirtyMinder
    end
  end
end
