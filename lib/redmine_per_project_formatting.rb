require File.expand_path('../redmine_per_project_formatting/project_listener', __FILE__)
require File.expand_path('../redmine_per_project_formatting/application_controller_patch', __FILE__)
require File.expand_path('../redmine_per_project_formatting/project_patch', __FILE__)
require File.expand_path('../redmine_per_project_formatting/setting_patch', __FILE__)

module RedminePerProjectFormatting
  def self.apply_patch
    ::ApplicationController.prepend ApplicationControllerPatch
    ::Project.send :include, ProjectPatch
    ::Setting.singleton_class.prepend SettingPatch
    if defined?(RedmineCkeditor)
      require 'redmine_per_project_formatting/mail_handler_patch'
      ::MailHandler.prepend MailHandlerPatch
    end
  end
end
