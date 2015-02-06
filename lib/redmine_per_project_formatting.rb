require 'redmine_per_project_formatting/project_listener'

module RedminePerProjectFormatting
  def self.apply_patch
    require 'redmine_per_project_formatting/application_helper_patch'
    require 'redmine_per_project_formatting/project_patch'
    require 'redmine_per_project_formatting/setting_patch'
    require 'redmine_per_project_formatting/controller_patch'
    Project.send(:include, ProjectPatch)
    Setting.send(:include, SettingPatch)
    ApplicationController.send(:include, ControllerPatch)
    require 'redmine_per_project_formatting/mail_handler_patch' if defined?(RedmineCkeditor)
  end
end
