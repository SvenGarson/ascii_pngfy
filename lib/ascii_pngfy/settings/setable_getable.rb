# frozen_string_literal: true

module AsciiPngfy
  module Settings
    # Provides the interface for all the Setting implementations in a way that
    # each inclusion of this module forces the including class to override
    # the behaviour for #set and #get
    module SetableGetable
      def get
        self_class_name = self.class.to_s

        expected_error_message = String.new
        expected_error_message << "#{self_class_name}#get has not yet been implemented. "
        expected_error_message << "Must override the #{self_class_name}#get method in order to "
        expected_error_message << 'function as Setting.'

        raise NotImplementedError, expected_error_message
      end

      def set
        self_class_name = self.class.to_s

        expected_error_message = String.new
        expected_error_message << "#{self_class_name}#set has not yet been implemented. "
        expected_error_message << "Must override the #{self_class_name}#set method in order to "
        expected_error_message << 'function as Setting.'

        raise NotImplementedError, expected_error_message
      end
    end
  end
end
