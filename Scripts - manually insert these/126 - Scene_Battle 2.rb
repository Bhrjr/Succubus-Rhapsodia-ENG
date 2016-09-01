#==============================================================================
# �� Scene_Battle (������` 2)
#------------------------------------------------------------------------------
# �@�o�g����ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Battle
  #--------------------------------------------------------------------------
  # �� �X�^�[�g�t�F�[�Y�J�n
  #--------------------------------------------------------------------------
  def start_phase0
    # �t�F�[�Y 1 �Ɉڍs
    @phase = 0
    
    #--------------------------------------------------------------------------
    # ���g���[�v�G�l�~�[�̕\��
    
    # �o�g�����O�E�B���h�E���o��
    @battle_log_window.visible = true
    @battle_log_window.bgframe_sprite.visible = true
    # �g���[�v�̏����l���𐔂���
    n = $game_troop.enemies.size
    for i in 1...$game_troop.enemies.size
      if $game_troop.enemies[i].hidden == true
        n -= 1
      end
    end 
    # �����l�����Q�l�ȏ�̏ꍇ�A�u�`�����v������B
    unless n > 1 
      text = $game_troop.enemies[0].name + " has appeared!"
    else
      if n == 2
      text = "A pair of succubi have appeared!"
      else
      text = "A group of succubi have appeared!"
      end
    end
    $game_temp.battle_log_text += text + "\067"
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
    
=begin    
    @appear_turns = []
    for enemy in $game_troop.enemies.reverse
      if enemy.exist?
        @appear_turns.push(enemy) 
      end
    end
=end
    #--------------------------------------------------------------------------
    @phase0_step = 1
  end
  
  #--------------------------------------------------------------------------
  # �� �X�^�[�g�t�F�[�Y�@�t���[���X�V
  #--------------------------------------------------------------------------
  def update_phase0
    # �ŏ��̖����\�����̎��͍X�V���~�߂�
    for enemy in $game_troop.enemies
      return if enemy.start_appear == true
    end
    
    case @phase0_step
    when 1
      update_phase0_step1
    when 2
      update_phase0_step2
    when 3
      update_phase0_step3
    end
  end
  #--------------------------------------------------------------------------
  # �� �X�^�[�g�t�F�[�Y�@�t���[���X�V�@�X�e�b�v�P�F��U��U���O
  #--------------------------------------------------------------------------
  def update_phase0_step1
    # @phase0_step2_count ���Ƃɏ��Ԃɐ퓬�O�������s��
    
    # ����U�������
    if $game_temp.first_attack_flag == 1
      #�A�N�^�[�̃t�@�[�X�g�A�^�b�N�t���O�𗧂Ă�
      @actor_first_attack = true
      @enemy_first_attack = false
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
      if $game_party.actors.size == 1
        $game_temp.battle_log_text += $game_actors[101].name + " has the initiative!\067"
      else
        $game_temp.battle_log_text += $game_actors[101].name + " has the initiative!\067"
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
    end
 
    # ���������ꂽ
    if $game_temp.first_attack_flag == 2
      #�G�l�~�[�̃t�@�[�X�g�A�^�b�N�t���O�𗧂Ă�
      @actor_first_attack = false
      @enemy_first_attack = true
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
      if $game_party.actors.size == 1
        $game_temp.battle_log_text += $game_actors[101].name + " had the initiative taken by the ene��y!\067"
      else
        $game_temp.battle_log_text += $game_actors[101].name + " had the initiative taken by the ene��y!\067"
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
    end

    
    @phase0_step = 2
    @phase0_step2_count = 0
  end
  #--------------------------------------------------------------------------
  # �� �X�^�[�g�t�F�[�Y�@�t���[���X�V�@�X�e�b�v�P�F�퓬�O����
  #--------------------------------------------------------------------------
  def update_phase0_step2

    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""

    # �o�g���C�x���g
    if @phase0_step2_count == 0
      @phase0_step2_count = 1
      # �o�g���C�x���g�̃Z�b�g�A�b�v
      setup_battle_event
      return
    end
    # �o�g���C�x���g���s���̏ꍇ
    if $game_system.battle_interpreter.running?
      return
    end
    # �o�����G�t�F�N�g�̎w�����o��
    appear_effect_order(@battlers)
    # �t�F�C�Y��i�߂�
    @phase0_step = 3
  end
  #--------------------------------------------------------------------------
  # �� �X�^�[�g�t�F�[�Y�@�t���[���X�V�@�X�e�b�v�R�F�I�������@
  #--------------------------------------------------------------------------
  def update_phase0_step3
    #���퓬�J�n���オ����ꍇ�͕\������
    # �S�o�g���[�̃��Z�b�g
    
    # �퓬�O���㖳���X�C�b�`���n�e�e�Ȃ�ΐ퓬�O������Ăяo����悤�ɂ���
    if $game_switches[59]
      # �n�m�̏ꍇ�̓X�C�b�`��؂��ďI������B
      $game_switches[59] = false
    else
      #������퓬���ɉ�b�t���O�𗧂Ă�
      #���ڍו\�����͕K���S�ĕ\��
      if $game_switches[95] == true
        #�Ώێ��O�I��ς݃g�[�N�X�e�b�v��ݒ�
        $msg.callsign = 40
        $msg.tag = "�퓬�J�n"
        common_event = $data_common_events[69]
        $game_system.battle_interpreter.setup(common_event.list, 0)
      #���ȈՕ\�����́A�x�b�h�C���ƃ{�X��ȊO��\�����Ȃ�
      elsif $game_switches[96] == true
        #�x�b�h�C���퓬��
        if ($game_switches[85] == true or
        #�{�X�펞
          $game_switches[91] == true)
          #�Ώێ��O�I��ς݃g�[�N�X�e�b�v��ݒ�
          $msg.callsign = 40
          $msg.tag = "�퓬�J�n"
          common_event = $data_common_events[69]
          $game_system.battle_interpreter.setup(common_event.list, 0)
        end
      #���ʏ펞�̓x�b�h�C���A�{�X��A�󕠎��A�n�e�d�A���A�o�����ɕ\������
      else 
        #�x�b�h�C���퓬��
        if ($game_switches[85] == true or
        #�󕠐퓬��
          $game_switches[86] == true or
        #�{�X�펞
          $game_switches[91] == true or
        #OFE�펞
          $game_switches[92] == true or
        #���A�o���퓬��
          $game_switches[93] == true)
          #�Ώێ��O�I��ς݃g�[�N�X�e�b�v��ݒ�
          $msg.callsign = 40
          $msg.tag = "�퓬�J�n"
          common_event = $data_common_events[69]
          $game_system.battle_interpreter.setup(common_event.list, 0)
        end
      end
    end
    start_phase1
  end

  #--------------------------------------------------------------------------
  # �� �v���o�g���t�F�[�Y�J�n
  #--------------------------------------------------------------------------
  def start_phase1
    # �t�F�[�Y 1 �Ɉڍs
    @phase = 1
    # �p�[�e�B�S���̃A�N�V�������N���A
    $game_party.clear_actions

    # ���o�g�����O���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false   
    
    # ���������ꂽ
    if $game_temp.first_attack_flag == 2
      start_phase4
    end
    
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�v���o�g���t�F�[�Y)
  #--------------------------------------------------------------------------
  def update_phase1
    
    # ���s����
    if judge
      # �����܂��͔s�k�̏ꍇ : ���\�b�h�I��
      return
    end

    
    # �p�[�e�B�R�}���h�t�F�[�Y�J�n
    start_phase2
  end
  #--------------------------------------------------------------------------
  # �� �p�[�e�B�R�}���h�t�F�[�Y�J�n
  #--------------------------------------------------------------------------
  def start_phase2
    # �t�F�[�Y 2 �Ɉڍs
    @phase = 2
    # �A�N�^�[���I����Ԃɐݒ�
    @actor_index = -1
    @active_battler = nil

    # ���o�g�����O�E�B���h�E������
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    @battle_log_window.visible = false
    @battle_log_window.bgframe_sprite.visible = false
    $game_temp.battle_log_text = ""
    
    # ���G�l�~�[�̕\����Ԃ̕ύX
    # �擪�̑��݂��Ă��閲����I�ԁB
    select_enemy = nil
    for enemy in $game_troop.enemies
      if enemy.exist?
        select_enemy = enemy
        break
      end
    end
    enemies_display(select_enemy) if select_enemy != nil
      
#    # �p�[�e�B�R�}���h�E�B���h�E��L����
#    @party_command_window.active = true
#    @party_command_window.visible = true
#    # �A�N�^�[�R�}���h�E�B���h�E�𖳌���
#     command_all_delete
#��    @actor_command_window.active = false
#��    @actor_command_window.visible = false
    # ���C���t�F�[�Y�t���O���N���A
    $game_temp.battle_main_phase = false
    # �p�[�e�B�S���̃A�N�V�������N���A
    $game_party.clear_actions
    # �R�}���h���͕s�\�ȏꍇ
    unless $game_party.inputable?
      # ���C���t�F�[�Y�J�n
      start_phase4
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�p�[�e�B�R�}���h�t�F�[�Y)
  #--------------------------------------------------------------------------
  def update_phase2
    
    start_phase3 #��
    
    
#    # C �{�^���������ꂽ�ꍇ
#    if Input.trigger?(Input::C)
#      # �p�[�e�B�R�}���h�E�B���h�E�̃J�[�\���ʒu�ŕ���
#      case @party_command_window.index
#      when 0  # �키
#        # ���� SE �����t
#        $game_system.se_play($data_system.decision_se)
#        # �A�N�^�[�R�}���h�t�F�[�Y�J�n
#        start_phase3
#      when 1  # ������
#        # �����\�ł͂Ȃ��ꍇ
#        if $game_temp.battle_can_escape == false
#          # �u�U�[ SE �����t
#         $game_system.se_play($data_system.buzzer_se)
#        return
#      end
#        # ���� SE �����t
#      $game_system.se_play($data_system.decision_se)
#        # ��������
#     update_phase2_escape
#     end
#     return
#   end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�p�[�e�B�R�}���h�t�F�[�Y : ������)
  #--------------------------------------------------------------------------
  def update_phase2_escape
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
        actors_agi += actor.agi
        actors_number += 1
      end
    end
    if actors_number > 0
      actors_agi /= actors_number
    end
    # ������������
    success = rand(100) < 50 * actors_agi / enemies_agi
    # ���������̏ꍇ
    if success
      # ���� SE �����t
      $game_system.se_play($data_system.escape_se)
      # �o�g���J�n�O�� BGM �ɖ߂�
      $game_system.bgm_play($game_temp.map_bgm)
      # �o�g���I��
      battle_end(1)
    # �������s�̏ꍇ
    else
      # �p�[�e�B�S���̃A�N�V�������N���A
      $game_party.clear_actions
      # ���C���t�F�[�Y�J�n
      start_phase4
    end
  end
  #--------------------------------------------------------------------------
  # �� �A�t�^�[�o�g���t�F�[�Y�J�n
  #--------------------------------------------------------------------------
  def start_phase5
    # �t�F�[�Y 5 �Ɉڍs
    @phase = 5
    # �t�@���t�@�[���I�t�������ꍇ�A�o�g���I�� ME �����t
    unless @fanfare_off
      $game_system.me_play($game_system.battle_end_me) 
    end
    # �_�񖲖������邩�̃`�F�b�N
    contract_check
    if $game_temp.contract_enemy == nil
      # �o�g���J�n�O�� BGM �ɖ߂�
      $game_system.bgm_play($game_temp.map_bgm)
    else
      # �_�񖲖�������ꍇ�� BGM ������
      $game_system.bgm_play(nil)
    end
    # ���o�g�����O�E�B���h�E���o��
    @battle_log_window.visible = true
    @battle_log_window.bgframe_sprite.visible = true
    n = $game_troop.enemies_dead_count
    # �l�����Q�l�ȏ�̏ꍇ�A�u�`�����v������B
    if n > 1
      if $game_switches[85] == true
        $game_temp.battle_log_text = "The ene��y succubi have been satisfied!"
      else
        $game_temp.battle_log_text = "The ene��y succubi have been repelled! "
      end
    else
      if $game_switches[85] == true
        $game_temp.battle_log_text = "The ene��y succubus has been satisfied!"
      else
        $game_temp.battle_log_text = "The ene��y succubus has been repelled! "
      end
    end
    # ���A�N�^�[�ƃG�l�~�[�̃��x���������Z�o����(����)
#    level_f = a_level = e_level = ect = 0
#    for actor in $game_party.party_actors
#      a_level += actor.level
#    end
#    a_level = (a_level / $game_party.party_actors.size).ceil
    # EXP�A�S�[���h�A�g���W���[��������
    exp = 0
    gold = 0
    treasures = []
    # ���[�v
    for enemy in $game_troop.enemies
      # �G�l�~�[���B���ԂłȂ��ꍇ
      unless enemy.hidden
        #���x�b�h�C�����́A�I���Ɠ����Ƀx�b�h�C���񐔂����Z����
        if $game_switches[85] == true
          enemy.bedin_count = 0 if enemy.bedin_count == nil
          enemy.bedin_count += 1
        end
        exp += enemy.exp + ((enemy.exp / 3) * $game_party.after_battle_bonus(0))
        gold += enemy.gold + ((enemy.gold / 3) * $game_party.after_battle_bonus(1))
        # �g���W���[�o������
        if rand(100) < enemy.treasure_prob + (3 * $game_party.after_battle_bonus(2))
          if enemy.item_id > 0
            treasures.push($data_items[enemy.item_id])
          end
          if enemy.weapon_id > 0
            treasures.push($data_weapons[enemy.weapon_id])
          end
          if enemy.armor_id > 0
            treasures.push($data_armors[enemy.armor_id])
          end
        end
        # ���g���W���[�o������ 
        if enemy.treasure != []
          for treasure in enemy.treasure
            if rand(100) < treasure[2] + $game_party.after_battle_bonus(2)
              case treasure[0]
              when 0
                treasures.push($data_items[treasure[1]])
              when 1
                treasures.push($data_weapons[treasure[1]])
              when 2
                treasures.push($data_armors[treasure[1]])
              end
            end
          end
        end        
        
      end
    end
    # �g���W���[�̐��� 6 �܂łɌ���
    treasures = treasures[0..5]
#    p "�����o���l�F#{exp}"
    # �Ε�����Ōo���l�A�b�v
    annihilation_rate = $game_troop.enemies_dead_count - 1 
    annihilation_rate = (annihilation_rate * 0.2) + 1.0
    exp = (exp * annihilation_rate).truncate
#    p "�r�ŕ␳�L��F#{exp}"
    # ���A�g���[�v�̏ꍇ�A�o���l���グ��B
    exp = (exp * 1.5).truncate if $game_switches[93]
    # �s�K��Ԃ̏ꍇ�A�o���l���グ��B
    exp = (exp * 1.5).truncate if $game_party.unlucky?
#    p "���A�g���[�v�␳�L��F#{exp}"
    # EXP �l��
    
    for i in 0...$game_party.party_actors.size
      actor = $game_party.party_actors[i]
      actor.exp_plus_flag = false
      if actor.cant_get_exp? == false
        last_level = actor.level
        temp_exp = exp
        if actor.equip?("�����҂̎w��")
          temp_exp = (temp_exp * 1.5).truncate 
          actor.exp_plus_flag = true
        end
        # �W���C�A���g�L�����O�␳
        if $game_troop.enemies_max_level > actor.level + 4
          giant_killing_rate = $game_troop.enemies_max_level - actor.level - 4
          giant_killing_rate = (giant_killing_rate * 0.2) + 1.0
          temp_exp = (temp_exp * giant_killing_rate).truncate
          actor.exp_plus_flag = true
        end
#        p "�ŏI�擾�o���l�F#{temp_exp}"
        actor.exp += temp_exp
        # ���x���A�b�v�t���O�𗧂Ă�
        if actor.level > last_level
          @status_window.level_up(i)
        end
      end
    end
    # �S�[���h�l��
    $game_party.gain_gold(gold)
    # �g���W���[�l��
    for item in treasures
      case item
      when RPG::Item
        $game_party.gain_item(item.id, 1)
      when RPG::Weapon
        $game_party.gain_weapon(item.id, 1)
      when RPG::Armor
        $game_party.gain_armor(item.id, 1)
      end
    end
    
    # �q�[�����O�����@
    $game_party.healing
    
    # �o�g�����U���g�E�B���h�E���쐬
    @result_window = Window_BattleResult.new(exp, gold, treasures)
    # �E�F�C�g�J�E���g��ݒ�
    if Input.press?(Input::CTRL) and ($DEBUG or $game_switches[46])
      @phase5_wait_count = 50
    else
      @phase5_wait_count = 80
    end
  end

  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�t�^�[�o�g���t�F�[�Y)
  #--------------------------------------------------------------------------
  def update_phase5
    # �E�F�C�g�J�E���g�� 0 ���傫���ꍇ
    if @phase5_wait_count > 0
      # �E�F�C�g�J�E���g�����炷
      @phase5_wait_count -= 1
      # �E�F�C�g�J�E���g�� 0 �ɂȂ����ꍇ
      if @phase5_wait_count == 0
        # ���U���g�E�B���h�E��\��
        @result_window.visible = true
        # ���C���t�F�[�Y�t���O���N���A
        $game_temp.battle_main_phase = false
        # ���x���A�b�v�i���[�g
        text = ""
        up_flag = false
        for a in $game_party.party_actors
          # ���߂ɖ�����i���[�g
          if a.exp_plus_flag == true
            text += "\065\067#{a.name} received ��ore experience than usual!"
            a.exp_plus_flag = false
          end
          text += a.level_up_log
          a.level_up_log = ""
          up_flag = true if text != ""
        end
#        $game_temp.battle_log_text += "\065\n" + text + "\065\065" if text != ""
        $game_temp.battle_log_text += text + "\065\065" if text != ""
        
        # ���̑��퓬�㏈���̃`�F�b�N
        for actor in $game_party.party_actors
          if actor.equip?("���C���h�J�[�h")
            actor.armor1_id = 0
            text = "\065\067#{actor.name}'s e��uipped \065\nWild Card has disappeared....."
            $game_temp.battle_log_text += text
          end
          if actor.equip?("����~�T���K")
            # �T���ȉ��Ń~�T���K���؂��B
            if rand(100) < 5
              actor.armor1_id = 0
              actor.promise += 500
              text = "\065\067#{actor.name}'s e��uipped \nHo��e��ade Misanga broke!"
              $game_temp.battle_log_text += text
            end
          end
        end
        
        # ���V�X�e���E�F�C�g
        if $game_system.system_read_mode == 0
          @wait_count = system_wait_make($game_temp.battle_log_text)
        end
        # �X�e�[�^�X�E�B���h�E�����t���b�V��
        @status_window.refresh
      end
      return
    end
    
    
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C) or (Input.press?(Input::CTRL) and ($DEBUG or $game_switches[46]))
      if $game_temp.contract_enemy != nil
        start_phase6
      else
        # �o�g���I��
        battle_end(0)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �_��t�F�[�Y�J�n
  #--------------------------------------------------------------------------
  def start_phase6
    # �t�F�[�Y 6 �Ɉڍs
    @phase = 6

    # ���U���g�E�B���h�E������
    @result_window.visible = false
    # ���o�g�����O�E�B���h�E���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    
    enemy = $game_temp.contract_enemy
    @contract = Sprite.new
    bitmap =RPG::Cache.battler(enemy.battler_name, enemy.battler_hue)
    @contract.bitmap = bitmap

    @contract.ox = @contract.bitmap.width / 2
    @contract.oy = @contract.bitmap.height / 2

    @contract.x = 640 / 2
    @contract.y = 480 / 2
    @contract.visible = true
    @contract.opacity = 0
    Audio.se_play("Audio/SE/136-Light02", 80, 100)
    
    @event_switch = false

   
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�t�^�[�o�g���t�F�[�Y)
  #--------------------------------------------------------------------------
  def update_phase6 
    
    if @contract.opacity < 255
      @contract.opacity += 10
      return
    end
    
    if @event_switch == false
      # �R�����C�x���g�u�_��t�F�[�Y�v�����s
      common_event = $data_common_events[28]
      $game_system.battle_interpreter.setup(common_event.list, 0)
      @event_switch = true
    end
    
    # �o�g���C�x���g���s���̏ꍇ
    if $game_system.battle_interpreter.running?
      return
    end
    
    # C �{�^���������ꂽ�ꍇ
#    if Input.trigger?(Input::C)
      # �o�g���J�n�O�� BGM �ɖ߂�
      $game_system.bgm_play($game_temp.map_bgm)
      # �o�g���I��
      battle_end(0)
#    end
  end

  #--------------------------------------------------------------------------
  # �� �_��`�F�b�N
  #--------------------------------------------------------------------------
  def contract_check
    # �_�񖲖��̏�����
    $game_temp.contract_enemy == nil
    # ������Ȃ�I��
    if $game_switches[85] or $game_switches[86] or $game_temp.absolute_contract == 2
      return
    end
    # �p�[�e�B���{�b�N�X�����܂��Ă���ꍇ���I��
    if $game_party.box_max == $game_party.home_actors
      return
    end
    # �Ō�Ɏc���������̗F�D�x��100�ɓ��B���Ă���ꍇ
    if @last_enemies[0].friendly >= 100
      # ���蕨�J�E���g������ꍇ�͖�����
      if @last_enemies[0].present_count > 0
        $game_temp.absolute_contract = 1
      # �g�[�N�񐔂����E���ɒB���Ă����ꍇ��������
      elsif @last_enemies[0].pillowtalk >= 3
        $game_temp.absolute_contract = 1
      end
    # �F�D�x100��������50���z���Ă���ꍇ
    elsif @last_enemies[0].friendly >= 50
      # ���蕨�J�E���g���P��ȏ゠��ꍇ�͕ʃJ�E���g
      if @last_enemies[0].present_count > 0
        perc = (@last_enemies[0].present_count * 30)
        #���x��������K�p(��l���̂ق������x����������Βǉ��␳�ƂȂ�)
        perc -= (@last_enemies[0].level - $game_actors[101].level) * 2
        if rand(100) < perc
          $game_temp.absolute_contract = 1
        end
      end
    # �F�D�x50�ɓ��B���Ă��Ȃ��ꍇ
    else
      # ���蕨�J�E���g���P��ȏ゠��ꍇ�͕ʃJ�E���g
      if @last_enemies[0].present_count > 0
        perc = (@last_enemies[0].present_count * 10)
        #���x��������K�p(��l���̂ق������x����������Βǉ��␳�ƂȂ�)
        perc -= (@last_enemies[0].level - $game_actors[101].level) * 2
        if rand(100) < perc
          $game_temp.absolute_contract = 1
        end
      end
    end
    # ��������ʏ폈��
    # �Ō�Ɏc���������̗F�D�x�{���[�h�������ȓ��Ȃ�Ό_��\��
    per = @last_enemies[0].friendly * $mood.point / 50
    # ���E���b�g�̃��x���𒴂��Ă���ꍇ�A���ɔ�Ⴕ�Ċm��������������
    if $game_actors[101].level < @last_enemies[0].level
      lv_rate = (@last_enemies[0].level - $game_actors[101].level) * 3
    else
      lv_rate = 0
    end
    per -= lv_rate
    #�_��\��̖����Ɖ�b�����蕨�����Ȃ������ꍇ�A�m������������
    if @last_enemies[0].pillowtalk == 0 and @last_enemies[0].present_count == 0
      per /= 10
    end
    # �p�[�Z���g�ő�l��100
    per = [per,100].min
    # ���x���̔����͎��s���������B
    per -= @last_enemies[0].level / 2
    # �퓬�ɏo�Ă��郁���o�[�̕␳�ł��܂�����
    for actor in $game_party.battle_actors
      per += 10 if actor.equip?("�F�D�̃��_��")
      per += 10 if actor.have_ability?("�J���X�}")
    end
    
    c = rand(100)
    if per >= c
      $game_temp.contract_enemy = @last_enemies[0]
    end
    # �m��_��t���O�������Ă�Ȃ�m��œ����
    if $game_temp.absolute_contract == 1
      $game_temp.contract_enemy = @last_enemies[0]
    end
  end
end