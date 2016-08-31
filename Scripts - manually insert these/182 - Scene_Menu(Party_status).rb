#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Menu
  #--------------------------------------------------------------------------
  # �� �t���[���X�V : �����o�[�X�e�[�^�X���
  #--------------------------------------------------------------------------
  def update_party
    
    @center_window.update

    
    case @party_command
    
    when 0
      update_party_status
    when 1
      update_party_ability
    when 2
      update_party_skill
    end
    
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V : �����o�[�X�e�[�^�X���
  #--------------------------------------------------------------------------
  def update_party_status
    
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
      # SE �����t
      Audio.se_play("Audio/SE/005-System05", 80, 100)
      @center_window.index = 0
      @center_window.help_window = @help_window
      @center_window.refresh
      @equip_fade_flag = 1
      @window[1].visible = true
      @center_window.active = true
      
      actor = $game_party.actors[@select_index]
      @equip_left_window = Window_EquipLeft.new(actor)
      @equip_item_window1 = Window_EquipItem.new(actor, 1)
      @equip_item_window2 = Window_EquipItem.new(actor, 4)
      @equip_item_window1.help_window = @help_window
      @equip_item_window2.help_window = @help_window
      equip_refresh
      @overF_text = "E q u i p"
      
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
      @center_window.refresh
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
      @center_window.refresh
      @actor_graphic.x = 320
      @actor_graphic.y = 240
      @actor_graphic.y += 60 if actor.boss_graphic?
      @actor_graphic.bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
      @actor_graphic.ox = @actor_graphic.bitmap.width / 2
      @actor_graphic.oy = @actor_graphic.bitmap.height / 2
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      actor = $game_party.actors[@select_index]
      @center_window.dispose
      @center_window = Window_Ability.new(actor)
      @center_window.index = 0
      @center_window.refresh
      @center_window.index = -1
      @center_window.refresh
      @center_window1 = Window_SkillStatus.new(actor)
      @overF_text = "T r a i t s"
      text = "ENTER: Examine Traits�@�����FCycle Party Member�@�����FChange Window"
      @help_window.set_text(text, 1)
      @party_command = 1
      return
    end

    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
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
      @center_window1 = Window_SkillStatus.new(actor)
      @overF_text = "S k i l l s"
      text = "ENTER: Examine Skills�@�����FCycle Party Member�@�����FChange Window"
      @help_window.set_text(text, 1)
      @party_command = 2
      return
    end

    
  end
end