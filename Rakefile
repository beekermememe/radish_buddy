# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'radish_buddy'
  app.icons = ["radsmall.png"]
  app.pods do
    pod 'AFNetworking'
  end

  app.provisioning_profile = '/Users/beeker/Library/MobileDevice/Provisioning Profiles/9867D9C3-8FC2-400E-9DE6-0CEF40C39C77.mobileprovision'
  app.codesign_certificate = 'iPhone Developer: Brendan Keogh (BN6W9Z52PD)'
end
