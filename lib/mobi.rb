#-*- encoding: utf-8

# 依存するライブラリ
require "zip"

# 依存性のないファイル
require "./lib/mobi/parser/ruby"
require "./lib/mobi/parser/mathml"
require "./lib/mobi/opf/item-container"
require "./lib/mobi/opf/errors"
require "./lib/mobi/opf/node-base"

# 依存性のあるファイル
require "./lib/mobi/opf/package-node"
require "./lib/mobi/opf/metadata-node"
require "./lib/mobi/opf/manifest-node"

# ルーチン
# ZIPを解凍する
# コミックスと小説を判定する
#   小説
#       .mdファイルを変換し，除外する
# 