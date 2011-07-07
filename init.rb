require 'redmine'
require 'dispatcher'
require_dependency 'mail_intergration'

Redmine::Plugin.register :mail_intergration do
  name 'Redmine mail intergration plugin'
  author 'Yusuke Kokubo'
  description 'more mail intergration than redmine receive email.'
  version '0.0.1'
  
  requires_redmine :version_or_higher => '1.2.0'
end

# This was required for plugin to be included in development environment
Dispatcher.to_prepare do
  MailHandler.send(:include, MailIntergrationPatch)
end
