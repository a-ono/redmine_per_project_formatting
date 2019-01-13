module RedminePerProjectFormatting
  module ApplicationControllerPatch
    @@_patched = {}

    def initialize
      # Ugly hack: We want to append the filter to the last of around actions from ApplicationController
      unless @@_patched[self.class]
        self.class.around_action :change_text_formatting
        @@_patched[self.class] = true
      end
      super
    end

    def change_text_formatting
      format = @project.try(:text_formatting)
      if format.present? && !@project.project_wide_formatting
        modules = @project.modules_for_formatting.to_a.map(&:to_sym)
        permissions = Redmine::AccessControl.permissions.select {|p| modules.include?(p.project_module)}
        actions = permissions.flat_map(&:actions)
        format = nil unless actions.include?("#{params[:controller]}/#{params[:action]}")
      end

      Setting.within_text_formatting(format) do
        yield
      end
    end
  end
end
