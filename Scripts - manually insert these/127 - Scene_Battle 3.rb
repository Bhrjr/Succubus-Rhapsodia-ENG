#==============================================================================
# �� Scene_Battle (������` 3)
#------------------------------------------------------------------------------
# �@�o�g����ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Battle
  #--------------------------------------------------------------------------
  # �� �A�N�^�[�R�}���h�t�F�[�Y�J�n
  #--------------------------------------------------------------------------
  def start_phase3
    # �t�F�[�Y 3 �Ɉڍs
    @phase = 3
    # �A�N�^�[���I����Ԃɐݒ�
    @actor_index = -1
    @active_battler = nil
    # ���̃A�N�^�[�̃R�}���h���͂�
    phase3_next_actor
    
    $game_temp.in_battle_change = true
    
    # �A�N�^�[�R�}���h�t�F�[�Y��temp�t���O�𗧂Ă�
    # �i���̃t�F�[�Y���̃G���[���b�Z�[�W���o�b�N���O�ɋL�^�����Ȃ����߁j
    $game_temp.battle_actor_command_flag = true


  end
  #--------------------------------------------------------------------------
  # �� ���̃A�N�^�[�̃R�}���h���͂�
  #--------------------------------------------------------------------------
  def phase3_next_actor
    # ���[�v
    begin
      # �A�N�^�[�̖��ŃG�t�F�N�g OFF
      if @active_battler != nil
        @active_battler.blink = false
      end
      # �Ō�̃A�N�^�[�̏ꍇ
      if @actor_index == $game_party.actors.size-1
        # ���C���t�F�[�Y�J�n
        $game_temp.arrow_actor = nil
        # �A�N�^�[�R�}���h�t�F�[�Y��temp�t���O��؂�
        $game_temp.battle_actor_command_flag = false
        start_phase4
        return
      end
      # �A�N�^�[�̃C���f�b�N�X��i�߂�
      @actor_index += 1
      @active_battler = $game_party.actors[@actor_index]
      @active_battler.blink = true
      $game_temp.arrow_actor = @active_battler
    # �A�N�^�[���R�}���h���͂��󂯕t���Ȃ���ԂȂ������x
    end until @active_battler.inputable?
    # �A�N�^�[�R�}���h�E�B���h�E���Z�b�g�A�b�v
    phase3_setup_command_window
  end
  #--------------------------------------------------------------------------
  # �� �O�̃A�N�^�[�̃R�}���h���͂�
  #--------------------------------------------------------------------------
  def phase3_prior_actor
    # ���[�v
    begin
      # �A�N�^�[�̖��ŃG�t�F�N�g OFF
      if @active_battler != nil
        @active_battler.blink = false
      end
      # �ŏ��̃A�N�^�[�̏ꍇ
      if @actor_index == 0
        # �p�[�e�B�R�}���h�t�F�[�Y�J�n
        $game_temp.arrow_actor = nil
        start_phase3
        return
      end
      # �A�N�^�[�̃C���f�b�N�X��߂�
      @actor_index -= 1
      @active_battler = $game_party.actors[@actor_index]
      @active_battler.blink = true
      $game_temp.arrow_actor = @active_battler
    # �A�N�^�[���R�}���h���͂��󂯕t���Ȃ���ԂȂ������x
    end until @active_battler.inputable?
    # �A�N�^�[�R�}���h�E�B���h�E���Z�b�g�A�b�v
    phase3_setup_command_window
  end
  #--------------------------------------------------------------------------
  # �� �A�N�^�[�R�}���h�E�B���h�E�̃Z�b�g�A�b�v
  #--------------------------------------------------------------------------
  def phase3_setup_command_window
    # �p�[�e�B�R�}���h�E�B���h�E�𖳌���
#    @party_command_window.active = false
#    @party_command_window.visible = false
    # �A�N�^�[�R�}���h�E�B���h�E��L����

#    @actor_command_window.active = true
#    @actor_command_window.visible = true
    # �A�N�^�[�R�}���h�E�B���h�E�̈ʒu��ݒ�
    @actor_command_window.x = @actor_index * 160
    @actor_command_window.fade_flag = 1
    # �C���f�b�N�X�� 0 �ɐݒ�
    @actor_command_window.index = 0
    
    @actor_command_window.refresh
    command_all_active
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�^�[�R�}���h�t�F�[�Y)
  #--------------------------------------------------------------------------
  def update_phase3
#    @battle_log_window.contents.clear
#    @battle_log_window.keep_flag = false
#    $game_temp.battle_log_text = ""

=begin
    # �z�[���h�|�b�v���\���ɂ���B
    if Input.trigger?(Input::L)
      # �t���O�𔽓]������B���l�i^=true�Ő^�U���]�j
      @hold_pops_display ^= true
      hold_pops_display_check(@hold_pops_display)
    end
=end

    # �G�l�~�[�A���[���L���̏ꍇ
    if @enemy_arrow != nil
      update_phase3_enemy_select
    # �A�N�^�[�A���[���L���̏ꍇ
    elsif @actor_arrow != nil
      update_phase3_actor_select
    # �X�L���E�B���h�E���L���̏ꍇ
    elsif @skill_window != nil
      update_phase3_skill_select
    # �A�C�e���E�B���h�E���L���̏ꍇ
    elsif @item_window != nil
      update_phase3_item_select
    # �p�[�e�B�E�B���h�E���L���̏ꍇ
    elsif @party_window != nil
      update_phase3_party_select
    # �A�N�^�[�R�}���h�E�B���h�E���L���̏ꍇ
    elsif @actor_command_window.active
      update_phase3_basic_command
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�^�[�R�}���h�t�F�[�Y : ��{�R�}���h)
  #--------------------------------------------------------------------------
  def update_phase3_basic_command
    @window_flag = true
    $game_temp.error_message = ""
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      if @actor_index == 0
        return
      end
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �O�̃A�N�^�[�̃R�}���h���͂�
      phase3_prior_actor
      @window_flag = false
      return
    end

    # �z�[���h�|�b�v��\������B
    if Input.trigger?(Input::UP) or Input.trigger?(Input::DOWN)
      # �t���O�𔽓]������B���l�i^=true�Ő^�U���]�j
      @hold_pops_display ^= true
      hold_pops_display_check(@hold_pops_display)
    end
    
    
    # A �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::A)
      $game_temp.check_result_list = SR_Util.make_condition_text(@active_battler)
      common_event = $data_common_events[51]
      $game_system.battle_interpreter.setup(common_event.list, 0)
      @window_flag = false
      return
    end

    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)

      # �A�N�^�[�R�}���h�E�B���h�E�̃J�[�\���ʒu�ŕ���
      case @actor_command_window.index
      when 0  # �X�L��
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        # �A�N�V������ݒ�
        @active_battler.current_action.kind = 1
        # �X�L���̑I�����J�n
        start_skill_select
      when 1  # �A�C�e��
        if @active_battler.holding?
          # �u�U�[ SE �����t
          $game_system.se_play($data_system.buzzer_se)
          $game_temp.message_text = "�z�[���h���̓A�C�e�����g���Ȃ��I"
          $game_temp.script_message = true
          @window_flag = false
          return
        end
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        # �A�N�V������ݒ�
        @active_battler.current_action.kind = 2
        # �A�C�e���̑I�����J�n
        start_item_select
      when 2  # �p�[�e�B�Ґ�
        if $game_system.partyform_permit
          # ���� SE �����t
          $game_system.se_play($data_system.decision_se)
          # �p�[�e�B�Ґ��t�F�[�Y�J�n
          start_party_select
        else
          # �u�U�[ SE �����t
          $game_system.se_play($data_system.buzzer_se)
        end
        @window_flag = false
        return
      when 3  # ����
        # ���� SE �����t
        if not $game_temp.battle_can_escape
          # �u�U�[ SE �����t
          $game_system.se_play($data_system.buzzer_se)
          $game_temp.message_text = "Can't escape from this battle!"
          $game_temp.script_message = true
          @window_flag = false
          return
        else
          # �S�͂ݒ��͓����s�\
          if $incense.exist?("�S�͂�", 0)
            # �u�U�[ SE �����t
            $game_system.se_play($data_system.buzzer_se)
            $game_temp.message_text = "��딯��������Ă��ē������Ȃ��I"
            $game_temp.script_message = true
            @window_flag = false
            return
          end
          # �z�[���h����Ă��鎞�͓����s�\
          for actor in $game_party.actors
            if actor.holding?
              # �u�U�[ SE �����t
              $game_system.se_play($data_system.buzzer_se)
              $game_temp.message_text = "Can't escape because #{actor.name} is engaged in a hold!"
              $game_temp.script_message = true
              @window_flag = false
              return
            end
          end
        end
        $game_system.se_play($data_system.decision_se)
        @active_battler.current_action.kind = 0
        @active_battler.current_action.basic = 2
        phase3_next_actor
#        # �A�N�V������ݒ�
#        @active_battler.current_action.kind = 2
#        # �A�C�e���̑I�����J�n
#        start_item_select
       end
       @window_flag = false
     return
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�^�[�R�}���h�t�F�[�Y : �X�L���I��)
  #--------------------------------------------------------------------------
  def update_phase3_skill_select
    # �X�L���E�B���h�E������Ԃɂ���
    @skill_window.visible = true
    # �X�L���E�B���h�E���X�V
    @skill_window.update
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �X�L���̑I�����I��
      end_skill_select
      return
    end
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # �X�L���E�B���h�E�Ō��ݑI������Ă���f�[�^���擾
      @skill = @skill_window.skill
      # ���I�������X�L�����ꎞ�I�ɋL��
      $game_temp.skill_selection = @skill
      # ���I�������X�L�����A�N�^�[���ɋL�����A����̃J�[�\�����킹�Ɏg�p
      # �֘A���l���A�N�^�[�ɂ����Ȃ��̂ŁA�O�̂��߃G���[�����΍�
      if @active_battler.is_a?(Game_Actor)
        # �V�X�e���y�[�W�Łu�J�[�\���ʒu�L���v���n�m�ɂȂ��Ă���ꍇ
        if $game_system.system_arrow == true
          @active_battler.skill_collect = $game_temp.skill_selection
        else
          @active_battler.skill_collect = nil
        end
      end
      # �g�p�ł��Ȃ��ꍇ
      if @skill == nil or not @active_battler.skill_can_use?(@skill.id)
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        # ���G���[���b�Z�[�W��\��
        $game_temp.message_text = $game_temp.error_message if $game_temp.error_message != ""
        $game_temp.error_message = ""
        return
      end
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # �A�N�V������ݒ�
      @active_battler.current_action.skill_id = @skill.id
      # �X�L���E�B���h�E��s����Ԃɂ���
      @skill_window.visible = false
      @skill_window.window.visible = false #��
      # ���ʔ͈͂��G�P�̂̏ꍇ
      if @skill.scope == 1
        # �G�l�~�[�̑I�����J�n
        start_enemy_select
      # ���ʔ͈͂������P�̂̏ꍇ
      elsif @skill.scope == 3 or @skill.scope == 5
        # �A�N�^�[�̑I�����J�n
        start_actor_select
      # ���ʔ͈͂��P�̂ł͂Ȃ��ꍇ
      else
        # �X�L���̑I�����I��
        end_skill_select
        # ���̃A�N�^�[�̃R�}���h���͂�
        phase3_next_actor
      end
      return
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�^�[�R�}���h�t�F�[�Y : �A�C�e���I��)
  #--------------------------------------------------------------------------
  def update_phase3_item_select
    # �A�C�e���E�B���h�E������Ԃɂ���
    @item_window.visible = true
    # �A�C�e���E�B���h�E���X�V
    @item_window.update
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �A�C�e���̑I�����I��
      end_item_select
      return
    end
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # �A�C�e���E�B���h�E�Ō��ݑI������Ă���f�[�^���擾
      @item = @item_window.item
      # ���I�������A�C�e�����ꎞ�I�ɋL��
      $game_temp.skill_selection = @item
      # �g�p�ł��Ȃ��ꍇ
      unless $game_party.item_can_use?(@item.id)
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        # ���G���[���b�Z�[�W��\��
        $game_temp.message_text = $game_temp.error_message if $game_temp.error_message != ""
        $game_temp.error_message = ""
        return
      end
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # �A�N�V������ݒ�
      @active_battler.current_action.item_id = @item.id
      # �A�C�e���E�B���h�E��s����Ԃɂ���
      @item_window.visible = false
      @item_window.window.visible = false #��
      # ���ʔ͈͂��G�P�̂̏ꍇ
      if @item.scope == 1
        # �G�l�~�[�̑I�����J�n
        start_enemy_select
      # ���ʔ͈͂������P�̂̏ꍇ
      elsif @item.scope == 3 or @item.scope == 5
        # �A�N�^�[�̑I�����J�n
        start_actor_select
      # ���ʔ͈͂��P�̂ł͂Ȃ��ꍇ
      else
        # �A�C�e���̑I�����I��
        end_item_select
        # ���̃A�N�^�[�̃R�}���h���͂�
        phase3_next_actor
      end
      return
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�^�[�R�}���h�t�F�[�Y : �p�[�e�B�I��)
  #--------------------------------------------------------------------------
  def update_phase3_party_select
    
    # �m�F�E�B���h�E���\������Ă��鎞�͂�����̃t���[���X�V���s��
    if @party_check[0].visible == true or @party_check[1].visible == true
      update_phase3_party_select_check
      return
    end
    # �p�[�e�B�E�B���h�E������Ԃɂ���
    @party_window.visible = true
    # �p�[�e�B�E�B���h�E���X�V
    @party_window.update
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �p�[�e�B�̑I�����I��
      end_party_select
      return
    end
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # �m�F�E�B���h�E��\��
      # �s��������l���A�I�𒆂̖��������łɐ퓬�ɏo�Ă���ꍇ
      if @active_battler == $game_actors[101] or
       $game_party.battle_actors.include?($game_party.party_actors[@party_window.index])
#        @active_battler == $game_actors[101] \
#       or @party_window.index == 0 \
#       or @party_window.index == 1
        @party_check[0].visible = true
        @party_check[0].active = true
        @party_check[0].index = 0
      else
        @party_check[1].visible = true
        @party_check[1].active = true
        @party_check[1].index = 0
      end
      return
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�^�[�R�}���h�t�F�[�Y : �p�[�e�B�I���̊m�F��
  #--------------------------------------------------------------------------
  def update_phase3_party_select_check
    
    if @party_check[0].visible == true
      @party_check[0].update
      # C �{�^���������ꂽ�ꍇ
      if Input.trigger?(Input::C)
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        case @party_check[0].index
        when 0 # �X�e�[�^�X
          Graphics.freeze
          scene = Scene_Partychange.new(2, @party_window.index)
          scene.main
          @party_check[0].visible = false
          @party_check[0].active = false
          @spriteset.refresh_actor_sprites
          @spriteset.update
          @status_window.refresh
          Graphics.transition(8)
        when 1 # �L�����Z��
          @party_check[0].visible = false
          @party_check[0].active = false
        end
        return
      end
    elsif @party_check[1].visible == true
      @party_check[1].update
      # C �{�^���������ꂽ�ꍇ
      if Input.trigger?(Input::C)
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        case @party_check[1].index
        when 0 # �X�e�[�^�X
          Graphics.freeze
          scene = Scene_Partychange.new(2, @party_window.index)
          scene.main
          @party_check[1].visible = false
          @party_check[1].active = false
          @spriteset.refresh_actor_sprites
          @spriteset.update
          @status_window.refresh
          Graphics.transition(8)
        when 1 # ���̖����ƌ��
          # �|��Ă��閲���̏ꍇ�̓u�U�[
          if $game_party.party_actors[@party_window.index].dead?
            # �u�U�[ SE �����t
            $game_system.se_play($data_system.buzzer_se)
            $game_temp.message_text = "This succubus cannot be s��itched out!"
            $game_temp.script_message = true
            @window_flag = false
            return
          end
          # �S�͂ݒ��͓����s�\
          if $incense.exist?("�S�͂�", 0)
            # �u�U�[ SE �����t
            $game_system.se_play($data_system.buzzer_se)
            $game_temp.message_text = "��딯��������Ă��Č�シ�邱�Ƃ��ł��Ȃ��I"
            $game_temp.script_message = true
            @window_flag = false
            return
          end
          # �z�[���h����Ă��鎞�͓����s�\
          if @active_battler.holding?
            # �u�U�[ SE �����t
            $game_system.se_play($data_system.buzzer_se)
            $game_temp.message_text = "Can't switch out when engaged in a hold!"
            $game_temp.script_message = true
            @window_flag = false
            return
          end
          @party_check[1].visible = false
          @party_check[1].active = false
          # �s�������Z�b�g
          @active_battler.current_action.kind = 0
          @active_battler.current_action.basic = 5
          for i in 0...$game_party.party_actors.size
            if $game_party.party_actors[i] == @active_battler
              n = [i, @party_window.index]
              @active_battler.change_index = n
              break
            end
          end
          # �p�[�e�B�̑I�����I��
          end_party_select
          # ���̃A�N�^�[�̃R�}���h���͂�
          phase3_next_actor
        when 2 # �L�����Z��
          @party_check[1].visible = false
          @party_check[1].active = false
        end
        return
      end
      
    end
    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �p�[�e�B�̑I�����I��
      @party_check[0].visible = false
      @party_check[0].active = false
      @party_check[1].visible = false
      @party_check[1].active = false
      return
    end

  end
  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�^�[�R�}���h�t�F�[�Y : �G�l�~�[�I��)
  #--------------------------------------------------------------------------
  def update_phase3_enemy_select
    # �G�l�~�[�A���[���X�V
    @enemy_arrow.update
    
    # ���G�l�~�[�̕\����Ԃ̕ύX
    enemies_display(@enemy_arrow.enemy)
    
    # A �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::A)
      $game_temp.check_result_list = SR_Util.make_condition_text(@enemy_arrow.enemy)
      common_event = $data_common_events[51]
      $game_system.battle_interpreter.setup(common_event.list, 0)
      return
    end

    # F8 �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::F8) and $DEBUG
      SR_Util.make_succubus_message(@enemy_arrow.enemy)
    end
    
    # �z�[���h�|�b�v��\������B
    if Input.trigger?(Input::UP) or Input.trigger?(Input::DOWN)
      # �t���O�𔽓]������B���l�i^=true�Ő^�U���]�j
      @hold_pops_display ^= true
      hold_pops_display_check(@hold_pops_display)
    end

    
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �G�l�~�[�̑I�����I��
      end_enemy_select
      # ���R�}���h�E�B���h�E�̓A�N�e�B�u�ɂ��Ȃ��B
      @actor_command_window.active = false
      # ���E�B���h�E�̌��т��o��
      if @skill_window != nil
        @skill_window.window.visible = true #��
      elsif @item_window != nil
        @item_window.window.visible = true #��
      end
      return
    end
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      
      # command�ϐ��Ɋi�[�i�X�L���̏ꍇ�̓X�L���A�A�C�e���̏ꍇ�̓A�C�e���j
      # �X�L���E�B���h�E�\�����̏ꍇ
      if @skill_window != nil
        command = @skill
      end
      # �A�C�e���E�B���h�E�\�����̏ꍇ
      if @item_window != nil
        # �A�C�e���̑I�����I��
        command = @item
      end

      #----------------------------------------------------------------
      # �� �G���[�W
      #----------------------------------------------------------------
      
      # ������F���ߒ��s�̃X�L���̏ꍇ
      if command.element_set.include?(178)
      #----------------------------------------------------------------
        #�}���n�U���̏ꍇ�A���肪���蔼�E����ԂȂ犸�s�\
        #(���������}����������)
        if command.element_set.include?(134) and (command.element_set.include?(94) or command.element_set.include?(95) or command.element_set.include?(97))
          unless (@enemy_arrow.enemy.insertable_half_nude? or @enemy_arrow.enemy.full_nude?)
            $game_temp.error_message = "Can't use unless target is co��pletely nude!"
            return
          end
#        elsif command.element_set.include?(37) or command.element_set.include?(38)
#          unless (@enemy_arrow.enemy.insertable_half_nude? or @enemy_arrow.enemy.full_nude?)
#            $game_temp.error_message = "���肪����E���ł��Ȃ��Ǝg�p�ł��܂���I"
#            return
#          end
        # ���肪���ߏ�Ԃł���ꍇ
        elsif not @enemy_arrow.enemy.full_nude?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "Can't use unless target is co��pletely nude!"
          $game_temp.script_message = true
          return
        end
      end

      # ������F�E�ߒ��s�̃X�L���̏ꍇ
      if command.element_set.include?(180)
      #----------------------------------------------------------------
        # ���肪����Ԃł���ꍇ
        if @enemy_arrow.enemy.full_nude?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "���肪���𒅂Ă��Ȃ��Ǝg�p�ł��܂���I"
          $game_temp.script_message = true
          return
        end
      end

      # ������F����L���s�̃X�L���̏ꍇ
      if command.element_set.include?(141)
      #----------------------------------------------------------------
        # ����̃y�j�X�����ɒN���ɐ�L����Ă���ꍇ
        if @enemy_arrow.enemy.hold.penis.battler != nil
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����̃y�j�X�����ɐ�L����Ă��邽�ߎg�p�ł��܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ������F����L���s�̃X�L���̏ꍇ
      if command.element_set.include?(147)
      #----------------------------------------------------------------
        # ���肪�}�����̏ꍇ
        if @enemy_arrow.enemy.hold.mouth.battler != nil
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����̌������ɐ�L����Ă��邽�ߎg�p�ł��܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ������F�K��L���s�̃X�L���̏ꍇ
      if command.element_set.include?(152)
      #----------------------------------------------------------------
        # ���肪�}�����̏ꍇ
        if @enemy_arrow.enemy.hold.anal.battler != nil
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����̂��K�����ɐ�L����Ă��邽�ߎg�p�ł��܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ������F�A�\�R��L���s�̃X�L���̏ꍇ
      if command.element_set.include?(156)
      #----------------------------------------------------------------
        # ���肪�}�����̏ꍇ
        if @enemy_arrow.enemy.hold.vagina.battler != nil
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����̃A�\�R�����ɐ�L����Ă��邽�ߎg�p�ł��܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ������F�㔼�g��L���s�̃X�L���̏ꍇ
      if command.element_set.include?(162)
      #----------------------------------------------------------------
        # ���肪�}�����̏ꍇ
        if @enemy_arrow.enemy.hold.tops.battler != nil
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����̏㔼�g�����ɐ�L����Ă��邽�ߎg�p�ł��܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ������F�K����L���s�̃X�L���̏ꍇ
      if command.element_set.include?(166)
      #----------------------------------------------------------------
        # ���肪�}�����̏ꍇ
        if @enemy_arrow.enemy.hold.tail.battler != nil
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����̐K�������ɐ�L����Ă��邽�ߎg�p�ł��܂���I"
          $game_temp.script_message = true
          return
        end
      end
      
      # ���}�����̂݉̃X�L���̏ꍇ
      if command.element_set.include?(142) or command.element_set.include?(167) or command.element_set.include?(172) or command.element_set.include?(183)
      #----------------------------------------------------------------
        # ���肪�}����ԂŖ����ꍇ
        unless @enemy_arrow.enemy.vagina_insert? or @enemy_arrow.enemy.vagina_insert_special?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����Ƒ}�����łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ���������̂݉̃X�L���̏ꍇ
      if command.element_set.include?(143) or command.element_set.include?(168) or command.element_set.include?(173) or command.element_set.include?(184)
      #----------------------------------------------------------------
        # ���肪������ԂŖ����ꍇ
        unless @enemy_arrow.enemy.mouth_oralsex? or @enemy_arrow.enemy.mouth_oralsex_special?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����ƌ������łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ���芭���̂݉̃X�L���̏ꍇ
      if command.element_set.include?(144) or command.element_set.include?(169) or command.element_set.include?(174) or command.element_set.include?(185)
      #----------------------------------------------------------------
        # ���肪�芭��ԂŖ����ꍇ
        unless @enemy_arrow.enemy.anal_analsex?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "������芭���łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ����R�撆�̂݉̃X�L���̏ꍇ
      if command.element_set.include?(149)
      #----------------------------------------------------------------
        # ���肪�R���ԂŖ����ꍇ
        unless @enemy_arrow.enemy.vagina_riding?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "���肪�R�撆�łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ���R�撆�̂݉̃X�L���̏ꍇ
      if command.element_set.include?(158)
      #----------------------------------------------------------------
        # ����ɋR���ԂŖ����ꍇ
        unless @enemy_arrow.enemy.mouth_riding?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����ɋR�撆�łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ����K�R�撆�̂݉̃X�L���̏ꍇ
      if command.element_set.include?(145)
      #----------------------------------------------------------------
        # ����ɋR���ԂŖ����ꍇ
        unless @enemy_arrow.enemy.anal_hipriding?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "���肪�R�撆�łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ���K�R�撆�̂݉̃X�L���̏ꍇ
      if command.element_set.include?(154)
      #----------------------------------------------------------------
        # ���肪�R���ԂŖ����ꍇ
        unless @enemy_arrow.enemy.mouth_hipriding?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����ɋR�撆�łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ���L���킹���̂݉̃X�L���̏ꍇ
      if command.element_set.include?(159)
      #----------------------------------------------------------------
        # ���肪�L���킹��ԂŖ����ꍇ
        unless @enemy_arrow.enemy.shellmatch?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����ƊL���킹���łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ���N���j���̂݉̃X�L���̏ꍇ
      if command.element_set.include?(150)
      #----------------------------------------------------------------
        # ���肪�N���j��ԂŖ����ꍇ
        unless @enemy_arrow.enemy.vagina_draw?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����Ɍ������łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ��D�L�b�X���̂݉̃X�L���̏ꍇ
      if command.element_set.include?(170)
      #----------------------------------------------------------------
        # ���肪D�L�b�X��ԂŖ����ꍇ
        unless @enemy_arrow.enemy.deepkiss?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����ƃL�b�X���łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ���ςӂςӒ��̂݉̃X�L���̏ꍇ
      if command.element_set.include?(171)
      #----------------------------------------------------------------
        # ���肪�ςӂςӏ�ԂŖ����ꍇ
        unless @enemy_arrow.enemy.mouth_pahupahu?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "�������i���łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ���S�����̂݉̃X�L���̏ꍇ
      if command.element_set.include?(163)
      #----------------------------------------------------------------
        # ���肪�S����ԂŖ����ꍇ
        unless (@enemy_arrow.enemy.tops_binder? or @enemy_arrow.enemy.tops_binding?)
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "����Ɩ������łȂ��Ǝg���܂���I"
          $game_temp.script_message = true
          return
        end
      end
      # ���z�[���h�����X�L��
      if command.is_a?(RPG::Skill) and (command.id == 28 or command.id == 29)
      #----------------------------------------------------------------
        # ���肪�{�C��Ԃő}�����Ă���ꍇ
        if @enemy_arrow.enemy.earnest and @enemy_arrow.enemy.vagina_insert?
          $game_system.se_play($data_system.cancel_se)
          $game_temp.message_text = "�ޏ����瓦���Ă͂����Ȃ��I"
          $game_temp.script_message = true
          return
        end
      end

      #----------------------------------------------------------------

      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # �A�N�V������ݒ�
      @active_battler.current_action.target_index = @enemy_arrow.index
      # �G�l�~�[�̑I�����I��
      end_enemy_select
      # �X�L���E�B���h�E�\�����̏ꍇ
      if @skill_window != nil
        # �X�L���̑I�����I��
        end_skill_select
      end
      # �A�C�e���E�B���h�E�\�����̏ꍇ
      if @item_window != nil
        # �A�C�e���̑I�����I��
        end_item_select
      end
      # ���̃A�N�^�[�̃R�}���h���͂�
      phase3_next_actor
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�^�[�R�}���h�t�F�[�Y : �A�N�^�[�I��)
  #--------------------------------------------------------------------------
  def update_phase3_actor_select
    # �A�N�^�[�A���[���X�V
    @actor_arrow.update

    # �z�[���h�|�b�v��\������B
    if Input.trigger?(Input::UP) or Input.trigger?(Input::DOWN)
      # �t���O�𔽓]������B���l�i^=true�Ő^�U���]�j
      @hold_pops_display ^= true
      hold_pops_display_check(@hold_pops_display)
    end


    # A �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::A)
       # �X�e�[�g���̕�������쐬
       text = ""
       # �P�s�ɕ\�����Ă���X�e�[�g�����쐬
       state_set = 0
       for i in @actor_arrow.actor.states
        if $data_states[i].rating >= 1
          if state_set == 0
            text = "�@" + $data_states[i].name
            state_set += 1
          else
            new_text = text + "/" + $data_states[i].name
            state_set += 1
            text = new_text
            # �P�s�ɃX�e�[�g���T�`�悵������s
            if state_set == 7
              text += "\n�@"
              state_set = 0
            end
          end
        end
      end
      # �X�e�[�g���̕����񂪋�̏ꍇ�� "�X�e�[�g����" �ɂ���
      if text == ""
        text = "�@����"
      end
      text_base = "�y��ԁz\n"
      text = text_base + text
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # ���������������\��
      $game_temp.message_text = text
      $game_temp.script_message = true
      return
    end
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �A�N�^�[�̑I�����I��
      end_actor_select
      # ���R�}���h�E�B���h�E�̓A�N�e�B�u�ɂ��Ȃ��B
      @actor_command_window.active = false
      # ���E�B���h�E�̌��т��o��
      if @skill_window != nil
        @skill_window.window.visible = true #��
      elsif @item_window != nil
        @item_window.window.visible = true #��
      end
      return
    end
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # �A�N�V������ݒ�
      @active_battler.current_action.target_index = @actor_arrow.index
      # �A�N�^�[�̑I�����I��
      end_actor_select
      # �X�L���E�B���h�E�\�����̏ꍇ
      if @skill_window != nil
        # �X�L���̑I�����I��
        end_skill_select
      end
      # �A�C�e���E�B���h�E�\�����̏ꍇ
      if @item_window != nil
        # �A�C�e���̑I�����I��
        end_item_select
      end
      # ���̃A�N�^�[�̃R�}���h���͂�
      phase3_next_actor
    end
  end
  #--------------------------------------------------------------------------
  # �� �G�l�~�[�I���J�n
  #--------------------------------------------------------------------------
  def start_enemy_select
    # �G�l�~�[�A���[���쐬
    @enemy_arrow = Arrow_Enemy.new(@spriteset.viewport1)
    # �w���v�E�B���h�E���֘A�t��
    @enemy_arrow.help_window = @help_window
    # �A�N�^�[�R�}���h�E�B���h�E�𖳌���
    @actor_command_window.active = false
    @actor_command_window.visible = false
    
    if @active_battler.current_action.kind == 1
      skill_element_set = $data_skills[@active_battler.current_action.skill_id].element_set
    elsif @active_battler.current_action.kind == 2
      skill_element_set = $data_items[@active_battler.current_action.item_id].element_set
    end
    go_flag = false

    for i in 0...$game_troop.enemies.size
      
      enemy_one = $game_troop.enemies[i]
      
      # �X�L���ȊO�͏ȗ�
      break if @active_battler.current_action.kind != 1
      # ���̃G�l�~�[�����Ȃ��ꍇ�͎�
      next unless enemy_one.exist?

      #���}�����Ώۂ̃A�\�R�����}�����
      go_flag = true if skill_element_set.include?(142) and enemy_one.vagina_insert?
      #���}�����Ώۂ̌����������
      go_flag = true if skill_element_set.include?(143) and enemy_one.mouth_oralsex?
      #����}�����Ώۂ̃y�j�X���������(�K���A�G��A�f�B���h����ł͔������������Ȃ�����)
      go_flag = true if skill_element_set.include?(148) and enemy_one.penis_analsex?
      #��R�恁�Ώۂ̃A�\�R���R����
      go_flag = true if skill_element_set.include?(149) and enemy_one.vagina_riding?
      #��K�R�恁�Ώۂ̐K���K�R����
      go_flag = true if skill_element_set.include?(145) and enemy_one.anal_hipriding?
      #��K�}�����Ώۂ̃y�j�X���芭���(�K���A�G��A�f�B���h����ł͔������������Ȃ�����)
      go_flag = true if skill_element_set.include?(153) and enemy_one.penis_analsex?
      #�큊�}�����Ώۂ̃y�j�X���}�����
      go_flag = true if skill_element_set.include?(157) and enemy_one.penis_insert?
      #�R�恁�Ώۂ̌����R����
      go_flag = true if skill_element_set.include?(158) and enemy_one.mouth_riding?
      #�K�R�恁�Ώۂ̌����K�R����
      go_flag = true if skill_element_set.include?(154) and enemy_one.mouth_hipriding?
      #�L���킹���Ώۂ̃A�\�R���L���킹���
      go_flag = true if skill_element_set.include?(159) and enemy_one.shellmatch?
      #�N���j���Ώۂ̃A�\�R���N���j���
      go_flag = true if skill_element_set.include?(150) and enemy_one.vagina_draw?
      #D�L�b�X���Ώۂ̌����L�b�X���
      go_flag = true if skill_element_set.include?(170) and enemy_one.deepkiss?
      #�ςӂςӁ��Ώۂ̌����ςӂςӏ��
      go_flag = true if skill_element_set.include?(171) and enemy_one.mouth_pahupahu?
      #�p�C�Y�����Ώۂ̃y�j�X���p�C�Y�����
      go_flag = true if skill_element_set.include?(160) and enemy_one.penis_paizuri?
      #�S�����Ώۂ̏㔼�g���S�����
      go_flag = true if skill_element_set.include?(163) and enemy_one.tops_binding?
      #�K�����}�����Ώۂ̃A�\�R�����}�����
      go_flag = true if skill_element_set.include?(167) and enemy_one.vagina_insert?
      #�K�����}�����Ώۂ̌����������
      go_flag = true if skill_element_set.include?(168) and enemy_one.mouth_oralsex?
      #�K���K�}�����Ώۂ̐K���芭���
      go_flag = true if skill_element_set.include?(169) and enemy_one.anal_analsex?
      #�G�聊�}�����Ώۂ̃A�\�R�����}�����
      go_flag = true if skill_element_set.include?(172) and enemy_one.vagina_insert?
      #�G����}�����Ώۂ̌����������
      go_flag = true if skill_element_set.include?(173) and enemy_one.mouth_oralsex?
      #�G��K�}�����Ώۂ̐K���芭���
      go_flag = true if skill_element_set.include?(174) and enemy_one.anal_analsex?
      #�G��S�����Ώۂ̏㔼�g���S�����
      go_flag = true if skill_element_set.include?(175) and enemy_one.tentacle_binding?
      #�c���}�����Ώۂ̃A�\�R�����q���}�����
      go_flag = true if skill_element_set.include?(183) and enemy_one.dildo_vagina_insert?
      #�c���}�����Ώۂ̌������q���}�����
      go_flag = true if skill_element_set.include?(184) and enemy_one.dildo_mouth_oralsex?
      #�c�K�}�����Ώۂ̐K�����q�K�}�����
      go_flag = true if skill_element_set.include?(185) and enemy_one.dildo_anal_analsex?
      #�G��z�����Ώۂ̃y�j�X���G��z�����
      go_flag = true if skill_element_set.include?(209) and enemy_one.tentacle_penis_absorbing?
      #�G��N���j���Ώۂ̃A�\�R���G��N���j���
      go_flag = true if skill_element_set.include?(210) and enemy_one.tentacle_vagina_draw?
      
      # ���̖����ɂ��Ă����ꍇ���̖����ɂ���
      if go_flag
        @enemy_arrow.index = i
        break
      end

    end
  end
  #--------------------------------------------------------------------------
  # �� �G�l�~�[�I���I��
  #--------------------------------------------------------------------------
  def end_enemy_select
    # �G�l�~�[�A���[�����
    @enemy_arrow.enemy.blink = false
    @enemy_arrow.dispose
    @enemy_arrow = nil
    # �R�}���h�� [�키] �̏ꍇ
    if @actor_command_window.index == 0
      # �A�N�^�[�R�}���h�E�B���h�E��L����
      @actor_command_window.active = true
      @actor_command_window.visible = true
      # �w���v�E�B���h�E���B��
      @help_window.visible = false
    end
  end
  #--------------------------------------------------------------------------
  # �� �A�N�^�[�I���J�n
  #--------------------------------------------------------------------------
  def start_actor_select
    # �A�N�^�[�A���[���쐬
    @actor_arrow = Arrow_Actor.new(@spriteset.viewport2)
    @actor_arrow.index = @actor_index
    # �w���v�E�B���h�E���֘A�t��
    @actor_arrow.help_window = @help_window
    # �A�N�^�[�R�}���h�E�B���h�E�𖳌���
    @actor_command_window.active = false
    @actor_command_window.visible = false
  end
  #--------------------------------------------------------------------------
  # �� �A�N�^�[�I���I��
  #--------------------------------------------------------------------------
  def end_actor_select
    # �A�N�^�[�A���[�����
    @actor_arrow.dispose
    @actor_arrow = nil
  end
  #--------------------------------------------------------------------------
  # �� �X�L���I���J�n
  #--------------------------------------------------------------------------
  def start_skill_select
    # �X�L���E�B���h�E���쐬
    @skill_window = Window_Skill_Battle.new(@active_battler)
    # �w���v�E�B���h�E���֘A�t��
    @skill_window.help_window = @help_window
    @help_window.window.visible = true # ��
    # �A�N�^�[�R�}���h�E�B���h�E�𖳌���
    @actor_command_window.active = false
    @actor_command_window.visible = false
    #���X�L���ʒu�L�������Ȃ��ꍇ�̓X�L�����K��̃X�L���ɍ��킹��
    unless $game_system.system_arrow == true
      if @active_battler.holding?
        for i in 0..@skill_window.item_max
          #�C���T�[�g�F��
          if @active_battler.penis_insert?
            if @skill_window.data[i].name == "�X�E�B���O"
              @skill_window.index = i
              break
            end
          #�C���T�[�g�F��
          elsif @active_battler.vagina_insert?
            if @skill_window.data[i].name == "�O���C���h"
              @skill_window.index = i
              break
            end
          #�C���T�[�g�F��
          elsif @active_battler.penis_oralsex?
            if @skill_window.data[i].name == "�I�[�����s�X�g��"
              @skill_window.index = i
              break
            end
          #��ʋR��E�K�R��i�U�j
          elsif @active_battler.vagina_riding?
            if @skill_window.data[i].name == "���C�f�B���O"
              @skill_window.index = i
              break
            end
          #��ʋR��E�K�R��i��j
          elsif @active_battler.mouth_riding? or @active_battler.mouth_hipriding?
            if @skill_window.data[i].name == "���b�N"
              @skill_window.index = i
              break
            end
          #�L���킹
          elsif @active_battler.shellmatch?
            if @skill_window.data[i].name == "�X�N���b�`"
              @skill_window.index = i
              break
            end
          #�N���j
          elsif @active_battler.mouth_draw?
            if @skill_window.data[i].name == "�T�b�N"
              @skill_window.index = i
              break
            end
          #��N���j
          elsif @active_battler.vagina_draw?
            if @skill_window.data[i].name == "�v�b�V���O"
              @skill_window.index = i
              break
            end
          #�S��
          elsif @active_battler.tops_binder?
            if @skill_window.data[i].name == "�~�X�`�[�t"
              @skill_window.index = i
              break
            end
          #��S��
          elsif @active_battler.tops_binding?
            if @skill_window.data[i].name == "���A�J���X"
              @skill_window.index = i
              break
            end
          #�f�B���h�C���T�[�g
          elsif @active_battler.dildo_insert?
            if @skill_window.data[i].name == "�f�B���h�X�E�B���O"
              @skill_window.index = i
              break
            end
          #�f�B���h�C���}�E�X
          elsif @active_battler.dildo_oralsex?
            if @skill_window.data[i].name == "�I�[�����f�B���h"
              @skill_window.index = i
              break
            end
          #�f�����Y�T�b�N
          elsif @active_battler.tentacle_draw?
            if @skill_window.data[i].name == "�f�����Y�T�b�N"
              @skill_window.index = i
              break
            end
          #��y���X�R�[�v
          elsif @active_battler.penis_paizuri?
            if @skill_window.data[i].name == "���r���O�s�X�g��"
              @skill_window.index = i
              break
            end
          #�Y�����Ȃ��ꍇ�͉����X�L���̃����[�X�ɃJ�[�\�������킹��
          else
            if @skill_window.data[i].name == "�����[�X"
              @skill_window.index = i
              break
            end
          end
        end
        #�z�[���h�Ŗ����ꍇ
      else
        for i in 0..@skill_window.item_max
        #�L�b�X�ɃJ�[�\�������킹��
          if @skill_window.data[i].name == "�L�b�X"
            @skill_window.index = i
            break
          end
        end
      end
    #���X�L���ʒu�L��������ꍇ
    else
      #�X�L���L���������ꍇ�́A�K���L�b�X�ɃZ�b�g����
      if @active_battler.skill_collect == nil or
        @active_battler.skill_collect == "" or
        (@active_battler.holding? and @active_battler.skill_collect.element_set.include?(131)) or
        (not @active_battler.holding? and @active_battler.skill_collect.element_set.include?(132))
        for i in 0..@skill_window.item_max
          if @active_battler.holding?
            #�C���T�[�g�F��
            if @active_battler.penis_insert?
              if @skill_window.data[i].name == "�X�E�B���O"
                @skill_window.index = i
                break
              end
            #�C���T�[�g�F��
            elsif @active_battler.vagina_insert?
              if @skill_window.data[i].name == "�O���C���h"
                @skill_window.index = i
                break
              end
            #�C���T�[�g�F��
            elsif @active_battler.penis_oralsex?
              if @skill_window.data[i].name == "�I�[�����s�X�g��"
                @skill_window.index = i
                break
              end
            #��ʋR��E�K�R��i�U�j
            elsif @active_battler.vagina_riding?
              if @skill_window.data[i].name == "���C�f�B���O"
                @skill_window.index = i
                break
              end
            #��ʋR��E�K�R��i��j
            elsif @active_battler.mouth_riding? or @active_battler.mouth_hipriding?
              if @skill_window.data[i].name == "���b�N"
                @skill_window.index = i
                break
              end
            #�L���킹
            elsif @active_battler.shellmatch?
              if @skill_window.data[i].name == "�X�N���b�`"
                @skill_window.index = i
                break
              end
            #�N���j
            elsif @active_battler.mouth_draw?
              if @skill_window.data[i].name == "�T�b�N"
                @skill_window.index = i
                break
              end
            #��N���j
            elsif @active_battler.vagina_draw?
              if @skill_window.data[i].name == "�v�b�V���O"
                @skill_window.index = i
                break
              end
            #�S��
            elsif @active_battler.tops_binder?
              if @skill_window.data[i].name == "�~�X�`�[�t"
                @skill_window.index = i
                break
              end
            #��S��
            elsif @active_battler.tops_binding?
              if @skill_window.data[i].name == "���A�J���X"
                @skill_window.index = i
                break
              end
            #�f�B���h�C���T�[�g
            elsif @active_battler.dildo_insert?
              if @skill_window.data[i].name == "�f�B���h�X�E�B���O"
                @skill_window.index = i
                break
              end
            #�f�B���h�C���}�E�X
            elsif @active_battler.dildo_oralsex?
              if @skill_window.data[i].name == "�I�[�����f�B���h"
                @skill_window.index = i
                break
              end
            #�f�����Y�T�b�N
            elsif @active_battler.tentacle_draw?
              if @skill_window.data[i].name == "�f�����Y�T�b�N"
                @skill_window.index = i
                break
              end
            #�Y�����Ȃ��ꍇ�͉����X�L���̃����[�X�ɃJ�[�\�������킹��
            else
              if @skill_window.data[i].name == "�����[�X"
                @skill_window.index = i
                break
              end
            end
          #��z�[���h��ԂȂ�L�b�X�ɃJ�[�\�������킹��
          else
            if @skill_window.data[i].name == "�L�b�X"
              @skill_window.index = i
              break
            end
          end
        end
      #�X�L���L��������ꍇ�A���̃X�L���ɃJ�[�\�����Z�b�g����
      else
        for i in 0..@skill_window.item_max
          if @skill_window.data[i].name == @active_battler.skill_collect.name
            @skill_window.index = i
            break
          end
        end
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �X�L���I���I��
  #--------------------------------------------------------------------------
  def end_skill_select
    # �X�L���E�B���h�E�����
    @skill_window.dispose
    @skill_window.window.dispose # ��
    @skill_window = nil
    # �w���v�E�B���h�E���B��
    @help_window.visible = false
    @help_window.window.visible = false # ��
    # �A�N�^�[�R�}���h�E�B���h�E��L����
    @actor_command_window.active = true
    @actor_command_window.visible = false #true
  end
  #--------------------------------------------------------------------------
  # �� �A�C�e���I���J�n
  #--------------------------------------------------------------------------
  def start_item_select
    # �A�C�e���E�B���h�E���쐬
    @item_window = Window_Item.new
    # �w���v�E�B���h�E���֘A�t��
    @item_window.help_window = @help_window
    @help_window.window.visible = true # ��
    # �A�N�^�[�R�}���h�E�B���h�E�𖳌���
    @actor_command_window.active = false
    @actor_command_window.visible = false
  end
  #--------------------------------------------------------------------------
  # �� �A�C�e���I���I��
  #--------------------------------------------------------------------------
  def end_item_select
    # �A�C�e���E�B���h�E�����
    @item_window.dispose
    @item_window.window.dispose # ��
    @item_window = nil
    # �w���v�E�B���h�E���B��
    @help_window.visible = false
    @help_window.window.visible = false # ��
    # �A�N�^�[�R�}���h�E�B���h�E��L����
    @actor_command_window.active = true
    @actor_command_window.visible = true
  end
  #--------------------------------------------------------------------------
  # �� �p�[�e�B�I���J�n
  #--------------------------------------------------------------------------
  def start_party_select
    # �A�C�e���E�B���h�E���쐬
    @party_window = Window_Partychange.new
    for i in 0...$game_party.party_actors.size
      if @active_battler == $game_party.party_actors[i]
        @party_window.index = i
      end
    end
#    if @active_battler == $game_actors[101]
#      @party_window.index = 0
#    else
#      @party_window.index = 1
#    end
    # �w���v�E�B���h�E���֘A�t��
    @party_window.help_window = @help_window
    @help_window.window.visible = true # ��
    
    # �m�F�E�B���h�E���쐬
    @party_check = []
    commands0 = ["�X�e�[�^�X", "�L�����Z��"]
    @party_check[0] = Window_Command.new(160, commands0)
    commands1 = ["�X�e�[�^�X", "���̖����ƌ��", "�L�����Z��"]
    @party_check[1] = Window_Command.new(160, commands1)
    for i in 0..1
      @party_check[i].back_opacity = 255
      @party_check[i].x = (640 - @party_check[i].width) / 2
      @party_check[i].y = (480 - @party_check[i].height) / 2
      @party_check[i].z = 2100
      @party_check[i].visible = false
      @party_check[i].active = false
    end
    # �A�N�^�[�R�}���h�E�B���h�E�𖳌���
    @actor_command_window.active = false
    @actor_command_window.visible = false
  end
  #--------------------------------------------------------------------------
  # �� �p�[�e�B�I���I��
  #--------------------------------------------------------------------------
  def end_party_select
    # �p�[�e�B�E�B���h�E�����
    @party_window.dispose
    @party_window = nil
    # �w���v�E�B���h�E���B��
    @help_window.visible = false
    @help_window.window.visible = false # ��
    # �m�F�E�B���h�E�����
    for check in @party_check
      check.dispose
    end
    # �A�N�^�[�R�}���h�E�B���h�E��L����
    @actor_command_window.active = true
    @actor_command_window.visible = true
  end
  #--------------------------------------------------------------------------
  # �� �p�[�e�B�I���J�n
  #--------------------------------------------------------------------------
  def start_party_select_status
  end
  #--------------------------------------------------------------------------
  # �� �p�[�e�B�I���J�n
  #--------------------------------------------------------------------------
  def end_party_select_status
  end
  #--------------------------------------------------------------------------
  # �� �A�N�^�[�R�}���h�̑S���o��
  #--------------------------------------------------------------------------
  def command_all_active
    @actor_command_window.active = true
    @actor_command_window.window.visible = true
    @actor_command_window.skill.visible = true
    @actor_command_window.item.visible = true
    @actor_command_window.change.visible = true
    @actor_command_window.escape.visible = true
    @actor_command_window.help.visible = true
    @actor_command_window.window.opacity = 51
    @actor_command_window.window.y = -12
  end
  #--------------------------------------------------------------------------
  # �� �A�N�^�[�R�}���h�̑S���o������
  #--------------------------------------------------------------------------
  def command_all_delete
    @actor_command_windowactive = false
    @actor_command_window.window.visible = false
    @actor_command_window.skill.visible = false
    @actor_command_window.item.visible = false
    @actor_command_window.change.visible = false
    @actor_command_window.escape.visible = false
    @actor_command_window.help.visible = false
  end
end
