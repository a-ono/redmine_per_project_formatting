require_dependency 'setting'

module RedminePerProjectFormatting
  module SettingPatch
    def self.included(base)
      base.extend ClassMethods

      base.class_eval do
        unloadable
        class << self
          alias_method_chain :text_formatting, :per_project
        end
      end
    end

    module ClassMethods
      def text_formatting_with_per_project
        current_text_formatting || text_formatting_without_per_project
      end

      def current_text_formatting
        Thread.current[:current_text_formatting]
      end

      def current_text_formatting=(format)
        Thread.current[:current_text_formatting] = format.present? ? format : nil
      end
    end
  end

  Setting.send(:include, SettingPatch)
end
