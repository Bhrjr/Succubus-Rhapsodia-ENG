#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Menu
  #--------------------------------------------------------------------------
  # �� �t���[���X�V : �����o�[�X�e�[�^�X���
  #--------------------------------------------------------------------------
  def update_party_ability
    
    # �f���E�B���h�E���A�N�e�B�u�̏ꍇ: update_target ���Ă�
    if @center_window.active
      update_ability_active
      return
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �p�[�e�B�Z���N�g�ɖ߂�
      @command = 0
      @fade_flag = 5
      @select.visible = false
      
      @window[0].y = 100
      @window[0].visible = false
      
      @center_window.dispose
      @center_window1.dispose
      @actor_graphic.bitmap = nil
      n = 30
      @help_window.visible = false
      @help_window.y = n
      @help_window.window.visible = false
      @help_window.window.y = n
      @overF_text = $game_party.gold.to_s + "�@" + $data_system.words.gold
      center_refresh      

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
    
    # �E �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # �J�[�\�� SE �����t
      @select_index += 1
      if @select_index > $game_party.actors.size - 1
        @select_index = 0
      end  
      $game_system.se_play($data_system.cursor_se)
      actor = $game_party.actors[@select_index]
      @center_window.actor = actor
      @center_window.index = 0
      @center_window.refresh
      @center_window.index = -1
      @center_window.refresh
      @center_window1.actor = actor
      @center_window1.refresh
      @actor_graphic.x = 320
      @actor_graphic.y = 240
      @actor_graphic.y += 60 if actor.boss_graphic?
      @actor_graphic.bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
      @actor_graphic.ox = @actor_graphic.bitmap.width / 2
      @actor_graphic.oy = @actor_graphic.bitmap.height / 2
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::LEFT)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @select_index -= 1
      if @select_index < 0
        @select_index = $game_party.actors.size - 1
      end  
      $game_system.se_play($data_system.cursor_se)
      actor = $game_party.actors[@select_index]
      @center_window.actor = actor
      @center_window.index = 0
      @center_window.refresh
      @center_window.index = -1
      @center_window.refresh
      @center_window1.actor = actor
      @center_window1.refresh
      @actor_graphic.x = 320
      @actor_graphic.y = 240
      @actor_graphic.y += 60 if actor.boss_graphic?
      @actor_graphic.bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
      @actor_graphic.ox = @actor_graphic.bitmap.width / 2
      @actor_graphic.oy = @actor_graphic.bitmap.height / 2
      return
    end
    
     
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)

      actor = $game_party.actors[@select_index]
      
      @center_window.dispose
      @center_window = Window_Status.new(actor)
      @center_window.index = -2
      @center_window.refresh
      @center_window1.dispose
      @overF_text = "S t a t u s"
      text = "ENTER: Examine Equipment/Runes�@�����FCycle Party Member�@�����FChange Window"
      @help_window.set_text(text, 1)
      @party_command = 0
      return
    end

    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      actor = $game_party.actors[@select_index]
      @center_window.dispose
      @center_window = Window_Skill.new(actor)
      @center_window.index = 0
      @center_window.refresh
      @center_window.index = -1
      @center_window.active = false
      @center_window.refresh
      @overF_text = "S k i l l s"
      text = "ENTER: Examine Skills�@�����FCycle Party Member�@�����FChange Window"
      @help_window.set_text(text, 1)
      @party_command = 2
      return
    end
    
    
  end
  
  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V : �����o�[�X�e�[�^�X���
  #--------------------------------------------------------------------------
  def update_ability_active

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
      text = "ENTER: Examine Traits�@�����FCycle Party Member�@�����FChange Window"
      @help_window.set_text(text, 1)
      return
    end
    
  end
  
end