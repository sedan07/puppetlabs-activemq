require 'spec_helper'

describe 'activemq::config::jetty' do
  let(:title) { 'test' }

    let(:params) { {
      :admin_authentication => true,
      :user_authentication  => false,
      :file     => '/opt/activemq/conf/jetty.xml',
    } }

    it { should contain_augeas('activemq/jetty/admin_access').with({
      'incl' => '/opt/activemq/conf/jetty.xml',
      'lens' => 'Xml.lns',
      'changes' => [
        'set beans/bean[ #attribute/id = "adminSecurityConstraint" ]/property[ #attribute/name = "authenticate" ]/#attribute/value true',
      ]
    })}

    it { should contain_augeas('activemq/jetty/user_access').with({
      'incl' => '/opt/activemq/conf/jetty.xml',
      'lens' => 'Xml.lns',
      'changes' => [
        'set beans/bean[ #attribute/id = "securityConstraint" ]/property[ #attribute/name = "authenticate" ]/#attribute/value false',
      ]
    })}
end
