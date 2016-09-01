#==============================================================================
# ■ Talk_Sys(分割定義 5)
#------------------------------------------------------------------------------
#   夢魔の口上を検索、表示するためのクラスです。
#   このクラスのインスタンスは $msg で参照されます。
#   ここではトーク時のシチュエーションごとのテキストを設定します
#==============================================================================
class Talk_Sys
  #============================================================================
  # ●トーク中のテキスト設定(口上表示前のテキスト)
  #============================================================================
  def make_text_aftertalk
    speaker = $msg.t_enemy.name #会話中のエネミー名
    master = $game_actors[101].name #主人公名
    #存在するなら、パートナー名
    if $msg.t_partner != nil
      servant = $msg.t_partner.name
    else
      servant = nil
    end
    m = ""
    case $msg.tag
    #==============================================================================
    # ●会話不成立時
    #==============================================================================
    when "不成立"
      case $msg.at_type
      when "夢魔クライシス"
        m = "#{speaker} is iｍｍersed in pleasure...!\066\n It's iｍpossible to talk right noｗ...!"
      when "主人公クライシス"
        m = "#{master} stares off vacantly...!\066\n can't focus right noｗ!"
      when "夢魔絶頂中"
        m = "#{speaker} is cliｍaxing....! \066\n She incapable of talking right noｗ!"
      when "試行過多"
        m = "For soｍe reason, #{speaker} doesn't seeｍ\n\066 to ｗant to talk anyｍore...."
      when "夢魔恍惚中"
        m = "#{speaker} bears blissful expression....! \066\n She incapable of talking right noｗ!"
        m = "#{speaker} has a transfixed look on her face....!\066\n She seeｍs unable to talk right noｗ...!" if $msg.t_enemy.holding?
      when "夢魔暴走中"
        m = "#{speaker} is violently aroused....!\066\n She can't talk right noｗ!"
      end
    #==============================================================================
    # ●主人公脱衣
    #==============================================================================
    when "主人公脱衣"
      case $msg.talk_step
      when 2 #脱衣を受け入れた場合
        m = "#{master} does as #{speaker} says, \066\n taking off his oｗn clothes!"
      when 77 #脱衣を拒否した場合
        m = "#{master} declined!"
      end
    #==============================================================================
    # ●仲間脱衣
    #==============================================================================
    when "仲間脱衣"
      case $msg.talk_step
      when 2 #仲間の脱衣を受け入れた場合
        m = "#{master} does as #{speaker} says,\066\n stripping #{servant} of her clothes!"
      when 77 #仲間の脱衣を拒否した場合
        m = "#{master} refused her deｍands!"
      end
    #==============================================================================
    # ●夢魔脱衣
    #==============================================================================
    when "夢魔脱衣"
      case $msg.talk_step
      when 2 #脱衣を見続けた場合
        m = "#{master} does as she says, ｗatching as\066\n #{speaker} continued to undresses herself!"
        m = "#{master} unintentionally kept ｗatching as \066\n#{speaker} she undressed herself!" if $data_SDB[$msg.t_enemy.class_id].name == "キャスト"
        m = "#{master} ｗatches hungrily, as #{speaker}\066\n continued undressing herself!" if $game_actors[101].state?(35)
      when 77 #脱衣を見なかった場合
        m = "#{master} struggled to pull aｗay,\066\n averting his eyes froｍ #{speaker}!"
      end
    #==============================================================================
    # ●吸精・口
    #==============================================================================
    when "吸精・口"
      case $msg.talk_step
      when 2 #吸精を受け入れた場合
        m = "#{speaker} locks lips ｗith #{master}!\066\n #{master}'s energy is being drained out of his body...!"
      when 77 #吸精を拒否した場合
        m = "#{master} declined her deｍand!"
      end
    #==============================================================================
    # ●吸精・性器
    #==============================================================================
    when "吸精・性器"
      case $msg.talk_step
      when 2 #吸精を受け入れた場合
        m = "#{speaker} hungrily sucks on #{master}'s penis!\066\n #{master}'s strength is being drained and replaced\066\n by pleasure...!"
      when 77 #吸精を拒否した場合
        m = "#{master} declined her deｍand!"
      end
    #==============================================================================
    # ●好意
    #==============================================================================
    when "好意"
      m = "#{speaker}は満更でもないようだ……！"
    #==============================================================================
    # ●視姦
    #==============================================================================
    when "視姦"
      case $msg.talk_step
      when 77 #視姦を最初から見なかった場合
        m = "#{master} resists teｍptation,\066\n averting his eyes froｍ #{speaker}!"
      when 78 #視姦を途中で断った場合
        m = "#{master} ｍanages to peel aｗay,\066\n averting his eyes froｍ #{speaker}!"
      when 79 #視姦しすぎて暴走した場合
        m = "#{master} cannot look aｗay froｍ the sight before his eyes,\066\n falling to #{speaker}'s teｍptation!"
      #継続している場合
      else
        m = "#{speaker} seeks to satisfy her desires....!"
        emotion = ""
        case $msg.t_enemy.personality
        when "意地悪","虚勢","倒錯"
          emotion = " suggestively"
          emotion = " approaches #{master} and" if rand($mood.point) > 50
        when "好色","高慢","陽気","柔和","勝ち気"
          emotion = " stares at #{master} and leｗdly"
          emotion = ", ｍeeting #{master}'s gaze," if rand($mood.point) > 50
        when "淡泊","従順","甘え性","不思議"
          emotion = ", absorbed in her act,"
          emotion = ", feeling #{master}'s gaze," if rand($mood.point) > 50
        when "内気","上品","天然"
          emotion = " turns her face aｗay as she sloｗly"
          emotion = " blushes as she" if rand($mood.point) > 50
        end
        #テキスト整形(口、尻系は現在は封印のため、他部位に割り振り)
        case $msg.at_parts
        #胸や乳首で自慰
        when "対象：胸","対象：口"
          if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            m = "#{speaker}#{emotion} runs her\066\n hands over her #{$msg.t_enemy.bustsize}!"
            m = "#{speaker}#{emotion} traces her\066\n nipple ｗith her finger!" if rand($mood.point) > 50
          else
            m = "#{speaker}#{emotion} sｑueezes her m\n #{$msg.t_enemy.bustsize} ｗith her hands!"
            m = "#{speaker}#{emotion} traces her\066\n nipple ｗith her finger!" if rand($mood.point) > 50
          end
        #アソコに指入れで自慰
        when "対象：アソコ","対象：尻"
          m = "#{speaker}#{emotion} rubs her\066\n fingers in and out of her pussy!"
          m = "#{speaker}#{emotion} thrusts her\066\n fingers in and out of her pussy!" if rand($mood.point) > 50
        #陰核を弄って自慰
        when "対象：陰核","対象：アナル"
          m = "#{speaker}#{emotion} rubs her\066\n clit ｗith her finger!"
          m = "#{speaker}#{emotion} violently rubs\066\n her clit ｗith her fingers!" if rand($mood.point) > 50
        end
      end
    #==============================================================================
    # ●奉仕
    #==============================================================================
    when "奉仕"
      case $msg.talk_step
      when 77 #視姦を最初から見なかった場合
        m = "#{master}は誘惑に負けず、\066\n#{speaker}の要求を断った！"
        m = "#{master}は後ろ髪を引かれる思いで、\066\n何とか#{speaker}の要求を断った！" if $game_actors[101].state?(35)
      when 78 #視姦を途中で断った場合
        m = "#{master} ｍanages to peel aｗay,\066\n#{speaker}への奉仕の手を止めた！"
      when 79 #視姦しすぎて暴走した場合
        m = "#{master}は熱に浮かされたように、#{speaker}への奉仕を続けている……！"
      #継続している場合
      else
        m = "#{master}は#{speaker}を愛撫した！"
        action = ""
        action = "更に" if $msg.talk_step > 3
        action = "続けて"if $msg.chain_attack == true and $msg.talk_step > 3
        action = "誘われるがままに" if $game_switches[89] == true
        #テキスト整形
        case $msg.at_parts
        #キッスで奉仕
        when "対象：口"
          m = "#{master}は#{action}、\066\n#{speaker}と口内で舌を絡めあった！"
        #胸や乳首に奉仕
        when "対象：胸"
          if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            m = "#{master}は#{action}、\066\n#{speaker}の#{$msg.t_enemy.bustsize}を揉みしだいた！"
            m = "#{master}は#{action}、\066\n#{speaker}の#{$msg.t_enemy.bustsize}を舌で舐め回した！" if $game_variables[17] > 50 
          else
            m = "#{master}は#{action}、\066\n#{speaker}の#{$msg.t_enemy.bustsize}を手で撫で回した！"
            m = "#{master}は#{action}、\066\n#{speaker}の#{$msg.t_enemy.bustsize}を舌で舐め回した！" if $game_variables[17] > 50 
          end
        #アソコに奉仕
        when "対象：アソコ","対象：アナル"
          m = "#{master}は#{action}、\066\n#{speaker}のアソコに指を抜き挿しした！"
          m = "#{master}は#{action}、\066\n#{speaker}のアソコに舌を出し入れした！" if $game_variables[17] > 50 
        #陰核に奉仕
        when "対象：陰核"
          m = "#{master}は#{action}、\066\n#{speaker}の陰核を指で愛撫した！"
          m = "#{master}は#{action}、\066\n#{speaker}の陰核を舌で舐め上げた！" if $game_variables[17] > 50 
        #お尻に奉仕
        when "対象：尻"
          m = "#{master}は#{action}、\066\n#{speaker}のお尻を両手で愛撫した！"
          m = "#{master}は#{action}、\066\n#{speaker}のお尻を舌で舐め回した！" if $game_variables[17] > 50 
        #アナルに奉仕
#        when "対象：アナル"
#          m = "#{master}は#{action}、\066\n#{speaker}の菊座を指で愛撫した！"
#          m = "#{master}は#{action}、\066\n#{speaker}の菊座を舌で舐め回した！" if $game_variables[17] > 50 
        end
      end
    #==============================================================================
    # ●愛撫・性交
    #==============================================================================
    when "愛撫・性交"
      case $msg.talk_step
      when 77 #愛撫を最初から断った場合
        m = "#{master} resists teｍptation,\066\n and #{speaker}'s proposal!"
        m = "#{master} reluctantly tears aｗay,\066\n declining #{speaker}'s proposal!" if $game_actors[101].state?(35)
      when 78 #視姦を途中で断った場合
        m = "#{master} ｍanages to peel aｗay,\066\n stopping #{speaker} ｍid-thrust!"
      #●愛撫を受け入れた場合
      else
        case $msg.at_parts
        #▼インサート・アクセプト
        #--------------------------------------------------------------------------
        when "♀挿入：アソコ側","尻挿入：尻側"
          if $game_variables[17] > 70
            if $game_actors[101].critical == true
              action = ["leｗdly","tightly","firmly"]
              action = action[rand(action.size)]
              move = ["tightens around","strangles","sｑueezes"]
              move = move[rand(move.size)]
            else
              action = ""
              move = "締め付ける"
            end
            hole = "pussy"
            hole = "ass" if $msg.at_parts == "尻挿入：尻側"
            m = "#{speaker}'s #{hole}\066\n #{action} #{move} #{master}'s penis！" 
          else
            if $game_actors[101].critical == true
              if $msg.t_enemy.initiative_level > 0
                #●
                action = "holds #{master} doｗn"
                #●
                waist = ["boldly fucks","poｗerfully fucks","intensely fucks"]
                waist.push("undulatingly fucks","leｗdly fucks","ｗildly fucks") if $msg.t_enemy.positive?
                waist.push("strenuously fucks","devotedly fucks","lazily fucks") if $msg.t_enemy.negative?
              else
                #●
                action = "entrusts herself to #{master}"
                #●
                waist = ["poｗerfully fucks"]
                waist.push("leｗdly fucks") if $msg.t_enemy.positive?
                waist.push("strenuously fucks") if $msg.t_enemy.negative?
              end
              waist = waist[rand(waist.size)]
            else
              if $msg.t_enemy.initiative_level > 0
                #●
                action = "gazes at #{master}"
                #●
                waist = ["sloｗly fucks","bounces on top of","gyrates on top"]
                waist.push("teasingly fucks","coｍfortably fucks") if $msg.t_enemy.positive?
                waist.push("ｍodestly fucks","shaｍefully fucks") if $msg.t_enemy.negative?
              else
                #●
                action = "ｍatches #{master}'s pace"
                #●
                waist = ["sloｗly fucks"]
                waist.push("teasingly fucks") if $msg.t_enemy.positive?
                waist.push("ｍodestly fucks") if $msg.t_enemy.negative?
              end
              waist = waist[rand(waist.size)]
            end
            m = "#{speaker} #{action} as she #{waist} hiｍ!"
          end
        #▼オーラル
        #--------------------------------------------------------------------------
        when "口挿入：口側"
          if $game_actors[101].critical == true
            if $msg.t_enemy.initiative_level > 0
              #●
              action = "sucks"
              #●
              mouth = ["boldly","noisily","intensely"]
              mouth.push("deeply","leｗdly","ｗildly") if $msg.t_enemy.positive?
              mouth.push("strenuously","devotedly","lazily") if $msg.t_enemy.negative?
              mouth.push("aｍorously") if $mood.point > 70
            else
              #●
              action = "deepthroats"
              #●
              mouth = ["boldly"]
              mouth.push("leｗdly") if $msg.t_enemy.positive?
              mouth.push("streneously") if $msg.t_enemy.negative?
              mouth.push("aｍorously") if $mood.point > 70
            end
            mouth = mouth[rand(mouth.size)]
          else
            if $msg.t_enemy.initiative_level > 0
              #●
              action = "sucks"
              #●
              mouth = ["sloｗly"]
              mouth.push("teasingly","coｍfortably") if $msg.t_enemy.positive?
              mouth.push("tiｍidly","ｍodestly","shaｍefully") if $msg.t_enemy.negative?
              mouth.push("aｍorously") if $mood.point > 70
            else
              #●
              action = "deepthroats"
              #●
              mouth = ["sloｗly"]
              mouth.push("teasingly","gradually") if $msg.t_enemy.positive?
              mouth.push("tiｍidly","hesitantly") if $msg.t_enemy.negative?
            end
            mouth = mouth[rand(mouth.size)]
          end
          m = "#{speaker} #{mouth} #{action} #{master}'s penis!"
        #▼パイズリ
        #--------------------------------------------------------------------------
        when "パイズリ"
          if $game_actors[101].critical == true
            action = "fucks"
            #●
            bust = ["boldly","deliberately"]
            bust.push("leｗdly","poｗerfully") if $msg.t_enemy.positive?
            bust.push("strenuously","devotedly","lazily") if $msg.t_enemy.negative?
            bust.push("aｍorously") if $mood.point > 70
          else
            action = "sandｗiches"
            #●
            bust = ["sloｗly","tightly"]
            bust.push("teasingly","coｍfortably") if $msg.t_enemy.positive?
            bust.push("tiｍidly","ｍodestly","shaｍefully") if $msg.t_enemy.negative?
            bust.push("aｍorously") if $mood.point > 70
          end
          bust = bust[rand(bust.size)]
          m = "#{speaker} #{bust} #{action} #{master}'s penis\066\n ｗith her #{$msg.t_enemy.bustsize}!"
        #--------------------------------------------------------------------------
        when "背面拘束"
          action = []
          if $game_actors[101].critical == true
            action.push("の首筋を舌先で舐めてきた！")
            action.push("の耳たぶを甘噛みしてきた！")
            action.push("の乳首を舌先で舐めてきた！")
            action.push("に自分の胸を押し付けてきた！")
            #ペニスが空いている場合
            if $game_actors[101].hold.penis.battler == nil
              action.push("のペニスを指で弄ってきた！") 
              action.push("のペニスを指先で撫でてきた！")
            #ペニスがインサート中の場合(アナル含む)
            elsif $game_actors[101].penis_insert? or $game_actors[101].penis_analsex?
              hold_target = $game_actors[101].hold.penis.battler
              action.push("の腰を前に押し出した！\066\n#{hold_target}との結合部がより深くなった！")
            #ペニスがパイズリ中の場合
            elsif $game_actors[101].penis_paizuri?
              action.push("の腰を押さえ込んだ！\066\n#{hold_target}の動きが更に激しくなった！")
            end
          else
            action.push("のわきの下を舌で舐めてきた！")
            action.push("の首筋にふぅっと息を吹きかけた！")
            action.push("の胸板に指を這わせてきた！")
            action.push("の腰をさわさわと撫でてきた！")
            action.push("の太ももをさわさわと撫でてきた！")
          end
          action = action[rand(action.size)]
          m = "#{speaker}は密着したまま、\066\n#{master}#{action}"
        end
      #--------------------------------------------------------------------------
      end
    #==============================================================================
    # ●愛撫・通常
    #==============================================================================
    when "愛撫・通常"
      m = "#{speaker}は微笑むと、\066\n#{master}のペニスを愛撫してきた！"
      case $msg.at_type
      #--------------------------------------------------------------------------
      when "手"
        #●弱点を突いた
        if $game_actors[101].critical == true
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker}は反応を楽しむかのように、\066\n#{master}のペニスを艶かしく指で弄ぶ！"
              m = "#{speaker}は愛おしむかのように、\066\n#{master}のペニスを艶かしく指で弄ぶ！" if $msg.t_enemy.love > 0
            else
              m = "#{speaker}は心得た指捌きで、\066\n#{master}のペニスを間断なく攻め立ててきた！"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}は間断なく、\066\n#{master}のペニスの敏感な部分を攻めてきた！"
            else
              m = "#{speaker}は指を絡めて、\066\n#{master}のペニスの敏感な部分を攻めてきた！"
            end
          end
        else
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker}は間断なく、\066\n#{master}のペニスを指で攻め立てる！"
            else
              m = "#{speaker}は指を絡めて、\066\n#{master}のペニスをしごき上げてきた！"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}は、\066\n#{master}のペニスに指を絡め愛撫してきた！"
            else
              m = "#{speaker}は手で、\066\n#{master}のペニスをしごいてきた！"
            end
          end
        end
      #--------------------------------------------------------------------------
      when "口"
        #●弱点を突いた
        if $game_actors[101].critical == true
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker}は反応を楽しむかのように、\066\n#{master}のペニスを根元から舐め上げてきた！"
              m = "#{speaker}は愛おしむかのように、\066\n#{master}のペニスを根元から舐め上げてきた！" if $msg.t_enemy.love > 0
            else
              m = "#{speaker}は心得た舌使いで、\066\n#{master}のペニスを間断なく舐め回してきた！"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}は間断なく、\066\n#{master}のペニスの敏感な部分を舐め続けた！"
            else
              m = "#{speaker}は舌先で、\066\n#{master}のペニスの敏感な部分を舐め上げた！"
            end
          end
        else
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker}は間断なく、\066\n#{master}のペニスを丹念に舐め上げてきた！"
            else
              m = "#{speaker}は舌先で、\066\n#{master}のペニスを焦らすように舐め上げた！"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}は休むことなく、\066\n#{master}のペニスを丹念に舐め上げてきた！"
            else
              m = "#{speaker}は舌で、\066\n#{master}のペニスを舐め上げてきた！"
            end
          end
        end
      #--------------------------------------------------------------------------
      when "足"
        #●弱点を突いた
        if $game_actors[101].critical == true
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker}は反応を楽しむかのように、\066\n#{master}のペニスを両足の裏でしごいてきた！"
              m = "#{speaker}は愛おしむかのように、\066\n#{master}のペニスを両足の裏でしごいてきた！" if $msg.t_enemy.love > 0
            else
              m = "#{speaker}は心得ていると言わんばかりに、\066\n#{master}のペニスを足裏で捏ね回してきた！"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}は休むことなく、\066\n#{master}のペニスを足裏で捏ね回してきた！"
            else
              m = "#{speaker}は足の裏で、\066\n#{master}のペニスの敏感な部分をしごいてきた！"
            end
          end
        else
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker}は緩急をつけながら、\066\n#{master}のペニスを足の指で更に弄ぶ！"
            else
              m = "#{speaker}は足の指で、\066\n#{master}のペニスを焦らすように弄んできた！"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}は緩急をつけながら、\066\n#{master}のペニスを足裏でしごいてきた！"
            else
              m = "#{speaker}は足の裏で、\066\n#{master}のペニスを軽く踏みつけた！"
            end
          end
        end
      #--------------------------------------------------------------------------
      when "胸"
        if $msg.chain_attack == true
          m = "#{speaker}は#{$msg.t_enemy.bustsize}で、\066\n#{master}のペニスを間断なく愛撫してきた！"
          m = "#{speaker}は#{$msg.t_enemy.bustsize}を、\066\n#{master}のペニスに擦り付けてきた！" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
        else
          m = "#{speaker}は#{$msg.t_enemy.bustsize}で、\066\n#{master}のペニスを挟みしごいてきた！"
          m = "#{speaker}は#{$msg.t_enemy.bustsize}を、\066\n#{master}のペニスに押し付けてきた！" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
        end
        #●弱点を突いた
        if $game_actors[101].critical == true
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
                m = "#{speaker}は反応を楽しむかのように、\066\n#{$msg.t_enemy.bustsize}をペニスに擦り付けてきた！"
                m = "#{speaker}は愛おしむかのように、\066\n#{$msg.t_enemy.bustsize}をペニスに擦り付けてきた！" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}は反応を楽しむかのように、\066\n#{$msg.t_enemy.bustsize}でペニスを艶かしく愛撫してきた！"
                m = "#{speaker}は愛おしむかのように、\066\n#{$msg.t_enemy.bustsize}でペニスを艶かしく愛撫してきた！" if $msg.t_enemy.love > 0
              end
            else
              m = "#{speaker}は#{$msg.t_enemy.bustsize}で、\066\n#{master}のペニスを挟みしごいてきた！"
              m = "#{speaker}は#{$msg.t_enemy.bustsize}を、\066\n#{master}のペニスに押し付けてきた！" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}は#{$msg.t_enemy.bustsize}で、\066\n#{master}のペニスを間断なく愛撫してきた！"
              m = "#{speaker}は#{$msg.t_enemy.bustsize}を、\066\n#{master}のペニスに擦り付けてきた！" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            else
              m = "#{speaker}は#{$msg.t_enemy.bustsize}で、\066\n#{master}のペニスを挟みしごいてきた！"
              m = "#{speaker}は#{$msg.t_enemy.bustsize}を、\066\n#{master}のペニスに押し付けてきた！" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            end
          end
        else
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker}は#{$msg.t_enemy.bustsize}で、\066\n#{master}のペニスを間断なく愛撫してきた！"
              m = "#{speaker}は#{$msg.t_enemy.bustsize}を、\066\n#{master}のペニスに擦り付けてきた！" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            else
              m = "#{speaker}は#{$msg.t_enemy.bustsize}で、\066\n#{master}のペニスを挟みしごいてきた！"
              m = "#{speaker}は#{$msg.t_enemy.bustsize}を、\066\n#{master}のペニスに押し付けてきた！" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}は#{$msg.t_enemy.bustsize}で、\066\n#{master}のペニスを間断なく愛撫してきた！"
              m = "#{speaker}は#{$msg.t_enemy.bustsize}を、\066\n#{master}のペニスに擦り付けてきた！" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            else
              m = "#{speaker}は#{$msg.t_enemy.bustsize}で、\066\n#{master}のペニスを挟みしごいてきた！"
              m = "#{speaker}は#{$msg.t_enemy.bustsize}を、\066\n#{master}のペニスに押し付けてきた！" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            end
          end
        end
      #--------------------------------------------------------------------------
      when "♀"
        #●弱点を突いた
        if $game_actors[101].critical == true
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "As if enjoying his reaction, #{speaker}\066\n continues to bounce up and doｗn #{master}'s penis!"
              m = "#{speaker} continues to lovingly bounce\066\n up and doｗn #{master}'s penis!" if $msg.t_enemy.love > 0
            else
              m = "Having found his ｗeakness, #{speaker} grinds\066\n her pussy doｗn on #{master}'s penis!"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker} continues grinding her hips\066\n back and forth on #{master}'s penis!"
            else
              m = "#{speaker} rubs her pussy on #{master},\066\n vigorously inciting response froｍ his penis!"
            end
          end
        else
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker} continues bouncing ｗildly\066\n on #{master}'s penis!"
            else
              m = "#{speaker} rubs her pussy against\066\n #{master}'s penis!"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker} continues bouncing ｗildly\066\n on #{master}'s penis!"
            else
              m = "#{speaker} rubs her pussy against\066\n #{master}'s penis!"
            end
          end
        end
      #--------------------------------------------------------------------------
      when "尻尾"
        #●弱点を突いた
        if $game_actors[101].critical == true
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker}は反応を楽しむかのように、\066\n#{master}のペニスを尻尾でしごいてきた！"
              m = "#{speaker}は愛おしむかのように、\066\n#{master}のペニスを尻尾でしごいてきた！" if $msg.t_enemy.love > 0
            else
              m = "#{speaker}は慣れた腰使いで、\066\n#{master}のペニスを尻尾で弄んできた！"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}は尻尾をくねらせ、\066\n#{master}のペニスを間断なくしごき上げてきた！"
            else
              m = "#{speaker}は尻尾を巧みに使い、\066\n#{master}のペニスをしごき上げてきた！"
            end
          end
        else
          case @weakpoints
          when 20,10
            if $msg.chain_attack == true
              m = "#{speaker}はリズミカルに、\066\n尻尾で#{master}のペニスをしごき上げてきた！"
            else
              m = "#{speaker}は自分の尻尾を、\066\n#{master}のペニスに巻き付けてきた！"
            end
          else
            if $msg.chain_attack == true
              m = "#{speaker}はリズミカルに、\066\n尻尾で#{master}のペニスをしごき上げてきた！"
            else
              m = "#{speaker}は自分の尻尾を、\066\n#{master}のペニスに巻き付けてきた！"
            end
          end
        end
      #--------------------------------------------------------------------------
      end
    #==============================================================================
    # ●交合
    #==============================================================================
    when "交合"
      case $msg.at_type
      when "♀挿入"
        case $msg.talk_step
        when 2 #挿入受諾
          m = "Having invited #{master}, #{speaker} ｑuickly\066\n stabs his penis into her pussy before he can escape!"
        when 77 #挿入拒否
          m = "#{master} hardens his resolve to resist her invitation!"
        end
#      when "口挿入"
#      when "尻挿入"
#      when "パイズリ"
#      when "キッス"
      end
    end
    #============================================================================
    return if m == ""
    $game_temp.battle_log_text += m
  end

###############################################################################  
  #============================================================================
  # ●トーク中のテキスト設定(口上表示前のテキスト)
  #============================================================================
  def make_text_pretalk
    speaker = $msg.t_enemy.name #会話中のエネミー名
    master = $game_actors[101].name #主人公名
    #存在するなら、パートナー名
    if $msg.t_partner != nil
      servant = $msg.t_partner.name
    else
      servant = nil
    end
    m = ""
    case $msg.tag
    #==============================================================================
    # ●主人公脱衣
    #==============================================================================
    when "主人公脱衣"
      m = "#{speaker} leans on #{master}'s chest,\066\n gazing deeply into his eyes...!"
      m = "#{speaker} leans on #{master}, taking fleeting\066\n glances at hiｍ ｗhile tｗirling her finger on his chest!" if $msg.t_enemy.negative?
    #==============================================================================
    # ●仲間脱衣
    #==============================================================================
    when "仲間脱衣"
      m = "#{speaker} gazes at #{servant}\066\n ｗith a suggestive look on her face...!"
      m = "#{speaker} stares at #{servant}\066\n ｗith an insinuating look on her face...!" if $msg.t_enemy.negative?
    #==============================================================================
    # ●夢魔脱衣
    #==============================================================================
    when "夢魔脱衣"
      m = "#{speaker} begins peeling back her clothes,\066\n turning toｗards #{master} ｗith a lustful expression!"
      m = "#{speaker} begins peeling back her clothes,\066\n eyeing #{master} ｗith suggestive intent!" if $msg.t_enemy.negative?
      m = "#{speaker} shakes the jiggling sliｍe covering\066\n her body in front of #{master}'s eyes....!" if $msg.t_enemy.tribe_slime?
    #==============================================================================
    # ●吸精・口
    #==============================================================================
    when "吸精・口"
      m = "#{speaker} closes her eyes,\066\n bringing her face close to #{master}'s lips...!"
      m = "#{speaker} sｍiles,\066\n bringing her face close to #{master}'s lips...!" if $msg.t_enemy.positive?
    #==============================================================================
    # ●吸精・性器
    #==============================================================================
    when "吸精・性器"
      m = "#{speaker} closes her eyes,\066\n bringing her face close to #{master}'s crotch...!"
      m = "#{speaker} sｍiles,\066\n bringing her face close to #{master}'s crotch...!" if $msg.t_enemy.positive?
    #==============================================================================
    # ●視姦
    #==============================================================================
    when "視姦"
      emotion = ""
      case $msg.t_enemy.personality
      when "好色","高慢"
        emotion = "sｍiles suggestively"
      when "陽気","柔和","勝ち気"
        emotion = "sｍiles ｍischievously"
      when "虚勢","甘え性"
        emotion = "coyly glances in and out of eye contact"
      when "内気"
        emotion = "shyly turns her face the other ｗay"
      when "意地悪"
        emotion = "grins provacatively"
      when "不思議","上品","倒錯"
        emotion = "sｍiles mysteriously"
      when "淡泊","従順"
        emotion = "blushes slightly"
      when "天然"
        emotion = "looks ｗith a sleepy expression"
      else
        emotion = "stands on full display"
      end
      #テキスト整形(口、尻系は現在は封印のため、他部位に割り振り)
      case $msg.at_parts
      #胸や乳首で自慰
      when "対象：胸","対象：口"
        m = "#{speaker} #{emotion},\066\n tracing her #{$msg.t_enemy.bustsize} ｗith her finger!"
      #アソコに指入れで自慰
      when "対象：アソコ","対象：尻"
        m = "#{speaker} #{emotion},\066\n tracing a finger doｗn to her crotch!"
      #陰核を弄って自慰
      when "対象：陰核","対象：アナル"
        m = "#{speaker} #{emotion},\066\n tracing her finger around her clit!"
      end
    #==============================================================================
    # ●奉仕
    #==============================================================================
    when "奉仕"
      #テキスト整形
      case $msg.at_parts
      #キッスで奉仕
      when "対象：口"
        m = "#{speaker} closes her eyes,\066\n offering #{master} her lips!"
      #胸や乳首に奉仕
      when "対象：胸"
        m = "#{speaker} clings tightly to #{master},\066\n pressing her #{$msg.t_enemy.bustsize} against his arｍ!"
      #アソコに奉仕
      when "対象：アソコ","対象：アナル"
        m = "#{speaker} approaches #{master}\n\066 and spreads open her pussy ｗith her fingers!"
        m = "ｗith her fingers, #{speaker} bashfully spreads\066\n open her intiｍates!" if $msg.t_enemy.negative?
      #陰核に奉仕
      when "対象：陰核"
        m = "#{speaker} approaches #{master}\n\066 and spreads open her pussy ｗith her fingers!"
        m = "ｗith her fingers, #{speaker} bashfully spreads\066\n open her intiｍates!" if $msg.t_enemy.negative?
      #お尻に奉仕
      when "対象：尻"
        m = "Face doｗn, #{speaker} kneels over before #{master},\066\n and ｗaves her butt in front of his face!"
        m = "Face doｗn,#{speaker} shyly kneels over,\066\n ｗaving her rear in front of #{master}!" if $msg.t_enemy.negative?
      #アナルに奉仕
#      when "対象：アナル"
#        m = "#{master}は#{action}、\066\n#{speaker}の菊座を指で愛撫した！"
#        m = "#{master}は#{action}、\066\n#{speaker}の菊座に舌を這わせた！" if $game_variables[17] > 50 
      end
    #==============================================================================
    # ●愛撫・通常
    #==============================================================================
    when "愛撫・通常"
      emotion = ""
      case $msg.t_enemy.personality
      when "勝ち気","高慢","意地悪"
        emotion = "licks her lips"
      when "上品","柔和"
        emotion = "softly sｍiles"
      when "淡泊","虚勢"
        emotion = "glances fleetingly"
      when "内気","従順","倒錯"
        emotion = "looks ｗith feverish eyes"
      when "不思議","天然"
        emotion = "bears an adｍiring look"
      when "陽気","甘え性"
        emotion = "sｍiles ｍischievously"
      else #好色
        emotion = "sｍiles suggestively"
      end
      m = "#{speaker} #{emotion} as she gazes\066\n doｗn at #{master}'s crotch!"
    #==============================================================================
    # ●愛撫・通常
    #==============================================================================
    when "愛撫・性交"
      emotion = ""
      case $msg.t_enemy.personality
      when "勝ち気","高慢","意地悪"
        emotion = "licks her lips"
      when "上品","柔和"
        emotion = "softly sｍiles"
      when "淡泊","虚勢"
        emotion = "looks ｗith feverish eyes"
      when "内気","従順","倒錯"
        emotion = "stares ｗith longing eyes"
      when "不思議","天然"
        emotion = "bears a carefree sｍile"
      when "陽気","甘え性"
        emotion = "sｍiles ｍischievously"
      else #好色
        emotion = "sｍiles suggestively"
      end
      action = []
      case $msg.at_parts
      #▼インサート・アクセプト
      #--------------------------------------------------------------------------
      when "♀挿入：アソコ側","尻挿入：尻側"
        action.push("turning her backside toｗards #{master}")
        action.push("looking doｗn at #{master}") if $msg.t_enemy.initiative_level > 0
      when "口挿入：口側","パイズリ"
        action.push("looking up at #{master}")
        action.push("toying around ｗith #{master}'s penis") if $msg.t_enemy.initiative_level > 0
      when "背面拘束"
        action.push("holding #{master} doｗn even ｍore")
      else
        action.push("holding #{master} doｗn even ｍore")
      end
      action = action[rand(action.size)]
      m = "#{speaker} #{emotion},\066\n #{action}!"
    #==============================================================================
    # ●交合
    #==============================================================================
    when "交合"
      case $msg.t_enemy.personality
      when "好色"
        m = "#{speaker} teases open her pussy,\066\n smiling proｍiscuously as she beckons #{master}!" #前
        m = "#{speaker} craｗls doｗn on all fours,\066\n reaching back to spread her pussy teｍptingly!" if $game_variables[17] > 50 #後
      when "上品"
        m = "As if to teｍpt hiｍ, #{speaker}\n\066 spreads her legs and beckons #{master} ｗith her finger!" #前
        m = "#{speaker} craｗls doｗn on all fours,\066\n seductively gazing into #{master}'s eyes!" if $game_variables[17] > 50 #後
      when "高慢"
        m = "#{speaker} teases open her pussy,\066\n smiling at #{master} ｗith a procative gaze!" #前
        m = "#{speaker} thrusts out her ass,\066\n throｗing #{master} a daring smile!" if $game_variables[17] > 50 #後
      when "淡泊"
        m = "#{speaker} blushes shyly,\066\n opening up her legs for #{master} to see!" #前
        m = "#{speaker} craｗls doｗn on all fours,\066\n giving #{master} a ｗelcoming gaze!" if $game_variables[17] > 50 #後
      when "柔和"
        m = "As if to teｍpt hiｍ, #{speaker}\n\066 spreads her legs and beckons #{master} ｗith her finger!" #前
        m = "#{speaker} craｗls doｗn on all fours,\066\n reaching back to spread her pussy teｍptingly!" if $game_variables[17] > 50 #後
      when "勝ち気"
        m = "#{speaker} boldly spreads her legs apart,\066\n casting a provoking gaze at #{master}!" #前
        m = "#{speaker} craｗls doｗn on all fours,\066\n throｗing #{master} a fearless smile!" if $game_variables[17] > 50 #後
      when "内気"
        m = "Covering her face ｗith her hands,\066\n #{speaker} opens her legs for #{master} to see!" #前
        m = "#{speaker} craｗls doｗn on all fours,\066\n shaｍefully turns her butt toｗards #{master}!" if $game_variables[17] > 50 #後
      when "陽気"
        m = "#{speaker} boldly spreads her legs apart、\066\n staring at #{master} ｗith expectant eyes!" #前
        m = "#{speaker} thrusts out her ass,\066\n staring at #{master} ｗith expectant eyes!" if $game_variables[17] > 50 #後
      when "意地悪"
        m = "As if to teｍpt hiｍ, #{speaker}\n\066 spreads her legs and beckons #{master} ｗith her finger!" #前
        m = "#{speaker} craｗls doｗn on all fours, \066\n reaching back to spread her pussy teｍptingly!" if $game_variables[17] > 50 #後
      when "天然"
        m = "#{speaker} looks expectantly at #{master}\066\n as she spreads open her legs!" #前
        m = "#{speaker} craｗls doｗn on all fours,\066\n staring at #{master} ｗith longing eyes!" if $game_variables[17] > 50 #後
      when "従順"
        m = "#{speaker} boldly spreads her legs apart,\066\n looking obediently at #{master}!" #前
        m = "#{speaker} thrusts out her ass,\066\n staring at #{master} ｗith longing eyes!" if $game_variables[17] > 50 #後
      when "虚勢"
        m = "#{speaker} doggedly spreads open her legs,\066\n and shoots a provoking gaze at #{master}!" #前
        m = "#{speaker} thrusts out her ass,\066\n and looks at #{master} ｗith a challenging expression!" if $game_variables[17] > 50 #後
      when "倒錯"
        m = "#{speaker} teases open her pussy,\066\n throｗing #{master} a beｗitching smile!" #前
        m = "#{speaker} craｗls doｗn on all fours、\066\n staring at #{master} ｗith longing eyes!" if $game_variables[17] > 50 #後
      when "甘え性"
        m = "#{speaker} looks expectantly, \066\n ｗatching #{master} as she spreads her legs!" #前
        m = "#{speaker} craｗls doｗn on all fours,\066\n staring at #{master} ｗith longing eyes!" if $game_variables[17] > 50 #後
      when "不思議"
        m = "#{speaker} sloｗly opens up her legs, ｗatching \066\n #{master} as she lifts up her pelvis!" #前
        m = "#{speaker} thrusts out her ass,\066\n looking back at #{master}!" if $game_variables[17] > 50 #後
      when "独善"
        m = "#{speaker} opens her legs for display,\066\n throｗing #{master} a beｗitching smile!" #前
        m = "#{speaker} craｗls doｗn on all fours,\066\n arching her ass high as if to provoke #{master}!" if $game_variables[17] > 50 #後
      end
    end
   #============================================================================
    return if m == ""
    $game_temp.battle_log_text += m
  end
###############################################################################  
end