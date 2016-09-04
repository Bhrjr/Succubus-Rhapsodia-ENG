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
        m = "#{speaker}�͉����ɓM��Ă���c�c�I\m\n���͘b���o�����Ԃł͂Ȃ��c�c�I"
      when "��l���N���C�V�X"
        m = "#{speaker}�͏΂݂𕂂��ׂĂ���c�c�I\m\n���͘b�𕷂��Ă��炦�����ɂȂ��c�c�I"
      when "�����Ⓒ��"
        m = "#{speaker}�͉����ɐg�ウ���Ă���c�c�I\m\n���͘b���o�����Ԃł͂Ȃ��c�c"
      when "���s�ߑ�"
        m = "#{speaker}�͂ǂ����A\m\n����ȏ�b�𕷂��Ă��ꂻ���ɂȂ��c�c"
      when "����������"
        m = "#{speaker}�͕��S���Ă���c�c�I\m\n���͘b���o�����Ԃł͂Ȃ��c�c�I"
        m = "#{speaker}�͈Ӗ��[�ȏ΂݂𕂂��ׂĂ���c�c�I\m\n���͘b�𕷂��Ă��炦�����ɂȂ��c�c�I" if $msg.t_enemy.holding?
      when "�����\����"
        m = "#{speaker}�͋ɓx�ɋ������Ă���c�c�I\m\n���͘b���o�����Ԃł͂Ȃ��c�c�I"
      end
    #==============================================================================
    # ����l���E��
    #==============================================================================
    when "��l���E��"
      case $msg.talk_step
      when 2 #�E�߂��󂯓��ꂽ�ꍇ
        m = "#{master}��#{speaker}�̌����ʂ�ɁA\m\n���畞��E�����I"
      when 77 #�E�߂����ۂ����ꍇ
        m = "#{master}�͎v���Ƃǂ܂����I"
      end
    #==============================================================================
    # �����ԒE��
    #==============================================================================
    when "���ԒE��"
      case $msg.talk_step
      when 2 #���Ԃ̒E�߂��󂯓��ꂽ�ꍇ
        m = "#{master}��#{speaker}�̌����ʂ�ɁA\m\n#{servant}�̕���E�������I"
      when 77 #���Ԃ̒E�߂����ۂ����ꍇ
        m = "#{master}�͗v����f�����I"
      end
    #==============================================================================
    # �������E��
    #==============================================================================
    when "�����E��"
      case $msg.talk_step
      when 2 #�E�߂����������ꍇ
        m = "#{master}�͌����ʂ�ɁA\m\n#{speaker}�̒E���l�q�����������I"
        m = "#{master}�͎v�킸�A\m\n#{speaker}�̒E���l�q���������Ă��܂����I" if $data_SDB[$msg.t_enemy.class_id].name == "�L���X�g"
        m = "#{master}�͐H������悤�ɁA\m\n#{speaker}�̒E���l�q�����������I" if $game_actors[101].state?(35)
      when 77 #�E�߂����Ȃ������ꍇ
        m = "#{master}�͎v���Ƃǂ܂�A\m\n#{speaker}����ڂ���炵���I"
      end
    #==============================================================================
    # ���z���E��
    #==============================================================================
    when "�z���E��"
      case $msg.talk_step
      when 2 #�z�����󂯓��ꂽ�ꍇ
        m = "#{master}��#{speaker}�ɐO��D��ꂽ�I\m\n#{master}�̐g�̂���͂������Ă����c�c�I"
      when 77 #�z�������ۂ����ꍇ
        m = "#{master}�͗v����f�����I"
      end
    #==============================================================================
    # ���z���E����
    #==============================================================================
    when "�z���E����"
      case $msg.talk_step
      when 2 #�z�����󂯓��ꂽ�ꍇ
        m = "#{speaker}�́A\m\n#{master}�̃y�j�X�ɂ���Ԃ�����I\m\n�����Ƌ��ɁA#{master}�̐g�̂���͂�������c�c�I"
      when 77 #�z�������ۂ����ꍇ
        m = "#{master}�͗v����f�����I"
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
        m = "#{master}�͗U�f�ɕ������A\m\n#{speaker}����ڂ���炵���I"
      when 78 #������r���Œf�����ꍇ
        m = "#{master}�͉��Ƃ��ӎv��U��i��A\m\n#{speaker}����ڂ���炵���I"
      when 79 #�����������Ė\�������ꍇ
        m = "#{master}�͖ڂ̑O�ŌJ��L������A\m\n#{speaker}�̒s�Ԃ���ڂ���炷���Ƃ��ł��Ȃ��I"
      #�p�����Ă���ꍇ
      else
        m = "#{speaker}�́A\m\n����̐g�̂��Ԃ߂Ă���c�c�I"
        emotion = ""
        case $msg.t_enemy.personality
        when "�Ӓn��","����","�|��"
          emotion = "�v�킹�Ԃ�ȕ\���"
          emotion = "#{master}�̊ԋ߂�" if rand($mood.point) > 50
        when "�D�F","����","�z�C","�_�a","�����C"
          emotion = "������鎋�����y���ނ悤��"
          emotion = "#{master}�Ɍ�����悤��" if rand($mood.point) > 50
        when "�W��","�]��","�Â���","�s�v�c"
          emotion = "�s�ׂɖv�����邩�̂悤��"
          emotion = "#{master}�̎�����������" if rand($mood.point) > 50
        when "���C","��i","�V�R"
          emotion = "�p���������Ɋ��w����"
          emotion = "����g��������" if rand($mood.point) > 50
        end
        #�e�L�X�g���`(���A�K�n�͌��݂͕���̂��߁A�����ʂɊ���U��)
        case $msg.at_parts
        #�������Ŏ���
        when "�ΏہF��","�ΏہF��"
          if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            m = "#{speaker}��#{emotion}�A\m\n������#{$msg.t_enemy.bustsize}����ŕ��ŉ񂵂Ă���I"
            m = "#{speaker}��#{emotion}�A\m\n�����̓�����w�ł��ˉ񂵂Ă���I" if rand($mood.point) > 50
          else
            m = "#{speaker}��#{emotion}�A\m\n������#{$msg.t_enemy.bustsize}�𝆂݂������Ă���I"
            m = "#{speaker}��#{emotion}�A\m\n�����̓�����w�ł��ˉ񂵂Ă���I" if rand($mood.point) > 50
          end
        #�A�\�R�Ɏw����Ŏ���
        when "�ΏہF�A�\�R","�ΏہF�K"
          m = "#{speaker}��#{emotion}�A\m\n�A�\�R�Ɏw�𔲂��}�����Ă���I"
          m = "#{speaker}��#{emotion}�A\m\n�w�ŃA�\�R�������񂵂Ă���I" if rand($mood.point) > 50
        #�A�j��M���Ď���
        when "�ΏہF�A�j","�ΏہF�A�i��"
          m = "#{speaker}��#{emotion}�A\m\n�����̉A�j���w�ňԂ߂Ă���I"
          m = "#{speaker}��#{emotion}�A\m\n�w�ŉA�j���C��グ�Ă���I" if rand($mood.point) > 50
        end
      end
    #==============================================================================
    # ����d
    #==============================================================================
    when "��d"
      case $msg.talk_step
      when 77 #�������ŏ����猩�Ȃ������ꍇ
        m = "#{master}�͗U�f�ɕ������A\m\n#{speaker}�̗v����f�����I"
        m = "#{master}�͌�딯���������v���ŁA\m\n���Ƃ�#{speaker}�̗v����f�����I" if $game_actors[101].state?(35)
      when 78 #������r���Œf�����ꍇ
        m = "#{master}�͉��Ƃ��ӎv��U��i��A\m\n#{speaker}�ւ̕�d�̎���~�߂��I"
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
          m = "#{master}��#{action}�A\m\n#{speaker}�ƌ����Ő�𗍂߂������I"
        #�������ɕ�d
        when "�ΏہF��"
          if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
            m = "#{master}��#{action}�A\m\n#{speaker}��#{$msg.t_enemy.bustsize}�𝆂݂��������I"
            m = "#{master}��#{action}�A\m\n#{speaker}��#{$msg.t_enemy.bustsize}�����r�߉񂵂��I" if $game_variables[17] > 50 
          else
            m = "#{master}��#{action}�A\m\n#{speaker}��#{$msg.t_enemy.bustsize}����ŕ��ŉ񂵂��I"
            m = "#{master}��#{action}�A\m\n#{speaker}��#{$msg.t_enemy.bustsize}�����r�߉񂵂��I" if $game_variables[17] > 50 
          end
        #�A�\�R�ɕ�d
        when "�ΏہF�A�\�R","�ΏہF�A�i��"
          m = "#{master}��#{action}�A\m\n#{speaker}�̃A�\�R�Ɏw�𔲂��}�������I"
          m = "#{master}��#{action}�A\m\n#{speaker}�̃A�\�R�ɐ���o�����ꂵ���I" if $game_variables[17] > 50 
        #�A�j�ɕ�d
        when "�ΏہF�A�j"
          m = "#{master}��#{action}�A\m\n#{speaker}�̉A�j���w�ň��������I"
          m = "#{master}��#{action}�A\m\n#{speaker}�̉A�j�����r�ߏグ���I" if $game_variables[17] > 50 
        #���K�ɕ�d
        when "�ΏہF�K"
          m = "#{master}��#{action}�A\m\n#{speaker}�̂��K�𗼎�ň��������I"
          m = "#{master}��#{action}�A\m\n#{speaker}�̂��K�����r�߉񂵂��I" if $game_variables[17] > 50 
        #�A�i���ɕ�d
#        when "�ΏہF�A�i��"
#          m = "#{master}��#{action}�A\m\n#{speaker}�̋e�����w�ň��������I"
#          m = "#{master}��#{action}�A\m\n#{speaker}�̋e�������r�߉񂵂��I" if $game_variables[17] > 50 
        end
      end
    #==============================================================================
    # �������E����
    #==============================================================================
    when "�����E����"
      case $msg.talk_step
      when 77 #�������ŏ�����f�����ꍇ
        m = "#{master}�͗U�f�ɕ������A\m\n#{speaker}�̐\���o��f�����I"
        m = "#{master}�͌�딯���������v���ŁA\m\n���Ƃ�#{speaker}�̗v����f�����I" if $game_actors[101].state?(35)
      when 78 #������r���Œf�����ꍇ
        m = "#{master}�͉��Ƃ��ӎv��U��i��A\m\n#{speaker}�̍s�ׂ��������߂��I"
      #���������󂯓��ꂽ�ꍇ
      else
        case $msg.at_parts
        #���C���T�[�g�E�A�N�Z�v�g
        #--------------------------------------------------------------------------
        when "���}���F�A�\�R��","�K�}���F�K��"
          if $game_variables[17] > 70
            if $game_actors[101].critical == true
              action = ["��������","�������","�������"]
              action = action[rand(action.size)]
              move = ["���ߕt����","���ߏグ��","�i��グ��"]
              move = move[rand(move.size)]
            else
              action = ""
              move = "���ߕt����"
            end
            hole = "�A�\�R"
            hole = "�e��" if $msg.at_parts == "�K�}���F�K��"
            m = "#{speaker}��#{hole}���A\m\n#{master}�̃y�j�X��#{action}#{move}�I" 
          else
            if $game_actors[101].critical == true
              if $msg.t_enemy.initiative_level > 0
                #��
                action = "������������"
                #��
                waist = ["��_��","�傫��","������"]
                waist.push("���˂�悤��","��������","�ɋ}������") if $msg.t_enemy.positive?
                waist.push("�ꏊ������","��S�s����","�������\���") if $msg.t_enemy.negative?
              else
                #��
                action = "�ɐg�̂�a��"
                #��
                waist = ["�傫��"]
                waist.push("��������") if $msg.t_enemy.positive?
                waist.push("�ꏊ������") if $msg.t_enemy.negative?
              end
              waist = waist[rand(waist.size)]
            else
              if $msg.t_enemy.initiative_level > 0
                #��
                action = "�����߂Ȃ���"
                #��
                waist = ["��������","�O���","�񂷂悤��"]
                waist.push("�ł炷�悤��","��������") if $msg.t_enemy.positive?
                waist.push("�T���߂�","�p�炢��") if $msg.t_enemy.negative?
              else
                #��
                action = "�ɓ��������킹"
                #��
                waist = ["��������"]
                waist.push("�ł炷�悤��") if $msg.t_enemy.positive?
                waist.push("�T���߂�") if $msg.t_enemy.negative?
              end
              waist = waist[rand(waist.size)]
            end
            m = "#{speaker}��#{master}#{action}�A\m\n#{waist}����U���Ă����I"
          end
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
          m = "#{speaker}��#{master}�̃y�j�X���A\m\n#{mouth}#{action}�I"
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
          m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X��#{bust}#{action}�I"
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
              action.push("�̍���O�ɉ����o�����I\m\n#{hold_target}�Ƃ̌����������[���Ȃ����I")
            #�y�j�X���p�C�Y�����̏ꍇ
            elsif $game_actors[101].penis_paizuri?
              action.push("�̍������������񂾁I\m\n#{hold_target}�̓������X�Ɍ������Ȃ����I")
            end
          else
            action.push("�̂킫�̉������r�߂Ă����I")
            action.push("�̎�؂ɂӂ����Ƒ��𐁂��������I")
            action.push("�̋��Ɏw�𔇂킹�Ă����I")
            action.push("�̍������킳��ƕ��łĂ����I")
            action.push("�̑����������킳��ƕ��łĂ����I")
          end
          action = action[rand(action.size)]
          m = "#{speaker}�͖��������܂܁A\m\n#{master}#{action}"
        end
      #--------------------------------------------------------------------------
      end
    #==============================================================================
    # �������E�ʏ�
    #==============================================================================
    when "�����E�ʏ�"
      case $msg.talk_step
      when 77 #�������ŏ�����f�����ꍇ
        m = "#{master}�͗U�f�ɕ������A\m\n#{speaker}�̐\���o��f�����I"
        m = "#{master}�͌�딯���������v���ŁA\m\n���Ƃ�#{speaker}�̗v����f�����I" if $game_actors[101].state?(35)
      when 78 #������r���Œf�����ꍇ
        m = "#{master}�͉��Ƃ��ӎv��U��i��A\m\n#{speaker}�̍s�ׂ��������߂��I"
      #���������󂯓��ꂽ�ꍇ
      else
        m = "#{speaker}�͔��΂ނƁA\m\n#{master}�̃y�j�X���������Ă����I"
        case $msg.at_type
        #--------------------------------------------------------------------------
        when "��"
          #����_��˂���
          if $game_actors[101].critical == true
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͔������y���ނ��̂悤�ɁA\m\n#{master}�̃y�j�X�����������w�ŘM�ԁI"
                m = "#{speaker}�͈������ނ��̂悤�ɁA\m\n#{master}�̃y�j�X�����������w�ŘM�ԁI" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}�͐S�����w�J���ŁA\m\n#{master}�̃y�j�X���Ԓf�Ȃ��U�ߗ��ĂĂ����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͊Ԓf�Ȃ��A\m\n#{master}�̃y�j�X�̕q���ȕ������U�߂Ă����I"
              else
                m = "#{speaker}�͎w�𗍂߂āA\m\n#{master}�̃y�j�X�̕q���ȕ������U�߂Ă����I"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͊Ԓf�Ȃ��A\m\n#{master}�̃y�j�X���w�ōU�ߗ��Ă�I"
              else
                m = "#{speaker}�͎w�𗍂߂āA\m\n#{master}�̃y�j�X���������グ�Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�́A\m\n#{master}�̃y�j�X�Ɏw�𗍂߈������Ă����I"
              else
                m = "#{speaker}�͎�ŁA\m\n#{master}�̃y�j�X���������Ă����I"
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
                m = "#{speaker}�͔������y���ނ��̂悤�ɁA\m\n#{master}�̃y�j�X�����������r�ߏグ�Ă����I"
                m = "#{speaker}�͈������ނ��̂悤�ɁA\m\n#{master}�̃y�j�X�����������r�ߏグ�Ă����I" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}�͐S������g���ŁA\m\n#{master}�̃y�j�X���Ԓf�Ȃ��r�߉񂵂Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͊Ԓf�Ȃ��A\m\n#{master}�̃y�j�X�̕q���ȕ������r�ߑ������I"
              else
                m = "#{speaker}�͐��ŁA\m\n#{master}�̃y�j�X�̕q���ȕ������r�ߏグ���I"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͊Ԓf�Ȃ��A\m\n#{master}�̃y�j�X��O�O���r�ߏグ�Ă����I"
              else
                m = "#{speaker}�͐��ŁA\m\n#{master}�̃y�j�X���ł炷�悤���r�ߏグ���I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͋x�ނ��ƂȂ��A\m\n#{master}�̃y�j�X��O�O���r�ߏグ�Ă����I"
              else
                m = "#{speaker}�͐�ŁA\m\n#{master}�̃y�j�X���r�ߏグ�Ă����I"
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
                m = "#{speaker}�͔������y���ނ��̂悤�ɁA\m\n#{master}�̃y�j�X�𗼑��̗��ł������Ă����I"
                m = "#{speaker}�͈������ނ��̂悤�ɁA\m\n#{master}�̃y�j�X�𗼑��̗��ł������Ă����I" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}�͐S���Ă���ƌ����΂���ɁA\m\n#{master}�̃y�j�X�𑫗��ŝs�ˉ񂵂Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͋x�ނ��ƂȂ��A\m\n#{master}�̃y�j�X�𑫗��ŝs�ˉ񂵂Ă����I"
              else
                m = "#{speaker}�͑��̗��ŁA\m\n#{master}�̃y�j�X�̕q���ȕ������������Ă����I"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͊ɋ}�����Ȃ���A\m\n#{master}�̃y�j�X�𑫂̎w�ōX�ɘM�ԁI"
              else
                m = "#{speaker}�͑��̎w�ŁA\m\n#{master}�̃y�j�X���ł炷�悤�ɘM��ł����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͊ɋ}�����Ȃ���A\m\n#{master}�̃y�j�X�𑫗��ł������Ă����I"
              else
                m = "#{speaker}�͑��̗��ŁA\m\n#{master}�̃y�j�X���y�����݂����I"
              end
            end
          end
        #--------------------------------------------------------------------------
        when "��"
          if $msg.chain_attack == true
            m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X���Ԓf�Ȃ��������Ă����I"
            m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\m\n#{master}�̃y�j�X�ɎC��t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
          else
            m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X�����݂������Ă����I"
            m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\m\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
          end
          #����_��˂���
          if $game_actors[101].critical == true
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
                  m = "#{speaker}�͔������y���ނ��̂悤�ɁA\m\n#{$msg.t_enemy.bustsize}���y�j�X�ɎC��t���Ă����I"
                  m = "#{speaker}�͈������ނ��̂悤�ɁA\m\n#{$msg.t_enemy.bustsize}���y�j�X�ɎC��t���Ă����I" if $msg.t_enemy.love > 0
                else
                  m = "#{speaker}�͔������y���ނ��̂悤�ɁA\m\n#{$msg.t_enemy.bustsize}�Ńy�j�X�����������������Ă����I"
                  m = "#{speaker}�͈������ނ��̂悤�ɁA\m\n#{$msg.t_enemy.bustsize}�Ńy�j�X�����������������Ă����I" if $msg.t_enemy.love > 0
                end
              else
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X�����݂������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\m\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X���Ԓf�Ȃ��������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\m\n#{master}�̃y�j�X�ɎC��t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              else
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X�����݂������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\m\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X���Ԓf�Ȃ��������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\m\n#{master}�̃y�j�X�ɎC��t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              else
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X�����݂������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\m\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X���Ԓf�Ȃ��������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\m\n#{master}�̃y�j�X�ɎC��t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
              else
                m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X�����݂������Ă����I"
                m = "#{speaker}��#{$msg.t_enemy.bustsize}���A\m\n#{master}�̃y�j�X�ɉ����t���Ă����I" if $data_SDB[$msg.t_enemy.class_id].bust_size < 3
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
                m = "#{speaker}�͔������y���ނ��̂悤�ɁA\m\n#{master}�̃y�j�X�̏�ō���U���Ă����I"
                m = "#{speaker}�͈������ނ��̂悤�ɁA\m\n#{master}�̃y�j�X�̏�ō���U���Ă����I" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}�͐S�������g���ŁA\m\n#{master}�̃y�j�X�ɃA�\�R���C��t���Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͍���O��ɂ��˂点�A\m\n#{master}�̃y�j�X���A�\�R�ŎC��グ�Ă����I"
              else
                m = "#{speaker}�͎����̃A�\�R���A\m\n#{master}�̃y�j�X�Ɍ������C��t���Ă����I"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�͊ɋ}�����Ȃ���A\m\n#{master}�̃y�j�X�̏�ō���U���Ă����I"
              else
                m = "#{speaker}�͎����̃A�\�R���A\m\n#{master}�̃y�j�X�ɎC��t���Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͊ɋ}�����Ȃ���A\m\n#{master}�̃y�j�X�̏�ō���U���Ă����I"
              else
                m = "#{speaker}�͎����̃A�\�R���A\m\n#{master}�̃y�j�X�ɎC��t���Ă����I"
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
                m = "#{speaker}�͔������y���ނ��̂悤�ɁA\m\n#{master}�̃y�j�X��K���ł������Ă����I"
                m = "#{speaker}�͈������ނ��̂悤�ɁA\m\n#{master}�̃y�j�X��K���ł������Ă����I" if $msg.t_enemy.love > 0
              else
                m = "#{speaker}�͊��ꂽ���g���ŁA\m\n#{master}�̃y�j�X��K���ŘM��ł����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�͐K�������˂点�A\m\n#{master}�̃y�j�X���Ԓf�Ȃ��������グ�Ă����I"
              else
                m = "#{speaker}�͐K�����I�݂Ɏg���A\m\n#{master}�̃y�j�X���������グ�Ă����I"
              end
            end
          else
            case @weakpoints
            when 20,10
              if $msg.chain_attack == true
                m = "#{speaker}�̓��Y�~�J���ɁA\m\n�K����#{master}�̃y�j�X���������グ�Ă����I"
              else
                m = "#{speaker}�͎����̐K�����A\m\n#{master}�̃y�j�X�Ɋ����t���Ă����I"
              end
            else
              if $msg.chain_attack == true
                m = "#{speaker}�̓��Y�~�J���ɁA\m\n�K����#{master}�̃y�j�X���������グ�Ă����I"
              else
                m = "#{speaker}�͎����̐K�����A\m\n#{master}�̃y�j�X�Ɋ����t���Ă����I"
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
          m = "#{speaker}��#{master}�̃y�j�X���A\m\n#{mouth}#{action}�I"
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
          m = "#{speaker}��#{$msg.t_enemy.bustsize}�ŁA\m\n#{master}�̃y�j�X��#{bust}#{action}�I"
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
              action.push("�̍���O�ɉ����o�����I\m\n#{hold_target}�Ƃ̌����������[���Ȃ����I")
            #�y�j�X���p�C�Y�����̏ꍇ
            elsif $game_actors[101].penis_paizuri?
              action.push("�̍������������񂾁I\m\n#{hold_target}�̓������X�Ɍ������Ȃ����I")
            end
          else
            action.push("�̂킫�̉������r�߂Ă����I")
            action.push("�̎�؂ɂӂ����Ƒ��𐁂��������I")
            action.push("�̋��Ɏw�𔇂킹�Ă����I")
            action.push("�̍������킳��ƕ��łĂ����I")
            action.push("�̑����������킳��ƕ��łĂ����I")
          end
          action = action[rand(action.size)]
          m = "#{speaker}�͖��������܂܁A\m\n#{master}#{action}"
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
          m = "#{master}�͗U����܂܁A\m\n#{speaker}�̃A�\�R�Ƀy�j�X��˂����ꂽ�I"
        when 77 #�}������
          m = "#{master}�͋����ӎu�Ŏv�����܂����I"
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
      m = "#{speaker}��#{master}�̋����ɁA\m\n�Ӗ����肰�Ȏ����������Ă����c�c�I"
      m = "#{speaker}��#{master}�̋������A\m\n���������Ȃ��l�q�ł��炿��Ǝf���Ă���I" if $msg.t_enemy.negative?
    #==============================================================================
    # �����ԒE��
    #==============================================================================
    when "���ԒE��"
      m = "#{speaker}�͊܂݂̂���\��ŁA\m\n#{servant}�����߂Ă���c�c�I"
      m = "#{speaker}�͈Ӗ����肰�ȕ\��ŁA\m\n#{servant}�����߂Ă���c�c�I" if $msg.t_enemy.negative?
    #==============================================================================
    # �������E��
    #==============================================================================
    when "�����E��"
      m = "#{speaker}�͕��̍��킹�ڂ��͂����A\m\n#{master}�ɉ����ۂ��\����������I"
      m = "#{speaker}�͕��̍��킹�ڂ��͂����A\m\n#{master}�ɈӖ����肰�ȕ\����������I" if $msg.t_enemy.negative?
      m = "#{speaker}�̐g�̂𕢂��S�t���A\m\n#{master}�̎����̐�ŗh��Ă���c�c�I" if $msg.t_enemy.tribe_slime?
    #==============================================================================
    # ���z���E��
    #==============================================================================
    when "�z���E��"
      m = "#{speaker}�͖ڂ���āA\m\n#{master}�̐O�Ɋ���߂Â��Ă����c�c�I"
      m = "#{speaker}�͏΂݂𕂂��ׁA\m\n#{master}�̐O�Ɋ���߂Â��Ă����c�c�I" if $msg.t_enemy.positive?
    #==============================================================================
    # ���z���E����
    #==============================================================================
    when "�z���E����"
      m = "#{speaker}�͖ڂ���āA\m\n#{master}�̃y�j�X�Ɋ���߂Â��Ă����c�c�I"
      m = "#{speaker}�͏΂݂𕂂��ׁA\m\n#{master}�̃y�j�X�Ɋ���߂Â��Ă����c�c�I" if $msg.t_enemy.positive?
    #==============================================================================
    # ������
    #==============================================================================
    when "����"
      emotion = ""
      case $msg.t_enemy.personality
      when "�D�F","����"
        emotion = "�d���ȏ΂݂𕂂���"
      when "�z�C","�_�a","�����C"
        emotion = "���Y���ۂ��΂݂𕂂���"
      when "����","�Â���"
        emotion = "���炿��Ƃ�������f���Ȃ���"
      when "���C"
        emotion = "�p���������Ɋ�𕚂���"
      when "�Ӓn��"
        emotion = "�ɂ��ƒ����I�Ɍ�����c��"
      when "�s�v�c","��i","�|��"
        emotion = "�Ӗ����肰�ȏ΂݂𕂂���"
      when "�W��","�]��"
        emotion = "�킸���Ɋ���g��������"
      when "�V�R"
        emotion = "�Ƃ��Ƃ����\���"
      else
        emotion = "�����t���邩�̂悤��"
      end
      #�e�L�X�g���`(���A�K�n�͌��݂͕���̂��߁A�����ʂɊ���U��)
      case $msg.at_parts
      #�������Ŏ���
      when "�ΏہF��","�ΏہF��"
        m = "#{speaker}��#{emotion}�A\m\n������#{$msg.t_enemy.bustsize}�Ɏw�𔇂킹���I"
      #�A�\�R�Ɏw����Ŏ���
      when "�ΏہF�A�\�R","�ΏہF�K"
        m = "#{speaker}��#{emotion}�A\m\n�����̃A�\�R�Ɏw�𔇂킹���I"
      #�A�j��M���Ď���
      when "�ΏہF�A�j","�ΏہF�A�i��"
        m = "#{speaker}��#{emotion}�A\m\n�����̉A�j�Ɏw�𔇂킹���I"
      end
    #==============================================================================
    # ����d
    #==============================================================================
    when "��d"
      #�e�L�X�g���`
      case $msg.at_parts
      #�L�b�X�ŕ�d
      when "�ΏہF��"
        m = "#{speaker}�͖ڂ���A\m\n#{master}�ɐO�������Ă����I"
      #�������ɕ�d
      when "�ΏہF��"
        m = "#{speaker}��#{master}�̘r�ɕ������A\m\n������#{$msg.t_enemy.bustsize}���C��t���Ă����I"
      #�A�\�R�ɕ�d
      when "�ΏہF�A�\�R","�ΏہF�A�i��"
        m = "#{speaker}��#{master}�̖ڂ̑O�ŁA\m\n�w�Ŏ���A�\�R���J���Č����Ă����I"
        m = "#{speaker}�͒p�炢���A\m\n�w�Ŏ���A�\�R���J���Č����Ă����I" if $msg.t_enemy.negative?
      #�A�j�ɕ�d
      when "�ΏہF�A�j"
        m = "#{speaker}��#{master}�̖ڂ̑O�ŁA\m\n�w�Ŏ���A�\�R���J���Č����Ă����I"
        m = "#{speaker}�͒p�炢���A\m\n�w�Ŏ���A�\�R���J���Č����Ă����I" if $msg.t_enemy.negative?
      #���K�ɕ�d
      when "�ΏہF�K"
        m = "#{speaker}��#{master}�̖ڂ̑O�ŁA\m\n�������ɂȂ��Ă��K��U���Ă����I"
        m = "#{speaker}�͒p�炢���A\m\n�������ɂȂ��Ă��K�������Ă����I" if $msg.t_enemy.negative?
      #�A�i���ɕ�d
#      when "�ΏہF�A�i��"
#        m = "#{master}��#{action}�A\m\n#{speaker}�̋e�����w�ň��������I"
#        m = "#{master}��#{action}�A\m\n#{speaker}�̋e���ɐ�𔇂킹���I" if $game_variables[17] > 50 
      end
    #==============================================================================
    # �������E�ʏ�
    #==============================================================================
    when "�����E�ʏ�"
      emotion = ""
      case $msg.t_enemy.personality
      when "�����C","����","�Ӓn��"
        emotion = "��Ȃ߂��������"
      when "��i","�_�a"
        emotion = "�_�炩���΂݂𕂂���"
      when "�W��","����"
        emotion = "���炿��Ɖ��ڂ�"
      when "���C","�]��","�|��"
        emotion = "�M���ۂ�����"
      when "�s�v�c","�V�R"
        emotion = "���S�����\���"
      when "�z�C","�Â���"
        emotion = "���Y���ۂ��΂݂𕂂���"
      else #�D�F
        emotion = "�d���ȏ΂݂𕂂���"
      end
      m = "#{speaker}��#{emotion}�A\m\n#{master}�̃y�j�X�����߂Ă���I"
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
        m = "#{speaker}��#{emotion}�A\m\n#{master}#{action}�I"
      end
    #==============================================================================
    # �������E����
    #==============================================================================
    when "�����E����"
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
      m = "#{speaker}��#{emotion}�A\m\n#{master}#{action}�I"
    #==============================================================================
    # ������
    #==============================================================================
    when "����"
      case $msg.t_enemy.personality
      when "�D�F"
        m = "#{speaker}�͏ł炷�悤�Ɍ҂��L���A\m\n�d���ȏ΂݂𕂂���#{master}���菵�������I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n����ŃA�\�R���L���ėU�f���Ă����I" if $game_variables[17] > 50 #��
      when "��i"
        m = "#{speaker}�͗U�f���邩�̂悤�ɁA\m\n�r���J����#{master}�Ɏ菵���������I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n�Y�܂����ȓ���#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "����"
        m = "#{speaker}�͏ł炷�悤�Ɍ҂��L���A\m\n��������悤��#{master}�����߂Ă����I" #�O
        m = "#{speaker}�͂��K��˂��o���A\m\n�s�G�ȏ΂݂�#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "�W��"
        m = "#{speaker}�͂��p�炢���A\m\n#{master}�Ɍ�����悤�ɋr���L���Ă����I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n�l�q���f�����̂悤��#{master}�����Ă���I" if $game_variables[17] > 50 #��
      when "�_�a"
        m = "#{speaker}�͗U�f���邩�̂悤�ɁA\m\n�r���J����#{master}�Ɏ菵���������I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n����ŃA�\�R���L���ėU�f���Ă����I" if $game_variables[17] > 50 #��
      when "�����C"
        m = "#{speaker}�͑�_�Ɍ҂��L���A\m\n��������悤��#{master}�����߂Ă����I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n�s�G�ȏ΂݂�#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "���C"
        m = "#{speaker}�͎�Ŋ�𕢂��A\m\n#{master}�Ɍ�����悤�Ɍ҂��L���Ă����I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n#{master}�ɂ��K��p���������Ɍ����Ă����I" if $game_variables[17] > 50 #��
      when "�z�C"
        m = "#{speaker}�͑�_�Ɍ҂��L���A\m\n���҂����߂�����#{master}�����߂Ă����I" #�O
        m = "#{speaker}�͂��K��˂��o���A\m\n���҂����߂�����#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "�Ӓn��"
        m = "#{speaker}�͗U�f���邩�̂悤�ɁA\m\n�r���J����#{master}�Ɏ菵���������I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n����ŃA�\�R���L���ėU�f���Ă����I" if $game_variables[17] > 50 #��
      when "�V�R"
        m = "#{speaker}�͊��҂����߂��፷���ŁA\m\n�҂��L����#{master}�����߂Ă����I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n���񂾓���#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "�]��"
        m = "#{speaker}�͑�_�Ɍ҂��L���A\m\n��ڌ�����#{master}�����߂Ă����I" #�O
        m = "#{speaker}�͂��K��˂��o���A\m\n���񂾓���#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "����"
        m = "#{speaker}�͈ӂ��������悤�Ɍ҂��L���A\m\n��������悤��#{master}�����߂Ă����I" #�O
        m = "#{speaker}�͂��K��˂��o���A\m\n���ނ悤�ȕ\���#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "�|��"
        m = "#{speaker}�͏ł炷�悤�Ɍ҂��L���A\m\n�d���ȏ΂݂𕂂���#{master}���菵�������I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n���񂾓���#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "�Â���"
        m = "#{speaker}�͊��҂����߂��፷���ŁA\m\n�҂��L����#{master}�����߂Ă����I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�A\m\n���񂾓���#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "�s�v�c"
        m = "#{speaker}�͋r���������ƍL���A\m\n���𕂂�����#{master}�����߂Ă����I" #�O
        m = "#{speaker}�͐K���Ԃ𗼎�ōL���A\m\n#{master}�����߂Ă����I" if $game_variables[17] > 50 #��
      when "�ƑP"
        m = "#{speaker}�͌����t����悤�ɋr���L���A\m\n�d���ȏ΂݂�#{master}�����߂Ă����I" #�O
        m = "#{speaker}�͎l�񔇂��ɂȂ�ƁA\m\n���K�������グ��#{master}�𒧔������I" if $game_variables[17] > 50 #��
      end
    end
   #============================================================================
    return if m == ""
    $game_temp.battle_log_text += m
  end
###############################################################################  
end