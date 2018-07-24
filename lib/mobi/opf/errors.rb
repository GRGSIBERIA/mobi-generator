#-*- encoding: utf-8

module Mobi
    module OPF
        # OPF関連の親エラークラス
        class OPFError < StandardError; end

        # 強制する属性が存在しない場合に発生するエラー
        class RequiredAttributeError < OPFError; end 

        # 子要素から見て無関係の親要素が存在するときに発生するエラー
        class DontMatchParentError < OPFError; end
    end
end