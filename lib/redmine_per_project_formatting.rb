require 'redmine_per_project_formatting/project_listener'

module RedminePerProjectFormatting
  def self.apply_patch
    require 'redmine_per_project_formatting/project_patch'
    require 'redmine_per_project_formatting/setting_patch'
    require 'redmine_per_project_formatting/controller_patch'
  end
end
