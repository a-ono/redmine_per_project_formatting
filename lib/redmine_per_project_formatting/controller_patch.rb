module RedminePerProjectFormatting
  module ControllerPatch
    @@_patched = {}

    def self.included(base)
      base.class_eval do
        unloadable

        after_filter :reset_current_text_formatting

        def initialize
          # Ugly hack: We want to append the filter to the last of before filters from ApplicationController
          unless @@_patched[self.class]
            self.class.before_filter :set_current_text_formatting
            @@_patched[self.class] = true
          end
          super
        end
      end
    end

    def set_current_text_formatting
      format = Setting.current_text_formatting = @project.try(:text_formatting)
      return if format.blank? || @project.project_wide_formatting

      modules = @project.modules_for_formatting.to_a.map(&:to_sym)
      permissions = Redmine::AccessControl.permissions.select {|p| modules.include?(p.project_module)}
      actions = permissions.flat_map(&:actions)
      unless actions.include?("#{params[:controller]}/#{params[:action]}")
        reset_current_text_formatting
      end
    end

    def reset_current_text_formatting
      Setting.current_text_formatting = nil
    end
  end
end
