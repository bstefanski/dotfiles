#require 'pry-doc'
require 'pry-rails' if defined? Rails
#require 'hirb'

#Hirb.enable

#old_print = Pry.config.print
#Pry.config.print = proc do |output, value|
#  Hirb::View.view_or_page_output(value) || old_print.call(output, value)
#end

Pry.config.editor = "atom"

# This prompt shows the ruby version (useful for RVM)
# Ex: [1.9.3] 0:(main) >
prompt_proc = lambda do |obj, nest_level, _|
  ruby_info = ""
  ruby_info << "\e[32m#{Rails.version}\e[0m@" if defined?(Rails)
  ruby_info << "\e[31m#{RUBY_VERSION}\e[0m"
  ruby_info = ruby_info
  nest_info = "#{nest_level}"
  obj_info = "\e[33m#{obj}\e[0m"
  "[#{ruby_info}] #{nest_info}:(#{obj_info}) > "
end
Pry.prompt = [prompt_proc, prompt_proc]

def require_without_bundler gem_name
  _gem_path = Dir.glob("#{Gem.path.grep(/global$/).first}/gems/#{gem_name}*/lib").first
  if _gem_path
    $LOAD_PATH << _gem_path
    require gem_name
  else
    raise LoadError, "Please put #{gem_name} in your global"
  end
end

# pry-debundle
# Copyright (c) Conrad Irwin <conrad.irwin@gmail.com> -- MIT License
# Source: https://github.com/ConradIrwin/pry-debundle
#
# To install and use this:
#
# 1. Recommended
# Add 'pry' to your Gemfile (in the development group)
# Add 'pry-debundle' to your Gemfile (in the development group)
#
# 2. OK, if colleagues are wary of pry-debundle:
# Add 'pry' to your Gemfile (in the development group)
# Copy this file into ~/.pryrc
#
# 3. Meh, if colleagues don't like Pry at all:
# Copy this file into ~/.pryrc
# Create a wrapper script that runs `pry -r<your-application>`
#
# 4. Pants, if you don't like Pry:
# Copy the definition of the debundle! method into your ~/.irbrc
# Call 'debundle!' from IRB when you need to.
#
class << Pry

  # Break out of the Bundler jail.
  #
  # This can be used to load files in development that are not in your Gemfile (for
  # example if you want to test something with a tool that you have locally).
  #
  # @example
  # Pry.debundle!
  # require 'all_the_things'
  #
  # Normally you don't need to cal this directly though, as it is called for you when Pry
  # starts.
  #
  # See https://github.com/carlhuda/bundler/issues/183 for some background.
  #
  def debundle!
    return unless defined?(Bundler)
    loaded = false

    if rubygems_18_or_better?
      if Gem.post_reset_hooks.reject!{ |hook| hook.source_location.first =~ %r{/bundler/} }
        Bundler.preserve_gem_path
        Gem.clear_paths
        Gem::Specification.reset
        remove_bundler_monkeypatches
        loaded = true
      end

    # Rubygems 1.6 — TODO might be quite slow.
    elsif Gem.source_index && Gem.send(:class_variable_get, :@@source_index)
      Gem.source_index.refresh!
      remove_bundler_monkeypatches
      loaded = true

    else
      raise "No hacks found :("
    end
  rescue => e
    puts "Debundling failed: #{e.message}"
    puts "When reporting bugs to https://github.com/ConradIrwin/pry-debundle, please include:"
    puts "* gem version: #{Gem::VERSION rescue 'undefined'}"
    puts "* bundler version: #{Bundler::VERSION rescue 'undefined'}"
    puts "* pry version: #{Pry::VERSION rescue 'undefined'}"
    puts "* ruby version: #{RUBY_VERSION rescue 'undefined'}"
    puts "* ruby engine: #{RUBY_ENGINE rescue 'undefined'}"
  else
    load_additional_plugins if loaded
  end

  # After we've escaped from Bundler we want to look around and find any plugins the user
  # has installed locally but not added to their Gemfile.
  #
  def load_additional_plugins
    old_plugins = Pry.plugins.values
    Pry.locate_plugins
    new_plugins = Pry.plugins.values - old_plugins

    new_plugins.each(&:activate!)
  end

  private

  def rubygems_18_or_better?
    defined?(Gem.post_reset_hooks)
  end

  def rubygems_20_or_better?
    Gem::VERSION.to_i >= 2
  end

  # Ugh, this stuff is quite vile.
  def remove_bundler_monkeypatches
    if rubygems_20_or_better?
      load 'rubygems/core_ext/kernel_require.rb'
    else
      load 'rubygems/custom_require.rb'
    end

    if rubygems_18_or_better?
      Kernel.module_eval do
        def gem(gem_name, *requirements) # :doc:
          skip_list = (ENV['GEM_SKIP'] || "").split(/:/)
          raise Gem::LoadError, "skipping #{gem_name}" if skip_list.include? gem_name
          spec = Gem::Dependency.new(gem_name, *requirements).to_spec
          spec.activate if spec
        end
      end
    else
      Kernel.module_eval do
        def gem(gem_name, *requirements) # :doc:
          skip_list = (ENV['GEM_SKIP'] || "").split(/:/)
          raise Gem::LoadError, "skipping #{gem_name}" if skip_list.include? gem_name
          Gem.activate(gem_name, *requirements)
        end
      end
    end
  end
end

# Run just after a binding.pry, before you get dumped in the REPL.
# This handles the case where Bundler is loaded before Pry.
# NOTE: This hook happens *before* :before_session
Pry.config.hooks.add_hook(:when_started, :debundle){ Pry.debundle! }

# Run after every line of code typed.
# This handles the case where you load something that loads bundler
# into your Pry.
Pry.config.hooks.add_hook(:after_eval, :debundle){ Pry.debundle! }

Pry.debundle!

# Load 'awesome_print'
begin
  require 'awesome_print'
  # The following line enables awesome_print for all pry output,
  # and it also enables paging
  Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)}
  # If you want awesome_print without automatic pagination, use the line below
  # Pry.config.print = proc { |output, value| output.puts value.ai }
  AwesomePrint.pry!
rescue LoadError => err
  puts "awesome_print not loaded"
end

# Load 'hirb'
begin
  require 'hirb'

  Hirb.enable

  old_print = Pry.config.print
  Pry.config.print = proc do |output, value|
    Hirb::View.view_or_page_output(value) || old_print.call(output, value)
  end
rescue LoadError => err
  puts "hirb not loaded"
end
