require 'json'

package = JSON.parse(File.read(File.join(__dir__, '..', 'package.json')))

Pod::Spec.new do |s|
  s.name         = 'FlexibleRazorPay'
  s.version      = package['version']
  s.summary      = package['description']
  s.description  = package['description']
  s.license      = package['license']
  s.author       = package['author']
  s.homepage     = package['homepage']

  s.platforms    = { :ios => '13.0' }
  s.swift_version = '5.4'

  # local source
  s.source       = { :path => '.' }

  s.source_files = 'ios/**/*.{swift,h,m}'
  s.requires_arc = true

  s.dependency 'React-Core'
  s.dependency 'razorpay-pod'
end
