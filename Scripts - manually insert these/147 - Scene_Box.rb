
class Scene_Box
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize

    # 0:��������, 1:�S�o��, 2:�S���� 3,�|�[�Y�p
    @fade_flag = 1
    
    # 0:�{�b�N�X, 1:�p�[�e�B
    @command = 0

    @return_flag = false
    @hidden_flag = false
    @change_flag = false
    
    @status_flag = false
    @status_command = 0 # 0:�X�e�[�^�X�A1:�X�L���A2:�f��
    
    
    
    @select_color = Color.new(255, 255, 255)
    @nonselect_color = Color.new(84, 98, 79)
    
    
    # ����
    @center = []
    @center[0] = Sprite.new
    @center[0].y = 0
    @center[0].opacity = 0
    @center[0].bitmap = RPG::Cache.windowskin("menu_back")
    @center[0].z = 2000
    @center[0].visible = true
    @center[0].blend_type = 2

    # ��t���[��
    @overF = []
    for i in 0..1
      @overF[i] = Sprite.new
      @overF[i].y = 0 - 100
      @overF[i].z = 2100
      @overF[i].visible = true
    end
    @overF[0].bitmap = RPG::Cache.windowskin("box_overF")
    @overF[0].x = 0


    @overF[1].bitmap = Bitmap.new(640, 100)
    @overF_text = nil
    
    # ���t���[��
    @underF = []
    for i in 0..5
      @underF[i] = Sprite.new
      @underF[i].y = 380 + 100
      @underF[i].z = 3100
      @underF[i].visible = true
    end
    @underF[0].bitmap = RPG::Cache.windowskin("box_underF")
    @underF[0].x = -240 #-120
    @underF[1].bitmap = RPG::Cache.windowskin("box_underF_home")
    @underF[2].bitmap = RPG::Cache.windowskin("box_underF_party")
    @underF[3].x = 106
    @underF[3].bitmap = Bitmap.new(180, 100)
    @underF[3].bitmap.font.size = $default_size_mini
    @underF[4].x = 430
    @underF[4].bitmap = Bitmap.new(180, 100)
    @underF[4].bitmap.font.size = $default_size_mini
    @underF[4].bitmap.draw_text(0, 56, 180, 20, "Contracted Succubi: ", 0)
    @underF[4].bitmap.draw_text(0, 56, 180, 20, $game_party.home_actors.to_s + " / " + $game_party.box_max.to_s, 2)
    @underF[4].bitmap.draw_text(0, 76, 180, 20, "Total Dream Power:", 0)
    @underF[4].bitmap.draw_text(0, 76, 180, 20, $game_party.all_d_power.to_s, 2)


    # �w���v�E�B���h�E�A�A�C�e���E�B���h�E���쐬
    @help_window = Window_Help.new
    @help_window.visible = false
    @help_window.y = 340
    @help_window.window.y = 340
    
    
    # ������ʕ\���p�@0:��������, 1:�o��, 2:����
    @equip_fade_flag = 0
    # ������ʗp�@0:��������, 1:�����I��, 2:�����ύX��
    @equip_time = 0
    
    # �I�������ʗp
    @select_type = ""

    # �_��̎����X�C�b�`
    @promise_flag = false
    
    # �Ăі��ύX���X�C�b�`
    @petname_flag = false

    @window = []
    for i in 0..3
      @window[i] = Sprite.new
      @window[i].z = 2020
      @window[i].visible = true
      @window[i].opacity = 0
    end
    @window[0].bitmap = RPG::Cache.windowskin("menu_windowLL")
    @window[0].x = -240
    @window[0].y = 40
    @window[1].bitmap = RPG::Cache.windowskin("menu_windowLL")
    @window[1].x = 640 - 20 - 240
    @window[1].y = 40
    @window[2].bitmap = RPG::Cache.windowskin("menu_windowL")
    @window[2].y = 40
    @window[2].visible = false
    @window[3].bitmap = RPG::Cache.windowskin("menu_windowL")
    @window[3].x = 640 - 20
    @window[3].y = 40

    
    
    # �A�N�^�[�O���t�B�b�N
    @actor_graphic = Sprite.new
    @actor_graphic.x = 320
    @actor_graphic.y = 240
    @actor_graphic.z = 2010
    @actor_graphic.opacity = 0
    if $game_actors[1].class_id != 1
      @now_actor = $game_actors[1]
      @box_temp = [$game_actors[1], 0]
    else
      @now_actor = $game_actors[101]
      @box_temp = [$game_actors[101], 0]
    end
    @party_temp = [$game_actors[101], 0]
    @actor_graphic.bitmap = RPG::Cache.battler(@now_actor.battler_name, @now_actor.battler_hue)
    @actor_graphic.ox = @actor_graphic.bitmap.width / 2
    @actor_graphic.oy = @actor_graphic.bitmap.height / 2

    @left_window = Window_BoxLeft.new
    @right_window = Window_BoxRight.new(@box_temp[0])
    
    @message_window = Window_Message.new
    
    @command_window = []
    
    # �{�b�N�X�p
    commands = ["Status", "Bring", "Move", "Bonuses", "Terminate", "Cancel"]
    @command_window[0] = Window_Command.new(130, commands)
    # �p�[�e�B�p�i�����p�j
    commands = ["Status", "Leave", "Move", "Bonuses", "Terminate", "Cancel"]
    @command_window[1] = Window_Command.new(130, commands)
    # �p�[�e�B�p�i��l���p�j
    commands = ["Status", "Cancel"]
    @command_window[2] = Window_Command.new(130, commands)
    # �{�b�N�X���ёւ��p
    commands = ["Move", "����"]
    @command_window[3] = Window_Command.new(130, commands)
    for window in @command_window
      window.x = (640 - window.width) / 2
      window.y = (480 - window.height) / 2
      window.z = 2100
      window.opacity = 220
      window.visible = false
      window.active = false
    end
    refresh
    
  end
  #--------------------------------------------------------------------------
  # �� ���C������
  #--------------------------------------------------------------------------
  def main
    $game_temp.in_box = true
    # �g�����W�V�������s
    Graphics.transition(0)
    # ���C�����[�v
    loop do
      # �Q�[����ʂ��X�V
      Graphics.update
      # ���͏����X�V
      Input.update
      # �t���[���X�V
      update
      # �V�[���I������
      break if @return_flag
    end
    # �g�����W�V��������
    Graphics.freeze
    # �E�B���h�E�����
    dispose
    # �p�[�e�B�̃��t���b�V��
    $game_party.refresh
  end
  
  #--------------------------------------------------------------------------
  # �� ���
  #--------------------------------------------------------------------------
  def dispose
    for center in @center
      center.dispose
    end
    for overF in @overF
      overF.dispose
    end
    for underF in @underF
      underF.dispose
    end
    for window in @window
      window.dispose
    end
    for command_window in @command_window
      command_window.dispose
    end
    @help_window.dispose
    @left_window.dispose
    @right_window.dispose
    @actor_graphic.dispose
    @message_window.dispose
    $game_temp.in_box = false

  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    
    @message_window.update
    
    # �R�}���h�J�n
    if $game_temp.script_message_index != 99
      case @select_type
      when "�_��j��"

        # �_��j�����܂����H
        case $game_temp.script_message_index
        when 0 # ������
          if $game_temp.script_message_cancel == false
            $game_system.se_play($data_system.decision_se) 
          end
        when 1 # �͂�
          release
          refresh
          graphic_refresh
          @command_window[0].visible = false
          @command_window[0].active = false
          if @left_window.actor_data == nil
            while @left_window.actor_data == nil
              if @left_window.index == -1
                @box_temp = [$game_actors[101],0]
                @now_actor = @right_window.actor = @box_temp[0]
                graphic_refresh
                @left_window.index = 0
                break
              end
              @left_window.index -= 1
            end
            refresh
          end
          @command_window[0].visible = false
          @command_window[0].active = false
          @command_window[1].visible = false
          @command_window[1].active = false
        end
        
      when "���[������"
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
          @now_actor.equip(@center_window.index + 1, item == nil ? 0 : item.id, 1)
          # ���C�g�E�B���h�E���A�N�e�B�u��
          @center_window.active = true
          @equip_item_window.active = false
          @equip_item_window.index = -1
          # ���C�g�E�B���h�E�A�A�C�e���E�B���h�E�̓��e���č쐬
          @center_window.refresh
          @equip_item_window.refresh
          @equip_time = 1
        end
      
      when "�{�[�i�X�E�X�L��"
        # �X�L���̏K�������Ă������ł����H
        case $game_temp.script_message_index
        when 0 # ������
          if $game_temp.script_message_cancel == false
            $game_system.se_play($data_system.decision_se) 
          end
        when 1 # �͂�
          Audio.se_play("Audio/SE/button26", 80, 100)
          @now_actor.learn_skill(@bonus[2])
          @now_actor.promise -= @bonus[0]
          # �z�[���h�X�L���͓����̑f�����K��
          case @bonus[2]
          when 5 # �V�F���}�b�`
            @now_actor.gain_ability(303)
          when 6 # �C���T�[�g
            @now_actor.gain_ability(301)
          when 16 # �h���E�l�N�^�[
            @now_actor.gain_ability(306)
          when 17 # �G���u���C�X
            @now_actor.gain_ability(305)
          when 18 # �G�L�T�C�g�r���[
            @now_actor.gain_ability(304)
          end
        end
        @center_window.refresh
        @promise_left_window.refresh
        
      when "�{�[�i�X�E�f��"
        # �X�L���̏K�������Ă������ł����H
        case $game_temp.script_message_index
        when 0 # ������
          if $game_temp.script_message_cancel == false
            $game_system.se_play($data_system.decision_se) 
          end
        when 1 # �͂�
          Audio.se_play("Audio/SE/button26", 80, 100)
          @now_actor.gain_ability(@bonus[2])
          @now_actor.promise -= @bonus[0]
        end
        @center_window.refresh
        @promise_left_window.refresh
        
      when "�{�[�i�X�E���x���A�b�v"
        # �X�L���̏K�������Ă������ł����H
        case $game_temp.script_message_index
        when 0 # ������
          if $game_temp.script_message_cancel == false
            $game_system.se_play($data_system.decision_se) 
          end
        when 1 # �͂�
          Audio.se_play("Audio/SE/button26", 80, 100)
          @now_actor.level = @now_actor.level + 1
          # �e�L�X�g�𐮌`����
          text = @now_actor.level_up_log
          text.gsub!("\","")
          text.gsub!("\","\n")
          @now_actor.level_up_log = ""
          $game_temp.message_text = text
          @now_actor.promise -= @bonus[0]
          # �d�o�E�u�o���ϓ�����̂őS��
          @now_actor.recover_all
        end
        @center_window.refresh
        @promise_left_window.refresh
        
      when "�{�[�i�X�E�Ăѕ��ύX"
        # ���̌Ăѕ��ɕύX���Ă����ł����H
        case $game_temp.script_message_index
        when 0 # ������
          if $game_temp.script_message_cancel == false
            $game_system.se_play($data_system.decision_se) 
          end
        when 1 # �͂�
          Audio.se_play("Audio/SE/button26", 80, 100)
          if @bonus[1] == @petname_window.default_text 
            @now_actor.nickname_master = nil
          elsif @bonus[1] == @petname_window.input_text 
            @now_actor.nickname_master = @petname_window.input_petname
          else
            @now_actor.nickname_master = @bonus[1]
          end
          @now_actor.promise -= @bonus[0]
        end
        @center_window.refresh
        @petname_window.refresh
        @promise_left_window.refresh
        
      when "�{�[�i�X�E�������"
        # ��������Ă������ł����H
        case $game_temp.script_message_index
        when 0 # ������
          if $game_temp.script_message_cancel == false
            $game_system.se_play($data_system.decision_se) 
          end
        when 1 # �͂�
          Audio.se_play("Audio/SE/006-System06", 80, 100)
          $game_party.gain_gold(3000)
          @now_actor.promise -= @bonus[0]
        end
        @center_window.refresh
        @promise_left_window.refresh

      end
      $game_temp.script_message_index = 99
      @select_type = ""
      return
    end

    
    # ���b�Z�[�W�\�����̏ꍇ�̓{�b�N�X��������b�N
    if $game_temp.message_window_showing
      return
    end
    
    
    # �t�F�[�h�t���O�������Ă���ꍇ�̓t�F�[�h
    if @fade_flag != 0
      fade
      return
    end

    
    
    if @status_flag
      update_status
      return
    end
    
    if @command_window[0].visible \
     or @command_window[1].visible \
     or @command_window[2].visible \
     or @command_window[3].visible
      update_command
      return
    end

    


    # ���t�g�E�B���h�E���A�N�e�B�u�Ȃ炱�����̃t���[���X�V
    if @left_window.active
      if @now_actor != @left_window.actor_data
        @now_actor =  @right_window.actor = @left_window.actor_data
        @right_window.refresh if @right_window.actor != nil
        graphic_refresh
      end
      # �_��̎���
      if @promise_flag
        update_promise
        return
      end
      @left_window.update
      # ��㒆
      if @change_flag
        update_change
        return
      end
      case @left_window.mode
      when 0
        update_box
      when 1
        update_party
      end
      return
    end
    
    # �E�{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # SE �����t
      Audio.se_play("Audio/SE/005-System05", 80, 100)
      @command += 1
      @command = 0 if @command > 1
      @left_window.mode = @command
      refresh
      return
    end
    # �E�{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::LEFT)
      # SE �����t
      Audio.se_play("Audio/SE/005-System05", 80, 100)
      @command -= 1
      @command = 1 if @command < 0
      @left_window.mode = @command
      refresh
      return
    end

    
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @left_window.active = true
      if @left_window.mode == 0
        @left_window.index = @box_temp[1]
        @overF_text = "H o m e"
      else
        @left_window.index = @party_temp[1]
        @overF_text = "P a r t y"
      end
      refresh

      return
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �}�b�v��ʂɐ؂�ւ�
      @fade_flag = 2
      return
    end
    

  end

  #--------------------------------------------------------------------------
  # �� �t���[���X�V�@�{�b�N�X
  #--------------------------------------------------------------------------
  def update_box
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      if @now_actor == $game_actors[101] or @now_actor == nil 
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @command_window[0].visible = true
      @command_window[0].active = true
      @command_window[0].index = 0
      return
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �A�N�e�B�u���I��
      @left_window.active = false
      @box_temp = [@left_window.actor_data, @left_window.index]
      @left_window.index = -1
      @overF_text = nil
      refresh
      return
    end
    
    # A �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::A)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @left_window.page_type_change
      refresh
      return
    end
   
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V�@�p�[�e�B
  #--------------------------------------------------------------------------
  def update_party
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      if @now_actor != $game_actors[101]
        @command_window[1].visible = true
        @command_window[1].active = true
        @command_window[1].index = 0
      else
        @command_window[2].visible = true
        @command_window[2].active = true
        @command_window[2].index = 0
      end
    end
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �A�N�e�B�u���I��
      @left_window.active = false
      @party_temp = [@left_window.actor_data,@left_window.index]
      @left_window.index = -1
      @overF_text = nil
      refresh
    end
    # A �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::A)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @left_window.page_type_change
      refresh
      return
    end
  end

  #--------------------------------------------------------------------------
  # �� �t���[���X�V�@���ёւ�
  #--------------------------------------------------------------------------
  def update_change
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      
      if @now_actor == @change_temp[0] \
       or @now_actor == $game_actors[101]
       # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # SE �����t
      Audio.se_play("Audio/SE/005-System05", 80, 100)
      
      if @left_window.mode == 0
         actor1 = @change_temp[0].dup
         actor2 = @now_actor.dup     
         $game_party.data_move(@left_window.change_index + 1, actor2)
         $game_party.data_move(@left_window.index + 1, actor1)
#        $game_party.data_move(@left_window.change_actor, actor2.dup)
#        $game_party.data_move(@left_window.actor_data, actor1.dup)
        @overF_text = "H o m e"
      else
        actor1_id = @change_temp[0].id
        actor2_id = @now_actor.id
        $game_party.party_actors[@left_window.change_index] = $game_actors[actor2_id]
        $game_party.party_actors[@left_window.index] = $game_actors[actor1_id]
        $game_party.battle_actor_refresh
        @overF_text = "P a r t y"
      end
      @now_actor = @right_window.actor = @left_window.change_actor
      @left_window.change_index = -1
      @change_flag = false
      box_sort
      refresh
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �A�N�e�B�u���I��
      @left_window.change_index = -1
      @change_flag = false
      if @left_window.mode == 0
        @overF_text = "H o m e"
      else
        @overF_text = "P a r t y"
      end
      refresh
    end
    
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V�@�R�}���h
  #--------------------------------------------------------------------------
  def update_command
        
    if @command_window[0].active
      @command_window[0].update
      
      # C �{�^���������ꂽ�ꍇ
      if Input.trigger?(Input::C)
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        case @command_window[0].index
        when 0 # �X�e�[�^�X
          @fade_flag = 3
          @status_flag = true
          @command_window[0].visible = false
          @command_window[0].active = false
          @center_window = Window_Status.new(@now_actor)
          @center_window1 = Window_SkillStatus.new(@now_actor)
          @center_window1.visible = false
          @window[2].visible = @help_window.visible = true
          @help_window.window.visible = true
          @left_window.visible = false
          @overF_text = "S t a t u s"
          @status_command = 0
          status_refresh
        when 1 # �A��čs��
          party_in
          refresh
          graphic_refresh
          @command_window[0].visible = false
          @command_window[0].active = false
          if @left_window.actor_data == nil
            while @left_window.actor_data == nil
              if @left_window.index == -1
                @box_temp = [$game_actors[101],0]
                @now_actor = @right_window.actor = @box_temp[0]
                graphic_refresh
                @left_window.index = 0
                break
              end
              @left_window.index -= 1
            end
            refresh
          end
        when 2 # ���ёւ�
          @change_temp = [@now_actor, @left_window.index]
          @left_window.change_index = @change_temp[1]
          @change_flag = true
          @command_window[0].visible = false
          @command_window[0].active = false
          @overF_text = "C h a n g e"
          refresh
        when 3 # �_��̎�̎g�p
          @fade_flag = 3
          @promise_flag = true
          @promise_left_window = Window_PromiseLeft.new(@now_actor)
          @center_window = Window_PromiseRight.new(@now_actor)
          @center_window.help_window = @help_window
          @command_window[0].visible = false
          @command_window[0].active = false
          @overF_text = "B o n u s"
          @window[2].visible = true
          @help_window.visible = true
          @help_window.window.visible = true
          refresh
        when 4 # �_��j��
          # ���j�[�N�͌_��j���s��
          if @now_actor.boss_graphic?
            text = "Cannot terminate a contract from a unique succubus!"
            # �u�U�[ SE �����t
            $game_system.se_play($data_system.buzzer_se)
            $game_temp.message_text = text
            $game_temp.script_message = true
            return
          end
          text = "Upon contract termination, this succubus will disappear.\n"
          text += " Are you sure that you want to terminate your contract \n with " + @now_actor.name + "? \nNevermind\nTerminate"
          $game_temp.choice_start = 3
          # ���� SE �����t
          $game_system.se_play($data_system.decision_se) 
          $game_temp.message_text = text
          $game_temp.choice_max = 2
          $game_temp.choice_cancel_type = 1
          $game_temp.script_message = true
          @select_type = "�_��j��"
        when 5 # �L�����Z��
          @command_window[0].visible = false
          @command_window[0].active = false
        end
        return
      end
    elsif @command_window[1].active # �p�[�e�B�i�����j
      @command_window[1].update
      
      # C �{�^���������ꂽ�ꍇ
      if Input.trigger?(Input::C)
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        case @command_window[1].index
        when 0 # �X�e�[�^�X
          @fade_flag = 3
          @status_flag = true
          @command_window[1].visible = false
          @command_window[1].active = false
          @window[2].visible = @help_window.visible = true
          @help_window.window.visible = true
          @center_window = Window_Status.new(@now_actor)
          @center_window1 = Window_SkillStatus.new(@now_actor)
          @center_window1.visible = false
          @left_window.visible = false
          @overF_text = "S t a t u s"
          @status_command = 0
          status_refresh
        when 1 # �a����
          box_in
          refresh
          @command_window[1].visible = false
          @command_window[1].active = false
          if @left_window.actor_data == nil
            while @left_window.actor_data == nil
              break if @left_window.index == -1
              @left_window.index -= 1
            end
            refresh
          end
        when 2 # ���ёւ�
          @change_temp = [@now_actor, @left_window.index]
          @left_window.change_index = @change_temp[1]
          @change_flag = true
          @command_window[1].visible = false
          @command_window[1].active = false
          @overF_text = "C h a n g e"
          refresh
        when 3 # �_��̎�̏���
          @fade_flag = 3
          @promise_flag = true
          @promise_left_window = Window_PromiseLeft.new(@now_actor)
          @center_window = Window_PromiseRight.new(@now_actor)
          @center_window.help_window = @help_window
          @command_window[1].visible = false
          @command_window[1].active = false
          @overF_text = "B o n u s"
          @window[2].visible = true
          @help_window.visible = true
          @help_window.window.visible = true
          refresh
        when 4 # �_��j��
          # ���j�[�N�͌_��j���s��
          if @now_actor.boss_graphic?
            text = "Cannot terminate a contract from a unique succubus!"
            # �u�U�[ SE �����t
            $game_system.se_play($data_system.buzzer_se)
            $game_temp.message_text = text
            $game_temp.script_message = true
            return
          end
          text = "Upon contract termination, this succubus will disappear.\n"
          text += " Are you sure that you want to terminate your contract \n with " + @now_actor.name + "? \nNevermind\nTerminate"
          $game_temp.choice_start = 3
          # ���� SE �����t
          $game_system.se_play($data_system.decision_se) 
          $game_temp.message_text = text
          $game_temp.choice_max = 2
          $game_temp.choice_cancel_type = 1
          $game_temp.script_message = true
          @select_type = "�_��j��"
        when 5 # �L�����Z��
          @command_window[1].visible = false
          @command_window[1].active = false
        end
        return
      end
    elsif @command_window[2].active # �p�[�e�B�i��l���j
      @command_window[2].update
      
      # C �{�^���������ꂽ�ꍇ
      if Input.trigger?(Input::C)
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        case @command_window[2].index
        when 0 # �X�e�[�^�X
          @fade_flag = 3
          @status_flag = true
          @command_window[2].visible = false
          @command_window[2].active = false
          @window[2].visible = @help_window.visible = true
          @help_window.window.visible = true
          @left_window.visible = false
          @overF_text = "S t a t u s"
          @center_window = Window_Status.new(@now_actor)
          @center_window1 = Window_SkillStatus.new(@now_actor)
          @center_window1.visible = false
          @status_command = 0
          status_refresh
        when 1 # �L�����Z��
          @command_window[2].visible = false
          @command_window[2].active = false
        end
        return
      end
        
    else @command_window[3].active # ���ёւ�
      @command_window[3].update
      
      # C �{�^���������ꂽ�ꍇ
      if Input.trigger?(Input::C)
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        case @command_window[3].index
        when 0 # �ꏊ���
        when 1 # �푰��
          pigeonhole(0)
          refresh
        end
        return
      end
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @command_window[0].visible = false
      @command_window[0].active = false
      @command_window[1].visible = false
      @command_window[1].active = false
      @command_window[2].visible = false
      @command_window[2].active = false
      @command_window[3].visible = false
      @command_window[3].active = false
      return
    end
    
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    if @overF_text == nil
      @overF_text = $game_party.gold.to_s + "�@" + $data_system.words.gold
    end
    @overF[1].bitmap.clear
    @overF[1].bitmap.draw_text(375, 0, 200, 32, @overF_text, 1)
    
    @underF[3].bitmap.clear
    case @command
    when 0 # Party
      @underF[1].color = @select_color
      @underF[2].color = @nonselect_color
      @underF[3].bitmap.draw_text(0, 36, 180, 20, "Examine succubi at home", 1)
    when 1 # Item
      @underF[1].color = @nonselect_color
      @underF[2].color = @select_color
      @underF[3].bitmap.draw_text(0, 36, 180, 20, "Examine succubi in party", 1)
    end

    
    unless @left_window.active
      case @left_window.mode
      when 0
        if @now_actor == $game_actors[101] and $game_actors[1].class_id != 1
          @box_temp = [$game_actors[1],0]
        end
        if @now_actor != @box_temp[0]
          @now_actor = @box_temp[0]
          @right_window.actor = @box_temp[0]
        end
      when 1
        if @now_actor != @party_temp[0]
          @now_actor = @party_temp[0]
          @right_window.actor = @party_temp[0]
        end
      end
      graphic_refresh
    end
    
    @left_window.refresh 
    @right_window.refresh if @now_actor != nil
    
    @underF[4].bitmap.clear
    @underF[4].bitmap.font.size = $default_size_mini
    @underF[4].bitmap.draw_text(0, 56, 180, 20, "Contracted Succubi: ", 0)
    @underF[4].bitmap.draw_text(0, 56, 180, 20, $game_party.home_actors.to_s + " / " + $game_party.box_max.to_s, 2)
    @underF[4].bitmap.draw_text(0, 76, 180, 20, "Total Dream Power:", 0)
    @underF[4].bitmap.draw_text(0, 76, 180, 20, $game_party.all_d_power.to_s, 2)

  end
  #--------------------------------------------------------------------------
  # �� �O���t�B�b�N���t���b�V��
  #--------------------------------------------------------------------------
  def graphic_refresh
    if @now_actor == nil
      return
    end
    @actor_graphic.bitmap = RPG::Cache.battler(@now_actor.battler_name, @now_actor.battler_hue)
    @actor_graphic.x = 320
    @actor_graphic.y = 240
    @actor_graphic.y += 60 if @now_actor.boss_graphic?
    @actor_graphic.ox = @actor_graphic.bitmap.width / 2
    @actor_graphic.oy = @actor_graphic.bitmap.height / 2
  end
end