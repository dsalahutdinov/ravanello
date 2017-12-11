# frozen_string_literal: true

require 'ravanello'
require 'ravanello/analyze'
require 'thor'

module Ravanello
  # Dispatches command line commands
  class Cli < Thor
    default_task :analyze

    desc 'analyze', 'Run redis analyze'
    method_option :rules, desc: 'Path to file with grouping keys rules'

    def analyze
      Analyze.new(options).call
    end

    map %w[--version -v] => :__print_version
    desc '--version, -v', 'Print gem version'
    def __print_version
      puts VERSION
    end
  end
end
