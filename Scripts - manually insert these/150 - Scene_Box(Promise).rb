#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Box
  
  #--------------------------------------------------------------------------
  # �� ���̕ύX
  #--------------------------------------------------------------------------
  def update_petname
    # �E�B���h�E���X�V
    @petname_window.update
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      @bonus = @petname_window.petname
      # �m�F�̏ꍇ�͉������Ȃ�
      if @bonus[1] == @petname_window.check_text
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      # �K���ł��Ȃ��ꍇ
      unless @petname_window.can_get_petname?
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        $game_temp.message_text = $game_temp.error_message
        return
      end
      @petname_window.input_petname = nil
      if @bonus[1] == @petname_window.input_text
        # ���O���ꎞ�L��
        temp_name = @now_actor.nickname_master
        # ���O���͉�ʂɈȍ~
        Graphics.freeze
        $game_actors[120].name = @now_actor.defaultname_hero
        $game_temp.name_actor_id = 120
        $game_temp.name_max_char = 12
        $scene1 = Scene_Name.new(1)
        $scene1.main
        Graphics.transition(8)
        # �O�Ɠ������̂������ꍇ�A�Ԃ�
        if $game_actors[120].name == @now_actor.nickname_master
          return
        end
        @petname_window.input_petname = $game_actors[120].name
      end
      text = "#{@now_actor.name}����̌Ăѕ����A�u#{@bonus[1]}�v��"
      text += "\n�ς��Ă��炢�܂����H�i�_��̎��#{@bonus[0]}����܂��j"
      if @bonus[1] == @petname_window.default_text
        text = "#{@now_actor.name}����̌Ăѕ����A�u#{@now_actor.defaultname_hero}�v��"
        text += "\n�߂��Ă��炢�܂����H�i�_��̎��#{@bonus[0]}����܂��j"
      end
      if @bonus[1] == @petname_window.input_text
        text = "#{@now_actor.name}����̌Ăѕ����A�u#{@petname_window.input_petname}�v��"
        text += "\n�ς��Ă��炢�܂����H�i�_��̎��#{@bonus[0]}����܂��j"
      end
      text += "\n������\n�͂�"
      $game_temp.choice_start = 2
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se) 
      $game_temp.message_text = text
      $game_temp.choice_max = 2
      $game_temp.choice_cancel_type = 1
      # ���b�Z�[�W�\�����t���O�𗧂Ă�
      $game_temp.message_window_showing = true
      $game_temp.script_message = true
      @select_type = "�{�[�i�X�E�Ăѕ��ύX"
    end
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @petname_window.dispose
      @center_window.active = true
      @center_window.visible = true
      @petname_flag = false
    end
  end
  #--------------------------------------------------------------------------
  # �� �{�[�i�X�K��
  #--------------------------------------------------------------------------
  def update_promise
    
    if @petname_flag
      update_petname
      return
    end
    
    
    @center_window.update
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      @bonus = @center_window.bonus
      
      # �K���ł��Ȃ��ꍇ
      unless @center_window.can_get_bonus?
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        $game_temp.message_text = $game_temp.error_message
        return
      end
      
      case @bonus[1]
      when 0 # �X�L���̏ꍇ
        text = "#{@now_actor.name} can learn �u#{$data_skills[@bonus[2]].name}�v."
        text += "\nLearn Skill? (Will consume #{@bonus[0]} Contract Beads!)"
        text += "\nNo\nYes"
        $game_temp.choice_start = 2
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se) 
        $game_temp.message_text = text
        $game_temp.choice_max = 2
        $game_temp.choice_cancel_type = 1
        # ���b�Z�[�W�\�����t���O�𗧂Ă�
        $game_temp.message_window_showing = true
        $game_temp.script_message = true
        @select_type = "�{�[�i�X�E�X�L��"

        
      when 1 # �f���̏ꍇ
        text = "#{@now_actor.name} can acquire �y#{$data_ability[@bonus[2]].name}�z."
        text += "\nAcquire trait? (Will consume #{@bonus[0]} Contract Beads!)"
        text += "\nNo\nYes"
        $game_temp.choice_start = 2
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se) 
        $game_temp.message_text = text
        $game_temp.choice_max = 2
        $game_temp.choice_cancel_type = 1
        # ���b�Z�[�W�\�����t���O�𗧂Ă�
        $game_temp.message_window_showing = true
        $game_temp.script_message = true
        @select_type = "�{�[�i�X�E�f��"
        
      when 2 # ���[���̏ꍇ
        
        
      when 3 # ���̑��̏ꍇ
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        case @bonus[2]
        when 0 # ���O��ς���
          # ���O���ꎞ�L��
          temp_name = @now_actor.name.dup
          # ���O���͉�ʂɈȍ~
          Graphics.freeze
          $game_temp.name_actor_id = @now_actor.id
          $game_temp.name_max_char = 9
          $scene1 = Scene_Name.new(1)
          $scene1.main
          # �O�ƈႤ���O�������ꍇ�A�_��̎������
          if @now_actor.name != temp_name
            @now_actor.promise -= @bonus[0]
          end
          @promise_left_window.refresh
          Graphics.transition(8)
        when 1 # ���x�����グ��
          text = "Level up #{@now_actor.name}?"
          text += "\n(Will consume #{@bonus[0]} Contract Beads)"
          text += "\nYes\nNo"
          $game_temp.choice_start = 2
          # ���� SE �����t
          $game_system.se_play($data_system.decision_se) 
          $game_temp.message_text = text
          $game_temp.choice_max = 2
          $game_temp.choice_cancel_type = 1
          # ���b�Z�[�W�\�����t���O�𗧂Ă�
          $game_temp.message_window_showing = true
          $game_temp.script_message = true
          @select_type = "�{�[�i�X�E���x���A�b�v"
        when 2 # �Ăі���ς���
          # ���� SE �����t
          $game_system.se_play($data_system.decision_se) 
          @center_window.active = false
          @center_window.visible = false
          @petname_window = Window_Petname_Change.new(@now_actor)
          @petname_window.help_window = @help_window
          @petname_flag = true
          return
        when 3 # �����̎悷��
          text = "Can extract 3000Lps. from #{@now_actor.name}. Extract?"
          text += "\n�iWill consume #{@bonus[0]} Contract Beads)"
          text += "\nYes\nNo"
          $game_temp.choice_start = 2
          # ���� SE �����t
          $game_system.se_play($data_system.decision_se) 
          $game_temp.message_text = text
          $game_temp.choice_max = 2
          $game_temp.choice_cancel_type = 1
          # ���b�Z�[�W�\�����t���O�𗧂Ă�
          $game_temp.message_window_showing = true
          $game_temp.script_message = true
          @select_type = "�{�[�i�X�E�������"
        end
      end
      @center_window.refresh
      @promise_left_window.refresh
      return
        
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �A�N�e�B�u���I��
      @fade_flag = 4
      @window[2].visible = false
      @help_window.visible = false
      @help_window.window.visible = false

      @center_window.dispose
      @promise_left_window.dispose

      @promise_flag = false
      if @left_window.mode == 0
        @overF_text = "H o m e"
      else
        @overF_text = "P a r t y"
      end
      refresh
    end
  end
end