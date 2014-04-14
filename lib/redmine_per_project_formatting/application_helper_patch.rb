require 'application_helper'
module ApplicationHelper
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

  alias_method_chain :textilizable, :per_project
end
