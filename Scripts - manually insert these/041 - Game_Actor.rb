#==============================================================================
# �� Game_Actor
#------------------------------------------------------------------------------
# �@�A�N�^�[�������N���X�ł��B���̃N���X�� Game_Actors �N���X ($game_actors)
# �̓����Ŏg�p����AGame_Party �N���X ($game_party) ������Q�Ƃ���܂��B
#==============================================================================

class Game_Actor < Game_Battler
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_reader   :name                   # ���O
  attr_reader   :character_name         # �L�����N�^�[ �t�@�C����
  attr_reader   :character_hue          # �L�����N�^�[ �F��
  attr_reader   :class_id               # �N���X ID
  attr_accessor :weapon_id              # ���� ID
  attr_accessor :armor1_id              # �� ID
  attr_accessor :armor2_id              # ���h�� ID
  attr_accessor :armor3_id              # �̖h�� ID
  attr_accessor :armor4_id              # �����i ID
  attr_reader   :level                  # ���x��
  attr_accessor :exp                    # EXP
  # ���ǉ��ӏ�---------------------------------------------------------------
  attr_accessor :skills                 # �X�L��
  attr_accessor :base_atk2              # �U���́i�����p�j
  attr_accessor :base_pdef2             # �����h��i�����p�j
  attr_accessor :base_mdef2             # ���@�h��i�����p�j
  attr_accessor :promise                # �_��|�C���g
  attr_accessor :maxfed                 # �ő喞���x
  attr_accessor :fed                    # �����x
  attr_accessor :digest                 # �󕠗�
  attr_accessor :absorb                 # �z����
  attr_accessor :d_power                # ���̖���
  attr_accessor :exp_tank               # �o���l�^���N
  attr_accessor :race                   # �푰
  attr_accessor :hp_autoheal            # EP������
  attr_accessor :sp_autoheal            # VP������
  attr_accessor :vs_me                  # ���̖����Ɛ퓬��
  attr_accessor :exp_list               # �o���l�e�[�u��
  attr_accessor :level_up_log           # ���x���A�b�v���O
  attr_accessor :skill_collect          # �X�L���g�p����
  attr_accessor :exp_plus_flag          # �o���l�𑽂߂ɖ�������H
  
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #     actor_id : �A�N�^�[ ID
  #--------------------------------------------------------------------------
  def initialize(actor_id)
    super()
    setup(actor_id)
  end
  #--------------------------------------------------------------------------
  # �� �Z�b�g�A�b�v
  #     actor_id : �A�N�^�[ ID
  #--------------------------------------------------------------------------
  def setup(actor_id)
    actor = $data_actors[actor_id]
    @actor_id = actor_id
    @name = actor.name
    @character_name = actor.character_name
    @character_hue = actor.character_hue
    @battler_name = actor.battler_name
    @battler_hue = actor.battler_hue
    @class_id = actor.class_id
    @weapon_id = actor.weapon_id
    @armor1_id = actor.armor1_id
    @armor2_id = actor.armor2_id
    @armor3_id = actor.armor3_id
    @armor4_id = actor.armor4_id
    @level = actor.initial_level
    @exp_list = Array.new(101)
    make_exp_list
    @exp = @exp_list[@level]
    @skills = []
    @hp = maxhp
    @sp = maxsp
    @states = []
    @states_turn = {}
    @maxhp_plus = 0
    @maxsp_plus = 0
    @str_plus = 0
    @dex_plus = 0
    @agi_plus = 0
    @int_plus = 0
    # �� �X�V�ӏ�
    @base_atk2 = 0
    @base_pdef2 = 0
    @base_mdef2 = 0
    @promise = 0
    @maxfed = 100
    @fed = 100
    @digest = 0
    @absorb = 0
    @d_power = 0
    @exp_tank = 0
    @hp_autoheal = 1
    @sp_autoheal = 1
    @vs_me = false
    @skill_collect = nil
    # �X�L���K��
    @skills = []
    if actor_id == 101
      for i in 1..@level
        for j in $data_classes[@class_id].learnings
          if j[0] == i
            if j[1] == 0
              learn_skill(j[2])
            else
              gain_ability(j[2])
            end
          end
        end
      end
    end
    @level_up_log = ""
    # �I�[�g�X�e�[�g���X�V
    update_auto_state(nil, $data_armors[@armor1_id])
    update_auto_state(nil, $data_armors[@armor2_id])
    update_auto_state(nil, $data_armors[@armor3_id])
    update_auto_state(nil, $data_armors[@armor4_id])
  end
  #--------------------------------------------------------------------------
  # �� �A�N�^�[ ID �擾
  #--------------------------------------------------------------------------
  def id
    return @actor_id
  end
  #--------------------------------------------------------------------------
  # �� �C���f�b�N�X�擾
  #--------------------------------------------------------------------------
  def index
    return $game_party.actors.index(self)
  end
  #--------------------------------------------------------------------------
  # �� EXP �v�Z
  #--------------------------------------------------------------------------
  def make_exp_list
    actor = $data_actors[@actor_id]
    @exp_list[1] = 0
    pow_i = 2.4 + actor.exp_inflation / 100.0
    for i in 2..100
      if i > actor.final_level
        @exp_list[i] = 0
      else
        n = actor.exp_basis * ((i + 3) ** pow_i) / (5 ** pow_i)
        @exp_list[i] = @exp_list[i-1] + Integer(n)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �����␳�l�̎擾
  #     element_id : ���� ID
  #--------------------------------------------------------------------------
  def element_rate(element_id)
    # �����L���x�ɑΉ����鐔�l���擾
    table = [0,200,150,100,50,0,-100]
    result = table[$data_classes[@class_id].element_ranks[element_id]]
    # �h��ł��̑������h�䂳��Ă���ꍇ�͔���
    for i in [@armor1_id, @armor2_id, @armor3_id, @armor4_id]
      armor = $data_armors[i]
      if armor != nil and armor.guard_element_set.include?(element_id)
        result /= 2
      end
    end
    # �X�e�[�g�ł��̑������h�䂳��Ă���ꍇ�͔���
    for i in @states
      if $data_states[i].guard_element_set.include?(element_id)
        result /= 2
      end
    end
    # ���\�b�h�I��
    return result
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�L���x�̎擾
  #--------------------------------------------------------------------------
  def state_ranks
    return $data_classes[@class_id].state_ranks
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�h�䔻��
  #     state_id : �X�e�[�g ID
  #--------------------------------------------------------------------------
  def state_guard?(state_id)
    for i in [@armor1_id, @armor2_id, @armor3_id, @armor4_id]
      armor = $data_armors[i]
      if armor != nil
        if armor.guard_state_set.include?(state_id)
          return true
        end
      end
    end
    return false
  end
  #--------------------------------------------------------------------------
  # �� �ʏ�U���̑����擾
  #--------------------------------------------------------------------------
  def element_set
    weapon = $data_weapons[@weapon_id]
    return weapon != nil ? weapon.element_set : []
  end
  #--------------------------------------------------------------------------
  # �� �ʏ�U���̃X�e�[�g�ω� (+) �擾
  #--------------------------------------------------------------------------
  def plus_state_set
    weapon = $data_weapons[@weapon_id]
    return weapon != nil ? weapon.plus_state_set : []
  end
  #--------------------------------------------------------------------------
  # �� �ʏ�U���̃X�e�[�g�ω� (-) �擾
  #--------------------------------------------------------------------------
  def minus_state_set
    weapon = $data_weapons[@weapon_id]
    return weapon != nil ? weapon.minus_state_set : []
  end
  #--------------------------------------------------------------------------
  # �� MaxHP �̎擾
  #--------------------------------------------------------------------------
  def maxhp
    n = [[base_maxhp + @maxhp_plus, 1].max, 9999].min
    for i in @states
      n *= $data_states[i].maxhp_rate / 100.0
    end
    n = [[Integer(n), 1].max, 9999].min
    n += 300 if self.is_a?(Game_Actor) and self.equip?("�\�H�̃��[��")
    return n
  end
  #--------------------------------------------------------------------------
  # �� ��{ MaxHP �̎擾
  #--------------------------------------------------------------------------
  def base_maxhp
    return $data_actors[@actor_id].parameters[0, @level]
  end
  #--------------------------------------------------------------------------
  # �� ��{ MaxSP �̎擾
  #--------------------------------------------------------------------------
  def base_maxsp
    return $data_actors[@actor_id].parameters[1, @level]
  end
  #--------------------------------------------------------------------------
  # �� ��{�r�͂̎擾
  #--------------------------------------------------------------------------
  def base_str
    n = $data_actors[@actor_id].parameters[2, @level]
    weapon = $data_weapons[@weapon_id]
    armor1 = $data_armors[@armor1_id]
    armor2 = $data_armors[@armor2_id]
    armor3 = $data_armors[@armor3_id]
    armor4 = $data_armors[@armor4_id]
    n += weapon != nil ? weapon.str_plus : 0
    n += armor1 != nil ? armor1.str_plus : 0
    n += armor2 != nil ? armor2.str_plus : 0
    n += armor3 != nil ? armor3.str_plus : 0
    n += armor4 != nil ? armor4.str_plus : 0
    return [[n, 1].max, 999].min
  end
  #--------------------------------------------------------------------------
  # �� ��{��p���̎擾
  #--------------------------------------------------------------------------
  def base_dex
    n = $data_actors[@actor_id].parameters[3, @level]
    weapon = $data_weapons[@weapon_id]
    armor1 = $data_armors[@armor1_id]
    armor2 = $data_armors[@armor2_id]
    armor3 = $data_armors[@armor3_id]
    armor4 = $data_armors[@armor4_id]
    n += weapon != nil ? weapon.dex_plus : 0
    n += armor1 != nil ? armor1.dex_plus : 0
    n += armor2 != nil ? armor2.dex_plus : 0
    n += armor3 != nil ? armor3.dex_plus : 0
    n += armor4 != nil ? armor4.dex_plus : 0
    return [[n, 1].max, 999].min
  end
  #--------------------------------------------------------------------------
  # �� ��{�f�����̎擾
  #--------------------------------------------------------------------------
  def base_agi
    n = $data_actors[@actor_id].parameters[4, @level]
    weapon = $data_weapons[@weapon_id]
    armor1 = $data_armors[@armor1_id]
    armor2 = $data_armors[@armor2_id]
    armor3 = $data_armors[@armor3_id]
    armor4 = $data_armors[@armor4_id]
    n += weapon != nil ? weapon.agi_plus : 0
    n += armor1 != nil ? armor1.agi_plus : 0
    n += armor2 != nil ? armor2.agi_plus : 0
    n += armor3 != nil ? armor3.agi_plus : 0
    n += armor4 != nil ? armor4.agi_plus : 0
    return [[n, 1].max, 999].min
  end
  #--------------------------------------------------------------------------
  # �� ��{���͂̎擾
  #--------------------------------------------------------------------------
  def base_int
    n = $data_actors[@actor_id].parameters[5, @level]
    weapon = $data_weapons[@weapon_id]
    armor1 = $data_armors[@armor1_id]
    armor2 = $data_armors[@armor2_id]
    armor3 = $data_armors[@armor3_id]
    armor4 = $data_armors[@armor4_id]
    n += weapon != nil ? weapon.int_plus : 0
    n += armor1 != nil ? armor1.int_plus : 0
    n += armor2 != nil ? armor2.int_plus : 0
    n += armor3 != nil ? armor3.int_plus : 0
    n += armor4 != nil ? armor4.int_plus : 0
    return [[n, 1].max, 999].min
  end
  #--------------------------------------------------------------------------
  # �� ��{�U���͂̎擾
  #--------------------------------------------------------------------------
  def base_atk
    weapon = $data_weapons[@weapon_id]
    return weapon != nil ? weapon.atk : 0
  end
  #--------------------------------------------------------------------------
  # �� ��{�����h��̎擾
  #--------------------------------------------------------------------------
  def base_pdef
    weapon = $data_weapons[@weapon_id]
    armor1 = $data_armors[@armor1_id]
    armor2 = $data_armors[@armor2_id]
    armor3 = $data_armors[@armor3_id]
    armor4 = $data_armors[@armor4_id]
    pdef1 = weapon != nil ? weapon.pdef : 0
    pdef2 = armor1 != nil ? armor1.pdef : 0
    pdef3 = armor2 != nil ? armor2.pdef : 0
    pdef4 = armor3 != nil ? armor3.pdef : 0
    pdef5 = armor4 != nil ? armor4.pdef : 0
    return pdef1 + pdef2 + pdef3 + pdef4 + pdef5
  end
  #--------------------------------------------------------------------------
  # �� �����p��{�����h��̎擾
  #--------------------------------------------------------------------------
  def base_pdef2
    weapon = $data_weapons[@weapon_id]
    armor1 = $data_armors[@armor1_id]
    armor2 = $data_armors[@armor2_id]
    armor3 = $data_armors[@armor3_id]
    armor4 = $data_armors[@armor4_id]
    pdef1 = weapon != nil ? weapon.pdef : 0
    pdef2 = armor1 != nil ? armor1.pdef : 0
    pdef3 = armor2 != nil ? armor2.pdef : 0
    pdef4 = armor3 != nil ? armor3.pdef : 0
    pdef5 = armor4 != nil ? armor4.pdef : 0
    return pdef1 + pdef2 + pdef3 + pdef4 + pdef5 + int
  end
  #--------------------------------------------------------------------------
  # �� ��{���@�h��̎擾
  #--------------------------------------------------------------------------
  def base_mdef
    weapon = $data_weapons[@weapon_id]
    armor1 = $data_armors[@armor1_id]
    armor2 = $data_armors[@armor2_id]
    armor3 = $data_armors[@armor3_id]
    armor4 = $data_armors[@armor4_id]
    mdef1 = weapon != nil ? weapon.mdef : 0
    mdef2 = armor1 != nil ? armor1.mdef : 0
    mdef3 = armor2 != nil ? armor2.mdef : 0
    mdef4 = armor3 != nil ? armor3.mdef : 0
    mdef5 = armor4 != nil ? armor4.mdef : 0
    return mdef1 + mdef2 + mdef3 + mdef4 + mdef5
  end
  #--------------------------------------------------------------------------
  # �� ��{����C���̎擾
  #--------------------------------------------------------------------------
  def base_eva
    armor1 = $data_armors[@armor1_id]
    armor2 = $data_armors[@armor2_id]
    armor3 = $data_armors[@armor3_id]
    armor4 = $data_armors[@armor4_id]
    eva1 = armor1 != nil ? armor1.eva : 0
    eva2 = armor2 != nil ? armor2.eva : 0
    eva3 = armor3 != nil ? armor3.eva : 0
    eva4 = armor4 != nil ? armor4.eva : 0
    return eva1 + eva2 + eva3 + eva4
  end
  #--------------------------------------------------------------------------
  # �� �ʏ�U�� �U�����A�j���[�V���� ID �̎擾
  #--------------------------------------------------------------------------
  def animation1_id
    weapon = $data_weapons[@weapon_id]
    return weapon != nil ? weapon.animation1_id : 0
  end
  #--------------------------------------------------------------------------
  # �� �ʏ�U�� �Ώۑ��A�j���[�V���� ID �̎擾
  #--------------------------------------------------------------------------
  def animation2_id
    weapon = $data_weapons[@weapon_id]
    return weapon != nil ? weapon.animation2_id : 0
  end

  #--------------------------------------------------------------------------
  # �� EXP �̕�����擾
  #--------------------------------------------------------------------------
  def exp_s
    return @exp_list[@level+1] > 0 ? @exp.to_s : "----"
  end
  #--------------------------------------------------------------------------
  # �� ���̃��x���� EXP �̕�����擾
  #--------------------------------------------------------------------------
  def next_exp_s
    return @exp_list[@level+1] > 0 ? @exp_list[@level+1].to_s : "----"
  end
  #--------------------------------------------------------------------------
  # �� ���̃��x���܂ł� EXP �̕�����擾
  #--------------------------------------------------------------------------
  def next_rest_exp_s
    return @exp_list[@level+1] > 0 ?
      (@exp_list[@level+1] - @exp).to_s : "----"
  end
  #--------------------------------------------------------------------------
  # �� �I�[�g�X�e�[�g�̍X�V
  #     old_armor : �O�����h��
  #     new_armor : ���������h��
  #--------------------------------------------------------------------------
  def update_auto_state(old_armor, new_armor)
    # �O�����h��̃I�[�g�X�e�[�g����������
    if old_armor != nil and old_armor.auto_state_id != 0
      remove_state(old_armor.auto_state_id, true)
    end
    # ���������h��̃I�[�g�X�e�[�g�������t��
    if new_armor != nil and new_armor.auto_state_id != 0
      add_state(new_armor.auto_state_id, true)
    end
  end
  #--------------------------------------------------------------------------
  # �� �����Œ蔻��
  #     equip_type : �����^�C�v
  #--------------------------------------------------------------------------
  def equip_fix?(equip_type)
    case equip_type
    when 0  # ����
      return $data_actors[@actor_id].weapon_fix
    when 1  # ��
      return $data_actors[@actor_id].armor1_fix
    when 2  # ��
      return $data_actors[@actor_id].armor2_fix
    when 3  # �g��
      return $data_actors[@actor_id].armor3_fix
    when 4  # �����i
      return $data_actors[@actor_id].armor4_fix
    end
    return false
  end
  #--------------------------------------------------------------------------
  # �� �����̕ύX
  #     equip_type : �����^�C�v
  #     id    : ���� or �h�� ID  (0 �Ȃ瑕������)
  #--------------------------------------------------------------------------
  def equip(equip_type, id)
    case equip_type
    when 0  # ����
      if id == 0 or $game_party.weapon_number(id) > 0
        $game_party.gain_weapon(@weapon_id, 1)
        @weapon_id = id
        $game_party.lose_weapon(id, 1)
      end
    when 1  # ��
      if id == 0 or $game_party.armor_number(id) > 0
        update_auto_state($data_armors[@armor1_id], $data_armors[id])
        $game_party.gain_armor(@armor1_id, 1)
        @armor1_id = id
        $game_party.lose_armor(id, 1)
      end
    when 2  # ��
      if id == 0 or $game_party.armor_number(id) > 0
        update_auto_state($data_armors[@armor2_id], $data_armors[id])
        $game_party.gain_armor(@armor2_id, 1)
        @armor2_id = id
        $game_party.lose_armor(id, 1)
      end
    when 3  # �g��
      if id == 0 or $game_party.armor_number(id) > 0
        update_auto_state($data_armors[@armor3_id], $data_armors[id])
        $game_party.gain_armor(@armor3_id, 1)
        @armor3_id = id
        $game_party.lose_armor(id, 1)
      end
    when 4  # �����i
      if id == 0 or $game_party.armor_number(id) > 0
        update_auto_state($data_armors[@armor4_id], $data_armors[id])
        $game_party.gain_armor(@armor4_id, 1)
        @armor4_id = id
        $game_party.lose_armor(id, 1)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �����\����
  #     item : �A�C�e��
  #--------------------------------------------------------------------------
  def equippable?(item)
    # ����̏ꍇ
    if item.is_a?(RPG::Weapon)
      # ���݂̃N���X�̑����\�ȕ���Ɋ܂܂�Ă���ꍇ
      if $data_classes[@class_id].weapon_set.include?(item.id)
        return true
      end
    end
    # �h��̏ꍇ
    if item.is_a?(RPG::Armor)
      # ���݂̃N���X�̑����\�Ȗh��Ɋ܂܂�Ă���ꍇ
      if $data_classes[@class_id].armor_set.include?(item.id)
        return true
      end
    end
    return false
  end
  #--------------------------------------------------------------------------
  # �� EXP �̕ύX
  #     exp : �V���� EXP
  #--------------------------------------------------------------------------
  def exp=(exp)
    @exp = [[exp, 9999999].min, 0].max
    text = ""
    @level_up_log = ""
    myname = self.name
    up_flag = false
    # ���x���A�b�v
    while @exp >= @exp_list[@level+1] and @exp_list[@level+1] > 0
      @level += 1
      text += "\065\067" #if up_flag
      text += "#{myname} reached Lv.#{@level.to_s}!"
      # �X�L���K��
      for j in $data_classes[@class_id].learnings
        if j[0] == @level
          if j[1] == 0
            learn_skill(j[2])
            text += "\065\067#{myname} learned #{$data_skills[j[2]].UK_name}!"
          else
            gain_ability(j[2])
            # ��\���f���͕\�����Ȃ�
            if $data_ability[j[2]].hidden == false
              text += "\065\067#{myname} got the �y#{$data_ability[j[2]].UK_name}�z trait!"
            end
          end
        end
      end
#      up_flag = true 
    end
    
    # ���x���_�E��
    while @exp < @exp_list[@level]
      @level -= 1
    end
    if text != ""
      @level_up_log = text
    end
    # ���݂� HP �� SP ���ő�l�𒴂��Ă�����C��
    @hp = [@hp, self.maxhp].min
    @sp = [@sp, self.maxsp].min
  end
  #--------------------------------------------------------------------------
  # �� ���x���̕ύX
  #     level : �V�������x��
  #--------------------------------------------------------------------------
  def level=(level)
    # �㉺���`�F�b�N
    level = [[level, $MAX_LEVEL].min, 1].max
    # EXP ��ύX
    self.exp = @exp_list[level]
  end
  #--------------------------------------------------------------------------
  # �� �X�L�����o����
  #     skill_id : �X�L�� ID
  #--------------------------------------------------------------------------
  def learn_skill(skill_id)
    if skill_id > 0 and not skill_learn?(skill_id, "ORIGINAL")
      @skills.push(skill_id)
      @skills.sort!
    end
  end
  #--------------------------------------------------------------------------
  # �� �X�L����Y���
  #     skill_id : �X�L�� ID
  #--------------------------------------------------------------------------
  def forget_skill(skill_id)
    @skills.delete(skill_id)
  end
  #--------------------------------------------------------------------------
  # �� �X�L���̏K���ςݔ���
  #     skill_id : �X�L�� ID
  #--------------------------------------------------------------------------
  def skill_learn?(skill_id, type = "ALL")
    # �퓬�����`�k�k�Ȃ�퓬���p�X�L����Ԃ�
    return battle_skills.include?(skill_id) if type == "ALL" and $game_temp.in_battle
    # �`�k�k�Ȃ�K�����Ă���S�X�L����Ԃ�
    return all_skills.include?(skill_id) if type == "ALL"
    # ����ȊO�Ȃ玩�͏K���݂̂̃X�L����Ԃ�
    return @skills.include?(skill_id)
  end
  #--------------------------------------------------------------------------
  # �� �X�L���̎g�p�\����
  #     skill_id : �X�L�� ID
  #--------------------------------------------------------------------------
  def skill_can_use?(skill_id)
    if not skill_learn?(skill_id)
      return false unless self.berserk == true
    end
    return super
  end
  #--------------------------------------------------------------------------
  # �� ���O�̕ύX
  #     name : �V�������O
  #--------------------------------------------------------------------------
  def name=(name)
    @name = name
  end
  #--------------------------------------------------------------------------
  # �� �D���x�̕ύX
  #     love : �V�����D���x
  #--------------------------------------------------------------------------
  def love=(love)
    if self.have_ability?("����")
      @love = [[love, 150].min, 0].max
    else
      @love = [[love, $MAX_LOVE].min, 0].max
    end
  end
  #--------------------------------------------------------------------------
  # �� �_��̎�̕ύX
  #     promise : �V�����_��̎�
  #--------------------------------------------------------------------------
  def promise=(promise)
    @promise = [[promise, 999999].min, 0].max
  end
  #--------------------------------------------------------------------------
  # �� �N���X ID �̕ύX
  #     class_id : �V�����N���X ID
  #--------------------------------------------------------------------------
  def class_id=(class_id)
    if $data_classes[class_id] != nil
      @class_id = class_id
      # �����ł��Ȃ��Ȃ����A�C�e�����O��
      unless equippable?($data_weapons[@weapon_id])
        equip(0, 0)
      end
      unless equippable?($data_armors[@armor1_id])
        equip(1, 0)
      end
      unless equippable?($data_armors[@armor2_id])
        equip(2, 0)
      end
      unless equippable?($data_armors[@armor3_id])
        equip(3, 0)
      end
      unless equippable?($data_armors[@armor4_id])
        equip(4, 0)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �O���t�B�b�N�̕ύX
  #     character_name : �V�����L�����N�^�[ �t�@�C����
  #     character_hue  : �V�����L�����N�^�[ �F��
  #     battler_name   : �V�����o�g���[ �t�@�C����
  #     battler_hue    : �V�����o�g���[ �F��
  #--------------------------------------------------------------------------
  def set_graphic(character_name, character_hue, battler_name, battler_hue)
    @character_name = character_name
    @character_hue = character_hue
    @battler_name = battler_name
    @battler_hue = battler_hue
  end
  #--------------------------------------------------------------------------
  # �� �o�g����� X ���W�̎擾
  #--------------------------------------------------------------------------
  def screen_x
    # �p�[�e�B���̕��я����� X ���W���v�Z���ĕԂ�
    if self.index != nil
      return self.index * 160 + 80
    else
      return 0
    end
  end
  #--------------------------------------------------------------------------
  # �� �o�g����� Y ���W�̎擾
  #--------------------------------------------------------------------------
  def screen_y
    return 464
  end
  #--------------------------------------------------------------------------
  # �� �o�g����� Z ���W�̎擾
  #--------------------------------------------------------------------------
  def screen_z
    # �p�[�e�B���̕��я����� Z ���W���v�Z���ĕԂ�
    if self.index != nil
      return 4 - self.index
    else
      return 0
    end
  end
  #--------------------------------------------------------------------------
  # �� �����x �̕ύX
  #--------------------------------------------------------------------------
  def fed
    return [[@fed, 0].max, 100].min
  end
  #---------------------------------------------------------------------------- 
  # �� �����x�̌���
  #----------------------------------------------------------------------------
  def fed_down
    if self != $game_actors[101]
      @fed -= self.digest
      if @fed <= 20 and not self.state?(15)
        $game_temp.hungry = true
        self.add_state(15)
        text = "#{@name}\n seems to be hungry again..."
        SR_Util.announce(text)
      end
      if @fed <= 0
        $game_temp.vs_actors.push(self)
        @vs_me = true
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �����N�A�b�v
  #--------------------------------------------------------------------------
  def rank_up
    # �N���X�̖��O���̂܂܂Ȃ�t���O�𗧂Ă�B
    name_flag = @name == $data_classes[@class_id].name ? true :false
    # �����N�A�b�v����
    @class_id = $data_SDB[self.class_id].next_rank_id
    self.set_graphic($data_SDB[self.class_id].graphics,0,$data_SDB[self.class_id].graphics,0)
    @name = $data_classes[@class_id].name if name_flag == true
    # �����N�A�b�v������
    @skills.delete(249)
    
    # �X�L���K��
    for j in $data_classes[@class_id].learnings
      if j[0] <= @level
        if j[1] == 0
          learn_skill(j[2])
        else
          gain_ability(j[2])
        end
      end
    end
    # �C���v�A�S�u�����ȊO���y�������̘A�g�z��f�Ŏ����Ă���ꍇ�A
    # �y�������̓����z�ɕύX����B�i�ꉞ�t���ݒ�j
    unless petit_devil_link?($data_SDB[self.class_id])
      if self.have_ability?("�������̘A�g", "ORIGINAL")
        self.remove_ability(81)
        self.gain_ability(82)
      end
    else
      if self.have_ability?("�������̓���", "ORIGINAL")
        self.remove_ability(82)
        self.gain_ability(81)
      end
    end
    # �f�t�H�ď̂�ݒ�
    @defaultname_self = nil
    @defaultname_hero = nil
    $msg.defaultname_select(self)    
  end
  #--------------------------------------------------------------------------
  # �� �����x �̑���
  #--------------------------------------------------------------------------
  def fed=(fed)
    @fed = fed
    @fed = [[@fed, 100].min, 0].max
    if @fed > 20 and self.state?(15)
      self.remove_state(15)
      # �퓬���ɉ񕜂����ꍇ�̓��O���o��
      if $game_temp.in_battle
        self.remove_states_log.delete($data_states[15])
        text = "\065\n#{self.name}'s hunger has been satiated!"
        $game_temp.battle_log_text += text
      end
    end 
  end
  #----------------------------------------------------------------
  # �� �K�����Z�b�g
  #----------------------------------------------------------------
  def learn_reset(type = 0)
    skills_box    = []
    abilities_box = []
    if type == 0
      # �_��̎�ŏK���ł�����͕̂ێ�
      for bonus in $data_classes[self.class_id].bonus
        case bonus[1]
        when 0 # �X�L��
          if self.skill_learn?(bonus[2],"ORIGINAL")
            skills_box.push(bonus[2])
          end
        when 1 # �f��
          if self.have_ability?(bonus[2],"ORIGINAL")
            abilities_box.push(bonus[2])
          end
        end
      end
    end
    # �ێ��������f����ێ�
    keep_ability = []
    for i in 1..61 # ��_���̐�V�f���͕ێ�
      keep_ability.push(i)
    end
    for i in 301..400 # �z�[���h�X�L���K���f�����ێ�
      keep_ability.push(i)
    end
    for keep in keep_ability
      if self.have_ability?(keep,"ORIGINAL")
        abilities_box.push(keep)
      end
    end
    abilities_box.uinq! # �d��������
    # ���t���b�V��������
    self.skills = skills_box.sort
    self.ability = abilities_box.sort
    # �z�[���h�X�L���K���f���������Ă���ꍇ�A������đ��U
    for skill_id in self.skills
      case skill_id
      when 5  # �V�F���}�b�`
        self.gain_ability(303)
      when 6  # �C���T�[�g 
        self.gain_ability(301) 
      when 16 # �h���E�l�N�^�[
        self.gain_ability(306)
      when 17 # �G���u���C�X
        self.gain_ability(305)
      when 18 # �G�L�T�C�g�r���[
        self.gain_ability(304)
      end
    end
    #���x���тɉ����ăX�L�����Ď擾
    for i in 1..self.level
      for j in $data_classes[self.class_id].learnings
        if j[0] == i
          if j[1] == 0
            learn_skill(j[2])
          else
            gain_ability(j[2])
          end
        end
      end
    end
  end
end