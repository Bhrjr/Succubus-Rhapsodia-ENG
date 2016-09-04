#==============================================================================
# �� SR_Util�@�F�@���̑�
#------------------------------------------------------------------------------
#==============================================================================
module SR_Util
  
  #--------------------------------------------------------------------------
  # �� ���̓G�������{�C���o���Ă��Ȃ�
  #--------------------------------------------------------------------------
  def self.enemy_before_earnest?(enemy)
    result = false
    # �x�X�g�G���h���F���~�B�[�i��
    if $game_temp.battle_troop_id == 603
      # �G�l�~�[�ʒu���O�Ԋ��A�܂��{�C���o���Ă��Ȃ�
      if enemy == $game_troop.enemies[0] and not $game_troop.enemies[0].earnest
        result = true
      end
    end
    return result
  end
  #--------------------------------------------------------------------------
  # �� ����ȕ���E��
  #--------------------------------------------------------------------------
  def self.special_undress(enemy)
    enemy.undress
    if $game_temp.battle_log_text != ""
      text = "\w\q" + enemy.bms_states_update
    else
      text = enemy.bms_states_update
    end
    enemy.graphic_change = true
    end
  #--------------------------------------------------------------------------
  # �� ����ȃz�[���h�������s��
  #--------------------------------------------------------------------------
  def self.special_hold_make(skill, active, target)
    $scene.special_hold_start
    $scene.hold_effect(skill, active, target)
    target.white_flash = true
    target.animation_id = 105
    target.animation_hit = true
    # ��ʂ̏c�V�F�C�N
    $game_screen.start_flash(Color.new(255,210,225,220), 8)
    $game_screen.start_shake2(7, 15, 15)
    # ���҂ɃX�^����������
    $scene.battler_stan(active)
    $scene.battler_stan(target)
    $scene.special_hold_end
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h���ƃp�[�c������Ή��p�[�c��Ԃ�
  #--------------------------------------------------------------------------
  def self.holding_parts_name(hold_type, parts_name)
    box = []
    if hold_type == "���}��"
      box.push(["penis"])
      box.push(["vagina"])
    elsif hold_type == "���}��"
      box.push(["penis"])
      box.push(["mouth"])
    elsif hold_type == "�K�}��"
      box.push(["penis"])
      box.push(["anal"])
    elsif hold_type == "�p�C�Y��"
      box.push(["tops"])
      box.push(["penis"])
    elsif hold_type == "�ςӂς�"
      box.push(["tops"])
      box.push(["mouth"])
    elsif hold_type == "�S��"
      box.push(["tops"])
      box.push(["tops"])
    elsif hold_type == "��ʋR��"
      box.push(["vagina"])
      box.push(["mouth"])
    elsif hold_type == "�K�R��"
      box.push(["anal"])
      box.push(["mouth"])
    elsif hold_type == "�N���j"
      box.push(["mouth"])
      box.push(["vagina"])
    elsif hold_type == "�L���킹"
#      box.push(["vagina","anal"])
#      box.push(["vagina","anal"])
      box.push(["vagina"])
      box.push(["vagina"])
    elsif hold_type == "�f�B���h���}��"
      box.push(["dildo"])
      box.push(["vagina"])
    elsif hold_type == "�f�B���h���}��"
      box.push(["dildo"])
      box.push(["mouth"])
    elsif hold_type == "�f�B���h�K�}��"
      box.push(["dildo"])
      box.push(["anal"])
    elsif hold_type == "�G��z��"
      box.push(["tentacle"])
      box.push(["penis"])
    elsif hold_type == "�G��N���j"
      box.push(["tentacle"])
      box.push(["vagina"])
    end
    # �P�ڂɑΉ��p�[�c������ꍇ�́A�Q�ڂ�Ԃ�
    if box[0].include?(parts_name)
      return box[1]
    # �P�ڂɑΉ��p�[�c���Ȃ��ꍇ�́A�P�ڂ�Ԃ�
    else
      return box[0]
    end
  end
  #--------------------------------------------------------------------------
  # �� �t�]�ł���z�[���h�H
  #--------------------------------------------------------------------------
  def self.reversible_hold?(hold_type)
    return true if ["���}��","�L���킹"].include?(hold_type)
    return false
  end
  #--------------------------------------------------------------------------
  # �� �S�A�C�e������C�x���g�̒��g���m�F���A�o��
  #--------------------------------------------------------------------------
  def self.treasure_box_check
    # �c�N�[���ŊJ���Ă��鏇�Ƀ}�b�vID�����ւ���
    maplist = load_data("Data/MapInfos.rxdata")
    num_box = [] 
    for i in 1..999
      if maplist[i] != nil
        num_box.push([i, maplist[i].order])
      end
    end
    num_box.sort!{|a,b| a[1] <=> b[1] }
    # �P���}�b�v�̕󔠂��m�F����
    all_text = ""
    count = 0
    for num in num_box
      i = num[0]
      map_name = (sprintf("Data/Map%03d.rxdata", i))
      next unless FileTest.exist?(map_name)
      map = load_data(map_name)
      events = {}
      text = ""
      for j in map.events.keys
        events[j] = Game_Event.new(i, map.events[j])
#        if map.events[j].pages[0].graphic.character_name == "174-Chest01"
          for list_one in map.events[j].pages[0].list
            contents = ""
            case list_one.code
            when 125 # �S�[���h
              number = list_one.parameters[2]
              contents = "�@#{number}Lps." if list_one.parameters[1] != 0
            when 126 # �A�C�e��
              name = $data_items[list_one.parameters[0]].name
              number = list_one.parameters[3]
              contents = "�@#{name} #{number}��" if list_one.parameters[1] != 1
            when 128 # �h��
              name = $data_armors[list_one.parameters[0]].name
              number = list_one.parameters[3]
              contents = "�@#{name} #{number}��" if list_one.parameters[1] != 1
            end
            text += contents + "\n" if contents != ""
          end
#        end
      end
      if text != ""
        all_text += "��#{maplist[i].name}\n" + text + "\n"
      end
      count += 1
      Graphics.update if count % 50 == 0 
    end
    # treasure_box.txt�ɏo�͂���
    file_name = "treasure_box.txt"    #�ۑ�����t�@�C����
    File.open(file_name, 'w') {|file|
     file.write all_text
    }
    p "treasure_box.txt�ɏo�͂��܂���"
  end
  #--------------------------------------------------------------------------
  # �� �������\���ǂ���
  #--------------------------------------------------------------------------
  def self.can_dream_interference?
    result = false
    result = true if $game_party.all_d_power >= 300
    return result
  end
  #--------------------------------------------------------------------------
  # �� ��l���̎�_�����ߒ���
  #--------------------------------------------------------------------------
  def self.hero_weak_change(weak_id_box = [], type = 0)
    case type
    # type�ɂ���ď�����_��ς���
    #----------------------------------------------------------------------
    when 0 # ��{��_
      # ��{��_��S�ď���
      for i in [10,11,12,13]
        $game_actors[101].remove_ability(i)
      end
    when 1 # �����_
      # �����_��S�ď���
      for i in [16,14]
        $game_actors[101].remove_ability(i)
      end
    end
    #----------------------------------------------------------------------
    # �w�肳�ꂽ��_��S�ďK��
    for i in weak_id_box
      $game_actors[101].gain_ability(i)
    end
  end
  #--------------------------------------------------------------------------
  # �� ��{��_�����߂�
  #--------------------------------------------------------------------------
  def self.normal_weak_dicide(weak_box)
    result = []
    # ���U�߂Ɏア
    result.push(10) if weak_box[0]
    # �K�U�߂Ɏア
    result.push(11) if weak_box[1]
    # ���U�߂Ɏア
    result.push(12) if weak_box[2]
    # ���A�U�߂Ɏア
    result.push(13) if weak_box[3]
    # �Ԃ�
    return result
  end
  #--------------------------------------------------------------------------
  # �� �����_�����߂�
  #--------------------------------------------------------------------------
  def self.special_weak_dicide(weak_box)
    result = []
    # �����Ɏア
    result.push(16) if weak_box[0]
    # �n�s�U�߂Ɏア
    result.push(14) if weak_box[1]
    # �Ԃ�
    return result
  end
  #--------------------------------------------------------------------------
  # �� �g�[�N�p���O�E�F�C�g�̍쐬
  #--------------------------------------------------------------------------
  def self.talk_log_wait_make
    log = $game_temp.battle_log_text
    if log != ""
      # �s���ɍ��킹�ăE�F�C�g������
      log = log.split(/[\n\q]/)
      ct = (4 * (log.size + 1)) + $game_system.battle_speed_time(0) + $game_system.important_wait_time
#      ct = (4 * 3) + $game_system.battle_speed_time(0) + $game_system.important_wait_time
      $game_temp.set_wait_count = ct
    else
      $game_temp.set_wait_count = 0
    end
  end
  #--------------------------------------------------------------------------
  # �� ��Ԉُ툵���X�e�[�g
  #--------------------------------------------------------------------------
  def self.bad_states
    reslut = []
    # �V��Ԉُ�
    for i in 34..40
      reslut.push(i)
    end
    reslut.push(30)  # ����
#    reslut.push(13)   # �f�B���C
#    reslut.push(105)  # �S��
#    reslut.push(106)  # �j��
    return reslut 
  end
  #--------------------------------------------------------------------------
  # �� ���J�X�e�[�g
  #--------------------------------------------------------------------------
  def self.checking_states
    #--------------------------------------------------------------------------
    # ���J�����X�e�[�g�B�_���[�W�����������̕t�^���s���X�L���́A
    # �d�����̎g�p�s�`�F�b�N�����ꂽ��A���s���̃e�L�X�g���o���肷��B
    #--------------------------------------------------------------------------
    reslut = []
    # �h�L�h�L�Q��A�V��Ԉُ�A���g����
    for i in 32..42
      reslut.push(i)
    end
    # ���x�㏸
    for i in 45..50
      reslut.push(i)
    end
    # ���̑�
    reslut.push(13)  # �f�B���C
    reslut.push(30)  # ����
    reslut.push(98)  # ���@�w
    reslut.push(101) # �j��
    reslut.push(102) # �ő�
    reslut.push(103) # ��S
    reslut.push(105) # �S��
    reslut.push(106) # �j��
    # �Ԃ�
    return reslut
  end
  #--------------------------------------------------------------------------
  # �� ����̋V�����s
  #--------------------------------------------------------------------------
  def self.compact_ritual_start
    # �p�[�e�B���Q�l�ȉ��̏ꍇ�A���s�s��
    if $game_party.party_actors.size < 2
      return false
    end
    # �����`�F�b�N
    return false unless $game_party.party_actors[1].love >= 150
    return false unless $game_party.party_actors[1].have_ability?("����")
    return false unless $game_party.party_actors[1].promise >= 10000
    return false if $game_party.party_actors[1].have_ability?("��؂Ȑl")
    # �Ԃ�
    return true
  end
  #--------------------------------------------------------------------------
  # �� �È�j���̋V�����s
  #--------------------------------------------------------------------------
  def self.ancient_rune_ritual_start
    # �p�[�e�B���S�l�ȉ��̏ꍇ�A���s�s��
    if $game_party.party_actors.size < 4
      return false
    end
    # ���Ԃ̂R�l�����_��100�ȏ�A�u�o1000�ȏ�𖞂����Ă��Ȃ��ꍇ�A���s�s��
    for i in 1..3
      unless $game_party.party_actors[i].int >= 100 and
       $game_party.party_actors[i].sp >= 1000
        return false
      end
    end
    # �Ή��̂u�o1000���x�����A���s�J�n�B
    for i in 1..3
      $game_party.party_actors[i].sp -= 1000
    end
    return true
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�^�X�v�Z���ꊇ
  #--------------------------------------------------------------------------
  def self.status_calculate(int, level, type)
    reslut = 1
    case type
    when 0 # �d�o�E�u�o
      reslut = int * 8 * level / $Status_UP_RATE + 300
    when 1 # ���́E�E�ϗ�
      reslut = int * 3 * level / $Status_UP_RATE + 50
    when 2 # ���́E��p���E�f�����E���_��
      reslut = int * 3 * level / $Status_UP_RATE + 30
    end
    return reslut
  end
  #--------------------------------------------------------------------------
  # �� �m�F
  #--------------------------------------------------------------------------
  def self.test_do
    number = 0
    case number
    when 3..1.0/0 
      p "ok" if $DEBUG
    else
      p "out" if $DEBUG
    end
  end
  #--------------------------------------------------------------------------
  # �� �z��
  #--------------------------------------------------------------------------
  def self.energy_drain(active_battler,target_battler)
    # �Ⓒ�������̂��A�N�^�[�̏ꍇ�A�����x����
     if active_battler.is_a?(Game_Actor)
      active_battler.fed += 20
    end
  end
  #--------------------------------------------------------------------------
  # �� ����m�F�i�v�j
  #--------------------------------------------------------------------------
  def self.make_succubus_message(battler)
    # ����G�l�~�[�ƑΏۂ���
    $msg.t_enemy = battler
    $msg.t_target = $game_party.party_actors[0]
    # �A�N�e�B�u�G�l�~�[�������
    temp_active = $game_temp.battle_active_battler
    $game_temp.battle_active_battler = $msg.t_enemy
    
    $msg.at_type = "�z�[���h�U��"
    $msg.at_parts = "���}���F�A�\�R��"
    
    # �o��
    p $msg.call(battler) if $DEBUG
    
    # ���ɖ߂�
    $game_temp.battle_active_battler = temp_active
  end
  #--------------------------------------------------------------------------
  # �� ��V���{����O�̕ϐ����Z�b�g
  #--------------------------------------------------------------------------
  def self.nonsymbol_battle_reset
    
    # �������t���b�g��
    $game_temp.first_attack_flag = 0
    # �m��_��t���O��s��Ԃ�
    $game_temp.absolute_contract = 2
    
  end
  #--------------------------------------------------------------------------
  # �� �K���X�L���\�̊m�F
  #--------------------------------------------------------------------------
  def self.debug_learnings_check
    for i in 1..300
      
      next if $data_classes[i].name == ""
      next if $data_classes[i].name.include?("��")
      next if $data_classes[i].name.include?("�ydata�z")
      
      message = ""
      message += "#{$data_classes[i].name} #{$data_classes[i].color}\n"
      for learn in $data_classes[i].learnings
        case learn[1] 
        when 0
          next if [2,4,81,82,83,84,121,123].include?(learn[2])
          message += "Lv#{learn[0].to_s}.#{$data_skills[learn[2]].name}\n"
        when 1
          message += "Lv#{learn[0].to_s}.�y#{$data_ability[learn[2]].name}�z\n"
        end
      end
      print message
    end
  end
  #--------------------------------------------------------------------------
  # �� �{�[�i�X�\�̊m�F
  #--------------------------------------------------------------------------
  def self.debug_bonus_check
    for i in 1..300
      
      next if $data_classes[i].name == ""
      next if $data_classes[i].name.include?("��")
      next if $data_classes[i].name.include?("�ydata�z")
      
      message = ""
      message += "#{$data_classes[i].name} #{$data_classes[i].color}\n"
      for learn in $data_classes[i].bonus
        case learn[1] 
        when 0
          message += "Cost:#{learn[0].to_s}.#{$data_skills[learn[2]].name}\n"
        when 1
          next if [19,21,23,27,29].include?(learn[2])
          message += "Cost:#{learn[0].to_s}.�y#{$data_ability[learn[2]].name}�z\n"
        end
      end
      print message
    end
  end
  #--------------------------------------------------------------------------
  # �� ���̌��㎞�̃X�e�[�^�X�ϓ�
  #    �����������ǂ��͂Ȃ������X���������̂��R�s�y�������̂̂��߁A����͑��v�B
  #--------------------------------------------------------------------------
  def self.spam_gift_change
    $game_actors[101].sp -= 
    $game_temp.battle_active_battler.absorb
    for actor in $game_party.party_actors
      if actor == $game_temp.battle_active_battler
        actor.fed = 100
        actor.promise += 100
        actor.promise += 20 if actor.equip?("�K���X�̎w��")
        actor.promise += 30 if actor.equip?("�M���̃��[��")
        actor.love += 3
        actor.love += 2 if actor.equip?("�K���X�̎w��")
        #actor.love_dish_bonus(0)
        actor.hp = actor.maxhp if actor.equip?("���H�̃��[��")
        actor.sp = actor.maxsp if actor.equip?("���H�̃��[��")
        actor.remove_state(15)
      elsif actor != $game_actors[101]
        actor.love += 1
        actor.love += 1 if actor.equip?("�K���X�̎w��")
        actor.promise += 10
        actor.promise += 5 if actor.equip?("�K���X�̎w��")
        actor.promise += 5 if actor.equip?("�M���̃��[��")
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �x�b�h���̃X�e�[�^�X�ϓ�
  #    �����������ǂ��͂Ȃ������X���������̂��R�s�y�������̂̂��߁A����͑��v�B
  #--------------------------------------------------------------------------
  def self.bed_battle_change
    favor_list = []
    for actor in $game_temp.vs_actors
      $game_actors[actor.id].vs_me = false
      $game_actors[actor.id].love += 3
      $game_actors[actor.id].love += 2 if actor.equip?("�K���X�̎w��")
      $game_actors[actor.id].promise += 30
      $game_actors[actor.id].promise += 20 if actor.equip?("�K���X�̎w��")
      $game_actors[actor.id].promise += 30 if actor.equip?("�M���̃��[��")
      #$game_actors[actor.id].love_dish_bonus(1)
      $game_party.add_actor(actor.id)
      $game_party.battle_actor_refresh
      # �D���x��100�ȏ㊎���������Ă��Ȃ��ꍇ�A�������X�g�ɒǉ�����
      if $game_actors[actor.id].love >= 100 and not $game_actors[actor.id].have_ability?("����")
        favor_list.push($game_actors[actor.id])
      end
    end
    for actor in $game_party.party_actors
      if actor != $game_actors[101]
        $game_actors[actor.id].love += 3
        $game_actors[actor.id].love += 2 if actor.equip?("�K���X�̎w��")
        $game_actors[actor.id].promise += 20
        $game_actors[actor.id].promise += 20 if actor.equip?("�K���X�̎w��")
        $game_actors[actor.id].promise += 30 if actor.equip?("�M���̃��[��")
        $game_actors[actor.id].bedin_count += 1
        #$game_actors[actor.id].love_dish_bonus(2)
      end
    end
    $game_temp.vs_actors = []
    
    # �����`�F�b�N
    text = ""
    for favor_actor in favor_list
      text += "\n" if text != ""
      favor_actor.gain_ability(60)  # �y�����z
      favor_actor.gain_ability(302) # �y�A�N�Z�v�g�z�������Ă��Ȃ������������ŏK��
      text += "#{$game_actors[101].name}��#{favor_actor.name}����̒����𓾂��I"
    end
    $game_variables[2] = ""
    $game_variables[2] = text if text != ""
    
  end
  #--------------------------------------------------------------------------
  # �� �X�L������u�o�̌v�Z 
  #--------------------------------------------------------------------------
  def self.sp_cost_result(battler, skill)
    
    result = skill.sp_cost
    # ���@�X�L���̏ꍇ
    if skill.element_set.include?(5)
      # �X�e�[�g�u���@�w�v�����Ă���ꍇ�A�O�ɁB
      result = 0 if battler.state?(98)
      # �����̎����𑕔����̏ꍇ�A1/2�ɁB
      if battler.is_a?(Game_Actor)
        result /= 2 if battler.equip?("�����̎����")
      end
    end
    if not (skill.name == "�E�F�C�g" or 
     skill.name == "�t���[�A�N�V����" or
     skill.name == "�G���[�V����" or 
     skill.name == "���x�~")
      # ���E��Ԃ̏ꍇ�AVP��3�������Z
      if battler.state?(37)
        # �{�X�n�͋��E�̌��ʂ��㉻������
        if battler.is_a?(Game_Enemy) and (
        $data_enemies[battler.id].element_ranks[124] == 1 or # �C�x���g�G�̏ꍇ
        $data_enemies[battler.id].element_ranks[126] == 1 or # �{�X�̏ꍇ
        $data_enemies[battler.id].element_ranks[128] == 1)   # ���X�{�X�̏ꍇ
          result += battler.maxsp * 0.005
        else
          result += battler.maxsp * 0.03
        end
        result = result.truncate
      end
      # �f�����L�X�}�[�N�𑕔����̏ꍇ�AVP��0.5�������Z
      if battler.is_a?(Game_Actor)
        if battler.equip?("�f�����L�X�}�[�N")
          result += battler.maxsp * 0.01
          result = result.truncate
        end
      end
    end
    return result
  end
  #--------------------------------------------------------------------------
  # �� �A�i�E���X
  #--------------------------------------------------------------------------
  def self.announce(text, se = "�ʏ�")
    $game_temp.announce_text.push([text, se])
  end
  #--------------------------------------------------------------------------
  # �� �}�b�v���̈ꎞ�ϐ������Z�b�g ��
  #--------------------------------------------------------------------------
  def self.map_temp_variables_reset
    # �V���{���o���ϐ��E���G�ϐ�
    for i in 102..150
      $game_variables[i] = 0
    end
    # �X�v���C�g�̏����Y�ꂪ����ꍇ�͏���
    $sprite.dispose if $sprite != nil
  end
  #--------------------------------------------------------------------------
  # �� �Q�[���I�[�o�[���̕ϐ������Z�b�g ��
  #    �����̗����g�p�����ꍇ�������ʂ�܂��B
  #--------------------------------------------------------------------------
  def self.map_gameover_reset
    $game_variables[29] = 0 # ��������_���@�n�攻��
    $game_variables[38] = 0 # �Èœx�i�����j
    $game_switches[53]  = false # ���v��
    $game_switches[54]  = false # ���̚���
    $game_switches[75]  = false # ���̗��g�p�֎~
    $game_switches[334] = false # ��˂̖����ɖڂ�t����ꂽ
    $game_switches[305] = false # �Q�K����F�S�u�����^�E��
    $game_switches[433] = false # �Q�K����F���E�ΎR�ʘH
  end
  #--------------------------------------------------------------------------
  # �� �A�C�e�����莞�̃e�L�X�g�쐬
  #--------------------------------------------------------------------------
  def self.item_get_message_make

    # ������
    message = []
    text  = ""
    count = 0
    
    # �����Ȃ�������I��
    if $game_temp.get_item == [] or $game_temp.get_item == nil
      return message
    end
    
    # �S�A�C�e�����m�F����܂Ń��[�v
    while $game_temp.get_item.size > 0
    
      # �S�s�g�p�����玟�̃y�[�W
      if count >= 4
        message.push(text)
        text  = ""
        count = 0
      end
      
      # ��ԑO�̃A�C�e���擾�f�[�^��ǂݍ���
      data = $game_temp.get_item.shift
      text += "\\T[#{data[1]}]#{data[2]}#{data[0]}�@����ɓ��ꂽ�I"
      if $game_temp.get_item.size > 0
        count += 1
        text += "\n" if count < 4
      end
    end
    
    # ���b�Z�[�W���i�[
    message.push(text)
    
    return message
  end
  #--------------------------------------------------------------------------
  # �� �`�F�b�N���U���g�̃e�L�X�g�쐬
  #--------------------------------------------------------------------------
  def self.make_condition_text(battler)
    
    # �`�F�b�L���O�m�F
    checking = battler.checking
    checking = 10 if battler.is_a?(Game_Actor) # �A�N�^�[�̏ꍇ���ꏈ��
    
    #--------------------------------------------------------------------------
    # �������b�Z�[�W�E�B���h�E�P
    #--------------------------------------------------------------------------
    
    message = []
    
    # �����O/�푰��������쐬
    names_text = "#{battler.name}/#{$data_classes[battler.class_id].name}"
    
    # �����i��������쐬
    personality = battler.personality
    personality = "�H�H�H�H" if checking < 1 # �`�F�b�N�����P�ȏ�
    personality_text = "���i�F#{personality}"
    
    # ����_��������쐬
    # ��_�m�F
    weak_list = [
    "���U�߂Ɏア",
    "��U�߂Ɏア",
    "���U�߂Ɏア",
    "���A�U�߂Ɏア",
    "�n�s�U�߂Ɏア",
    "�ٌ`�U�߂Ɏア",
    "�����Ɏア",
    "��s�Ɏア",
    "����������", "���O",
    "����������", "����", 
    "���K��������", "���K",
    "�e����������", "����",
    "�A�j��������", "���j",
    "���A��������", "����",
    ]
    # ����������Z�b�g
    weak_text = ""
    # ���X�g���쐬
    battler_weak_list = []
    for weak in weak_list
      # ��_�������Ă���΃��X�g�ɒǉ�
      if battler.have_ability?(weak)
        battler_weak_list.push(weak)
      end
    end
    # ��_�p�e�L�X�g���쐬
    if battler_weak_list != []
      weak_text = SR_Util.weak_text_change(battler_weak_list)
    else
      weak_text = "����"
    end
    weak_text = "�H�H�H�H�H" if checking < 1 # �`�F�b�N�����P�ȏ�
    weak_base = "��_�F"
    # �X�e�[�g����
    weak_text = weak_base + weak_text
    
    # ���X�e�[�g��������쐬
    state_text = ""
    # �P�s�ɕ\�����Ă���X�e�[�g�����쐬
    state_set = 0
    for i in battler.states
      if $data_states[i].rating >= 1
        if state_set == 0
          state_text += $data_states[i].name
          state_set += 1
        else
          # �P�s�ɃX�e�[�g���W�`�悵������s
          if state_set == 20
            state_text += "\n"
            state_set = 0
          end
          new_text = state_text + "/" + $data_states[i].name
          state_set += 1
          state_text = new_text
        end
      end
    end
    # �X�e�[�g���̕����񂪋�̏ꍇ�� "�X�e�[�g����" �ɂ���
    if state_text == ""
      state_text = "����"
    end
    state_base = "��ԁF"
    # �X�e�[�g����
    state_text = state_base + state_text

    # ���b�Z�[�W�E�B���h�E�P�\�������쐬
    message.push("#{names_text}\n#{personality_text}\n#{weak_text}\n#{state_text}")

    #--------------------------------------------------------------------------
    # �������b�Z�[�W�E�B���h�E�Q
    #--------------------------------------------------------------------------
    
    # �`�F�b�N�����Q�ȏォ��\���i�A�N�^�[�͕\�����Ȃ��j
    if checking >= 2 and checking < 10
    
      # ���ϋv��������쐬
      ep = "#{battler.hp}/#{battler.maxhp}"
      vp = "#{battler.sp}/#{battler.maxsp}"
      # �{�X��͌��d�o�A�u�o���B���B
      ep = "�H�H/#{battler.maxhp}" if $game_switches[91]
      vp = "�H�H/#{battler.maxsp}" if $game_switches[91]
      toughness_text = "�d�o�F#{ep}\n�u�o�F#{vp}"
    
      # ���b�Z�[�W�E�B���h�E�Q�\�������쐬
      message.push("#{toughness_text}")
    end
    #--------------------------------------------------------------------------
    
      # �h���b�v�A�C�e��
    
    #--------------------------------------------------------------------------
    
    #--------------------------------------------------------------------------
    # �������b�Z�[�W�E�B���h�E����
    #--------------------------------------------------------------------------
    
    # �`�F�b�N�����P�ȏォ��\���i�A�N�^�[�͕\�����Ȃ��j
    if checking >= 1 and checking < 10
      
      # �G��p�X�e�[�g�ϐ��̕\��
      state_rank_text = ""
      state_rank_text1 = ""
      state_rank_text2 = ""
      for i in 1..battler.state_ranks.xsize
        if battler.state_ranks[i] == 6
          state_rank_text1 += "�E" unless state_rank_text1 == ""
          state_rank_text1 += $data_states[i].name
        elsif battler.state_ranks[i] == 5
          state_rank_text2 += "�E" unless state_rank_text2 == ""
          state_rank_text2 += $data_states[i].name
        end
      end
      state_rank_text += "\n�����F#{state_rank_text1}" if state_rank_text1 != ""
      state_rank_text += "\n��R�F#{state_rank_text2}" if state_rank_text2 != ""
      
      # ���b�Z�[�W�E�B���h�E����̕\�������쐬
      unless state_rank_text == ""
        state_rank_text = "�y�������ϐ��z" + "#{state_rank_text}"
        message.push("#{state_rank_text}")
      end
        
    end
    
    #--------------------------------------------------------------------------
    # �������b�Z�[�W�E�B���h�E����
    #--------------------------------------------------------------------------
    
    # �`�F�b�N�����P�ȏォ��\���i�A�N�^�[�͕\�����Ȃ��j
    if checking >= 1 and checking < 10
      
      special_text = ""
      # ������ȊO���A����ȑf���������̂�\��
      if not ($game_switches[85] or $game_switches[86])
        if battler.have_ability?("�m�ł��鎩���S")
          special_text += "�y�m�ł��鎩���S�z"
          special_text += "\n" + $data_ability.data[$data_ability.search(0,"�m�ł��鎩���S")].description
        elsif battler.have_ability?("�ł̑̉t")
          special_text += "�y�ł̑̉t�z"
          special_text += "\n" + $data_ability.data[$data_ability.search(0,"�ł̑̉t")].description
        elsif battler.have_ability?("�ώ�")
          special_text += "�y�ώ��z"
          special_text += "\n" + $data_ability.data[$data_ability.search(0,"�ώ�")].description
        elsif battler.have_ability?("��ǂ�")
          special_text += "�y��ǂ݁z"
          special_text += "\n" + $data_ability.data[$data_ability.search(0,"��ǂ�")].description
        end
      end
      
      # ���b�Z�[�W�E�B���h�E����̕\�������쐬
      unless special_text == ""
        message.push("#{special_text}")
      end
    end
    
    # �ŏI�o��
    return message
  end

#==============================================================================
  
  #--------------------------------------------------------------------------
  # �� �`�F�b�N���U���g�p�A��_�e�L�X�g����
  #--------------------------------------------------------------------------
  def self.weak_text_change(battler_weak_list)
    
    #--------------------------------------------------------------------------
    # �����@�����Ɏア�n
    #--------------------------------------------------------------------------
    
    text_first = ""

    # �����U�߂Ɏア
    #--------------------------------------------------------------------------
    text_1 = ""
    count = 0
    for weak in battler_weak_list
      text_1a = ""
      case weak
      when "���U�߂Ɏア"
        text_1a += "��"
      when "��U�߂Ɏア"
        text_1a += "��"
      when "���U�߂Ɏア"
        text_1a += "��"
      when "���A�U�߂Ɏア"
        text_1a += "���A"
      when "�n�s�U�߂Ɏア"
        text_1a += "�n�s"
      when "�ٌ`�U�߂Ɏア"
        text_1a += "�ٌ`"
      end
      # ��_�������Ă���΃e�L�X�g�ɒǉ�
      if text_1a != ""
        text_1 += "�E" if count > 0 
        text_1 += text_1a
        count += 1 
      end
    end
    text_1 += "�U��" if text_1 != ""

    # �����Ɏア
    #--------------------------------------------------------------------------
    text_2 = ""
    count = 0
    for weak in battler_weak_list
      text_2a = ""
      case weak
      when "�����Ɏア"
        text_2a += "����"
      when "��s�Ɏア"
        text_2a += "��s"
      end
      # ��_�������Ă���΃e�L�X�g�ɒǉ�
      if text_2a != ""
        text_2 += "�E" if count > 0 
        text_2 += text_2a
        count += 1 
      end
    end

    #--------------------------------------------------------------------------
    
    text_first = text_1 + "�Ɏア" if text_1 != ""
    text_first = text_2 + "�Ɏア" if text_2 != ""
    text_first = text_1 + "�A" + text_2 + "�Ɏア" if text_1 != "" and text_2 != ""

    #--------------------------------------------------------------------------
    # �����@�������ア�n
    #--------------------------------------------------------------------------
    
    text_second = ""

    # ������������
    #--------------------------------------------------------------------------
    text_3 = ""
    count = 0
    for weak in battler_weak_list
      text_3a = ""
      case weak
      when "����������"
        text_3a += "��"
      when "����������"
        text_3a += "��"
      when "���K��������"
        text_3a += "���K"
      when "�e����������"
        text_3a += "�e��"
      when "�A�j��������"
        text_3a += "�A�j"
      when "���A��������"
        text_3a += "���A"
      end
      # ��_�������Ă���΃e�L�X�g�ɒǉ�
      if text_3a != ""
        text_3 += "�E" if count > 0 
        text_3 += text_3a
        count += 1 
      end
    end
    text_second = text_3 + "���ア" if text_3 != ""

    #--------------------------------------------------------------------------
    text_third = ""

    # ����
    #--------------------------------------------------------------------------
    text_4 = ""
    count = 0
    for weak in battler_weak_list
      text_4a = ""
      case weak
      when "���O"
        text_4a += "��"
      when "����" 
        text_4a += "��"
      when "���K"
        text_4a += "���K"
      when "����"
        text_4a += "�e��"
      when "���j"
        text_4a += "�A�j"
      when "����"
        text_4a += "���A"
      end
      # ��_�������Ă���΃e�L�X�g�ɒǉ�
      if text_4a != ""
        text_4 += "�E" if count > 0 
        text_4 += text_4a
        count += 1 
      end
    end
    text_third = text_4 + "�����Ɏア" if text_4 != ""
        
    #--------------------------------------------------------------------------
    # �����@�e�L�X�g�m��
    #--------------------------------------------------------------------------
    
    text = ""
    count = 0
    # �����U�߂Ɏア
    if text_first != ""
      text += "�@" if count > 0
      text += text_first
      count += 1
    end
    # ������������
    if text_second != ""
      text += "�@" if count > 0
      text += text_second 
      count += 1
    end
    # ����
    if text_third != ""
      text += "�@" if count > 0
      text += text_third
      count += 1
    end
    return text
    
  end
  
end