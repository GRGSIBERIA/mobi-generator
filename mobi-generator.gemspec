#-*- encoding: utf-8
$: << File.expand_path('../lib', __FILE__)
require './lib/version'

Gem::Specification.new do |s|
    s.name = "mobi-generator"
    s.version = Mobi::VERSION
    s.authors = ["Eiichi Takebuchi(GRGSIBERIA)"]
    s.email = ["nanashi4129@gmail.com"]
    s.summary = "ZIPで圧縮した連番ファイルをMOBIに変換するプロジェクト"
    s.description = "ZIPで圧縮した連番ファイルをMOBIに変換するプロジェクト"
    s.licenses = ["AGPL"]

    s.require_paths = ["lib"]

    s.add_development_dependency 'rake'
    
    s.add_runtime_dependency 'texmath-ruby'
    s.add_runtime_dependency 'rdiscount'
end