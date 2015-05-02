module RedminePerProjectFormatting
  class ProjectListener < Redmine::Hook::ViewListener
    def view_projects_form(context)
      p = context[:project]
      f = context[:form]
      options = p.module_options
      default_formatting = Setting.text_formatting_without_per_project
      content_tag(:p, f.select(:text_formatting,
        Redmine::WikiFormatting.format_names.map {|n| [n, n.to_s]},
        :include_blank => "Redmine setting (#{default_formatting})", :label => :setting_text_formatting
      )) +
      content_tag(:p,
        label_tag(:project_wide_formatting, I18n.t(:project_wide_formatting)) +
        check_box_tag(nil, nil, p.project_wide_formatting, :id => :project_wide_formatting)
      ) +
      content_tag(:p, f.select(:modules_for_formatting, options,
        {}, {:multiple => true, :size => options.size}
      )) +
      javascript_tag(
        <<-EOT
          $(function() {
            var checkbox = $("#project_wide_formatting");
            var select = $("#project_modules_for_formatting");
            checkbox.change(function() {
              if (checkbox.is(":checked")) {
                select.val("").parent().hide();
              } else {
                select.parent().show();
              }
            });
            $("#project_text_formatting").change(function() {
              if ($(this).val()) {
                checkbox.change().parent().show();
              } else {
                checkbox.parent().hide();
                select.parent().hide();
              } 
            }).change();
          });
        EOT
      )
    end
  end
end
