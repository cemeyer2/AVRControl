require 'rspec'
require '../lib/AVRControl'

describe 'Controlling my denon receiver' do

  before :each do
    @host = '192.168.1.75'
    @invoker = AVRControl::AVRInvoker.new(@host)
  end

  it 'should be able to power it off' do
    command = AVRControl::AVRCommand.new("PWSTANDBY")
    @invoker.invoke(command).should be_true
  end

  it 'should be able to query power' do
    command = AVRControl::AVRCommand.for :main_query
    command.should_not be_nil
    @invoker.invoke(command).should be_true
    puts command.response
    command.response.should_not be_nil
  end

  it 'should not allow commands without enough params' do
    command = AVRControl::AVRCommand.new('FOO', 5)
    expect {
      command.to_s
    }.to raise_error(ArgumentError)
  end

  it 'should allow commands with enough params' do
    cnt = 5
    command = AVRControl::AVRCommand.new('DEADBEEF', cnt)
    cnt.times { command << 'foo' }
    expect {
      command.to_s
    }.to_not raise_error
  end

end