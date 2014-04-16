require 'rspec'
require '../lib/AVRControl'

describe 'Controlling my denon receiver' do

  it 'should be able to power it off' do

    invoker = AVRControl::AVRInvoker.new('192.168.1.75')
    command = AVRControl::AVRCommand.new("PWSTANDBY")
    invoker.invoke(command).should be_true
  end

  it 'should be able to query power' do
    invoker = AVRControl::AVRInvoker.new('192.168.1.75')
    command = AVRControl::AVRCommand.for :main_query
    command.should_not be_nil
    invoker.invoke(command).should be_true
    puts command.response
    command.response.should_not be_nil
  end

  it 'should not allow commands without enough params' do
    command = AVRControl::AVRCommand.new('FOO', 5)
    expect {
      command.to_s
    }.to raise_error(ArgumentError)
  end

end