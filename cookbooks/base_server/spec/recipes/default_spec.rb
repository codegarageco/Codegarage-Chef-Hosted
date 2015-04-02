require_relative '../spec_helper'

describe 'base_server::default' do
  subject { ChefSpec::SoloRunner.converge(described_recipe) }

  it { expect(subject).to run_bash('apt update') }
  it { expect(subject).to install_package('git') }
  it { expect(subject).to install_package('emacs') }
  it { expect(subject).to install_package('curl') }
  it { expect(subject).to install_package('zlib1g-dev') }
  it { expect(subject).to install_package('liblzma-dev') }
  it { expect(subject).to install_package('zlibc') }
  it { expect(subject).to install_package('ruby-dev') }
  it { expect(subject).to install_package('make') }
  it { expect(subject).to install_package('build-essential') }
  it { expect(subject).to install_package('libpq-dev') }
  it { expect(subject).to install_package('libmagickwand-dev') }
end
