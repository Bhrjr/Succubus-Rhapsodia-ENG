#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Menu
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update_party_skill
    
    # �E�B���h�E���X�V
    @target_window.update
    
    # �^�[�Q�b�g�E�B���h�E���A�N�e�B�u�̏ꍇ: update_target ���Ă�
    if @center_window.active
      update_skill_active
      return
    end
    # �^�[�Q�b�g�E�B���h�E���A�N�e�B�u�̏ꍇ: update_target ���Ă�
    if @target_window.active
      update_skill_target_active
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
    if Input.repeat?(Input::UP)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)

      actor = $game_party.actors[@select_index]
      
      @center_window.dispose
      @center_window = Window_Status.new(actor)
      @center_window.index = -2
      @center_window.refresh
      @overF_text = "S t a t u s"
      text = "����F�����ύX�E���[������@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
      @help_window.set_text(text, 1)
      @center_window1.dispose
      @party_command = 0
      return
    end

    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      # �J�[�\�� SE �����t
      $game_system.se_play($data_system.cursor_se)
      actor = $game_party.actors[@select_index]
      @center_window.dispose
      @center_window = Window_Ability.new(actor)
      @center_window.index = 0
      @center_window.refresh
      @center_window.index = -1
      @center_window.refresh
      @overF_text = "A b i l i t y"
      text = "����F�f���m�F�@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
      @help_window.set_text(text, 1)
      @party_command = 1
      return
    end
  end
  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�^�[�Q�b�g�E�B���h�E���A�N�e�B�u�̏ꍇ)
  #--------------------------------------------------------------------------
  def update_skill_active
    
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      @center_window.help_window = nil
      @center_window.active = false
      @center_window.index = -1
      @center_window.refresh
      text = "����F�X�L���m�F�@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
      @help_window.set_text(text, 1)
      return
    end

    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # �X�L���E�B���h�E�Ō��ݑI������Ă���f�[�^���擾
      @skill = @center_window.skill
      @actor = $game_party.party_actors[@select_index]
      # �g�p�ł��Ȃ��ꍇ
      if @skill == nil or not @actor.skill_can_use?(@skill.id)
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # ���ʔ͈͂������̏ꍇ
      if @skill.scope >= 3
        # �^�[�Q�b�g�E�B���h�E���A�N�e�B�u��
        @center_window.visible = false
        @center_window.active = false
        @target_window.y = 60
        @target_window.visible = true
        @target_window.active = true
        @target_window.icon = @skill.icon_name
        @target_window.name = @skill.name
        # ���ʔ͈� (�P��/�S��) �ɉ����ăJ�[�\���ʒu��ݒ�
        if @skill.scope == 4 || @skill.scope == 6
          @target_window.index = -1
        elsif @skill.scope == 7
          @target_window.index = @select_index - 10
        else
          @target_window.index = 0
        end
        @target_window.refresh
      # ���ʔ͈͂������ȊO�̏ꍇ
      else
        # �R�����C�x���g ID ���L���̏ꍇ
        if @skill.common_event_id > 0
          # �R�����C�x���g�Ăяo���\��
          $game_temp.common_event_id = @skill.common_event_id
          # �X�L���̎g�p�� SE �����t
          $game_system.se_play(@skill.menu_se)
          # SP ����
          @actor.sp -= @skill.sp_cost
          # �g�p�҂��L�^
          $game_temp.skilluse_actor = $game_party.party_actors[@select_index]
          # �e�E�B���h�E�̓��e���č쐬
          @center_window.refresh
          @target_window.refresh
          @center_window.visible = false
          # �}�b�v��ʂɐ؂�ւ�
          @fade_flag = 9
          return
        end
      end
      return
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�^�[�Q�b�g�E�B���h�E���A�N�e�B�u�̏ꍇ)
  #--------------------------------------------------------------------------
  def update_skill_target_active
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �^�[�Q�b�g�E�B���h�E������
      @center_window.visible = true
      @center_window.active = true
      @target_window.visible = false
      @target_window.active = false
      return
    end
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # SP �؂�ȂǂŎg�p�ł��Ȃ��Ȃ����ꍇ
      unless @actor.skill_can_use?(@skill.id)
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      # �^�[�Q�b�g���S�̂̏ꍇ
      if @target_window.index == -1
        # �p�[�e�B�S�̂ɃX�L���̎g�p���ʂ�K�p
        used = false
        for i in $game_party.party_actors
          used |= i.skill_effect(@actor, @skill)
        end
      end
      # �^�[�Q�b�g���g�p�҂̏ꍇ
      if @target_window.index <= -2
        # �^�[�Q�b�g�̃A�N�^�[�ɃX�L���̎g�p���ʂ�K�p
        target = $game_party.party_actors[@target_window.index + 10]
        used = target.skill_effect(@actor, @skill)
      end
      # �^�[�Q�b�g���P�̂̏ꍇ
      if @target_window.index >= 0
        # �^�[�Q�b�g�̃A�N�^�[�ɃX�L���̎g�p���ʂ�K�p
        target = $game_party.party_actors[@target_window.index]
        used = target.skill_effect(@actor, @skill)
      end
      # �X�L�����g�����ꍇ
      if used
        # �X�L���̎g�p�� SE �����t
        $game_system.se_play(@skill.menu_se)
        # SP ����
        @actor.sp -= @skill.sp_cost
        # �e�E�B���h�E�̓��e���č쐬
        @center_window.refresh
        @center_window1.refresh
        @target_window.refresh
        center_refresh
        # �S�ł̏ꍇ
        if $game_party.all_dead?
          # �Q�[���I�[�o�[��ʂɐ؂�ւ�
          $scene = Scene_Gameover.new
          return
        end
        # �R�����C�x���g ID ���L���̏ꍇ
        if @skill.common_event_id > 0
          # �R�����C�x���g�Ăяo���\��
          $game_temp.common_event_id = @skill.common_event_id
          # �g�p�҂��L�^
          $game_temp.skilluse_actor = $game_party.party_actors[@select_index]
          @center_window.visible = false
          # �}�b�v��ʂɐ؂�ւ�
          @fade_flag = 9
          return
        end
      end
      # �X�L�����g��Ȃ������ꍇ
      unless used
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
      end
      return
    end
  end
end