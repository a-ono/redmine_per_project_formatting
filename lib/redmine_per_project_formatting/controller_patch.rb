module RedminePerProjectFormatting
  module ControllerPatch
    def self.included(base)
      base.class_eval do
        unloadable
        before_filter :set_current_text_formatting
      end
    end

    def set_current_text_formatting
      format = Setting.current_text_formatting = @project.try(:text_formatting)
      return if format.blank? || @project.project_wide_formatting

      mod = case controller = params[:controller]
        when "issues" then "issue_tracking"
        when "journals" then "issue_tracking"
        when "wikis" then "wiki"
        when "messages" then "boards"
        when "previews"
          case params[:action]
          when "issue" then "issue_tracking"
          when "news" then "news"
          end
        else controller
      end

      unless @project.modules_for_formatting.to_a.include?(mod)
        Setting.current_text_formatting = nil
      end
    end
  end
end
