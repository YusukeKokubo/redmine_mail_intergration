class MailMessage < ActiveRecord::Base
    unloadable
    belongs_to :issue
end

