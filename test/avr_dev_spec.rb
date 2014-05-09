require 'rspec'
require 'AVRControl'

describe 'Controlling my denon receiver' do

  before :each do
    @context = AVRControl::AVRContext.new('192.168.1.75')
    @invoker = AVRControl::AVRInvoker.new(@context)
  end

  after :each do
    sleep 1
  end

  it 'should be able to power it off' do
    command = AVRControl::AVRCommand.new("PWSTANDBY")
    @invoker.invoke(command).should be_true
  end

  it 'should be able to query power' do
    command = AVRControl::AVRCommand.for :main_query
    command.should_not be_nil
    @invoker.invoke(command).should be_true
    command.response.should_not be_nil
  end

  it 'should be able to power it on' do
    command = AVRControl::AVRCommand.for :power_on
    @invoker.invoke(command).should be_true
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
    @invoker.invoke(command).should be_true
  end

  it 'should not allow invalid commands' do
    expect {
      AVRControl::AVRCommand.for :this_doesnt_exist
    }.to raise_error ArgumentError
  end

  it 'should be able to do look for upnp' do
    require 'playful/ssdp'
    obj = Playful::SSDP.search
    obj
  end
end