#==============================================================================
# �� Talk_Sys(������` 2)
#------------------------------------------------------------------------------
#   �����̌���������A�\�����邽�߂̃N���X�ł��B
#   ���̃N���X�̃C���X�^���X�� $msg �ŎQ�Ƃ���܂��B
#   �����ł͉�b���s���L�����N�^�[�̑I��A�X�L���w�g�[�N�x�̐�����s���܂��B
#==============================================================================
class Talk_Sys
  #============================================================================
  # ���R�}���h�I�������v���p�^�[�����������Ă����ɍs�����[���b�g
  #============================================================================
  def talk_choice
    $msg.tag = $msg.at_type = $msg.at_parts = ""
    @talk_command_type = ""
    #�z�[���h����b�t���O���N���A
    holding_talk = false
    #�G���u���C�X����̎b�菈��
    # if #$msg.t_enemy.bind? or $msg.t_enemy.riding? 
    # �C���T�[�g�ȊO�̃z�[���h���󂯂Ă��鑊��͕s�����ɂȂ�
    if $msg.t_enemy.can_struggle? or $msg.t_enemy.shellmatch? 
      $msg.tag = "�s����"
      $msg.at_type = "����������"
      return
    end
    #�x�b�h�C���ȊO�ŁA��b�t���O����萔�ȏ�̏ꍇ�ł��؂���(�������z�[���h���͏���)
    if $game_switches[85] == false and $msg.t_enemy.pillowtalk > 4
      #��l������b�Ώۂƃz�[���h���̏ꍇ�͌p��
      if $game_actors[101].holding_now?
        holding_talk = true
      #�z�[���h���łȂ���Ή�b�s��
      else
        $msg.tag = "�s����"
        $msg.at_type = "���s�ߑ�"
        return
      end
    #��l�����N���C�V�X�̏ꍇ
    elsif $game_actors[101].crisis?
      #��l������b�Ώۂƃz�[���h���̏ꍇ�͌p��
      if $game_actors[101].holding_now?
        holding_talk = true
      #�z�[���h���łȂ���Ή�b�s��
      else
#        unless $msg.t_enemy.friendly > 70
          $msg.tag = "�s����"
          $msg.at_type = "��l���N���C�V�X"
          return
#        else
          #�������͗��ҒE�ߏ�ԁA�����Ҕ�z�[���h�łȂ��Ɣ������Ȃ�
#          if $game_actors[101].insertable_half_nude? or $game_actors[101].full_nude?
#            if not $game_actors[101].holding? and not $msg.t_enemy.holding? #�z�[���h���͑I�������珜�O
#              $msg.tag = "����" if ($msg.t_enemy.friendly > 70 or $game_switches[85] == true)
#              b = []
#              b.push("���}��") if $msg.t_enemy.insertable_half_nude? or $msg.t_enemy.full_nude?
#              if b == []
#                $msg.tag = "�s����"
#                $msg.at_type = "��l���N���C�V�X"
#                return
#              end
#              $msg.at_parts = b[rand(b.size)]
#              @talk_command_type = "���ۃ^�C�v"
#              return
#            end
#          end
#        end
      end
    #��b�Ώۂ��N���C�V�X�̏ꍇ
    elsif $msg.t_enemy.crisis?
      #��l������b�Ώۂƃz�[���h���̏ꍇ�͌p��
      if $game_actors[101].holding_now?
        holding_talk = true
      #�z�[���h���łȂ���Ή�b�s��
      else
        $msg.tag = "�s����"
        $msg.at_type = "�����N���C�V�X"
        return
      end
    #��b�Ώۂ��Ⓒ���̏ꍇ
    elsif $msg.t_enemy.weaken?
      $msg.tag = "�s����"
      $msg.at_type = "�����Ⓒ��"
      return
    #��b�Ώۂ��������(34)�̏ꍇ
    elsif $msg.t_enemy.states.include?(34)
      $msg.tag = "�s����"
      $msg.at_type = "����������"
      return
    #��b�Ώۂ��\�����(36)�̏ꍇ�i�{�C��Ԃ̍ۂ�����ɂȂ�j
    elsif $msg.t_enemy.states.include?(36) or $msg.t_enemy.earnest == true
      $msg.tag = "�s����"
      $msg.at_type = "�����\����"
      return
    #��L������ł��Ȃ���ԂŎ�l�����z�[���h�A����b�Ώۂƃz�[���h���̏ꍇ
    elsif $game_actors[101].holding_now?
      holding_talk = true
    end
    #����������g�[�N�������̐��䕔��
    #["����","��l���E��","���ԒE��","�����E��","��d","����","�z��","����","�_��"]
    #�O����Ăяo��
    #���[�h���Q�O�ȉ��̏ꍇ�̓R�����C�x���g�Ńg�[�N�I���������s��
    if $msg.talk_step == 0
      $msg.tag = "�O����"
    #�X�e�b�v�P�ȏ�Ȃ�ʏ폈��
    else
      #�z�[���h��b�t���O�������Ă���ꍇ�͐�p�^�O�ɂ���
      if holding_talk == true and not bitter_talk?($msg.t_enemy)
        $msg.tag = "�����E����"
        $msg.at_type = "�z�[���h�U��"
        #�ςӂςӁA��ʋR��A�L�b�X�̓g�[�N���̂��̂��������邽�ߏ��O
        #�U����i��ݒ�(�����z�[���h����������ꍇ�͑���Ƃ̕��݂̂�I��)
        #���C���T�[�gor�A�N�Z�v�g(���}�����)
        if $game_actors[101].inserting_now?
          $msg.at_parts = "���}���F�A�\�R��"
        #���I�[�����C���T�[�gor�I�[�����A�N�Z�v�g(���}�����)
        elsif $game_actors[101].oralsex_now?
          $msg.tag = "�����E�ʏ�"
          $msg.at_parts = "���}���F����"
        #���o�b�N�C���T�[�gor�o�b�N�A�N�Z�v�g(�K�}�����)
        elsif $game_actors[101].analsex_now?
          $msg.tag = "�����E�ʏ�"
          $msg.at_parts = "�K�}���F�K��"
        #���G���u���C�X(�������)
        elsif $msg.t_enemy.binding_now?
          $msg.tag = "�����E�ʏ�"
          $msg.at_parts = "�w�ʍS��"
        #���y���X�R�[�v(�p�C�Y�����)
        elsif $msg.t_enemy.paizuri_now?
          $msg.tag = "�����E�ʏ�"
          $msg.at_parts = "�p�C�Y��"
        else
          $msg.tag = "�����E�ʏ�"
        end
        @talk_command_type = "�p���^�C�v"
        return
      end
      return if $mood.point < 20 #���[�h�Q�O�ȉ��Ȃ炱���܂�
      a = []
      #����l�����z�[���h��Ԃ��Ɣ������Ȃ����̑���
      unless $game_actors[101].holding?
        #����l���E�߂͊��Ɏ�l�����E���ł���Ɣ������Ȃ�
        a.push("��l���E��") unless $game_actors[101].full_nude?
        # �������[�h��
        if $mood.point >= 40
          #����d�͑��肪�E�ߎ��̂݁A����z�[���h�łȂ��Ɣ������Ȃ�
          a.push("��d") if not $msg.t_enemy.holding? and $msg.t_enemy.full_nude?
          #���z��P�͎�l����VP�����ȏ�A����l�����S���A��P�z�[���h�łȂ��Ɣ������Ȃ�
          if $game_actors[101].spp > 10 and $game_switches[85] == false
            a.push("�z���E����") if $game_actors[101].hold.penis.battler == nil and $game_actors[101].full_nude?
          end
          #�������͗��ҒE�ߏ�ԁA�����Ҕ�z�[���h�łȂ��Ɣ������Ȃ�
          if $game_actors[101].insertable_half_nude? or $game_actors[101].full_nude?
            if not $game_actors[101].holding? and not $msg.t_enemy.holding? #�z�[���h���͑I�������珜�O
              a.push("����") if $msg.t_enemy.friendly > 70
            end
          end
        end
      end
      #�����肪�z�[���h��Ԃ��Ɣ������Ȃ�����
      unless $msg.t_enemy.holding?
        #�������E�߂͊��ɖ������E���ł���A�������͖������z�[���h�����Ɣ������Ȃ�
        a.push("�����E��") unless $msg.t_enemy.full_nude?
        #�������͎�l������P�z�[���h�A�����肪��z�[���h�łȂ��Ɣ������Ȃ�
        if $game_actors[101].hold.penis.battler == nil
          a.push("�����E�ʏ�") if $game_actors[101].nude?
        end
        #���[�h������
        if $mood.point >= 40
          #�������͑��肪�S���łȂ��Ɣ������Ȃ�
          a.push("����") if $msg.t_enemy.full_nude?
          if $game_actors[101].spp > 10 and $game_switches[85] == false
            #���z�����͌����ǂ���Ă���Ɣ������Ȃ�
            a.push("�z���E��") if $game_actors[101].hold.mouth.battler == nil
          end
        end
      end
#      a.push("�_��") if $mood.point >= 100
      #�����[���b�g(�I�����������ꍇ�̂݁u�D�Ӂv���I�΂��)
      a.push("�D��") if a == []
      
      #���D�ӈȊO�̑I���������Ȃ������̏ꍇ
      if bitter_talk?($msg.t_enemy)
        a = ["�D��"] # �D�ӂ݂̂���ɂ���
        # 50���ŕs�����ɕύX
        if rand(100) < 50
          $msg.tag = "�s����"
          $msg.at_type = "���s�ߑ�" 
          # ���^�C�v��������ꍇ�͂�����ύX���Č���rb���ɉ��M
          return
        end
      end
      
      $msg.tag = a[rand(a.size)]
      #�z�[���h�v���̏ꍇ�A�ǂ̃z�[���h���s�����I��
      if $msg.tag == "����"
        b = []
        b.push("���}��") if $msg.t_enemy.insertable_half_nude? or $msg.t_enemy.full_nude?
#        b.push("���}��")
#        b.push("�L�b�X")
#        b.push("�K�}��") if $msg.t_enemy.insertable_half_nude? or $msg.t_enemy.full_nude?
#        b.push("�p�C�Y��") if $msg.t_enemy.full_nude?
        if b == []
          $msg.tag = "�D��"
          return
        end
        $msg.at_parts = b[rand(b.size)]
      end
      case $msg.tag
      when "�����E�ʏ�","�����E����","����","��d"
        @talk_command_type = "�p���^�C�v"
      when "��l���E��","���ԒE��","�����E��","�z���E��","�z���E����","����"
        @talk_command_type = "���ۃ^�C�v"
      end
    end
  end
  #============================================================================
  # �����f�B(�ʃg�[�N�̎��O�������o�͂��鏈��)
  #============================================================================
  def talk_ready
    case $msg.tag
    when "�����E�ʏ�","�����E����","����","��d"
      #�U�����؃��Z�b�g
      @befor_talk_action = []
      talk_attack_pattern
      make_text_pretalk
    else
      make_text_pretalk
    end
  end
  #============================================================================
  # �����U���g(�ʃg�[�N�̌��ʂ��o�͂��鏈��)
  #============================================================================
  def talk_result
#    p "�^�O�F#{@tag}�^���ށF#{@talk_command_type}"
    case $msg.tag
    when "�����E�ʏ�","�����E����","����","��d"
      unless $msg.talk_step >= 77
        talk_critical
        make_text_aftertalk
        talk_damage
        talk_states_change
        #�ǂݍ��񂾃e�L�X�g������E�F�C�g���Z�o
        SR_Util.talk_log_wait_make
        #�A�^�b�N�p�^�[���ēx�ǂݍ���
        talk_attack_pattern
        #���O�s���Ƃ̐�����������
        if @befor_talk_action[0] == @befor_talk_action[1]
          @chain_attack = true
        else
          @chain_attack = false
        end
        #�擪������
        a = @befor_talk_action[1]
        @befor_talk_action = []
        @befor_talk_action.push(a)
      end
    when "�z���E��","�z���E����"
      unless $msg.talk_step >= 77
        make_text_aftertalk
        talk_damage
        talk_states_change
      end
    when "��l���E��","���ԒE��","�����E��","����"
      make_text_aftertalk
      unless $msg.talk_step >= 77
        talk_states_change
      end
    when "�D��","�s����"
      make_text_aftertalk
    end
  end
  #============================================================================
  # ���A�^�b�N�p�^�[��(�����I�����ɍs�����[���b�g����)
  #============================================================================
  def talk_attack_pattern
    if $msg.tag == "�����E�ʏ�"
      #���[���b�g�쐬
      pattern = ["��","��","��","��","��","��","��"]
      pattern.push("��","��","��","��") if $msg.t_enemy.full_nude?
      pattern.push("�K��") if $data_SDB[$msg.t_enemy.class_id].tail == true
      #���Ԑ��`�F�b�N�X�L�����g��ꂽ�ꍇ�͗\�ߎ�_��˂���₷���Ȃ�
      if $msg.t_enemy.checking == 1
        pattern.push("��","��","��","��","��") if $game_actors[101].have_ability?("��U�߂Ɏア")
        pattern.push("��","��","��","��","��") if $game_actors[101].have_ability?("���U�߂Ɏア")
        pattern.push("��","��","��","��","��") if $game_actors[101].have_ability?("�n�s�U�߂Ɏア")
        pattern.push("��","��","��","��","��") if $game_actors[101].have_ability?("���U�߂Ɏア")
        pattern.push("��","��","��","��","��") if $game_actors[101].have_ability?("���A�U�߂Ɏア")
        pattern.push("�K��","�K��","�K��","�K��","�K��") if $game_actors[101].have_ability?("�ٌ`�U�߂Ɏア")
      end
      #����ȍ~�͎�_��m��ꂽ�ꍇ�ɒǉ����鍀��
      if $msg.t_enemy.talk_weak_check.include?("��")
        pattern.push("��","��","��","��","��") 
        pattern.push("��","��","��","��","��","��","��","��","��","��") if $game_actors[101].have_ability?("��U�߂Ɏア")
      end
      if $msg.t_enemy.talk_weak_check.include?("��")
        pattern.push("��","��","��","��","��") 
        pattern.push("��","��","��","��","��","��","��","��","��","��") if $game_actors[101].have_ability?("���U�߂Ɏア")
      end
      if $msg.t_enemy.talk_weak_check.include?("��")
        pattern.push("��","��","��","��","��","��","��") 
        pattern.push("��","��","��","��","��","��","��","��","��","��") if $game_actors[101].have_ability?("�n�s�U�߂Ɏア")
      end
      if $msg.t_enemy.talk_weak_check.include?("��")
        pattern.push("��","��","��","��","��","��") 
        pattern.push("��","��","��","��","��","��","��","��","��","��") if $game_actors[101].have_ability?("���U�߂Ɏア")
      end
      if $msg.t_enemy.talk_weak_check.include?("��")
        pattern.push("��","��","��","��","��","��") 
        pattern.push("��","��","��","��","��","��","��","��","��","��") if $game_actors[101].have_ability?("���A�U�߂Ɏア")
      end
      if $msg.t_enemy.talk_weak_check.include?("�K��")
        pattern.push("�K��","�K��","�K��","�K��","�K��") 
        pattern.push("�K��","�K��","�K��","�K��","�K��","�K��","�K��","�K��","�K��","�K��") if $game_actors[101].have_ability?("�ٌ`�U�߂Ɏア")
      end
      $msg.at_type = pattern[rand(pattern.size)]
      @befor_talk_action.push($msg.at_type)
    elsif $msg.tag == "��d" or $msg.tag == "����"
      #���[���b�g�쐬
      pattern = ["��","��","�K","�A�\�R"]
      pattern.push("�A�j","�A�i��") if $msg.t_enemy.full_nude?
      #���Ԑ��`�F�b�N�X�L�����g�����ꍇ�͎�_��˂��₷���Ȃ�
      if $msg.t_enemy.checking == 1
        pattern.push("��","��","��","��","��") if $msg.t_enemy.have_ability?("����������") or $msg.t_enemy.have_ability?("���O")
        pattern.push("��","��","��","��","��") if $msg.t_enemy.have_ability?("����������") or $msg.t_enemy.have_ability?("����")
        pattern.push("�K","�K","�K","�K","�K") if $msg.t_enemy.have_ability?("���K��������") or $msg.t_enemy.have_ability?("���K")
        pattern.push("�A�\�R","�A�\�R","�A�\�R","�A�\�R","�A�\�R") if $msg.t_enemy.have_ability?("���A��������") or $msg.t_enemy.have_ability?("����")
        pattern.push("�A�j","�A�j","�A�j","�A�j","�A�j") if $msg.t_enemy.have_ability?("�A�j��������") or $msg.t_enemy.have_ability?("���j")
        pattern.push("�A�i��","�A�i��","�A�i��","�A�i��","�A�i��") if $msg.t_enemy.have_ability?("�e����������") or $msg.t_enemy.have_ability?("����")
      end
      if $msg.t_enemy.talk_weak_check.include?("�ΏہF��")
        pattern.push("��","��","��","��","��") 
        pattern.push("��","��","��","��","��","��","��","��","��","��") if $msg.t_enemy.have_ability?("����������") or $msg.t_enemy.have_ability?("���O")
      end
      if $msg.t_enemy.talk_weak_check.include?("�ΏہF��")
        pattern.push("��","��","��","��","��") 
        pattern.push("��","��","��","��","��","��","��","��","��","��") if $msg.t_enemy.have_ability?("����������") or $msg.t_enemy.have_ability?("����")
      end
      if $msg.t_enemy.talk_weak_check.include?("�ΏہF�K")
        pattern.push("�K","�K","�K","�K","�K") 
        pattern.push("�K","�K","�K","�K","�K","�K","�K","�K","�K","�K") if $msg.t_enemy.have_ability?("���K��������") or $msg.t_enemy.have_ability?("���K")
      end
      if $msg.t_enemy.talk_weak_check.include?("�ΏہF�A�\�R")
        pattern.push("�A�\�R","�A�\�R","�A�\�R","�A�\�R","�A�\�R") 
        pattern.push("�A�\�R","�A�\�R","�A�\�R","�A�\�R","�A�\�R","�A�\�R","�A�\�R","�A�\�R","�A�\�R","�A�\�R") if $msg.t_enemy.have_ability?("���A��������") or $msg.t_enemy.have_ability?("����")
      end
      if $msg.t_enemy.talk_weak_check.include?("�ΏہF�A�j")
        pattern.push("�A�j","�A�j","�A�j","�A�j","�A�j") 
        pattern.push("�A�j","�A�j","�A�j","�A�j","�A�j","�A�j","�A�j","�A�j","�A�j","�A�j") if $msg.t_enemy.have_ability?("�A�j��������") or $msg.t_enemy.have_ability?("���j")
      end
      if $msg.t_enemy.talk_weak_check.include?("�ΏہF�A�i��")
        pattern.push("�A�i��","�A�i��","�A�i��","�A�i��","�A�i��") 
        pattern.push("�A�i��","�A�i��","�A�i��","�A�i��","�A�i��","�A�i��","�A�i��","�A�i��","�A�i��","�A�i��") if $msg.t_enemy.have_ability?("�e����������") or $msg.t_enemy.have_ability?("����")
      end
      $msg.at_parts = "�ΏہF" + pattern[rand(pattern.size)]
      @befor_talk_action.push($msg.at_parts)
    #�ʏ툤���ƕ�d�Ŗ����ꍇ�͖߂�
    else
      return
    end
  end
  #============================================================================
  # ���N���e�B�J��(�g�[�N���Ƀ_���[�W���Z�o����ۂ̃N���e�B�J���̏���)
  #   �K��$msg.t_target�͎�l���ɂȂ��Ă���(�͂�)
  #============================================================================
  def talk_critical
    case $msg.tag
    when "��d","����"
      damage_target = $msg.t_enemy
    else
      damage_target = $game_actors[101]
    end
    damage_target.critical = false
    #�Ώۂ̎�_��\�߃T�[�`
    talk_weakpoint
    #���ȍ��݂̎�_���Ŕj���ꂽ�ꍇ
    case @weakpoints
    #����(������)��˂����ꍇ(���łɊŔj�ς�)
    when 20
      perc = 60
    #����(������)��˂����ꍇ(�������ꂽ)
    when 10
      perc = [($msg.talk_step * 3),30].min + 20
    #����(������)���U�߂�ꂽ�ꍇ
    when 2
      perc = [($msg.talk_step * 3),30].min + 10
    #�ʏ�
    else
      perc = [$msg.talk_step,10].min + 10
    end
    #���m���v�Z
    if perc > rand(100)
      damage_target.critical = true
    else
      damage_target.critical = false
    end
  end
  #============================================================================
  # ���_���[�W(�g�[�N���Ɉ������Ŏ��_���[�W���Z�o����ۂ̏���)
  #   �K��$msg.t_target�͎�l���ɂȂ��Ă���(�͂�)
  #============================================================================
  def talk_damage
    text = ""
    #�_���[�W��^����Ώۂ��^�O���ƂɕύX
    if $msg.tag == "��d"
      damage_target = $msg.t_enemy
      #�_���[�W���Z�o
      base_dmg = [($game_actors[101].dex / 2).ceil, 40].min
      base_dmg += [[(($game_actors[101].level * 2) - damage_target.level),0].max,30].min
      base_dmg += rand(($mood.point / 5).round)
      base_dmg += rand($msg.talk_step * 3) if $msg.talk_step > 0
    elsif $msg.tag == "����"
      damage_target = $msg.t_enemy
      #�_���[�W���Z�o
      base_dmg = [($msg.t_enemy.dex / 2).ceil, 40].min
      base_dmg += rand(($mood.point / 5).round)
      base_dmg += rand($msg.talk_step * 3) if $msg.talk_step > 0
    else
      damage_target = $game_actors[101]
      #�_���[�W���Z�o
      base_dmg = [($msg.t_enemy.dex / 2).ceil, 80].min
      base_dmg += [(($msg.t_enemy.level * 2) - damage_target.level),0].max
      base_dmg += rand(($mood.point / 4).round)
      base_dmg += rand($msg.talk_step * 5) if $msg.talk_step > 0
    end
    #���܂�ɒႷ������C������
    base_dmg = 20 + rand(10) - rand(5) if base_dmg <= 20
    #��SS�����y�уA�j���[�V�����̐ݒ�
    #�����ɂ�SS�͔������Ȃ�
    case $msg.tag
    when "�����E�ʏ�","�����E����","��d"
      #�N���e�B�J������
      if damage_target.critical == true
        text += "Sensual Stroke�I\065\067"
        damage_target.animation_id = 103
        damage_target.animation_hit = true
        base_dmg = (base_dmg * 5 / 4).round
        #�������A�����̏ꍇ�͓˂�����_���m�ۂ��Ă���
        if $msg.tag == "�����E�ʏ�"
          unless $msg.t_enemy.talk_weak_check.include?($msg.at_type)
            $msg.t_enemy.talk_weak_check.push($msg.at_type)
          end
        elsif $msg.tag == "�����E����"
          unless $msg.t_enemy.talk_weak_check.include?($msg.at_type)
            $msg.t_enemy.talk_weak_check.push($msg.at_type)
          end
          @hold_initiative_refresh.push($msg.t_enemy,$game_actors[101])
        #����d�̏ꍇ�͓˂��ꂽ��_���m�ۂ��Ă���
        elsif $msg.tag == "��d"
          unless $msg.t_enemy.talk_weak_check.include?($msg.at_parts)
            $msg.t_enemy.talk_weak_check.push($msg.at_parts)
          end
        end
      #�N���e�B�J���Ŗ����ꍇ�͍U�����ƂɃA�j���[�V������\��
      else
        if $msg.at_type == "�K��"
          damage_target.animation_id = 46
        elsif $msg.tag == "�����E����"
          damage_target.animation_id = 107
        else
          damage_target.animation_id = 45
        end
        damage_target.animation_hit = true
      end
    when "�z���E��","�z���E����"
      damage_target.animation_id = 85
    when "����"
      damage_target.animation_id = 52
    end
    #�_���[�W�l�C��(�������P�Ƃ����ꍇ)
    case $msg.tag
    when "�����E����"
      unless $msg.at_parts == "�w�ʍS��"
        base_dmg = (base_dmg * 3 / 2).round
        if damage_target.shake_tate?
          # ��ʂ̏c�V�F�C�N
          $game_screen.start_flash(Color.new(255,210,225,220), 8)
          $game_screen.start_shake2(7, 15, 15)
        # �O���C���h�n
        elsif damage_target.shake_yoko?
          # ��ʂ̉��V�F�C�N
          $game_screen.start_flash(Color.new(255,210,225,220), 8)
          $game_screen.start_shake(7, 15, 15)
        end
      else
        if damage_target.critical == true
          base_dmg = (base_dmg * 4 / 3).round
        else
          base_dmg = (base_dmg * 2 / 3).round
        end
      end
    when "��d"
      base_dmg = (base_dmg * 2 / 3).round
    when "�z���E��","�z���E����"
      #��VP�����͕ʌv�Z��
      base_dmg = $msg.t_enemy.atk
      base_dmg += ($msg.t_enemy.level * 2) + rand($msg.t_enemy.level * 3)
      base_dmg += ($msg.t_enemy.str / 2).round if $msg.tag == "�z���E����"
      base_dmg = ($game_actors[101].sp - 1) if base_dmg >= $game_actors[101].sp
      $msg.t_enemy.add_state(16) #�z���̓X�e�[�g�ω���ʂ�Ȃ��̂ł����ōs������
    when "����"
      base_dmg = (base_dmg / 2).round
    end
    #�e�L�X�g�␳�E�_���[�W�K�p
    if $msg.tag == "�z���E��" or $msg.tag == "�z���E����"
      text += "#{damage_target.name}�͐��C�� #{base_dmg.to_s} �z�����ꂽ�I"
      damage_target.sp -= base_dmg
    else
      if $msg.tag == "��d"
        text += "#{$msg.t_enemy.name}�� #{base_dmg.to_s} �̉�����^�����I"
      elsif $msg.tag == "����"
        text += "#{$msg.t_enemy.name}�� #{base_dmg.to_s} �̉����𓾂��I"
      else
        text += "#{$msg.t_target.name}�� #{base_dmg.to_s} �̉������󂯂��I"
      end
      t_hp = damage_target.hp - base_dmg
      if t_hp <= 0
        if $msg.tag == "��d"
          $msg.talking_ecstasy_flag = "enemy"
        else
          p "�A�N�^�[" if $DEBUG
          $msg.talking_ecstasy_flag = "actor"
        end
        damage_target.add_state(11)
      end
      #���ۂɃ_���[�W��K�p����
      damage_target.hp -= base_dmg
    end
    #�X�e�[�^�X�E�B���h�E�X�V
    @stateswindow_refresh = true
    if $game_temp.battle_log_text != ""
      $game_temp.battle_log_text += "\065\067" + text
    else
      $game_temp.battle_log_text += text
    end
    
    #damage_target.animation_id = 0
    
    
    
    # �摜�ύX
    damage_target.graphic_change = true
  end
  #============================================================================
  # ���g�[�N��_�˂��`�F�b�N
  #============================================================================
  def talk_weakpoint
    @weakpoints = 0
    case $msg.at_type
    when "��"
      if $game_actors[101].have_ability?("���U�߂Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("��")
      end
    when "��"
      if $game_actors[101].have_ability?("��U�߂Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("��")
      end
    when "��"
      if $game_actors[101].have_ability?("���U�߂Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("��")
      end
    when "��"
      if $game_actors[101].have_ability?("���A�U�߂Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("��")
      end
    when "��"
      if $game_actors[101].have_ability?("�n�s�U�߂Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("��")
      end
    when "�K��"
      if $game_actors[101].have_ability?("�ٌ`�U�߂Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("�K��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("�K��")
      end
    when "���}��"
      if $game_actors[101].have_ability?("�����Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("���}��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("���}��")
      end
    when "���}��"
      if $game_actors[101].have_ability?("���U�߂Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("���}��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("���}��")
      end
    when "�K�}��"
      if $game_actors[101].have_ability?("�����Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("�K�}��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("�K�}��")
      end
    when "�p�C�Y��"
      if $game_actors[101].have_ability?("���U�߂Ɏア")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("��")
      end
    end
    #���肪�����̏ꍇ�A�Q�Ƃ���f�����ς��
    case $msg.at_parts
    when "�ΏہF��"
      if $msg.t_enemy.have_ability?("����������") or $msg.t_enemy.have_ability?("���O")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("�ΏہF��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("�ΏہF��")
      end
    when "�ΏہF��"
      if $msg.t_enemy.have_ability?("����������") or $msg.t_enemy.have_ability?("����")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("�ΏہF��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("�ΏہF��")
      end
    when "�ΏہF�K"
      if $msg.t_enemy.have_ability?("���K��������") or $msg.t_enemy.have_ability?("���K")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("�ΏہF�K")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("�ΏہF�K")
      end
    when "�ΏہF�A�\�R"
      if $msg.t_enemy.have_ability?("���A��������") or $msg.t_enemy.have_ability?("����")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("�ΏہF�A�\�R")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("�ΏہF�A�\�R")
      end
    when "�ΏہF�A�j"
      if $msg.t_enemy.have_ability?("�A�j��������") or $msg.t_enemy.have_ability?("���j")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("�ΏہF�A�j")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("�ΏہF�A�j")
      end
    when "�ΏہF�A�i��"
      if $msg.t_enemy.have_ability?("�e����������") or $msg.t_enemy.have_ability?("����")
        @weakpoints = 2
        @weakpoints = 20 if $msg.t_enemy.talk_weak_check.include?("�ΏہF�A�i��")
      else
        @weakpoints = 1
        @weakpoints = 10 if $msg.t_enemy.talk_weak_check.include?("�ΏہF�A�i��")
      end
    end
  end
  #============================================================================
  # ���X�e�[�g�ύX(�ʃg�[�N���̃X�e�[�g�t�^�����Ǘ�)
  #============================================================================
  def talk_states_change
    text = ""
    case $msg.tag
    when "�����E�ʏ�","�����E����"
      if $game_actors[101].hpp < 20 and $game_actors[101].hp > 0
        unless $game_actors[101].states.include?(6)
          $game_actors[101].add_state(6)
          if $game_temp.battle_log_text != ""
            text = "\065\067" + $game_actors[101].bms_states_update
          else
            text = $game_actors[101].bms_states_update
          end
          $game_actors[101].graphic_change = true
          $msg.stateswindow_refresh = true
        end
      end
      $msg.t_enemy.add_state(16) #�s������
    when "����"
      case $msg.at_parts
      when "���}��"
        # �A�N�Z�v�g��ʂ�
        SR_Util.special_hold_make($data_skills[682], $msg.t_enemy, $game_actors[101])
=begin
        # �A�N�Z�v�g��ʂ�
        $scene.hold_effect($data_skills[682], $msg.t_enemy, $game_actors[101])
        $msg.t_enemy.white_flash = true
        $msg.t_enemy.animation_id = 105
        $msg.t_enemy.animation_hit = true
        # ��ʂ̏c�V�F�C�N
        $game_screen.start_flash(Color.new(255,210,225,220), 8)
        $game_screen.start_shake2(7, 15, 15)

        #$msg.t_enemy.hold.vagina.set($game_actors[101], "�y�j�X", "���}��", 3)
        #$game_actors[101].hold.penis.set($msg.t_enemy, "�A�\�R", "���}��", 0)

        # �g�[�N����ɃX�^����������
        $scene.battler_stan($msg.t_enemy)
=end
#      when "���}��"
#      when "�K�}��"
#      when "�p�C�Y��"
#      when "�L�b�X"
      end
      @hold_pops_refresh = true
    when "��l���E��"
      $game_actors[101].undress
      if $game_temp.battle_log_text != ""
        text = "\065\067" + $game_actors[101].bms_states_update
      else
        text = $game_actors[101].bms_states_update
      end
      $game_actors[101].graphic_change = true
      $msg.stateswindow_refresh = true
      for enemy in $game_troop.enemies
        pc = [[($game_actors[101].str + 10 - enemy.int), 10].max, 40].min
        pc = [[($game_actors[101].dex + 10 - enemy.int), 10].max, 40].min if $msg.tag == "���ԒE��"
        #���悵�Ă��ƕt�^�m�����オ��
        pc += 20 if $game_switches[89] == true
        if rand(100) < pc
          enemy.add_state(32) #�h�L�h�L
          enemy.animation_id = 39
          if $game_temp.battle_log_text != ""
            text = "\065\067" + enemy.bms_states_update
          else
            text = enemy.bms_states_update
          end
        end
      end
    when "�����E��"
      $msg.t_enemy.undress
      if $game_temp.battle_log_text != ""
        text = "\065\067" + $msg.t_enemy.bms_states_update
      else
        text = $msg.t_enemy.bms_states_update
      end
      $msg.t_enemy.graphic_change = true
      $msg.stateswindow_refresh = true
      #��l���̂݃h�L�h�L�̉\���A�����Ă�⍂��
      pc = [[($msg.t_enemy.str + 20 - $game_actors[101].int), 20].max, 50].min
      #�i��Ō���Ƃ��m������
      pc += 30 if $game_switches[89] == true
      if rand(100) < pc
        $game_actors[101].add_state(32) #�h�L�h�L
        $game_actors[101].animation_id = 39
        if $game_temp.battle_log_text != ""
          text = "\065\067" + $game_actors[101].bms_states_update
        else
          text = $game_actors[101].bms_states_update
        end
      end
      $msg.t_enemy.add_state(16) #�s������
    when "��d"
      if ($msg.t_enemy.hpp < $mood.crisis_point(self) + rand(5)) and $msg.t_enemy.hp > 0
        unless $msg.t_enemy.states.include?(6)
          $msg.t_enemy.add_state(6)
          if $game_temp.battle_log_text != ""
            text = "\065\067" + $msg.t_enemy.bms_states_update
          else
            text = $msg.t_enemy.bms_states_update
          end
          $msg.t_enemy.graphic_change = true
          $msg.stateswindow_refresh = true
        end
      end
      case $msg.talk_step
      when 2
        $game_actors[101].add_state(32) #�h�L�h�L
        text += "\065\067" + $game_actors[101].bms_states_update
        $msg.t_enemy.add_state(16) #�s������
      when 3..99
        plus = ($msg.talk_step * 5)
        perc = $game_actors[101].int
        perc /= 3 if $game_switches[89] == true #��R���Ȃ��ƕt�^�������Ȃ�
        if $game_actors[101].state?(40)
          if rand($mood.point) + plus > [perc,60].min
            $game_actors[101].add_state(36) #�\��
            text += "\065\067" + $game_actors[101].bms_states_update
          end
        elsif $game_actors[101].state?(35)
          if rand($mood.point) + plus > [perc,45].min
            $game_actors[101].add_state(40) #�U��
            text += "\065\067" + $game_actors[101].bms_states_update
          end
        else
          if rand($mood.point) + plus > [perc,30].min
            $game_actors[101].add_state(35) #�~��
            text += "\065\067" + $game_actors[101].bms_states_update
          end
        end
      end
    when "����"
      if ($msg.t_enemy.hpp < $mood.crisis_point(self) + rand(5)) and $msg.t_enemy.hp > 0
        unless $msg.t_enemy.states.include?(6)
          $msg.t_enemy.add_state(6)
          if $game_temp.battle_log_text != ""
            text = "\065\067" + $msg.t_enemy.bms_states_update
          else
            text = $msg.t_enemy.bms_states_update
          end
          $msg.t_enemy.graphic_change = true
          $msg.stateswindow_refresh = true
        end
      end
      case $msg.talk_step
      when 2
        $game_actors[101].add_state(32) #�h�L�h�L
        text += "\065\067" + $game_actors[101].bms_states_update
        $msg.t_enemy.add_state(16) #�s������
      when 3..99
        plus = ($msg.talk_step * 5)
        perc = $game_actors[101].int
        perc /= 3 if $game_switches[89] == true #��R���Ȃ��ƕt�^�������Ȃ�
        if $game_actors[101].state?(40)
          if rand($mood.point) + plus > [perc,60].min
            $game_actors[101].add_state(34) #����
            text += "\065\067" + $game_actors[101].bms_states_update
          end
        elsif $game_actors[101].state?(35)
          if rand($mood.point) + plus > [perc,45].min
            $game_actors[101].add_state(40) #�U��
            text += "\065\067" + $game_actors[101].bms_states_update
          end
        else
          if rand($mood.point) + plus > [perc,30].min
            $game_actors[101].add_state(35) #�~��
            text += "\065\067" + $game_actors[101].bms_states_update
          end
        end
      end
    end
    $game_temp.battle_log_text += text
  end
  #============================================================================
  # ������ɐ����̈ӎv���Ȃ���b������ꍇ
  #============================================================================
  def bitter_talk?(enemy)
    result = false
    # �ʏ�튎�A�N���XID���v���[�X�e�X���M���S�[�������[�~���ł���
    if not ($game_switches[85] or $game_switches[86] or $game_switches[99])
      if [118,254,257].include?(enemy.class_id)
        result = true
      end
    end
    return result
  end
  
end