class Scene_Box
  #--------------------------------------------------------------------------
  # �� �t���[���X�V�@�X�e�[�^�X
  #--------------------------------------------------------------------------
  def update_status

    @center_window.update
    
    # �t�F�[�h�t���O�������Ă���ꍇ�̓t�F�[�h
    if @equip_fade_flag != 0
      equip_fade
      return
    end
    
    # ������ʒ��̏ꍇ�͂�����̃t���[���X�V���s��
    if @equip_time > 0
      update_equip
      return
    end

    case @status_command
    when 0
      update_status_status
    when 1
      update_status_skill
    when 2
      update_status_ability
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V�@�X�e�[�^�X
  #--------------------------------------------------------------------------
  def update_status_status
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # SE �����t
      Audio.se_play("Audio/SE/005-System05", 80, 100)
      @center_window.index = 0
      @center_window.help_window = @help_window
      @center_window.refresh
      @equip_fade_flag = 1
      @window[2].visible = true
      @center_window.active = true
      @overF_text = "E q u i p"
      status_refresh
      
      actor = @now_actor
      @equip_left_window = Window_EquipLeft.new(actor)
      @equip_item_window1 = Window_EquipItem.new(actor, 1)
      @equip_item_window2 = Window_EquipItem.new(actor, 4)
      @equip_item_window1.help_window = @help_window
      @equip_item_window2.help_window = @help_window
      equip_refresh
      return
    end

    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @center_window.visible = @window[2].visible = @help_window.visible = false
      @help_window.window.visible = false
      @fade_flag = 4
      @status_flag = false
      @left_window.visible = true
      @center_window.dispose
      @center_window1.dispose
      if @left_window.mode == 0
        @overF_text = "H o m e"
      else
        @overF_text = "P a r t y"
      end
      refresh
      return
    end
        
    # �E �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # �J�[�\�� SE �����t
      @left_window.index += 1
      if @left_window.index >= @left_window.item_max
         @left_window.index = 0
      end  
      $game_system.se_play($data_system.cursor_se)
      status_refresh
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::LEFT)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @left_window.index -= 1
      if @left_window.index < 0
        @left_window.index = @left_window.item_max - 1
      end  
      $game_system.se_play($data_system.cursor_se)
      status_refresh
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.dispose
      @center_window = Window_Ability.new(@now_actor)
      @center_window.index = 0
      @center_window.refresh
      @center_window.index = -1
      @center_window1.visible = true
      @overF_text = "A b i l i t y"
      status_refresh
      @status_command = 2
      return
    end

    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.dispose
      @center_window = Window_Skill.new(@now_actor, true)
      @center_window.index = 0
      @center_window.refresh
      @center_window.index = -1
      @center_window.active = false
      @center_window1.visible = true
      @overF_text = "S k i l l"
      status_refresh
      @status_command = 1
      return
    end

    
    
    
    
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V�@�X�e�[�^�X
  #--------------------------------------------------------------------------
  def update_status_skill
    
    if @center_window.active
      update_center_active
      return
    end

    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @center_window.index = 0
      @center_window.help_window = @help_window
      @center_window.refresh
      @center_window.active = true
      return
    end

    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @center_window.visible = @window[2].visible = @help_window.visible = false
      @help_window.window.visible = false
      @fade_flag = 4
      @status_flag = false
      @left_window.visible = true
      @center_window.dispose
      @center_window1.dispose
      if @left_window.mode == 0
        @overF_text = "H o m e"
      else
        @overF_text = "P a r t y"
      end
      refresh
      return
    end

    # �E �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # �J�[�\�� SE �����t
      @left_window.index += 1
      if @left_window.index >= @left_window.item_max
         @left_window.index = 0
      end  
      $game_system.se_play($data_system.cursor_se)
      status_refresh
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::LEFT)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @left_window.index -= 1
      if @left_window.index < 0
        @left_window.index = @left_window.item_max - 1
      end  
      $game_system.se_play($data_system.cursor_se)
      status_refresh
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.dispose
      @center_window = Window_Status.new(@now_actor)
      @center_window.index = -2
      @center_window1.visible = false
      @overF_text = "S t a t u s"
      status_refresh
      @status_command = 0
      return
    end

    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.dispose
      @center_window = Window_Ability.new(@now_actor)
      @center_window.index = 0
      @center_window.refresh
      @center_window.index = -1
      @center_window.active = false
      @overF_text = "A b i l i t y"
      status_refresh
      @status_command = 2
      return
    end

    
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V�@�X�e�[�^�X
  #--------------------------------------------------------------------------
  def update_status_ability
    
    if @center_window.active
      update_center_active
      return
    end
    
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @center_window.index = 0
      @center_window.help_window = @help_window
      @center_window.refresh
      @center_window.active = true
      return
    end

    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @center_window.visible = @window[2].visible = @help_window.visible = false
      @help_window.window.visible = false
      @fade_flag = 4
      @status_flag = false
      @left_window.visible = true
      @center_window.dispose
      @center_window1.dispose
      if @left_window.mode == 0
        @overF_text = "H o m e"
      else
        @overF_text = "P a r t y"
      end
      refresh
      return
    end
    # �E �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # �J�[�\�� SE �����t
      @left_window.index += 1
      if @left_window.index >= @left_window.item_max
         @left_window.index = 0
      end  
      $game_system.se_play($data_system.cursor_se)
      status_refresh
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::LEFT)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @left_window.index -= 1
      if @left_window.index < 0
        @left_window.index = @left_window.item_max - 1
      end  
      $game_system.se_play($data_system.cursor_se)
      status_refresh
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.dispose
      @center_window = Window_Skill.new(@now_actor, true)
      @center_window.index = 0
      @center_window.refresh
      @center_window.index = -1
      @center_window.active = false
      @overF_text = "S k i l l"
      status_refresh
      @status_command = 1
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.dispose
      @center_window = Window_Status.new(@now_actor)
      @center_window.index = -2
      @center_window1.visible = false
      @overF_text = "S t a t u s"
      status_refresh
      @status_command = 0
      return
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V : �����o�[�X�e�[�^�X���
  #--------------------------------------------------------------------------
  def update_center_active
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # �u�U�[ SE �����t
      $game_system.se_play($data_system.buzzer_se)
      return
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @center_window.help_window = nil
      @center_window.active = false
      @center_window.index = -1
      @center_window.refresh
      status_refresh
      return
    end
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V���@�X�e�[�^�X
  #--------------------------------------------------------------------------
  def status_refresh
    
    case @left_window.mode
    when 0
      @box_temp = [@left_window.actor_data, @left_window.index]
      if @now_actor != @box_temp[0]
        @now_actor = @right_window.actor = @box_temp[0]
      end
    when 1
      @party_temp = [@left_window.actor_data, @left_window.index]
      if @now_actor != @party_temp[0]
        @now_actor = @right_window.actor = @party_temp[0]
      end
    end
    @center_window.actor = @now_actor
    @center_window.refresh
    if @center_window1 != nil
      @center_window1.actor = @now_actor
      @center_window1.refresh
    end
    graphic_refresh
    
    @overF[1].bitmap.clear
    @overF[1].bitmap.draw_text(375, 0, 200, 32, @overF_text, 1)
    case @overF_text
    when "S t a t u s"
      text = "����F�����ύX�E���[������@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
    when "A b i l i t y"
      text = "����F�f���m�F�@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
    when "S k i l l"
      text = "����F�X�L���m�F�@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
    when "E q u i p"
      text = "����F�X�L���m�F�@�����F�\�������o�[�ύX"
    end
    @help_window.set_text(text, 1)
  end


end