# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "act_as_buddy"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["kannancet"]
  s.date = "2013-01-23"
  s.description = "This gem is used to implement self relation in a rails project for any table. The gem will automatically manage self relation implementation on mumtiple tables."
  s.email = "krxcet@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "lib/act_as_buddy.rb",
    "lib/act_as_buddy/buddeable.rb",
    "lib/act_as_buddy/railtie.rb",
    "lib/act_as_buddy/utils.rb",
    "lib/generators/USAGE",
    "lib/generators/act_as_buddy_generator.rb",
    "lib/generators/templates/migration.rb",
    "lib/generators/templates/model.rb"
  ]
  s.homepage = "http://github.com/kannancet/act_as_buddy"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A gem to implement self relation on any table."
  s.test_files = ["test/test_helper.rb", "test/test_buddy_functions.rb", "test/dummy_hooks/after_app_generator.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2.3"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<rcov>, ["= 0.9.11"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<activerecord>, [">= 3.1.0"])
      s.add_development_dependency(%q<rails>, [">= 0"])
      s.add_development_dependency(%q<dummier>, [">= 0.3.2"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.2.3"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<rcov>, ["= 0.9.11"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 3.1.0"])
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<dummier>, [">= 0.3.2"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.2.3"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<rcov>, ["= 0.9.11"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 3.1.0"])
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<dummier>, [">= 0.3.2"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end

