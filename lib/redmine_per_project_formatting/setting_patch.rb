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
        format = current_project.try(:text_formatting)
        format.blank? ? text_formatting_without_per_project : format
      end

      def current_project
        Thread.current[:current_project]
      end

      def current_project=(project)
        Thread.current[:current_project] = project
      end
    end
  end

  Setting.send(:include, SettingPatch)
end
