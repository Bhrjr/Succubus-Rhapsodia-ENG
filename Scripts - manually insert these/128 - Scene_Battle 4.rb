#==============================================================================
# �� Scene_Battle (������` 4)
#------------------------------------------------------------------------------
# �@�o�g����ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Battle
  
  #--------------------------------------------------------------------------
  # �� �z�[���h�|�b�v�̏o���E��o��
  #--------------------------------------------------------------------------
  def hold_pops_display_check(bool)

    # ���ꂼ��̃o�g���[�ɕ\���t���O�𗧂Ă�B
    for battler in $game_party.battle_actors + $game_troop.enemies
      battler.hold_pops_fade = 1 if bool
      battler.hold_pops_fade = 2 unless bool
    end
  end
  #--------------------------------------------------------------------------
  # �� ���C���t�F�[�Y�J�n
  #--------------------------------------------------------------------------
  def start_phase4
    # �t�F�[�Y 4 �Ɉڍs
    @phase = 4
    # �^�[�����J�E���g
    $game_temp.battle_turn += 1
    # �o�g���C�x���g�̑S�y�[�W������
    for index in 0...$data_troops[@troop_id].pages.size
      # �C�x���g�y�[�W���擾
      page = $data_troops[@troop_id].pages[index]
      # ���̃y�[�W�̃X�p���� [�^�[��] �̏ꍇ
      if page.span == 1
        # ���s�ς݃t���O���N���A
        $game_temp.battle_event_flags[index] = false
      end
    end
    # �A�N�^�[���I����Ԃɐݒ�
    @actor_index = -1
    @active_battler = nil
    
    # �z�[���h�|�b�v���\���ɂ���B
    hold_pops_display_check(false) if @hold_pops_display
    @hold_pops_display = false
      
    #����Ǘ��n�X�C�b�`��؂��Ă���
    for i in 23..24
      $game_switches[i] = false
    end
    for i in 77..83
      $game_switches[i] = false
    end
    $game_switches[89] = false #���W�X�g����X�C�b�`
    
    # ���b�Z�[�W�\���ʒu�ύX��߂�
    $game_temp.in_battle_change = false
    
    # �p�[�e�B�R�}���h�E�B���h�E��L����
#    @party_command_window.active = false
#    @party_command_window.visible = false
    # �A�N�^�[�R�}���h�E�B���h�E�𖳌���
    command_all_delete
#    @actor_command_window.active = false
#    @actor_command_window.visible = false
    # ���C���t�F�[�Y�t���O���Z�b�g
    $game_temp.battle_main_phase = true
    
    #���o�g���g�[�N�֘A�����Z�b�g
    $game_temp.action_num = 0
    #�A�N�^�[�̖\���t���O������(�T���܂�)
    for actor in $game_party.actors
      #���\���t���O������
      if actor.berserk == true and not actor.state?(36)
        actor.berserk = false
      elsif actor.berserk == false and actor.state?(36)
        actor.berserk = true
      end
    end
    # �G�l�~�[�A�N�V�����쐬
    for enemy in $game_troop.enemies
      #���\���t���O������
      if enemy.berserk == true and not enemy.state?(36)
        enemy.berserk = false
      end
      enemy.another_action = false
      enemy_action_swicthes(enemy)
      enemy.make_action
    end
    # �G�l�~�[�̑��d�s���t���O������
    for enemy in $game_troop.enemies
#      enemy.another_action = false # ��Ɉړ�
    end
    
    # �A�N�^�[�̎g�p�^�[���Ɋ|����X�L���G�t�F�N�g
    for actor in $game_party.battle_actors
      if actor.exist? and actor.current_action.kind == 1
        # �����F�^�[�����K�[�h����
        if $data_skills[actor.current_action.skill_id].element_set.include?(197)
          # �K�[�h�X�e�[�g��t����
          actor.add_state(93)
          actor.add_states_log.clear
        end
      end
    end
    
    
    
    # ���o�g�����O�E�B���h�E���t�F�[�h�C���J�n���W��
    @battle_log_window.bgframe_sprite.opacity = 0
    @battle_log_window.bgframe_sprite.y = -12
    
    # �s�������쐬
    make_action_orders
    
    # �������ꂽ�ꍇ
    if $game_temp.first_attack_flag == 2
      # �A�N�^�[��z�� @action_battlers ����폜
      for actor in $game_party.actors
        @action_battlers.delete(actor)
      end
#      $game_temp.first_attack_flag = 0
    elsif $game_temp.first_attack_flag == 1
      # �G�l�~�[��z�� @action_battlers ����폜
      for enemy in $game_troop.enemies
        @action_battlers.delete(enemy)
      end
#      $game_temp.first_attack_flag = 0
    end
    #########################################################
    @self_data = ""          #���̎��̍s���҂̏��
    @target_data = ""        #���̎��̍U���Ώۂ̏��
    @free_text = ""          #������쐬�p�̃�����
    
    @battle_log_window.visible = false
    #@battle_log_window.set_text($game_temp.battle_turn.to_s + "�^�[���� �J�n")
    #@wait_count = 60
    #p $game_temp.battle_turn.to_s + "�^�[���� �J�n"
    #########################################################
    @wait_count = 5
    # �X�e�b�v 1 �Ɉڍs
    @phase4_step = 0
  end
  #--------------------------------------------------------------------------
  # �� �s�������쐬
  #--------------------------------------------------------------------------
  def make_action_orders
    # �z�� @action_battlers ��������
    @action_battlers = []
    # �G�l�~�[��z�� @action_battlers �ɒǉ�
    # ���d�s���p�ɂQ�g�ǉ�����(�\�����A�ؕ|�s�����͂P�g�̂�)
    for enemy in $game_troop.enemies
      @action_battlers.push(enemy)
      if enemy.berserk == false 
        @action_battlers.push(enemy)
      end
    end
    # �A�N�^�[��z�� @action_battlers �ɒǉ�
    for actor in $game_party.actors
      @action_battlers.push(actor)
    end
    # �S���̃A�N�V�����X�s�[�h������
    for battler in @action_battlers
      battler.make_action_speed
    end
    # �A�N�V�����X�s�[�h�̑傫�����ɕ��ёւ�
    @action_battlers.sort! {|a,b|
      b.current_action.speed - a.current_action.speed }
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y)
  #--------------------------------------------------------------------------
  def update_phase4
    case @phase4_step
    when 0 # ���^�[���J�n������
      update_phase4_step0
    when 101 # ���N���C�V�X��
      update_phase4_step101
    when 102 # ���X�e�[�g�p����
      update_phase4_step102
    when 104 # ���C���Z���X�p����
      update_phase4_step104
    when 1
      update_phase4_step1
    when 103 # ���^�[���I������
      update_phase4_step103
    when 105 # ������s��
      update_phase4_step105
    when 2
      update_phase4_step2
    when 3
      update_phase4_step3
    when 4
      update_phase4_step4
    when 401 #�N���C�V�X����
      update_phase4_step401
    when 402 #�r����b����
      update_phase4_step402
    when 5
      update_phase4_step5
    when 501 #���Ⓒ�X�e�b�v�O��
      update_phase4_step501
    when 502 #���Ⓒ�X�e�b�v�㔼
      update_phase4_step502
    when 503 #���z�[���h����
      update_phase4_step503
    when 504 #���A�N�^�[����ւ�����(�퓬�s�\��)
      update_phase4_step504
    when 601 #���ǌ�����
      update_phase4_step601
    when 602 # ���Ⓒ������
      update_phase4_step602
    when 6
      update_phase4_step6
    when 12 # �����W�X�g�Q�[���J�n
      update_phase4_step12
    when 13 # �����W�X�g���ۂ̌��ʍ쐬 
      update_phase4_step13
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 0 : �^�[���J�n������)
  #--------------------------------------------------------------------------
  def update_phase4_step0
    
    # �w���v�E�B���h�E���B��
    @help_window.visible = false
    # ���o�g�����O�E�B���h�E���o��
    @battle_log_window.visible = true
    @battle_log_window.bgframe_sprite.visible = true

    text = ""
    txc = 0
    # �N���C�V�X�񍐃��b�Z�[�W�\��
    for actor in $game_party.battle_actors
      if actor.exist? and actor.state?(6)
        text += $data_states[6].message($data_states[6], "report", actor, nil) + "\w\q"
        txc += 1
      end
    end
    for enemy in $game_troop.enemies
      if enemy.exist? and enemy.state?(6)
        text += $data_states[6].message($data_states[6], "report", enemy, nil) + "\w\q"
        txc += 1
      end
    end
    if text != ""
      #���V�X�e���E�F�C�g
      case $game_system.ms_skip_mode
      when 3 #�蓮���胂�[�h
        @wait_count = (txc + 1) * 4
      when 2 #�f�o�b�O���[�h
        @wait_count = 8
      when 1 #�������[�h
        @wait_count = 12
      else
        @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time + (txc * (4 + 1))
      end
      if $game_system.system_read_mode != 0
        text += "CLEAR"
        text.sub!("\w\qCLEAR","")
      end
      $game_temp.battle_log_text += text if text != ""
    end
    
    
    # �X�e�b�v 1 �Ɉڍs
    @phase4_step = 101
  end  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 101 : �X�e�[�g�p�����b�Z�[�W)
  #--------------------------------------------------------------------------
  def update_phase4_step101
    # �o�g�����O���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    ms = text = text1 = text2 = ""
    txc = 0
    for actor in $game_party.battle_actors
      if actor.exist? and not actor.dead?
#        actor.remove_states_auto
        ms = actor.bms_states_report
        text1 = (text1 + ms + "\w\q") if ms != ""
        txc += 1 if ms != ""
      end
    end
    ms = ms2 = ""
    for enemy in $game_troop.enemies
      if enemy.exist?
#        enemy.remove_states_auto
        ms = enemy.bms_states_report
        text2 = (text2 + ms + "\w\q") if ms != ""
        txc += 1 if ms != ""
      end
    end
#    text2.sub!("\w\q\w\n\w\n\w\n\w\n","\w\n") if text2.include?("\w\n\w\n\w\n\w\n\w\n")
    text = text1 + text2
    if text != ""
=begin
      #���V�X�e���E�F�C�g
      case $game_system.ms_skip_mode
      when 3 #�蓮���胂�[�h
        @wait_count = (txc + 1) * 4
      when 2 #�f�o�b�O���[�h
        @wait_count = 8
      when 1 #�������[�h
        @wait_count = 12
      else
        # �X�e�[�g�֌W�̓X�e�[�g�̐������E�F�C�g�����Z
        @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time + (txc * (4 + 1))
      end
=end
      if $game_system.system_read_mode != 0
        text += "CLEAR"
        text.sub!("\w\qCLEAR","")
      end
      $game_temp.battle_log_text += text
      #���V�X�e���E�F�C�g
      @wait_count = system_wait_make($game_temp.battle_log_text)
    end
    # �S�o�g���[�̃X�e�[�g���O�����ׂăN���A
    for battler in @battlers
      battler.add_states_log.clear
      battler.remove_states_log.clear
    end
    # �摜�ύX�t���O�𗧂Ăĉ摜�����t���b�V��
    for enemy in $game_troop.enemies
      if enemy.exist?
        enemy.graphic_change = true
      end
    end
    for actor in $game_party.party_actors
      if actor.exist?
        actor.graphic_change = true
      end
    end
    # �X�e�b�v 102 �Ɉڍs
    @phase4_step = 102
  end  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 102 : �X�e�[�g�ω����b�Z�[�W)
  #   �i�قڈ��Ő�p�j
  #--------------------------------------------------------------------------
  def update_phase4_step102
    # �o�g�����O���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    ms = text = text1 = text2 = ""
    txc = 0
    for actor in $game_party.battle_actors
      if actor.exist? and not actor.dead?
        special_mushroom_effect(actor) if actor.state?(30) #���ŕ���
        #actor.persona_break if actor.state?(106) #�j�ʕ���
        
#        actor.remove_states_auto
        ms = actor.bms_states_update
        text1 = (text1 + ms + "\w\q") if ms != ""
        txc += 1 if ms != ""
      end
    end
    ms = ms2 = ""
    for enemy in $game_troop.enemies
      if enemy.exist?
        special_mushroom_effect(enemy) if enemy.state?(30) #���ŕ���
        #enemy.persona_break if enemy.state?(106) #�j�ʕ���
#        enemy.remove_states_auto
        ms = enemy.bms_states_update
        text2 = (text2 + ms + "\w\q") if ms != ""
        txc += 1 if ms != ""
      end
    end
    text = text1 + text2
    if text != ""
      #���V�X�e���E�F�C�g
      case $game_system.ms_skip_mode
      when 3 #�蓮���胂�[�h
        @wait_count = (txc + 1) * 4
      when 2 #�f�o�b�O���[�h
        @wait_count = 8
      when 1 #�������[�h
        @wait_count = 12
      else
        # �X�e�[�g�֌W�̓X�e�[�g�̐������E�F�C�g�����Z
        @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time + (txc * (4 + 1))
      end
      if $game_system.system_read_mode != 0
        text += "CLEAR"
        text.sub!("\w\qCLEAR","")
      end
      $game_temp.battle_log_text += text
    end
    # �S�o�g���[�̃X�e�[�g���O�����ׂăN���A
    for battler in @battlers
      battler.add_states_log.clear
      battler.remove_states_log.clear
    end
    # �摜�ύX�t���O�𗧂Ăĉ摜�����t���b�V��
    for enemy in $game_troop.enemies
      if enemy.exist?
        enemy.graphic_change = true
      end
    end
    for actor in $game_party.party_actors
      if actor.exist?
        actor.graphic_change = true
      end
    end
    # �X�e�b�v 104 �Ɉڍs
    @phase4_step = 104
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 103 : �C���Z���X�ω����b�Z�[�W)
  #--------------------------------------------------------------------------
  def update_phase4_step104
    # �o�g�����O���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    #���C���Z���X���ʕ񍐂��o�͂���
    $incense.keep_text_call
    #���C���Z���X�G�t�F�N�g�𔭐�������
    incense_effect
    #���V�X�e���E�F�C�g
    if $game_temp.battle_log_text != ""
      @wait_count = system_wait_make($game_temp.battle_log_text)
    end
    # �X�e�b�v 1 �Ɉڍs
    @phase4_step = 1
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 1 : �A�N�V��������)
  #--------------------------------------------------------------------------
  def update_phase4_step1
#    p "update4-1"if $DEBUG
    #p "1a" if $debug_flag == 1
    #�Ⓒ�X�C�b�`�͐؂��Ă���
    
    # ���s����
    if judge
      # �����܂��͔s�k�̏ꍇ : ���\�b�h�I��
      return
    end
    
    # �c��̖�������������
    @last_enemies = []
    common_enemies = []
    # �g���[�v���`�F�b�N
    for enemy in $game_troop.enemies
      if enemy.exist?
        @last_enemies.push(enemy)
        common_enemies.push(enemy) unless enemy.boss_graphic?
      end
    end
    if common_enemies.size == 1
      common_enemies[0].position_flag = 1 unless common_enemies[0].position_flag == -1
    end
    
    # �w���v�E�B���h�E���B��
    @help_window.visible = false
    # ���o�g�����O�E�B���h�E���o��
    @battle_log_window.visible = true
    @battle_log_window.bgframe_sprite.visible = true

    # �A�N�V��������������Ă���o�g���[�����݂��Ȃ��ꍇ
    if $game_temp.forcing_battler == nil
      # �o�g���C�x���g���Z�b�g�A�b�v
      setup_battle_event
      # �o�g���C�x���g���s���̏ꍇ
      if $game_system.battle_interpreter.running?
        return
      end
    end
    # �A�N�V��������������Ă���o�g���[�����݂���ꍇ
    if $game_temp.forcing_battler != nil
      # �擪�ɒǉ��܂��͈ړ�(�����s�����N�����Ƒ��d�s���s�ɂ���)
      @action_battlers.delete($game_temp.forcing_battler)
      @action_battlers.unshift($game_temp.forcing_battler)
      $game_temp.forcing_battler.another_action = false
    end
    # ���s���o�g���[�����݂��Ȃ��ꍇ (�S���s������)
    if @action_battlers.size == 0
      # �o�g�����O���N���A
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
      txc = 0
      # ���X�e�[�g����������s�Ȃ�
      ms = text = text1 = text2 = ""
      for actor in $game_party.battle_actors
        if actor.exist? and not actor.dead?
          actor.remove_states_auto
          ms = actor.bms_states_update
          text1 = (text1 + ms + "\w\q") if ms != ""
          txc += 1
        end
      end
      ms = ms2 = ""
      for enemy in $game_troop.enemies
        if enemy.exist?
          enemy.remove_states_auto
          ms = enemy.bms_states_update
          text2 = (text2 + ms + "\w\q") if ms != ""
          txc += 1
        end
      end
      text = text1 + text2
      before_text_flag = false # ���̎��_�Ńe�L�X�g�����邩�m�F
      if text != ""
        #���V�X�e���E�F�C�g
        case $game_system.ms_skip_mode
        when 3 #�蓮���胂�[�h
          @wait_count = (txc + 1) * 4
        when 2 #�f�o�b�O���[�h
          @wait_count = 8
        when 1 #�������[�h
          @wait_count = 12
        else
          # �X�e�[�g�֌W�̓X�e�[�g�̐������E�F�C�g�����Z
          @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time + (txc * (4 + 1))
        end
        if $game_system.system_read_mode != 0
          text += "CLEAR"
          text.sub!("\w\qCLEAR","")
        end
        $game_temp.battle_log_text += text
        before_text_flag = true # �e�L�X�g�L��̃t���O�𗧂Ă�
      end
      # �S�o�g���[�̃X�e�[�g���O�����ׂăN���A
      for battler in @battlers
        battler.add_states_log.clear
        battler.remove_states_log.clear
      end
      # �摜�ύX�t���O�𗧂Ăĉ摜�����t���b�V��
      for enemy in $game_troop.enemies
        if enemy.exist?
          enemy.graphic_change = true
        end
      end
      for actor in $game_party.party_actors
        if actor.exist?
          actor.graphic_change = true
        end
      end
      # ��U��U�͂����Ń��t���b�V��������
      $game_temp.first_attack_flag = 0
      # �摜�ύX�t���O�𗧂Ăĉ摜�����t���b�V��
      # �X�ɁA�K�[�h��ԁA���N�G�X�g��ԂȂ炻���������ɉ�������
      text = ""
      for enemy in $game_troop.enemies
        if enemy.exist?
          #�^�[�����܂����ƃ��W�X�g�J�E���g�͂P������
#          enemy.resist_count -= 1 if enemy.resist_count > 0
          if enemy.ecstasy_turn > 0
            enemy.ecstasy_turn -= 1
            if enemy.ecstasy_turn == 0 and enemy.weaken?
              enemy.remove_state(2) if enemy.states.include?(2) #����
              enemy.remove_state(3) if enemy.states.include?(3) #�Ⓒ
              text += enemy.bms_states_update + "\w\q"
              enemy.animation_id = 12
              enemy.animation_hit = true
              txc += 1
            end
          end
          enemy.graphic_change = true
          enemy.remove_state(93) if enemy.states.include?(93) #�K�[�h
          enemy.remove_state(94) if enemy.states.include?(94) #��K�[�h
        end
      end
      for actor in $game_party.party_actors
        if actor.exist?
          #�\���`�F�b�N
          if actor.state?(36)
            actor.berserk = true
          else
            actor.berserk = false
          end
          #�^�[�����܂����ƃ��W�X�g�J�E���g�͂P������
#          actor.resist_count -= 1 if actor.resist_count > 0
          if actor.ecstasy_turn > 0
            actor.ecstasy_turn -= 1
            if actor.ecstasy_turn == 0 and actor.weaken?
              actor.remove_state(2) if actor.states.include?(2) #����
              actor.remove_state(3) if actor.states.include?(3) #�Ⓒ
              text += actor.bms_states_update + "\w\q"
              actor.animation_id = 12
              actor.animation_hit = true
              txc += 1
            end
          end
          actor.graphic_change = true
          actor.remove_state(93) if actor.states.include?(93) #�K�[�h
          actor.remove_state(94) if actor.states.include?(94) #��K�[�h
          actor.remove_state(96) if actor.states.include?(96) #�A�s�[��
        end
      end
      #���C�����̏ꍇ�A�J�E���g���B�J�E���g���O�ɂȂ�����������Ĕ�����
      if $game_actors[101].state?(95)
        if $freemode_count > 0
          $freemode_count -= 1
        else
          $game_actors[101].remove_state(95)
          $freemode_count = nil
        end
      end
      #�e�L�X�g���`
      if text != ""
        if $game_system.system_read_mode != 0
          text += "CLEAR"
          text.sub!("\w\qCLEAR","")
        end
        # ���O�Ƀe�L�X�g���������ꍇ�͉��s��}��
        text = "\w\q" + text if before_text_flag 
        $game_temp.battle_log_text += text
        #���V�X�e���E�F�C�g
        case $game_system.ms_skip_mode
        when 3 #�蓮���胂�[�h
          @wait_count = (txc + 1) * 4
        when 2 #�f�o�b�O���[�h
          @wait_count = 8
        when 1 #�������[�h
          @wait_count = 12
        else
          @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time
        end
      end
      #���C���Z���X�p��������s�Ȃ�
      $incense.turn_end_reduction
      
      # �搧�U���t���O���N���A      
      $game_temp.first_attack_flag = 0
      @actor_first_attack = true
      @enemy_first_attack = false
      # �X�e�[�^�X�E�B���h�E�����t���b�V��
      @status_window.refresh
      ## �X�e�b�v 103 �Ɉڍs
      #@phase4_step = 103
      # �X�e�b�v 105 �Ɉڍs
      @phase4_step = 105
    else
      # �A�j���[�V���� ID ����уR�����C�x���g ID ��������
      @animation1_id = 0
      @animation2_id = 0
      @common_event_id = 0
      # ���s���o�g���[�z��̐擪����V�t�g
      @active_battler = @action_battlers.shift
      # ���łɐ퓬����O����Ă���ꍇ�i�B��G�l�~�[���܂ށj
      if @active_battler.index == nil or @active_battler.hidden
        return
      end
      # ���A�N�e�B�u�o�g���[�̏����L���@���R�����C�x���g�Ŏg���܂��B
      $game_temp.battle_active_battler = @active_battler

=begin
      # ���G�l�~�[�̕\����Ԃ̕ύX
      enemies_display(@active_battler) if @active_battler.is_a?(Game_Enemy)
=end
      # ���G�l�~�[�̏ꍇ
      enemy_skill = @active_battler.current_action.skill_id
      if @active_battler.is_a?(Game_Enemy) and enemy_skill != nil
        if @active_battler.another_action
          # �s�����ڂȂ�A�N�V���������t���O���O��
          @active_battler.current_action.forcing = false
        end
        if not @active_battler.current_action.forcing
          # �G�l�~�[�s������p�X�C�b�`���m�F���A�ēx�A�N�V�����I��
          enemy_action_swicthes(@active_battler)
          @active_battler.make_action
        end
      end
      
      # �X���b�v�_���[�W
      if @active_battler.hp > 0 and @active_battler.slip_damage?
        @active_battler.slip_damage_effect
        @active_battler.damage_pop = true
      end
      
      #p "1b" if $debug_flag == 1
      # �S�o�g���[�̃X�e�[�g���O�����ׂăN���A
      for battler in @battlers
        battler.add_states_log.clear
        battler.remove_states_log.clear
      end
      # ���b�Z�[�W�^�O���N���A
      $msg.tag = ""
      
      # �o�b�N���O�ɉ��s�w���ǉ�
#      $game_temp.battle_back_log += "\q"

      # �X�e�[�^�X�E�B���h�E�����t���b�V��
      @status_window.refresh
      # �X�e�b�v 2 �Ɉڍs
      @phase4_step = 2
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 11 : �^�[���I��)
  #--------------------------------------------------------------------------
  def update_phase4_step103
    # ���o�g�����O�E�B���h�E������
    @battle_log_window.visible = false
    @battle_log_window.bgframe_sprite.visible = false

    @status_window.refresh
    # �p�[�e�B�R�}���h�t�F�[�Y�J�n
    start_phase2
  end
  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 2 : �A�N�V�����J�n)
  #--------------------------------------------------------------------------
  def update_phase4_step2
    
    # �o�g�����O���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    # �e�o�g���[�Ƀz�[���h�󋵂��L�^
    hold_record
#    p "�s��4-2�F#{@active_battler.name}/�Ώ�index�F#{@active_battler.current_action.target_index}"if $DEBUG
    
    #p "2a" if $debug_flag == 1
    # ���A�N�e�B�u�o�g���[�̏����L���@���R�����C�x���g�Ŏg���܂��B
    $game_temp.battle_active_battler = @active_battler
    # �����A�N�V�����łȂ����
    unless @active_battler.current_action.forcing
      # ���� [�G��ʏ�U������] �� [������ʏ�U������] �̏ꍇ
      if @active_battler.restriction == 2 or @active_battler.restriction == 3
        # �A�N�V�����ɍU����ݒ�
        @active_battler.current_action.kind = 0
        @active_battler.current_action.basic = 0
        # ���L�������X�L��������
        $game_temp.skill_selection = nil
      end
      # ���� [�s���ł��Ȃ�] �̏ꍇ
      if @active_battler.restriction == 4
        #�s���ł��Ȃ��������\���̏ꍇ�A�����_���s���X�L���𑕓U
        if @active_battler.berserk == true
          @active_battler.current_action.kind = 1
          @active_battler.current_action.forcing = true
          @active_battler.current_action.skill_id = 296
          if @active_battler.is_a?(Game_Enemy)
            @active_battler.current_action.decide_random_target_for_enemy
          elsif @active_battler.is_a?(Game_Actor)
            @active_battler.current_action.decide_random_target_for_actor
          end
          @active_battler.another_action = false
        #�\���ȊO�̏ꍇ�A�o�g���[���N���A����
        else
          # �A�N�V���������Ώۂ̃o�g���[���N���A
          $game_temp.forcing_battler = nil
          # �X�e�b�v 1 �Ɉڍs
          @phase4_step = 1
          # ���L�������X�L��������
          $game_temp.skill_selection = nil
          return
        end
      end
    end
    # �Ώۃo�g���[���N���A
    @target_battlers = []
    # �A�N�V�����̎�ʂŕ���
    case @active_battler.current_action.kind
    when 0  # ��{
      make_basic_action_result
    when 1  # �X�L��
      make_skill_action_result
    when 2  # �A�C�e��
      make_item_action_result
    end
    #p "2b" if $debug_flag == 1
    
    # �X�e�b�v 3 �Ɉڍs
    if @phase4_step == 2
      @phase4_step = 3
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 3 : �s�����A�j���[�V����)
  #--------------------------------------------------------------------------
  def update_phase4_step3
    #p "3a" if $debug_flag == 1
    # �o�g�����O���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    # �s�����A�j���[�V���� (ID �� 0 �̏ꍇ�͔��t���b�V��)
    if @animation1_id == 0
      @active_battler.white_flash = true
    else
      @active_battler.animation_id = @animation1_id
      @active_battler.animation_hit = true
    end
    # ���o�g�����O��\��
    case @active_battler.current_action.kind
    when 1  #�X�L��
      @active_battler.bms_useskill(@skill)
    when 2  #�A�C�e��
      @active_battler.bms_useitem(@item)
    end
    
    # ���R�}���h���� 
    #------------------------------------------------------
    case @active_battler.current_action.kind
    when 1 #�X�L���̏ꍇ
      command = @skill
    when 2 #�A�C�e���̏ꍇ
      command = @item
    end
    # ���G�l�~�[�̕\����Ԃ̕ύX�i�Ώۂ��S�̂̏ꍇ�͕ύX�����j
    # �i�^�[�Q�b�g���A�N�e�B�u���G�l�~�[�̏ꍇ�A�����ŕ\���G�l�~�[��\�񂵁A
    # �@�s�������b�Z�[�W�̏I����ɕ\��������j
    if @target_battlers[0].is_a?(Game_Enemy) and @active_battler.is_a?(Game_Enemy) \
     and command.scope != 2 and command.scope != 4 
      @display_order_enemy = @target_battlers[0]
    end
    
    # �����W�X�g�X�L���̏ꍇ
    if @active_battler.current_action.kind == 1
      #�z�[���h(6)�A�U�f(7)�A����(8)���W�X�g�̂����ꂩ�̑���������ꍇ�͐�p�����Ɉړ�
      if @skill.element_set.include?(6) or @skill.element_set.include?(7) or @skill.element_set.include?(8)
        # �Ώۂɐ����o���A�j���[�V����������
        unless @skill.id == 10
          @target_battlers[0].animation_id = 109
          @target_battlers[0].animation_hit = true
        end
        # ���W�X�g�X�L���̏����L�^
        $game_temp.resist_skill = @skill
        # �E�F�C�g������ 12 �Ɉڍs
        @phase4_step = 12
        return
      end
    end
    # ���W�X�g�X�L���łȂ��ꍇ�A�X�e�b�v 4 �Ɉڍs
    @phase4_step = 4
#��    @wait_count = 8 #�E�F�C�g�O���ăe���|�A�b�v
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 4 : ���W�X�g����)
  #--------------------------------------------------------------------------
  def update_phase4_step12
    # --------------------------------------------------------------
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    # �R�����C�x���g������Ń��W�X�g�O�̉�b��\��
    common_event = $data_common_events[31]
    $game_system.battle_interpreter.setup(common_event.list, 0)
    @wait_count = 10
    battle_resist
    # �X�e�b�v 4 �Ɉڍs
    @phase4_step = 13
  end  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 4 : ���W�X�g���ʍ쐬)
  #--------------------------------------------------------------------------
  def update_phase4_step13
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
#��    @wait_count = 30
    @add_hold_flag = false
    for target in @target_battlers
      # �Ώۂ��G�l�~�[�̏ꍇ
      if target.is_a?(Game_Enemy)
        # ������
        if $game_temp.resistgame_clear == true
          @resist_flag = true
          @hold_shake = true
          #���W�X�g�J�E���g���O�ɂ���
          target.resist_count = 0
          #�������̃g�[�N�X�e�b�v(�Q)�ɐݒ�
          $msg.talk_step = 2
          # ������E����
          if @skill.element_set.include?(36)
            target.undress
            $game_temp.battle_log_text += target.bms_states_update
          # ���z�[���h�t�^
          elsif @skill.element_set.include?(6)
#            add_hold(@skill, @active_battler, target)
            @add_hold_flag = true
            hold_effect(@skill, @active_battler, target)
          # ���̑�
          else
            $game_temp.battle_log_text += "Resist Successful\w\q" 
          end
        # ���s��
        else
          @resist_flag = false
          @hold_shake = false
          #���s���̃g�[�N�X�e�b�v(�R)�ɐݒ�
          $msg.talk_step = 3
          #�󂯓��ꂽ�ꍇ��SE��炳���A���W�X�g�J�E���g���グ�Ȃ�
          if $game_switches[89]
            $game_temp.battle_log_text += @active_battler.name + " gave up!\w\q"
          else
          # ������SE��炵�A�Ώۂ̃��W�X�g�J�E���g���{�P����
            Audio.se_play("Audio/SE/063-Swing02", 80, 100)
            $game_temp.battle_log_text += target.name + " resisted it!\w\q"
            target.resist_count += 1
          end
          if @skill.element_set.include?(6)
            @hold_shake = false
            hold_effect(@skill, @active_battler, target)
          end
          #���V�X�e���E�F�C�g
          case $game_system.ms_skip_mode
          when 3 #�蓮���胂�[�h
            @wait_count = 1
          when 2 #�f�o�b�O���[�h
            @wait_count = 8
          when 1 #�������[�h
            @wait_count = 12
          else
            # �����͏��������E�F�C�g�𑝂₷
            @wait_count = $game_system.battle_speed_time(0) + 2
          end
        end
      # �Ώۂ��A�N�^�[�̏ꍇ
      else  
        # ������
        if $game_temp.resistgame_clear == true
          @resist_flag = true
          #�������̃g�[�N�X�e�b�v(�Q)�ɐݒ�
          $msg.talk_step = 2
          # ������SE��炵�A�Ώۂ̃��W�X�g�J�E���g���{�P����
          Audio.se_play("Audio/SE/063-Swing02", 80, 100)
          $game_temp.battle_log_text += target.name + " resisted it!\w\q"
          target.resist_count += 1
          if @skill.element_set.include?(6)
            @hold_shake = false
            hold_effect(@skill, @active_battler, target)
          end
          #���V�X�e���E�F�C�g
          case $game_system.ms_skip_mode
          when 3 #�蓮���胂�[�h
            @wait_count = 1
          when 2 #�f�o�b�O���[�h
            @wait_count = 8
          when 1 #�������[�h
            @wait_count = 12
          else
            # �����͏��������E�F�C�g�𑝂₷
            @wait_count = $game_system.battle_speed_time(0) + 2
          end
        # ���s��
        else
          @resist_flag = false
          #���W�X�g�J�E���g���O�ɂ���
          target.resist_count = 0
          @hold_shake = true
          #���s���̃g�[�N�X�e�b�v(�R)�ɐݒ�
          $msg.talk_step = 3
          # ������E����
          if @skill.element_set.include?(36)
            # �E�߃A�j���[�V����������
              target.animation_id = 104
              target.animation_hit = true
              target.undress
              $game_temp.battle_log_text += target.bms_states_update
          # ���z�[���h�t�^
          elsif @skill.element_set.include?(6)
#            add_hold(@skill, @active_battler, target)
            @add_hold_flag = true
            hold_effect(@skill, @active_battler, target)
          # ���̑�
          else
            $game_temp.battle_log_text += "Failed to resist.\w\q" 
          end
        end
      end
      # �摜�ύX
      @active_battler.graphic_change = true
      target.graphic_change = true
    end
    # �X�e�[�^�X�̃��t���b�V��
    @status_window.refresh
    # �X�e�b�v 4 �Ɉڍs
    @phase4_step = 4
  end  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 4 : �Ώۑ��A�j���[�V����)
  #--------------------------------------------------------------------------
  def update_phase4_step4
    
    # �e�퍀�ڂ��N���A
    @ecstasy_check = false
    @ecstasy_check_self = false
    text1 = ""
    text2 = ""
    text3 = ""
    # ���R�}���h���� 
    #------------------------------------------------------
    case @active_battler.current_action.kind
    when 1 #�X�L���̏ꍇ
      @command = @skill
    when 2 #�A�C�e���̏ꍇ
      @command = @item
    end
=begin
    # ���G�l�~�[�̕\����Ԃ̕ύX�i�Ώۂ��S�̂̏ꍇ�͕ύX�����j
    if @target_battlers[0].is_a?(Game_Enemy) \
     and @command.scope != 2 and @command.scope != 4 
      enemies_display(@target_battlers[0])
    end
=end
    # �������J�n
    for target in @target_battlers
      #------------------------------------------------------
      # �Ώۑ��A�j���[�V����
      target.animation_id = @animation2_id
      target.animation_hit = (target.damage != "Miss")
      # ���[�h�A�b�v����
      #------------------------------------------------------
      # ���[�h�A�b�v��
      if @command.element_set.include?(20)
        $mood.rise(1)
      # ���[�h�A�b�v��
      elsif @command.element_set.include?(21)
        $mood.rise(4)
      # ���[�h�A�b�v��
      elsif @command.element_set.include?(22)
        $mood.rise(10)
      end
      # �V�F�C�N����(�z�[���h�����ŃV�F�C�N�������ꍇ�͔�΂�)
      #------------------------------------------------------
      # �s�X�g���n
      if @hold_shake == nil
        if @command.element_set.include?(37)
          # ��ʂ̏c�V�F�C�N
          $game_screen.start_flash(Color.new(255,210,225,220), 8)
          $game_screen.start_shake2(7, 15, 15)
        # �O���C���h�n
        elsif @command.element_set.include?(38)
          # ��ʂ̉��V�F�C�N
          $game_screen.start_flash(Color.new(255,210,225,220), 8)
          $game_screen.start_shake(7, 15, 15)
        end
      else
        #�z�[���h�ŃV�F�C�N�������s�����ꍇ�A������nil�ɖ߂�
        @hold_shake = nil
      end
      #======================================================================================
      # �_���[�W������ꍇ      
      #======================================================================================
      if target.damage != nil
        skill_result = state_result = ""
        target.damage_pop = true
        #======================================================================================
        # ���U���𖽒������Ă���
        #======================================================================================
        if target.damage != "Miss"
          #************************************************************************
          # ���u�_���[�W�����X�L���v�ł͂Ȃ��ꍇ
          #************************************************************************
          if not @command.element_set.include?(17)
            #���X�L���e�L�X�g�Ăяo��
            if @active_battler.current_action.kind == 1
              skill_result = target.bms_skill_effect(@skill)
            #���A�C�e���e�L�X�g�Ăяo��
            elsif @active_battler.current_action.kind == 2
              skill_result = target.bms_item_effect(@item)
            end
            state_result = target.bms_states_update
            state_result2 = @active_battler.bms_states_update
            #���e�L�X�g���`
            #���X�L���e�L�X�g������Ȃ�}��
            text1 += skill_result if skill_result != ""
            #���Ώۂ̃X�e�[�g�e�L�X�g������Ȃ�}��
            text1 += "\w\q" + state_result if state_result != ""
            #�����g�̃X�e�[�g�e�L�X�g������Ȃ�}��
            text1 += "\w\q" + state_result2 if state_result2 != ""
            #���e�L�X�g�����݂���Ȃ�A�Ō�ɉ��s��}��
            text1 += "\w\q" if text1 != ""
            #------------------------------------------------------
            # �����蕨�A�C�e���̏ꍇ�A�F�D�x�ɉ����ăA�j���[�V�������w��
            #------------------------------------------------------
            if target.is_a?(Game_Enemy) and @command.element_set.include?(199)
              target.friendly_animation_order
            end
            #------------------------------------------------------
            # �����o�E���h����������X�L���ł���ꍇ�͎Z�o
            #------------------------------------------------------
            if @command.element_set.include?(31) or @command.element_set.include?(32)
              @active_rebound_flag = false
              rebound = (target.damage * (5 + ($mood.point / 10).floor) / 100).floor
              rebound = (rebound / 2).round if @command.element_set.include?(31) #���o�E���h��
              # �����_���[�W�łg�o���O�ȉ��ɂȂ�ꍇ�͂P���c��(���̂Ƃ���)
              rebound = 0 if @active_battler.hp == 1
              rebound = @active_battler.hp - 1 if @active_battler.hp <= rebound
              # ���ۂ�EP�����Z
              @active_battler.hp -= rebound
              # �o�g�����O��\��(���o�E���h���������Ȃ��ꍇ�͕\�����Ȃ��j
              text3 += "\w" + @active_battler.name + " took " + rebound.to_s + " rebound pleasure!\q" if rebound > 0
              if @active_battler.hp > 0 and not @active_battler.state?(6)
                if @active_battler.hpp <= $mood.crisis_point(@active_battler) + rand(5)
                  @active_rebound_flag = true
                  @active_battler.add_state(6)
                  text3 += @active_battler.bms_states_update + "\w\q"
                end
              end
              # �摜�ύX
              @active_battler.graphic_change = true
            end
            #------------------------------------------------------
            # ���z������������X�L���ł���ꍇ�͎Z�o
            #------------------------------------------------------
            if @command.element_set.include?(198)
              # �z���l���Z�o���A�z������
              vp_drain = (target.damage * (10 + ($mood.point / 5).floor) / 100).floor
              if vp_drain > 0
                target.sp -= vp_drain
                @active_battler.sp += vp_drain
                text3 += "\w" + @active_battler.name + " had " + vp_drain.to_s + " energy absorbed!\w\q"
                if target.sp <= 0
                  target.sp_down_flag = true
                end
                # �z�������Ȃ�A�j����t����
                @active_battler.animation_id = 168
                @active_battler.animation_hit = (target.damage != "Miss")
              end
            end
            #------------------------------------------------------
            # �����x���h���C������������X�L���ł���ꍇ�͎Z�o
            #------------------------------------------------------
            if @command.element_set.include?(202)
              if target.level > 1
                target.level -= 1
                text3 += "\w" + "#{target.name} became Lv.#{target.level.to_s}!"
                # �g�p�҂ɃX�g�����u�����̋������ڂ�ʂ�
                level_drain_text = ""
#                @active_battler.capacity_alteration_effect($data_skills[195])
#                level_drain_text = @active_battler.bms_states_update
                level_drain_text += special_status_check(@active_battler,[195])
#               
                # �e�L�X�g������Ȃ炻����ʂ�
#                if level_drain_text != "" and level_drain_text != "������#{@active_battler.name}�ɂ͌��ʂ����������I"
                  text3 += level_drain_text + "\w\q"
#                end
                # �z�������Ȃ�A�j����t����
                @active_battler.animation_id = 168
                @active_battler.animation_hit = (target.damage != "Miss")
              end
            end
            #------------------------------------------------------
            # ���ł炵�X�C�b�`�������Ă���ꍇ�A�Ō�Ƀi���[�g��ǉ�
            #------------------------------------------------------
            if $game_switches[82] == true
              brk = ""
              brk = "�A\n\m" if SR_Util.names_over?(@active_battler.name,$game_temp.battle_target_battler[0].name)
              #�e�B�[�Y�̏ꍇ�A�X�C�b�`�𑦎���������
              if @active_battler.is_a?(Game_Actor) and @command.id == 101
                text3 += "\w" + @active_battler.name + "��#{brk}#{$game_temp.battle_target_battler[0].name}���ł炵�Ă���I\w\q"
              #��������̏ł炵�U����H������ꍇ�A�X�C�b�`�𑦎���������
              elsif @active_battler.is_a?(Game_Enemy)
                text3 += "\w" + @active_battler.name + "��#{brk}#{$game_temp.battle_target_battler[0].name}���ł炵�Ă���I\w\q"
              end
              $game_switches[82] = false
            end
            #------------------------------------------------------
            # ���g�p�҂������Ły���@�́z�����̏ꍇ
            #------------------------------------------------------
            if @active_battler.is_a?(Game_Actor) and @active_battler.have_ability?("���@��")
              brk = ""
              brk = "�A\n\m" if SR_Util.names_over?(@active_battler.name, $game_temp.battle_target_battler[0].name, 16)
              # �Ώۂ��G�ŁA�`�F�b�N�t���O���P�����̎��A�P�ɂ��ăi���[�g���o��
              if target.is_a?(Game_Enemy) and target.checking < 1
                target.checking = 1
                text3 += "\w" + @active_battler.name + " examined #{brk}#{$game_temp.battle_target_battler[0].name}!\w\q"
              end
            end
            #------------------------------------------------------
            # ���x�X�g�G���h��̃��F���~�B�[�i���{�C���o���ꍇ
            #------------------------------------------------------
            if @troop_id == 603
              # �Ώۂ����F���~�B�[�i���A���F���~�B�[�i���܂��{�C��ԂŖ�������
              # �u�o��1000�ȉ����A�Ⓒ�ێ����łȂ��ꍇ
              if target == $game_troop.enemies[0] and not $game_troop.enemies[0].earnest and
               $game_troop.enemies[0].sp <= 1200 and not $game_troop.enemies[0].weaken?
                # �C�x���g�������i�X�e�b�v�U�ŃC�x���g�Z�b�g�A�b�v�j
                @common_event_id = 119
              end
            end
          #************************************************************************
          # ���u�X�e�[�g�t�^�X�L���v�̏ꍇ
          #************************************************************************
          elsif @command.element_set.include?(33)
            #�Ώۂ̃X�e�[�g����X�e�[�g���U���g���Ăяo��
            state_result = target.bms_states_update
            if state_result != "" #�t�^�X�e�[�g������ꍇ
              text1 += state_result + "\w\q"
            elsif state_result == "" #�t�^�X�e�[�g�������ꍇ
              text1 += ""
            else
              text1 += state_result + "\w\q"
            end
            # �����E�ቺ���@�֘A����
            for i in 80..87
              target.remove_state(i) if target.states.include?(i)
            end
          #************************************************************************
          # ���u���o�X�L���v�̏ꍇ
          #************************************************************************
          elsif @command.element_set.include?(200)
            text1 = target.bms_direction_skill_effect(@skill)
          end
        #======================================================================================
        # ���U�����O���Ă���
        #======================================================================================
        elsif target.damage == "Miss"
          #************************************************************************
          # ���u�X�e�[�g�t�^�X�L���v�̏ꍇ
          #************************************************************************
          if @command.element_set.include?(33)
            # ���o�b�h�X�e�[�g�t�^���@�̏ꍇ(���ɕt�^����Ă���ꍇ�����������)
            bs = 0
            for i in SR_Util.checking_states
              if $data_skills[@skill.id].plus_state_set.include?(i) and target.states.include?(i)
                text1 += "�go��ever " + target.name + " cannot be effected ��ore than this!\w\q"
                bs = 1
                break
              end
            end
            if bs == 0
              skill_result = target.bms_skill_effect(@skill)
              text1 += skill_result + "\w\q"
            end
          #************************************************************************
          # ���u���蕨�A�C�e���v�̏ꍇ�A���蕨�A�C�e���̎��s��\��
          #************************************************************************
          elsif target.is_a?(Game_Enemy) and @command.element_set.include?(199) and
            skill_result = target.bms_item_effect(@item)
            text1 += skill_result + "\w\q"
          #************************************************************************
          # ���u�_���[�W�����X�L���v�ł͂Ȃ��ꍇ
          #************************************************************************
          elsif not @command.element_set.include?(17)
#          else
#            # �~�X�����ꍇ�͔�����SE��炷
#            Audio.se_play("Audio/SE/063-Swing02", 80, 100)
            $game_temp.battle_log_text += "\w" + target.name + " was not effected!\q"
          end
        end
        #======================================================================================
        # ������
        #======================================================================================
        #************************************************************************
        # ���w����E���x�n����
        #************************************************************************
        if @command.element_set.include?(35)
          # �_���[�W�i���[�g��Ɍ�����o���t���O������
          $game_switches[90] = true
          #���G�l�~�[���̋���
          if target.is_a?(Game_Enemy)
            $msg.tag = "���������Ԗ�����E��"
            $msg.tag = "����������E��" if @active_battler == target
            #�������̒E�ߌ���Ǘ��͎�l�������ňꊇ�ōs��
            $msg.callsign = 7
            $msg.callsign = 17 if $game_switches[85] == true
            target.undress
            #�Ώۂ̃X�e�[�g�󋵂��e�L�X�g�Ɋi�[
            text1 += target.bms_states_update + "\w\q"
          #���A�N�^�[���̋���
          else
            #��l��
            if target == $game_actors[101]
              if @active_battler != target
                $msg.tag = "�p�[�g�i�[����l����E��"
                $msg.callsign = 27
                $msg.callsign = 37 if $game_switches[85] == true
              else
                $msg.tag = "��l��������E��"
                $msg.callsign = 7
                $msg.callsign = 17 if $game_switches[85] == true
              end
            #�p�[�g�i�[
            else
              if @active_battler != target
                $msg.tag = "��l�����p�[�g�i�[��E��"
                $msg.callsign = 7
                $msg.callsign = 17 if $game_switches[85] == true
              else
                $msg.tag = "�p�[�g�i�[������E��"
                $msg.callsign = 27
                $msg.callsign = 37 if $game_switches[85] == true
              end
            end
            target.animation_id = 104
            target.animation_hit = true
            target.undress
            text1 += target.bms_states_update + "\w\q"
          end
        end
        #************************************************************************
        # ���X���C���̒��E�ߌn����
        #************************************************************************
        #���S�t�Đ�
        if @command.name == "���X�g���[�V����"
          target.animation_id = 89
          target.animation_hit = true
          target.dress
        #���S�t����
        elsif @command.name == "�X���C�~�[���L�b�h"
          target.animation_id = 90
          target.animation_hit = true
          @active_battler.undress
          text1 += @active_battler.bms_states_update + "\w\q"
          @active_battler.graphic_change = true
        end
        #************************************************************************
        # ���C�j�V�A�`�u�ύX�n
        #************************************************************************
        if @command.element_set.include?(207)
          text1 += "#{@active_battler.name}�͎哱�������߂����I\w\q"
        end
        #************************************************************************
        # ���C���Z���X�S�č폜
        #************************************************************************
        if @command.element_set.include?(213)
          delete_flag = $incense.delete_incense_all
          if delete_flag
            text1 += "��Ɋ|�����Ă�����ʂ����ׂĖ����Ȃ����I\w\q"
          else
            text1 += "���������ʂ͖��������I\w\q"
          end
        end
        #************************************************************************
        # ���G�l�~�[�����n
        #************************************************************************
        if @command.element_set.include?(217)
          target.recover_all
          target.state_runk = [0, 0, 0, 0, 0, 0]
          target.ecstasy_count = []
          target.crisis_flag = false
          target.hold_reset
          target.ecstasy_turn = 0
          target.ecstasy_emotion = nil
          target.sp_down_flag = false
          target.resist_count = 0
          target.pillowtalk = 0
          target.talk_weak_check = []
          target.add_states_log.clear
          target.remove_states_log.clear
          target.checking = 0
          target.lub_male = 0
          target.lub_female = 0
          target.lub_anal = 0
          target.used_mouth = 0
          target.used_anal = 0
          target.used_sadism = 0
          battler_stan(target)
          enemies_display(target)
          text1 += "#{target.name}�����ꂽ�I\w\q"
        end
        
     #elsif target.damage == nil �_���[�W�������ꍇ�̏����͌���ł͓��ɖ������ߕ���
      end
      #======================================================================================
      # �摜�ύX
      target.graphic_change = true
      # ���z�[���h�󋵊m�F
      if @active_battler != target
        #hold_initiative(@skill, @active_battler, target) # ���\�b�h�ύX���܂���
        if target.holding?
          # �N���e�B�J�����o�Ă���ꍇ�A�G�z�[���h�̃C�j�V�A�`�u������
          if target.critical
            hold_initiative_down(target)
          end
          # �������̏ꍇ�A�������z�[���h���Ă��鑊��S���̃C�j�V�A�`�u������
          if @command.element_set.include?(207)
            for hold_target in @active_battler.hold_target_battlers
              hold_initiative_down(hold_target)
            end
          end
        end
        # �z�[���h�|�b�v�̎w��
        hold_pops_order
        #�z�[���h����̏����̏ꍇ�A�����ŕ���^�]�ɖ߂�
        $game_switches[81] = false
      end
    #for target in @target_battlers�����܂�
    end
    #************************************************************************
    # ���A�����b�L�[���A
    #************************************************************************
    if @command.name == "�A�����b�L�[���A"
      # �s�K�łȂ��ꍇ�A�s�K��Ԃɂ���B
      unless $game_party.unlucky?
        text1 += "#{$game_actors[101].name}�͕s�K�ɂȂ��Ă��܂����I\w\q"
        $game_variables[61] = 50 
      else
        text1 += "���������ʂ͖��������I\w\q"
      end
    end
    #************************************************************************
    # ���C���Z���X����
    #************************************************************************
    if @command.element_set.include?(129)
      add_check = $incense.use_incense(@active_battler, @command)
      if add_check
        # ����������
        text1 = incense_start_effect
      else
        text1 = "���������ʂ͖��������I\w\q"
      end
    end
    #�{�\�̌Ăъo�܂��Ŏ��Ȗ\�������ꍇ�A���̃^�[���̒ǉ��A�N�V�������L�����Z������
    @action_battlers.delete(@active_battler) if @command.name == "�{�\�̌Ăъo�܂�"
    #======================================================================================
    #���g�[�N����(�g�[�N���̈������ł̃_���[�W���̑��������s������)
    #======================================================================================
    # �R�}���h�����g�[�N�A���R�����C�x���g ID ���L���̏ꍇ
    if @common_event_id > 0 and @command.name == "�g�[�N"
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
      # �C�x���g���Z�b�g�A�b�v
      common_event = $data_common_events[@common_event_id]
      $game_system.battle_interpreter.setup(common_event.list, 0)
    end
    #************************************************************************
    # ���e�L�X�g���`
    #************************************************************************
    if text1 != "" or text2 != "" or text3 != ""
      a = text1 + text2 + text3
      if $game_system.system_read_mode != 0
        a += "CLEAR"
        a.sub!("\w\qCLEAR","")
        a.sub!("CLEAR","") if a[/(CLEAR)/] != nil
      end
      $game_temp.battle_log_text += a
    else
      # �}�j���A������̏ꍇ�A���ʂ��Ȃ��ꍇ�ł��|�[�Y��t����
#      if $game_system.system_read_mode == 0
#        $game_temp.battle_log_text += "�@\w\q"
#      end
    end
    
    #======================================================================================
    #���N���C�V�X�E�Ⓒ�t���O
    #======================================================================================
    #�Ώۂ��N���C�V�X�ɂȂ�A�N���C�V�X��b���������Ă��Ȃ��Ȃ珈���J�n
    @crisis_battlers = []
    @ecstasy_battlers = []
    @ecstasy_battlers_count = []
    @ecstasy_battlers_clone = []
    @target_ecstasy_flag = false
    @active_ecstasy_flag = false
    @crisis_mes_stop_flag = false
    #���Ⓒ�L�����N�^�[���i�[����
    #------------------------------------------------------
    for target in @target_battlers
      if target.hp <= 0 or target.sp <= 0
        target.add_state(11)
        @ecstasy_battlers.push(target)
        @target_ecstasy_flag = true
        target.graphic_change = true
        @crisis_mes_stop_flag = true
      end
    end
    if @active_battler.hp <= 0 or @active_battler.sp <= 0
      @active_battler.add_state(11)
      @ecstasy_battlers.push(@active_battler)
      @active_ecstasy_flag = true
      @active_battler.graphic_change = true
      @crisis_mes_stop_flag = true
    end
    @ecstasy_battlers_count = @ecstasy_battlers
    @ecstasy_battlers_clone = @ecstasy_battlers_count.dup
    #���N���C�V�X�L�����N�^�[���i�[����
    #------------------------------------------------------
    #�g�[�N���A�_���[�W�����X�L���A�񕜃X�L���g�p�̏ꍇ�͊i�[���Ȃ�
    unless $game_switches[79] == true and @command.element_set.include?(16) and @command.element_set.include?(17)
      for target in @target_battlers
        unless @ecstasy_battlers.include?(target)
          unless @crisis_mes_stop_flag == true
            if target.crisis? and target.crisis_flag == false
              @crisis_battlers.push(target)
            end
          end
        end
      end
      #�^�[�Q�b�g�m�F�̌�A�A�N�e�B�u�L�����N�^�[��������s��
      unless @ecstasy_battlers.include?(@active_battler)
        unless @crisis_mes_stop_flag == true
          if @active_battler.crisis? and @active_battler.crisis_flag == false
            for target in @target_battlers
              # �A�N�e�B�u���^�[�Q�b�g���G�l�~�[�̏ꍇ�̓A�N�e�B�u�����Ȃ�
              unless @active_battler.is_a?(Game_Enemy) and target.is_a?(Game_Enemy)
                @crisis_battlers.push(@active_battler)
              end
            end
          end
        end
      end
    end
    #************************************************************************
    # ���S�o�g���[�̃X�e�[�g���O���N���A
    #************************************************************************
    for battler in @battlers
      battler.add_states_log.clear
      battler.remove_states_log.clear
    end
    #************************************************************************
    # ���e��@�\����
    #************************************************************************
    #�X�e�[�^�X�E�B���h�E�X�V
    @status_window.refresh
    #���V�X�e���E�F�C�g
    case $game_system.ms_skip_mode
    when 3 #�蓮���胂�[�h
      @wait_count = 4
    when 2 #�f�o�b�O���[�h
      @wait_count = 6
    when 1 #�������[�h
      @wait_count = 10
    else
      @wait_count = $game_system.battle_speed_time(0)
    end
    if @crisis_battlers.size > 0
      # �X�e�b�v 401 �Ɉڍs
      @phase4_step = 401
    elsif $game_switches[90] == true
      # �X�e�b�v 402 �Ɉڍs
      @phase4_step = 402
    else
      # �X�e�b�v 5 �Ɉڍs
      @phase4_step = 5
    end

  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 401 : �N���C�V�X����)
  #--------------------------------------------------------------------------
  def update_phase4_step401
    #======================================================================================
    #���N���C�V�X�t���O
    #======================================================================================
    cs_battler = @crisis_battlers[0]
    #���R�[���T�C����ݒ�
    if @active_battler == $game_actors[101] or cs_battler == $game_actors[101]
      $msg.callsign = 6
      $msg.callsign = 16 if $game_switches[85] == true
    else
      $msg.callsign = 26
      $msg.callsign = 36 if $game_switches[85] == true
    end
    #���A�N�V���������G�l�~�[
    if cs_battler.is_a?(Game_Actor)
      if @active_battler.crisis? and @active_battler.is_a?(Game_Enemy)
        $msg.tag = "�A�N�^�[����"
      elsif cs_battler == @active_battler
        if @active_rebound_flag == true
          $msg.tag = "�A�N�^�[���o�E���h����"
          @active_rebound_flag = false
        else
          $msg.tag = "�A�N�^�[����"
        end
      else
        $msg.tag = "�A�N�^�[�P��"
      end
    elsif cs_battler.is_a?(Game_Enemy)
      if @active_battler != cs_battler
        if @active_battler.is_a?(Game_Enemy) and cs_battler.is_a?(Game_Enemy)
          $msg.tag = "�G�l�~�[���ԍU��"
        elsif @active_battler.crisis? and @active_battler.is_a?(Game_Actor)
          $msg.tag = "�G�l�~�[����"
        else
          $msg.tag = "�G�l�~�[�P��"
        end
      else
        if @active_rebound_flag == true
          $msg.tag = "�G�l�~�[���o�E���h����"
          @active_rebound_flag = false
        else
          $msg.tag = "�G�l�~�[����"
        end
      end
    end
    cs_battler.crisis_flag = true
    #���ヂ�[�h���ȈՕ\���̏ꍇ�A���̍��ڂ̓X���[����
    unless $game_system.system_message == 0
      #�A�N�e�B�u�A�^�[�Q�b�g���X�V
      $game_temp.battle_active_battler = @active_battler
      $game_temp.battle_target_battler[0] = cs_battler
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
      # �R�����C�x���g�u������R�[���v�����s
      common_event = $data_common_events[31]
      $game_system.battle_interpreter.setup(common_event.list, 0)
      @wait_count = 1
    end
    @crisis_battlers.delete(cs_battler)
    if @crisis_battlers.size > 0
      # �X�e�b�v 401 �Ɉڍs
      @phase4_step = 401
    elsif $game_switches[90] == true
      # �X�e�b�v 402 �Ɉڍs
      @phase4_step = 402
    else
      # �X�e�b�v 5 �Ɉڍs
      @phase4_step = 5
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 402 : ���r���㏈��)
  #--------------------------------------------------------------------------
  def update_phase4_step402
    
    #���ヂ�[�h���ȈՕ\���̏ꍇ�A���̍��ڂ̓X���[����
    if $game_system.system_message == 0
      #�K���X�C�b�`���������Ă���
      $game_switches[90] = false
      #�A�N�e�B�u�A�^�[�Q�b�g���X�V
      $game_temp.battle_active_battler = @active_battler
      $game_temp.battle_target_battler[0] = @target_battlers[0]
      #���[�h�`�F�b�N
      system_simplemode_moodcheck(@active_battler)
    #�X�L�����Ŗ���������Ăяo���ꍇ�A�����Őݒ�
    elsif $game_switches[90] == true
      #�A�N�e�B�u�A�^�[�Q�b�g���X�V
      $game_temp.battle_active_battler = @active_battler
      $game_temp.battle_target_battler[0] = @target_battlers[0]
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
      # �R�����C�x���g�u������R�[���v�����s
      common_event = $data_common_events[31]
      $game_system.battle_interpreter.setup(common_event.list, 0)
      @wait_count = 10
      #�K���X�C�b�`���������Ă���
      $game_switches[90] = false
    end
    # �_���[�W�����X�L���łȂ��ꍇ
    unless @command.element_set.include?(17)
      # ���O�����B
      #���V�X�e���E�F�C�g
      case $game_system.ms_skip_mode
      when 3 #�蓮���胂�[�h
        @wait_count = 1
      when 2 #�f�o�b�O���[�h
        @wait_count = 2
      when 1 #�������[�h
        @wait_count = 4
      else
        @wait_count = $game_system.battle_speed_time(0) #����12
      end
    end
    # �X�e�b�v 5 �Ɉڍs
    @phase4_step = 5
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 5 : �_���[�W�㏈��)
  #--------------------------------------------------------------------------
  def update_phase4_step5
    #�g�[�N��������Ⓒ���N�����ꍇ�̏���
    if $msg.talking_ecstasy_flag == "actor"
      @ecstasy_battlers.push($game_actors[101])
      @active_ecstasy_flag = true
      @ecstasy_battlers_count = @ecstasy_battlers
      $game_actors[101].add_state(11)
    elsif $msg.talking_ecstasy_flag == "enemy"
      @ecstasy_battlers.push($msg.t_enemy)
      @target_ecstasy_flag = true
      @ecstasy_battlers_count = @ecstasy_battlers
      $msg.t_enemy.add_state(11)
    end
    #�Ⓒ���Ă���o�g���[������ꍇ
    if @ecstasy_battlers_count.size > 0
#      #�����Ⓒ�t���O���o���Ă���ꍇ��511�A�����łȂ��ꍇ��501��
#      if @ecstasy_battlers.size > 1 and @target_ecstasy_flag == true and @active_ecstasy_flag == true
        @phase4_step = 501
#      else
#        @phase4_step = 511
#      end
    #�Ⓒ�o�g���[�����Ȃ��ꍇ
    else
      #�ǌ��t���O���o���Ă���ꍇ�̓X�e�b�v601��
      if @combo_break == false
        @phase4_step = 601
      #����ȊO�̏ꍇ�̓X�e�b�v6��
      else
        @phase4_step = 6
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 501 : �Ⓒ����(�P��)�F�O��)
  #--------------------------------------------------------------------------
  def update_phase4_step501
    # ���Ⓒ���X�C�b�`������
    $game_switches[77] = true
    # ���o�g�����O���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    #======================================================================================
    #���Ⓒ�t���O
    #======================================================================================
    # �����t���O�������Ă���
    @self_ecstasy_flag = false
    #--------------------------------------------------------------------------------------
    # ���Ⓒ���Ă���L�����N�^�[���A�N�^�[�̏ꍇ
    #--------------------------------------------------------------------------------------
    if @ecstasy_battlers_count[0].is_a?(Game_Actor)
      #�����łȂ��ꍇ�͍U���G�l�~�[���m�肵�Ă���
      if @ecstasy_battlers_count[0] != @active_battler
        $msg.t_enemy = $game_temp.battle_active_battler = @active_battler
        $msg.t_target = $game_temp.battle_target_battler[0] = @ecstasy_battlers_count[0]
      #�g�[�N���̏ꍇ�͉�b�ΏۃG�l�~�[���m�肵�Ă���
      elsif $msg.talking_ecstasy_flag == "actor"
        $msg.t_enemy = $game_temp.battle_active_battler = @target_battlers[0]
        $msg.t_target = $game_temp.battle_target_battler[0] = @ecstasy_battlers_count[0]
      #�����̏ꍇ�A�z�[���h���Ȃ炻�̑�����A�Ⴄ�Ȃ烉���_���ŉ�b���鑊���I��
      else
        @self_ecstasy_flag = true
        talk_battler = []
        if @ecstasy_battlers_count[0].holding?
          for enemy in $game_troop.enemies
            if enemy.exist?
              if (enemy.hold.penis.battler == @ecstasy_battlers_count[0] or
               enemy.hold.vagina.battler == @ecstasy_battlers_count[0] or
               enemy.hold.mouth.battler == @ecstasy_battlers_count[0] or
               enemy.hold.anal.battler == @ecstasy_battlers_count[0] or
               enemy.hold.tops.battler == @ecstasy_battlers_count[0] or
               enemy.hold.tail.battler == @ecstasy_battlers_count[0] or
               enemy.hold.tentacle.battler == @ecstasy_battlers_count[0] or
               enemy.hold.dildo.battler == @ecstasy_battlers_count[0])
                talk_battler.push(enemy)
              end
            end
          end
        else
          for enemy in $game_troop.enemies
            if enemy.exist?
              talk_battler.push(enemy)
            end
          end
        end
        #��b�G�l�~�[��I��
        $msg.t_enemy = $game_temp.battle_active_battler = talk_battler[rand(talk_battler.size)]
        $msg.t_target = $game_temp.battle_target_battler[0] = @ecstasy_battlers_count[0]
      end
    #--------------------------------------------------------------------------------------
    # ���Ⓒ���Ă���L�����N�^�[���G�l�~�[�̏ꍇ
    #--------------------------------------------------------------------------------------
    elsif @ecstasy_battlers_count[0].is_a?(Game_Enemy)
      #�g�[�N���̏ꍇ�͍U���G�l�~�[���m�肵�Ă���
      if $msg.talking_ecstasy_flag == "enemy"
        $msg.t_enemy = $game_temp.battle_target_battler[0] = @ecstasy_battlers_count[0]
        $msg.t_target = $game_temp.battle_active_battler = @active_battler
      #�����łȂ��ꍇ�͍U���G�l�~�[���m�肵�Ă���
      elsif @ecstasy_battlers_count[0] != @active_battler
        $msg.t_enemy = $game_temp.battle_target_battler[0] = @ecstasy_battlers_count[0]
        $msg.t_target = $game_temp.battle_active_battler = @active_battler
      #�����̏ꍇ�A�z�[���h���Ȃ炻�̑�����A�Ⴄ�Ȃ��l����I��
      else
        @self_ecstasy_flag = true
        talk_battler = []
        if @ecstasy_battlers_count[0].holding?
           for actor in $game_party.actors
            if actor.exist?
              if (actor.hold.penis.battler == @ecstasy_battlers_count[0] or
               actor.hold.vagina.battler == @ecstasy_battlers_count[0] or
               actor.hold.mouth.battler == @ecstasy_battlers_count[0] or
               actor.hold.anal.battler == @ecstasy_battlers_count[0] or
               actor.hold.tops.battler == @ecstasy_battlers_count[0] or
               actor.hold.tail.battler == @ecstasy_battlers_count[0] or
               actor.hold.tentacle.battler == @ecstasy_battlers_count[0] or
               actor.hold.dildo.battler == @ecstasy_battlers_count[0])
                talk_battler.push(actor)
              end
            end
          end
        else
          for actor in $game_party.actors
            if actor.exist?
              talk_battler.push(actor)
            end
          end
        end
        #��b�G�l�~�[��I��
        $msg.t_enemy = $game_temp.battle_active_battler = talk_battler[rand(talk_battler.size)]
        $msg.t_target = $game_temp.battle_target_battler[0] = @ecstasy_battlers_count[0]
      end
    end
    #--------------------------------------------------------------------------------------
    # �����l����
    #--------------------------------------------------------------------------------------
    # �Ⓒ�����L������SP�����ʂ��Z�o(20150823�_���[�W�ʉ���)
    $ecstasy_loss_sp = 0
    #������
    if @self_ecstasy_flag == true
      loss = 100 + ($mood.point * 15 / 10)
      loss += (@ecstasy_battlers_count[0].str / 2) if @ecstasy_battlers_count[0].holding?
      loss = [[loss, (@ecstasy_battlers_count[0].maxsp / 3)].max, 999].min
      loss = loss + rand(@ecstasy_battlers_count[0].level * 5)
      loss = loss.round
    #�g�[�N��
    elsif $msg.talking_ecstasy_flag != nil
      case $msg.tag
      when "��d","����"
        ec_battler = $msg.t_enemy
      else
        ec_battler = $game_actors[101]
      end
      loss = 200 + ec_battler.dex + ($mood.point * 15 / 10)
      loss += ec_battler.str if @ecstasy_battlers_count[0].holding?
      loss = [[loss, (@ecstasy_battlers_count[0].maxsp / 3)].max, 999].min
      loss = loss + ($msg.talk_step * 5)
      loss = loss.round
      $game_switches[79] = false
    else
      loss = 200 + @active_battler.dex + ($mood.point * 15 / 10)
      loss += @active_battler.str if @ecstasy_battlers_count[0].holding?
      loss = [[loss, (@ecstasy_battlers_count[0].maxsp / 3)].max, 999].min
      loss = loss - ($game_temp.difference_damage / 3).floor
      #��l���C���T�[�g���A���Ⓒ�ΏۂƂ̏ꍇ�A�啝�Ƀ_���[�W����
      if @ecstasy_battlers_count[0].vagina_insert?
        if @ecstasy_battlers_count[0].hold.vagina.battler == $game_actors[101]
          loss += [($game_actors[101].str * 3),200].max
        end
      end
      loss = loss.round
    end
    #�x�b�h�C�����͌����ʔ���
    if $game_switches[85] == true
      loss = (loss / 2).ceil
    #�ʏ�퓬���́A���肪�{�X�łȂ���Ό����ꌂ�ŏ��V����_���[�W��^����
#    elsif @ecstasy_battlers_count[0].is_a?(Game_Enemy)
#      unless @ecstasy_battlers_count[0].element_rate(191) >= 2
#        loss = loss * 3
#      end
    end

    #--------------------------------------------------------------
    # �{�C�ɂȂ閲�����܂��{�C���o���Ă��Ȃ��ꍇ�A�u�o���P�����c��
    #--------------------------------------------------------------
    if SR_Util.enemy_before_earnest?(@ecstasy_battlers_count[0])
      # �����u�o�����̖����̌��݂u�o�ȏ�̏ꍇ
      if loss >= @ecstasy_battlers_count[0].sp
        # �u�o���P�����c��
        loss = @ecstasy_battlers_count[0].sp - 1
      end
    end
    
    # �����Ō�������u�o���m�肷�邪�A���ۂɌ���̂͂��̎��̃X�e�b�v��
    $ecstasy_loss_sp = loss
    unless $msg.talking_ecstasy_flag != nil
      attack_element_check
    else
      $msg.talking_ecstasy_flag = nil
    end
    #--------------------------------------------------------------------------------------
    # ���Ⓒ���Ă���L�����N�^�[���G�l�~�[�̏ꍇ
    #--------------------------------------------------------------------------------------
    # �Ⓒ���Ă���̂��G�l�~�[�̏ꍇ
    if @ecstasy_battlers_count[0].is_a?(Game_Enemy)
      # �R�����C�x���g�u�Ⓒ�i�G�l�~�[�j�v�����s
      common_event = $data_common_events[34]
      $game_system.battle_interpreter.setup(common_event.list, 0)
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
    # �Ⓒ���Ă���̂��A�N�^�[�̏ꍇ
    elsif @ecstasy_battlers_count[0].is_a?(Game_Actor)# == $game_actors[101]
      #���V�X�e���E�F�C�g
      case $game_system.ms_skip_mode
      when 3 #�蓮���胂�[�h
        @wait_count = 1
      when 2 #�f�o�b�O���[�h
        @wait_count = 8
      when 1 #�������[�h
        @wait_count = 12
      else
        @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time
      end
      # �R�����C�x���g�u�Ⓒ�i�A�N�^�[�j�v�����s
      common_event = $data_common_events[32]
      $game_system.battle_interpreter.setup(common_event.list, 0)
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
    end
    @status_window.refresh
    # �X�e�b�v 502 �Ɉڍs
    @phase4_step = 502
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 502 : �Ⓒ����(�P��)�F�㔼)
  #--------------------------------------------------------------------------
  def update_phase4_step502
    # ���o�g�����O���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    # �o�g���C�x���g���s���̏ꍇ
    if $game_system.battle_interpreter.running?
      return
    end
    #���V�X�e���E�F�C�g
    case $game_system.ms_skip_mode
    when 3 #�蓮���胂�[�h
      @wait_count = 1
    when 2 #�f�o�b�O���[�h
      @wait_count = 8
    when 1 #�������[�h
      @wait_count = 12
    else
      @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time
    end
    #--------------------------------------------------------------------------------------
    # ���Ⓒ���Ă���L�����N�^�[���G�l�~�[�̏ꍇ�̎��㏈��
    #--------------------------------------------------------------------------------------
    # �����ȊO��SP�_�E���t���O��^����ꍇ�̏���
    if @ecstasy_battlers_count[0].is_a?(Game_Enemy) and @ecstasy_battlers_count[0].sp_down_flag == true
      $game_temp.battle_log_text = "#{@ecstasy_battlers_count[0].name} has reached cli��ax!"
      # �Ⓒ�������L�������y�z���z�����̏ꍇ�A�z�����\�b�h��ʂ�
      if @active_battler.have_ability?("�z��")
        SR_Util.energy_drain(@active_battler,@ecstasy_battlers_count[0]) 
      end
      @ecstasy_battlers_count[0].animation_id = 13
      @ecstasy_battlers_count[0].animation_id = 127
      @ecstasy_battlers_count[0].animation_hit = true
      @ecstasy_battlers_count[0].add_state(1)
      @ecstasy_battlers_count[0].sp_down_flag = false
      @ecstasy_battlers_count[0].sp -= 1
    # �ʏ�Ⓒ�㏈��
    else
      # �Ⓒ�����L�����̂r�o���A�O�i�K�ŎZ�o���Ă����l���������B
      @ecstasy_battlers_count[0].sp = (@ecstasy_battlers_count[0].sp - $ecstasy_loss_sp)
      $ecstasy_loss_sp = 0 #���Z�b�g
      #----------------------------------------------------------------------
      # ���u�o���P�ȏ�c�����ꍇ
      #----------------------------------------------------------------------
      if @ecstasy_battlers_count[0].sp > 0
        #���Ⓒ�X�e�[�g��t�^(���E�N�̂ݐ���X�e�[�g)
        @ecstasy_battlers_count[0].add_state(2) if @ecstasy_battlers_count[0] == $game_actors[101]
        @ecstasy_battlers_count[0].add_state(3) unless @ecstasy_battlers_count[0] == $game_actors[101]
        #���Ⓒ�������s��(�Ⓒ�J�E���g�͌��㏈���̌�ōs��)
        #@ecstasy_battlers_count[0].ecstasy_turn = 1 + @ecstasy_battlers_count[0].ecstasy_count.size
        @ecstasy_battlers_count[0].ecstasy_turn = 2# + @ecstasy_battlers_count[0].ecstasy_count.size
        #@ecstasy_battlers_count[0].ecstasy_turn = 3 if @ecstasy_battlers_count[0].ecstasy_turn > 3
        @ecstasy_battlers_count[0].remove_state(6)
        @ecstasy_battlers_count[0].remove_state(11)
        #���o�b�h�X�e�[�g����
        for i in SR_Util.checking_states
          if @ecstasy_battlers_count[0].states.include?(i)
            @ecstasy_battlers_count[0].remove_state(i)
          end
        end
        #��SP�_�E���t���O�������Ă��Ȃ��ꍇ�A�����ŐⒸ�A�j���[�V������\��
        unless @ecstasy_battlers_count[0].sp_down_flag
          @ecstasy_battlers_count[0].animation_id = 11
          @ecstasy_battlers_count[0].animation_hit = true
        end
        #����EP���ő�l�܂ŉ�
        #  �����͑S���A�G�͂d�o�ő�l�̔����܂ŉ�
        if @ecstasy_battlers_count[0].is_a?(Game_Actor)
          @ecstasy_battlers_count[0].hp = @ecstasy_battlers_count[0].maxhp
        elsif @ecstasy_battlers_count[0].is_a?(Game_Enemy)
          @ecstasy_battlers_count[0].hp = (@ecstasy_battlers_count[0].maxhp / 2).round
        end
        #���V�X�e���E�F�C�g
        case $game_system.ms_skip_mode
        when 3 #�蓮���胂�[�h
          @wait_count = 1
        when 2 #�f�o�b�O���[�h
          @wait_count = 8
        when 1 #�������[�h
          @wait_count = 12
        else
          @wait_count = $game_system.battle_speed_time(0)
        end
        #���O�̂��߃o�g�����O���N���A
        @battle_log_window.contents.clear
        @battle_log_window.keep_flag = false
        $game_temp.battle_log_text = ""
        #----------------------------------------------------------------------
        # ���A�N�^�[�ƃG�l�~�[�̏���
        if @ecstasy_battlers_count[0].is_a?(Game_Actor)
        # �R�����C�x���g�u�Ⓒ��i�A�N�^�[�j�v�����s
          common_event = $data_common_events[33]
          $game_system.battle_interpreter.setup(common_event.list, 0)
        elsif @ecstasy_battlers_count[0].is_a?(Game_Enemy)
          # �m��ŏo���ꍇ�A�܂��͗\������VP���Ώۂ�VP��������ΐⒸ������o��
          if ($game_switches[95] == true or
             $game_switches[91] == true or #�{�X��ł͕K���o��
             $game_switches[85] == true) #�x�b�h�C�����͕K���o��
            # �R�����C�x���g�u�Ⓒ��i�G�l�~�[�j�v�����s
            common_event = $data_common_events[35]
            $game_system.battle_interpreter.setup(common_event.list, 0)
            #���V�X�e���E�F�C�g
            case $game_system.ms_skip_mode
            when 3 #�蓮���胂�[�h
              @wait_count = 1
            when 2 #�f�o�b�O���[�h
              @wait_count = 8
            when 1 #�������[�h
              @wait_count = 12
            else
              @wait_count = $game_system.battle_speed_time(0)
            end
          end
        end
        #���Ⓒ�J�E���g�����Z����
        @ecstasy_battlers_count[0].ecstasy_count.push(@active_battler)
        #���X�e�[�g���O�����ׂăN���A
        @ecstasy_battlers_count[0].add_states_log.clear
        @ecstasy_battlers_count[0].remove_states_log.clear
      #----------------------------------------------------------------------
      # ���u�o���O�ȉ��̏ꍇ
      #----------------------------------------------------------------------
      else
        # �o�g�����O���N���A
        @battle_log_window.contents.clear
        @battle_log_window.keep_flag = false
        $game_temp.battle_log_text = ""
        if @ecstasy_battlers_count[0].is_a?(Game_Enemy)
          # �G�̏ꍇ
          # �o�g�����O���N���A
          $game_temp.battle_log_text = "#{@ecstasy_battlers_count[0].name}��Ⓒ�������I"
          if @active_battler.have_ability?("�z��")
            SR_Util.energy_drain(@active_battler,@ecstasy_battlers_count[0]) 
          end
          @ecstasy_battlers_count[0].animation_id = 127
          @ecstasy_battlers_count[0].animation_hit = true
        else
          # �R�����C�x���g�u�Ⓒ��i�A�N�^�[�j�v�����s
          common_event = $data_common_events[33]
          $game_system.battle_interpreter.setup(common_event.list, 0)
          # �K���R������Ƀo�g�����O���N���A
          @battle_log_window.contents.clear
          @battle_log_window.keep_flag = false
          $game_temp.battle_log_text = ""
        end
      end
    end
    #----------------------------------------------------------------------
    # �z�[���h�p���t���O�̐ݒ�
    $game_switches[83] = false # ������
    if @ecstasy_battlers_count[0].holding?
      $game_switches[83] = true
      # �Ⓒ�����o�g���[�����_���Ă��邩�A�Ⓒ�����{�C��Ԃ̑}�����łȂ�
      # �A�N�e�B�u���̃z�[���h�C�j�V�A�`�u���R�������������̓z�[���h���p�����Ȃ�
      if @ecstasy_battlers_count[0].dead? or
       (not @ecstasy_battlers_count[0].earnest_insert? and @active_battler.hold.initiative_level < 3)
        $game_switches[83] = false
      end
    end
    #----------------------------------------------------------------------
    #���X�e�[�^�X�E�B���h�E�X�V
    @status_window.refresh
    #----------------------------------------------------------------------
    # ����l�����|��邩�ۂ�
    #----------------------------------------------------------------------
    # ����l�������S�ɓ|��Ă��܂����ꍇ�͑��₩�ɏI��
    if $game_actors[101].dead?
      @phase4_step = 6
    else
    # ����l�������݂Ȃ�z�[���h���������Ɉڍs
      @phase4_step = 503
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 503 : �e��z�[���h���� )
  #--------------------------------------------------------------------------
  def update_phase4_step503
    # �e�o�g���[�Ƀz�[���h�󋵂��L�^
    hold_record
    # �z�[���h�p���t���O���o���Ă��Ȃ��ꍇ�͉���
    unless $game_switches[83]
      # �o�g�����O���N���A
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
      make_unhold_text(@ecstasy_battlers_count[0])
      remove_hold("�Ⓒ",@ecstasy_battlers_count[0])
    end
    # �z�[���h�p���t���O�����Z�b�g
    $game_switches[83] = false
    
=begin
    #�����̃z�[���h������ɂ������Ă���Ȃ�������蔭��
    if @ecstasy_battlers_count[0].holding?
      if @ecstasy_battlers_count[0].dead? or @active_battler.hold.initiative_level < 3
        # �o�g�����O���N���A
        @battle_log_window.contents.clear
        @battle_log_window.keep_flag = false
        $game_temp.battle_log_text = ""
        make_unhold_text(@ecstasy_battlers_count[0])
        remove_hold("�Ⓒ",@ecstasy_battlers_count[0])
      end
    end
=end
    # �z�[���h�|�b�v�̎w��
    hold_pops_order
    # �G�������܂��|��Ă��Ȃ��ꍇ
    if not @ecstasy_battlers_count[0].dead?
      #���V�X�e���E�F�C�g
      case $game_system.ms_skip_mode
      when 3 #�蓮���胂�[�h
        @wait_count = 1
      when 2 #�f�o�b�O���[�h
        @wait_count = 8
      when 1 #�������[�h
        @wait_count = 12
      else
        @wait_count = $game_system.battle_speed_time(0) #����20
      end
    else
      # �o�g�����O���N���A
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
    end
    @status_window.refresh
    # �G�l�~�[�Ȃ炷���Ⓒ��������
    if @ecstasy_battlers_count[0].is_a?(Game_Enemy)
      #�Ⓒ�����̍ς񂾃G�l�~�[������
      @ecstasy_battlers_count.delete(@ecstasy_battlers_count[0])
      @phase4_step = 602
    # �A�N�^�[�Ȃ����ւ����������Ă���
    else
      @phase4_step = 504
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 5 : �퓬�s�\������ )
  #--------------------------------------------------------------------------
  def update_phase4_step504
    # �X�e�b�v602�i�Ⓒ�㋓���j�̃t���O
    @phase4_step = 602
    target = @ecstasy_battlers_count[0]
    #�Ⓒ�������I�����A�N�^�[������
    @ecstasy_battlers_count.delete(@ecstasy_battlers_count[0])
    #------------------------------------------------------------------------
    if target.dead?
      for i in $game_party.party_actors
        if not i.dead? and not $game_party.battle_actors.include?(i)
#        if not i.dead? and i != $game_party.party_actors[0] and
#         i != $game_party.party_actors[1]
          # ���_�A���n�ȊO�̃X�e�[�g��S�ĉ���
          for n in target.states
            target.remove_state(n) unless [1,4,5].include?(n)
          end
          target.remove_states_log.clear
          #�z�[���h�S����
          target.hold_reset
          # ���������
          a_actor = target#.dup
          b_actor = i#.dup
          # �w�肵�������o�[����シ��B
=begin
          if target == $game_party.party_actors[0]
            $game_party.battle_actors[0] = b_actor
            $game_party.party_actors[0] = b_actor
            appear_battler = $game_party.battle_actors[0]
          end
          if target == $game_party.party_actors[1]
            $game_party.battle_actors[1] = b_actor
            $game_party.party_actors[1] = b_actor
            appear_battler = $game_party.battle_actors[1]
          end
          if i == $game_party.party_actors[3]
            $game_party.party_actors[3] = a_actor
          elsif i == $game_party.party_actors[2]
            $game_party.party_actors[2] = a_actor
          end
=end
          for num in 0...$game_party.party_actors.size
            if target == $game_party.party_actors[num]
              $game_party.battle_actors.delete(target)
              $game_party.battle_actors.push(b_actor)
              $game_party.party_actors[num] = b_actor
              appear_battler = b_actor
              break
            end
          end
          for num in 0...$game_party.party_actors.size
            if i == $game_party.party_actors[num]
              $game_party.party_actors[num] = a_actor
              break
            end
          end
          
          i = a_actor
          #���퓬�J�n�����֘A�Őݒ�R�ꂪ����΍ēx�ݒ�
          b_actor.state_runk = [0, 0, 0, 0, 0, 0] if b_actor.state_runk == nil
          b_actor.ecstasy_count = [] if b_actor.ecstasy_count == nil
          b_actor.crisis_flag = false
          b_actor.skill_collect = nil
          b_actor.hold_reset
          b_actor.lub_male = 0 if b_actor.lub_male == nil or not b_actor.lub_male > 0
          b_actor.lub_female = 0 if b_actor.lub_female == nil or not b_actor.lub_female > 0
          b_actor.lub_anal = 0 if b_actor.lub_anal == nil or not b_actor.lub_anal > 0
          b_actor.used_mouth = 0 if b_actor.used_mouth == nil or not b_actor.used_mouth > 0
          b_actor.used_anal = 0 if b_actor.used_anal == nil or not b_actor.used_anal > 0
          b_actor.used_sadism = 0 if b_actor.used_sadism == nil or not b_actor.used_sadism > 0
          b_actor.ecstasy_turn = 0 if b_actor.ecstasy_turn == nil
          b_actor.sp_down_flag = false if b_actor.sp_down_flag == nil or b_actor.sp_down_flag == true
          b_actor.ecstasy_emotion = nil
          b_actor.add_states_log.clear
          b_actor.remove_states_log.clear
          b_actor.resist_count = 0 if b_actor.resist_count == nil
          #�x�b�h�C�����A�󕠏P�����͍ŏ������_�`�F�b�N��true�ɂ���
          if $game_switches[85] == true or $game_switches[86] == true
            b_actor.checking = 1
          else
            b_actor.checking = 0
          end
          $game_party.battle_actor_refresh
          # �o�g�����O��\��
          $game_temp.battle_log_text += b_actor.name + " has entered battle!\w\q"
          # �X�e�[�^�X��ʂ����t���b�V��
          @status_window.refresh
          #���o�g���g�[�N�֘A�����Z�b�g
          $game_temp.action_num = 0
          $game_temp.attack_combo_target = ""
          # �A�N�V���������Ώۂ̃o�g���[���N���A
          $game_temp.forcing_battler = nil
          # �摜�ύX
          $game_party.battle_actors[1].graphic_change = true
          # �A�j���[�V������\��
          $game_party.battle_actors[1].animation_id = 18
          $game_party.battle_actors[1].animation_hit = true
          #���V�X�e���E�F�C�g
          case $game_system.ms_skip_mode
          when 3 #�蓮���胂�[�h
            @wait_count = 1
          when 2 #�f�o�b�O���[�h
            @wait_count = 8
          when 1 #�������[�h
            @wait_count = 12
          else
            @wait_count = $game_system.battle_speed_time(0)
          end
=begin
          # �o�����G�t�F�N�g�̃t�F�C�Y��
          @phase4_step = 16
          @phase4_step16_count = 0
=end
          # �o�����G�t�F�N�g�̏������s��
          appear_effect_order([appear_battler])
          return
        end
      end
    end
    #------------------------------------------------------------------------
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 601 : �ǌ�����)
  #--------------------------------------------------------------------------
  def update_phase4_step601
    #���Ⓒ���Ă��Ȃ��ꍇ�A�ǌ�����������ōs��
    if $game_temp.battle_target_battler[0].hp > 0
      if @active_battler.is_a?(Game_Enemy)
        plural_attack_check(@skill,@target_battlers[0])
      elsif @active_battler.current_action.kind == 1
        #�A�N�^�[�s�����ŃX�L���g�p���̂ݒǌ�������s��
        plural_attack_check(@skill,@target_battlers[0])
      else
        $game_switches[78] = false
        $weak_number = $weak_result = 0
      end
    else
      $game_switches[78] = false
      $weak_number = $weak_result = 0
    end
    @phase4_step = 6
  end

  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 602 : �Ⓒ��̋���)
  #--------------------------------------------------------------------------
  def update_phase4_step602
    #���Ⓒ�������K�v�ȃL�����N�^�[���܂����݂���ꍇ
    if @ecstasy_battlers_count.size > 0
      # �X�e�b�v5�i�Ⓒ��������j�ɔ�΂�
      @phase4_step = 5
    else
      # �S���̐Ⓒ���G�t�F�N�g�̎w�����o��
      dead_effect_order(@battlers)
      # �X�e�b�v6�i���t���b�V���j�ɔ�΂�
      @phase4_step = 6
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (���C���t�F�[�Y �X�e�b�v 6 : ���t���b�V��)
  #--------------------------------------------------------------------------
  def update_phase4_step6
#    p "update4-6"if $DEBUG
    case @active_battler.current_action.kind
    when 1 #�X�L���̏ꍇ
      @command = @skill
    when 2 #�X�L���̏ꍇ
      @command = @item
    else
      @command = nil
    end
    # �U���t���O������������
    $game_temp.incite_flag = false

    # �R�����C�x���g ID ���L���̏ꍇ
    if @common_event_id > 0
      if @command == nil
        unless (@skill != nil and @skill.name == "�g�[�N")
          # �C�x���g���Z�b�g�A�b�v
          common_event = $data_common_events[@common_event_id]
          $game_system.battle_interpreter.setup(common_event.list, 0)
        end
      elsif not @command.name == "�g�[�N"
        # �C�x���g���Z�b�g�A�b�v
        common_event = $data_common_events[@common_event_id]
        $game_system.battle_interpreter.setup(common_event.list, 0)
      end
    end
    
    # �w���v�E�B���h�E���B��
    @help_window.visible = false
    # ���w���v�E�B���h�E�т��B��
    @help_window.window.visible = false
    
    # ���o�g�����O�̃N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    # ���������������Ă���ꍇ����
    if @escape_success == true
      # �o�g���J�n�O�� BGM �ɖ߂�
      $game_system.bgm_play($game_temp.map_bgm)
      @escape_success = false
      battle_end(1)
    end
    #�Ⓒ���A��b���͒ǌ���ł��؂�
    if ($game_switches[77] == true or $game_switches[79] == true or @combo_break == true)
      $game_switches[78] = false
    end
    # ���ǌ�������
    if $game_switches[78] == true
      #�ǌ������ŁA�����EP���O�ȏ�Ȃ�ǌ����ڂֈړ�
      if $game_temp.battle_target_battler[0].hp > 0
        $weak_result += 1 #�s�����񐔂��{�P
        # �o�g�����O��\��
        if @active_battler.is_a?(Game_Actor)
          # ����C�x���g���Z�b�g�A�b�v
          common_event = $data_common_events[31]
          $game_system.battle_interpreter.setup(common_event.list, 0)
        else
#          p "�ǌ���/�ΏہF#{$game_temp.battle_target_battler[0].name}"
          # ����C�x���g���Z�b�g�A�b�v
          common_event = $data_common_events[31]
          $game_system.battle_interpreter.setup(common_event.list, 0)
          # �����_���X�L�����đ��U���邽�ߐ�p�y�[�W�֔�΂�
          random_skill_action
        end
        #�g�[�N�X�e�b�v���P�i�߂�
        $msg.talk_step += 1
        # �X�e�b�v 2 �Ɉڍs���čU��
        @phase4_step = 2
      #���肪�Ⓒ���Ă�����I��
      else
        # ���b�Z�[�W�^�O���N���A
#        $msg.tag = ""
        # �A�N�V���������Ώۂ̃o�g���[���N���A
        $game_temp.forcing_battler = nil
        #����Ǘ��n�X�C�b�`��؂��Ă���
        for i in 77..82
          $game_switches[i] = false
        end
        #�Ⓒ�s���p�^�[��������������
        for actor in $game_party.party_actors
          actor.ecstasy_emotion = nil if actor.exist?
        end
        for enemy in $game_troop.enemies
          enemy.ecstasy_emotion = nil if enemy.exist?
        end
        # ���ǌ��������͑��d�s���p�t���O��������
        @active_battler.another_action = false
        #�g�[�N�X�e�b�v�A�ǌ��U����i�����Z�b�g����
        $msg.talk_step = 0
        $msg.at_parts = $msg.at_type = ""
        $msg.t_enemy = $msg.t_target = nil
        $msg.coop_enemy = []
        @combo_break = false
        $msg.moody_flag = false
        $game_switches[89] = false #���W�X�g����X�C�b�`
        # �X�e�b�v 1 �Ɉڍs
        @phase4_step = 1
      end
    else
      # ���b�Z�[�W�^�O���N���A
#      $msg.tag = ""
      # �A�N�V���������Ώۂ̃o�g���[���N���A
      $game_temp.forcing_battler = nil
      #����Ǘ��n�X�C�b�`��؂��Ă���
      for i in 77..82
        $game_switches[i] = false
      end
      #�Ⓒ�s���p�^�[��������������
      for actor in $game_party.party_actors
        actor.ecstasy_emotion = nil if actor.exist?
      end
      for enemy in $game_troop.enemies
        enemy.ecstasy_emotion = nil if enemy.exist?
      end
      # �����d�s���p�t���O�𗧂Ă�
      @active_battler.another_action = true
      #�g�[�N�X�e�b�v�A�ǌ��U����i�����Z�b�g����
      $msg.talk_step = 0
      $msg.at_parts = $msg.at_type = ""
      $msg.t_enemy = $msg.t_target = nil
      $msg.coop_enemy = []
      @combo_break = false
      $msg.moody_flag = false
      $game_switches[89] = false #���W�X�g����X�C�b�`
      # �X�e�b�v 1 �Ɉڍs
      @phase4_step = 1
    end
  end
end