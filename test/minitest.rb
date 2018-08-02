require "minitest/autorun"

#########################################################
# 依存するライブラリ
#
require "zip"

#########################################################
# テスト対象のロード
#

#
# 依存性のないファイル
#
require "./lib/mobi/parser/ruby"
require "./lib/mobi/parser/mathml"

require "./lib/mobi/opf/errors"
require "./lib/mobi/opf/item-container"
require "./lib/mobi/opf/node-base"

require "./lib/mobi/zip/mobi-compressor"
require "./lib/mobi/zip/zip-extractor"

#
# 依存性のあるファイル
#
require "./lib/mobi/opf/item-generator"
require "./lib/mobi/opf/package-node"
require "./lib/mobi/opf/metadata-node"
require "./lib/mobi/opf/manifest-node"
require "./lib/mobi/opf/opf-generator"

#
# テスト本体
#
require "./test/mobi/parser/ruby-parser-test"
require "./test/mobi/parser/mathml-parser-test" # texmathの実行ファイルにパスを通す


require "./test/mobi/opf/node-base-test"
require "./test/mobi/opf/package-node-test"
require "./test/mobi/opf/metadata-node-test"
require "./test/mobi/opf/item-container-test"
require "./test/mobi/opf/manifest-node-test"

#require "./test/mobi/zip/zip-extractor-test"
#require "./test/mobi/zip/mobi-compressor-test"