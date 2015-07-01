require 'spec_helper'

describe 'activemq::config::credentials' do
  let(:title) { 'test' }

    let(:params) { {
      :activemq_username => 'wrapper.logfile.loglevel',
      :activemq_password => 'DEBUG',
      :guest_password    => 'hello',
      :file     => '/opt/activemq/bin/linux-x86-64/wrapper.conf',
    } }

    it { should contain_augeas('activemq/wrapper/wrapper.logfile.loglevel').with({
      'incl' => '/opt/activemq/bin/linux-x86-64/wrapper.conf',
      'lens' => 'Properties.lns',
      'changes' => [
        'set wrapper.logfile.loglevel DEBUG',
      ]
    })}
end
