#coding:utf-8
require_dependency 'mail_handler'

module MailIntergrationPatch
  
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :dispatch, :more_intergration
    end
  end
  
  module InstanceMethods
    def dispatch_with_more_intergration
      # なぜかrakeタスクがここらへんの設定をしてくれないのでここで設定する
      @keywords ||= {}
      %w(project status tracker category priority).each { |a| @keywords[a.to_sym] = ENV[a] if ENV[a] }

      unless email.in_reply_to or email.references
        issue = dispatch_without_more_intergration
        return unless issue
      else
        msg = MailMessage.find_by_message_id(email.in_reply_to)
        msg = MailMessage.find_by_message_id(email.references) unless msg

        if msg
          journal = receive_issue_reply(msg.issue_id)
          issue = journal.issue
        else
          issue = dispatch_without_more_intergration
          return unless issue
        end
      end

      msg = MailMessage.find_by_message_id(email.message_id) || MailMessage.new
      msg.message_id = email.message_id
      msg.issue_id = issue.id
      msg.save!
    end
  end
end

