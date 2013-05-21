module RedminePerProjectFormatting
  class ProjectListener < Redmine::Hook::ViewListener
    def view_projects_form(context)
      f = context[:form]
      content_tag :p, f.select(:text_formatting,
        Redmine::WikiFormatting.format_names.map {|f| [f, f.to_s]},
        :include_blank => true, :label => :setting_text_formatting
      )
    end
  end
end
