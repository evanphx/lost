# -*- ruby -*-

require 'rubygems'
require 'hoe'
require "rake/extensiontask"

Hoe.plugin :minitest

Hoe.spec 'lost' do
  developer('Evan Phoenix', 'evan@phx.io')

  Rake::ExtensionTask.new "lost", spec do |ext|
    ext.lib_dir = 'lib'
  end
end

# vim: syntax=ruby
