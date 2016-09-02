#==============================================================================
# �� Scene_Battle (������` 8)
#------------------------------------------------------------------------------
# �@�o�g����ʂ̏������s���N���X�ł��B
#   ���̍��ڂł̓��W�X�g�������s���܂��B
#==============================================================================

class Scene_Battle
  
  def battle_resist
    # ���W�X�g�t���O�����Ă�
    $game_temp.resistgame_flag = 1
    # ���W�X�g�̐��ۂ��N���A
    $game_temp.resistgame_clear = false
    # �_���[�W�i���[�g��Ɍ�����o���t���O������
    $game_switches[90] = true
    # �z�[���h�X�L���Ȃ�X�C�b�`�W�P���I���ɂ���
    $game_switches[81] = false
    $game_switches[81] = true if @skill.element_set.include?(6)
    # �����W�X�g�͊�{�{���[�h�{�\�́{���̑��̕␳���v�œ�Փx���肷��
    md = lvp = pm = ste = ins = 0
    # ���Ώۂ̐ݒ�Ɠ����Ƀ��[�h�␳�ƁA����ďo�L�[��ݒ肷��
    # �G�l�~�[���Ώۂ̏ꍇ(�s�������A�N�^�[)
    active = @active_battler
    target = @target_battlers[0]
    # --------------------------------------------------------------
    # ���g�[�N�X�e�b�v�A�R�[���T�C���ݒ�
    # --------------------------------------------------------------
    #�g�[�N�X�e�b�v���P�i���W�X�g�J�n�j�ɐݒ�
    #�Ȃ���q���邪���W�X�g�����̏ꍇ�͂Q�A���s�̏ꍇ�͂R�ƂȂ�
    #�g�[�N���̑I�������W�X�g�̏ꍇ�A���Ƀg�[�N�X�e�b�v�����邽�ߐݒ肵�Ȃ�
    #�z�[���h�U��
    if @skill.element_set.include?(6)
      $msg.talk_step = 1
      #�����n�X�L���͕ʘg
      if @skill.name == "�����[�X" or @skill.name == "�X�g���O��"
        if active == $game_actors[101]
          $msg.tag = "��l�����������z�[���h"
          $msg.at_type = "�����z�[���h����"
          $msg.callsign = 8
          $msg.callsign = 18 if $game_switches[85] == true
        else
          $msg.tag = "�p�[�g�i�[���������z�[���h"
          $msg.at_type = "�����z�[���h����"
          $msg.callsign = 28
          $msg.callsign = 38 if $game_switches[85] == true
        end
      elsif @skill.name == "�C���^���v�g"
        if active == $game_actors[101]
          $msg.tag = "��l�����������z�[���h"
          $msg.at_type = "���ԃz�[���h����"
          $msg.callsign = 8
          $msg.callsign = 18 if $game_switches[85] == true
        else
          $msg.tag = "�p�[�g�i�[���������z�[���h"
          $msg.at_type = "���ԃz�[���h����"
          $msg.callsign = 28
          $msg.callsign = 38 if $game_switches[85] == true
        end
      elsif target.is_a?(Game_Actor)
        if target == $game_actors[101]
          $msg.tag = "��������l�����z�[���h"
          $msg.callsign = 8
          $msg.callsign = 18 if $game_switches[85] == true
        else
          $msg.tag = "�������p�[�g�i�[���z�[���h"
          $msg.callsign = 28
          $msg.callsign = 38 if $game_switches[85] == true
        end
      elsif target.is_a?(Game_Enemy)
        if active == $game_actors[101]
          $msg.tag = "��l�����������z�[���h"
          $msg.callsign = 8
          $msg.callsign = 18 if $game_switches[85] == true
        else
          $msg.tag = "�p�[�g�i�[���������z�[���h"
          $msg.callsign = 28
          $msg.callsign = 38 if $game_switches[85] == true
        end
      end
      #�z�[���h�^�C�v���w��(�ǌ��C�x���g�Ƃ͔��Ȃ��̂�$msg.at_type���g�p)
      case @skill.name
      when "�C���T�[�g"
        $msg.at_type = "���}���F����"
      when "�A�N�Z�v�g"
        $msg.at_type = "���}���F����"
      when "�I�[�����C���T�[�g"
        $msg.at_type = "���}���F����"
      when "�I�[�����A�N�Z�v�g"
        $msg.at_type = "���}���F����"
      when "�o�b�N�C���T�[�g"
        $msg.at_type = "�`�}���F����"
      when "�o�b�N�A�N�Z�v�g"
        $msg.at_type = "�`�}���F�`��"
      when "�G�L�T�C�g�r���["
        $msg.at_type = "��ʋR��"
      when "�C���������r���["
        $msg.at_type = "�K�R��"
      when "�G���u���C�X"
        $msg.at_type = "�w�ʍS��"
      when "�G�L�V�r�W����"
        $msg.at_type = "�J�r"
      when "�y���X�R�[�v"
        $msg.at_type = "�p�C�Y��"
      when "�w�u�����[�t�B�[��"
        $msg.at_type = "�ςӂς�"
      when "�V�F���}�b�`"
        $msg.at_type = "�L���킹"
      when "�h���E�l�N�^�["
        $msg.at_type = "�N���j�����O�X"
      when "�t���b�^�i�C�Y"
        $msg.at_type = "�L�b�X"
      when "�C���T�[�g�e�C��"
        $msg.at_type = "�K�����}��"
      when "�}�E�X�C���e�C��"
        $msg.at_type = "�K�����}��"
      when "�o�b�N�C���e�C��"
        $msg.at_type = "�K���`�}��"
      when "�f�B���h�C���T�[�g"
        $msg.at_type = "�f�B���h���}��"
      when "�f�B���h�C���f�B���h"
        $msg.at_type = "�f�B���h���}��"
      when "�f�B���h�C���o�b�N"
        $msg.at_type = "�f�B���h�K�}��"
      when "�C���T�[�g�e���^�N��"
        $msg.at_type = "�G�聊�}��"
      when "�}�E�X�C���e���^�N��"
        $msg.at_type = "�G����}��"
      when "�o�b�N�C���e���^�N��"
        $msg.at_type = "�G��`�}��"
      when "�e���^�N���o���f�[�W"
        $msg.at_type = "�G��S��"
      when "�f�����Y�A�u�\�[�u"
        $msg.at_type = "�G��z��"
      when "�f�����Y�h���E"
        $msg.at_type = "�G��N���j"
      end
    #����̕���E������
    elsif @skill.element_set.include?(36)
      $msg.talk_step = 1
      if target.is_a?(Game_Actor)
        if target == $game_actors[101]
          $msg.tag = "��������l����E��"
          $msg.callsign = 7
          $msg.callsign = 17 if $game_switches[85] == true
        else
          $msg.tag = "�������p�[�g�i�[��E��"
          $msg.callsign = 27
          $msg.callsign = 37 if $game_switches[85] == true
        end
      elsif target.is_a?(Game_Enemy)
        if active == $game_actors[101]
          $msg.tag = "��l����������E��"
          $msg.callsign = 7
          $msg.callsign = 17 if $game_switches[85] == true
        else
          $msg.tag = "�p�[�g�i�[��������E��"
          $msg.callsign = 27
          $msg.callsign = 37 if $game_switches[85] == true
        end
      end
    #�g�[�N���̑I�������背�W�X�g
    elsif @skill.id == 10
      
    else
      $msg.talk_step = 1
      $msg.tag = "�ėp���W�X�g"
    end
    # --------------------------------------------------------------
    # �����W�X�g�A�C�R�����ݒ�
    # --------------------------------------------------------------
    # �����x�����␳(�����x���Ȃ�C���͖���)
    # �����̂ق���������Ζ������Ł{�P�����
    # �A�N�^�[�̂ق����R���x���ȏ㍂����΁A�Q���x�����ƂɁ|�P�����
    # --------------------------------------------------------------
    #���z�[���h�����X�L���͕ʏ����ƂȂ�
    #================================================================================================
    if @skill.name == "�����[�X" or @skill.name == "�X�g���O��"
    #================================================================================================
      n = 8
      #�����̗L���x�Ԃ��Փx����������
      if active.penis_intv != nil
        n -= active.penis_intv if target.hold.penis.battler == active
      end
      if active.vagina_intv != nil
        n -= active.vagina_intv if target.hold.vagina.battler == active
      end
      if active.mouth_intv != nil
        n -= active.mouth_intv if target.hold.mouth.battler == active
      end
      if active.anal_intv != nil
        n -= active.anal_intv if target.hold.anal.battler == active
      end
      if active.tops_intv != nil
        n -= active.tops_intv if target.hold.tops.battler == active
      end
      if active.tail_intv != nil
        n -= active.tail_intv if target.hold.tail.battler == active
      end
      if active.tentacle_intv != nil
        n -= active.tentacle_intv if target.hold.tentacle.battler == active
      end
      if active.dildo_intv != nil
        n -= active.dildo_intv if target.hold.dildo.battler == active
      end
#      p "�C�j�`�A�`�u�␳�F#{n}"if $DEBUG
      #�X�e�[�g�E���i�ɂ���ē�Փx���ϓ�
#      n += 1 if not active.talkable? #�N���C�V�X�E�\���Ȃǉ�b�ł��Ȃ��قǗ]�T�������ꍇ
#      n += 2 if active.dancing? #������Ԃ̏ꍇ
      # �␳
      n += resist_correction(active, target) if active.is_a?(Game_Enemy)
      n -= resist_correction(active, target) if active.is_a?(Game_Actor)
      #���i�ɂ���ē�Փx���ϓ�
      case target.personality 
      when "���C","�Â���","�|��","�Ӓn��"
        n += 1
      #�ꕔ�̐��i�̖����͈����������₷��
      when "�W��","�V�R","�]��","�z�C"
        n -= 1
      end
      #��჏�Ԃ̏ꍇ�A�ő�l�E�ŏ��l���ϓ�����(�o����Ⴢ̏ꍇ�͒ʏ�ʂ�)
      if not (active.state?(39) and target.state?(39))
        n = 5 if n < 5 if active.state?(39) #�s����(�A�N�^�[)�����
        n = 4 if n > 4 if target.state?(39) #�󓮑�(�G�l�~�[)�����
      end
      #�A�����W�X�g��R�ɂ���Փx�ω����s��
      n -= target.resist_count
      #�ŏI����
      n = 7 if n > 7
      n = 2 if n < 2
#      p "�C�j�`�A�`�u�␳��F#{n}"if $DEBUG
      #��Փx���
      #-------------------------------------------------------------------------------
      $game_temp.resistgame_difficulty = n
      return
    #================================================================================================
    elsif @skill.name == "�C���^���v�g"
    #================================================================================================
      if active == $game_actors[101]
        for i in $game_party.actors
          if i != $game_actors[101]
            hold_actor = i
          end
        end
      else
        hold_actor = $game_actors[101]
      end
      n = 8
      #�Ώۂ̗L���x�Ԃ��Փx����������
      if target.penis_intv != nil
        n -= target.penis_intv if target.hold.penis.battler == hold_actor
      end
      if target.vagina_intv != nil
        n -= target.vagina_intv if target.hold.vagina.battler == hold_actor
      end
      if target.mouth_intv != nil
        n -= target.mouth_intv if target.hold.mouth.battler == hold_actor
      end
      if target.anal_intv != nil
        n -= target.anal_intv if target.hold.anal.battler == hold_actor
      end
      if target.tops_intv != nil
        n -= target.tops_intv if target.hold.tops.battler == hold_actor
      end
      if target.tail_intv != nil
        n -= target.tail_intv if target.hold.tail.battler == hold_actor
      end
      if target.tentacle_intv != nil
        n -= target.tentacle_intv if target.hold.tentacle.battler == hold_actor
      end
      if target.dildo_intv != nil
        n -= target.dildo_intv if target.hold.dildo.battler == hold_actor
      end
#      p "�C�j�`�A�`�u�␳�F#{n}"if $DEBUG
      #�X�e�[�g�E���i�ɂ���ē�Փx���ϓ�
#      n -= 1 if not target.talkable? #�N���C�V�X�E�\���Ȃǉ�b�ł��Ȃ��قǗ]�T�������ꍇ
#      n -= 1 if target.dancing? #������Ԃ̏ꍇ
      # �␳
      n += resist_correction(active, target) if active.is_a?(Game_Enemy)
      n -= resist_correction(active, target) if active.is_a?(Game_Actor)
      
      #���i�ɂ���ē�Փx���ϓ�
      case target.personality 
      when "���C","�Â���","�|��","�Ӓn��"
        n += 1
      #�ꕔ�̐��i�̖����͈����������₷��
      when "�W��","�V�R","�]��","�z�C"
        n -= 1
      end
      #��჏�Ԃ̏ꍇ�A�ő�l�E�ŏ��l���ϓ�����(�o����Ⴢ̏ꍇ�͒ʏ�ʂ�)
      if not (active.state?(39) and target.state?(39))
        n = 5 if n < 5 if active.state?(39) #�s����(�A�N�^�[)�����
        n = 4 if n > 4 if target.state?(39) #�󓮑�(�G�l�~�[)�����
      end
      # �A�����W�X�g��R�ɂ���Փx�ω����s��
      n -= target.resist_count
      #�ŏI����
      n = 7 if n > 7
      n = 2 if n < 2
#      p "�C�j�`�A�`�u�␳��F#{n}"if $DEBUG
      #��Փx���
      #-------------------------------------------------------------------------------
      $game_temp.resistgame_difficulty = n
      return
    end
    #================================================================================================
    # ���g�[�N�I�������W�X�g�͕ʏ����ƂȂ�
    if @skill.id == 10
      n = 0
#      case $msg.tag
      $game_temp.resistgame_difficulty = 1
      # �^�C�}�[���Z�b�g
      $game_temp.resistgame_timer = 50
      return
    end
    #-------------------------------------------------------------------------------
    #����Փx�Z�o
    #p "�U/#{attack_pow}�F�h/#{defense_pow}" if $DEBUG
    #-------------------------------------------------------------------------------
    #����l���Ăяo��
    n = 0
    if active.is_a?(Game_Enemy)
      n += $mood.resist_rate(active)
      #���\�����̕␳����󓮑��̕␳���������l���Փx�ɉ��Z
      n += resist_correction(active, target)
    elsif active.is_a?(Game_Actor)
      n += $mood.resist_rate(target)
      #���\�����̕␳����󓮑��̕␳���������l���Փx���猸�Z
      n -= resist_correction(active, target)
    end
    #��჏�Ԃ̏ꍇ�A�ő�l�E�ŏ��l���ϓ�����(�o����Ⴢ̏ꍇ�͒ʏ�ʂ�)
    if active.is_a?(Game_Enemy) and not (active.state?(39) and target.state?(39))
      n = 6 if n > 6 if active.state?(39) #�s����(�G�l�~�[)����Ⴢ͍ő�l��������
      n = 7 if n < 7 if target.state?(39) #�󓮑�(�A�N�^�[)����Ⴢ͍ŏ��l���グ��
    elsif active.is_a?(Game_Actor) and not (active.state?(39) and target.state?(39))
      n = 7 if n < 7 if active.state?(39) #�s����(�A�N�^�[)����Ⴢ͍ŏ��l���グ��
      n = 6 if n > 6 if target.state?(39) #�󓮑�(�G�l�~�[)����Ⴢ͍ő�l��������
    end
    # �����̃��[���A��R�̃��[���ɂ��ő�l�ϓ�
    n = 6 if n > 6 if active.is_a?(Game_Actor) and active.equip?("�����̃��[��")
    n = 6 if n > 6 if target.is_a?(Game_Actor) and target.equip?("��R�̃��[��")
    #��R�񐔂œ�Փx�𑝌�
    n += (target.resist_count * 2) if active.is_a?(Game_Enemy)#��R�񐔂����Z(�񐔂������Ɛ������ɂ����Ȃ�)
    n -= (target.resist_count * 2) if active.is_a?(Game_Actor)#��R�񐔂����Z(�񐔂������Ɛ������₷���Ȃ�)
    #-------------------------------------------------------------------------------
    #���ő�l�E�ŏ��l�␳(�ő�P�O�A�ŏ��R�Ƃ���)
    #-------------------------------------------------------------------------------
    n = 10 if n > 10
    n = 3 if n < 3
    #-------------------------------------------------------------------------------
    #����Փx���
    #-------------------------------------------------------------------------------
    $game_temp.resistgame_difficulty = n
    return
  end
  
  #--------------------------------------------------------------------------
  # �� ���W�X�g�␳
  #--------------------------------------------------------------------------
  def resist_correction(active, target)
    n = 0
    attack_pow = 0
    defense_pow = 0
    #-------------------------------------------------------------------------------
    #���s�����̕␳
    #-------------------------------------------------------------------------------
    #���x���␳
    attack_pow += 1 if active.level > target.level
    attack_pow += ((active.level - (target.level + 2)) / 2).ceil if active.level > (target.level + 2)
    #�p�����[�^�␳
    attack_pow += 1 if (active.str > target.str) and @skill.element_set.include?(6) #�z�[���h���W�X�g
    attack_pow += 1 if (active.atk > target.atk) and @skill.element_set.include?(7) #�U�f���W�X�g
    attack_pow += 1 if (active.dex > target.agi) and @skill.element_set.include?(8) #�������W�X�g
    #�X�e�[�g�␳(�������L���Ȃ��̂̓v���X�A�s���Ȃ��̂̓}�C�i�X)
    attack_pow += 1 if active.state?(41) #���g(�\�����͗L��)
    attack_pow += 5 if active.state?(36) #�\��(�\�����͗L��)
    attack_pow -= 1 if active.state?(42) #����(�\�����͕s��)
    attack_pow -= 1 if active.state?(6) #�N���C�V�X(�s��)
    attack_pow -= 5 if active.state?(34) #����(�s��)
    attack_pow -= 2 if active.state?(40) #�U��(�s��)
    attack_pow -= 15 if active.weaken? #������(�s��)
    attack_pow -= 3 if active.state?(93) #�h�䒆(�\�����͕s��)
    attack_pow -= 5 if active.state?(94) #��h�䒆(�\�����͕s��)
    attack_pow -= 2 if active.dancing? #�Q�ӏ��ȏ�z�[���h(�s��)
    attack_pow -= 1 if active.state?(13) #�f�B���C���󂯂Ă���(�s��)
    attack_pow -= 2 if $incense.exist?("�Д�", active) #�C���Z���X�u�Д��v�i�s���j
    # �����̂ݕ␳�i�����i�Ȃǁj
    if active.is_a?(Game_Actor)
      attack_pow += 1  if active.equip?("���\��") #(�L��)
      attack_pow += 3  if active.equip?("��؂Ȏ҂̎��") #(�L��)
      attack_pow -= 2  if active.equip?("�i���̃J���I") #(�s��)
      attack_pow -= 10  if active.equip?("�ꑮ�̎��") #(�s��)
    end
    #�z�[���h�␳(�y�j�X�E�A�\�R�E�A�i�����g���^�C�v�̏ꍇ�A�����x���Q�Ƃ���)
    if @skill.element_set.include?(6)
      attack_pow += [(active.lub_male / 15).floor,3].min if @skill.element_set.include?(95) #�y�j�X���g�p����z�[���h
      attack_pow += [(active.lub_female / 15).floor,3].min if @skill.element_set.include?(97) #�A�\�R���g�p����z�[���h
      attack_pow += [(active.lub_anal / 15).floor,3].min if @skill.element_set.include?(94) #�A�i�����g�p����z�[���h
      attack_pow += (($mood.point) / 30).floor #���[�h���オ��ƗL��
    end
    #-------------------------------------------------------------------------------
    #���󓮑��̕␳
    #-------------------------------------------------------------------------------
    #���x���␳
    defense_pow += 1 if active.level < target.level
    defense_pow += ((target.level - (active.level + 2)) / 2).ceil if (active.level + 2) < target.level
    #�p�����[�^�␳
    defense_pow += 1 if (active.str < target.str) and @skill.element_set.include?(6) #�z�[���h���W�X�g
    defense_pow += 1 if (active.atk < target.atk) and @skill.element_set.include?(7) #�U�f���W�X�g
    defense_pow += 1 if (active.dex < target.agi) and @skill.element_set.include?(8) #�������W�X�g
    #�X�e�[�g�␳(�������L���Ȃ��̂̓v���X�A�s���Ȃ��̂̓}�C�i�X)
    defense_pow -= 1 if target.state?(41) #���g(�󓮎��͕s��)
    defense_pow -= 5 if target.state?(36) #�\��(�󓮎��͕s��)
    defense_pow += 1 if target.state?(42) #����(�󓮎��͗L��)
    defense_pow -= 1 if target.state?(6) #�N���C�V�X(�s��)
    defense_pow -= 15 if target.state?(34) #����(�s��)
    defense_pow -= 2 if target.state?(40) #�U��(�s��)
    defense_pow -= 15 if target.state?(105) #�S��(�s��)
    defense_pow -= 15 if target.weaken? #������(�s��)
    defense_pow += 3 if target.state?(93) #�h�䒆(�󓮎��̂ݗL��)
    defense_pow += 5 if target.state?(94) #��h�䒆(�󓮎��̂ݗL��)
    defense_pow -= 2 if target.dancing? #�Q�ӏ��ȏ�z�[���h(�s��)
    defense_pow -= 1 if target.state?(13) #�f�B���C���󂯂Ă���(�s��)
    defense_pow -= 2 if $incense.exist?("�Д�", target) #�C���Z���X�u�Д��v�i�s���j
    # �����̂ݕ␳�i�����i�Ȃǁj
    if active.is_a?(Game_Actor)
      defense_pow -= 2  if active.equip?("�i���̃J���I") #(�s��)
      defense_pow -= 10  if active.equip?("�ꑮ�̎��") #(�s��)
    end
    #�z�[���h�␳(�y�j�X�E�A�\�R�E�A�i�����g���^�C�v�̏ꍇ�A�����x���Q�Ƃ���)
    if @skill.element_set.include?(6)
      #�S���^�C�v�E�}���^�C�v�ł��ꂼ��x�[�X�̓�Փx�����Z����
      defense_pow += 5 if @skill.element_set.include?(134) #�}���^�C�v�͓�Փx������
      defense_pow += 4 if @skill.element_set.include?(135) #�S���^�C�v�͓�Փx���Ⴂ
      defense_pow -= [(target.lub_male / 15).floor,3].min if @skill.element_set.include?(74) #�y�j�X��Ώۂɂ���z�[���h
      defense_pow -= [(target.lub_female / 15).floor,3].min if @skill.element_set.include?(75) #�A�\�R��Ώۂɂ���z�[���h
      defense_pow -= [(target.lub_anal / 15).floor,3].min if @skill.element_set.include?(76) #�A�i����Ώۂɂ���z�[���h
      defense_pow -= (($mood.point) / 30).floor #���[�h���オ��ƕs��
    end
    # ���Z���ĕ␳�l���m�肵�ĕԂ�
    n = attack_pow - defense_pow
    return n
  end
  
end