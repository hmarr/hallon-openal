require 'bundler/setup'
require 'hallon/openal'

describe Hallon::OpenAL do
  let(:klass)  { described_class }
  let(:format) { Hash.new }
  subject { klass.new }

  describe "#play" do
    it "should not raise an error" do
      expect { subject.play }.to_not raise_error
    end
  end

  describe "#stop" do
    it "should not raise an error" do
      expect { subject.stop }.to_not raise_error
    end
  end

  describe "#pause" do
    it "should not raise an error" do
      expect { subject.pause }.to_not raise_error
    end
  end

  describe "#drops" do
    it "should always return zero" do
      subject.drops.should be_zero
    end
  end

  describe "#format" do
    it "should be settable and gettable" do
      subject.format.should be_nil
      subject.format = format
      subject.format.should eq format
    end
  end

  describe ".default_device" do
    it "should return a string" do
      klass.default_device.should be_a String
    end
  end

  describe ".list_devices" do
    it "should return an array" do
      klass.list_devices.should be_a Array
    end
  end

  describe '.device' do
    subject { klass.device }

    context 'by default' do
      it { should == klass.default_device }
    end

    context 'when the device has been changed' do
      let(:device_name) { 'Other Device' }
      before { klass.device = device_name }
      it { should == device_name }
    end
  end
end
