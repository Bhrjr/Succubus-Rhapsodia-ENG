#==============================================================================
# ■ RPG::Class
#------------------------------------------------------------------------------
# 　名称の判別用。
#==============================================================================
module RPG
  class Class
    #--------------------------------------------------------------------------
    # ● 習得スキル
    #--------------------------------------------------------------------------
    def bonus
      #------------------------------------------------------------------------
      # ■■　概要
      # 　0:スキル　1:素質　2:ルーン　3:その他
      #------------------------------------------------------------------------
      # 初期スキル
      group = []
      #------------------------------------------------------------------------
      # ■■共通第１項（名前変更など）
      #------------------------------------------------------------------------
      # 名称変更（ボス夢魔は除く）
      if self.id < 250 
        group += [[20, 3, 0]]
      end
      # レベルアップ
      group += [[-1, 3, 1]]
      # 呼び名を変える
      group += [[0, 3, 2,nil,nil,"寵愛"]]

      # クラスIDから個別習得スキルを追加
      case self.name
      #------------------------------------------------------------------------
      # ■■サキュバス種
      #------------------------------------------------------------------------
      when "Lesser Succubus ","Succubus","Succubus Lord "
        # チャーム
        group.push([300, 0, 200])
        # ペイド・チャーム （Lv20）
        group.push([2000, 0, 201, 20])
        # ラスト
        group.push([300, 0, 202])
        # ペイド・ラスト （Lv20）
        group.push([1500, 0, 203, 20])
        # フィルス
        group.push([300, 0, 204])
        # ペイド・フィルス （Lv20）
        group.push([1500, 0, 205, 20])
        # プライスオブシナー（Lv30）
        group.push([3000, 0, 363, 30])
        # ラブフレグランス
        group.push([1500, 0, 625])
        #【濡れやすい】
        group.push([100, 1, 106])
        #【柔軟】
        group.push([400, 1, 112])
        #【熟練】
        group.push([1200, 1, 124]) 
        # 【カリスマ】（サキュバスロード）
        group.push([1500, 1, 73]) if self.name == "Succubus Lord " 
        #【最高の姿】
        group.push([5000, 1, 50, 30]) 

      #------------------------------------------------------------------------
      # ■■デビル種
      #------------------------------------------------------------------------
      when "Iｍp","Devil ","Deｍon"
        # ツーパフ（デビル以降）
        group.push([200, 0, 91]) if self.name == "Devil " or self.name == "Deｍon" 
        # トリックレイド
        group.push([500, 0, 104])
        # リフレッシュ
        group.push([250, 0, 125])
        # エルダイーザ
        group.push([300, 0, 181])
        # ネリネイーザ・アルダ
        group.push([1200, 0, 178,20])
        # サフライーザ・アルダ（白）
        group.push([1200, 0, 186,20]) if self.color == "白"
        # パッションビート
        group.push([800, 0, 613])
        #【小悪魔の連携】（インプ Lv30）
        group.push([2000, 1, 81, 30]) if self.name == "Iｍp" 
        #【小悪魔の統率】（デビル以降 Lv30）
        group.push([2000, 1, 82, 30]) if self.name == "Devil " or self.name == "Deｍon" 
        #【吸精】
        group.push([1000, 1, 70]) if self.name == "Devil " or self.name == "Deｍon" 
        # 【生命力】
        group.push([400, 1, 214])
        # 【溢れる生命力】（緑）
        group.push([1000, 1, 215]) if self.color == "緑"
        # 【カリスマ】(デーモン)
        group.push([1200, 1, 73]) if self.name == "Deｍon" 
        #【最高の姿】
        group.push([5000, 1, 50, 30]) 
      #------------------------------------------------------------------------
      # ■■ウィッチ種
      #------------------------------------------------------------------------
      when "Little Witch", "Witch "
        # チャーム
        group.push([250, 0, 200])
        # ペイド・チャーム
        group.push([1800, 0, 201])
        # ルーズ
        group.push([250, 0, 212])
        # ペイド・ルーズ
        group.push([1800, 0, 213])
        # コリオブルム
        group.push([350, 0, 187])
        # セットサークル
        group.push([400, 0, 359])
        # アナライズ
        group.push([800, 0, 127])
        # トリムストーク
        group.push([400, 0, 216])
        # エンブレイス
        group.push([1000, 0, 17])
        # イリスペタル・アルダ（緑） Lv20
        group.push([2000, 0, 166, 20]) if self.color == "緑"
        # エルダブルム・アルダ（紫） Lv17
        group.push([2000, 0, 180, 17]) if self.color == "紫"
        # 専心
        group.push([500, 0, 600])
        # 【目聡い採取】
        group.push([500, 1, 241])
        # 【沈着】（緑）
        group.push([800, 1, 121]) if self.color == "緑"
        # 【高揚】（紫）
        group.push([800, 1, 120]) if self.color == "紫"
        #【最高の姿】
        group.push([5000, 1, 50, 30]) 
      #------------------------------------------------------------------------
      # ■■キャスト種
      #------------------------------------------------------------------------
      when "Caster"
        # リフレッシュ
        group.push([300, 0, 125])
        # アスタブルム
        group.push([400, 0, 191])
        # トリムルート
        group.push([550, 0, 215])
        # トリムストーク
        group.push([550, 0, 216])
        # エンブレイス
        group.push([700, 0, 17])
        # スイートウィスパー Lv20
        group.push([500, 0, 418, 20])
        # クッキング Lv20
        group.push([600, 0, 241, 20])
        # 【溢れる回復力】
        group.push([500, 1, 213])
        # 【溢れる生命力】
        group.push([2000, 1, 215])
      #------------------------------------------------------------------------
      # ■■スレイヴ種
      #------------------------------------------------------------------------
      when "Slave "
        # ドロウネクター
        group.push([1000, 0, 16])
        # クッキング Lv30
        group.push([600, 0, 241, 30])
        #【濡れやすい】
        group.push([100, 1, 106])
      #------------------------------------------------------------------------
      # ■■ナイトメア種
      #------------------------------------------------------------------------
      when "Nightｍare"
        # ネリネイーザ
        group.push([300, 0, 177])
        # サフライーザ
        group.push([300, 0, 185])
        # コリオイーザ
        group.push([300, 0, 189])
        # コールドタッチ
        group.push([500, 0, 360])
        # エンブレイス
        group.push([1000, 0, 17])
        # 威迫
        group.push([800, 0, 620])
        # リラックスタイム 好感度50
        group.push([700, 0, 611, nil, 50]) 
        # 【沈着】
        group.push([600, 1, 121])
        # 【サンチェック】
        group.push([2500, 1, 134, 40])
      #------------------------------------------------------------------------
      # ■■スライム種
      #------------------------------------------------------------------------
      when "Sliｍe","Gold Sliｍe "
        # 金を採取する
        group.push([500, 3, 3])  if self.name == "Gold Sliｍe "
        # ファストレイド
        group.push([700, 0, 103])
        # トリックレイド
        group.push([700, 0, 104])
        # ネリネブルム
        group.push([600, 0, 175]) if self.name == "Sliｍe"
        # ネリネブルム・アルダ
        group.push([2000, 0, 176, 30]) if self.name == "Sliｍe"
        # 祝福の口付け
        group.push([600, 0, 417]) if self.name == "Gold Sliｍe "
        # 【平静】
        group.push([450, 1, 108])
        # 【ダウト】
        group.push([600, 1, 226]) if self.name == "Sliｍe"
        # 【熟練】
        group.push([1000, 1, 124])
        # 【生命力】
        group.push([500, 1, 214]) if self.name == "Sliｍe"
        # 【免疫力】
        group.push([1000, 1, 118])
        # 【奇襲の備え】
        group.push([500, 1, 227])
      #------------------------------------------------------------------------
      # ■■ファミリア種
      #------------------------------------------------------------------------
      when "Familiar"
        # ティーズ
        group.push([180, 0, 101])
        # ガード
        group.push([300, 0, 145])
        # トリックレイド
        group.push([700, 0, 104])
        # ドロウネクター
        group.push([600, 0, 16]) if $PRODUCT_VERSION
        # レッドカーペット
        group.push([700, 0, 615])
        # 【ダウト】
        group.push([500, 1, 226])
        # 【警戒の備え】（青）
        group.push([500, 1, 228]) if self.color == "青"
        # 【奇襲の備え】（緑）
        group.push([500, 1, 227]) if self.color == "緑"
      #------------------------------------------------------------------------
      # ■■ワーウルフ種
      #------------------------------------------------------------------------
      when "Werewolf"
        # ファストレイド
        group.push([700, 0, 103])
        # チェック
        group.push([300, 0, 126])
        # リフレッシュ
        group.push([300, 0, 125])
        # 士気高揚
#未        group.push([1000, 0, 227])
        # エンブレイス
        group.push([500, 0, 17])
        # 【胆力】
        group.push([400, 1, 110])
        # 【奇襲の備え】
        group.push([500, 1, 227])
        # 【溢れる回復力】
        group.push([600, 1, 213])
        # 【溢れる生命力】
        group.push([1400, 1, 215])
      #------------------------------------------------------------------------
      # ■■ワーキャット種
      #------------------------------------------------------------------------
      when "Werecat "
        # ファストレイド
        group.push([700, 0, 103])
        # アピール
        group.push([500, 0, 148])
        # テンプテーション
        group.push([700, 0, 140]) 
        # ネリネイーザ
        group.push([300, 0, 177])
        # リラックスタイム
        group.push([800, 0, 611]) if self.color == "黄" 
        # 威迫
        group.push([800, 0, 620]) if self.color == "黒"
        # 【目聡い採取】
        group.push([500, 1, 241])
        # 【蒐集】
        group.push([800, 1, 221]) 
      #------------------------------------------------------------------------
      # ■■ゴブリン種
      #------------------------------------------------------------------------
      when "Goblin","Goblin Leader "
        # ファストレイド
        group.push([700, 0, 103])
        # トリックレイド
        group.push([800, 0, 104])
        # チェック
        group.push([300, 0, 126]) if self.name == "Goblin Leader "
        # チャーム
        group.push([1000, 0, 200]) if self.name == "Goblin Leader "
        # ペイド・チャーム （Lv40）
        group.push([1800, 0, 201, 40]) if self.name == "Goblin Leader "
        # エンブレイス
        group.push([800, 0, 17])
        # 【高揚】
        group.push([500, 1, 120])
        # 【胆力】
        group.push([500, 1, 110])
        # 【免疫力】
        group.push([2000, 1, 118])
        # 【洞察力】
        group.push([1000, 1, 130])
        # 【最高の姿】
        group.push([5000, 1, 50, 30]) 
        # 【溢れる生命力】
        group.push([1400, 1, 215])
      #------------------------------------------------------------------------
      # ■■プリーステス種
      #------------------------------------------------------------------------
      when "Priestess "
        # トリムルート
        group.push([350, 0, 215])
        # トリムストーク
        group.push([350, 0, 216])
        # 専心
        group.push([500, 0, 600])
        # エンブレイス
        group.push([1000, 0, 17])
        # 【手際良い採取】
        group.push([100, 1, 240])
        # 【平静】
        group.push([500, 1, 108])
        # 【一心】
        group.push([500, 1, 113])
        # 【沈着】
        group.push([600, 1, 121])
      #------------------------------------------------------------------------
      # ■■カースメイガス種
      #------------------------------------------------------------------------
      when "Cursed Magus"
        # ツーパフ
        group.push([200, 0, 91]) 
        # ティーズ
        group.push([200, 0, 101])  
        # チェック
        group.push([300, 0, 126])
        # エキサイトビュー
        group.push([500, 0, 18])   
        # ドロウネクター
        group.push([500, 0, 16])
        # ペイド・チャーム
        group.push([1800, 0, 201])
        # 【高揚】
        group.push([500, 1, 120])
        # 【目聡い採取】
        group.push([500, 1, 241])
      #------------------------------------------------------------------------
      # ■■アルラウネ種
      #------------------------------------------------------------------------
      when "Alraune "
        # ラスト
        group.push([400, 0, 202])
        # マイルドパフューム
        group.push([400, 0, 614])
        #【濡れやすい】
        group.push([100, 1, 106])
        # 【高揚】
        group.push([500, 1, 120])
        # 【溢れる回復力】
        group.push([600, 1, 213])
        # 【奇襲の備え】
        group.push([400, 1, 227])
      #------------------------------------------------------------------------
      # ■■マタンゴ種
      #------------------------------------------------------------------------
      when "Matango "
        # アピール
        group.push([500, 0, 148])
        # ガード
        group.push([800, 0, 145])  
        # ネリネイーザ
        group.push([500, 0, 176])
        # エンブレイス
        group.push([600, 0, 17])
        # 【沈着】
        group.push([600, 1, 121])
        # 【溢れる回復力】
        group.push([600, 1, 213])
        # 【溢れる生命力】
        group.push([1400, 1, 215])
      #------------------------------------------------------------------------
      # ■■エンジェル種
      #------------------------------------------------------------------------
      when "Dark Angel"
        # アピール
        group.push([500, 0, 148])
        # イリスペタル・アルダ
        group.push([1200, 0, 166])
        # スイートウィスパー
        group.push([500, 0, 418])
        # レッドカーペット
        group.push([1000, 0, 615])
        # 【一心】
        group.push([500, 1, 113])
        # 【高揚】
        group.push([600, 1, 120])
        # 【沈着】
        group.push([600, 1, 121])
        # 【平穏の保証】
        group.push([2000, 1, 135])
      #------------------------------------------------------------------------
      # ■■ガーゴイル種
      #------------------------------------------------------------------------
      when "Gargoyle"
        # アピール
        group.push([500, 0, 148])
        # テラー
        group.push([500, 0, 208])
        # ペイド・テラー
        group.push([1300, 0, 209])
        # ネリネブルム
        group.push([650, 0, 175])
        # エキサイトビュー
        group.push([500, 0, 18])   
        # 【免疫力】
        group.push([400, 1, 118])
      #------------------------------------------------------------------------
      # ■■ミミック種
      #------------------------------------------------------------------------
      when "Miｍic"
        # ネリネイーザ
        group.push([500, 0, 177])
        # ペイド・チャーム
        group.push([2000, 0, 201])
        # スイートウィスパー
        group.push([500, 0, 418])
        # レッドカーペット
        group.push([700, 0, 615])
        # ラブフレグランス
        group.push([1500, 0, 625])
        # 【警戒の備え】（青）
        group.push([500, 1, 228])
      #------------------------------------------------------------------------
      # ■■タマモ種
      #------------------------------------------------------------------------
      when "Taｍaｍo"
        # ファストレイド
        group.push([700, 0, 103])
        # ハウリング
        group.push([400, 0, 415])
        # ラナンブルム
        group.push([500, 0, 171]) 
        # フィルス
        group.push([230, 0, 204])
        # ペイド・フィルス
        group.push([1500, 0, 205])
        # トリックレイド
        group.push([800, 0, 104])
        # 【溢れる回復力】
        group.push([700, 1, 213])
      #------------------------------------------------------------------------
      # ■■リリム種
      #------------------------------------------------------------------------
      when "Liliｍ"
        # テラー
        group.push([200, 0, 208])
        # ペイド・チャーム
        group.push([1800, 0, 201])
        # ペイド・ラスト
        group.push([1000, 0, 203])
        # フィルス
        group.push([150, 0, 204])
        # ペイド・フィルス
        group.push([1000, 0, 205])
        # サディストカレス
        group.push([1000, 0, 361])
        #【濡れやすい】
        group.push([100, 1, 106])
        #【奇襲の備え】
        group.push([600, 1, 227])
        
      #------------------------------------------------------------------------
      # ■■ユニークサキュバス種
      #------------------------------------------------------------------------
      when "Unique Succubus ","Unique Tycoon ","Unique Witch"
        case self.color
        #----------------------------------------------------------------------
        # ■■ネイジュレンジ
        #----------------------------------------------------------------------
        when "Neijorange"
          # ラナンブルム
          group.push([500, 0, 171]) 
          # ネリネブルム
          group.push([500, 0, 175])
          # フィルス
          group.push([400, 0, 204])
          # スポアクラウド
          group.push([800, 0, 590])
          # スイートウィスパー
          group.push([500, 0, 418])
          # リラックスタイム
          group.push([700, 0, 611])
          # クッキング 
          group.push([700, 0, 241])
          # 【調理知識】
          group.push([1000, 1, 104])
        #----------------------------------------------------------------------
        # ■■リジェオ
        #----------------------------------------------------------------------
        when "Rejeo "
          # ファストレイド
          group.push([700, 0, 103])
          # エンブレイス
          group.push([600, 0, 17])
          # ウォッシュフルード
          group.push([900, 0, 224])
          # クッキング 
          group.push([500, 0, 241])
          # レッドカーペット
          group.push([1000, 0, 615])
          # ストレリイーザ
          group.push([5000, 0, 197, 40])
          # 【熟練】
          group.push([1000, 1, 124]) 
        #----------------------------------------------------------------------
        # ■■フルビュア
        #----------------------------------------------------------------------
        when "Fulbeua "
          # トリックレイド
          group.push([800, 0, 104])
          # リフレッシュ
          group.push([500, 0, 125]) 
          # 魔性の口付け
          group.push([300, 0, 416])
          # スイートウィスパー
          group.push([500, 0, 418])
          # 威迫
          group.push([300, 0, 620])
          # 【高揚】
          group.push([600, 1, 120])
        #----------------------------------------------------------------------
        # ■■ギルゴーン
        #----------------------------------------------------------------------
        when "Gilgoon "
          # レザラジィ
          group.push([200, 0, 206])
          # テラー
          group.push([200, 0, 208])
          # パラライズ
          group.push([200, 0, 210])
          # ルーズ
          group.push([200, 0, 212])
          # リフレッシュ
          group.push([600, 0, 125]) 
          # エンブレイス
          group.push([600, 0, 17])
          # ドロウネクター
          group.push([600, 0, 16])
          # 【慧眼】
          group.push([3000, 1, 83])
          #【小悪魔の統率】
          group.push([3000, 1, 82]) 
        #----------------------------------------------------------------------
        # ■■ユーガノット
        #----------------------------------------------------------------------
        when "Yuganaught"
          # パラライズ
          group.push([200, 0, 210])
          # ペイド・パラライズ
          group.push([1500, 0, 211])
          # ドロウネクター
          group.push([200, 0, 16]) 
          # 【目聡い採取】
          group.push([500, 1, 241])
          # 【奇襲の備え】
          group.push([300, 1, 227])
          # 【バッドチェイン】
          group.push([3000, 1, 136])
        #----------------------------------------------------------------------
        # ■■シルフェ
        #----------------------------------------------------------------------
        when "Sylphe"
          # ウォッシュフルード
          group.push([700, 0, 224])   
          # リラックスタイム
          group.push([700, 0, 611])
          # 【慧眼】
          group.push([3000, 1, 83, 40])
          # 【沈着】
          group.push([600, 1, 121])
          # 【蒐集】
          group.push([800, 1, 221])
          # 【金運】
          group.push([800, 1, 222])
        #----------------------------------------------------------------------
        # ■■ラーミル
        #----------------------------------------------------------------------
        when "Ramile"
          # イリスペタル
          group.push([300, 0, 162]) 
          # 祝福の口付け
          group.push([500, 0, 417])
          # クッキング 
          group.push([200, 0, 241])
          # 【高揚】
          group.push([600, 1, 120])
          # 【沈着】
          group.push([600, 1, 121])
          # 【洞察力】
          group.push([1000, 1, 130])
          # 【平穏の保証】
          group.push([3000, 1, 135])
        #----------------------------------------------------------------------
        # ■■ヴェルミィーナ
        #----------------------------------------------------------------------
        when "Vermiena"
          # ファストレイド
          group.push([700, 0, 103])
          # トリックレイド
          group.push([700, 0, 104])
          # 威迫
          group.push([300, 0, 620])
          # 【バッドチェイン】
          group.push([3000, 1, 136])
        end

      end

      #------------------------------------------------------------------------
      # ■■共通第２項（弱点等）
      #------------------------------------------------------------------------
      group += [
      [500, 1, 19],    # 【口が性感帯】
      [500, 1, 21],    # 【胸が性感帯】
      [500, 1, 23],    # 【お尻が性感帯】
      [500, 1, 27],    # 【陰核が性感帯】
      [500, 1, 29],    # 【女陰が性感帯】
      ]
      #------------------------------------------------------------------------
      # ■■共通第３項（デバッグ用）
      #------------------------------------------------------------------------
      if $DEBUG
        group += [
        [0, 1, 60],    # 【寵愛】
        [0, 1, 61],    # 【大切な人】
        ]
      end
    
      return group
    end
  end
end