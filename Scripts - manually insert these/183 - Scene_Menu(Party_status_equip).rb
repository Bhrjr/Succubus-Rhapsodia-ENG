#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Menu
  #--------------------------------------------------------------------------
  # �� �t���[���X�V : ���ݑ�����
  #--------------------------------------------------------------------------
  def update_equip
    
    
    equip_refresh
    @equip_left_window.update
    @equip_item_window.update
    

    # ������ʒ��̏ꍇ�͂�����̃t���[���X�V���s��
    if @equip_time == 2
      update_equip_time
      return
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # SE �����t
      Audio.se_play("Audio/SE/005-System05", 80, 100)
      @center_window.active = false
      @equip_fade_flag = 2
      @window[1].visible = true
      @center_window.index = -2
      @center_window.help_window = nil
      text = "ENTER: Examine Equipment/Runes�@�����FCycle Party Member�@�����FChange Window"
      @help_window.set_text(text, 1)
      @center_window.refresh
      @overF_text = "S t a t u s"
      return
    end
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @equip_time = 2
      @center_window.active = false
      @equip_item_window.index = 0
      @equip_item_window.active = true
      return
    end
    
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.index += 1
      if @center_window.index > $data_SDB[$game_party.actors[@select_index].class_id].maxrune
        @center_window.index = 0
      end
      @center_window.refresh
      return
    end
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @center_window.index -= 1
      if @center_window.index < 0
        @center_window.index = $data_SDB[$game_party.actors[@select_index].class_id].maxrune
      end
      @center_window.refresh
      return
    end
    
    # �E �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @select_index += 1
      if @select_index > $game_party.actors.size - 1
        @select_index = 0
      end  
      actor = $game_party.actors[@select_index]
      @center_window.actor = actor
      @center_window.index = 0
      @center_window.refresh
      
      actor = $game_party.actors[@select_index]
      @equip_left_window.actor = actor
      @equip_item_window1.actor = actor
      @equip_item_window2.actor = actor
      @equip_left_window.refresh
      @equip_item_window1.refresh
      @equip_item_window2.refresh

      @actor_graphic.x = 320
      @actor_graphic.y = 240
      @actor_graphic.y += 60 if actor.boss_graphic?
      @actor_graphic.bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
      @actor_graphic.ox = @actor_graphic.bitmap.width / 2
      @actor_graphic.oy = @actor_graphic.bitmap.height / 2
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
      
      actor = $game_party.actors[@select_index]
      @equip_left_window.actor = actor
      @equip_item_window1.actor = actor
      @equip_item_window2.actor = actor
      @equip_left_window.refresh
      @equip_item_window1.refresh
      @equip_item_window2.refresh

      @actor_graphic.x = 320
      @actor_graphic.y = 240
      @actor_graphic.y += 60 if actor.boss_graphic?
      @actor_graphic.bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
      @actor_graphic.ox = @actor_graphic.bitmap.width / 2
      @actor_graphic.oy = @actor_graphic.bitmap.height / 2
    end
  end

  #--------------------------------------------------------------------------
  # �� �����ύX���F�A�C�e�����@
  #--------------------------------------------------------------------------
  def update_equip_time
    
    # �R�}���h�J�n
    if $game_temp.script_message_index != 99
      # ���[���̍�������Ă������ł����H
      case $game_temp.script_message_index
      when 0 # ������
        if $game_temp.script_message_cancel == false
          $game_system.se_play($data_system.decision_se) 
        end
      when 1 # �͂�
        item = @equip_item_window.item
        # SE �����t
        Audio.se_play("Audio/SE/046-Book01", 80, 100)
        # ������ύX
        $game_party.actors[@select_index].equip(@center_window.index + 1, item == nil ? 0 : item.id, 1)
        # ���C�g�E�B���h�E���A�N�e�B�u��
        @center_window.active = true
        @equip_item_window.active = false
        @equip_item_window.index = -1
        # ���C�g�E�B���h�E�A�A�C�e���E�B���h�E�̓��e���č쐬
        @center_window.refresh
        @equip_item_window.refresh
        @equip_time = 1
      end
      $game_temp.script_message_index = 99
      return
    end

    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)

      # �A�C�e���E�B���h�E�Ō��ݑI������Ă���f�[�^���擾
      item = @equip_item_window.item
      
      if item == nil and $game_party.actors[@select_index].armor_id[@center_window.index + 1] == 0
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end

      if @center_window.index != 0
        if item != nil
          text = "���[���͈�x���󂵂Ă��܂��ƍė��p���鎖���ł��܂���B\n���󂵂܂����H"
          text += "\n��߂�\n���󂷂�"
          $game_temp.choice_start = 2
        else
          text = "���󂵂Ă��郋�[����j�����Ă��܂��܂����H"
          text += "\n��߂�\n�j������"
          $game_temp.choice_start = 1
        end
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se) 
        $game_temp.message_text = text
        $game_temp.choice_max = 2
        $game_temp.choice_cancel_type = 1
        # ���b�Z�[�W�\�����t���O�𗧂Ă�
        $game_temp.message_window_showing = true
        $game_temp.script_message = true
        return
      end
      
      # ���� SE �����t
      $game_system.se_play($data_system.equip_se)
      # ������ύX
      $game_party.actors[@select_index].equip(@center_window.index + 1, item == nil ? 0 : item.id)
      # ���C�g�E�B���h�E���A�N�e�B�u��
      @center_window.active = true
      @equip_item_window.active = false
      @equip_item_window.index = -1
      # ���C�g�E�B���h�E�A�A�C�e���E�B���h�E�̓��e���č쐬
      @center_window.refresh
      @equip_item_window.refresh
      @equip_time = 1
      return
    end

    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @equip_time = 1
      @center_window.active = true
      @equip_item_window.active = false
      @equip_item_window.index = -1

      return
    end
  end

  #--------------------------------------------------------------------------
  # �� �����ύX���F�A�C�e�����@
  #--------------------------------------------------------------------------
  def equip_refresh
    
    actor = $game_party.actors[@select_index]

    # �A�C�e���E�B���h�E�̉���Ԑݒ�
    @equip_item_window1.visible = (@center_window.index == 0)
    @equip_item_window2.visible = (@center_window.index != 0)

    # ���ݑ������̃A�C�e�����擾
    item1 = @center_window.item
    
    # ���݂̃A�C�e���E�B���h�E�� @equip_item_window �ɐݒ�
    if @center_window.index == 0
      @equip_item_window = @equip_item_window1
    else
      @equip_item_window = @equip_item_window2
    end
    # ���C�g�E�B���h�E���A�N�e�B�u�̏ꍇ
    if @center_window.active
      # �����ύX��̃p�����[�^������
      @equip_left_window.set_new_parameters(nil, nil, nil)
    end
    # �A�C�e���E�B���h�E���A�N�e�B�u�̏ꍇ
    if @equip_item_window.active
      # ���ݑI�𒆂̃A�C�e�����擾
      item2 = @equip_item_window.item
      # ������ύX
      last_hp = actor.hp
      last_sp = actor.sp
      actor.equip(@center_window.index + 1, item2 == nil ? 0 : item2.id)
      if $imported["EquipExtension"]
        for i in (actor.two_swords? ? actor.ts_number : 1)...actor.equip_type.size
          actor.update_auto_state(nil, $data_armors[actor.armor_id[i]])
        end
      else
        for i in 1..4
          actor.update_auto_state(nil, $data_armors[eval("actor.armor#{i}_id")])
        end
      end      # �����ύX��̃p�����[�^���擾
      new_atk = actor.atk
      new_pdef = actor.pdef
      new_mdef = actor.mdef
      if $imported["EquipAlter"]
        new_st = [actor.str, actor.dex, actor.agi, actor.int]
      end

      # ������߂�
      actor.equip(@center_window.index + 1, item1 == nil ? 0 : item1.id)
      actor.hp = last_hp
      actor.sp = last_sp
      # ���t�g�E�B���h�E�ɕ`��
      if $imported["EquipAlter"]
        @equip_left_window.set_new_parameters(new_atk, new_pdef, new_mdef, new_st)
      else
        @equip_left_window.set_new_parameters(new_atk, new_pdef, new_mdef)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� ������ʗp�t�F�[�h
  #--------------------------------------------------------------------------
  def equip_fade
    
    n = 10
    case @equip_fade_flag
    when 1 #�o��
      @window[0].x -= 400 / n
      @center_window.x -= 320 / n
      @window[1].x -= 400 / n
      @equip_left_window.x -= 400 / n
      @equip_item_window1.x -= 400 / n
      @equip_item_window2.x -= 400 / n
      # ���ׂĊ���������t�F�[�h���I������B
      if @window[0].x == -400
        @equip_fade_flag = 0
        @equip_time = 1
      end
      return
    when 2 #����    
      @window[0].x += 400 / n
      @center_window.x += 320 / n
      @window[1].x += 400 / n
      @equip_left_window.x += 400 / n
      @equip_item_window1.x += 400 / n
      @equip_item_window2.x += 400 / n
      # ���ׂĊ���������t�F�[�h���I������B
      if @window[0].x == 0
        @equip_fade_flag = 0
        @window[1].visible = false
        @equip_time = 0
        @equip_left_window.dispose
        @equip_item_window1.dispose
        @equip_item_window2.dispose
      end
      return
    end
   
  end
  
end