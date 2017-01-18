require 'rspec'
require 'AVRControl'

describe 'Controlling my denon receiver' do

  before :each do
    @context = AVRControl::AVRContext.new('192.168.1.110')
    @invoker = AVRControl::AVRInvoker.new(@context)
  end

  after :each do
    sleep 1
  end

  it 'should be able to power it off' do
    command = AVRControl::AVRCommand.new("PWSTANDBY")
    @invoker.invoke(command).should be_truthy
  end

  it 'should be able to query power' do
    command = AVRControl::AVRCommand.for :main_query
    command.should_not be_nil
    @invoker.invoke(command).should be_truthy
    command.response.should_not be_nil
  end

  it 'should be able to power it on' do
    command = AVRControl::AVRCommand.for :power_on
    @invoker.invoke(command).should be_truthy
  end

  it 'should not allow commands when they require parameters but none are specified' do
    command = AVRControl::AVRCommand.new('FOO', 5)
    expect {
      command.to_s
    }.to raise_error(ArgumentError)
  end

  it 'should not allow commands when they require parameters but less than the required number are specified' do
    command = AVRControl::AVRCommand.new('FOO', 5)
    expect {
      command << 'bar'
      command << 'baz'
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

  it 'should only emit ASCII commands' do
    expect {
      cmd = AVRControl::AVRCommand.new('FOO', 2)
      cmd << "zɐq"
      cmd << "zɐq"
      cmd.to_s
    }.to raise_error Encoding::UndefinedConversionError
  end

  it 'should allow compound commands' do
    cmd = AVRControl::AVRCompoundCommand.new('MV', 1)
    cmd << '80'
    cmd.to_s.should == "MV80\r"
  end

  it 'should allow compound commands with more than one param' do
    cmd = AVRControl::AVRCompoundCommand.new('MV', 2)
    cmd << '80'
    cmd << '40'
    cmd.to_s.should == "MV80 40\r"
  end

  it 'should instantiate the proper command type based off of the config' do
    cmd = AVRControl::AVRCommand.for :main_volume_set
    cmd.should be_an_instance_of AVRControl::AVRCompoundCommand
    cmd = AVRControl::AVRCommand.for :power_on
    cmd.should be_an_instance_of AVRControl::AVRCommand
  end

  it 'should be able to set the volume' do
    command = AVRControl::AVRCommand.for :main_volume_set
    command << '40'
    @invoker.invoke(command).should be_truthy
  end

  it 'should not allow invalid commands' do
    expect {
      AVRControl::AVRCommand.for :this_doesnt_exist
    }.to raise_error ArgumentError
  end

  it 'should respond that there are no parameters on a command when none have been specified' do
    command = AVRControl::AVRCommand.new('FOO', 10)
    command.param_count.should eql 0
    command << 'bar'
    command.param_count.should eql 1
  end

  it 'should be able to discover denon receivers on the local network' do
    receivers = AVRControl::AVRContext.discover
    receivers.first.host.should eql '192.168.1.110'
  end
end