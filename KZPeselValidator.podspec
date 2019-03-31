Pod::Spec.new do |s|
  s.name         = "KZPeselValidator"
  s.version      = "0.5"
  s.summary      = "Validator for Polish national identification number PESEL "
  s.description  = <<-DESC
    Validator for Polish national identification number PESEL

    Features
    * Validate PESEL number
    * Get sex of PESEL owner
    * Get birthdate of PESEL owner
  DESC
  s.homepage     = "https://github.com/konradzdunczyk/KZPeselValidator/"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Konrad Zdunczyk" => "konrad.zdunczyk@gmail.com" }
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.swift_version = "4.0"
  s.source       = { :git => "https://github.com/konradzdunczyk/KZPeselValidator.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
