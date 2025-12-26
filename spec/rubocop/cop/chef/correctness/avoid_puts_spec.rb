# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../../../lib/rubocop/cop/chef/correctness/avoid_puts'

RSpec.describe RuboCop::Cop::Chef::Correctness::AvoidPuts, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using puts' do
   
    expect_offense(<<~RUBY)
      puts "Doing something"
      ^^^^^^^^^^^^^^^^^^^^^^ Do not use puts in Chef recipes. Use the log resource or Chef::Log instead.
    RUBY
  end

  it 'does not register an offense when using log resource' do
    expect_no_offenses(<<~RUBY)
      log "Doing something"
    RUBY
  end

  # FIXED: Auto-correct tests must show the OFFENSE first, then the CORRECTION
  it 'autocorrects puts to log' do
    expect_offense(<<~RUBY)
      puts "Doing something"
      ^^^^^^^^^^^^^^^^^^^^^^ Do not use puts in Chef recipes. Use the log resource or Chef::Log instead.
    RUBY

    expect_correction(<<~RUBY)
      log "Doing something"
    RUBY
  end
end