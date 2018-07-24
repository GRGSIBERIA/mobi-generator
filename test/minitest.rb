require "minitest/autorun"


# テスト対象のロード
require "./lib/mobi/parser/ruby"
require "./lib/mobi/parser/mathml"

require "./lib/mobi/opf/errors"
require "./lib/mobi/opf/node-base"
require "./lib/mobi/opf/package-node"
require "./lib/mobi/opf/metadata-node"
require "./lib/mobi/opf/manifest-node"


# テスト本体
require "./test/mobi/parser/ruby-parser-test"

# texmathの実行ファイルにパスが通ってないとダメ
require "./test/mobi/parser/mathml-parser-test"

require "./test/mobi/opf/node-base-test"
require "./test/mobi/opf/package-node-test"
require "./test/mobi/opf/metadata-node-test"