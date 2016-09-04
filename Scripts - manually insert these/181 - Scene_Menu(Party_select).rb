#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Menu
  #--------------------------------------------------------------------------
  # �� �t���[���X�V : �p�[�e�B�I��
  #--------------------------------------------------------------------------
  def update_actor_select
    
    if @party_change_flag
      update_party_select_change
      return
    end
    
    if @menu_party_command_window[0].visible or @menu_party_command_window[1].visible
      update_party_select_command
      return
    end
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @select_blink_flag = false
      @select_blink_check = true
      @select.opacity = 255
      
      if $game_party.actors[@select_index] == $game_actors[101]
        @menu_party_command_window[0].visible = true
        @menu_party_command_window[0].active = true
        @menu_party_command_window[0].index = 0
      else
        @menu_party_command_window[1].visible = true
        @menu_party_command_window[1].active = true
        @menu_party_command_window[1].index = 0
      end
      return
    end
    
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @fade_flag = 4
      # �Z���N�g�����Z�b�g
      @select.opacity = 0
      @select.visible = false
      @select_blink_check = false
      @command = 1
      @center_window = Window_Status.new($game_party.actors[@select_index])
      actor = $game_party.actors[@select_index]
      @actor_graphic.bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
      @actor_graphic.x = 320
      @actor_graphic.y = 240
      @actor_graphic.y += 60 if actor.boss_graphic?
      @actor_graphic.ox = @actor_graphic.bitmap.width / 2
      @actor_graphic.oy = @actor_graphic.bitmap.height / 2
      @window[0].visible = true
      @window[0].y = 40
      @help_window.visible = true
      @help_window.window.visible = true
      text = "����F�����ύX�E���[������@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
      @help_window.set_text(text, 1)
      n = 340
      @help_window.y = n
      @help_window.window.y = n
      @overF_text = "S t a t u s"
      @party_command = 0
      return
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �㕔�e�L�X�g��߂�
      @overF_text = $game_party.gold.to_s + "�@" + $data_system.words.gold
      # ���j���[�ɖ߂�
      @command = 0
      @fade_flag = 5
      # �Z���N�g�����Z�b�g
      @select.opacity = 0
      @select.visible = false
      @select_index = 0
      @select_blink_check = false
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
      return
    end
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @select_index -= 2
      if @select_index < 0
        if $game_party.actors.size == 1 or $game_party.actors.size == 3
          if $game_party.actors.size == 3 and @select_index == -1
            @select_index += $game_party.actors.size
          else
            @select_index += $game_party.actors.size + 1
          end
        else
          @select_index += $game_party.actors.size
        end
        
      end  
      return
    end
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @select_index += 2
      if @select_index > $game_party.actors.size - 1
        if @select_index == 3 or @select_index == 5
          if $game_party.actors.size == 3
            @select_index = 2
          else
            @select_index = 1
          end
        else
          @select_index = 0
        end
      end  
      return
    end
    
  end

  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�m�F�E�B���h�E���A�N�e�B�u�̏ꍇ)
  #--------------------------------------------------------------------------
  def update_party_select_command
    
    
    # �R�}���h�J�n
    if $game_temp.script_message_index != 99
      # �̍�������Ă������ł����H
      case $game_temp.script_message_index
      when 0 # ������
        if $game_temp.script_message_cancel == false
          $game_system.se_play($data_system.decision_se) 
        end
      when 1 # �͂�
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        if $game_actors[101].sp <= $game_party.party_actors[@select_index].absorb
          $game_temp.message_text = $game_actors[101].name + "��VP���s�����Ă��܂��I"
        else
          @menu_party_command_window[1].visible = false
          @select.visible = false
          $game_temp.battle_active_battler = $game_party.party_actors[@select_index]
          # �R�����C�x���g ID ���L���̏ꍇ
          $game_temp.common_event_id = 41
          # �}�b�v��ʂɐ؂�ւ�
          @fade_flag = 2
        end
      end
      $game_temp.script_message_index = 99
      return
    end

    
    
    if @menu_party_command_window[0].active
      @menu_party_command_window[0].update
      
      # C �{�^���������ꂽ�ꍇ
      if Input.trigger?(Input::C)
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        
        case @menu_party_command_window[0].index
        
        when 0 # �X�e�[�^�X
          @fade_flag = 4
          # �Z���N�g�����Z�b�g
          @select.opacity = 0
          @select.visible = false
          @select_blink_check = false
          @command = 1
          @center_window = Window_Status.new($game_party.actors[@select_index])
          actor = $game_party.actors[@select_index]
          @actor_graphic.bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
          @actor_graphic.x = 320
          @actor_graphic.y = 240
          @actor_graphic.y += 60 if actor.boss_graphic?
          @actor_graphic.ox = @actor_graphic.bitmap.width / 2
          @actor_graphic.oy = @actor_graphic.bitmap.height / 2
          @window[0].visible = true
          @window[0].y = 40
          @help_window.visible = true
          @help_window.window.visible = true
          text = "����F�����ύX�E���[������@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
          @help_window.set_text(text, 1)
          n = 340
          @help_window.y = n
          @help_window.window.y = n
          @overF_text = "S t a t u s"
          @party_command = 0
          @menu_party_command_window[0].visible = false
          @menu_party_command_window[0].active = false
          @select_blink_flag = true
          return
        when 1 # �L�����Z��
          @menu_party_command_window[0].visible = false
          @menu_party_command_window[0].active = false
          @select_blink_flag = true
          return
        end
      end
      
    else
      @menu_party_command_window[1].update
      
      # C �{�^���������ꂽ�ꍇ
      if Input.trigger?(Input::C)
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        
        case @menu_party_command_window[1].index
        
        when 0 # �X�e�[�^�X
          @fade_flag = 4
          # �Z���N�g�����Z�b�g
          @select.opacity = 0
          @select.visible = false
          @select_blink_check = false
          @command = 1
          @center_window = Window_Status.new($game_party.actors[@select_index])
          actor = $game_party.actors[@select_index]
          @actor_graphic.bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
          @actor_graphic.x = 320
          @actor_graphic.y = 240
          @actor_graphic.y += 60 if actor.boss_graphic?
          @actor_graphic.ox = @actor_graphic.bitmap.width / 2
          @actor_graphic.oy = @actor_graphic.bitmap.height / 2
          @window[0].visible = true
          @window[0].y = 40
          @help_window.visible = true
          @help_window.window.visible = true
          text = "����F�����ύX�E���[������@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
          @help_window.set_text(text, 1)
          n = 340
          @help_window.y = n
          @help_window.window.y = n
          @overF_text = "S t a t u s"
          @party_command = 0
          @menu_party_command_window[1].visible = false
          @menu_party_command_window[1].active = false
          @select_blink_flag = true
          return
        when 1
          @menu_party_command_window[1].visible = false
          @menu_party_command_window[1].active = false
          @select_blink_flag = true
          @party_change_flag = true
          @now_select_index = @select_index
          @now_select.visible = true
          @overF_text = "C h a n g e"
          return
        when 2
          # ���b�Z�[�W�\�����t���O�𗧂Ă�
          $game_temp.message_window_showing = true
          $game_temp.script_message = true
          if not $game_party.actors[@select_index].state?(15)
            text = "�󕠂łȂ������ɐ������シ�邱�Ƃ͂ł��܂���I"
            $game_temp.message_text = text
            return
          end
          if not $game_party.actors[@select_index].dead?
            #�������z���e�X�g
            eat = $game_party.actors[@select_index].absorb
#            eat_p = (100 - $game_party.actors[@select_index].fed)
#            eat = (eat * eat_p / 100).round
            text = $game_party.actors[@select_index].name + "�ɐ������サ�܂����H\n"
            text += "�i" + $game_actors[101].name + "��VP��"+ eat.to_s + "����܂��j"
            text += "\n��߂�\n���シ��"
            $game_temp.choice_start = 2
            # ���� SE �����t
            $game_system.se_play($data_system.decision_se) 
            $game_temp.message_text = text
            $game_temp.choice_max = 2
            $game_temp.choice_cancel_type = 1
          else
            text = "���_���Ă��閲���ɐ������シ�邱�Ƃ͂ł��܂���I"
            $game_temp.message_text = text
          end
          return

          
          
        when 3 # �L�����Z��
          @menu_party_command_window[1].visible = false
          @menu_party_command_window[1].active = false
          @select_blink_flag = true
          return
        end
      end
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @menu_party_command_window[0].visible = false
      @menu_party_command_window[0].active = false
      @menu_party_command_window[1].visible = false
      @menu_party_command_window[1].active = false
      @select_blink_flag = true
      return
    end
  end
  
  
  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���ёւ����̏ꍇ)
  #--------------------------------------------------------------------------
  def update_party_select_change
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      if $game_party.actors[@select_index] == $game_actors[101] \
       or @now_select_index == @select_index
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # SE �����t
      Audio.se_play("Audio/SE/005-System05", 80, 100)
      @select_blink_check = true
      @select.opacity = 255
      @party_change_flag = false
#      @select_index = @now_select_index
      @now_select.visible = false
      
      # �w�胁���o�[�̕��������
      @select_actor1 = $game_party.actors[@select_index]
      @select_actor2 = $game_party.actors[@now_select_index]
      
      @fade_flag = 7
      return
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @select_blink_flag = true
      @select_blink_check = true
      @select.opacity = 255
      @party_change_flag = false
#      @select_index = @now_select_index
      @now_select.visible = false
      @overF_text = "P a r t y"
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
      return
    end
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @select_index -= 2
      if @select_index < 0
        if $game_party.actors.size == 1 or $game_party.actors.size == 3
          if $game_party.actors.size == 3 and @select_index == -1
            @select_index += $game_party.actors.size
          else
            @select_index += $game_party.actors.size + 1
          end
        else
          @select_index += $game_party.actors.size
        end
        
      end  
      return
    end
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      @select_index += 2
      if @select_index > $game_party.actors.size - 1
        if @select_index == 3 or @select_index == 5
          if $game_party.actors.size == 3
            @select_index = 2
          else
            @select_index = 1
          end
        else
          @select_index = 0
        end
      end  
      return
    end
    

    
  end
end