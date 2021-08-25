module RedminePerProjectFormatting
  module MailerPatch
    def issue_add(user, issue)
      if p = Issue.where(:id => issue.id).first.try(:project)
        Setting.within_text_formatting(p.text_formatting_for(:issue_tracking)) do
          super
        end
      end
    end

    def issue_edit(user, journal)
      issue = journal.journalized
      if p = Issue.where(:id => issue.id).first.try(:project)
        Setting.within_text_formatting(p.text_formatting_for(:issue_tracking)) do
          super
        end
      end
    end

  end
end

