#==============================================================================
# �� Scene_Battle (������` 6)
#------------------------------------------------------------------------------
# �@�o�g����ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Battle
  #--------------------------------------------------------------------------
  # �� ����z�[���h�t�^�̏���
  #--------------------------------------------------------------------------
  def special_hold_start
    $game_switches[81] = true
    @add_hold_flag = true
    hold_record
  end
  #--------------------------------------------------------------------------
  # �� ����z�[���h�t�^�̏I��
  #--------------------------------------------------------------------------
  def special_hold_end
    $game_switches[81] = false
    @add_hold_flag = false
    hold_pops_order
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h��������
  #--------------------------------------------------------------------------
  def hold_effect(skill, active, target)
    
    #��ʃV�F�C�N
    # �s�X�g���n
    if @hold_shake == true
      #�t���b�V���{�A�j���[�V����
      if target.is_a?(Game_Enemy)
        if skill.name == "�����[�X" or skill.name == "�C���^���v�g"
          active.white_flash = true
          target.animation_id = 129
          target.animation_hit = true
        else
          active.white_flash = true
          target.animation_id = 105
          target.animation_hit = true
        end
      elsif target.is_a?(Game_Actor)
        target.white_flash = true
        active.animation_id = 105
        active.animation_hit = true
      end
      if skill.element_set.include?(37)
        # ��ʂ̏c�V�F�C�N
        $game_screen.start_flash(Color.new(255,210,225,220), 8)
        $game_screen.start_shake2(7, 15, 15)
      # �O���C���h�n
      elsif skill.element_set.include?(38)
        # ��ʂ̉��V�F�C�N
        $game_screen.start_flash(Color.new(255,210,225,220), 8)
        $game_screen.start_shake(7, 15, 15)
      end
      #�z�[���h�������ɂ̓e�L�X�g���o���A�^�[�Q�b�g���s���ς݂ɂ���
      unless (skill.name == "�����[�X" or skill.name == "�C���^���v�g")
        @action_battlers.delete(target)
      end
      make_hold_text(skill, active, target)
    elsif @hold_shake == false
      if skill.element_set.include?(37)
        # ��ʂ̏c�V�F�C�N
#        $game_screen.start_flash(Color.new(255,210,225,100), 8)
        $game_screen.start_shake2(2, 15, 10)
      # �O���C���h�n
      elsif skill.element_set.include?(38)
        # ��ʂ̉��V�F�C�N
#        $game_screen.start_flash(Color.new(255,210,225,100), 8)
        $game_screen.start_shake(2, 15, 10)
      end
    end
    #-------------------------------------------------------------------------
    # ���������A�z�[���h�t�^���ɃC�j�V�A�`�u��ϓ�������
    #-------------------------------------------------------------------------
    if $game_switches[81] and @add_hold_flag
      # ���łɑ��肪�P�ȏ�z�[���h���Ă���ꍇ�A�Ώێ���̃z�[���h�����ׂĔ��]������
      if target.hold.hold_output.size > 0 and target.hold.initiative? and
       not ["�����[�X","�C���^���v�g","�X�g���O��"].include?(skill.name)
        # ���̋L�q�͊ȗ����������\�b�h�ɂ��܂���
        hold_dancing_change(target)
=begin
       #�܂�����̃C�j�V�A�`�u��S�ĊO���A�Ώۂ��z�[���h���Ă���o�g���[�S�Ă�
        #�L���Q��t�^����(���g�܂�)
        #�p�[�c���ƂɌʑΉ����邱�ƁB
        #���y�j�X����
        if target.hold.penis.battler != nil
          target.hold.penis.initiative = 0
          hold_target = target.hold.penis.battler
          case target.hold.penis.type
          when "���}��"
            hold_target.hold.vagina.initiative = 2
          when "���}��"
            hold_target.hold.mouth.set(nil, nil, nil, nil)
            target.hold.penis.set(nil, nil, nil, nil)
          when "�K�}��"
            hold_target.hold.anal.set(nil, nil, nil, nil)
            target.hold.penis.set(nil, nil, nil, nil)
          when "�G��z��"
            hold_target.hold.tentacle.set(nil, nil, nil, nil)
            target.hold.penis.set(nil, nil, nil, nil)
          end
        end
        #��������
        if target.hold.mouth.battler != nil
          target.hold.mouth.initiative = 0
          hold_target = target.hold.mouth.battler
          case target.hold.mouth.type
          when "���}��"
            hold_target.hold.penis.set(nil, nil, nil, nil)
            target.hold.mouth.set(nil, nil, nil, nil)
          when "�f�B���h���}��"
            hold_target.hold.dildo.set(nil, nil, nil, nil)
            target.hold.mouth.set(nil, nil, nil, nil)
          when "�N���j"
            #�S���^�C�v�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.vagina.set(nil, nil, nil, nil)
            target.hold.mouth.set(nil, nil, nil, nil)
          when "�L�b�X"
            #�S���^�C�v�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.mouth.set(nil, nil, nil, nil)
            target.hold.mouth.set(nil, nil, nil, nil)
          end
        end
        #���A�\�R����
        if target.hold.vagina.battler != nil
          target.hold.vagina.initiative = 0
          hold_target = target.hold.vagina.battler
          case target.hold.vagina.type
          when "���}��"
            hold_target.hold.penis.initiative = 2
          when "�L���킹"
            hold_target.hold.vagina.initiative = 2
          when "�N���j"
            #�S���^�C�v�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.mouth.set(nil, nil, nil, nil)
            target.hold.vagina.set(nil, nil, nil, nil)
          when "�f�B���h���}��"
            hold_target.hold.dildo.set(nil, nil, nil, nil)
            target.hold.vagina.set(nil, nil, nil, nil)
          when "��ʋR��"
            #�S���^�C�v�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.mouth.set(nil, nil, nil, nil)
            target.hold.vagina.set(nil, nil, nil, nil)
          when "�G��N���j"
            #�S���^�C�v�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.tentacle.set(nil, nil, nil, nil)
            target.hold.vagina.set(nil, nil, nil, nil)
          end
        end
        #���A�i������
        if target.hold.anal.battler != nil
          target.hold.anal.initiative = 0
          hold_target = target.hold.anal.battler
          case target.hold.anal.type
          when "�K�}��"
            hold_target.hold.penis.initiative = 2
          when "�f�B���h�K�}��"
            hold_target.hold.dildo.set(nil, nil, nil, nil)
            target.hold.anal.set(nil, nil, nil, nil)
          when "�K�R��"
            hold_target.hold.mouth.set(nil, nil, nil, nil)
            target.hold.anal.set(nil, nil, nil, nil)
          end
        end
        #���㔼�g����
        if target.hold.tops.battler != nil
          target.hold.tops.initiative = 0
          #�㔼�g�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
          hold_target = target.hold.tops.battler
          case target.hold.tops.type
          when "�p�C�Y��"
            #�p�C�Y���̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.penis.set(nil, nil, nil, nil)
            target.hold.tops.set(nil, nil, nil, nil)
          when "�ςӂς�"
            #�ςӂςӂ̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.mouth.set(nil, nil, nil, nil)
            target.hold.tops.set(nil, nil, nil, nil)
          when "�G��S��","�ӍS��"
            #�S���^�C�v�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.tentacle.set(nil, nil, nil, nil)
            target.hold.tops.set(nil, nil, nil, nil)
          else
            hold_target.hold.tops.set(nil, nil, nil, nil)
            target.hold.tops.set(nil, nil, nil, nil)
          end
        end
        #���K������
        if target.hold.tail.battler != nil
          target.hold.tail.initiative = 0
          #�K���̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
          hold_target = target.hold.tail.battler
          case target.hold.tail.type
          when "���}��"
            hold_target.hold.vagina.set(nil, nil, nil, nil)
          when "���}��"
            hold_target.hold.mouth.set(nil, nil, nil, nil)
          when "�K�}��"
            hold_target.hold.anal.set(nil, nil, nil, nil)
          end
          target.hold.tail.set(nil, nil, nil, nil)
        end
        #���f�B���h����
        if target.hold.dildo.battler != nil
          target.hold.dildo.initiative = 0
          #�K���̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
          hold_target = target.hold.dildo.battler
          case target.hold.dildo.type
          when "�f�B���h���}��"
            hold_target.hold.vagina.set(nil, nil, nil, nil)
          when "�f�B���h���}��"
            hold_target.hold.mouth.set(nil, nil, nil, nil)
          when "�f�B���h�K�}��"
            hold_target.hold.anal.set(nil, nil, nil, nil)
          end
          target.hold.dildo.set(nil, nil, nil, nil)
        end
        #���G�蕔��
        if target.hold.tentacle.battler != nil
          target.hold.tentacle.initiative = 0
          #�K���̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
          hold_target = target.hold.tentacle.battler
          case target.hold.tentacle.type
          when "�G��z��"
            hold_target.hold.penis.set(nil, nil, nil, nil)
          when "�G�聊�}��","�G��N���j"
            hold_target.hold.vagina.set(nil, nil, nil, nil)
          when "�G����}��"
            hold_target.hold.mouth.set(nil, nil, nil, nil)
          when "�G��K�}��"
            hold_target.hold.anal.set(nil, nil, nil, nil)
          when "�G��S��","�ӍS��","�G��J�r"
            hold_target.hold.tops.set(nil, nil, nil, nil)
          end
          target.hold.tentacle.set(nil, nil, nil, nil)
        end
=end
      end

      
      # ���̌�A�z�[���h�t�^�������s��
      add_hold(skill, active, target)
      # �O���t�B�b�N�`�F���W�t���O�𗧂Ă�
      active.graphic_change = true
      target.graphic_change = true
    end
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h�������e�L�X�g����
  #--------------------------------------------------------------------------
  def make_hold_text(skill, active, target)
    if active.is_a?(Game_Actor)
      #�z�[���h������e�L�X�g�𐮌`
      
      brk = "\n" if SR_Util.names_over?(active.name,target.name)
      case skill.name
      when "�C���T�[�g"
        text = "#{active.name} inserted into #{target.name}!"
      when "�A�N�Z�v�g"
        text = "#{active.name} inserted #{target.name}'s penis into her pussy!"
      when "�I�[�����C���T�[�g"
        text = "#{active.name} inserted into#{brk} #{target.name}'s ��outh!"
      when "�I�[�����A�N�Z�v�g"
        text = "#{active.name} sucked#{brk} #{target.name}'s penis into her ��outh!"
      when "�o�b�N�C���T�[�g"
        text = "#{active.name} inserted into#{brk} up #{target.name}'s ass!"
      when "�o�b�N�A�N�Z�v�g"
        text = "#{active.name} inserted #{target.name}'s penis up her ass!"
      when "�G�L�T�C�g�r���["
        text = "#{active.name} is straddling #{brk}#{target.name}'s face!"
      when "�h���E�l�N�^�["
        if active.name == $game_actors[101]
        text = "#{active.name} drinks in #{brk}#{target.name}'s pussy ��ith his ��outh!"
        else
        text = "#{active.name} drinks in #{brk}#{target.name}'s pussy\n ��ith her ��outh!"
        end
      when "�G���u���C�X"
        text = "#{active.name} clings tightly to #{brk}#{target.name}!"
      when "�V�F���}�b�`"
        text = "#{active.name} legs intertwined ��ith #{brk}#{target.name}'s!"
      when "�f�B���h�C���T�[�g"
        text = "#{active.name} inserted into #{brk}#{target.name}!"
      when "�f�B���h�C���}�E�X"
        text = "#{active.name} inserted into #{brk}#{target.name}'s ��outh!"
      when "�f�B���h�C���o�b�N"
        text = "#{active.name} inserted up #{brk}#{target.name}'s ass!"
      when "�A�C���B�N���[�Y","�f�����Y�N���[�Y"
        text = "#{active.name}�̑���G��́A\n#{target.name}�̐g�̂𗍂߂Ƃ����I"
      when "�f�����Y�A�u�\�[�u"
        text = "#{active.name}�̑���G�肪�A\n#{target.name}�̃y�j�X�ɋz���t�����I"
      when "�f�����Y�h���E"
        text = "#{active.name}�̑���G�肪�A\n#{target.name}�̃A�\�R�ɋz���t�����I"
      when "�����[�X"
        text = "#{active.name} broke free fro�� #{target.name}!"
      when "�C���^���v�g"
        if active == $game_actors[101]
          for i in $game_party.actors
            if i != $game_actors[101]
              partner = i
            end
          end
        else
          partner = $game_actors[101]
        end
        text = "#{active.name} separated #{partner.name} fro�� #{target.name}!"
      end
    elsif active.is_a?(Game_Enemy)
      #�z�[���h������e�L�X�g�𐮌`
      case skill.name
      when "�C���T�[�g"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} spreads her legs\n to receive #{active.name}'s insertion!"
        else
          text = "#{target.name} ��as violated by #{active.name}!"
        end
      when "�A�N�Z�v�g"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} lies on his back,\n ready to be inserted by #{active.name}!"
        else
          text = "#{target.name} ��as violated by #{active.name}!"
        end
      when "�I�[�����C���T�[�g"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} opens her mouth\n to receive #{active.name}'s penis!"
        else
          text = "#{active.name}'s penis has been\n scre��ed into #{target.name}'s ��outh!"
        end
      when "�I�[�����A�N�Z�v�g"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} thrusts forward, offering\n his penis to #{active.name}'s lewd ��outh!"
        else
          text = "#{target.name}'s penis ��as stuffed\n into #{active.name}'s ��outh!"
        end
      when "�o�b�N�C���T�[�g"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} opens up her ass\n to receive #{active.name}'s penis!"
        else
          text = "#{target.name}'s sphincter has been pierced by\n #{active.name}'s penis!"
        end
      when "�o�b�N�A�N�Z�v�g"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} looks upward, ready to\n be inserted into #{active.name}'s ass!"
        else
          text = "#{target.name}'s penis has been s��allo��ed by\n #{active.name}'s ass!"
        end
      when "�G�L�T�C�g�r���["
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "Lying down, #{target.name} willingly accepts\n to be sat on by #{active.name}!"
        else
          text = "#{target.name}'s face is being s��othered by\n #{active.name}'s pussy!"
        end
      when "�C���������r���["
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "Lying down, #{target.name} willingly accepts\n to be sat on by #{active.name}!"
        else
          text = "#{target.name}'s face is being s��othered by\n #{active.name}'s ass!"
        end
      when "�G���u���C�X"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          if active.name == $game_actors[101]
          text = "#{target.name} relaxes and entrusts his body\n to #{active.name}!"
          else
          text = "#{target.name} relaxes and entrusts her\n body to #{active.name}!"
          end
        else
          text = "#{active.name} clung tightly to #{target.name}!"
        end
      when "�G�L�V�r�W����"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} spreads her legs,\n entrusting herself to #{active.name}!"
        else
          text = "#{active.name} clings on to #{target.name},\n opening up her crotch for all to see!"
        end
      when "�y���X�R�[�v"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} thrusts out his pelvis\n and buries his penis in #{active.name}'s breasts!"
        else
          text = "#{target.name}'s penis has been\n s��allo��ed by #{active.name}'s cleavage!!"
        end
      when "�V�F���}�b�`"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} opens her legs to accept #{active.name}!"
        else
          text = "#{target.name} legs have been entangled ��ith #{active.name}!"
        end
      when "�h���E�l�N�^�["
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} opens up her slit ��ith her\n finger, happily accepting #{active.name}'s ��outh!"
        else
          text = "#{target.name}'s pussy is being sucked on\n by #{active.name}'s ��outh!"
        end
      when "�C���T�[�g�e�C��"
        text = "#{active.name} sticks her tail inside #{target.name}'s pussy!"
      when "�}�E�X�C���e�C��"
        text = "#{active.name} sticks her tail inside #{target.name}'s ��outh!"
      when "�o�b�N�C���e�C��"
        text = "#{active.name} sticks her tail up #{target.name}'s ass!"
      when "�f�B���h�C���T�[�g"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name} spreads her legs to receive #{active.name}!"
        else
          text = "#{active.name} pierces #{target.name}'s pussy!"
        end
      when "�f�B���h�C���}�E�X"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name}�͎�������J���A\n#{active.name}�̃f�B���h��������񂾁I"
        else
          text = "#{target.name}�̌��ɁA\n#{active.name}�̃f�B���h���˂����܂ꂽ�I"
        end
      when "�f�B���h�C���o�b�N"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name}�͎��炨�K���グ�A\n#{active.name}�̃f�B���h�̑}�����}�����ꂽ�I"
        else
          text = "#{target.name}�̋e���ɁA\n#{active.name}�̃f�B���h���˂������ꂽ�I"
        end
      when "�C���T�[�g�e���^�N��"
        text = "#{target.name}�̃A�\�R�ɁA\n#{active.name}�̑���G�肪�N�����Ă����I"
      when "�}�E�X�C���e���^�N��"
        text = "#{target.name}�̌��ɁA\n#{active.name}�̑���G�肪�N�����Ă����I"
      when "�o�b�N�C���e���^�N��"
        text = "#{target.name}�̋e���ɁA\n#{active.name}�̑���G�肪�N�����Ă����I"
      when "�A�C���B�N���[�Y","�f�����Y�N���[�Y"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name}�́A\n#{active.name}�̑���G��ɐg�������o�����I�I"
        else
          text = "#{target.name}�̐g�̂́A\n#{active.name}�̑���G��ɗ��ߎ���Ă��܂����I�I"
        end
      when "�f�����Y�A�u�\�[�u"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name}�͎�������ɂȂ�A\n#{active.name}�̑���G��̌����󂯓��ꂽ�I�I"
        else
          text = "#{target.name}�̃y�j�X�́A\n#{active.name}�̑���G��ə������Ă��܂����I�I"
        end
      when "�f�����Y�h���E"
        if $game_switches[89] == true #�L�����Z���L�[�Ŏ󂯓��ꂽ�ꍇ
          text = "#{target.name}�͎���w�ŃA�\�R���L���A�A\n#{active.name}�̑���G��̌����󂯓��ꂽ�I�I"
        else
          text = "#{target.name}�̃A�\�R�ɁA\n#{active.name}�̑���G�肪����t���Ă����I�I"
        end
      when "�C���T���g�c���["
        text = "#{active.name}�̑���G�肪������忂��ƁA\n#{target.name}�͌҂�傫���L�����p���ɂ���Ă��܂����I"
      end
    end
    $game_temp.battle_log_text += text + "\065\067"
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h�I�����e�L�X�g����
  #--------------------------------------------------------------------------
  def make_unhold_text(target)
    #�e�L�X�g�͂P�����ɂ��T�C�Y�R
    #�P�s�\�����E�͂Q�U�����Ȃ̂ŁA���O�̍��v���P�Q����(�T�C�Y36)���z����ꍇ�͉��s������
    text = []
    #���܂��^�[�Q�b�g�̐Ⓒ�`�ʂ�����
    if target == $game_actors[101]
      text.push("#{target.name}�͌��������Ղ��Ă���c�c�I")
      text.push("#{target.name}�͋ɓx�ɏ��Ղ��Ă���c�c�I") if target.ecstasy_count.size > 1 #���łɂQ�x�ȏ�Ⓒ���Ă���ꍇ
    else
      text.push("#{target.name}�͉����ɚb���ł���c�c�I")
    end
    #�����̌�A�z�[���h�Ώۂ̕`�ʂ�����
    if target.hold.penis.battler != nil
      holder = target.hold.penis.battler
      case target.hold.penis.type
      when "���}��"
        text.push("#{holder.name} releases his penis fro�� her vagina!")
      when "���}��"
        text.push("#{holder.name}'s ��outh releases his penis!")
      when "�K�}��"
        text.push("#{holder.name} released his penis fro�� her ass!")
      when "�p�C�Y��"
        text.push("#{holder.name} released his penis fro�� her cleavage!")
      end
    end
    if target.hold.vagina.battler != nil
      holder = target.hold.vagina.battler
      case target.hold.vagina.type
      when "���}��"
        item = target.hold.vagina.parts
        text.push("#{holder.name} pulled his penis out of her #{item}!")
      when "��ʋR��","�N���j"
        text.push("#{holder.name} pulls a��ay fro�� #{target.name}'s crotch!")
      when "�L���킹"
        text.push("#{holder.name} unt��ines her legs!")
      end
    end
    if target.hold.mouth.battler != nil
      holder = target.hold.mouth.battler
      case target.hold.mouth.type
      when "���}��"
        item = target.hold.mouth.parts
        text.push("#{holder.name} pulled his penis out of her #{item}!")
      when "��ʋR��","�K�R��","�ςӂς�"
        text.push("#{holder.name} releases #{target.name}!")
      when "�N���j","�L�b�X"
        text.push("#{holder.name} parts fro�� #{target.name}'s lips!")
      end
    end
    if target.hold.anal.battler != nil
      holder = target.hold.anal.battler
      case target.hold.anal.type
      when "�K�}��"
        text.push("#{holder.name} pulled his penis out of her #{item}!")
      when "�K�R��"
        text.push("#{holder.name} releases #{target.name}!")
      end
    end
    if target.hold.tops.battler != nil
      holder = target.hold.tops.battler
      case target.hold.tops.type
      when "�S��","�J�r","�ςӂς�"
        text.push("#{holder.name} lets go of #{target.name}!")
      end
    end
    if target.hold.tail.battler != nil
      holder = target.hold.tail.battler
      case target.hold.tail.type
      when "���}��","���}��","�K�}��"
        text.push("#{target.name} was released fro�� her tail's grasp!")
      end
    end
    if target.hold.tentacle.battler != nil
      holder = target.hold.tentacle.battler
      case target.hold.tentacle.type
      when "���}��","���}��","�K�}��"
        text.push("#{holder.name} releases her tentacle!")
      end
    end
    if target.hold.dildo.battler != nil
      holder = target.hold.dildo.battler
      brk = "�A\n" if SR_Util.names_over?(holder.name,target.name)
      case target.hold.dildo.type
      when "���}��","���}��","�K�}��"
        text.push("#{holder.name} releases her dildo!")
      end
    end
    a = ""
    a += text[0] if text[0] != nil
    a += "\n\066" if text[1] != nil
    a += text[1] if text[1] != nil
    a += "\n\066" if text[2] != nil
    a += text[2] if text[2] != nil
    a += "\n\066" if text[3] != nil
    a += text[3] if text[3] != nil
    $game_temp.battle_log_text += a + "\065\067"
  end
  #--------------------------------------------------------------------------
  # �� �������̃z�[���h�t�^�ɂ��C�j�V�A�`�u�ϓ�
  # owner : ��������o�g���[
  #--------------------------------------------------------------------------
  def hold_dancing_change(owner)
    # �p�[�c�����擾����
    owner_parts = owner.hold.parts_names
    # �e�p�[�c���ƂɊm�F
    for o_parts_one in owner_parts
      # �p�[�c����ϐ��ɓ����
      checking_parts = eval("owner.hold.#{o_parts_one}")
      # ���̃p�[�c����L���̏ꍇ
      if checking_parts.battler != nil
        initiative_zero_flag = false
        # �O�ȉ��Ŗ�����΃C�j�V�A�`�u������������
        if checking_parts.initiative > 0
          checking_parts.initiative = 0
          # ����ɂ��C�j�V�A�`�u���O�ɂȂ����ꍇ�A�t���O�𗧂Ă�
          initiative_zero_flag = true
        end
        #-----------------------------------------------------------------------------
        # ���C�j�V�A�`�u���O�ɂ��ꂽ���̕ϓ�
        if checking_parts.initiative == 0
          # �z�[���h�����ϐ��ɓ����
          hold_target = checking_parts.battler
          # �z�[���h���葤�̑Ή��p�[�c�z����m�F����
          target_parts_names = SR_Util.holding_parts_name(checking_parts.type, o_parts_one)
          # �Ή��p�[�c���ƂɃ`�F�b�N
          for t_parts_one in target_parts_names
            # �Ή��p�[�c����ϐ��ɓ����
            checking_target_parts = eval("hold_target.hold.#{t_parts_one}")
            # �t�]�\�ȃz�[���h�͑Ή��p�[�c�̃C�j�V�A�`�u���Q�ɂ܂ň����グ��
            if SR_Util.reversible_hold?(checking_target_parts.type)
              if checking_target_parts.initiative < 2
                checking_target_parts.initiative = 2
              end
            # �t�]�s�Ȃ��̂̓z�[���h������������
            else
              # �C�j�V�A�`�u���O�ɂ��ꂽ�i�D������򐨂ɂȂ����j���͉���
              if initiative_zero_flag
                checking_parts.clear
                checking_target_parts.clear
              # �C�j�V�A�`�u�����X�O�̎��i������򐨁j�̓C�j�V�A�`�u���Q�ɂ܂ň����グ��
              else
                if checking_target_parts.initiative < 2
                  checking_target_parts.initiative = 2
                end
              end
            end
          end
        end
        #-----------------------------------------------------------------------------
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �N���e�B�J�����ɂ��z�[���h�C�j�V�A�`�u����
  # owner : ��������o�g���[
  #--------------------------------------------------------------------------
  def hold_initiative_down(owner)
    # �p�[�c�����擾����
    owner_parts = owner.hold.parts_names
    # �e�p�[�c���ƂɊm�F
    for o_parts_one in owner_parts
      # �p�[�c����ϐ��ɓ����
      checking_parts = eval("owner.hold.#{o_parts_one}")
      # ���̃p�[�c����L���̏ꍇ
      if checking_parts.battler != nil
        initiative_zero_flag = false
        # �O�ȉ��Ŗ�����΃C�j�V�A�`�u������������
        if checking_parts.initiative > 0
          checking_parts.initiative -= 1
          # ����ɂ��C�j�V�A�`�u���O�ɂȂ����ꍇ�A�t���O�𗧂Ă�
          initiative_zero_flag = true if checking_parts.initiative == 0
        end
        #-----------------------------------------------------------------------------
        # �C�j�V�A�`�u���O�̑���ɑ΂������
        if checking_parts.initiative == 0
          # �z�[���h�����ϐ��ɓ����
          hold_target = checking_parts.battler
          # �z�[���h���葤�̑Ή��p�[�c�z����m�F����
          target_parts_names = SR_Util.holding_parts_name(checking_parts.type, o_parts_one)
          # �Ή��p�[�c���ƂɃ`�F�b�N
          for t_parts_one in target_parts_names
            # �Ή��p�[�c����ϐ��ɓ����
            checking_target_parts = eval("hold_target.hold.#{t_parts_one}")
            # ���t�]�\�ȃz�[���h
            # �Ή��p�[�c�̃C�j�V�A�`�u�����Z������
            if SR_Util.reversible_hold?(checking_target_parts.type)
              # �C�j�V�A�`�u���O�ɂ��ꂽ�i�D������򐨂ɂȂ����j���͂Q�܂ň����グ��
              if initiative_zero_flag
                if checking_target_parts.initiative < 2
                  checking_target_parts.initiative = 2
                end
              # �C�j�V�A�`�u�����X�O�̎��i������򐨁j�̓C�j�V�A�`�u�����Z������
              else
                if checking_target_parts.initiative < 3
                  checking_target_parts.initiative += 1
                end
              end
            # ���t�]�s�ȃz�[���h������������
            else
              # �C�j�V�A�`�u���O�ɂ��ꂽ�i�D������򐨂ɂȂ����j���͉���
              if initiative_zero_flag
                checking_parts.clear
                checking_target_parts.clear
              # �C�j�V�A�`�u�����X�O�̎��i������򐨁j�̓C�j�V�A�`�u�����Z������
              else
                if checking_target_parts.initiative < 3
                  checking_target_parts.initiative += 1
                end
              end
            end
          end
        end
        #-----------------------------------------------------------------------------
      end
    end
    
# �z�[���h�|�b�v�̎w���͂��������A
#���������ʂ�ꍇ������̂ł��̃��\�b�h��ʂ������ƂŎw��
=begin 
    # �z�[���h�|�b�v�̎w��
    hold_pops_order
=end

  end
  #--------------------------------------------------------------------------
  # �� �e�o�g���[�Ƀz�[���h�󋵂��L�^
  #--------------------------------------------------------------------------
  def hold_record
    for battler in $game_party.party_actors + $game_troop.enemies
      battler.hold_list = battler.hold.hold_output
    end
  end
  #--------------------------------------------------------------------------
  # �� ���������z�[���h�|�b�v���w��
  #--------------------------------------------------------------------------
  def hold_pops_order
    # �S���̃z�[���h�󋵂��m�F����
    for battler in $game_party.battle_actors + $game_troop.enemies
      # �O��ƌ��݂̃z�[���h�󋵂��o���B
      last_hold = battler.hold_list
      now_hold = battler.hold.hold_output
      # �O�̃z�[���h�󋵂ƈႤ�ꍇ�A�f�[�^��􂢏o���B
      if last_hold != now_hold
        # �ǉ����ꂽ�z�[���h�ƍ폜���ꂽ�z�[���h�̔���������
        add_hold = []
        delete_hold = []
        #----------------------------------------------------------------------
        # �ǉ������m�F
        #----------------------------------------------------------------------
        for now in now_hold
          # ���z�[���h�̑��݃t���O��������
          exist_flag = false
          for last in last_hold
            # ���z�[���h������������t���O�𗧂ĂďI��
            if now[0] == last[0] and now[2] == last[2]
              exist_flag = true
              break
            end
          end
          # �����z�[���h���Ȃ������ꍇ�A����͒ǉ����ꂽ���̂ł���B
          if exist_flag == false
            add_hold.push(now)
          end
        end
        # �^�C�v���d�����Ă�����̂�1�ɂ܂Ƃ߂�
        result_box = []
        for hold in add_hold
          overlap_flag = false
          for result in result_box
            if hold[0] == result[0] and hold[2] == result[2]
              overlap_flag = true
              break
            end
          end
          if overlap_flag == false
            result_box.push(hold)
          end
        end
        add_hold = result_box
        #----------------------------------------------------------------------
        # �폜�����m�F
        #----------------------------------------------------------------------
        for last in last_hold
          # ���z�[���h�̑��݃t���O��������
          exist_flag = false
          for now in now_hold
            # ���z�[���h������������t���O�𗧂ĂďI��
            if now[0] == last[0] and now[2] == last[2]
              exist_flag = true
              break
            end
          end
          # �����z�[���h���Ȃ������ꍇ�A����͍폜���ꂽ���̂ł���B
          if exist_flag == false
            delete_hold.push(last) 
          end
        end
        # �^�C�v���d�����Ă�����̂�1�ɂ܂Ƃ߂�
        result_box = []
        for hold in delete_hold
          overlap_flag = false
          for result in result_box
            if hold[0] == result[0] and hold[2] == result[2]
              overlap_flag = true
              break
            end
          end
          if overlap_flag == false
            result_box.push(hold)
          end
        end
        delete_hold = result_box
        #----------------------------------------------------------------------
        # �O��ƌ��݂̃C�j�V�A�`�u���m�F
        #----------------------------------------------------------------------
        last_initiative = 0
        for last in last_hold
          last_initiative = last[3] 
          break
        end
        now_initiative = 0
        for now in now_hold
          now_initiative = now[3] 
          break
        end
        #----------------------------------------------------------------------
        # �z�[���h�|�b�v�ւ̎w�����쐬
        #----------------------------------------------------------------------
        order = []
        for hold in add_hold
          order.push([1, hold[2], battler, hold[0]])
        end
        for hold in delete_hold
          order.push([2, hold[2], battler, hold[0]])
        end
        order.push([3, now_initiative])
        battler.hold_pop_order = order
      end
    end
  end
=begin
  #--------------------------------------------------------------------------
  # �� �z�[���h�L���s���؂�ւ�
  #--------------------------------------------------------------------------
  def hold_initiative(skill, active, target)
    #������
    #�O�F�z�[���h�ɐ��������ꍇ
    #�P�F�d�|�������A���肪�������z�[���h�̏ꍇ  ��  �d�|�������Ɏd�|�����z�[���h�̗L�������Q�ŕt��
    #�Q�F���肪���łɃz�[���h���̏ꍇ  ��  �d�|�������Ɏd�|�����z�[���h�̗L�������Q�ŁA
    #    ���̏�ő���̗L�����S�ď����āA����Ɏd�|���Ă���z�[���h�L�����S���ɂ����P���t��
    #��99�I�t(�_���[�W��A�^�b�N�ŕϓ�����ꍇ)
    #�P�F���肪�L���̏ꍇ�A�܂��S�Ă̗L�����P�i�K�ቺ������
    #�Q�F����̗L���̂����A�����O�ɂȂ����炻�̃z�[���h���Ă��鑊��Ɂ��P��t�^����
    #�R�F�������L���̏ꍇ�A�����Q�ȉ��������Ȃ灚���P�i�K�A�b�v������
    #-------------------------------------------------------------------------
    # ���z�[���h�X�L���ł͂Ȃ��A��ʃX�L���ɂ�����
    #-------------------------------------------------------------------------
    # ���p�^�[���R�F���肪�z�[���h���ŁA����ɃZ���V�����G�t�F�N�g�𔭐�������
    #-------------------------------------------------------------------------
    hd_text = ""
    if (target.critical or skill.element_set.include?(207)) and target.holding?
      #�ʓ|�ł��p�[�c���ƂɌʑΉ��B
      #����̃C�j�V�A�`�u���|�P����B�P�̎��Ɂ|�P�����ꍇ�A�C�j�V�A�`�u�����]����
      #���ɍU���Ώۂ̃C�j�V�A�`�u���O�̏ꍇ�A�z�[���h�ΏۂɁ{�P�i�ő�R�j����
      #���y�j�X����
      if target.hold.penis.battler != nil
        if target.hold.penis.initiative > 0
          target.hold.penis.initiative -= 1
        end
        if target.hold.penis.initiative == 0
          hold_target = target.hold.penis.battler
          case target.hold.penis.type
          when "���}��"
            hold_target.hold.vagina.initiative += 1 unless hold_target.hold.vagina.initiative > 2
          when "���}��"
            hold_target.hold.mouth.initiative += 1 unless hold_target.hold.mouth.initiative > 2
          when "�K�}��"
            hold_target.hold.anal.initiative += 1 unless hold_target.hold.anal.initiative > 2
          when "�p�C�Y��"
            hold_target.hold.tops.initiative += 1 unless hold_target.hold.tops.initiative > 2
          when "�G��z��"
            hold_target.hold.tentacle.initiative += 1 unless hold_target.hold.tentacle.initiative > 2
          end
        end
      end
      #��������
      if target.hold.mouth.battler != nil
        if target.hold.mouth.initiative > 0
          target.hold.mouth.initiative -= 1
        end
        if target.hold.mouth.initiative == 0
          hold_target = target.hold.mouth.battler
          case target.hold.mouth.type
          when "���}��"
            case target.hold.mouth.parts
            when "�y�j�X"
              hold_target.hold.penis.set(nil, nil, nil, nil)
              target.hold.mouth.set(nil, nil, nil, nil)
            when "�K��"
              hold_target.hold.tail.set(nil, nil, nil, nil)
              target.hold.mouth.set(nil, nil, nil, nil)
            when "�f�B���h"
              hold_target.hold.dildo.set(nil, nil, nil, nil)
              target.hold.mouth.set(nil, nil, nil, nil)
            when "�G��"
              hold_target.hold.tentacle.set(nil, nil, nil, nil)
              target.hold.mouth.set(nil, nil, nil, nil)
            end
          when "��ʋR��"
            hold_target.hold.vagina.initiative += 1 unless hold_target.hold.vagina.initiative > 2
          when "�K�R��"
            hold_target.hold.anal.initiative += 1 unless hold_target.hold.anal.initiative > 2
          when "�L�b�X"
            hold_target.hold.mouth.initiative += 1 unless hold_target.hold.mouth.initiative > 2
          when "�N���j"
            #�S���^�C�v�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.vagina.set(nil, nil, nil, nil)
            target.hold.mouth.set(nil, nil, nil, nil)
          end
        end
      end
      #���A�\�R����
      if target.hold.vagina.battler != nil
        if target.hold.vagina.initiative > 0
          target.hold.vagina.initiative -= 1
        end
        if target.hold.vagina.initiative == 0
          hold_target = target.hold.vagina.battler
          case target.hold.vagina.type
          when "���}��"
            case target.hold.vagina.parts
            when "�y�j�X"
              hold_target.hold.penis.initiative += 1 unless hold_target.hold.penis.initiative > 2
            when "�K��"
              hold_target.hold.tail.set(nil, nil, nil, nil)
              target.hold.vagina.set(nil, nil, nil, nil)
            when "�f�B���h"
              hold_target.hold.dildo.set(nil, nil, nil, nil)
              target.hold.vagina.set(nil, nil, nil, nil)
            when "�G��"
              hold_target.hold.tentacle.set(nil, nil, nil, nil)
              target.hold.vagina.set(nil, nil, nil, nil)
            end
          when "�L���킹"
            hold_target.hold.vagina.initiative += 1 unless hold_target.hold.vagina.initiative > 2
          when "��ʋR��"
            #�S���^�C�v�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.mouth.set(nil, nil, nil, nil)
            target.hold.vagina.set(nil, nil, nil, nil)
          end
        end
      end
      #���A�i������
      if target.hold.anal.battler != nil
        if target.hold.anal.initiative > 0
          target.hold.anal.initiative -= 1
        end
        if target.hold.anal.initiative == 0
          hold_target = target.hold.anal.battler
          case target.hold.anal.type
          when "�K�}��"
            case target.hold.anal.parts
            when "�y�j�X"
              hold_target.hold.penis.initiative += 1 unless hold_target.hold.penis.initiative > 2
            when "�K��"
              hold_target.hold.tail.set(nil, nil, nil, nil)
              target.hold.anal.set(nil, nil, nil, nil)
            when "�f�B���h"
              hold_target.hold.dildo.set(nil, nil, nil, nil)
              target.hold.anal.set(nil, nil, nil, nil)
            when "�G��"
              hold_target.hold.tentacle.set(nil, nil, nil, nil)
              target.hold.anal.set(nil, nil, nil, nil)
            end
          when "�K�R��"
            #�S���^�C�v�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target.hold.mouth.set(nil, nil, nil, nil)
            target.hold.anal.set(nil, nil, nil, nil)
          end
        end
      end
      #���㔼�g����
      if target.hold.tops.battler != nil
        hold_target = target.hold.tops.battler
        if target.hold.tops.initiative > 0
          target.hold.tops.initiative -= 1
          if target.hold.tops.initiative == 0
            #�㔼�g�̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target = target.hold.tops.battler
            hold_target.hold.tops.set(nil, nil, nil, nil)
            case target.hold.tops.parts
            when "�㔼�g" #�G���u���C�X
              target.hold.tops.set(nil, nil, nil, nil)
            when "��" #�w�u�����[�t�B�[��
              target.hold.mouth.set(nil, nil, nil, nil)
            when "�y�j�X" #�y���X�R�[�v
              target.hold.penis.set(nil, nil, nil, nil)
            when "�G��" #�y���X�R�[�v
              target.hold.tentacle.set(nil, nil, nil, nil)
            end
          end
        #���ɃC�j�V�A�`�u���O(�Ώۂ���S�����)�Ȃ瑊��Ɂ{�P����
        else
          case target.hold.tops.parts
          when "��"
            hold_target.hold.mouth.initiative += 1 unless hold_target.hold.mouth.initiative > 2
          when "�y�j�X"
            hold_target.hold.penis.initiative += 1 unless hold_target.hold.penis.initiative > 2
          when "�㔼�g"
            hold_target.hold.tops.initiative += 1 unless hold_target.hold.tops.initiative > 2
          end
        end
      end
      #���K������
      if target.hold.tail.battler != nil
        if target.hold.tail.initiative > 0
          target.hold.tail.initiative -= 1
          if target.hold.tail.initiative == 0
            #�K���}���̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target = target.hold.tail.battler
            case target.hold.tail.parts
            when "�A�\�R"
              hold_target.hold.vagina.set(nil, nil, nil, nil)
            when "��"
              hold_target.hold.mouth.set(nil, nil, nil, nil)
            when "�A�i��"
              hold_target.hold.anal.set(nil, nil, nil, nil)
            end
            target.hold.tail.set(nil, nil, nil, nil)
          end
        end
      end
      #���f�B���h����
      if target.hold.dildo.battler != nil
        if target.hold.dildo.initiative > 0
          target.hold.dildo.initiative -= 1
          if target.hold.dildo.initiative == 0
            #�f�B���h�}���̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target = target.hold.dildo.battler
            case target.hold.dildo.parts
            when "�A�\�R"
              hold_target.hold.vagina.set(nil, nil, nil, nil)
            when "��"
              hold_target.hold.mouth.set(nil, nil, nil, nil)
            when "�A�i��"
              hold_target.hold.anal.set(nil, nil, nil, nil)
            end
            target.hold.dildo.set(nil, nil, nil, nil)
          end
        end
      end
      #���G�蕔��
      if target.hold.tentacle.battler != nil
        if target.hold.tentacle.initiative > 0
          target.hold.tentacle.initiative -= 1
          if target.hold.tentacle.initiative == 0
            #�G��}���E�S���̓C�j�V�A�`�u���؂ꂽ�i�K�ŊO���
            hold_target = target.hold.tentacle.battler
            case target.hold.tentacle.parts
            when "�y�j�X"
              hold_target.hold.penis.set(nil, nil, nil, nil)
            when "�A�\�R"
              hold_target.hold.vagina.set(nil, nil, nil, nil)
            when "��"
              hold_target.hold.mouth.set(nil, nil, nil, nil)
            when "�A�i��"
              hold_target.hold.anal.set(nil, nil, nil, nil)
            when "�㔼�g"
              hold_target.hold.tops.set(nil, nil, nil, nil)
            end
            target.hold.tentacle.set(nil, nil, nil, nil)
          end
        end
      end
    end
    # �z�[���h�|�b�v�̎w��
    hold_pops_order
    # �̈ʃe�L�X�g
    $game_temp.battle_log_text += "\065\067" + hd_text if hd_text != ""
  end
=end

end