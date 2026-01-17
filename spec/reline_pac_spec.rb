# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RelinePac do
  it 'has a version number' do
    expect(RelinePac::VERSION).not_to be_nil
  end

  describe '.configure' do
    it 'installs packages and delegates keybind to Reline config' do
      reline_config = instance_double(RelineConfig)

      expect(RelinePac::Packages).to receive(:install_all)
      allow(Reline).to receive(:send).with(:core).and_return(double(config: reline_config))
      expect(reline_config).to receive(:add_default_key_binding).with([18], :fzf_history)

      described_class.configure do |config|
        config.add_keybind("\C-r", :fzf_history)
      end
    end
  end
end
