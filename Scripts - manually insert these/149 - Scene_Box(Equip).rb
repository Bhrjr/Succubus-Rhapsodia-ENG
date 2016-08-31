#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Box
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
      text = "ENTER: Equipment/Runes�@�����FParty member�@�����FNext window"
      @help_window.set_text(text, 1)
      @center_window.refresh
      @overF_text = "S t a t u s"
      status_refresh
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
      if @center_window.index > $data_SDB[@now_actor.class_id].maxrune
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
        @center_window.index = $data_SDB[@now_actor.class_id].maxrune
      end
      @center_window.refresh
      return
    end
    
    # �E �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # �J�[�\�� SE �����t
      @left_window.index += 1
      if @left_window.index >= @left_window.item_max
         @left_window.index = 0
      end  
      status_refresh
      $game_system.se_play($data_system.cursor_se)
      actor = @now_actor
      @center_window.actor = actor
      @center_window.index = 0
      @center_window.refresh
      @equip_left_window.actor = actor
      @equip_item_window1.actor = actor
      @equip_item_window2.actor = actor
      @equip_left_window.refresh
      @equip_item_window1.refresh
      @equip_item_window2.refresh
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
      status_refresh
      $game_system.se_play($data_system.cursor_se)
      actor = @now_actor
      @center_window.actor = actor
      @center_window.index = 0
      @center_window.refresh
      @equip_left_window.actor = actor
      @equip_item_window1.actor = actor
      @equip_item_window2.actor = actor
      @equip_left_window.refresh
      @equip_item_window1.refresh
      @equip_item_window2.refresh
      return
    end
  end

  #--------------------------------------------------------------------------
  # �� �����ύX���F�A�C�e�����@
  #--------------------------------------------------------------------------
  def update_equip_time
    


    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)

      # �A�C�e���E�B���h�E�Ō��ݑI������Ă���f�[�^���擾
      item = @equip_item_window.item
      
      if item == nil and @now_actor.armor_id[@center_window.index + 1] == 0
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end

      if @center_window.index != 0
        if item != nil
          text = "Once the rune is branded on, you won't be able to reuse it.\n Continue?"
          text += "\nNevermind\nBrand Rune"
          $game_temp.choice_start = 2
        else
          text = "Stop branding?"
          text += "\nNo\nStop"
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
        @select_type = "���[������"
        return
      end
      
      # ���� SE �����t
      $game_system.se_play($data_system.equip_se)
      # ������ύX
      @now_actor.equip(@center_window.index + 1, item == nil ? 0 : item.id)
      if $imported["EquipExtension"]
        for i in (@now_actor.two_swords? ? @now_actor.ts_number : 1)...@now_actor.equip_type.size
          @now_actor.update_auto_state(nil, $data_armors[@now_actor.armor_id[i]])
        end
      else
        for i in 1..4
          @now_actor.update_auto_state(nil, $data_armors[eval("@now_actor.armor#{i}_id")])
        end
      end      # ���C�g�E�B���h�E���A�N�e�B�u��
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
    
    actor = @now_actor

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
      # �����ύX��̃p�����[�^���擾
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
      @window[2].x -= 400 / n
      @center_window.x -= 320 / n
      @window[3].x -= 400 / n
      @equip_left_window.x -= 400 / n
      @equip_item_window1.x -= 400 / n
      @equip_item_window2.x -= 400 / n
      # ���ׂĊ���������t�F�[�h���I������B
      if @window[2].x == -400
        @equip_fade_flag = 0
        @equip_time = 1
      end
      return
    when 2 #����    
      @window[2].x += 400 / n
      @center_window.x += 320 / n
      @window[3].x += 400 / n
      @equip_left_window.x += 400 / n
      @equip_item_window1.x += 400 / n
      @equip_item_window2.x += 400 / n
      # ���ׂĊ���������t�F�[�h���I������B
      if @window[2].x == 0
        @equip_fade_flag = 0
        @equip_time = 0
        @equip_left_window.dispose
        @equip_item_window1.dispose
        @equip_item_window2.dispose
      end
      return
    end
   
  end
  
end