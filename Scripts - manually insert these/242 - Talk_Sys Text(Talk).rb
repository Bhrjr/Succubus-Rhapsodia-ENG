#==============================================================================
# �� Talk_Sys(������` 5)
#------------------------------------------------------------------------------
#   �����̌���������A�\�����邽�߂̃N���X�ł��B
#   ���̃N���X�̃C���X�^���X�� $msg �ŎQ�Ƃ���܂��B
#   �����ł̓g�[�N���̃V�`���G�[�V�������Ƃ̃e�L�X�g��ݒ肵�܂�
#==============================================================================
class Talk_Sys
  #============================================================================
  # ���g�[�N���̃e�L�X�g�ݒ�(����\���O�̃e�L�X�g)
  #============================================================================
  def make_text_aftertalk
    speaker = $msg.t_enemy.name #��b���̃G�l�~�[��
    master = $game_actors[101].name #��l����
    #���݂���Ȃ�A�p�[�g�i�[��
    if $msg.t_partner != nil
      servant = $msg.t_partner.name
    else
      servant = nil
    end
    m = ""
    case $msg.tag
    #==============================================================================
    # ����b�s������
    #==============================================================================
    when "�s����"
      case $msg.at_type
      when "�����N���C�V�X"
        m = "#{speaker} is immersed in pleasure...!\\n It's impossible to talk right no��...!"
      when "��l���N���C�V�X"
        m = "#{master} stares off vacantly...!\\n can't focus right no��!"
      when "�����Ⓒ��"
        m = "#{speaker} is climaxing....! \\n She incapable of talking right no��!"
      when "���s�ߑ�"
        m = "For some reason, #{speaker} doesn't seem\n\ to ��ant to talk anymore...."
      when "����������"
        m = "#{speaker} bears blissful expression....! \\n She incapable of talking right no��!"
        m = "#{speaker} has a transfixed look on her face....!\\n She seems unable to talk right no��...!" if $msg.t_enemy.holding?
      when "�����\����"
        m = "#{speaker} is violently aroused....!\\n She can't talk right no��!"
      end
    #==============================================================================
    # ����l���E��
    #==============================================================================
    when "��l���E��"
      case $msg.talk_step
      when 2 #�E�߂��󂯓��ꂽ�ꍇ
        m = "#{master} does as #{speaker} says, \\n taking off his o��n clothes!"
      when 77 #�E�߂����ۂ����ꍇ
        m = "#{master} declined!"
      end
    #==============================================================================
    # �����ԒE��
    #==============================================================================
    when "���ԒE��"
      case $msg.talk_step
      when 2 #���Ԃ̒E�߂��󂯓��ꂽ�ꍇ
        m = "#{master} does as #{speaker} says,\\n stripping #{servant} of her clothes!"
      when 77 #���Ԃ̒E�߂����ۂ����ꍇ
        m = "#{master} refused her demands!"
      end
    #==============================================================================
    # �������E��
    #==============================================================================
    when "�����E��"
      case $msg.talk_step
      when 2 #�E�߂����������ꍇ
        m = "#{master} does as she says, ��atching as\\n #{speaker} continued to undresses herself!"
        m = "#{master} unintentionally kept ��atching as \\n#{speaker} she undressed herself!" if $data_SDB[$msg.t_enemy.class_id].name == "�L���X�g"
        m = "#{master} watches hungrily, as #{speaker}\\n continued undressing herself!" if $game_actors[101].state?(35)
      when 77 #�E�߂����Ȃ������ꍇ
        m = "#{master} struggled to pull a��ay,\\n averting his eyes from #{speaker}!"
      end
    #==============================================================================
    # ���z���E��
    #==============================================================================
    when "�z���E��"
      case $msg.talk_step
      when 2 #�z�����󂯓��ꂽ�ꍇ
        m = "#{speaker} locks lips with #{master}!\\n #{master}'s energy is being drained out of his body...!"
      when 77 #�z�������ۂ����ꍇ
        m = "#{master} declined her demand!"
      end
    #==============================================================================
    # ���z���E����
    #==============================================================================
    when "�z���E����"
      case $msg.talk_step
      when 2 #�z�����󂯓��ꂽ�ꍇ
        m = "#{speaker} hungrily sucks on #{master}'s penis!\\n #{master}'s strength is being drained and replaced\\n by pleasure...!"
      when 77 #�z�������ۂ����ꍇ
        m = "#{master} declined her demand!"
      end
    #==============================================================================
    # ���D��
    #==============================================================================
    when "�D��"
      m = "#{speaker}�͖��X�ł��Ȃ��悤���c�c�I"
    #==============================================================================
    # ������
    #==============================================================================
    when "����"
      case $msg.talk_step
      when 77 #�������ŏ����猩�Ȃ������ꍇ
        m = "#{master} resists temptation,\\n averting his eyes from #{speaker}!"
      when 78 #������r���Œf�����ꍇ
        m = "#{master} manages to peel a��ay,\\n averting his eyes from #{speaker}!"
      when 79 #�����������Ė\�������ꍇ
        m = "#{master} cannot look a��ay from the sight before his eyes,\\n falling to #{speaker}'s temptation!"
      #�p�����Ă���ꍇ
      else
        m = "#{speaker} seeks to satisfy her desires....!"
        emotion = ""
        case $msg.t_enemy.personality
        when "�Ӓn��","����","�|��"
          emotion = " suggestively"
          emotion = " approaches #{master} and" if rand($mood.point) > 50
        when "�D�F","����","�z�C","�_�a","�����C"
          emotion = " stares at #{master} and le��dly"
          emotion = ", meeting #{master}'s gaze," if rand($mood.point) > 50
        when "�W��","�]��","�Â���","�s�v�c"
          emotion = ", absorbed in her act,"
          emotion = ", feeling #{master}'s gaze," if rand($mood.point) > 50
        when "���C","��i","�V�R"
          emotion = " turns her face a��ay as she slo��ly"
          emotion = " blushes as she" if rand($mood.point) > 50
        end
        #�e�L�X�g���`(���A�K�n�͌��݂͕���̂��߁A�����ʂɊ���U��)
        case $msg.at_parts
        #�������Ŏ���
        when "�ΏہF��","�ΏہF��"
          if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            m = "#{speaker}#{emotion} runs her\\n hands over her #{$msg.t_enemy.bustsize}!"
            m = "#{speaker}#{emotion} traces her\\n nipple ��ith her finger!" if rand($mood.point) > 50
          else
            m = "#{speaker}#{emotion} squeezes her m\n #{$msg.t_enemy.bustsize} ��ith her hands!"
            m = "#{speaker}#{emotion} traces her\\n nipple ��ith her finger!" if rand($mood.point) > 50
          end
        #�A�\�R�Ɏw����Ŏ���
        when "�ΏہF�A�\�R","�ΏہF�K"
          m = "#{speaker}#{emotion} rubs her\\n fingers in and out of her pussy!"
          m = "#{speaker}#{emotion} thrusts her\\n fingers in and out of her pussy!" if rand($mood.point) > 50
        #�A�j��M���Ď���
        when "�ΏہF�A�j","�ΏہF�A�i��"
          m = "#{speaker}#{emotion} rubs her\\n clit ��ith her finger!"
          m = "#{speaker}#{emotion} violently rubs\\n her clit ��ith her fingers!" if rand($mood.point) > 50
        end
      end
    #==============================================================================
    # ����d
    #==============================================================================
    when "��d"
      case $msg.talk_step
      when 77 #�������ŏ����猩�Ȃ������ꍇ
        m = "#{master}�͗U�f�ɕ������A\\n#{speaker}�̗v����f�����I"
        m = "#{master}�͌�딯���������v���ŁA\\n���Ƃ�#{speaker}�̗v����f�����I" if $game_actors[101].state?(35)
      when 78 #������r���Œf�����ꍇ
        m = "#{master} manages to peel a��ay,\\n#{speaker}�ւ̕�d�̎���~�߂��I"
      when 79 #�����������Ė\�������ꍇ
        m = "#{master}�͔M�ɕ������ꂽ�悤�ɁA#{speaker}�ւ̕�d�𑱂��Ă���c�c�I"
      #�p�����Ă���ꍇ
      else
        m = "#{master}��#{speaker}�����������I"
        action = ""
        action = "�X��" if $msg.talk_step > 3
        action = "������"if $msg.chain_attack == true and $msg.talk_step > 3
        action = "�U���邪�܂܂�" if $game_switches[89] == true
        #�e�L�X�g���`
        case $msg.at_parts
        #�L�b�X�ŕ�d
        when "�ΏہF��"
          m = "#{master}��#{action}�A\\n#{speaker}�ƌ����Ő�𗍂߂������I"
        #�������ɕ�d
        when "�ΏہF��"
          if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            m = "#{master}��#{action}�A\\n#{speaker}��#{$msg.t_enemy.bustsize}�𝆂݂��������I"
            m = "#{master}��#{action}�A\\n#{speaker}��#{$msg.t_enemy.bustsize}�����r�߉񂵂��I" if $game_variables[17] > 50 
          else
            m = "#{master}��#{action}�A\\n#{speaker}��#{$msg.t_enemy.bustsize}����ŕ��ŉ񂵂��I"
            m = "#{master}��#{action}�A\\n#{speaker}��#{$msg.t_enemy.bustsize}�����r�߉񂵂��I" if $game_variables[17] > 50 
          end
        #�A�\�R�ɕ�d
        when "�ΏہF�A�\�R","�ΏہF�A�i��"
          m = "#{master}��#{action}�A\\n#{speaker}�̃A�\�R�Ɏw�𔲂��}�������I"
          m = "#{master}��#{action}�A\\n#{speaker}�̃A�\�R�ɐ���o�����ꂵ���I" if $game_variables[17] > 50 
        #�A�j�ɕ�d
        when "�ΏہF�A�j"
          m = "#{master}��#{action}�A\\n#{speaker}�̉A�j���w�ň��������I"
          m = "#{master}��#{action}�A\\n#{speaker}�̉A�j�����r�ߏグ���I" if $game_variables[17] > 50 
        #���K�ɕ�d
        when "�ΏہF�K"
          m = "#{master}��#{action}�A\\n#{speaker}�̂��K�𗼎�ň��������I"
          m = "#{master}��#{action}�A\\n#{speaker}�̂��K�����r�߉񂵂��I" if $game_variables[17] > 50 
        #�A�i���ɕ�d
#        when "�ΏہF�A�i��"
#          m = "#{master}��#{action}�A\\n#{speaker}�̋e�����w�ň��������I"
#          m = "#{master}��#{action}�A\\n#{speaker}�̋e�������r�߉񂵂��I" if $game_variables[17] > 50 
        end
      end
    #==============================================================================
    # �������E����
    #==============================================================================
    when "�����E����"
      case $msg.talk_step
      when 77 #�������ŏ�����f�����ꍇ
        m = "#{master} resists temptation,\\n and #{speaker}'s proposal!"
        m = "#{master} reluctantly tears a��ay,\\n declining #{speaker}'s proposal!" if $game_actors[101].state?(35)
      when 78 #������r���Œf�����ꍇ
        m = "#{master} manages to peel a��ay,\\n stopping #{speaker} mid-thrust!"
      #���������󂯓��ꂽ�ꍇ
      else
        case $msg.at_parts
        #���C���T�[�g�E�A�N�Z�v�g
        #--------------------------------------------------------------------------
        when "���}���F�A�\�R��","�K�}���F�K��"
          if $game_variables[17] > 70
            if $game_actors[101].critical == true
              action = ["le��dly","tightly","firmly"]
              action = action[rand(action.size)]
              move = ["tightens around","strangles","squeezes"]
              move = move[rand(move.size)]
            else
              action = ""
              move = "���ߕt����"
            end
            hole = "pussy"
            hole = "ass" if $msg.at_parts == "�K�}���F�K��"
            m = "#{speaker}'s #{hole}\\n #{action} #{move} #{master}'s penis�I" 
          else
            if $game_actors[101].critical == true
              if $msg.t_enemy.initiative_level > 0
                #��
                action = "holds #{master} do��n"
                #��
                waist = ["boldly fucks","po��erfully fucks","intensely fucks"]
                waist.push("undulatingly fucks","le��dly fucks","pounds") if $msg.t_enemy.positive?
                waist.push("strenuously fucks","devotedly fucks","lazily fucks") if $msg.t_enemy.negative?
              else
                #��
                action = "entrusts herself to #{master}"
                #��
                waist = ["po��erfully fucks"]
                waist.push("le��dly fucks") if $msg.t_enemy.positive?
                waist.push("strenuously fucks") if $msg.t_enemy.negative?
              end
              waist = waist[rand(waist.size)]
            else
              if $msg.t_enemy.initiative_level > 0
                #��
                action = "gazes at #{master}"
                #��
                waist = ["slowly fucks","bounces on top of","gyrates on top"]
                waist.push("teasingly fucks","comfortably fucks") if $msg.t_enemy.positive?
                waist.push("modestly fucks","shamefully fucks") if $msg.t_enemy.negative?
              else
                #��
                action = "matches #{master}'s pace"
                #��
                waist = ["slo��ly fucks"]
                waist.push("teasingly fucks") if $msg.t_enemy.positive?
                waist.push("modestly fucks") if $msg.t_enemy.negative?
              end
              waist = waist[rand(waist.size)]
            end
            m = "#{speaker} #{action} as she #{waist} him!"
          end
        #���I�[����
        #--------------------------------------------------------------------------
        when "���}���F����"
          if $game_actors[101].critical == true
            if $msg.t_enemy.initiative_level > 0
              #��
              action = "sucks"
              #��
              mouth = ["boldly","noisily","intensely"]
              mouth.push("deeply","le��dly","slowly") if $msg.t_enemy.positive?
              mouth.push("strenuously","devotedly","lazily") if $msg.t_enemy.negative?
              mouth.push("amorously") if $mood.point > 70
            else
              #��
              action = "deepthroats"
              #��
              mouth = ["boldly"]
              mouth.push("le��dly") if $msg.t_enemy.positive?
              mouth.push("streneously") if $msg.t_enemy.negative?
              mouth.push("amorously") if $mood.point > 70
            end
            mouth = mouth[rand(mouth.size)]
          else
            if $msg.t_enemy.initiative_level > 0
              #��
              action = "sucks"
              #��
              mouth = ["slowly"]
              mouth.push("teasingly","comfortably") if $msg.t_enemy.positive?
              mouth.push("timidly","modestly","shamefully") if $msg.t_enemy.negative?
              mouth.push("amorously") if $mood.point > 70
            else
              #��
              action = "deepthroats"
              #��
              mouth = ["slo��ly"]
              mouth.push("teasingly","gradually") if $msg.t_enemy.positive?
              mouth.push("timidly","hesitantly") if $msg.t_enemy.negative?
            end
            mouth = mouth[rand(mouth.size)]
          end
          m = "#{speaker} #{mouth} #{action} #{master}'s penis!"
        #���p�C�Y��
        #--------------------------------------------------------------------------
        when "�p�C�Y��"
          if $game_actors[101].critical == true
            action = "fucks"
            #��
            bust = ["boldly","deliberately"]
            bust.push("lewdly","po��erfully") if $msg.t_enemy.positive?
            bust.push("strenuously","devotedly","lazily") if $msg.t_enemy.negative?
            bust.push("amorously") if $mood.point > 70
          else
            action = "sandwiches"
            #��
            bust = ["slowly","tightly"]
            bust.push("teasingly","comfortably") if $msg.t_enemy.positive?
            bust.push("timidly","modestly","shamefully") if $msg.t_enemy.negative?
            bust.push("amorously") if $mood.point > 70
          end
          bust = bust[rand(bust.size)]
          m = "#{speaker} #{bust} #{action} #{master}'s penis\\n ��ith her #{$msg.t_enemy.bustsize}!"
        #--------------------------------------------------------------------------
        when "�w�ʍS��"
          action = []
          if $game_actors[101].critical == true
            action.push("�̎�؂�����r�߂Ă����I")
            action.push("�̎����Ԃ��Ê��݂��Ă����I")
            action.push("�̓��������r�߂Ă����I")
            action.push("�Ɏ����̋��������t���Ă����I")
            #�y�j�X���󂢂Ă���ꍇ
            if $game_actors[101].hold.penis.battler == nil
              action.push("�̃y�j�X���w�ŘM���Ă����I") 
              action.push("�̃y�j�X���w��ŕ��łĂ����I")
            #�y�j�X���C���T�[�g���̏ꍇ(�A�i���܂�)
            elsif $game_actors[101].penis_insert? or $game_actors[101].penis_analsex?
              hold_target = $game_actors[101].hold.penis.battler
              action.push("�̍���O�ɉ����o�����I\\n#{hold_target}�Ƃ̌����������[���Ȃ����I")
            #�y�j�X���p�C�Y�����̏ꍇ
            elsif $game_actors[101].penis_paizuri?
              action.push("�̍������������񂾁I\\n#{hold_target}�̓������X�Ɍ������Ȃ����I")
            end
          else
            action.push("�̂킫�̉������r�߂Ă����I")
            action.push("�̎�؂ɂӂ����Ƒ��𐁂��������I")
            action.push("�̋��Ɏw�𔇂킹�Ă����I")
            action.push("�̍������킳��ƕ��łĂ����I")
            action.push("�̑����������킳��ƕ��łĂ����I")
          end
          action = action[rand(action.size)]
          m = "#{speaker}�͖��������܂܁A\\n#{master}#{action}"
        end
      #--------------------------------------------------------------------------
      end
    #==============================================================================
    # �������E�ʏ�
    #==============================================================================
    when "�����E�ʏ�"
      case $msg.talk_step
      when 77 #�������ŏ�����f�����ꍇ
        m = "#{master}�͗U�f�ɕ������A\\n#{speaker}�̐\���o��f�����I"
        m = "#{master}�͌�딯���������v���ŁA\\n���Ƃ�#{speaker}�̗v����f�����I" if $game_actors[101].state?(35)
      when 78 #������r���Œf�����ꍇ
        m = "#{master}�͉��Ƃ��ӎv��U��i��A\\n#{speaker}�̍s�ׂ��������߂��I"
      #���������󂯓��ꂽ�ꍇ
      else
        m = "#{speaker}�͔��΂ނƁA\\n#{master}�̃y�j�X���������Ă����I"
        case $msg.at_type
        #--------------------------------------------------------------------------
        when "��"
          #����_��˂���
          if $game_actors[101].critical == true
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͔������y���ނ��̂悤�ɁA\\n#{master}�̃y�j�X�����������w�ŘM�ԁI"
                m = "#{speaker}�͈������ނ��̂悤�ɁA\\n#{master}�̃y�j�X�����������w�ŘM�ԁI" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}�͐S�����w�J���ŁA\\n#{master}�̃y�j�X���Ԓf�Ȃ��U�ߗ��ĂĂ����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͊Ԓf�Ȃ��A\\n#{master}�̃y�j�X�̕q���ȕ������U�߂Ă����I"
              else
                m = "#{speaker}�͎w�𗍂߂āA\\n#{master}�̃y�j�X�̕q���ȕ������U�߂Ă����I"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͊Ԓf�Ȃ��A\\n#{master}�̃y�j�X���w�ōU�ߗ��Ă�I"
              else
                m = "#{speaker}�͎w�𗍂߂āA\\n#{master}�̃y�j�X���������グ�Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�́A\\n#{master}�̃y�j�X�Ɏw�𗍂߈������Ă����I"
              else
                m = "#{speaker}�͎�ŁA\\n#{master}�̃y�j�X���������Ă����I"
              end
            end
          end
        #--------------------------------------------------------------------------
        when "��"
          #����_��˂���
          if $game_actors[101].critical == true
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͔������y���ނ��̂悤�ɁA\\n#{master}�̃y�j�X�����������r�ߏグ�Ă����I"
                m = "#{speaker}�͈������ނ��̂悤�ɁA\\n#{master}�̃y�j�X�����������r�ߏグ�Ă����I" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}�͐S������g���ŁA\\n#{master}�̃y�j�X���Ԓf�Ȃ��r�߉񂵂Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͊Ԓf�Ȃ��A\\n#{master}�̃y�j�X�̕q���ȕ������r�ߑ������I"
              else
                m = "#{speaker}�͐��ŁA\\n#{master}�̃y�j�X�̕q���ȕ������r�ߏグ���I"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͊Ԓf�Ȃ��A\\n#{master}�̃y�j�X��O�O���r�ߏグ�Ă����I"
              else
                m = "#{speaker}�͐��ŁA\\n#{master}�̃y�j�X���ł炷�悤���r�ߏグ���I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͋x�ނ��ƂȂ��A\\n#{master}�̃y�j�X��O�O���r�ߏグ�Ă����I"
              else
                m = "#{speaker}�͐�ŁA\\n#{master}�̃y�j�X���r�ߏグ�Ă����I"
              end
            end
          end
        #--------------------------------------------------------------------------
        when "��"
          #����_��˂���
          if $game_actors[101].critical == true
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͔������y���ނ��̂悤�ɁA\\n#{master}�̃y�j�X�𗼑��̗��ł������Ă����I"
                m = "#{speaker}�͈������ނ��̂悤�ɁA\\n#{master}�̃y�j�X�𗼑��̗��ł������Ă����I" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}�͐S���Ă���ƌ����΂���ɁA\\n#{master}�̃y�j�X�𑫗��ŝs�ˉ񂵂Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͋x�ނ��ƂȂ��A\\n#{master}�̃y�j�X�𑫗��ŝs�ˉ񂵂Ă����I"
              else
                m = "#{speaker}�͑��̗��ŁA\\n#{master}�̃y�j�X�̕q���ȕ������������Ă����I"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͊ɋ}�����Ȃ���A\\n#{master}�̃y�j�X�𑫂̎w�ōX�ɘM�ԁI"
              else
                m = "#{speaker}�͑��̎w�ŁA\\n#{master}�̃y�j�X���ł炷�悤�ɘM��ł����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͊ɋ}�����Ȃ���A\\n#{master}�̃y�j�X�𑫗��ł������Ă����I"
              else
                m = "#{speaker}�͑��̗��ŁA\\n#{master}�̃y�j�X���y�����݂����I"
              end
            end
          end
        #--------------------------------------------------------------------------
        when "��"
          if $msg.chain_attack == true
            m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X���Ԓf�Ȃ��������Ă����I"
            m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\\n#{master}�̃y�j�X�ɎC��t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
          else
            m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X�����݂������Ă����I"
            m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
          end
          #����_��˂���
          if $game_actors[101].critical == true
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
                  m = "#{speaker}�͔������y���ނ��̂悤�ɁA\\n#{$msg.t_enemy.bustsize}���y�j�X�ɎC��t���Ă����I"
                  m = "#{speaker}�͈������ނ��̂悤�ɁA\\n#{$msg.t_enemy.bustsize}���y�j�X�ɎC��t���Ă����I" if $msg.t_enemy.love > 0
                else
                  m = "#{speaker}�͔������y���ނ��̂悤�ɁA\\n#{$msg.t_enemy.bustsize}�Ńy�j�X�����������������Ă����I"
                  m = "#{speaker}�͈������ނ��̂悤�ɁA\\n#{$msg.t_enemy.bustsize}�Ńy�j�X�����������������Ă����I" if $msg.t_enemy.love > 0
                end
              else
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X�����݂������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X���Ԓf�Ȃ��������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\\n#{master}�̃y�j�X�ɎC��t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              else
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X�����݂������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X���Ԓf�Ȃ��������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\\n#{master}�̃y�j�X�ɎC��t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              else
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X�����݂������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X���Ԓf�Ȃ��������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\\n#{master}�̃y�j�X�ɎC��t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              else
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X�����݂������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              end
            end
          end
        #--------------------------------------------------------------------------
        when "��"
          #����_��˂���
          if $game_actors[101].critical == true
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "As if enjoying his reaction, #{speaker}\\n continues to bounce up and do��n #{master}'s penis!"
                m = "#{speaker} continues to lovingly bounce\\n up and do��n #{master}'s penis!" if $msg.t_enemy.love > 0
              else
                m = "Having found his ��eakness, #{speaker} grinds\\n her pussy do��n on #{master}'s penis!"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker} continues grinding her hips\\n back and forth on #{master}'s penis!"
              else
                m = "#{speaker} rubs her pussy on #{master},\\n vigorously inciting response from his penis!"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker} continues bouncing\\n atop #{master}'s penis!"
              else
                m = "#{speaker} rubs her pussy against\\n #{master}'s penis!"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker} continues bouncing\\n atop #{master}'s penis!"
              else
                m = "#{speaker} rubs her pussy against\\n #{master}'s penis!"
              end
            end
          end
        #--------------------------------------------------------------------------
        when "�K��"
          #����_��˂���
          if $game_actors[101].critical == true
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͔������y���ނ��̂悤�ɁA\\n#{master}�̃y�j�X��K���ł������Ă����I"
                m = "#{speaker}�͈������ނ��̂悤�ɁA\\n#{master}�̃y�j�X��K���ł������Ă����I" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}�͊��ꂽ���g���ŁA\\n#{master}�̃y�j�X��K���ŘM��ł����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͐K�������˂点�A\\n#{master}�̃y�j�X���Ԓf�Ȃ��������グ�Ă����I"
              else
                m = "#{speaker}�͐K�����I�݂Ɏg���A\\n#{master}�̃y�j�X���������グ�Ă����I"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�̓��Y�~�J���ɁA\\n�K����#{master}�̃y�j�X���������グ�Ă����I"
              else
                m = "#{speaker}�͎����̐K�����A\\n#{master}�̃y�j�X�Ɋ����t���Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�̓��Y�~�J���ɁA\\n�K����#{master}�̃y�j�X���������グ�Ă����I"
              else
                m = "#{speaker}�͎����̐K�����A\\n#{master}�̃y�j�X�Ɋ����t���Ă����I"
              end
            end
          end
        end
        #���z�[���h�b��[�u
        if $msg.t_enemy.holding_now?
        case $msg.at_parts
        #���I�[����
        #--------------------------------------------------------------------------
        when "���}���F����"
          if $game_actors[101].critical == true
            if $msg.t_enemy.initiative_level > 0
              #��
              action = "����Ԃ��Ă���"
              #��
              mouth = ["��_��","���𗧂Ă�","������"]
              mouth.push("�z�����ނ悤��","��������","�ɋ}������") if $msg.t_enemy.positive?
              mouth.push("�ꏊ������","��S�s����","�������\���") if $msg.t_enemy.negative?
              mouth.push("�������ނ悤��") if $mood.point > 70
            else
              #��
              action = "�A���܂œۂݍ���ł���"
              #��
              mouth = ["��_��"]
              mouth.push("�d���ȕ\���") if $msg.t_enemy.positive?
              mouth.push("�ꏊ������") if $msg.t_enemy.negative?
              mouth.push("�������ނ悤��") if $mood.point > 70
            end
            mouth = mouth[rand(mouth.size)]
          else
            if $msg.t_enemy.initiative_level > 0
              #��
              action = "����Ԃ��Ă���"
              #��
              mouth = ["��������"]
              mouth.push("�ł炷�悤��","��������") if $msg.t_enemy.positive?
              mouth.push("����������","�T���߂�","�p�炢��") if $msg.t_enemy.negative?
              mouth.push("�������ނ悤��") if $mood.point > 70
            else
              #��
              action = "�A���܂œۂݍ���ł���"
              #��
              mouth = ["��������"]
              mouth.push("�ł炷�悤��","���킶���") if $msg.t_enemy.positive?
              mouth.push("����������","�ӂ�������") if $msg.t_enemy.negative?
            end
            mouth = mouth[rand(mouth.size)]
          end
          m = "#{speaker}��#{master}�̃y�j�X���A\\n#{mouth}#{action}�I"
        #���p�C�Y��
        #--------------------------------------------------------------------------
        when "�p�C�Y��"
          if $game_actors[101].critical == true
            action = "�������Ă���"
            #��
            bust = ["��_��","������"]
            bust.push("��������","�ɋ}������") if $msg.t_enemy.positive?
            bust.push("�ꏊ������","��S�s����","�������\���") if $msg.t_enemy.negative?
            bust.push("�������ނ悤��") if $mood.point > 70
          else
            action = "����ł���"
            #��
            bust = ["��������","�㉺��"]
            bust.push("�ł炷�悤��","��������") if $msg.t_enemy.positive?
            bust.push("����������","�T���߂�","�p�炢��") if $msg.t_enemy.negative?
            bust.push("�������ނ悤��") if $mood.point > 70
          end
          bust = bust[rand(bust.size)]
          m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\\n#{master}�̃y�j�X��#{bust}#{action}�I"
        #--------------------------------------------------------------------------
        when "�w�ʍS��"
          action = []
          if $game_actors[101].critical == true
            action.push("�̎�؂�����r�߂Ă����I")
            action.push("�̎����Ԃ��Ê��݂��Ă����I")
            action.push("�̓��������r�߂Ă����I")
            action.push("�Ɏ����̋��������t���Ă����I")
            #�y�j�X���󂢂Ă���ꍇ
            if $game_actors[101].hold.penis.battler == nil
              action.push("�̃y�j�X���w�ŘM���Ă����I") 
              action.push("�̃y�j�X���w��ŕ��łĂ����I")
            #�y�j�X���C���T�[�g���̏ꍇ(�A�i���܂�)
            elsif $game_actors[101].penis_insert? or $game_actors[101].penis_analsex?
              hold_target = $game_actors[101].hold.penis.battler
              action.push("�̍���O�ɉ����o�����I\\n#{hold_target}�Ƃ̌����������[���Ȃ����I")
            #�y�j�X���p�C�Y�����̏ꍇ
            elsif $game_actors[101].penis_paizuri?
              action.push("�̍������������񂾁I\\n#{hold_target}�̓������X�Ɍ������Ȃ����I")
            end
          else
            action.push("�̂킫�̉������r�߂Ă����I")
            action.push("�̎�؂ɂӂ����Ƒ��𐁂��������I")
            action.push("�̋��Ɏw�𔇂킹�Ă����I")
            action.push("�̍������킳��ƕ��łĂ����I")
            action.push("�̑����������킳��ƕ��łĂ����I")
          end
          action = action[rand(action.size)]
          m = "#{speaker}�͖��������܂܁A\\n#{master}#{action}"
        end
        end #if $msg.t_enemy.holding_now?
      #--------------------------------------------------------------------------
      end
    #==============================================================================
    # ������
    #==============================================================================
    when "����"
      case $msg.at_type
      when "���}��"
        case $msg.talk_step
        when 2 #�}�����
          m = "Having invited #{master}, #{speaker} quickly\\n stabs his penis into her pussy before he can escape!"
        when 77 #�}������
          m = "#{master} hardens his resolve to resist her invitation!"
        end
#      when "���}��"
#      when "�K�}��"
#      when "�p�C�Y��"
#      when "�L�b�X"
      end
    end
    #============================================================================
    return if m == ""
    $game_temp.battle_log_text += m
  end

###############################################################################  
  #============================================================================
  # ���g�[�N���̃e�L�X�g�ݒ�(����\���O�̃e�L�X�g)
  #============================================================================
  def make_text_pretalk
    speaker = $msg.t_enemy.name #��b���̃G�l�~�[��
    master = $game_actors[101].name #��l����
    #���݂���Ȃ�A�p�[�g�i�[��
    if $msg.t_partner != nil
      servant = $msg.t_partner.name
    else
      servant = nil
    end
    m = ""
    case $msg.tag
    #==============================================================================
    # ����l���E��
    #==============================================================================
    when "��l���E��"
      m = "#{speaker} leans on #{master}'s chest,\\n gazing deeply into his eyes...!"
      m = "#{speaker} leans on #{master}, taking fleeting\\n glances at him ��hile t��irling her finger on his chest!" if $msg.t_enemy.negative?
    #==============================================================================
    # �����ԒE��
    #==============================================================================
    when "���ԒE��"
      m = "#{speaker} gazes at #{servant}\\n ��ith a suggestive look on her face...!"
      m = "#{speaker} stares at #{servant}\\n ��ith an insinuating look on her face...!" if $msg.t_enemy.negative?
    #==============================================================================
    # �������E��
    #==============================================================================
    when "�����E��"
      m = "#{speaker} begins peeling back her clothes,\\n turning to��ards #{master} ��ith a lustful expression!"
      m = "#{speaker} begins peeling back her clothes,\\n eyeing #{master} ��ith suggestive intent!" if $msg.t_enemy.negative?
      m = "#{speaker} shakes the jiggling slime covering\\n her body in front of #{master}'s eyes....!" if $msg.t_enemy.tribe_slime?
    #==============================================================================
    # ���z���E��
    #==============================================================================
    when "�z���E��"
      m = "#{speaker} closes her eyes,\\n bringing her face close to #{master}'s lips...!"
      m = "#{speaker} smiles,\\n bringing her face close to #{master}'s lips...!" if $msg.t_enemy.positive?
    #==============================================================================
    # ���z���E����
    #==============================================================================
    when "�z���E����"
      m = "#{speaker} closes her eyes,\\n bringing her face close to #{master}'s crotch...!"
      m = "#{speaker} smiles,\\n bringing her face close to #{master}'s crotch...!" if $msg.t_enemy.positive?
    #==============================================================================
    # ������
    #==============================================================================
    when "����"
      emotion = ""
      case $msg.t_enemy.personality
      when "�D�F","����"
        emotion = "smiles suggestively"
      when "�z�C","�_�a","�����C"
        emotion = "smiles mischievously"
      when "����","�Â���"
        emotion = "coyly glances in and out of eye contact"
      when "���C"
        emotion = "shyly turns her face the other ��ay"
      when "�Ӓn��"
        emotion = "grins provacatively"
      when "�s�v�c","��i","�|��"
        emotion = "smiles mysteriously"
      when "�W��","�]��"
        emotion = "blushes slightly"
      when "�V�R"
        emotion = "looks ��ith a sleepy expression"
      else
        emotion = "stands on full display"
      end
      #�e�L�X�g���`(���A�K�n�͌��݂͕���̂��߁A�����ʂɊ���U��)
      case $msg.at_parts
      #�������Ŏ���
      when "�ΏہF��","�ΏہF��"
        m = "#{speaker} #{emotion},\\n tracing her #{$msg.t_enemy.bustsize} ��ith her finger!"
      #�A�\�R�Ɏw����Ŏ���
      when "�ΏہF�A�\�R","�ΏہF�K"
        m = "#{speaker} #{emotion},\\n tracing a finger do��n to her crotch!"
      #�A�j��M���Ď���
      when "�ΏہF�A�j","�ΏہF�A�i��"
        m = "#{speaker} #{emotion},\\n tracing her finger around her clit!"
      end
    #==============================================================================
    # ����d
    #==============================================================================
    when "��d"
      #�e�L�X�g���`
      case $msg.at_parts
      #�L�b�X�ŕ�d
      when "�ΏہF��"
        m = "#{speaker} closes her eyes,\\n offering #{master} her lips!"
      #�������ɕ�d
      when "�ΏہF��"
        m = "#{speaker} clings tightly to #{master},\\n pressing her #{$msg.t_enemy.bustsize} against his arm!"
      #�A�\�R�ɕ�d
      when "�ΏہF�A�\�R","�ΏہF�A�i��"
        m = "#{speaker} approaches #{master}\n\ and spreads open her pussy ��ith her fingers!"
        m = "��ith her fingers, #{speaker} bashfully spreads\\n open her intimates!" if $msg.t_enemy.negative?
      #�A�j�ɕ�d
      when "�ΏہF�A�j"
        m = "#{speaker} approaches #{master}\n\ and spreads open her pussy ��ith her fingers!"
        m = "��ith her fingers, #{speaker} bashfully spreads\\n open her intimates!" if $msg.t_enemy.negative?
      #���K�ɕ�d
      when "�ΏہF�K"
        m = "Face do��n, #{speaker} kneels over before #{master},\\n and ��aves her butt in front of his face!"
        m = "Face do��n,#{speaker} shyly kneels over,\\n ��aving her rear in front of #{master}!" if $msg.t_enemy.negative?
      #�A�i���ɕ�d
#      when "�ΏہF�A�i��"
#        m = "#{master}��#{action}�A\\n#{speaker}�̋e�����w�ň��������I"
#        m = "#{master}��#{action}�A\\n#{speaker}�̋e���ɐ�𔇂킹���I" if $game_variables[17] > 50 
      end
    #==============================================================================
    # �������E�ʏ�
    #==============================================================================
    when "�����E�ʏ�"
      emotion = ""
      case $msg.t_enemy.personality
      when "�����C","����","�Ӓn��"
        emotion = "licks her lips"
      when "��i","�_�a"
        emotion = "softly smiles"
      when "�W��","����"
        emotion = "glances fleetingly"
      when "���C","�]��","�|��"
        emotion = "looks ��ith feverish eyes"
      when "�s�v�c","�V�R"
        emotion = "bears an admiring look"
      when "�z�C","�Â���"
        emotion = "smiles mischievously"
      else #�D�F
        emotion = "smiles suggestively"
      end
      m = "#{speaker}��#{emotion}�A\\n#{master}�̃y�j�X�����߂Ă���I"
      #���ʃz�[���h�̐�p���o����܂ł̈ꎞ�[�u(@0830)
      if $msg.t_enemy.holding_now?
        emotion = ""
        case $msg.t_enemy.personality
        when "�����C","����","�Ӓn��"
          emotion = "��Ȃ߂��������"
        when "��i","�_�a"
          emotion = "�_�炩���΂݂𕂂���"
        when "�W��","����"
          emotion = "�M���ۂ�����"
        when "���C","�]��","�|��"
          emotion = "���񂾓���"
        when "�s�v�c","�V�R"
          emotion = "�����̖����΂݂𕂂���"
        when "�z�C","�Â���"
          emotion = "���Y���ۂ��΂݂𕂂���"
        else #�D�F
          emotion = "�d���ȏ΂݂𕂂���"
        end
        action = []
        case $msg.at_parts
        #���C���T�[�g�E�A�N�Z�v�g
        #--------------------------------------------------------------------------
        when "���}���F�A�\�R��","�K�}���F�K��"
          action.push("�̔w�ɘr���񂵂Ă���")
          action.push("�������낵�Ă���") if $msg.t_enemy.initiative_level > 0
        when "���}���F����","�p�C�Y��"
          action.push("�����グ�Ă���")
          action.push("�̃y�j�X�ƋY��Ă���") if $msg.t_enemy.initiative_level > 0
        when "�w�ʍS��"
          action.push("�ɍX�ɐg�̂𖧒������Ă���")
        else
          action.push("�ɍX�ɐg�̂𖧒������Ă���")
        end
        action = action[rand(action.size)]
        m = "#{speaker}��#{emotion}�A\\n#{master}#{action}�I"
      end
    #==============================================================================
    # �������E����
    #==============================================================================
    when "�����E����"
      emotion = ""
      case $msg.t_enemy.personality
      when "�����C","����","�Ӓn��"
        emotion = "licks her lips"
      when "��i","�_�a"
        emotion = "softly smiles"
      when "�W��","����"
        emotion = "looks ��ith feverish eyes"
      when "���C","�]��","�|��"
        emotion = "stares ��ith longing eyes"
      when "�s�v�c","�V�R"
        emotion = "bears a carefree smile"
      when "�z�C","�Â���"
        emotion = "smiles mischievously"
      else #�D�F
        emotion = "smiles suggestively"
      end
      action = []
      case $msg.at_parts
      #���C���T�[�g�E�A�N�Z�v�g
      #--------------------------------------------------------------------------
      when "���}���F�A�\�R��","�K�}���F�K��"
        action.push("turning her backside to��ards #{master}")
        action.push("looking do��n at #{master}") if $msg.t_enemy.initiative_level > 0
      when "���}���F����","�p�C�Y��"
        action.push("looking up at #{master}")
        action.push("toying around ��ith #{master}'s penis") if $msg.t_enemy.initiative_level > 0
      when "�w�ʍS��"
        action.push("holding #{master} do��n even more")
      else
        action.push("holding #{master} do��n even more")
      end
      action = action[rand(action.size)]
      m = "#{speaker} #{emotion},\\n #{action}!"
    #==============================================================================
    # ������
    #==============================================================================
    when "����"
      case $msg.t_enemy.personality
      when "�D�F"
        m = "#{speaker} teases open her pussy,\\n smiling promiscuously as she beckons #{master}!" #�O
        m = "#{speaker} crawls do��n on all fours,\\n reaching back to spread her pussy temptingly!" if $game_variables[17] > 50 #��
      when "��i"
        m = "As if to tempt him, #{speaker}\n\ spreads her legs and beckons #{master} ��ith her finger!" #�O
        m = "#{speaker} crawls do��n on all fours,\\n seductively gazing into #{master}'s eyes!" if $game_variables[17] > 50 #��
      when "����"
        m = "#{speaker} teases open her pussy,\\n smiling at #{master} ��ith a procative gaze!" #�O
        m = "#{speaker} thrusts out her ass,\\n throwing #{master} a daring smile!" if $game_variables[17] > 50 #��
      when "�W��"
        m = "#{speaker} blushes shyly,\\n opening up her legs for #{master} to see!" #�O
        m = "#{speaker} crawls do��n on all fours,\\n giving #{master} a welcoming gaze!" if $game_variables[17] > 50 #��
      when "�_�a"
        m = "As if to tempt him, #{speaker}\n\ spreads her legs and beckons #{master} ��ith her finger!" #�O
        m = "#{speaker} crawls do��n on all fours,\\n reaching back to spread her pussy temptingly!" if $game_variables[17] > 50 #��
      when "�����C"
        m = "#{speaker} boldly spreads her legs apart,\\n casting a provoking gaze at #{master}!" #�O
        m = "#{speaker} crawls do��n on all fours,\\n throwing #{master} a fearless smile!" if $game_variables[17] > 50 #��
      when "���C"
        m = "Covering her face ��ith her hands,\\n #{speaker} opens her legs for #{master} to see!" #�O
        m = "#{speaker} crawls do��n on all fours,\\n shamefully turns her butt to��ards #{master}!" if $game_variables[17] > 50 #��
      when "�z�C"
        m = "#{speaker} boldly spreads her legs apart�A\\n staring at #{master} ��ith expectant eyes!" #�O
        m = "#{speaker} thrusts out her ass,\\n staring at #{master} ��ith expectant eyes!" if $game_variables[17] > 50 #��
      when "�Ӓn��"
        m = "As if to tempt him, #{speaker}\n\ spreads her legs and beckons #{master} ��ith her finger!" #�O
        m = "#{speaker} crawls do��n on all fours, \\n reaching back to spread her pussy temptingly!" if $game_variables[17] > 50 #��
      when "�V�R"
        m = "#{speaker} looks expectantly at #{master}\\n as she spreads open her legs!" #�O
        m = "#{speaker} cra��ls do��n on all fours,\\n staring at #{master} ��ith longing eyes!" if $game_variables[17] > 50 #��
      when "�]��"
        m = "#{speaker} boldly spreads her legs apart,\\n looking obediently at #{master}!" #�O
        m = "#{speaker} thrusts out her ass,\\n staring at #{master} ��ith longing eyes!" if $game_variables[17] > 50 #��
      when "����"
        m = "#{speaker} doggedly spreads open her legs,\\n and shoots a provoking gaze at #{master}!" #�O
        m = "#{speaker} thrusts out her ass,\\n and looks at #{master} ��ith a challenging expression!" if $game_variables[17] > 50 #��
      when "�|��"
        m = "#{speaker} teases open her pussy,\\n thro��ing #{master} a bewitching smile!" #�O
        m = "#{speaker} cra��ls do��n on all fours�A\\n staring at #{master} ��ith longing eyes!" if $game_variables[17] > 50 #��
      when "�Â���"
        m = "#{speaker} looks expectantly, \\n ��atching #{master} as she spreads her legs!" #�O
        m = "#{speaker} cra��ls do��n on all fours,\\n staring at #{master} ��ith longing eyes!" if $game_variables[17] > 50 #��
      when "�s�v�c"
        m = "#{speaker} slowly opens up her legs, ��atching \\n #{master} as she lifts up her pelvis!" #�O
        m = "#{speaker} thrusts out her ass,\\n looking back at #{master}!" if $game_variables[17] > 50 #��
      when "�ƑP"
        m = "#{speaker} opens her legs for display,\\n throwing #{master} a bewitching smile!" #�O
        m = "#{speaker} crawls do��n on all fours,\\n arching her ass high as if to provoke #{master}!" if $game_variables[17] > 50 #��
      end
    end
   #============================================================================
    return if m == ""
    $game_temp.battle_log_text += m
  end
###############################################################################  
end