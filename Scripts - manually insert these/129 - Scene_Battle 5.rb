#==============================================================================
# �� Scene_Battle (������` 5)
#------------------------------------------------------------------------------
# �@�o�g����ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Battle
  #--------------------------------------------------------------------------
  # �� ��{�A�N�V���� ���ʍ쐬
  #--------------------------------------------------------------------------
  def make_basic_action_result
    #���V�X�e���E�F�C�g
    case $game_system.ms_skip_mode
    when 3 #�蓮���胂�[�h
      @wait_count = $game_system.battle_speed_time(0)
    when 2 #�f�o�b�O���[�h
      @wait_count = 8
    when 1 #�������[�h
      @wait_count = 12
    else
      @wait_count = $game_system.battle_speed_time(0)
    end
    
    # �U���̏ꍇ
    if @active_battler.current_action.basic == 0
      # �A�j���[�V���� ID ��ݒ�
      @animation1_id = @active_battler.animation1_id
      @animation2_id = @active_battler.animation2_id
      # �s�����o�g���[���G�l�~�[�̏ꍇ
      if @active_battler.is_a?(Game_Enemy)
        if @active_battler.restriction == 3
          target = $game_troop.random_target_enemy
        elsif @active_battler.restriction == 2
          target = $game_party.random_target_actor
        else
          index = @active_battler.current_action.target_index
          target = $game_party.smooth_target_actor(index)
        end
      end
      # �s�����o�g���[���A�N�^�[�̏ꍇ
      if @active_battler.is_a?(Game_Actor)
        if @active_battler.restriction == 3
          target = $game_party.random_target_actor
        elsif @active_battler.restriction == 2
          target = $game_troop.random_target_enemy
        else
          index = @active_battler.current_action.target_index
          target = $game_troop.smooth_target_enemy(index)
        end
      end
      # �Ώۑ��o�g���[�̔z���ݒ�
      @target_battlers = [target]
      # �ʏ�U���̌��ʂ�K�p
      for target in @target_battlers
        target.attack_effect(@active_battler)
      end
      return
    end
    # �h��̏ꍇ
    if @active_battler.current_action.basic == 1
      # ���w���v�E�B���h�E�т�\��
      @help_window.window.visible = true
      # �w���v�E�B���h�E�� "�h��" ��\��
      @help_window.set_text($data_system.words.guard, 1)
      #  ���o�g�����O��\��
      $game_temp.battle_log_text += @active_battler.name + "�͖h�䂵�Ă���c�c\067"
      @phase4_step = 6
      return
    end
    # ������̏ꍇ
    if @active_battler.is_a?(Game_Enemy) and
       @active_battler.current_action.basic == 2
      # ���w���v�E�B���h�E�т�\��
      @help_window.window.visible = true
      # �w���v�E�B���h�E�� "������" ��\��
      @help_window.set_text("������", 1)
      # ���o�g�����O��\��
      # �����郁�b�Z�[�W�͕ʂ̏ꏊ�ɏ����Ȃ��ƃ_���݂����B(������)
      $game_temp.battle_log_text += @active_battler.name + "�͓����o�����I\067"
      # ������
      @active_battler.escape
      @phase4_step = 6
      return
    end
    # �������Ȃ��̏ꍇ
    if @active_battler.current_action.basic == 3
      # �A�N�V���������Ώۂ̃o�g���[���N���A
      $game_temp.forcing_battler = nil
      # �B��Ă��閲���ƃX�^����Ԃ̖����̓��O���o���Ȃ��B
      if @active_battler.hidden == false and @active_battler.another_action == false
        if @active_battler.is_a?(Game_Enemy) and not $game_temp.first_attack_flag == 1
          # ���o�g�����O��\��
          $game_temp.battle_log_text += @active_battler.name + " is observing...\067"
        else
          @wait_count = 0
        end
        @phase4_step = 6
        return
      else
        # ���X�e�b�v 6 �Ɉڍs
        @wait_count = 0
        @phase4_step = 6
        return
      end
    end
    # �����̏ꍇ
    if @active_battler.current_action.basic == 2
      # �����\�ȏꍇ�͓���
      if @active_battler.can_escape?
        # �A�N�V���������Ώۂ̃o�g���[���N���A
        $game_temp.forcing_battler = nil
        @active_battler.white_flash = true
        # ���o�g�����O��\��
        $game_temp.battle_log_text += @active_battler.name + " ran a��ay!\065\067"
        # �E�F�C�g���Đݒ�
        #���V�X�e���E�F�C�g
        case $game_system.ms_skip_mode
        when 3 #�蓮���胂�[�h
          @wait_count = 1
        when 2 #�f�o�b�O���[�h
          @wait_count = 6
        when 1 #�������[�h
          @wait_count = 8
        else
          @wait_count = 12
        end
        # ���� SE �����t
        $game_system.se_play($data_system.escape_se)
        escape_result
      # �����s�\�ȏꍇ�̓E�F�C�g���O�ɂ��ďI��
      else
        @wait_count = 0
      end
      @phase4_step = 6
      return
    end
    # �p�[�e�B���̏ꍇ
    if @active_battler.current_action.basic == 5
      # ���\�ȏꍇ�͌��
      if @active_battler.can_escape?
        # ���O�̃X�e�[�g��
        # ���_�A���n�ȊO�̃X�e�[�g��S�ĉ���
        for n in @active_battler.states
          @active_battler.remove_state(n) unless [1,4,5].include?(n)
        end
        @active_battler.remove_states_log.clear
        #�z�[���h�S����
        @active_battler.hold_reset
        # ���������
        actor_1 = $game_party.party_actors[@active_battler.change_index[0]]#.dup
        actor_2 = $game_party.party_actors[@active_battler.change_index[1]]#.dup
        # �w�肵�������o�[����シ��
        $game_party.party_actors[@active_battler.change_index[0]] = actor_2
        $game_party.party_actors[@active_battler.change_index[1]] = actor_1
        $game_party.battle_actor_refresh
        @active_battler = $game_party.party_actors[@active_battler.change_index[0]]
        # �摜�ύX
        @active_battler.graphic_change = true
        #���퓬�J�n�����֘A�Őݒ�R�ꂪ����΍ēx�ݒ�
        actor_2.state_runk = [0, 0, 0, 0, 0, 0] if actor_2.state_runk == nil
        actor_2.ecstasy_count = [] if actor_2.ecstasy_count == nil
        actor_2.crisis_flag = false
        actor_2.skill_collect = nil
        actor_2.hold_reset
        actor_2.lub_male = 0 if actor_2.lub_male == nil or not actor_2.lub_male > 0
        actor_2.lub_female = 0 if actor_2.lub_female == nil or not actor_2.lub_female > 0
        actor_2.lub_anal = 0 if actor_2.lub_anal == nil or not actor_2.lub_anal > 0
        actor_2.used_mouth = 0 if actor_2.used_mouth == nil or not actor_2.used_mouth > 0
        actor_2.used_anal = 0 if actor_2.used_anal == nil or not actor_2.used_anal > 0
        actor_2.used_sadism = 0 if actor_2.used_sadism == nil or not actor_2.used_sadism > 0
        actor_2.ecstasy_turn = 0 if actor_2.ecstasy_turn == nil
        actor_2.ecstasy_emotion = nil
        actor_2.sp_down_flag = false if actor_2.sp_down_flag == nil or actor_2.sp_down_flag == true
        actor_2.resist_count = 0 if actor_2.resist_count == nil
        actor_2.add_states_log.clear
        actor_2.remove_states_log.clear
        #�x�b�h�C�����A�󕠏P�����͍ŏ������_�`�F�b�N��true�ɂ���
        if $game_switches[85] == true or $game_switches[86] == true
          actor_2.checking = 1
        else
          actor_2.checking = 0
        end
        # �o�g�����O��\��
        $game_temp.battle_log_text += actor_1.name + " and " + actor_2.name + "\065\n s��itched places!\065\067"
        # �X�e�[�^�X��ʂ����t���b�V��
        @status_window.refresh
        # �A�N�V���������Ώۂ̃o�g���[���N���A
        $game_temp.forcing_battler = nil
        # �A�j���[�V������\��
        @active_battler.animation_id = 18
        @active_battler.animation_hit = true
        # �o�����G�t�F�N�g�̃t�F�C�Y��
        appear_effect_order([@active_battler])
      # ���s�\�ȏꍇ�̓E�F�C�g���O�ɂ��ďI��
      else
        @wait_count = 0
      end
      @phase4_step = 6
      return
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�p�[�e�B�R�}���h�t�F�[�Y : ������)
  #--------------------------------------------------------------------------
  def escape_result
    # �G�l�~�[�̑f�������ϒl���v�Z
    enemies_agi = 0
    enemies_number = 0
    for enemy in $game_troop.enemies
      if enemy.exist?
        enemies_agi += enemy.agi
        enemies_number += 1
      end
    end
    if enemies_number > 0
      enemies_agi /= enemies_number
    end
    # �A�N�^�[�̑f�������ϒl���v�Z
    actors_agi = 0
    actors_number = 0
    for actor in $game_party.actors
      if actor.exist?
        agi_one = actor.agi
        # ��Ⴢ͑f������1/10�����ɂ���B
        agi_one /= 10 if actor.state?(39)
        actors_agi += agi_one
        actors_number += 1
      end
    end
    if actors_number > 0
      # ���ϒl���Z�o
      actors_agi /= actors_number
      # �S�̓����␳�͂����Ŋ|����
      actors_agi += actors_agi / 2 if @active_battler.equip?("�����̃A���N���b�g")
      actors_agi += actors_agi / 2 if @active_battler.have_ability?("�����̋Ɉ�")
    end
    # ������������
    success = rand(100) < 50 * actors_agi / enemies_agi
    # ���������̏ꍇ(�搧���͂P�O�O����������)
    if success or @actor_first_attack == true
      @escape_success = true
    # �������s�̏ꍇ
    else
      # ���o�g�����O��\��
      $game_temp.battle_log_text += "��������肱�܂�Ă��܂����I\067"
      # �E�F�C�g���Đݒ�
      #���V�X�e���E�F�C�g
      case $game_system.ms_skip_mode
      when 3 #�蓮���胂�[�h
        @wait_count = $game_system.battle_speed_time(0)
      when 2 #�f�o�b�O���[�h
        @wait_count = 8
      when 1 #�������[�h
        @wait_count = 12
      else
        @wait_count = $game_system.battle_speed_time(0)
      end
      #�Ώێ��O�I��ς݃g�[�N�X�e�b�v��ݒ�
      $msg.callsign = 40
      $msg.talk_step = 100
=begin
      talk = []
      for enemy in $game_troop.enemies
        if enemy.talkable?
          talk.push(enemy)
        end
      end
      talk.push($game_actors[101]) if talk == []
      $msg.t_enemy = talk[rand(talk.size)]
      $msg.t_target = $game_actors[101]
=end
      $msg.tag = "�������s"
      @common_event_id = 31
      #�������I�������K���X�e�b�v���O�ɖ߂�
      $msg.talk_step = 0
    end
  end
  #--------------------------------------------------------------------------
  # �� �X�L���܂��̓A�C�e���̑Ώۑ��o�g���[�ݒ�
  #     scope : �X�L���܂��̓A�C�e���̌��ʔ͈�
  #--------------------------------------------------------------------------
  def set_target_battlers(scope, skill_id = nil)
    
    # �ǋL
    # ������skill_id��ǉ����A�Ώۂ̃X���[�Y�Ȍ���ɃX�L��ID�������p���悤�ɂ��܂����B
    
    # �s�����o�g���[���G�l�~�[�̏ꍇ
    if @active_battler.is_a?(Game_Enemy)
      # ���ʔ͈͂ŕ���
      case scope
      when 1  # �G�P��
        index = @active_battler.current_action.target_index
#        p "�s���F#{@active_battler.name}/�Ώ�index�F#{index}"if $DEBUG
        @target_battlers.push($game_party.smooth_target_actor(index, skill_id))
      when 2  # �G�S��
        for actor in $game_party.actors
          if actor.exist?
            @target_battlers.push(actor)
          end
        end
      when 3  # �����P��
        index = @active_battler.current_action.target_index
        @target_battlers.push($game_troop.smooth_target_enemy(index,skill_id))
      when 4  # �����S��
        for enemy in $game_troop.enemies
          if enemy.exist?
            @target_battlers.push(enemy)
          end
        end
      when 5  # �����P�� (HP 0) 
        index = @active_battler.current_action.target_index
        enemy = $game_troop.enemies[index]
        if enemy != nil and enemy.hp0?
          @target_battlers.push(enemy)
        end
      when 6  # �����S�� (HP 0) 
        for enemy in $game_troop.enemies
          if enemy != nil and enemy.hp0?
            @target_battlers.push(enemy)
          end
        end
      when 7  # �g�p��
        @target_battlers.push(@active_battler)
      end
    end
    # �s�����o�g���[���A�N�^�[�̏ꍇ
    if @active_battler.is_a?(Game_Actor)
      # ���ʔ͈͂ŕ���
      case scope
      when 1  # �G�P��
        index = @active_battler.current_action.target_index
        @target_battlers.push($game_troop.smooth_target_enemy(index,skill_id))
      when 2  # �G�S��
        for enemy in $game_troop.enemies
          if enemy.exist?
            @target_battlers.push(enemy)
          end
        end
      when 3  # �����P��
        index = @active_battler.current_action.target_index
        @target_battlers.push($game_party.smooth_target_actor(index,skill_id))
      when 4  # �����S��
        for actor in $game_party.actors
          if actor.exist?
            @target_battlers.push(actor)
          end
        end
      when 5  # �����P�� (HP 0) 
        index = @active_battler.current_action.target_index
        actor = $game_party.actors[index]
        if actor != nil and actor.hp0?
          @target_battlers.push(actor)
        end
      when 6  # �����S�� (HP 0) 
        for actor in $game_party.actors
          if actor != nil and actor.hp0?
            @target_battlers.push(actor)
          end
        end
      when 7  # �g�p��
        @target_battlers.push(@active_battler)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �X�L���A�N�V���� ���ʍ쐬
  #--------------------------------------------------------------------------
  def make_skill_action_result
    # �X�L�����擾
    @skill = $data_skills[@active_battler.current_action.skill_id]
    
    # nil�΍�
    if @skill == nil
      @skill = $data_skills[299] # �G���[�V����
    end
    
    # �����A�N�V�������ȊO���X�L�����g�p�s�ȏꍇ
    if not @active_battler.current_action.forcing and @active_battler.is_a?(Game_Actor)
      # �X�L�����Ë��ł���ꍇ�A�Ë����ă`�F�b�N�B
      # �Ë����Ă��g�p�s�\�ȏꍇ�͑��I��
      end_flag = false
      while end_flag == false
        unless @active_battler.skill_can_use?(@skill.id)
          # �w���B�s�X�g�����s�X�g��
          if @skill.id == 33
            new_id = 32
            @skill = $data_skills[new_id]
            @active_battler.current_action.skill_id = new_id
            next
          end
          $game_temp.forcing_battler = nil
          @active_battler.another_action = true
          @phase4_step = 1
          return
        end
        end_flag = true
      end
    end
    # �ؕ|�̏ꍇ�A�R�O���̊m���ōs���s�\�ɂȂ�
    # (���������Ƀ��C�N�A�N�V�����ňؕ|�s�����Z�b�g���ꂽ�ꍇ�͔�΂�)
    unless @skill.id == 297
      if @active_battler.states.include?(38) and rand(100) < 30
        @skill = $data_skills[297]
        @active_battler.current_action.forcing = true
        @active_battler.another_action = false
      end
    end
    # �\���̏ꍇ�A�K�������_���A�N�V�����ƂȂ�
    if @active_battler.state?(36) and not @active_battler.berserk == false
      @active_battler.berserk = true
    elsif @active_battler.berserk == true and not @active_battler.state?(36)
      @active_battler.berserk = false
    end
    if @active_battler.berserk == true and $game_switches[78] == false
      @skill = $data_skills[296] if @skill.id != 296
      @active_battler.another_action = false
#      @active_battler.current_action.forcing = true
    end

#    p "�g�p�X�L��(�J�n)�F#{@skill.name}" if $DEBUG
#    p @active_battler.current_action.kind if $DEBUG
    # �Ώۑ��o�g���[��ݒ�
    set_target_battlers(@skill.scope, @skill.id)
    # ���^�[�Q�b�g�o�g���[�̏����L���@���R�����C�x���g�Ŏg���܂��B
    $game_temp.battle_target_battler = @target_battlers
#    p "�s��5-2�F#{@active_battler.name}/�Ώ�index�F#{@active_battler.current_action.target_index}"if $DEBUG
#    p "�Ώ�(�J�n)�F#{@target_battlers[0].name}" if $DEBUG

    # �������_���X�L�����g�p����ꍇ�A��p�y�[�W�֔�΂�
    if @skill.element_set.include?(9)
#      p $data_skills[@active_battler.current_action.skill_id].name
      random_skill_action
    end
    
    # �G���[�e�L�X�g��������
    @error_text = ""
   
    # ��---------------------------------------------------------------

    # �U�������G�l�~�[�̏ꍇ
    if @active_battler.is_a?(Game_Enemy)
      ct = 0
      # ���ǋL����-----------------------------------  
      #
      # �����s�ȃX�L���̏ꍇ�A�����\�Ȃ��̂��o��܂őI�ђ���
      #
      # ------------------------------------------------------------

      loop do
        #----------------------------------------------------------------
        # �� �G���[�W
        #----------------------------------------------------------------
        # �G���[�p�ϐ������Z�b�g
        n = 0
        a = 0
#        a = 1 if $DEBUG
        # ���^�[�Q�b�g�D�揇��
        #   �ώ�(���E���b�g�����_��Ȃ�)���z�[���h�Ώہ��C���g���X�g���A�s�[�����}�[�L���O
        # ���A�s�[����Ԃ̃p�[�g�i�[������ꍇ�A������ɍU�����W������
        #   �������g�[�N���A�}�����͂��̌���ł͂Ȃ�
        
        # ���̂u�o����O���A���E���ŏ���u�o�����݂̂u�o��艺����Ă���ꍇ�A
        # �����x�~�ɂ���
        if SR_Util.sp_cost_result(@active_battler, @skill) >= @active_battler.sp and
         @skill.sp_cost == 0
          # ���x�~���g�p����
          @active_battler.current_action.skill_id = 970
          @skill = $data_skills[@active_battler.current_action.skill_id]
          @active_battler.current_action.kind = 1
          if @skill.scope == 7 #�����ɍs������
            $game_temp.attack_combo_target = @active_battler
            @target_battlers = []
            @target_battlers.push($game_temp.attack_combo_target)
            # ���^�[�Q�b�g�o�g���[�̏����L��
            $game_temp.battle_target_battler = @target_battlers
          end
          if @active_battler.is_a?(Game_Enemy)
            @active_battler.current_action.decide_random_target_for_enemy
          end
          $game_temp.battle_target_battler = @target_battlers
          # ���L�������X�L��������
          $game_temp.skill_selection = nil
          break
        end
        
        #�Ζ�����(�󕠎��A�x�b�h�C����)�͈ꕔ���@�𐧌�����
        if ($game_switches[85] == true or $game_switches[86] == true)
          #���S�Ɏg�p�s�̏ꍇ
          if @skill.element_set.include?(69)
            n = 1
            p "�Ζ����펞�͎g�p�s��" if a == 1
          #������������ꍇ�́A�P�^�Q�̊m���ōĒ���
          elsif @skill.element_set.include?(68)
            if rand(100) > 20
              n = 1
              p "�Ζ����펞�̐����ɂ��g�p�s��" if a == 1
            end
          end
        end
        # ���z�[���h���̑���݂̂�ΏۂƂ���X�L���̑I��
        if @skill.element_set.include?(189)
          unless @target_battlers[0].holding?
            n = 1
            p "�z�[���h���̃L�����N�^�[�łȂ��̂ŕs��" if a == 1
          end
        # ����z�[���h��Ԃ̑���݂̂�ΏۂƂ���X�L���̑I��
        elsif @skill.element_set.include?(188)
          if @target_battlers[0].holding?
            n = 1
            p "�z�[���h���̃L�����N�^�[�Ȃ̂ŕs��" if a == 1
          end
        end
        # �����@�X�L���̏ꍇ�A���g���z�[���h�����Ǝg�p�s��
        if @skill.element_set.include?(5)
        #----------------------------------------------------------------
          if @active_battler.holding?
            n = 1
            p "���g���z�[���h���Ȃ̂Ŏg�p�s��" if a == 1
          end
        end
        # ��������ΏۂɎ��Ȃ��X�L���Ŏ�����I�������ꍇ�g�p�s��
        if @skill.element_set.include?(19)
        #----------------------------------------------------------------
          if @active_battler == @target_battlers[0]
            n = 1
            p "������ΏۂɎ��Ȃ��X�L���Ȃ̂Ŏg�p�s��" if a == 1
          end
        end
        # �������F���ߒ��s�̃X�L���̏ꍇ
        if @skill.element_set.include?(177)
        #----------------------------------------------------------------
          #���}��(�z�[���h�^�C�v�F�}���őΏۂ���)�������}���́A���肪�}���\�ȏ󋵂łȂ���Βe��
          if @skill.element_set.include?(134)
            unless @skill.element_set.include?(91)
              unless (@active_battler.insertable_half_nude? or @active_battler.full_nude?)
                n = 1
                p "�G�l�~�[�������߂̂��ߕs��(�}���n)�F#{@active_battler.name}�F#{@skill.name}" if a == 1
              end
            end
          # ���������ߏ�Ԃł���ꍇ
          elsif not @active_battler.full_nude?
            n = 1
            p "�G�l�~�[�������߂̂��ߕs�F#{@active_battler.name}�F#{@skill.name}" if a == 1
          end
        end
        # ������F���ߒ��s�̃X�L���̏ꍇ
        if @skill.element_set.include?(178)
        #----------------------------------------------------------------
          #���}��(�z�[���h�^�C�v�F�}���őΏۂ���)�������}���́A���肪�}���\�ȏ󋵂łȂ���Βe��
          if @skill.element_set.include?(134)
            unless @skill.element_set.include?(91)
              unless (@target_battlers[0].insertable_half_nude? or @target_battlers[0].full_nude?)
                n = 1
                p "�A�N�^�[�������߂̂��ߕs��(�}���n)�F#{@target_battlers[0].name}�F#{@skill.name}" if a == 1
              end
            end
          # ���肪���ߏ�Ԃł���ꍇ
          elsif not @target_battlers[0].full_nude?
            n = 1
            p "�A�N�^�[�������߂̂��ߕs�F#{@target_battlers[0].name}�F#{@skill.name}" if a == 1
          end
        end
        # �������F�E�ߒ��s�̃X�L���̏ꍇ
        if @skill.element_set.include?(179)
        #----------------------------------------------------------------
          # ����������Ԃł���ꍇ
          if @active_battler.nude?
            n = 1
            p "�G�l�~�[�������̂��ߕs�F#{@active_battler.name}�F#{@skill.name}" if a == 1
          end
        end
        # ������F�E�ߒ��s�̃X�L���̏ꍇ
        if @skill.element_set.include?(180)
        #----------------------------------------------------------------
          # ���肪����Ԃł���ꍇ
          if @target_battlers[0].full_nude?
            n = 1
            p "�A�N�^�[�������̂��ߕs�F#{@target_battlers[0].name}�F#{@skill.name}" if a == 1
          end
        end

      
        # ���z�[���h���D������p�X�L���̏ꍇ
        if @skill.element_set.include?(137) and @active_battler.holding?
        #------------------------------------------------------------------------
          # �������򐨂̏ꍇ
          unless @active_battler.initiative?
            n = 1
          end
        end
        # ���z�[���h���򐨎���p�X�L���̏ꍇ
        #------------------------------------------------------------------------
        if @skill.element_set.include?(138) and @active_battler.holding?
          # �������򐨂̏ꍇ
          if @active_battler.initiative?
            n = 1
          end
        end
        #------------------------------------------------------------------------
        # �������F����L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(140)
          # �����̃y�j�X���N���o�g���[�Ő�L����Ă���Εs��
          if @active_battler.hold.penis.battler != nil
            n = 1
          end
        end
        #------------------------------------------------------------------------
        # ������F����L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(141)
          # �����̃y�j�X���N���o�g���[�Ő�L����Ă���Εs��
          if @target_battlers[0].hold.penis.battler != nil
            n = 1
          end
        end
        # ������L���̂݉̃X�L���̏ꍇ
        #------------------------------------------------------------------------
        if @skill.element_set.include?(142)
          # �����́������}����ԂŖ����ꍇ
          unless @active_battler.penis_insert?
            n = 1
          end
        end
        if @skill.element_set.include?(143)
        # �����́���������ԂŖ����ꍇ
          unless @active_battler.penis_oralsex?
            n = 1
          end
        end
        if @skill.element_set.include?(144)
        # �����́����芭��ԂŖ����ꍇ
          unless @active_battler.penis_analsex?
            n = 1
          end
        end
        #------------------------------------------------------------------------
        # �������F����L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(146)
          # ������L���̏ꍇ
          if @active_battler.hold.mouth.battler != nil
            n = 1
          end
        end
        # ������F����L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(147)
          # ������L���̏ꍇ
          if @target_battlers[0].hold.mouth.battler != nil
            n = 1
          end
        end
        # �����}�����̂݉̃X�L���̏ꍇ
        #------------------------------------------------------------------------
        if @skill.element_set.include?(148)
        # �����̌������}����ԂŖ����ꍇ
          unless @active_battler.mouth_oralsex?
            n = 1
          end
        end
        if @skill.element_set.include?(149)
        # �����̌�����ʋR���ԂŖ����ꍇ
          unless @active_battler.mouth_riding?
            n = 1
          end
        end
        if @skill.element_set.include?(145)
        # �����̌����K�R���ԂŖ����ꍇ
          unless @active_battler.mouth_hipriding?
            n = 1
          end
        end
        if @skill.element_set.include?(150)
        # �����̌����N���j��ԂŖ����ꍇ
          unless @active_battler.mouth_draw?
            n = 1
          end
        end
        if @skill.element_set.include?(170)
        # �����̌���D�L�b�X��ԂŖ����ꍇ
          unless @active_battler.deepkiss?
            n = 1
          end
        end
        #------------------------------------------------------------------------
        # �������F�K��L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(151)
          # �������K�}�����̏ꍇ
          if @active_battler.hold.anal.battler != nil
            n = 1
          end
        end
        # ������F�K��L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(152)
          # �������K�}�����̏ꍇ
          if @target_battlers[0].hold.anal.battler != nil
            n = 1
          end
        end
        # ���K��L���̂݉̃X�L���̏ꍇ
        #------------------------------------------------------------------------
        if @skill.element_set.include?(153)
          # �����̐K���K�}����ԂŖ����ꍇ
          unless @active_battler.anal_analsex?
            n = 1
          end
        end
        if @skill.element_set.include?(154)
          # �����̐K���K�R���ԂŖ����ꍇ
          unless @active_battler.anal_hipriding?
            n = 1
          end
        end
        #------------------------------------------------------------------------
        # �������F����L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(155)
          # ����������L���̏ꍇ
          if @active_battler.hold.vagina.battler != nil
            n = 1
          end
        end
        # ������F����L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(156)
          # ���肪����L���̏ꍇ
          if @target_battlers[0].hold.vagina.battler != nil
            n = 1
          end
        end
        # ������L���̂݉̃X�L���̏ꍇ
        #------------------------------------------------------------------------
        if @skill.element_set.include?(157)
        # �����́������}����ԂŖ����ꍇ
          unless @active_battler.vagina_insert?
            n = 1
          end
        end
        if @skill.element_set.include?(158)
        # �����́����R���ԂŖ����ꍇ
          unless @active_battler.vagina_riding?
            n = 1
          end
        end
        if @skill.element_set.include?(159)
        # �����́����L���킹��ԂŖ����ꍇ
          unless @active_battler.shellmatch?
            n = 1
          end
        end
        #------------------------------------------------------------------------
        # �������F�㔼�g��L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(161)
          # �������㔼�g��L���̏ꍇ
          if @active_battler.hold.tops.battler != nil
            @error_text = "�������㔼�g��L���ŏ㔼�g�g�p"
            n = 1
          end
        end
        if @skill.element_set.include?(162)
          # �������㔼�g��L���̏ꍇ
          if @target_battlers[0].hold.tops.battler != nil
            @error_text = "�������㔼�g��L���ŏ㔼�g�g�p"
            n = 1
          end
        end
        # ���㔼�g��L���̂݉̃X�L���̏ꍇ
        #------------------------------------------------------------------------
        if @skill.element_set.include?(163)
        # �����̏㔼�g���S�����(�U�ߎ�)�Ŗ����ꍇ
          unless @active_battler.tops_binder? or @active_battler.tops_binding?
            n = 1
            @error_text = "�����̏㔼�g���S�����(�U�ߎ�)�Ŗ���"
          end
        end
        if @skill.element_set.include?(164)
        # �����̏㔼�g���J�r���(�U�ߎ�)�Ŗ����ꍇ
          unless @active_battler.tops_openbinder? or @active_battler.tops_openbinding?
            n = 1
          end
        end
        if @skill.element_set.include?(160)
        # �����̏㔼�g���p�C�Y�����(�U�ߎ�)�Ŗ����ꍇ
          unless @active_battler.tops_paizuri?
            n = 1
          end
        end
        if @skill.element_set.include?(171)
        # �����̏㔼�g���ςӂςӏ��(�U�ߎ�)�Ŗ����ꍇ
          unless @active_battler.tops_pahupahu?
            n = 1
          end
        end
        #------------------------------------------------------------------------
        # �������F�K����L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(165)
        # �����̐K����}�����̏ꍇ
          if @active_battler.hold.tail.battler != nil
            n = 1
          end
        end
        if @skill.element_set.include?(166)
        # �����̐K����}�����̏ꍇ
          if @target_battlers[0].hold.tail.battler != nil
            n = 1
          end
        end
        # ���K����L���̂݉̃X�L���̏ꍇ
        #------------------------------------------------------------------------
        if @skill.element_set.include?(167)
        # �����̐K�������}����ԂŖ����ꍇ
          unless @active_battler.tail_insert?
            n = 1
          end
        end
        if @skill.element_set.include?(168)
        # �����̐K����������ԂŖ����ꍇ
          unless @active_battler.tail_oralsex?
            n = 1
          end
        end
        if @skill.element_set.include?(169)
        # �����̐K�����芭��ԂŖ����ꍇ
          unless @active_battler.tail_analsex?
            n = 1
          end
        end
        #------------------------------------------------------------------------
        # ���G���L���̂݉̃X�L���̏ꍇ
        #------------------------------------------------------------------------
        if @skill.element_set.include?(172)
        # �����̐G�肪���}����ԂŖ����ꍇ
          unless @active_battler.tentacle_insert?
            n = 1
          end
        end
        if @skill.element_set.include?(173)
        # �����̐G�肪������ԂŖ����ꍇ
          unless @active_battler.tentacle_oralsex?
            n = 1
          end
        end
        if @skill.element_set.include?(174)
        # �����̐G�肪�芭��ԂŖ����ꍇ
          unless @active_battler.tentacle_analsex?
            n = 1
          end
        end
        if @skill.element_set.include?(175)
        # �����̐G��ő�����S�����Ă��Ȃ��ꍇ
          unless @active_battler.tentacle_binder?
            n = 1
            @error_text = "�����̐G��ōS�������Ă��Ȃ�"
          end
        end
        if @skill.element_set.include?(176)
        # �����̐G��ő�����J�r�����Ă��Ȃ��ꍇ
          unless @active_battler.tentacle_openbinder?
            n = 1
            @error_text = "�����̐G��ŊJ�r�����Ă��Ȃ�"
          end
        end

        #------------------------------------------------------------------------
        # �������F�f�B���h��L���s�̃X�L���̏ꍇ
        if @skill.element_set.include?(182)
          # �����̃f�B���h��}�����̏ꍇ
          n = 1 if @active_battler.hold.dildo.battler != nil
        end
        # ���K����L���̂݉̃X�L���̏ꍇ
        #------------------------------------------------------------------------
        if @skill.element_set.include?(183)
        # �����̃f�B���h�����}����ԂŖ����ꍇ
          n = 1 unless @active_battler.dildo_insert?
        end
        if @skill.element_set.include?(184)
        # �����̃f�B���h��������ԂŖ����ꍇ
          n = 1 unless @active_battler.dildo_oralsex?
        end
        if @skill.element_set.include?(185)
        # �����̃f�B���h���芭��ԂŖ����ꍇ
          n = 1 unless @active_battler.dildo_analsex?
        end

        # ���Βj�p�X�L���̏ꍇ
        if @skill.element_set.include?(41)
        #----------------------------------------------------------------
          # ���肪�j�i��l���j�łȂ��ꍇ
          unless @target_battlers[0] == $game_actors[101]
            n = 1
            p "�Βj�X�L�������Ɏg�p���Ă��邽�ߕs�F#{@skill.name}" if a == 1
          end
        end
        # ���Ώ��p�X�L���̏ꍇ
        if @skill.element_set.include?(42)
        #----------------------------------------------------------------
          # ���肪�j�i��l���j�ł���ꍇ
          if @target_battlers[0] == $game_actors[101]
            n = 1
            p "�Ώ��X�L����j�Ɏg�p���Ă��邽�ߕs�F#{@skill.name}" if a == 1
          end
        end
        # ���X�e�[�^�X�ω����@�̏ꍇ
        # �X�e�[�g�ω������������A�_���[�W���������̏ꍇ�A���łɂ��Ă�����̂ɂ͎g�p���Ȃ�
        if @skill.element_set.include?(33) and @skill.element_set.include?(17) 
          if @skill.id == 215 #�g�������[�g�F���_�n�o�X�e����
            unless @target_battlers[0].badstate_mental?
              n = 1
              p "���_�n�o�b�h�X�e�[�g�ł͂Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
            end
          elsif @skill.id == 216 #�g�����X�g�[�N�F���f�n�o�X�e����
            unless @target_battlers[0].badstate_curse?
              n = 1
              p "���f�n�o�b�h�X�e�[�g�ł͂Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
            end
          elsif  @skill.id == 217 #�g�������@�C���F�����n�o�X�e����
            unless @target_battlers[0].badstate_tool?
              n = 1
              p "�����n�o�b�h�X�e�[�g�ł͂Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
            end
          else #�o�X�e�t�^
            for i in SR_Util.checking_states # ��ʃo�X�e
              if @skill.plus_state_set.include?(i) and @target_battlers[0].states.include?(i)
                n = 1
                p "���ɃX�e�[�g�t�^����Ă���̂Ŏg�p�s�F#{@skill.name}" if a == 1
                break
              end
            end
            for i in [30,98,104] # ����o�X�e
              if @skill.plus_state_set.include?(i) and @target_battlers[0].states.include?(i)
                n = 1
                p "���ɃX�e�[�g�t�^����Ă���̂Ŏg�p�s�F#{@skill.name}" if a == 1
                break
              end
            end
          end
        end
        # ���p�����[�^�ω����@�̏ꍇ
        if @skill.element_set.include?(34)
        # ���łɏ���܂ł������Ă���ꍇ�͎g�p���Ȃ�
        #----------------------------------------------------------------
          #������
          if @skill.element_set.include?(67) #�S����
            eff_count = 0
            for i in 0..5
              # �Ώۂ��G�l�~�[�i���R�j�Ȃ�㉻�l�̐��𐔂���
              if @target_battlers[0].is_a?(Game_Enemy) and 
              @target_battlers[0].state_runk[i] < 0 
                eff_count += @target_battlers[0].state_runk[i].abs
              # �Ώۂ��A�N�^�[�[�i�G�R�j�Ȃ狭���l�̐��𐔂���
              elsif @target_battlers[0].is_a?(Game_Actor) and 
              @target_battlers[0].state_runk[i] < 0 
                eff_count += @target_battlers[0].state_runk[i].abs
              end
            end
            n = 1 if eff_count < 1 # �����P�ȉ��Ȃ�g��Ȃ�
=begin
            n = 1
            for i in 0..5
              if @target_battlers[0].state_runk[i] != 0 
                n = 0
                break
              end
            end
=end
            p "�������������\�͕ω��������̂Ŏg�p�s�F#{@skill.name}" if a == 1 and n == 1
          elsif @skill.element_set.include?(65) #��������
            n = 1
            for i in 0..5
              if @target_battlers[0].state_runk[i] > 0
                n = 0
                break
              end
            end
            p "�������ꂽ�\�͂������̂Ŏg�p�s�F#{@skill.name}" if a == 1 and n == 1
          elsif @skill.element_set.include?(66) #��̉�����
            n = 1
            for i in 0..5
              if @target_battlers[0].state_runk[i] < 0
                n = 0
                break
              end
            end
            p "��̉������\�͂������̂Ŏg�p�s�F#{@skill.name}" if a == 1 and n == 1
          #���S�\��
          elsif @skill.element_set.include?(63) #�X�g�����u����
            effectable = []
            state_count = 0
            # �ΏۑS�����m�F
            for target in @target_battlers
              # �S�X�e�[�^�X�̏㏸�␳���m�F
              for i in 0..5
                # �ő�l�ɂȂ��Ă��Ȃ����̂𐔂���
                if target.state_runk[i] < 2
                  state_count += 1
                end
              end
              effectable.push(state_count)
            end
            # �P�l���A�L�����̔�����s��
            effectable_count = 0
            for i in 0...@target_battlers.size
              # �R�ȏオ�L���ȃ^�[�Q�b�g
              if effectable[i] >= 3
                effectable_count += 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          elsif @skill.element_set.include?(64) #�X�g�����C�[�U
            effectable = []
            state_count = 0
            # �ΏۑS�����m�F
            for target in @target_battlers
              # �S�X�e�[�^�X�̏㏸�␳���m�F
              for i in 0..5
                # �ŏ��l�ɂȂ��Ă��Ȃ����̂𐔂���
                if target.state_runk[i] > -2
                  state_count += 1
                end
              end
              effectable.push(state_count)
            end
            # �P�l���A�L�����̔�����s��
            effectable_count = 0
            for i in 0...@target_battlers.size
              # �R�ȏオ�L���ȃ^�[�Q�b�g
              if effectable[i] >= 3
                effectable_count += 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          #������
          elsif @skill.element_set.include?(51) #���i���u����
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[0] == 2
                effectable_count -= 1
                n = 1
                p "����ȏ㖣�͋����ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          elsif @skill.element_set.include?(52) #���i���C�[�U
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[0] == -2
                effectable_count -= 1
                n = 1
                p "����ȏ㖣�͎㉻�ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          #���E�ϗ�
          elsif @skill.element_set.include?(53) #�l���l�u����
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[1] == 2
                effectable_count -= 1
                n = 1
                p "����ȏ�E�ϗ͎㉻�ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          elsif @skill.element_set.include?(54) #�l���l�C�[�U
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[1] == -2
                effectable_count -= 1
                n = 1
                p "����ȏ�E�ϗ͎㉻�ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          #������
          elsif @skill.element_set.include?(55) #�G���_�u����
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[2] == 2
                effectable_count -= 1
                n = 1
                p "����ȏ㐸�͋����ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          elsif @skill.element_set.include?(56) #�G���_�C�[�U
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[2] == -2
                effectable_count -= 1
                n = 1
                p "����ȏ㐸�͎㉻�ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          #����p��
          elsif @skill.element_set.include?(57) #�T�t���u����
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[3] == 2
                effectable_count -= 1
                n = 1
                p "����ȏ��p�������ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          elsif @skill.element_set.include?(58) #�T�t���C�[�U
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[3] == -2
                effectable_count -= 1
                n = 1
                p "����ȏ��p���㉻�ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          #���f����
          elsif @skill.element_set.include?(59) #�R���I�u����
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[4] == 2
                effectable_count -= 1
                n = 1
                p "����ȏ�f���������ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          elsif @skill.element_set.include?(60) #�R���I�C�[�U
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[4] == -2
                effectable_count -= 1
                n = 1
                p "����ȏ�f�����㉻�ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          #�����_��
          elsif @skill.element_set.include?(61) #�A�X�^�u����
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[5] == 2
                effectable_count -= 1
                n = 1
                p "����ȏ㐸�_�͋����ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          elsif @skill.element_set.include?(62) #�A�X�^�C�[�U
            effectable_count = @target_battlers.size
            for target in @target_battlers
              if target.state_runk[5] == -2
                effectable_count -= 1
                n = 1
                p "����ȏ㐸�_�͎㉻�ł��Ȃ��̂Ŏg�p�s�F#{@skill.name}" if a == 1
              end
            end
            # �ΏۑS���Ɍ��ʂ�������΃G���[
            if effectable_count < @target_battlers.size
              n = 1
              # �Ώۂ��R�l�ȏ�A���Ώې��|�P�ɗL���Ȃ狖��
              if @target_battlers.size >= 3 and effectable_count + 1 >= @target_battlers.size
                n = 0
              end
            end
          end
        end
        
        # �C���Z���X�X�L���́A���łɓ����C���Z���X������ꍇ�͕s��
        if @skill.element_set.include?(129)
          n = 1 if $incense.exist?(@skill.name, @target_battlers[0])
        end
        # �����̃z�[���h����ɂ̂ݎg�p�̏ꍇ�A�����̃z�[���h����ȊO�͕s��
        if @skill.element_set.include?(208)
          n = 1 if not @active_battler.target_hold?(@target_battlers[0])
        end
        # �����̃z�[���h�����D�悵�Ďg�p�̏ꍇ�A�������z�[���h���Ă���Ȃ��
        # �����̃z�[���h����ȊO�͕s��
        if @skill.element_set.include?(215)
          if @active_battler.holding? and not @active_battler.target_hold?(@target_battlers[0])
            n = 1 
          end
        end
        
        
        # ���X�L���ʂ��Ƃ̎g�p��
        #----------------------------------------------------------------
        case @skill.name
        
        # �����_���X�L���ȂǂŃX�L�����ߒ������o���ꍇ�͂������񂳂���        
        when "�X�L�����ߒ���"
          n = 1
        # ���łɃ}�[�L���O���Ă���ꍇ�A�i��߂��g��Ȃ�
        when "�i���"; n = 1 if @active_battler.marking?
        # �񕜖��@
        #----------------------------------------------------------------
        # �ΏۂP�l�̏ꍇ�A�Ώۂ̌��݂d�o�̊����ŉۂ��m�F
        when "�C���X�V�[�h"; n = 1 if @target_battlers[0].hpp >= 90
        when "�C���X�y�^��"; n = 1 if @target_battlers[0].hpp >= 80
        when "�C���X�t���E"; n = 1 if @target_battlers[0].hpp >= 50
        when "�C���X�R���i"; n = 1 if @target_battlers[0].hpp >= 50
        # �Ώە����̏ꍇ�A�Ώۂ̂d�o�������K���ł���ꍇ�̎҂��Q�l�ȏ�̏ꍇ�n�j
        when "�C���X�V�[�h�E�A���_","�C���X�y�^���E�A���_","�C���X�t���E�E�A���_"
          target_count = 0
          for target in @target_battlers
            case @skill.name
            when "�C���X�V�[�h�E�A���_"
              target_count += 1 if target.hpp < 90
            when "�C���X�y�^���E�A���_"
              target_count += 1 if target.hpp < 80
            when "�C���X�t���E�E�A���_"
              target_count += 1 if target.hpp < 50
            end
          end
          if target_count < 2
            n = 1 
            @error_text = "�͈͉񕜖��@�F�Ώەs�K��"
          end
        # �����n�X�L���́A���w�ł��łɒN�����������Ă���ꍇ�̓G���[
        when "�A�s�[��","�v�����H�[�N"
          for enemy in $game_troop.enemies
            if enemy.exist? and (enemy.state?(96) or enemy.state?(104))
              n = 1
              break
            end
          end
        # �M���S�[���p�B�܂��₯�����R�A�����g�p���Ă��Ȃ��ꍇ�A�������Ȃ��B
        when "������"
          if $game_switches[393]
            n = 1
            @error_text = "�������F����󋵃G���["
          end
        end
        #------------------------------------------------------------------------
        # ���I�ђ����őI�΂�Ȃ��X�L���̏ꍇ�̓G���[
        #------------------------------------------------------------------------
        if @skill.element_set.include?(211) and ct > 0
          n = 1
        end
        #------------------------------------------------------------------------
        # ���P�l�̎��ɂ͎g��Ȃ��X�L���̏ꍇ�A�P�l���ƃG���[
        #------------------------------------------------------------------------
        if @skill.element_set.include?(212)
          enemy_count = 0
          for enemy in $game_troop.enemies
            enemy_count += 1 if enemy.exist?
          end
          n = 1 if enemy_count < 2
        end
        #------------------------------------------------------------------------
        # ���{�C��Ԃł͎g��Ȃ����A�{�C���ƃG���[
        #------------------------------------------------------------------------
        if @skill.element_set.include?(218)
          if @active_battler.earnest
            n = 1 
          end
        end
        #------------------------------------------------------------------------
        # ���Ώۂ��s�K���̏ꍇ�̓G���[
        #------------------------------------------------------------------------
        if not @active_battler.proper_target?(@target_battlers[0],@skill.id)
          n = 1 
          @error_text = "�Ώەs�K��"
        end

        
        
        #----------------------------------------------------------------
        #�X�L�����s�񐔂��S�O��𒴂����ꍇ�A�ėp�A�N�V�����ɂ��ă��[�v�𔲂���
        #���n���O�A�b�v�΍�
        if ct > 300
          p "���s����Ȃ̂ŉ������s" if $DEBUG
          unless @active_battler.holding?
            # �X�L��[�G���[�V����]���擾
            @skill = $data_skills[299]
          else
            # �X�L��[���w�E����]���擾
            @skill = $data_skills[968]
          end
        # �G���[�J�E���g�̏ꍇ�̓A�N�V�������ߒ���
        elsif n == 1
          ct += 1
#          p "�g�p�X�L��(�G���[�F����)�F#{@skill.name}" if $DEBUG
          if a == 1
            unless @skill.name == "�X�L�����ߒ���"
              text = "�G���[�F����"
              text += "\n�A�N�e�B�u�F#{@active_battler.name}"
              text += "\n�^�[�Q�b�g�F#{@target_battlers[0].name}"
              text += "\n�X�L���F#{@skill.name}"
              text += "\n�G���[���e�F#{@error_text}"
              print text
              @error_text = ""
            end
          end
          # �A�N�V�������Č���
          enemy_action_swicthes(@active_battler)
          @active_battler.make_action
          # ��{�A�N�V�����������ꍇ�́A��{�A�N�V�����̌��ʍ쐬�ɔ�΂�             
          if @active_battler.current_action.kind == 0
            make_basic_action_result
            return
          end
          # �X�L�����擾
          @skill = $data_skills[@active_battler.current_action.skill_id]
#          p "�g�p�X�L��(�Đݒ�)�F#{@skill.name}" if $DEBUG
          
          # �f�o�b�O�p
          if @skill.id == 15
#            p @active_battler.current_action
#           a = 1
          end  
          
          # �Ώۑ��o�g���[���N���A
          @target_battlers = []
          # �Ώۑ��o�g���[��ݒ�
          set_target_battlers(@skill.scope, @skill.id)
          # ���^�[�Q�b�g�o�g���[�̏����ēx�L��
          $game_temp.battle_target_battler = @target_battlers
#          p "�Ώ�(�Đݒ�)�F#{@target_battlers[0].name}" if $DEBUG

          # �������_���X�L�����g�p����ꍇ�A��p�y�[�W�֔�΂�
          if $data_skills[@active_battler.current_action.skill_id].element_set.include?(9)
#            p $data_skills[@active_battler.current_action.skill_id].name
            random_skill_action
          end
          next
        end
        
        # ���v�Ȃ烋�[�v�I��
        break
      end    
#    p "�g�p�X�L��(����)�F#{@skill.name}" if $DEBUG
        
    # �U�������A�N�^�[�̏ꍇ    
    else
      # �G���[�p�ϐ������Z�b�g
      n = 0
=begin
      #----------------------------------------------------------------
      # �� �X�L�����g�p�s���X�L���̑Ë����\�ȏꍇ�A�Ë�����
      #----------------------------------------------------------------
      unless @active_battler.skill_can_use?(@skill.id)
        # �w���B�s�X�g�����s�X�g��
        if @skill.id == 33
          new_id = 32
          @skill = $data_skills[new_id]
          @active_battler.current_action.skill_id = new_id
          p 1
        end
      end
=end
      
      
      #----------------------------------------------------------------
      # �� �G���[�W
      #----------------------------------------------------------------

      # �G���[�p�ϐ������Z�b�g
      n = 0
      @error_text = ""
      
      # �������F���ߒ��s�̃X�L���̏ꍇ
      if @skill.element_set.include?(177)
      #----------------------------------------------------------------
        #�}���^�C�v�E�s�X�g���E�O���C���h����������ꍇ�A���E���ŋ������ꍇ��
        if @skill.element_set.include?(134)
          unless @skill.element_set.include?(91)
            unless (@active_battler.insertable_half_nude? or @active_battler.full_nude?)
              n = 1
            end
          end
        else
          unless @active_battler.full_nude?
            n = 1
          end
        end
      end

      # ������F���ߒ��s�̃X�L���̏ꍇ
      if @skill.element_set.include?(178)
      #----------------------------------------------------------------
        #�}���^�C�v�E�s�X�g���E�O���C���h����������ꍇ�A���E���ŋ������ꍇ��
        if @skill.element_set.include?(134)
          unless @skill.element_set.include?(91)
            unless (@target_battlers[0].insertable_half_nude? or @target_battlers[0].full_nude?)
              n = 1
            end
          end
        else
          unless @target_battlers[0].full_nude?
            n = 1
          end
        end
      end

      # �������F�E�ߒ��s�̃X�L���̏ꍇ
      if @skill.element_set.include?(179)
      #----------------------------------------------------------------
        # ����������Ԃł���ꍇ
        n = 1 if @active_battler.full_nude?
      end

      # ������F�E�ߒ��s�̃X�L���̏ꍇ
      if @skill.element_set.include?(180)
      #----------------------------------------------------------------
        # ���肪����Ԃł���ꍇ
        n = 1 if @target_battlers[0].full_nude?
      end

      # ���z�[���h���D������p�X�L���̏ꍇ
      if @skill.element_set.include?(137) and @active_battler.holding?
      #------------------------------------------------------------------------
        # �������򐨂̏ꍇ
        n = 1 unless @active_battler.initiative?
      end
      # ���z�[���h���򐨎���p�X�L���̏ꍇ
      #------------------------------------------------------------------------
      if @skill.element_set.include?(138) and @active_battler.holding?
        # �������򐨂̏ꍇ
        n = 1 if @active_battler.initiative?
      end
      # ���z�[���h�����X�L���̏ꍇ
      #------------------------------------------------------------------------
      if @skill.name == "�����[�X" or @skill.name == "�C���^���v�g"
        # ���肪���łɃz�[���h�Ŗ����ꍇ
        n = 1 unless @target_battlers[0].holding?
      end
      if @skill.name == "�X�g���O��"
        # ���������łɃz�[���h�Ŗ����ꍇ
        n = 1 unless @active_battler.holding?
      end

      # ��������ΏۂɎ��Ȃ��X�L���Ŏ�����I�������ꍇ�g�p�s��
      if @skill.element_set.include?(19)
      #----------------------------------------------------------------
        if @active_battler == @target_battlers[0]
          n = 1
        end
      end
      #------------------------------------------------------------------------
      # �������F����L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(140)
        # �����̃y�j�X���o�g���[�ɐ�L����Ă���ꍇ
        n = 1 if @active_battler.hold.penis.battler != nil
      end
      # ������F����L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(141)
        # ����̃y�j�X���o�g���[�ɐ�L����Ă���ꍇ
        n = 1 if @target_battlers[0].hold.penis.battler != nil
      end
      # ������L���̂݉̃X�L���̏ꍇ
      #------------------------------------------------------------------------
      if @skill.element_set.include?(142)
        # �����́������}����ԂŖ����ꍇ
        n = 1 unless @active_battler.penis_insert?
      end
      if @skill.element_set.include?(143)
      # �����́���������ԂŖ����ꍇ
        n = 1 unless @active_battler.penis_oralsex?
      end
      if @skill.element_set.include?(144)
      # �����́����芭��ԂŖ����ꍇ
        n = 1 unless @active_battler.penis_analsex?
      end

      #------------------------------------------------------------------------
      # �������F����L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(146)
        # ������L���̏ꍇ
        n = 1 if @active_battler.hold.mouth.battler != nil
      end
      # ������F����L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(147)
        # ������L���̏ꍇ
        n = 1 if @target_battlers[0].hold.mouth.battler != nil
      end
      # �����}�����̂݉̃X�L���̏ꍇ
      #------------------------------------------------------------------------
      if @skill.element_set.include?(148)
      # �����̌������}����ԂŖ����ꍇ
        n = 1 unless @active_battler.mouth_oralsex?
      end
      if @skill.element_set.include?(149)
      # �����̌�����ʋR���ԂŖ����ꍇ
        n = 1 unless @active_battler.mouth_riding?
      end
      if @skill.element_set.include?(145)
      # �����̌����K�R���ԂŖ����ꍇ
        n = 1 unless @active_battler.mouth_hipriding?
      end
      if @skill.element_set.include?(150)
      # �����̌����N���j��ԂŖ����ꍇ
        n = 1 unless @active_battler.mouth_draw?
      end
      if @skill.element_set.include?(170)
      # �����̌����L�b�X��ԂŖ����ꍇ
        n = 1 unless @active_battler.deepkiss?
      end

      #------------------------------------------------------------------------
      # �������F�K��L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(151)
        # �������K��L���̏ꍇ
        n = 1 if @active_battler.hold.anal.battler != nil
      end
      # ������F�K��L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(152)
        # ���肪�K��L���̏ꍇ
        n = 1 if @target_battlers[0].hold.anal.battler != nil
      end
      # ���K��L���̂݉̃X�L���̏ꍇ
      #------------------------------------------------------------------------
      if @skill.element_set.include?(153)
        # �����̐K���K�}����ԂŖ����ꍇ
        n = 1 unless @active_battler.anal_analsex?
      end
      if @skill.element_set.include?(154)
        # �����̐K���K�R���ԂŖ����ꍇ
        n = 1 unless @active_battler.anal_hipriding?
      end

      #------------------------------------------------------------------------
      # �������F����L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(155)
        # �������}�����̏ꍇ
        n = 1 if @active_battler.hold.vagina.battler != nil
      end
      # ������F����L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(156)
        # ���肪����L���̏ꍇ
        n = 1 if @target_battlers[0].hold.vagina.battler != nil
      end
      # ������L���̂݉̃X�L���̏ꍇ
      #------------------------------------------------------------------------
      if @skill.element_set.include?(157)
      # �����́������}����ԂŖ����ꍇ
        n = 1 unless @active_battler.vagina_insert?
      end
      if @skill.element_set.include?(158)
      # �����́����R���ԂŖ����ꍇ
        n = 1 unless @active_battler.vagina_riding?
      end
      if @skill.element_set.include?(159)
      # �����́����L���킹��ԂŖ����ꍇ
        n = 1 unless @active_battler.shellmatch?
      end

      #------------------------------------------------------------------------
      # �������F�㔼�g��L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(161)
        # �������㔼�g��L���̏ꍇ
        n = 1 if @active_battler.hold.tops.battler != nil
      end
      # ������F�㔼�g��L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(162)
        # ���肪�㔼�g��L���̏ꍇ
        n = 1 if @target_battlers[0].hold.tops.battler != nil
      end
      # ���㔼�g��L���̂݉̃X�L���̏ꍇ
      #------------------------------------------------------------------------
      if @skill.element_set.include?(163)
      # �����̏㔼�g���S����ԂŖ����ꍇ
        n = 1 unless (@active_battler.tops_binder? or @active_battler.tops_binding?)
      end
      if @skill.element_set.include?(164)
      # �����̏㔼�g���J�r��ԂŖ����ꍇ
        n = 1 unless @active_battler.tops_openbinding?
      end
      if @skill.element_set.include?(160)
      # �����̏㔼�g���p�C�Y����ԂŖ����ꍇ
        n = 1 unless @active_battler.tops_paizuri?
      end
      if @skill.element_set.include?(171)
      # �����̏㔼�g���ςӂςӏ�ԂŖ����ꍇ
        n = 1 unless @active_battler.tops_pahupahu?
      end

      #------------------------------------------------------------------------
      # �������F�K����L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(165)
        # �����̐K����}�����̏ꍇ
        n = 1 if @active_battler.hold.tail.battler != nil
      end
      # ������F�K����L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(165)
        # ����̐K������L���̏ꍇ
        n = 1 if @target_battlers[0].hold.tail.battler != nil
      end
      # ���K����L���̂݉̃X�L���̏ꍇ
      #------------------------------------------------------------------------
      if @skill.element_set.include?(167)
      # �����̐K�������}����ԂŖ����ꍇ
        n = 1 unless @active_battler.tail_insert?
      end
      if @skill.element_set.include?(168)
      # �����̐K����������ԂŖ����ꍇ
        n = 1 unless @active_battler.tail_oralsex?
      end
      if @skill.element_set.include?(169)
      # �����̐K�����芭��ԂŖ����ꍇ
        n = 1 unless @active_battler.tail_analsex?
      end
      
      
      #------------------------------------------------------------------------
      # ���G���L���̂݉̃X�L���̏ꍇ
      if @skill.element_set.include?(172)
      # �����̐G�肪���}����ԂŖ����ꍇ
        n = 1 unless @active_battler.tentacle_insert?
      end
      if @skill.element_set.include?(173)
      # �����̐G�肪������ԂŖ����ꍇ
        n = 1 unless @active_battler.tentacle_oralsex?
      end
      if @skill.element_set.include?(174)
      # �����̐G�肪�芭��ԂŖ����ꍇ
        n = 1 unless @active_battler.tentacle_analsex?
      end
      if @skill.element_set.include?(175)
      # �����̐G��ő�����S�����Ă��Ȃ��ꍇ
        n = 1 unless @active_battler.tentacle_binding?
      end
      if @skill.element_set.include?(176)
      # �����̐G��ő�����S�����Ă��Ȃ��ꍇ
        n = 1 unless @active_battler.tentacle_openbinding?
      end

      #------------------------------------------------------------------------
      # �������F�f�B���h��L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(182)
        # �����̃f�B���h��}�����̏ꍇ
        n = 1 if @active_battler.hold.dildo.battler != nil
      end
      # ������F�f�B���h��L���s�̃X�L���̏ꍇ
      if @skill.element_set.include?(190)
        # �����̃f�B���h��}�����̏ꍇ
        n = 1 if @target_battlers[0].hold.dildo.battler != nil
      end
      # ���K����L���̂݉̃X�L���̏ꍇ
      #------------------------------------------------------------------------
      if @skill.element_set.include?(183)
      # �����̃f�B���h�����}����ԂŖ����ꍇ
        n = 1 unless @active_battler.dildo_insert?
      end
      if @skill.element_set.include?(184)
      # �����̃f�B���h��������ԂŖ����ꍇ
        n = 1 unless @active_battler.dildo_oralsex?
      end
      if @skill.element_set.include?(185)
      # �����̃f�B���h���芭��ԂŖ����ꍇ
        n = 1 unless @active_battler.dildo_analsex?
      end
      # ���Βj�p�X�L���̏ꍇ(�A�N�^�[����̏ꍇ�A���肪�����Ȃ�g�p��)
      if @skill.element_set.include?(41)
      #----------------------------------------------------------------
        # ���肪������L�łȂ��ꍇ
        n = 1 unless @target_battlers[0].futanari?
      end
      
      # ���Ώ��p�X�L���̏ꍇ
      if @skill.element_set.include?(42)
      #----------------------------------------------------------------
        # ���肪�j�i��l���j�ł���ꍇ
        n = 1 if @target_battlers[0].boy?
      end

      # ���X�L������
      # ----------------------------------------------------------------

      # �G���[�J�E���g�̏ꍇ�̓A�N�V�����𖳌���
      if n == 1
        $game_temp.forcing_battler = nil
        @wait_count = 0
        @phase4_step = 6
        return
      end
    end

    # ---------------------------------------------------------------

    # ���^�[�Q�b�g�o�g���[�̏����L���@���R�����C�x���g�Ŏg���܂��B
    $game_temp.battle_target_battler = @target_battlers
#    p "�Ώ�(����)�F#{@target_battlers[0].name}" if $DEBUG
#    p "�g�p�X�L��(����)�F#{@skill.name}" if $DEBUG

    # �����A�N�V�����łȂ����
    unless @active_battler.current_action.forcing
      # SP �؂�ȂǂŎg�p�ł��Ȃ��Ȃ����ꍇ
      unless @active_battler.skill_can_use?(@skill.id)
#        p "�A�N�V���������s���ɂ�藚���N���A�F#{@skill.name}" if $DEBUG
        # �A�N�V���������Ώۂ̃o�g���[���N���A
        $game_temp.forcing_battler = nil
        # �X�e�b�v 6 �Ɉڍs
        @phase4_step = 6
        return
      end
    end
    
    # �ǌ����łȂ���΁@SP ������s��
    unless $game_switches[78]
      @active_battler.sp -= SR_Util.sp_cost_result(@active_battler, @skill)
      # �G�l�~�[���u�o�������⏕�X�L�����g�p�����ꍇ�A
      # �⏕�X�L���J�E���g�𑝂₷
      if @active_battler.is_a?(Game_Enemy) and
       SR_Util.sp_cost_result(@active_battler, @skill) > 0 and
       (@skill.element_set.include?(4) or @skill.element_set.include?(5))
        @active_battler.support_skill_count += 1
      end
    end
    
    # �X�e�[�^�X�E�B���h�E�����t���b�V��
    @status_window.refresh
    
    #�g�p���Ă���X�L������{���̕����U���̏ꍇ�A�����������ŏK��
    if @skill.element_set.include?(84)
      @skill.element_set.delete(71) if @skill.element_set.include?(71)#��
      @skill.element_set.delete(72) if @skill.element_set.include?(72)#��
      #���������Ԃ̏ꍇ�͎�̂�
      if @active_battler.hold.mouth.battler != nil
        @skill.element_set.push(71)
      #���͑��v�����㔼�g�����Ԃ̏ꍇ�͌��̂�
      elsif @active_battler.hold.tops.battler != nil
        @skill.element_set.push(72)
      #�ǂ���ł������ꍇ�̓����_��
      else
        if rand(100) >= 50
          @skill.element_set.push(71)
        else
          @skill.element_set.push(72)
        end
      end
    end
    # �������_���X�L�����g�p����ꍇ�A��p�y�[�W�֔�΂�
#    if $data_skills[@active_battler.current_action.skill_id].element_set.include?(9)
#      p $data_skills[@active_battler.current_action.skill_id].name
#      random_skill_action
#    end
    # ���X�L������\������ꍇ
    if @skill.element_set.include?(14)
      # ���w���v�E�B���h�E�т�\��
      @help_window.window.visible = true
      #�x�b�h�C�����̓g�[�N���̂��s���[�g�[�N�ɕύX
      if $game_switches[85] == true and @skill.name == "�g�[�N"
        # �w���v�E�B���h�E�ɃX�L������\��
        @help_window.set_text("�s���[�g�[�N", 1)
      else
        # �w���v�E�B���h�E�ɃX�L������\��
        @help_window.set_text(@skill.name, 1)
      end
    end
    # �A�j���[�V���� ID ��ݒ�
    @animation1_id = @skill.animation1_id
    @animation2_id = @skill.animation2_id
    # �R�����C�x���g ID ��ݒ�
    @common_event_id = @skill.common_event_id
    
    # ���G�l�~�[�̕\����Ԃ̕ύX�i�Ώۂ��S�̂̏ꍇ�͕ύX�����j
    # �i�A�N�e�B�u���A�N�^�[�̏ꍇ�͂����Ń^�[�Q�b�g���f��j
    if @target_battlers[0].is_a?(Game_Enemy) and @active_battler.is_a?(Game_Actor) \
     and @skill.scope != 2 and @skill.scope != 4 
      enemies_display(@target_battlers[0])
    # �i�A�N�e�B�u���G�l�~�[�̏ꍇ�͂����ŃA�N�e�B�u���f��j
    elsif @active_battler.is_a?(Game_Enemy)
      enemies_display(@active_battler)
    end

    
    
    # �X�L���̌��ʂ�K�p
    for target in @target_battlers
      #�^�[�Q�b�g�����A�U�������A�N�^�[�̏ꍇ�̓^�[�Q�b�g�ɍs��ꂽ�X�L������
      if target.is_a?(Game_Enemy) and @active_battler.is_a?(Game_Actor)
        #�Ώۂɍs�����X�L��ID�����@�łȂ��A�����O�ɍs��ꂽ���̂Ɠ���Ȃ�J�E���g
        if @skill.id == target.before_suffered_skill_id and not @skill.element_set.include?(5)
          $repeat_skill_num += 1 unless $game_switches[78] == true #�ǌ����̓J�E���g���Ȃ�
        else
          # �ʂȍU���X�L���Ȃ烊�Z�b�g
          $repeat_skill_num = 0
          target.before_suffered_skill_id = @skill.id
        end
      end
      #�g�����X�L�����m�肵$game_temp�ɋL�^
      $game_temp.used_skill = @skill
      #�X�L���G�t�F�N�g
      target.skill_effect(@active_battler, @skill)
    end
  end
  #--------------------------------------------------------------------------
  # �� �A�C�e���A�N�V���� ���ʍ쐬
  #--------------------------------------------------------------------------
  def make_item_action_result
    # �A�C�e�����擾
    @item = $data_items[@active_battler.current_action.item_id]
    # ���^�[�Q�b�g�o�g���[�̏����L���@���R�����C�x���g�Ŏg���܂��B
    $game_temp.battle_target_battler = @target_battlers
    # �A�C�e���؂�ȂǂŎg�p�ł��Ȃ��Ȃ����ꍇ
    unless $game_party.item_can_use?(@item.id)
      # �X�e�b�v 1 �Ɉڍs
      @phase4_step = 1
      return
    end
    # ���Օi�̏ꍇ
    if @item.consumable
      # �g�p�����A�C�e���� 1 ���炷
      $game_party.lose_item(@item.id, 1)
    end
    # ���w���v�E�B���h�E�т�\��
    @help_window.window.visible = true
    # �w���v�E�B���h�E�ɃA�C�e������\��
    @help_window.set_text(@item.name, 1)
    # �A�j���[�V���� ID ��ݒ�
    @animation1_id = @item.animation1_id
    @animation2_id = @item.animation2_id
    # �R�����C�x���g ID ��ݒ�
    @common_event_id = @item.common_event_id
    # �Ώۂ�����
    index = @active_battler.current_action.target_index
    target = $game_party.smooth_target_actor(index)
    # �Ώۑ��o�g���[��ݒ�
    set_target_battlers(@item.scope)
    
    # ���G�l�~�[�̕\����Ԃ̕ύX�i�Ώۂ��S�̂̏ꍇ�͕ύX�����j
    if @target_battlers[0].is_a?(Game_Enemy) \
     and @item.scope != 2 and @item.scope != 4 
      enemies_display(@target_battlers[0])
    end

    
    # �A�C�e���̌��ʂ�K�p
    for target in @target_battlers
      target.item_effect(@item)
    end
  end
  #--------------------------------------------------------------------------
  # �� ���ŏ���
  #--------------------------------------------------------------------------
  def special_mushroom_effect(battler)
    
    # �����ł�����̂�ϐ����݂Ō���
    bs = [0,0,0,45,45,45,45,37,39,40]
    # ���E
    registance = battler.state_percent(nil, 37, nil)
    if battler.states.include?(37) or rand(100) >= registance
      bs.delete(37) 
    end
    # ���
    registance = battler.state_percent(nil, 39, nil)
    if battler.states.include?(39) or rand(100) >= registance
      bs.delete(39) 
    end
    # �U��
    registance = battler.state_percent(nil, 40, nil)
    if battler.states.include?(37) or rand(100) >= registance
      bs.delete(40) 
    end
    # �����ł�����̂��Ȃ��ꍇ�A���\�b�h�I��
    return if bs == []
    
    # �����ł�����̂̒�����P�I��ł��̃X�e�[�g��t�^
    bs = bs[rand(bs.size)]
    # 0�̏ꍇ�͕�������
    return if bs == 0
    # ����
    battler.add_state(bs)
    
  end
end