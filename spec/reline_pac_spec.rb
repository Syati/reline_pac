# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RelinePac do
  it 'has a version number' do
    expect(RelinePac::VERSION).not_to be_nil
  end

  describe '.configure' do
    it 'installs packages and delegates keybind to Reline config' do
      reline_config = double('RelineConfig', add_default_key_binding: nil) # rubocop:disable RSpec/VerifiedDoubles

      allow(RelinePac::Packages).to receive(:install_all)
      allow(Reline).to receive(:core).and_return(double(config: reline_config))

      described_class.configure do |config|
        config.add_keybind("\C-r", :fzf_history)
      end

      expect(RelinePac::Packages).to have_received(:install_all)
      expect(reline_config).to have_received(:add_default_key_binding).with([18], :fzf_history)
    end
  end
end
