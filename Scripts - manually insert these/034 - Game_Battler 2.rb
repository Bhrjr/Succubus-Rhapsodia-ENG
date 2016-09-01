#==============================================================================
# �� Game_Battler (������` 2)
#------------------------------------------------------------------------------
# �@�o�g���[�������N���X�ł��B���̃N���X�� Game_Actor �N���X�� Game_Enemy �N��
# �X�̃X�[�p�[�N���X�Ƃ��Ďg�p����܂��B
#==============================================================================

class Game_Battler
  #--------------------------------------------------------------------------
  # �� �{�X�p�̃O���t�B�b�N�H
  #--------------------------------------------------------------------------
  def boss_graphic?
    return @battler_name.include?("boss_")
  end
  #--------------------------------------------------------------------------
  # �� �N���X���̎擾
  #--------------------------------------------------------------------------
  def class_name
    return $data_classes[self.class_id].name
  end
  #--------------------------------------------------------------------------
  # �� �N��т̎擾
  #--------------------------------------------------------------------------
  def age
    return $data_SDB[self.class_id].years_type
  end
  #--------------------------------------------------------------------------
  # �� �N���X�F�̎擾
  #--------------------------------------------------------------------------
  def class_color
    return $data_classes[self.class_id].color
  end
  #--------------------------------------------------------------------------
  # �� �푰�̎擾(����̕ω�����������Ŕ������閲�����̊Ǘ��Ŏg�p)
  #--------------------------------------------------------------------------
  # ���푰
  def tribe
    return $data_SDB[self.class_id].name
  end
  #���l�ԑ�(���炩�ɖ����E�����łȂ����X)
  def tribe_human?
    case $data_SDB[self.class_id].name
    when "Little Witch","Witch ","Caster","Slave "
      return true
    when "Priestess ","Cursed Magus","Ramile","Hu��an"
      return true
    else
      return false
    end
  end
  #���X���C����(�����S�t)
  def tribe_slime?
    case $data_SDB[self.class_id].name
    when "Sli��e","Gold Sli��e ","Queen Sli��e"
      return true
    else
      return false
    end
  end
  #���K�[�S�C����(������)
  def tribe_gargoyle?
    return true if $data_SDB[self.class_id].name == "Gargoyle"
    return false
  end
  #���t�@�~���A��(����ɑ΂��Č������ς��)
  def tribe_familiar?
    return true if $data_SDB[self.class_id].name == "Familiar"
    return false
  end
  #���q�S��(�R�}���_�[�w���͈͂ƂȂ�B�C���v����O�I�Ɋ܂܂��)
  def tribe_gobrin?
    case $data_SDB[self.class_id].name
    when "Goblin","Goblin Leader ","I��p"
      return true
    else
      return false
    end
  end
  #--------------------------------------------------------------------------
  # �� ���T�C�Y�\���̎擾
  #--------------------------------------------------------------------------
  def bustsize
    bust = "��"
    case $data_SDB[self.class_id].bust_size
    when 0 #���E�N
      bust = "chest"
    when 1 #�`
      bust = "youthful breasts"
    when 2 #�a
      bust = "shapely breasts"
    when 3 #�b
      bust = "round breasts"
    when 4 #�c
      bust = "voluptuous breasts"
    when 5 #�d�ȏ�
      bust = "incredible breasts"
    end
    return bust
  end
  #--------------------------------------------------------------------------
  # �� ���ꔻ��
  #--------------------------------------------------------------------------
  # ���j�ł��邩�ǂ����̔���(�������E�N�݂̂�����ɍ��v)
  def boy?
    return false if self.have_ability?("��")
    return false if self.have_ability?("������L")
    return true if self.have_ability?("�j")
    return false
  end
  # ���ł��邩�ǂ����̔���(�����͌���������)
  def girl?
    return false if self.have_ability?("�j")
    return true if self.have_ability?("��")
    return false
  end
  # ������L���(�����̓�����)
  def futanari?
    return false if self.have_ability?("�j")
    return true if self.have_ability?("������L")
    return false
  end
  # �f�B���h�������ۂ��̔���
  def equip_dildo?
    return false if self.have_ability?("�j") #��l���͎��O�̂����邽��false
    return true if self.have_ability?("�C�N�C�b�v�f�B���h")
    return false
  end
  # �S�t���(�_���[�W�v�Z���Ɏg�p)
  def wet?
    return true if self.states.include?(27) #�S�t������
    return true if self.states.include?(28) #�S�t������
    return true if self.states.include?(29) #�X���C��
    return true if self.states.include?(31) #���[�V����
    return false
  end
  # �Ⓒ�ێ����(�ǌ����ω��Ɏg�p)
  def weaken?
    return true if self.states.include?(2) #����
    return true if self.states.include?(3) #�Ⓒ
    return false
  end
  # ��b�\���ۂ�(�g�[�N�ݒ�Ɏg�p)
  def talkable?
    return false if self.states.include?(2) #����
    return false if self.states.include?(3) #�Ⓒ
    return false if self.states.include?(34) #����
    return false if self.states.include?(36) #�\��
    return false if self.dead?
    return false unless self.exist?
    return true
  end
  #������Ԃ��ۂ�(���r���r���p)
  def excited?
    return true if self.states.include?(6)  #�N���C�V�X
    return true if self.states.include?(35) #�~��
    return true if self.states.include?(36) #�\��
    return true if self.states.include?(41) #���g
    return true if self.have_ability?("�T�f�B�X�g") and $mood.point > 30
    return false
  end
  #�z�[���h�����ۂ�(�����������ꂩ�̃z�[���h��ԂȂ�true)
  def holding?
    return true if self.hold.mouth.battler != nil
    return true if self.hold.tops.battler != nil
    return true if self.hold.penis.battler != nil
    return true if self.hold.vagina.battler != nil
    return true if self.hold.anal.battler != nil
    return true if self.hold.tail.battler != nil
    return true if self.hold.tentacle.battler != nil 
    return true if self.hold.dildo.battler != nil
    return false
  end
  #�A�N�V�����Ώۂƃz�[���h��Ԃ��ۂ�(�Ώۂ����Ȃ��ꍇ��false)
  def holding_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless self.holding?
    return true if self.hold.mouth.battler == target
    return true if self.hold.tops.battler == target
    return true if self.hold.penis.battler == target
    return true if self.hold.vagina.battler == target
    return true if self.hold.anal.battler == target
    return true if self.hold.tail.battler == target
    return true if self.hold.tentacle.battler == target
    return true if self.hold.dildo.battler == target
    return false
  end
  #���𒆂��ۂ�(�Q�ӏ��ȏ�̕��������z�[���h����Ă����true)
  def dancing?
    dc = 0
    dc += 1 if self.hold.mouth.battler != nil
    dc += 1 if self.hold.tops.battler != nil
    dc += 1 if self.hold.penis.battler != nil
    dc += 1 if self.hold.vagina.battler != nil
    dc += 1 if self.hold.anal.battler != nil
    dc += 1 if self.hold.tail.battler != nil
#    dc += 1 if self.hold.tentacle.battler != nil
    dc += 1 if self.hold.dildo.battler != nil
    dc -= 1 if self.hold.vagina.type == "�L���킹" #����A�̓�ӏ���L�̂���
    return true if dc >= 2
    return false
  end
  #�D�ʏ�Ԃ��ۂ�(�z�[���h��ԂłȂ��ꍇ��false)
  def initiative?
    return self.hold.initiative?
    # �ȉ��A�O�L�q�B
    # ���z�[���h����ĂȂ��ӏ������邾����true��Ԃ��悤�ɂȂ��Ă���B
=begin
    if self.holding?
      return true unless self.hold.penis.initiative == 0
      return true unless self.hold.mouth.initiative == 0
      return true unless self.hold.anal.initiative == 0
      return true unless self.hold.vagina.initiative == 0
      return true unless self.hold.tops.initiative == 0
      return true unless self.hold.tail.initiative == 0
      return true unless self.hold.dildo.initiative == 0
      return true unless self.hold.tentacle.initiative == 0
    end
    return false
=end
  end
  #�A�N�V�����Ώۂɑ΂��ėD�ʏ�Ԃ��ۂ�(�z�[���h��ԂłȂ��ꍇ��false)
  def initiative_now?
    if self.holding_now?
      return true unless self.hold.penis.initiative == 0
      return true unless self.hold.mouth.initiative == 0
      return true unless self.hold.anal.initiative == 0
      return true unless self.hold.vagina.initiative == 0
      return true unless self.hold.tops.initiative == 0
      return true unless self.hold.tail.initiative == 0
      return true unless self.hold.dildo.initiative == 0
      return true unless self.hold.tentacle.initiative == 0
    end
    return false
  end
  #�z�[���h�C�j�V�A�`�u�̒l�̍ő�l���Z�o
  def initiative_level
    unless self.holding?
      return 0
    else
      intv = intv2 = 0
      intv = self.hold.penis.initiative if self.hold.penis.initiative != nil
      intv2 = self.hold.mouth.initiative if self.hold.mouth.initiative != nil
      intv = intv2 if intv2 > intv
      intv2 = self.hold.vagina.initiative if self.hold.vagina.initiative != nil
      intv = intv2 if intv2 > intv
      intv2 = self.hold.anal.initiative if self.hold.anal.initiative != nil
      intv = intv2 if intv2 > intv
      intv2 = self.hold.tops.initiative if self.hold.tops.initiative != nil
      intv = intv2 if intv2 > intv
      intv2 = self.hold.tail.initiative if self.hold.tail.initiative != nil
      intv = intv2 if intv2 > intv
      intv2 = self.hold.dildo.initiative if self.hold.dildo.initiative != nil
      intv = intv2 if intv2 > intv
      intv2 = self.hold.tentacle.initiative if self.hold.tentacle.initiative != nil
      intv = intv2 if intv2 > intv
      return intv
    end
  end
  #�z�[���h�ʂ��Ƃ̃C�j�V�A�`�u���Z�o
  #�y�j�X
  def penis_intv
    return self.hold.penis.initiative
  end
  #�A�\�R
  def vagina_intv
    return self.hold.vagina.initiative
  end
  #��
  def mouth_intv
    return self.hold.mouth.initiative
  end
  #���K
  def anal_intv
    return self.hold.anal.initiative
  end
  #�㔼�g
  def tops_intv
    return self.hold.tops.initiative
  end
  #�K��
  def tail_intv
    return self.hold.tail.initiative
  end
  #�G��
  def tentacle_intv
    return self.hold.tentacle.initiative
  end
  #�f�B���h
  def dildo_intv
    return self.hold.dildo.initiative
  end
  #��Ԕ��f���\�b�h�ǉ�
  #�ΏۂƁ��C���T�[�g��Ԃ��ۂ�
  def inserting_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless (self.insert? and target.insert?)
    #�����́��ɑ}����
    if self.vagina_insert?
      return true if self.hold.vagina.battler == target
    else
      return true if self.hold.penis.battler == target
      return true if self.hold.tail.battler == target
      return true if self.hold.tentacle.battler == target
      return true if self.hold.dildo.battler == target
    end
    return false
  end
  #�Ώۂƌ��C���T�[�g��Ԃ��ۂ�
  def oralsex_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless (self.oralsex? and target.oralsex?)
    #�����̌��ɑ}����
    if self.mouth_oralsex?
      return true if self.hold.mouth.battler == target
    else
      return true if self.hold.penis.battler == target
      return true if self.hold.tail.battler == target
      return true if self.hold.tentacle.battler == target
      return true if self.hold.dildo.battler == target
    end
    return false
  end
  #�ΏۂƃA�i���C���T�[�g��Ԃ��ۂ�
  def analsex_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless (self.analsex? and target.analsex?)
    if self.anal_analsex?
      return true if self.hold.anal.battler == target
    else
      return true if self.hold.penis.battler == target
      return true if self.hold.tail.battler == target
      return true if self.hold.tentacle.battler == target
      return true if self.hold.dildo.battler == target
    end
    return false
  end
  #�ΏۂƃV�F���}�b�`��Ԃ��ۂ�
  def shellmatch_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless (self.shellmatch? and target.shellmatch?)
    return true if self.hold.vagina.battler == target
    return false
  end
  #�ΏۂƊ�ʋR���Ԃ��ۂ�
  def riding_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless (self.riding? and target.riding?)
    if self.vagina_riding?
      return true if self.hold.vagina.battler == target
    else
      return true if self.hold.mouth.battler == target
    end
    return false
  end
  #�ΏۂƖ�����Ԃ��ۂ�
  def binding_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless (self.bind? and target.bind?)
    #�g�̂Ŗ������̏ꍇ
    if self.tops_binder? or self.tops_binding?
      return true if self.hold.tops.battler == target
    elsif self.tentacle_binder?
      return true if self.hold.tentacle.battler == target
    else
      return true if self.hold.tops.battler == target
    end
    return false
  end
  #�Ώۂƃp�C�Y����Ԃ��ۂ�
  def paizuri_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless (self.paizuri? and target.paizuri?)
    if self.tops_paizuri?
      return true if self.hold.tops.battler == target
    else
      return true if self.hold.penis.battler == target
    end
    return false
  end
  #�ΏۂƃN���j��Ԃ��ۂ�
  def drawing_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless (self.draw? and target.draw?)
    if self.mouth_draw?
      return true if self.hold.mouth.battler == target
    elsif self.vagina_draw?
      return true if self.hold.vagina.battler == target
    elsif self.tentacle_draw?
      return true if self.hold.tentacle.battler == target
    elsif self.tentacle_vagina_draw?
      return true if self.hold.vagina.battler == target
    end
    return false
  end
  #�ΏۂƐG��z����Ԃ��ۂ�(��)
  def usetentacle_now?
    if $msg.t_enemy != nil and $msg.t_target != nil
      target = $msg.t_enemy if self.is_a?(Game_Actor)
      target = $msg.t_target if self.is_a?(Game_Enemy)
    elsif $game_temp.battle_target_battler[0] != nil
      target = $game_temp.battle_target_battler[0]
    else
      target = nil
    end
    return false if target == nil
    return false unless (self.tentacle_absorb? and target.tentacle_absorb?)
    if self.tentacle_absorbing?
      return true if self.hold.tentacle.battler == target
    elsif self.tentacle_penis_absorbing?
      return true if self.hold.penis.battler == target
    end
    return false
  end
  #���_�n�o�X�e���(�����A�~��A�\��)
  def badstate_mental?
    return true if self.states.include?(33) #�h�L�h�L
    return true if self.states.include?(34) #����
    return true if self.states.include?(35) #�~��
    return true if self.states.include?(36) #�\��
    return false
  end
  #���f�n�o�X�e���(���E�A�ؕ|�A��ჁA�U��)
  def badstate_curse?
    return true if self.states.include?(37) #���E
    return true if self.states.include?(38) #�ؕ|
    return true if self.states.include?(39) #���
    return true if self.states.include?(40) #�U��
    return false
  end
  #�����n�o�X�e���(���^�A�G��A�S����)
  def badstate_tool?
    #���݂͊Y���X�e�[�g���Ȃ��̂�false
    return false
  end
  #�p�����[�^�A�b�v���(�u�����n���@����)
  def param_up?
    correct = [55,56,59,60,63,64,67,68,71,72,75,76]
    for i in correct
      return true if self.states.include?(i)
    end
    return false
  end
  #�p�����[�^�_�E�����(�C�[�U�n���@����)
  def param_down?
    correct = [57,58,61,62,65,66,69,70,73,74,77,78]
    for i in correct
      return true if self.states.include?(i)
    end
    return false
  end
  #�s�X�g���n�z�[���h�ŐⒸ(�Ⓒ�R�����̉�ʗh�ꏈ���Ɏg�p)
  def shake_tate?
    return true if self.insert? and not self.vagina_insert?
    return true if self.oralsex?
    return true if self.mouth_draw?
    return true if self.mouth_riding?
    return true if self.mouth_hipriding?
    return true if self.tops_paizuri?
    return false
  end
  #�O���C���h�n�z�[���h�ŐⒸ(�Ⓒ�R�����̉�ʗh�ꏈ���Ɏg�p)
  def shake_yoko?
    return true if self.vagina_insert?
    return true if self.vagina_riding?
    return true if self.shellmatch?
    return true if self.anal_analsex?
    return true if self.anal_hipriding?
    return false
  end
  #���i�f�f(��Ɍ��㕪��Ɏg�p)
  def positive?
    case self.personality
    when "�����C","�Ӓn��","����","�D�F","�Â���","�ƑP"
      return true
    else
      return false
    end
  end
  def negative?
    case self.personality
    when "���C","�]��","�W��","����","��i"
      return true
    else
      return false
    end
  end
  def neutral?
    case self.personality
    when "�_�a","�z�C","�V�R","�s�v�c","�|��"
      return true
    else
      return false
    end
  end
  #--------------------------------------------------------------------------
  # �� �푰���̎擾
  #--------------------------------------------------------------------------
  def race_name
    return $data_classes[self.class_id].name
  end
  #--------------------------------------------------------------------------
  # �� �푰���̎擾
  #--------------------------------------------------------------------------
  def race_color
    return $data_classes[self.class_id].color
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�̌���
  #     state_id : �X�e�[�g ID
  #--------------------------------------------------------------------------
  def state?(state_id)
    # �Y������X�e�[�g���t������Ă���� true ��Ԃ�
    return @states.include?(state_id)
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�̕ϓ�����
  #     state_id : �X�e�[�g ID
  #--------------------------------------------------------------------------
  def chenge_state?(state_id)
    # �Y������X�e�[�g���t������Ă���� true ��Ԃ�
    return @states.include?(state_id) == @last_states.include?(state_id)
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g���t�����ǂ����̔���
  #     state_id : �X�e�[�g ID
  #--------------------------------------------------------------------------
  def state_full?(state_id)
    # �Y������X�e�[�g���t������Ă��Ȃ��� false ��Ԃ�
    unless self.state?(state_id)
      return false
    end
    # �����^�[������ -1 (�I�[�g�X�e�[�g) �Ȃ� true ��Ԃ�
    if @states_turn[state_id] == -1
      return true
    end
    # �����^�[���������R�����̍Œ�^�[�����Ɠ����Ȃ� true ��Ԃ�
    return @states_turn[state_id] == $data_states[state_id].hold_turn
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�̕t��
  #     state_id : �X�e�[�g ID
  #     force    : �����t���t���O (�I�[�g�X�e�[�g�̏����Ŏg�p)
  #--------------------------------------------------------------------------
  def add_state(state_id, force = false, ragistance = false)
    # �����ȃX�e�[�g�̏ꍇ
    if $data_states[state_id] == nil
      # ���\�b�h�I��
      return
    end
    # �����t���ł͂Ȃ��ꍇ
    unless force
      # �����̃X�e�[�g�̃��[�v
      for i in @states
        # �V�����X�e�[�g�������̃X�e�[�g�̃X�e�[�g�ω� (-) �Ɋ܂܂�Ă���A
        # ���̃X�e�[�g���V�����X�e�[�g�̃X�e�[�g�ω� (-) �ɂ͊܂܂�Ȃ��ꍇ
        # (ex : �퓬�s�\�̂Ƃ��ɓł�t�����悤�Ƃ����ꍇ)
        if $data_states[i].minus_state_set.include?(state_id) and
           not $data_states[state_id].minus_state_set.include?(i)
          # ���\�b�h�I��
          return
        end
      end
    end
    # ���̃X�e�[�g���t������Ă��Ȃ��ꍇ
    unless state?(state_id)

      # �ϐ��l���v�Z����ꍇ
      if ragistance == true
        per = self.state_percent(nil, state_id, nil)
        add_flag = false
        # �����`�F�b�N
        if rand(100) < per
          add_flag = true
        end
        # add_flag���U�̏ꍇ�̓��\�b�h���I��
        return if add_flag == false
      end
      
      # �X�e�[�g ID �� @states �z��ɒǉ�
      @states.push(state_id)
      # �퓬���̏ꍇ�A�t�^�X�e�[�g�����L�^
      if $game_temp.in_battle
        @add_states_log.push($data_states[state_id])
      end
      # �I�v�V���� [HP 0 �̏�ԂƂ݂Ȃ�] ���L���̏ꍇ
      if $data_states[state_id].zero_hp
        # HP �� 0 �ɕύX
        @hp = 0
        @sp = 0
      end
      # �S�X�e�[�g�̃��[�v
      for i in 1...$data_states.size
        # �X�e�[�g�ω� (+) ����
        if $data_states[state_id].plus_state_set.include?(i)
          add_state(i)
        end
        # �X�e�[�g�ω� (-) ����
        if $data_states[state_id].minus_state_set.include?(i)
          remove_state(i)
        end
      end
      
      # �j�ʂ͕�����ʂ�
      persona_break if state_id == 106
      
      # ���[�e�B���O�̑傫���� (���l�̏ꍇ�͐���̋�����) �ɕ��ёւ�
      @states.sort! do |a, b|
        state_a = $data_states[a]
        state_b = $data_states[b]
        if state_a.rating > state_b.rating
          -1
        elsif state_a.rating < state_b.rating
          +1
        elsif state_a.restriction > state_b.restriction
          -1
        elsif state_a.restriction < state_b.restriction
          +1
        else
          a <=> b
        end
      end
    end
    # �����t���̏ꍇ
    if force
      # ���R�����̍Œ�^�[������ -1 (����) �ɐݒ�
      @states_turn[state_id] = -1
    end
    # �����t���ł͂Ȃ��ꍇ
    unless  @states_turn[state_id] == -1
      # ���R�����̍Œ�^�[������ݒ�
      @states_turn[state_id] = $data_states[state_id].hold_turn
    end
    # �s���s�\�̏ꍇ
    unless movable?
      # �A�N�V�������N���A(���������C���X�e�[�g�t�^���̓X���[����)
      @current_action.clear unless state_id == 95
    end
    # HP ����� SP �̍ő�l�`�F�b�N
    @hp = [@hp, self.maxhp].min
    @sp = [@sp, self.maxsp].min
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�̉���
  #     state_id : �X�e�[�g ID
  #     force    : ���������t���O (�I�[�g�X�e�[�g�̏����Ŏg�p)
  #--------------------------------------------------------------------------
  def remove_state(state_id, force = false)
    # ���̃X�e�[�g���t������Ă���ꍇ
    if state?(state_id)
      # �����t�����ꂽ�X�e�[�g�ŁA�������������ł͂Ȃ��ꍇ
      if @states_turn[state_id] == -1 and not force
        # ���\�b�h�I��
        return
      end
      # ���݂� HP �� 0 ���� �I�v�V���� [HP 0 �̏�ԂƂ݂Ȃ�] ���L���̏ꍇ
      if @hp == 0 and $data_states[state_id].zero_hp
        # �ق��� [HP 0 �̏�ԂƂ݂Ȃ�] �X�e�[�g�����邩�ǂ�������
        zero_hp = false
        for i in @states
          if i != state_id and $data_states[i].zero_hp
            zero_hp = true
          end
        end
        # �퓬�s�\���������Ă悯��΁AHP �� 1 �ɕύX
        if zero_hp == false
          @sp = 1
        end
        if self.is_a?(Game_Actor)
          self.fed = 20 if self.fed == 0
        end
      end
      # �X�e�[�g ID �� @states �z�񂨂�� @states_turn �n�b�V������폜
      @states.delete(state_id)
      @states_turn.delete(state_id)
      # �퓬���̏ꍇ�A�����X�e�[�g�����L�^
      if $game_temp.in_battle
        @remove_states_log.push($data_states[state_id])
      end
    end
    # HP ����� SP �̍ő�l�`�F�b�N
    @hp = [@hp, self.maxhp].min
    @sp = [@sp, self.maxsp].min
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�̃A�j���[�V���� ID �擾
  #--------------------------------------------------------------------------
  def state_animation_id
    # �X�e�[�g���ЂƂ��t������Ă��Ȃ��ꍇ
    if @states.size == 0
      return 0
    end
    # ���[�e�B���O�ő�̃X�e�[�g�̃A�j���[�V���� ID ��Ԃ�
    return $data_states[@states[0]].animation_id
  end
  #--------------------------------------------------------------------------
  # �� ����̎擾
  #--------------------------------------------------------------------------
  def restriction
    restriction_max = 0
    # ���ݕt������Ă���X�e�[�g����ő�� restriction ���擾
    for i in @states
      if $data_states[i].restriction >= restriction_max
        restriction_max = $data_states[i].restriction
      end
    end
    return restriction_max
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g [EXP ���l���ł��Ȃ�] ����
  #--------------------------------------------------------------------------
  def cant_get_exp?
    for i in @states
      if $data_states[i].cant_get_exp
        return true
      end
    end
    return false
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g [�U��������ł��Ȃ�] ����
  #--------------------------------------------------------------------------
  def cant_evade?
    for i in @states
      if $data_states[i].cant_evade
        return true
      end
    end
    return false
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g [�X���b�v�_���[�W] ����
  #--------------------------------------------------------------------------
  def slip_damage?
    for i in @states
      if $data_states[i].slip_damage
        return true
      end
    end
    return false
  end
  #--------------------------------------------------------------------------
  # �� �o�g���p�X�e�[�g�̉��� (�o�g���I�����ɌĂяo��)
  #--------------------------------------------------------------------------
  def remove_states_battle
    for i in @states.clone
      if $data_states[i].battle_only
        remove_state(i)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g���R���� (�^�[�����ƂɌĂяo��)
  #--------------------------------------------------------------------------
  def remove_states_auto
    for i in @states_turn.keys.clone
      if @states_turn[i] > 0
        @states_turn[i] -= 1
      elsif rand(100) < $data_states[i].auto_release_prob
        remove_state(i)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�Ռ����� (�����_���[�W���ƂɌĂяo��)
  #--------------------------------------------------------------------------
  def remove_states_shock
    for i in @states.clone
      if rand(100) < $data_states[i].shock_release_prob
        remove_state(i)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�Ռ����� (�����_���[�W���ƂɌĂяo��)
  #--------------------------------------------------------------------------
  def remove_states_shock
    for i in @states.clone
      if rand(100) < $data_states[i].shock_release_prob
        remove_state(i)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�L���x�̎擾
  #--------------------------------------------------------------------------
  def state_percent(user = nil, state_id = 1, skill = nil)
    state_name = $data_states[state_id].name
    # �m��t���O�������� (1:�m��t�^ 2:�m�薳��)
    absolute_flag = 0
    # ����{���������擾
    if self.is_a?(Game_Enemy)
      # �G�l�~�[�̏ꍇ�A�L���x���Q��
      # �� A:100%(�K��) / B:80% / C:60% / D:40% / E:20% / F:0%(����)
      plus = [100,100,20,0,-20,-50,-100][self.state_ranks[state_id]]
      # �y�X�L���̖��@�h��L���x=�X�L���̃X�e�[�g�t�^�����s����m���̍����z
      if skill != nil
        effect_percent = skill.mdef_f + plus
      else
        effect_percent = 50 + plus
      end
      # �L���x���`�A�܂��͖��@�h��L���x100�̏ꍇ�K���ƌ��Ȃ�
      if self.state_ranks[state_id] == 1 or (skill != nil and skill.mdef_f == 100)
        absolute_flag = 1
      end
      # �L���x���e�A�܂��͖��@�h��L���x0�̏ꍇ�����ƌ��Ȃ�
      if self.state_ranks[state_id] == 6 or (skill != nil and skill.mdef_f == 0)
        absolute_flag = 2
      end
    elsif self.is_a?(Game_Actor)
      # �A�N�^�[�̏ꍇ�A�X�L���́y���@�h��L���x���Q�Ɓz(�d�v)
      # ���A�N�^�[���g�̖��@�h��͎Q�Ƃ���Ȃ�
      # �y�X�L���̖��@�h��L���x=�X�L���̃X�e�[�g�t�^�����s����m���̍����z
      if skill != nil
        effect_percent = skill.mdef_f
      else
        effect_percent = 50
      end
      # �L���x100�̏ꍇ�K���ƌ��Ȃ�
      absolute_flag = 1 if effect_percent == 100
      # �L���x0�̏ꍇ�����ƌ��Ȃ�
      absolute_flag = 2 if effect_percent == 0
    end

    n = m = 0
    if skill != nil
      # ���X�e�[�^�X�ɂ��␳
      if skill.element_set.include?(44) #���͂��l������ꍇ
        n = (user.atk / 10).floor
      elsif skill.element_set.include?(45) #��p�����l������ꍇ
        n = (user.dex / 10).floor
      elsif skill.element_set.include?(46) #���_�͂��l������ꍇ
        n = (user.int / 10).floor
      end
      m = (self.int / 10).floor #�h�䑤�͈ꊇ�Ő��_���g�p
    end
    effect_percent = effect_percent + n - m
    
    # �f���E�����i�Ȃǂ̑ϐ��l���v�Z
    registance = self.state_registance(state_id)
    registance_perpercent = registance[0]
    registance_flag       = registance[1]
    
    effect_percent *= registance_perpercent
    effect_percent = effect_percent.truncate
    absolute_flag = registance_flag if absolute_flag == 0
    
    if skill != nil
      # ���f����X�e�[�g�ɂ��␳
      # ���@�n�𖳌�������y�v���e�N�V�����z
      if self.have_ability?("�v���e�N�V����")
        if skill.element_set.include?(5)
          absolute_flag = 2
        end
      end
      # �E�q�n�𖳌�������y�Ɖu�́z
      if self.have_ability?("�Ɖu��")
        if skill.element_set.include?(206)
          absolute_flag = 2
        end
      end
    end
    
    # �h�䒆�͕t�^�������A��h�䒆�͒��ڕt�^�ȊO�𖳌�������
    if self.states.include?(94) #��h��
      # �L���X�e�[�g�̑��݂����邽�߁A�m��t���O�ł͂Ȃ�-999�ŕԂ�
      absolute_flag = -999 
    elsif self.states.include?(93) #�h��
      effect_percent /= 2
    end
    return 100 if absolute_flag == 1
    return 0   if absolute_flag == 2
    return effect_percent
  end

  #--------------------------------------------------------------------------
  # �� �X�e�[�g������
  #--------------------------------------------------------------------------
  def state_registance(state_id)
    result = 100
    absolute_flag = 0 # 0:�ʏ�, 1:�m��ŕt��, 2:�m��ŕt���Ȃ�
    
    # �����m���̂��߁A�ϐ���t����ꍇ��100�����猸�Z����
    
    # �ϐ����[���̑ϐ��l
    rune_registance = 40
    # �ϐ��f���̑ϐ��l
    ability_registance = 75
    # �ʉԊ����̑S�ϐ��l
    flower_roll_registance = 50
    # ��C�T���r�̑S�ϐ��l
    lonely_wolf_registance = 50
    # �Ɛ�~�̑S�ϐ��l
    monopolize_registance = 50
    
    # ���ŁE�����E�~��E�\���E���E�E�ؕ|�E��ჁE�U��
    if SR_Util.bad_states.include?(state_id)
      
      # ������
      if self.is_a?(Game_Actor)
        result -= flower_roll_registance if self.flower_roll_display?
        result -= lonely_wolf_registance if self.lonely_wolf?
        result -= monopolize_registance if self.monopolize?
        result -= rune_registance if self.equip?("���G�̃��[��")
        result -= 10 if self.equip?("�傫�ȃ��{��")
        result -= rivise_rate_dish("��Ԉُ�ϐ�", true)
      end
      result -= 50 if self.state?(101) # �j��
      result -= 50 if $game_temp.in_battle and $incense.exist?("�}�C���h�p�t���[��", self)
      result += 50 if $game_temp.in_battle and $incense.exist?("�X�g�����W�X�|�A", self) and not self.have_ability?("�Ɖu��")
      absolute_flag = 2 if self.have_ability?("�m�ł��鎩���S")
      
      case state_id
      # ����
      when 30
        result -= 50 if self.have_ability?("�Ɖu��")
      # ����
      when 34
        if self.is_a?(Game_Actor)
          result -= 25 if self.equip?("���Â̎�����")
          result -= 50 if self.equip?("��x�̃u���[�`")
          result -= 50 if self.equip?("���̃u���[�`")
          result -= rune_registance if self.equip?("�ӎ��̃��[��")
          absolute_flag = 2 if self.equip?("���ׂ銥") and not $game_switches[79] == true
          absolute_flag = 2 if self.equip?("���ς̃G���u����") and not $game_switches[79] == true
        end
      # �~��
      when 35
        if self.is_a?(Game_Actor)
          result -= 25 if self.equip?("���Â̎�����")
          result -= 50 if self.equip?("�܂̌���")
          result -= 75 if self.equip?("�i���̃J���I")
          result -= rune_registance if self.equip?("�}���̃��[��")
        end
      # �\��
      when 36
        result -= ability_registance if self.have_ability?("����")
        if self.is_a?(Game_Actor)
          result -= 25 if self.equip?("���Â̎�����")
          result -= 50 if self.equip?("�܂̌���")
          result += 100 if self.equip?("��؂Ȏ҂̎��")
          result -= 50 if self.equip?("�E�C�̃T�[�N���b�g")
          result += 100 if self.equip?("���\��")
          result -= rune_registance if self.equip?("�����̃��[��")
          absolute_flag = 2 if self.equip?("�����̃��U���I") and not $game_switches[79] == true
        end
      # ���E
      when 37
        result -= ability_registance if self.have_ability?("���C")
        if self.is_a?(Game_Actor)
          result -= 75 if self.equip?("�n�[�g�̃s�A�X")
          result -= 75 if self.equip?("�򑐂̊�")
          result -= 50 if self.equip?("�M�O�̃h�b�O�^�O")
          result -= rune_registance if self.equip?("���C�̃��[��")
          absolute_flag = 2 if self.equip?("���͂̉�") and not $game_switches[79] == true
        end
      # �ؕ|
      when 38
        result -= ability_registance if self.have_ability?("�_��")
        if self.is_a?(Game_Actor)
          result -= 25 if self.equip?("���Â̎�����")
          result -= 75 if self.equip?("�⌕�̃A�~�����b�g")
          result -= 75 if self.equip?("�����̃A�~�����b�g")
          result -= 50 if self.equip?("�M�O�̃h�b�O�^�O")
          result -= 50 if self.equip?("�E�C�̃T�[�N���b�g")
          result -= rune_registance if self.equip?("�_�͂̃��[��")
        end
        absolute_flag = 2 if self.have_ability?("�m�ł��鎩���S")
      # ���
      when 39
        result -= ability_registance if self.have_ability?("�_��")
        if self.is_a?(Game_Actor)
          result -= 75 if self.equip?("�򑐂̊�")
          result -= 75 if self.equip?("�啉H�̃o�b�W")
          result -= rune_registance if self.equip?("�_��̃��[��")
          absolute_flag = 2 if self.equip?("���^�̃G���u����") and not $game_switches[79] == true
        end
      # �U��
      when 40
        result -= ability_registance if self.have_ability?("��S")
        if self.is_a?(Game_Actor)
          result -= 25 if self.equip?("���Â̎�����")
          result -= 75 if self.equip?("���̃s�A�X")
          result -= 75 if self.equip?("�򑐂̊�")
          result -= rune_registance if self.equip?("��S�̃��[��")
        end
      end
    end
    # �ϐ��l�̉�����������߂�
    result = [[result,1000].min,0].max
    # �ϐ��l�̓p�[�Z���g�ŕԂ�����100.0�Ŋ���B
    result /= 100.0
    # �Ԃ�
    return [result, absolute_flag]
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�ω� (+) �̓K�p
  #     plus_state_set  : �X�e�[�g�ω� (+)
  #--------------------------------------------------------------------------
  def states_plus(user, plus_state_set, skill)
    # �L���t���O���N���A
    effective = false
    # ���[�v (�t������X�e�[�g)
    for i in plus_state_set
      # ���̃X�e�[�g���h�䂳��Ă��Ȃ��ꍇ
      unless self.state_guard?(i)
        # ���̃X�e�[�g���t���łȂ���ΗL���t���O���Z�b�g
        effective |= self.state_full?(i) == false
        # �X�e�[�g�� [��R���Ȃ�] �̏ꍇ
        if $data_states[i].nonresistance
          # �X�e�[�g�ω��t���O���Z�b�g
          @state_changed = true
          # �X�e�[�g��t��
          add_state(i)
        # ���̃X�e�[�g���t���ł͂Ȃ��ꍇ
        elsif self.state_full?(i) == false
          # �����Ƃ̔�r���s���A���m����0%�łȂ������ꍇ�t���O�𗧂Ă�
          @hit_able = true if self.state_percent(user, i, skill) > 0
          percent_set = self.state_percent(user, i, skill)
          # �X�e�[�g�L���x���m���ɕϊ����A�����Ɣ�r
          if rand(100) < percent_set
            # �X�e�[�g�ω��t���O���Z�b�g
            @state_changed = true
            # �X�e�[�g��t��
            add_state(i)
          end
        end
      end
    end
    # ���\�b�h�I��
    return effective
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�ω� (-) �̓K�p
  #     minus_state_set : �X�e�[�g�ω� (-)
  #--------------------------------------------------------------------------
  def states_minus(minus_state_set)
    # �L���t���O���N���A
    effective = false
    # ���[�v (��������X�e�[�g)
    for i in minus_state_set
      # ���̃X�e�[�g���t������Ă���ΗL���t���O���Z�b�g
      effective |= self.state?(i)
      # �X�e�[�g�ω��t���O���Z�b�g
      @state_changed = true
      # �X�e�[�g������
      remove_state(i)
    end
    # ���\�b�h�I��
    return effective
  end
  #--------------------------------------------------------------------------
  # �� ��_��˂��Ă��邩�ۂ��̔���
  #    skill_id : �X�L�� ID
  #--------------------------------------------------------------------------
  def weakpoint?(skill)
    return true if self.have_ability?("�����Ɏア") and self.insert? and skill.element_set.include?(74) and skill.element_set.include?(97)
    return true if self.have_ability?("�����Ɏア") and self.insert? and skill.element_set.include?(75) and skill.element_set.include?(95)
    return true if self.have_ability?("�����Ɏア") and self.insert? and skill.element_set.include?(78) and skill.element_set.include?(97)
    return true if self.have_ability?("�����Ɏア") and self.insert? and skill.element_set.include?(79) and skill.element_set.include?(97)
    return true if self.have_ability?("�����Ɏア") and self.insert? and skill.element_set.include?(81) and skill.element_set.include?(97)
    return true if self.have_ability?("��U�߂Ɏア") and skill.element_set.include?(71)
    return true if self.have_ability?("���U�߂Ɏア") and skill.element_set.include?(72)
    return true if self.have_ability?("���U�߂Ɏア") and skill.element_set.include?(73)
    return true if self.have_ability?("���A�U�߂Ɏア") and skill.element_set.include?(75)
    return true if self.have_ability?("�n�s�U�߂Ɏア") and not self.analsex? and (skill.element_set.include?(76) or skill.element_set.include?(77) or skill.element_set.include?(85))
    return true if self.have_ability?("�ٌ`�U�߂Ɏア") and (skill.element_set.include?(78) or skill.element_set.include?(79))
    return true if self.have_ability?("��s�Ɏア") and self.analsex? and skill.element_set.include?(74) and skill.element_set.include?(94)
    return true if self.have_ability?("��s�Ɏア") and self.analsex? and skill.element_set.include?(78) and skill.element_set.include?(94)
    return true if self.have_ability?("��s�Ɏア") and self.analsex? and skill.element_set.include?(79) and skill.element_set.include?(94)
    return true if self.have_ability?("��s�Ɏア") and self.analsex? and skill.element_set.include?(81) and skill.element_set.include?(94)
    return true if (self.have_ability?("����������") or self.have_ability?("���O")) and skill.element_set.include?(91)
    return true if (self.have_ability?("����������") or self.have_ability?("����")) and skill.element_set.include?(92)
    return true if (self.have_ability?("���K��������") or self.have_ability?("���K")) and skill.element_set.include?(93)
    return true if (self.have_ability?("�e����������") or self.have_ability?("����")) and skill.element_set.include?(94)
    return true if (self.have_ability?("���A��������") or self.have_ability?("����")) and skill.element_set.include?(97)
    return true if (self.have_ability?("�A�j��������") or self.have_ability?("���j")) and skill.element_set.include?(98)
    return false
  end
end
