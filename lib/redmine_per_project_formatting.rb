require 'redmine_per_project_formatting/project_listener'
require 'redmine_per_project_formatting/application_controller_patch'
require 'redmine_per_project_formatting/project_patch'
require 'redmine_per_project_formatting/setting_patch'

module RedminePerProjectFormatting
  def self.apply_patch
    ::ApplicationController.prepend ApplicationControllerPatch
    ::Project.send :include, ProjectPatch
    ::Setting.singleton_class.prepend SettingPatch
    if defined?(RedmineCkeditor)
      require 'redmine_per_project_formatting/mail_handler_patch'
      require 'redmine_per_project_formatting/mailer_patch'
      ::MailHandler.prepend MailHandlerPatch
      ::Mailer.prepend MailerPatch
    end
  end
end

