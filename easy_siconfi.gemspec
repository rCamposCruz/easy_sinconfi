
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "easy_siconfi/version"

Gem::Specification.new do |spec|
  spec.name          = "easy_siconfi"
  spec.version       = EasySiconfi::VERSION
  spec.authors       = ["rCamposCruz"]
  spec.email         = ["rafaelcpcruz@hotmail.com"]

  spec.summary       = %q{Gem that facilitates access to SICONF.}
  spec.description   = %q{Through GETs, standardization, and interfaces, allows users to easily access and unpack     SICONF data.}
  spec.homepage      = "https://github.com/rCamposCruz/easy_sinconfi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
	spec.add_development_dependency "net", "~> 0.3"
	spec.add_development_dependency "json", "~> 2.2"
end
