# vim:fileencoding=utf-8
require File.expand_path('../lib/activerecord-hbase-adapter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jean Lescure"]
  gem.email         = ["jean@agilityfeat.com"]
  gem.description   = %q{HBase ActiveRecord adapter based on HipsterSqlToHbase}
  gem.summary       = %q{HBase ActiveRecord adapter based on HipsterSqlToHbase}
  gem.homepage      = %q{http://github.com/jeanlescure/activerecord-hbase-adapter}

  gem.files         = [ 'Gemfile',
                        'activerecord-hbase-adapter.gemspec',
                        'lib/activerecord-hbase-adapter/version.rb',
                        'lib/active_record/connection_adapters/hbase_adapter.rb',
                        'active_record/connection_adapters/abstract_mysql_adapter.rb',
                        'lib/active_record/connection_adapters/hbase/error.rb',
                        'lib/active_record/connection_adapters/hbase/result.rb',
                        'lib/active_record/connection_adapters/hbase/client.rb']
  #gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "activerecord-hbase-adapter"
  gem.require_paths = ["lib"]
  gem.version       = Activerecord::Hbase::Adapter::VERSION

  if gem.respond_to? :specification_version then
    gem.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      gem.add_runtime_dependency(%q<hipster_sql_to_hbase>, [">= 0"])
      gem.add_runtime_dependency(%q<httparty>, [">= 0"])
      gem.add_runtime_dependency(%q<msgpack>, [">= 0"])
      gem.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      gem.add_dependency(%q<hipster_sql_to_hbase>, [">= 0"])
      gem.add_dependency(%q<httparty>, [">= 0"])
      gem.add_dependency(%q<msgpack>, [">= 0"])
      gem.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    gem.add_dependency(%q<hipster_sql_to_hbase>, [">= 0"])
    gem.add_dependency(%q<httparty>, [">= 0"])
    gem.add_dependency(%q<msgpack>, [">= 0"])
    gem.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
