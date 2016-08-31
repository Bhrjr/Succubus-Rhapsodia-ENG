#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Menu
  #--------------------------------------------------------------------------
  # �� �t���[���X�V�i�V�X�e���j
  #--------------------------------------------------------------------------
  def update_system
    @center_window.update
    # �R�}���h�J�n
    if $game_temp.script_message_index != 99
      case $game_temp.script_message_index
      when 0 # ��߂�
        if $game_temp.script_message_cancel == false
          $game_system.se_play($data_system.decision_se) 
        end
        $game_temp.script_message_index = 99
      when 1 # �^�C�g���֖߂�
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        @center_window.dispose
        @fade_flag = 6
        # BGM�ABGS�AME ���t�F�[�h�A�E�g
        Audio.bgm_fade(800)
        Audio.bgs_fade(800)
        Audio.me_fade(800)
        # �^�C�g����ʂɐ؂�ւ�
        $scene = Scene_Title.new
        
        
      when 2 # �V���b�g�_�E��
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        @center_window.dispose
        @fade_flag = 6
        # BGM�ABGS�AME ���t�F�[�h�A�E�g
        Audio.bgm_fade(800)
        Audio.bgs_fade(800)
        Audio.me_fade(800)
        # �V���b�g�_�E��
        $scene = nil
      end
      return
    end


    
    
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
=begin
      #���b�Z�[�W�\�����x���Đݒ�
      #�ϐ�45�F�V�X�e���E�F�C�g(�t�F�C�Y�̍��Ԃ̃E�F�C�g)
      #�ϐ�46�F���b�Z�[�W�E�F�C�g(\m��\w�̊�l)
      #�ϐ�47�F�I�[�g���[�h���x(�e���b�v���̂ݗL��)
      case $game_system.system_battle_speed
      when 0
        $game_variables[45] = 60
        $game_variables[46] = 5
        $game_variables[47] = 60
      when 1
        $game_variables[45] = 30
        $game_variables[46] = 3
        $game_variables[47] = 40
      when 2
        $game_variables[45] = 16
        $game_variables[46] = 1
        $game_variables[47] = 28
      end
=end
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �㕔�e�L�X�g��߂�
      @overF_text = $game_party.gold.to_s + "�@" + $data_system.words.gold
      @help_window.visible = false
      @help_window.window.visible = false
      @item_window.visible = false
      @window[0].visible = false
      @center_window.dispose
      # ���j���[�ɖ߂�
      @command = 0
      @fade_flag = 5
    end

    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      if @center_window.index == 13
        # ���� SE �����t
        $keybd = Win32API.new 'user32.dll', 'keybd_event', ['i', 'i', 'l', 'l'], 'v'
        $keybd.call 0xA4, 0, 0, 0
        $keybd.call 13, 0, 0, 0
        $keybd.call 13, 0, 2, 0
        $keybd.call 0xA4, 0, 2, 0
        return
      elsif @center_window.index == 14
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        
        text = "Quit game?"
        text += "\nCancel\nBack to Title\nShutdown"
        $game_temp.choice_start = 1
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se) 
        $game_temp.message_text = text
        $game_temp.choice_max = 3
        $game_temp.choice_cancel_type = 1
        # ���b�Z�[�W�\�����t���O�𗧂Ă�
        $game_temp.message_window_showing = true
        $game_temp.script_message = true
        return
      end
      # �u�U�[ SE �����t
      $game_system.se_play($data_system.buzzer_se)
      return
    end
    
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.index += 1
      @center_window.index = 0 if @center_window.index > @center_window.max - 1
      @center_window.refresh
      @center_window.index += 1 if @center_window.index == 0 or @center_window.index == 5 or @center_window.index == 12
      @center_window.refresh
      return
    end

    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.index -= 1
      @center_window.index = @center_window.max - 1 if @center_window.index <= 0
      @center_window.refresh
      @center_window.index -= 1 if @center_window.index == 5 or @center_window.index == 12
      @center_window.refresh
      return
    end

    # �E �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      case @center_window.index
      when 1 # �_�b�V���ύX�̎�
        if $game_system.system_dash == false
          $game_system.system_dash = true
        else
          $game_system.system_dash = false
        end
      when 2 # ���̌���C�x���g
        if $game_system.system_present == false
          $game_system.system_present = true
        else
          $game_system.system_present = false
        end
      when 3 # �|�[�g�ݒ�
        if $game_switches[33] == false
          $game_switches[33] = true
        else
          $game_switches[33] = false
        end
      when 4 # �󕠓x�ύX
        $game_system.system_fed += 1
        $game_system.system_fed = 0 if $game_system.system_fed > 2
      when 6 # �o�g�����x
        $game_system.system_battle_speed += 1
        $game_system.system_battle_speed = 0 if $game_system.system_battle_speed > 2
      when 7 # ���b�Z�[�W���[�h
        $game_system.system_read_mode += 1
        $game_system.system_read_mode = 0 if $game_system.system_read_mode > 2
      when 8 # ���W�X�g����
        $game_system.system_regist += 1
        $game_system.system_regist = 0 if $game_system.system_regist > 3
      when 9 # ���t�O���t�B�b�N
        if $game_system.system_sperm == false
          $game_system.system_sperm = true
        else
          $game_system.system_sperm = false
        end
      when 10 # �J�[�\���ʒu�L��
        if $game_system.system_arrow == false
          $game_system.system_arrow = true
        else
          $game_system.system_arrow = false
        end
      when 11 # �G���e�B�b�N���b�Z�[�W
        $game_system.system_message += 1
        $game_system.system_message = 0 if $game_system.system_message > 2
        #�ڍ�
        $game_switches[95] = ($game_system.system_message == 2)
        #�Ȉ�
        $game_switches[96] = ($game_system.system_message == 0)
#      when 12 # ��ʐ؂�ւ�
#        if $game_system.system_fullscreen == false
#          $game_system.system_fullscreen = true
#          $data_config.setLine(2, "full")
#          $data_config.save()
#          @f_screen2 = 1
#          $full_method = true
#        else
#          $game_system.system_fullscreen = false
#          $data_config.setLine(2, "window")
#          $data_config.save()
#          @f_screen2 = 0
#          $full_method = false
#        end
      end
      @center_window.refresh
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::LEFT)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      case @center_window.index
      when 1 # �_�b�V���ύX�̎�
        if $game_system.system_dash == false
          $game_system.system_dash = true
        else
          $game_system.system_dash = false
        end
      when 2 # ���̌���C�x���g
        if $game_system.system_present == false
          $game_system.system_present = true
        else
          $game_system.system_present = false
        end
      when 3 # �|�[�g�ݒ�
        if $game_switches[33] == false
          $game_switches[33] = true
        else
          $game_switches[33] = false
        end
      when 4 # �󕠓x�ύX
        $game_system.system_fed -= 1
        $game_system.system_fed = 2 if $game_system.system_fed < 0
      when 6 # �o�g�����x
        $game_system.system_battle_speed -= 1
        $game_system.system_battle_speed = 2 if $game_system.system_battle_speed < 0
      when 7 # ���b�Z�[�W�X�s�[�h
        $game_system.system_read_mode -= 1
        $game_system.system_read_mode = 2 if $game_system.system_read_mode < 0
      when 8 # ���W�X�g����
        $game_system.system_regist -= 1
        $game_system.system_regist = 3 if $game_system.system_regist < 0
      when 9 # ���t�O���t�B�b�N
        if $game_system.system_sperm == false
          $game_system.system_sperm = true
        else
          $game_system.system_sperm = false
        end
      when 10 # �J�[�\���ʒu�L��
        if $game_system.system_arrow == false
          $game_system.system_arrow = true
        else
          $game_system.system_arrow = false
        end
      when 11 # �G���e�B�b�N���b�Z�[�W
        $game_system.system_message -= 1
        $game_system.system_message = 2 if $game_system.system_message < 0
        #�ڍ�
        $game_switches[95] = ($game_system.system_message == 2)
        #�Ȉ�
        $game_switches[96] = ($game_system.system_message == 0)
#      when 12 # ��ʐ؂�ւ�
#        if $game_system.system_fullscreen == false
#          $game_system.system_fullscreen = true
#          $data_config.setLine(2, "full")
#          $data_config.save()
#          @f_screen2 = 1
#          $full_method = true
#          p @f_screen2
#        else
#          $game_system.system_fullscreen = false
#          $data_config.setLine(2, "window")
#          $data_config.save()
#          @f_screen2 = 0
#          $full_method = false
#        end
      end
      @center_window.refresh
      return
    end
    
  end
  #--------------------------------------------------------------------------
  # �� �ݒ�ύX
  #--------------------------------------------------------------------------
  def system_change
    
    
  end
end
