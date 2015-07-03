require 'spec_helper'

describe 'activemq::config::credentials' do
  let(:title) { 'test' }

    let(:params) { {
      :activemq_username => 'system',
      :activemq_password => 'Password',
      :guest_password    => 'guessme',
      :file     => '/opt/activemq/conf/credentials.properties',
    } }

    it { should contain_augeas('activemq/credentials').with({
      'incl' => '/opt/activemq/conf/credentials.properties',
      'lens' => 'Properties.lns',
      'changes' => [
        "set activemq.username system",
        "set activemq.password Password",
        "set guest.password guessme",
      ]
    })}
end
