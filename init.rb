require 'redmine'
require_dependency 'mail_intergration'

Redmine::Plugin.register :mail_intergration do
  name 'Redmine mail intergration plugin'
  author 'Masatoshi TSUCHIYA'
  description 'more mail intergration than redmine receive email.'
  version '0.0.2'
  requires_redmine :version_or_higher => '4.0'
end

# This was required for plugin to be included in development environment
((Rails.version > "5")? ActiveSupport::Reloader : ActionDispatch::Callbacks).to_prepare do
  MailHandler.send(:include, MailIntergrationPatch)
end
