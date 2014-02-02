require_dependency 'application_helper'

module RedminePerProjectFormatting
  module ApplicationHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :textilizable, :per_project
      end
    end

    module InstanceMethods
      def textilizable_with_per_project(*args)
        options = args.last.is_a?(Hash) ? args.last : {}
        obj = options[:object] || args.first 
        project = options[:project] || @project || if obj.is_a?(Project)
          obj
        elsif obj.respond_to?(:project)
          obj.project
        end

        if project.try(:project_wide_formatting) && Setting.current_text_formatting.nil?
          Setting.within_text_formatting(project.text_formatting) do
            textilizable_without_per_project(*args)
          end
        else
          textilizable_without_per_project(*args)
        end
      end
    end
  end

  ApplicationHelper.send(:include, ApplicationHelperPatch)
end
