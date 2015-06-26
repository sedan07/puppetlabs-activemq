require 'spec_helper'

describe 'activemq::config::jetty_realm' do
  let(:title) { 'test' }
  let(:params) { {
    :username => 'demo',
    :password => 'guessme',
    :file     => '/etc/activemq/jetty-realm.properties',
    :realms   => [ 'guest' ]
  } }

  it { should contain_augeas('activemq/jetty-realm/demo').with({
    'incl' => '/etc/activemq/jetty-realm.properties',
    'lens' => 'JettyRealm.lns',
    'changes' => [
      'rm user/username[.="demo"]',
      'set user[last()+1]/username demo',
      'set user[last()]/password guessme',
      'set user[last()]/realm guest'
    ]
  })}
end
