require 'rspec'
require '../lib/AVRControl'

describe 'Controlling my denon receiver' do

  it 'should be able to power it off' do

    invoker = AVRControl::AVRInvoker.new('192.168.1.75')
    command = AVRControl::AVRCommand.new('PWRSTANDBY')
    invoker.invoke(command)

  end
end