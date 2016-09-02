#==============================================================================
# �� Game_Battler (������` 1)
#------------------------------------------------------------------------------
# �@�o�g���[�������N���X�ł��B���̃N���X�� Game_Actor �N���X�� Game_Enemy �N��
# �X�̃X�[�p�[�N���X�Ƃ��Ďg�p����܂��B
#==============================================================================

class Game_Battler
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_accessor :battler_name             # �o�g���[ �t�@�C����
  attr_reader   :battler_hue              # �o�g���[ �F��
  attr_reader   :hp                       # HP
  attr_reader   :sp                       # SP
  attr_accessor   :states                   # �X�e�[�g
  attr_accessor :level                    # ���x��
  attr_accessor :hidden                   # �B��t���O
  attr_accessor :immortal                 # �s���g�t���O
  attr_accessor :damage_pop               # �_���[�W�\���t���O
  attr_accessor :damage                   # �_���[�W�l
  attr_accessor :critical                 # �N���e�B�J���t���O
  attr_accessor :animation_id             # �A�j���[�V���� ID
  attr_accessor :animation_hit            # �A�j���[�V���� �q�b�g�t���O
  attr_accessor :white_flash              # ���t���b�V���t���O
  attr_accessor :white_flash_long         # �������t���b�V���t���O
  attr_accessor :blink                    # ���Ńt���O
  attr_accessor :change                   # ����㏀���p
  attr_accessor :add_states_log           # �t�����ꂽ�X�e�[�g�̃��O
  attr_accessor :remove_states_log        # �������ꂽ�X�e�[�g�̃��O
  attr_accessor :lub_male                 # �������x
  attr_accessor :lub_female               # �������x
  attr_accessor :lub_anal                 # �K�������x
  attr_accessor :personality              # ���i
  attr_accessor :ability                  # �f��
  attr_accessor :state_runk               # �f��
  attr_accessor :change_index             # ��シ��ꏊ
  attr_accessor :before_target            # ���������O�ɒǌ��𔭐��������Ώ�
  attr_accessor :crisis_flag              # �N���C�V�X��b�����t���O
  attr_accessor :love                     # �D���x
  attr_accessor :resist_count             # ���W�X�g�����񐔃`�F�b�N
  attr_accessor :ecstasy_count            # �Ⓒ����������̏��
  attr_accessor :ecstasy_turn             # �Ⓒ�^�[��
  attr_accessor :ecstasy_emotion          # �Ⓒ���̍s���G���[�V����
  attr_accessor :sp_down_flag             # VP�����ɂ�鎸�_�t���O
  attr_accessor :graphic_change           # �摜�ύX�t���O
  attr_accessor :checking                 # �`�F�b�N�����t���O
  #����g���p�e��t���O
  attr_accessor :bedin_count              # �x�b�h�C����
  attr_accessor :rankup_flag              # �����N�A�b�v�o���t���O
  attr_accessor :hold                     # �z�[���h�t���O
  attr_accessor :label                    # �ŗL���x���ݒ�p
  attr_accessor :defaultname_hero         # ���E�N�̊�{�ď�
  attr_accessor :nickname_master          # ���E�N�̓���ď�
  attr_accessor :defaultname_self         # �����̊�{�ď�
  attr_accessor :nickname_self            # �����̓���ď�
  attr_accessor :used_mouth               # ���o������e
  attr_accessor :used_anal                # ��������e
  attr_accessor :used_sadism              # ��s������e
  attr_accessor :another_action           # ���d�A�N�V�����p�t���O
  attr_accessor :marking_battler          # �}�[�L���O����
  attr_accessor :berserk                  # �\���t���O
  attr_accessor :pillowtalk               # ��b�t���O(�_�񔭓��U��)
  attr_accessor :talk_weak_check          # ��b��_�˂��t���O
  attr_accessor :lub_flag_male            # �������i�s�t���O
  attr_accessor :lub_flag_female          # �������i�s�t���O
  attr_accessor :lub_flag_anal            # �K�������i�s�t���O
  attr_accessor :earnest                  # �{�C�t���O
  attr_accessor :UK_name                  # $UKmode go!
  
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    @battler_name = ""
    @battler_hue = 0
    @hp = 0
    @sp = 0
    @states = []
    @last_states = []
    @states_turn = {}
    @maxhp_plus = 0
    @maxsp_plus = 0
    @str_plus = 0
    @dex_plus = 0
    @agi_plus = 0
    @int_plus = 0
    @hidden = false
    @immortal = false
    @damage_pop = false
    @damage = nil
    @critical = false
    @animation_id = 0
    @animation_hit = false
    @white_flash = false
    @blink = false
    @current_action = Game_BattleAction.new
    @change = -1
    @add_states_log = []
    @remove_states_log = []
    @lub_male = 0
    @lub_female = 0
    @lub_anal = 0
    @personality = "" 
    @ability = []
    @state_runk = []
    @change_index = []
    @before_target = ""
    @crisis_flag = false
    @love = 0
    @resist_count = 0
    @ecstasy_count = []
    @ecstasy_turn = 0
    @ecstasy_emotion = nil
    @sp_down_flag = false
    @graphic_change = false
    @checking = 0
    #����g���p�e��t���O
    @bedin_count = 0
    @rankup_flag = false
    @hold = Game_BattlerHold.new
    @label = []
    @nickname_master = nil
    @nickname_self = nil
    #���ꂼ��150���z����Ɗm���ŉ������󂯎n�߂�B
    @used_mouth = 0
    @used_anal = 0
    @used_sadism = 0
    @another_action = false
    @berserk = false
    @pillowtalk = 0
    @talk_weak_check = []
    @lub_flag_male = 0
    @lub_flag_female = 0
    @lub_flag_anal = 0
    @earnest = false
  end
  #--------------------------------------------------------------------------
  # �� MaxHP �̎擾
  #--------------------------------------------------------------------------
  def maxhp
    n = [[base_maxhp + @maxhp_plus, 1].max, 999999].min
    for i in @states
      n *= $data_states[i].maxhp_rate / 100.0
    end
    n = [[Integer(n), 1].max, 999999].min
    return n
  end
  #--------------------------------------------------------------------------
  # �� MaxSP �̎擾
  #--------------------------------------------------------------------------
  def maxsp
    n = [[base_maxsp + @maxsp_plus, 0].max, 9999].min
    for i in @states
      n *= $data_states[i].maxsp_rate / 100.0
    end
    # ��C�T���r
    n += 2000 if self.is_a?(Game_Actor) and lonely_wolf?
    # �Ɛ�~
    n += 300 if self.is_a?(Game_Actor) and monopolize?
    n += 1000 if self.is_a?(Game_Actor) and self.equip?("����̃��[��")
    n = [[Integer(n), 0].max, 9999].min
    return n
  end
  #--------------------------------------------------------------------------
  # �� �r�͂̎擾
  #--------------------------------------------------------------------------
  def str
    n = [[base_str + @str_plus, 1].max, 999].min
    for i in @states
      n *= $data_states[i].str_rate / 100.0
    end
    # �퓬���␳
    if $game_temp.in_battle
      # �C���Z���X�␳
      n = n * $incense.inc_adjusted_value(self, 2) / 100
      # �y���䖲���z�����̓N���C�V�X���ɐ��͂��P�D�T�{
      n = (n * 1.5).truncate if self.have_ability?("���䖲��") and self.crisis?
      # �y���\���z�����͖\�����ɐ��͂��P�D�T�{
      n = n * 2 if self.have_ability?("���\��") and self.state?(36)
    end
    n = [[Integer(n), 1].max, 999].min
    return n
  end
  #--------------------------------------------------------------------------
  # �� ��p���̎擾
  #--------------------------------------------------------------------------
  def dex
    n = [[base_dex + @dex_plus, 1].max, 999].min
    for i in @states
      n *= $data_states[i].dex_rate / 100.0
    end
    # �퓬���␳
    if $game_temp.in_battle
      # �C���Z���X�␳
      n = n * $incense.inc_adjusted_value(self, 3) / 100
    end
    n = [[Integer(n), 1].max, 999].min
    return n
  end
  #--------------------------------------------------------------------------
  # �� �f�����̎擾
  #--------------------------------------------------------------------------
  def agi
    n = [[base_agi + @agi_plus, 1].max, 999].min
    for i in @states
      n *= $data_states[i].agi_rate / 100.0
    end
    # �퓬���␳
    if $game_temp.in_battle
      # �C���Z���X�␳
      n = n * $incense.inc_adjusted_value(self, 4) / 100
      # �y�����z�����͒��ߎ��ɑf�������O�D�T�{
      n = (n * 0.5).truncate if self.have_ability?("����") and not self.nude?
    end
    n = [[Integer(n), 1].max, 999].min
    return n
  end
  #--------------------------------------------------------------------------
  # �� ���͂̎擾
  #--------------------------------------------------------------------------
  def int
    n = [[base_int + @int_plus, 1].max, 999].min
    for i in @states
      n *= $data_states[i].int_rate / 100.0
    end
    # �퓬���␳
    if $game_temp.in_battle
      # �C���Z���X�␳
      n = n * $incense.inc_adjusted_value(self, 5) / 100
      # �y���\���z�����͖\�����ɐ��_�͂��O�D�T�{
      n = n / 2 if self.have_ability?("���\��") and self.state?(36)
    end
    n = [[Integer(n), 1].max, 999].min
    return n
  end
  #--------------------------------------------------------------------------
  # �� MaxHP �̐ݒ�
  #     maxhp : �V���� MaxHP
  #--------------------------------------------------------------------------
  def maxhp=(maxhp)
    @maxhp_plus += maxhp - self.maxhp
    @maxhp_plus = [[@maxhp_plus, -9999].max, 9999].min
    @hp = [@hp, self.maxhp].min
  end
  #--------------------------------------------------------------------------
  # �� MaxSP �̐ݒ�
  #     maxsp : �V���� MaxSP
  #--------------------------------------------------------------------------
  def maxsp=(maxsp)
    @maxsp_plus += maxsp - self.maxsp
    @maxsp_plus = [[@maxsp_plus, -9999].max, 9999].min
    @sp = [@sp, self.maxsp].min
  end
  #--------------------------------------------------------------------------
  # �� HP�p�[�Z���e�[�W�̎擾
  #--------------------------------------------------------------------------
  def hpp
    return (self.hp * 100 / self.maxhp).round
  end
  #--------------------------------------------------------------------------
  # �� SP�p�[�Z���e�[�W�̎擾
  #--------------------------------------------------------------------------
  def spp
    return (self.sp * 100 / self.maxsp).round
  end
  #--------------------------------------------------------------------------
  # �� �r�͂̐ݒ�
  #     str : �V�����r��
  #--------------------------------------------------------------------------
  def str=(str)
    @str_plus += str - self.str
    @str_plus = [[@str_plus, -999].max, 999].min
  end
  #--------------------------------------------------------------------------
  # �� ��p���̐ݒ�
  #     dex : �V������p��
  #--------------------------------------------------------------------------
  def dex=(dex)
    @dex_plus += dex - self.dex
    @dex_plus = [[@dex_plus, -999].max, 999].min
  end
  #--------------------------------------------------------------------------
  # �� �f�����̐ݒ�
  #     agi : �V�����f����
  #--------------------------------------------------------------------------
  def agi=(agi)
    @agi_plus += agi - self.agi
    @agi_plus = [[@agi_plus, -999].max, 999].min
  end
  #--------------------------------------------------------------------------
  # �� ���͂̐ݒ�
  #     int : �V��������
  #--------------------------------------------------------------------------
  def int=(int)
    @int_plus += int - self.int
    @int_plus = [[@int_plus, -999].max, 999].min
  end
  #--------------------------------------------------------------------------
  # �� �������̎擾
  #--------------------------------------------------------------------------
  def hit
    n = 100
    for i in @states
      n *= $data_states[i].hit_rate / 100.0
    end
    return Integer(n)
  end
  #--------------------------------------------------------------------------
  # �� �U���͂̎擾
  #--------------------------------------------------------------------------
  def atk
    n = base_atk
    n += 10 if self.have_ability?("����")
    n += 10 if self.have_ability?("��؂Ȑl")
    for i in @states
      n *= $data_states[i].atk_rate / 100.0
    end
    # �퓬���␳
    if $game_temp.in_battle
      # �C���Z���X�␳
      n = n * $incense.inc_adjusted_value(self, 0) / 100
    end
    return Integer(n)
  end
  #--------------------------------------------------------------------------
  # �� �����h��̎擾
  #--------------------------------------------------------------------------
  def pdef
    n = base_pdef
    for i in @states
      n *= $data_states[i].pdef_rate / 100.0
    end
    # �퓬���␳
    if $game_temp.in_battle
      # �C���Z���X�␳
      n = n * $incense.inc_adjusted_value(self, 1) / 100
      # �y���\���z�����͖\�����ɔE�ϗ͂��O�D�T�{
      n = n / 2 if self.have_ability?("���\��") and self.state?(36)
    end
    # �y�����z�����͒��ߎ��ɔE�ϗ͂��P�D�T�{
    n = (n * 1.5).truncate if self.have_ability?("����") and not self.nude?
    return Integer(n)
  end
  #--------------------------------------------------------------------------
  # �� ���@�h��̎擾
  #--------------------------------------------------------------------------
  def mdef
    n = base_mdef
    for i in @states
      n *= $data_states[i].mdef_rate / 100.0
    end
    return Integer(n)
  end
  #--------------------------------------------------------------------------
  # �� ����C���̎擾
  #--------------------------------------------------------------------------
  def eva
    n = base_eva
    for i in @states
      n += $data_states[i].eva
    end
    return n
  end
  #--------------------------------------------------------------------------
  # �� HP �̕ύX
  #     hp : �V���� HP
  #--------------------------------------------------------------------------
  def hp=(hp)
    @hp = [[hp, maxhp].min, 0].max
  end
  #--------------------------------------------------------------------------
  # �� SP �̕ύX
  #     sp : �V���� SP
  #--------------------------------------------------------------------------
  def sp=(sp)
    @sp = [[sp, maxsp].min, 0].max
    if self.dead?
      add_state(1)
    else
      remove_state(1)
    end
  end
  #--------------------------------------------------------------------------
  # �� �����x �̕ύX
  #--------------------------------------------------------------------------
  def lub_male=(lub_male)
    @lub_male = [[lub_male, 100].min, 0].max
  end
  def lub_female=(lub_female)
    @lub_female = [[lub_female, 100].min, 0].max
  end
  def lub_anal=(lub_anal)
    @lub_anal = [[lub_anal, 100].min, 0].max
  end
  #--------------------------------------------------------------------------
  # �� �S��
  #--------------------------------------------------------------------------
  def recover_all
    @hp = maxhp
    @sp = maxsp
    for i in @states.clone
      remove_state(i)
    end
    if self.is_a?(Game_Actor)
      self.fed = 100
    end
  end
  
  #--------------------------------------------------------------------------
  # �� �J�����g�A�N�V�����̎擾
  #--------------------------------------------------------------------------
  def current_action
    return @current_action
  end
  #--------------------------------------------------------------------------
  # �� �A�N�V�����X�s�[�h�̌���
  #--------------------------------------------------------------------------
  def make_action_speed
    plus = 0
#    @current_action.speed = agi + rand(10 + agi / 4)
    # ���s�����Ƀ����_���v�f����AGI�Ŋm��
    @current_action.speed = agi
    #�f�B���C���󂯂Ă���ƍs�����x-999��
    if self.state?(13)
      @current_action.speed -= 999
    end
    #��Ⴢ��Ă���ƍs�����x��1/10��
    if self.state?(39)
      @current_action.speed /= 10
    end
    # �����ݎg�p���̃X�L�������ŏC����������
    if self.current_action.kind == 1
      #�搧�s������
      if $data_skills[self.current_action.skill_id].element_set.include?(29)
        plus += 9999
      end
      #�Œx�s������
      if $data_skills[self.current_action.skill_id].element_set.include?(214)
        plus -= 9999
      end
      #���������X�L���͎኱�����������i�v�j
      if $data_skills[self.current_action.skill_id].element_set.include?(10)
#        plus += 20
      end
      @current_action.speed += plus
    end
  end
  #--------------------------------------------------------------------------
  # �� �Ⓒ����
  #--------------------------------------------------------------------------
  def ecstasy?
    return ((@hp == 0 and not @immortal) or @sp_down_flag)
  end
  #--------------------------------------------------------------------------
  # �� �퓬�s�\����
  #--------------------------------------------------------------------------
  def dead?
    return (@sp == 0 and not @immortal and not @sp_down_flag)
  end
  #--------------------------------------------------------------------------
  # �� ���ݔ���
  #--------------------------------------------------------------------------
  def exist?
    return (not @hidden and (@sp > 0 or @immortal or @sp_down_flag))
  end
  #--------------------------------------------------------------------------
  # �� HP 0 ����
  #--------------------------------------------------------------------------
  def hp0?
    return (not @hidden and @hp == 0)
  end
  #--------------------------------------------------------------------------
  # �� �R�}���h���͉\����
  #--------------------------------------------------------------------------
  def inputable?
    return (not @hidden and restriction <= 1)
  end
  #--------------------------------------------------------------------------
  # �� �s���\����
  #--------------------------------------------------------------------------
  def movable?
    return (not @hidden and restriction < 4)
  end
  #--------------------------------------------------------------------------
  # �� �h�䒆����
  #--------------------------------------------------------------------------
  def guarding?
    return (@current_action.kind == 0 and @current_action.basic == 1)
  end
  #--------------------------------------------------------------------------
  # �� �x�~������
  #--------------------------------------------------------------------------
  def resting?
    return (@current_action.kind == 0 and @current_action.basic == 3)
  end
  #--------------------------------------------------------------------------
  # �� �N���C�V�X����(���ғ�)
  #--------------------------------------------------------------------------
  def crisis
    return
  end
  #--------------------------------------------------------------------------
  # �� �N���C�V�X����
  #--------------------------------------------------------------------------
  def crisis?
    return self.states.include?(6)
  end
  #--------------------------------------------------------------------------
  # �� ��������
  #--------------------------------------------------------------------------
  def half_nude?
    return self.states.include?(4)
  end
  #--------------------------------------------------------------------------
  # �� ���� + �}��������
  #--------------------------------------------------------------------------
  def insertable_half_nude?
    result = false
    if half_nude?
      condBitmapFile = @battler_name.clone()
      condBitmapFile += "_M"
      if RPG::Cache.battler_exist?(condBitmapFile)
        result = true
      end
    end
    return result
  end
  #--------------------------------------------------------------------------
  # �� ���� + �}���s����
  #--------------------------------------------------------------------------
  def uninsertable_half_nude?
    result = false
    if half_nude?
      condBitmapFile = @battler_name.clone()
      condBitmapFile += "_L"
      if RPG::Cache.battler_exist?(condBitmapFile)
        result = true
      end
    end
    return result
  end
  #--------------------------------------------------------------------------
  # �� �S������
  #--------------------------------------------------------------------------
  def full_nude?
    return self.states.include?(5)
  end
  #--------------------------------------------------------------------------
  # �� ������
  #--------------------------------------------------------------------------
  def nude?
    return (self.half_nude? or full_nude?)
  end
  #--------------------------------------------------------------------------
  # �� �}���\������
  #--------------------------------------------------------------------------
  def insertable_nude?
    return (self.insertable_half_nude? or full_nude?)
  end
  #--------------------------------------------------------------------------
  # �� �}������
  #--------------------------------------------------------------------------
  # ���}������i�����j
  def penis_insert?
    # �y�j�X������́u�A�\�R�v�Łu���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.penis.parts == "�A�\�R" and self.hold.penis.type == "���}��")
  end
  # ���}������i�K�����j
  def tail_insert?
    # �K��������́u�A�\�R�v�Łu���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.tail.parts == "�A�\�R" and self.hold.tail.type == "���}��")
  end
  # ���}������i�G�葤�j
  def tentacle_insert?
    # �G�肪����́u�A�\�R�v�Łu���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.tentacle.parts == "�A�\�R" and self.hold.tentacle.type == "���}��")
  end
  # ���}������i�f�B���h���j
  def dildo_insert?
    # �f�B���h������́u�A�\�R�v�Łu���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.dildo.parts == "�A�\�R" and self.hold.dildo.type == "�f�B���h���}��")
  end
  # ���}������i�����j
  # �C���T�[�g�悪���݂���ꍇ�A���ꂪtrue���Ƃ������Ƃ������ɂ���B
  def vagina_insert?
    # �A�\�R������́u�y�j�X�v�u�K���v�u�G��v�u�f�B���h�v�̂����ꂩ�ŁA
    #�u���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.vagina.parts == "�y�j�X" and self.hold.vagina.type == "���}��")
    #return (self.hold.vagina.parts == "�K��" and self.hold.vagina.type == "���}��")
    #return (self.hold.vagina.parts == "�G��" and self.hold.vagina.type == "���}��")
    #return (self.hold.vagina.parts == "�f�B���h" and self.hold.vagina.type == "���}��")
  end
  
  # �f�B���h���}������i�����j
  def dildo_vagina_insert?
    return (self.hold.vagina.parts == "�f�B���h" and self.hold.vagina.type == "�f�B���h���}��")
  end
  
  # ���}������i��������j
  def vagina_insert_special?
    return true if (self.hold.vagina.parts == "�K��" and self.hold.vagina.type == "���}��")
    return true if (self.hold.vagina.parts == "�G��" and self.hold.vagina.type == "���}��")
    return true if (self.hold.vagina.parts == "�f�B���h" and self.hold.vagina.type == "�f�B���h���}��")
    return false
  end
  # �������}������
  def insert?
    return true if self.penis_insert?
    return true if self.vagina_insert?
    return true if self.vagina_insert_special?
    return true if self.tail_insert?
    return true if self.tentacle_insert?
    return true if self.dildo_insert?
    return false
  end
  #--------------------------------------------------------------------------
  # �� ��������
  #--------------------------------------------------------------------------
  # ��������i�����j
  def penis_oralsex?
    # �y�j�X������́u���v�Łu���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.penis.parts == "��" and self.hold.penis.type == "���}��")
  end
  # ��������i�K�����j
  def tail_oralsex?
    # �K��������́u���v�Łu���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.tail.parts == "��" and self.hold.tail.type == "���}��")
  end
  # ��������i�G�葤�j
  def tentacle_oralsex?
    # �G�肪����́u���v�Łu���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.tentacle.parts == "��" and self.hold.tentacle.type == "���}��")
  end
  # �f�B���h��������i�f�B���h���j
  def dildo_oralsex?
    # �f�B���h������́u���v�Łu���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.dildo.parts == "��" and self.hold.dildo.type == "�f�B���h���}��")
  end
  # ��������i�����j
  # �C���T�[�g�悪���݂���ꍇ�A���ꂪtrue���Ƃ������Ƃ������ɂ���B
  def mouth_oralsex?
    # ��������́u�y�j�X�v�u�K���v�u�G��v�u�f�B���h�v�̂����ꂩ�ŁA
    #�u���}���v�ɂ��z�[���h����Ă����true
    return true if (self.hold.mouth.parts == "�y�j�X" and self.hold.mouth.type == "���}��")
    return false
  end
  # �f�B���h��������i�����j
  def dildo_mouth_oralsex?
    # �f�B���h������́u���v�Łu���}���v�ɂ��z�[���h����Ă����true
    return (self.hold.mouth.parts == "�f�B���h" and self.hold.mouth.type == "�f�B���h���}��")
  end
  # ��������i��������j
  # �C���T�[�g�悪���݂���ꍇ�A���ꂪtrue���Ƃ������Ƃ������ɂ���B
  def mouth_oralsex_special?
    return true if (self.hold.mouth.parts == "�K��" and self.hold.mouth.type == "���}��")
    return true if (self.hold.mouth.parts == "�G��" and self.hold.mouth.type == "���}��")
    return true if (self.hold.mouth.parts == "�f�B���h" and self.hold.mouth.type == "�f�B���h���}��")
    return false
  end
  # ������������
  def oralsex?
    return true if self.penis_oralsex?
    return true if self.mouth_oralsex?
    return true if self.tail_oralsex?
    return true if self.tentacle_oralsex?
    return true if self.dildo_oralsex?
    return true if self.mouth_oralsex_special?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �芭����
  #--------------------------------------------------------------------------
  # �芭����i�����j
  def penis_analsex?
    # �y�j�X������́u�A�i���v�Łu�K�}���v�ɂ��z�[���h����Ă����true
    return (self.hold.penis.parts == "�A�i��" and self.hold.penis.type == "�K�}��")
  end
  # �芭����i�K�����j
  def tail_analsex?
    # �K��������́u�A�i���v�Łu�K�}���v�ɂ��z�[���h����Ă����true
    return (self.hold.tail.parts == "�A�i��" and self.hold.tail.type == "�K�}��")
  end
  # �芭����i�G�葤�j
  def tentacle_analsex?
    # �G�肪����́u�A�i���v�Łu�K�}���v�ɂ��z�[���h����Ă����true
    return (self.hold.tentacle.parts == "�A�i��" and self.hold.tentacle.type == "�K�}��")
  end
  # �f�B���h�芭����i�f�B���h���j
  def dildo_analsex?
    # �f�B���h������́u�A�i���v�Łu�K�}���v�ɂ��z�[���h����Ă����true
    return (self.hold.dildo.parts == "�A�i��" and self.hold.dildo.type == "�f�B���h�K�}��")
  end
  # �芭����i�K���j
  # �C���T�[�g�悪���݂���ꍇ�A���ꂪtrue���Ƃ������Ƃ������ɂ���B
  def anal_analsex?
    # �A�i��������́u�y�j�X�v�u�K���v�u�G��v�u�f�B���h�v�̂����ꂩ�ŁA
    #�u�K�}���v�ɂ��z�[���h����Ă����true
    return (self.hold.anal.parts == "�y�j�X" and self.hold.anal.type == "�K�}��")
  end
  # �f�B���h�芭����i�K���j
  def dildo_anal_analsex?
    # �A�i��������́u�f�B���h�v�Łu�K�}���v�ɂ��z�[���h����Ă����true
    return (self.hold.anal.parts == "�f�B���h" and self.hold.anal.type == "�f�B���h�K�}��")
  end
  # �芭����i�K���j
  # �C���T�[�g�悪���݂���ꍇ�A���ꂪtrue���Ƃ������Ƃ������ɂ���B
  def anal_analsex?
    return true if (self.hold.anal.parts == "�K��" and self.hold.anal.type == "�K�}��")
    return true if (self.hold.anal.parts == "�G��" and self.hold.anal.type == "�G��K�}��")
    return true if (self.hold.anal.parts == "�f�B���h" and self.hold.anal.type == "�f�B���h�K�}��")
    return false
  end
  # �����芭����
  def analsex?
    return true if self.penis_analsex?
    return true if self.tail_analsex?
    return true if self.tentacle_analsex?
    return true if self.dildo_analsex?
    return true if self.anal_analsex?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �R�攻��
  #--------------------------------------------------------------------------
  # �R�攻��i�U�ߑ��j
  def vagina_riding?
    # �A�\�R������́u���v�Łu��ʋR��v�ɂ��z�[���h����Ă����true
    return (self.hold.vagina.parts == "��" and self.hold.vagina.type == "��ʋR��")
  end
  # �R�攻��i�󂯑��j
  def mouth_riding?
    # ��������́u�A�\�R�v�Łu��ʋR��v�ɂ��z�[���h����Ă����true
    return (self.hold.mouth.parts == "�A�\�R" and self.hold.mouth.type == "��ʋR��")
  end
  # �����R�攻��
  def riding?
    return true if self.vagina_riding?
    return true if self.mouth_riding?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �K�R�攻��
  #--------------------------------------------------------------------------
  # �K�R�攻��i�U�ߑ��j
  def anal_hipriding?
    # �A�i��������́u���v�Łu�K�R��v�ɂ��z�[���h����Ă����true
    return (self.hold.anal.parts == "��" and self.hold.anal.type == "�K�R��")
  end
  # �R�攻��i�󂯑��j
  def mouth_hipriding?
    # ��������́u�A�i���v�Łu�K�R��v�ɂ��z�[���h����Ă����true
    return (self.hold.mouth.parts == "�A�i��" and self.hold.mouth.type == "�K�R��")
  end
  # �����R�攻��
  def hipriding?
    return true if self.anal_hipriding?
    return true if self.mouth_hipriding?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �N���j����
  #--------------------------------------------------------------------------
  # �N���j����i�U�ߑ��j
  def mouth_draw?
    # ��������́u�A�\�R�v�Łu�N���j�v�ɂ��z�[���h����Ă����true
    return (self.hold.mouth.parts == "�A�\�R" and self.hold.mouth.type == "�N���j")
  end
  # �N���j����i�󂯑��j
  def vagina_draw?
    # �A�\�R������́u���v�Łu�N���j�v�ɂ��z�[���h����Ă����true
    return (self.hold.vagina.parts == "��" and self.hold.vagina.type == "�N���j")
  end
  # �N���j����i�U�ߑ��j
  def tentacle_draw?
    # ��������́u�A�\�R�v�Łu�N���j�v�ɂ��z�[���h����Ă����true
    return (self.hold.tentacle.parts == "�A�\�R" and self.hold.tentacle.type == "�G��N���j")
  end
  # �N���j����i�󂯑��j
  def tentacle_vagina_draw?
    # �A�\�R������́u���v�Łu�N���j�v�ɂ��z�[���h����Ă����true
    return (self.hold.vagina.parts == "�G��" and self.hold.vagina.type == "�G��N���j")
  end
  # �����N���j����
  def draw?
    return true if self.mouth_draw?
    return true if self.vagina_draw?
    return true if self.tentacle_draw?
    return true if self.tentacle_vagina_draw?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �f�B�[�v�L�b�X����
  #--------------------------------------------------------------------------
  # �f�B�[�v�L�b�X����(�󂯍U�߂œ������ʃz�[���h)
  def deepkiss?
    # ��������́u���v�Łu�L�b�X�v�ɂ��z�[���h����Ă����true
    return (self.hold.mouth.parts == "��" and self.hold.mouth.type == "�L�b�X")
  end
  #--------------------------------------------------------------------------
  # �� �L���킹����
  #--------------------------------------------------------------------------
  # �L���킹����(�󂯍U�߂œ������ʃz�[���h)
  def shellmatch?
    # �A�\�R������́u�A�\�R�v�Łu�L���킹�v�ɂ��z�[���h����Ă����true
    return (self.hold.vagina.parts == "�A�\�R" and self.hold.vagina.type == "�L���킹")
  end
  #--------------------------------------------------------------------------
  # �� �p�C�Y������
  #--------------------------------------------------------------------------
  # �p�C�Y������i�U�ߑ��j
  def tops_paizuri?
    # �㔼�g������́u�y�j�X�v�Łu�p�C�Y���v�ɂ��z�[���h����A�C�j�V�A�`�u���P�ȏ�Ȃ��true
    return (self.hold.tops.parts == "�y�j�X" and self.hold.tops.type == "�p�C�Y��" and self.hold.tops.initiative > 0)
  end
  # �p�C�Y������i�󂯑��j
  def penis_paizuri?
    # �㔼�g������́u�㔼�g�v�Łu�p�C�Y���v�ɂ��z�[���h����A�C�j�V�A�`�u���O�Ȃ��true
    return (self.hold.penis.parts == "�㔼�g" and self.hold.penis.type == "�p�C�Y��" and self.hold.penis.initiative == 0)
  end
  # �����p�C�Y������
  def paizuri?
    return true if self.tops_paizuri?
    return true if self.penis_paizuri?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �ςӂςӔ���
  #--------------------------------------------------------------------------
  # �ςӂςӔ���i�U�ߑ��j
  def tops_pahupahu?
    # �㔼�g������́u���v�Łu�ςӂςӁv�ɂ��z�[���h����A�C�j�V�A�`�u���P�ȏ�Ȃ��true
    return (self.hold.tops.parts == "��" and self.hold.tops.type == "�ςӂς�" and self.hold.tops.initiative > 0)
  end
  # �ςӂςӔ���i�󂯑��j
  def mouth_pahupahu?
    # �㔼�g������́u�㔼�g�v�Łu�p�C�Y���v�ɂ��z�[���h����A�C�j�V�A�`�u���O�Ȃ��true
    return (self.hold.mouth.parts == "�㔼�g" and self.hold.mouth.type == "�ςӂς�" and self.hold.mouth.initiative == 0)
  end
  # �����ςӂςӔ���
  def pahupahu?
    return true if self.tops_pahupahu?
    return true if self.mouth_pahupahu?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �S������
  #--------------------------------------------------------------------------
  # �S������i�U�ߑ��j
  def tops_binder?
    # �㔼�g������́u�㔼�g�v�Łu�S���v�ɂ��z�[���h����A�C�j�V�A�`�u���P�ȏ�Ȃ��true
    return (self.hold.tops.parts == "�㔼�g" and self.hold.tops.type == "�S��" and self.hold.tops.initiative > 0)
  end
  # �S������i�󂯑��j
  def tops_binding?
    # �㔼�g������́u�㔼�g�v�Łu�S���v�ɂ��z�[���h����A�C�j�V�A�`�u���O�Ȃ��true
    return (self.hold.tops.parts == "�㔼�g" and self.hold.tops.type == "�S��" and self.hold.tops.initiative == 0)
  end
  # �����S������
  def bind?
    return true if self.tops_binder?
    return true if self.tops_binding?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �G��S������
  #--------------------------------------------------------------------------
  # �S������i�G��U�ߑ��j
  def tentacle_binder?
    # �G�肪����́u�㔼�g�v�Łu�S���v�ɂ��z�[���h����Ă����true
    return true if (self.hold.tentacle.parts == "�㔼�g" and self.hold.tentacle.type == "�G��S��")
    return true if (self.hold.tentacle.parts == "�㔼�g" and self.hold.tentacle.type == "�ӍS��")
    return false
  end
  # �S������i�G��󂯑��j
  def tentacle_binding?
    # �G�肪����́u�G��v�Łu�S���v�ɂ��z�[���h����Ă����true
    return true if (self.hold.tops.parts == "�G��" and self.hold.tops.type == "�G��S��")
    return true if (self.hold.tops.parts == "�G��" and self.hold.tops.type == "�ӍS��")
    return false
  end
  # �����S������
  def tentacle_bind?
    return true if self.tentacle_binder?
    return true if self.tentacle_binding?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �G��z������
  #--------------------------------------------------------------------------
  # �z������i�G�葤�j
  def tentacle_absorbing?
    # �G�肪����́u�G��v�Łu�S���v�ɂ��z�[���h����Ă����true
    return (self.hold.tentacle.parts == "�y�j�X" and self.hold.tentacle.type == "�G��z��")
  end
  # �z������i�����j
  def tentacle_penis_absorbing?
    # �G�肪����́u�G��v�Łu�S���v�ɂ��z�[���h����Ă����true
    return (self.hold.penis.parts == "�G��" and self.hold.penis.type == "�G��z��")
  end
  # �����z������
  def tentacle_absorb?
    return true if self.tentacle_absorbing?
    return true if self.tentacle_penis_absorbing?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �J������
  #--------------------------------------------------------------------------
  # �J������i�U�ߑ��j
  def tops_openbinder?
    # �㔼�g������́u�㔼�g�v�Łu�J�r�v�ɂ��z�[���h����A�C�j�V�A�`�u���P�ȏ�Ȃ��true
    return (self.hold.tops.parts == "�㔼�g" and self.hold.tops.type == "�J�r" and self.hold.tops.initiative > 0)
  end
  # �S������i�󂯑��j
  def tops_openbinding?
    # �㔼�g������́u�㔼�g�v�Łu�J�r�v�ɂ��z�[���h����A�C�j�V�A�`�u���O�Ȃ��true
    return (self.hold.tops.parts == "�㔼�g" and self.hold.tops.type == "�J�r" and self.hold.tops.initiative == 0)
  end
  # �S������i�G�葤�j
  def tentacle_openbinder?
    # �G�肪����́u�㔼�g�v�Łu�J�r�v�ɂ��z�[���h����Ă����true
    return (self.hold.tentacle.parts == "�㔼�g" and self.hold.tentacle.type == "�J�r")
  end
  # �S������i�G�葤�j
  def tentacle_openbinding?
    # �G�肪����́u�G��v�Łu�J�r�v�ɂ��z�[���h����Ă����true
    return (self.hold.tops.parts == "�G��" and self.hold.tentacle.type == "�J�r")
  end
  # �����S������
  def openbind?
    return true if self.tops_openbinder?
    return true if self.tops_openbinding?
    return true if self.tentacle_openbinder?
    return true if self.tentacle_openbinding?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �{�C�}�����s���Ă��邩�̊m�F
  #--------------------------------------------------------------------------
  def earnest_insert?
    return true if self.earnest and self.vagina_insert?
    return true if self.earnest and self.penis_insert?
    return true if self.hold.penis.battler != nil and self.hold.penis.battler.earnest
    return true if self.hold.vagina.battler != nil and self.hold.vagina.battler.earnest
    return false
  end
  #--------------------------------------------------------------------------
  # �� �{�C�}���̊m�F�i�O���t�B�b�N�ύX�p�j
  #--------------------------------------------------------------------------
  def earnest_vagina_insert?
    return true if self.earnest and self.vagina_insert?
    return false
  end
  #--------------------------------------------------------------------------
  # �� �f������
  #    ability : �m�F����f���i�h�c�A������ǂ���ł��n�j�j
  #--------------------------------------------------------------------------
  def have_ability?(ability, type = "ALL")
    # �K�����Ă�����̂����m�F����
    n = ability
    # ������������̏ꍇ�AID�ɕϊ�����B
    n = $data_ability.search(0, ability) if ability.is_a?(String)
    # �S�m�F��ON�ŃA�N�^�[�̏ꍇ�A�S������m�F����i�f�t�H���g�j
    if type == "ALL" and self.is_a?(Game_Actor)
      return self.all_ability.include?(n)
    else
      return @ability.include?(n)
    end
  end
  #--------------------------------------------------------------------------
  # �� �f���K��
  #    ability : �K������f���i�h�c�A������ǂ���ł��n�j�j
  #--------------------------------------------------------------------------
  def gain_ability(ability)
    n = ability
    # ������������̏ꍇ�AID�ɕϊ�����B
    n = $data_ability.search(0, ability) if ability.is_a?(String)
    
    case n
    # ���g���K�����鎞�͒���������
    when $data_ability.search(0, "���g")
      remove_ability("����")
      
    # �������K�����鎞�͍��g������
    when $data_ability.search(0, "����")
      remove_ability("���g")
    end
    
    unless have_ability?(n, "ORIGINAL")
      @ability.push(n)
      @ability.sort!
    end
  end
  #--------------------------------------------------------------------------
  # �� �f������
  #    ability : ��������f���i�h�c�A������ǂ���ł��n�j�j
  #--------------------------------------------------------------------------
  def remove_ability(ability)
    n = ability
    # ������������̏ꍇ�AID�ɕϊ�����B
    n = $data_ability.search(0, ability) if ability.is_a?(String)

    if have_ability?(n, "ORIGINAL")
      @ability.delete(n)
      @ability.sort!
    end
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h�ݒ菈��
  #--------------------------------------------------------------------------
  def hold
    @hold = Game_BattlerHold.new if @hold == nil
    return @hold
  end
  def hold=(hold)
    @hold = Game_BattlerHold.new if @hold == nil
    @hold = hold
  end
  def hold_reset
    self.hold.mouth.set(nil, nil, nil, nil)
    self.hold.penis.set(nil, nil, nil, nil)
    self.hold.tops.set(nil, nil, nil, nil)
    self.hold.vagina.set(nil, nil, nil, nil)
    self.hold.anal.set(nil, nil, nil, nil)
    self.hold.tail.set(nil, nil, nil, nil)
    self.hold.tentacle.set(nil, nil, nil, nil)
  end
  #--------------------------------------------------------------------------
  # �� �N���C�V�X����
  #--------------------------------------------------------------------------
  
  #--------------------------------------------------------------------------
  # �� ���ߏ���
  #--------------------------------------------------------------------------
  def dress
    user = $game_temp.battle_active_battler
    for i in 4..5
      user.remove_state(i) if user.states.include?(i)
    end
  end
  #--------------------------------------------------------------------------
  # �� �E�ߏ���
  #--------------------------------------------------------------------------
  def undress
    user = $game_temp.battle_active_battler
    #���E���ɏ������򂪑��݂��閲���̓t���O���P�ɂ���
    undress_flag = 0
    #�����ɂ���āA�E�ߕ��@���ʂɐݒ肷��
    case $data_SDB[self.class_id].name
    #�i�C�g���A�̏ꍇ�u�A�N�^�[����E�߁v�u�A�N�^�[�������v�Ŕ��E���ɂȂ�
    #��������E�����ꍇ��ʏ펞�͓��ɕω����Ȃ�
    when "�i�C�g���A"
      unless user.is_a?(Game_Actor) and user.excited?
        #�����𖞂����Ȃ��ꍇ�̓t���O���P�ɂ���
        undress_flag = 1
      end
    end
    # ������ԁH
    if half_nude?
      # �S����Ԃɂ���
      self.add_state(5)
    # ���ߏ�ԁH
    elsif undress_flag == 0
      bmp_name = []
      bmp_name[0] = @battler_name + "_L"
      bmp_name[1] = @battler_name + "_M"
      if RPG::Cache.battler_exist?(bmp_name[0]) or
         RPG::Cache.battler_exist?(bmp_name[1])
        # ������Ԃɂ���
        self.add_state(4)
      else
        # �S����Ԃɂ���
        self.add_state(5)
      end
    else
      # �S����Ԃɂ���
      self.add_state(5)
    end
#    self.white_flash_long = true
#    Audio.se_play("Audio/SE/one28", 80, 100)
    # �E�߃A�j���[�V����������
    @animation_id = 104
    @animation_hit = true
    
  end

  #--------------------------------------------------------------------------
  # �� �}������
  #--------------------------------------------------------------------------
  

  #--------------------------------------------------------------------------
  # �� �}����������
  #--------------------------------------------------------------------------

  #--------------------------------------------------------------------------
  # �� �D���x�㏸����
  #--------------------------------------------------------------------------
  def like(plus=0)
    #�Ώۂ��G�l�~�[�łȂ�(�D���x�����݂��Ȃ�)�ꍇ�͖߂�
    return if self.is_a?(Game_Actor)
    #�D���x�㏸�O�Ə㏸����ׂ�
    point1 = self.friendly
    point2 = self.friendly + plus
    if point2 > point1
      friendly_animation_order(point2)
      self.friendly = self.friendly + plus
    end
  end
  #--------------------------------------------------------------------------
  # �� �D���x�A�j���w��
  #--------------------------------------------------------------------------
  def friendly_animation_order(point = self.friendly)
    case point
    #�D���x���V�O�z���̏ꍇ
    when 71..255
      @animation_id = 42
      @animation_hit = true
    #�D���x���R�O�`�V�O�̊Ԃ̏ꍇ
    when 30..70
      @animation_id = 41
      @animation_hit = true
    #�D���x���Q�X�ȉ��̏ꍇ(�}�C�i�X���܂�)
    else
      @animation_id = 40
      @animation_hit = true
    end
  end
  #--------------------------------------------------------------------------
  # �� ���t����
  #   point   0:�Ԃ����� 1:���o��
  #--------------------------------------------------------------------------
  def sperm(point)
    case point
    when 0 # �Ԃ�����
      self.add_state(9)
     when 1 # ���o��
      # �Ԃ���������Ă���ꍇ�͂Ԃ������L��������
      self.add_state(10)
    end
    
  end    

  #--------------------------------------------------------------------------
  # �� �N���C�V�X���������
  #--------------------------------------------------------------------------
  def crisis_graphic?
    if self.state?(6) or self.state?(11) or self.state?(2) or self.state?(3)
      return true
    elsif self.sp_down_flag
      return true
    end
    return false
  end
  #--------------------------------------------------------------------------
  # �� �Ⓒ��
  #--------------------------------------------------------------------------
  def ecstasy_count
    @ecstasy_count = [] if @ecstasy_count == nil
    return @ecstasy_count
  end
  #--------------------------------------------------------------------------
  # �� �}�[�L���O��ԁH
  #--------------------------------------------------------------------------
  def marking?
    return (self.marking_battler != nil and self.state?(99))
  end
  #--------------------------------------------------------------------------
  # �� �s���ςݏ�ԁH
  #--------------------------------------------------------------------------
  def actioned?
    if $game_temp.in_battle
      return !$scene.action_battlers.include?(self)
    else
      return false
    end
  end
  #--------------------------------------------------------------------------
  # �� ��Ԉُ�̐�
  #--------------------------------------------------------------------------
  def bad_state_number
    count = 0
    for i in SR_Util.bad_states
      count += 1 if self.state?(i)
    end
    return count
  end
  #--------------------------------------------------------------------------
  # �� �o�b�h�`�F�C���ł��邩�H
  #--------------------------------------------------------------------------
  def bad_chain?
    # �Q�ȏ�Ńo�b�h�`�F�C���B��
    return bad_state_number >= 2
  end
  #--------------------------------------------------------------------------
  # �� �����g���邩�H
  #--------------------------------------------------------------------------
  def can_use_leg?
    result = true
    result = false if $data_SDB[self.class_id].legless == true
    return result
  end
  #--------------------------------------------------------------------------
  # �� ���̑���̋��Ɏ肪�͂����H
  #--------------------------------------------------------------------------
  def can_reach_bust?(target)
    #--------------------------------------------------------------------------
    # �̐��I�ɕs��
    #--------------------------------------------------------------------------
    # ���}���E�����n�͗��ҕs��
    return false if self.hold.mouth.parts == "�y�j�X" and self.hold.mouth.battler == target
    return false if self.hold.penis.parts == "��" and self.hold.penis.battler == target
    return false if self.hold.mouth.parts == "�f�B���h" and self.hold.mouth.battler == target
    return false if self.hold.dildo.parts == "��" and self.hold.dildo.battler == target
    return false if self.hold.mouth.parts == "�A�\�R" and self.hold.mouth.battler == target
    return false if self.hold.vagina.parts == "��" and self.hold.vagina.battler == target
    #--------------------------------------------------------------------------
    return true
  end
  #--------------------------------------------------------------------------
  # �� ���̑���̔镔�Ɏ肪�͂����H
  #--------------------------------------------------------------------------
  def can_reach_secret?(target)
    #--------------------------------------------------------------------------
    # ����̔镔���z�[���h��ԂɂȂ��Ă���ꍇ�͕s��
    #--------------------------------------------------------------------------
    return false if target.hold.penis.battler != nil
    return false if target.hold.dildo.battler != nil
    return false if target.hold.vagina.battler != nil
=begin �V�b�N�X�i�C���̐��Ȃ�\�Ȃ̂ŃR�����g�A�E�g
    #--------------------------------------------------------------------------
    # �̐��I�ɕs��
    #--------------------------------------------------------------------------
    # �����̔镔������̌��Ńz�[���h����Ă���
    return false if self.hold.penis.parts == "��" and self.hold.penis.battler == target
    return false if self.hold.dildo.parts == "��" and self.hold.dildo.battler == target
    return false if self.hold.vagina.parts == "��" and self.hold.vagina.battler == target
    #--------------------------------------------------------------------------
=end
    return true
  end
  #--------------------------------------------------------------------------
  # �� ���̑���̐K�Ɏ肪�͂����H
  #--------------------------------------------------------------------------
  def can_reach_hip?(target)
    #--------------------------------------------------------------------------
    # ����̐K���z�[���h��ԂɂȂ��Ă���ꍇ�͕s��
    #--------------------------------------------------------------------------
    return false if target.hold.anal.battler != nil
=begin �V�b�N�X�i�C���̐��Ȃ�\�Ȃ̂ŃR�����g�A�E�g
    #--------------------------------------------------------------------------
    # �̐��I�ɕs��
    #--------------------------------------------------------------------------
    # �����̔镔������̌��Ńz�[���h����Ă���
    return false if self.hold.penis.parts == "��" and self.hold.penis.battler == target
    return false if self.hold.dildo.parts == "��" and self.hold.dildo.battler == target
    return false if self.hold.vagina.parts == "��" and self.hold.vagina.battler == target
    #--------------------------------------------------------------------------
=end
    return true
  end
  #--------------------------------------------------------------------------
  # �� �������ėǂ����H
  #--------------------------------------------------------------------------
  def can_struggle?
    result = false
    if (
    self.bind? or
    self.pahupahu? or
    self.paizuri? or
    self.draw? or
    self.hipriding? or
    self.riding? or
    self.oralsex? or
    self.vagina_insert_special? or 
    self.tentacle_bind? or
    self.tentacle_absorb?
    ) and not self.initiative?
      result = true
    end
    return result
  end
  #--------------------------------------------------------------------------
  # �� �Ώۂ̐��t�������ɂ����邩�H
  #--------------------------------------------------------------------------
  def sperm_me?(target = $game_actors[101])
    result = true
    # �Ώۂ����ɂȂ��Ă��Ȃ��ꍇ�A�U��Ԃ�
    unless target.nude?
      result = false
    end
    # �Ώۂ̃y�j�X�������ȊO�̒N���Ƀz�[���h����Ă���ꍇ�A�U��Ԃ�
    if target.hold.penis.battler != nil and target.hold.penis.battler != self
      result = false
    end
    return result
  end
  #--------------------------------------------------------------------------
  # �� �炪�ǂ���Ă��邩�H
  #--------------------------------------------------------------------------
  def face_blind?
    result = false
    result = true if self.mouth_riding? # ��������ʋR����󂯂Ă���
    result = true if self.mouth_hipriding? # �������K��ʋR����󂯂Ă���
    result = true if self.mouth_pahupahu? # �������ςӂςӂ��󂯂Ă���
    return result
  end
  #----------------------------------------------------------------
  # �� �K���^�[�Q�b�g�̊m�F
  #----------------------------------------------------------------
  def proper_target?(target, skill_id = nil)
    #�A�C�e���g�p�̏ꍇ�̓^�[�Q�b�g�m�F���X���[����
    if self.current_action.kind == 2
      return true
    end
    #----------------------------------------------------------------
    # �X�L�����ݒ肳��Ă���ꍇ
    if skill_id != nil 
      # �g�p�X�L���̊m�F
      skill = $data_skills[skill_id]
      #----------------------------------------------------------------
      # �ȉ��̃X�L���͓K���^�[�Q�b�g�𖳎�����
      #----------------------------------------------------------------
      # �G�P�l��ΏۂƂ���X�L���̂���
      if skill.scope == 1
        # �T�|�[�g�X�L��
#        return true if skill.element_set.include?(4)
        # ���@�X�L��
#        return true if skill.element_set.include?(5)
      else
        # �G�P�l������ΏۂƂ��Ȃ��ꍇ�͈ȉ����ׂĖ���
        return true
      end
    end
    #----------------------------------------------------------------
    # �K���^�[�Q�b�g�p�̏�����
    proper_battlers = []
    target_group = $game_party.battle_actors + $game_troop.enemies
    # �z�[���h�����z�[���h���X�L���̏ꍇ�A
    # �z�[���h�����K���^�[�Q�b�g�ɓ����
    if self.holding? and skill.element_set.include?(132)
      proper_battlers.push(self.hold.mouth.battler)
      proper_battlers.push(self.hold.anal.battler)
      proper_battlers.push(self.hold.penis.battler)
      proper_battlers.push(self.hold.vagina.battler)
      proper_battlers.push(self.hold.tops.battler)
      proper_battlers.push(self.hold.tail.battler)
      proper_battlers.push(self.hold.dildo.battler)
      proper_battlers.push(self.hold.tentacle.battler)
      proper_battlers.compact!
    # ����ȊO�̏ꍇ�A�S����K���^�[�Q�b�g�ɓ����
    else
      for target_one in target_group
        proper_battlers.push(target_one) if target_one.exist?
      end
    end
=begin
    # �㔼�g�S���i�G���u���C�X���j���󂯂Ă���A���Ă�ꍇ��
    # ���̑���݂̂�K���^�[�Q�b�g�ɂ���
    # ���G��S���̏ꍇ�A�G�葤�͂��̐������󂯂Ȃ�
    if self.hold.tops.type == "�S��"
      proper_battlers = [self.hold.tops.battler]
    end
=end
    #----------------------------------------------------------------
    # �K���^�[�Q�b�g���̒������̑���̑��݂��m�F����
    incite_battlers = []
    for proper_one in proper_battlers
      if proper_one.incite_success? 
        # �������猩�ēG�̃o�g���[���������̏ꍇ�͒������z��ɓ����
        if (self.is_a?(Game_Actor) and proper_one.is_a?(Game_Enemy)) or 
         (self.is_a?(Game_Enemy) and proper_one.is_a?(Game_Actor))
          incite_battlers.push(proper_one)
        end
      end
    end
    #--------------------------------------------------------------------
    # �K���^�[�Q�b�g���Ɍ��ݑI��ł���Ώۂ�����ꍇ�A�}�[�L���O�n�̊m�F
    #--------------------------------------------------------------------
    # ���ʂ�^�ɏ�����
    result = true
    if proper_battlers.include?(target)
      #----------------------------------------------------------------
      # ����ʂقǗD��x���オ��
      #----------------------------------------------------------------
      # ���̃o�g���[���G�l�~�[���y�ώ��z�����̏ꍇ�A��l���ȊO���ƃG���[
      if self.have_ability?("�ώ�") and self.is_a?(Game_Enemy) and
       target != $game_actors[101] and proper_battlers.include?($game_actors[101])
        result = false
      #----------------------------------------------------------------
      # ��l�������h����Ԃ̏ꍇ�A��l���ȊO���ƃG���[
      elsif $game_actors[101].state?(95) and
       target != $game_actors[101] and proper_battlers.include?($game_actors[101])
        result = false
      #----------------------------------------------------------------
      # �K���^�[�Q�b�g���ɒ������̑��肪����A
      # ���̑����_���Ă��Ȃ��ꍇ�G���[
      elsif not incite_battlers.include?(target) and
       incite_battlers.size > 0
        result = false
        # ���������_���Ă��Ȃ��ꍇ�A�U�������t���O�𗧂Ă�
        # �i���Ώۂ̃X���[�Y�Ȍ���ƘA���j
        $game_temp.incite_flag = true
      #----------------------------------------------------------------
      # �K���^�[�Q�b�g���Ƀ}�[�L���O���Ă��鑊�肪����A
      # ���̑����_���Ă��Ȃ��ꍇ�G���[
      elsif proper_battlers.include?(self.marking_battler) and
       self.marking? and self.marking_battler != target
        result = false
=begin       
        text = ""
        for pro in proper_battlers
          text += "\n" if text != ""
          text += pro.name
        end
        text = "proper_battlers\n" + text
        print text
=end
      end
    #----------------------------------------------------------------
    # �K���^�[�Q�b�g���Ɍ��ݑI��ł���Ώۂ����Ȃ��ꍇ�A�G���[
    #----------------------------------------------------------------
    else
      result = false
    end
    # ���ʂ�Ԃ�
    return result
  end
  
  #----------------------------------------------------------------
  # �� ���������H
  #----------------------------------------------------------------
  def incite_success?
    return ((self.state?(96) or self.state?(104)) and self.bad_state_number <= 0)
  end
  #----------------------------------------------------------------
  # �� �f�t�H���g�̌Ăѕ��i��l�́j
  #----------------------------------------------------------------
  def defaultname_self
    text = ""
    if @defaultname_self != nil
      text = @defaultname_self
    else
      text = $data_SDB[self.class_id].default_name_self
    end
    text.gsub!("������","#{self.name}")
    text.gsub!("�����Z�k��","#{$msg.short_name(self)}")
    return text
  end
  #----------------------------------------------------------------
  # �� �f�t�H���g�̌Ăѕ��i��l�́j
  #----------------------------------------------------------------
  def defaultname_hero
    text = ""
    if @defaultname_hero != nil
      text = @defaultname_hero
    else
      text = $data_SDB[self.class_id].default_name_hero
    end
    text.gsub!("��l����","#{$game_actors[101].name}")
    text.gsub!("��l���Z�k��","#{$msg.short_name($game_actors[101])}")
    return text
  end
  #----------------------------------------------------------------
  # �� �Ăѕ��i��l�́j
  #----------------------------------------------------------------
  def nickname_self
    text = self.defaultname_self
    text = @nickname_self if @nickname_self != nil
    text.gsub!("������","#{self.name}")
    text.gsub!("�����Z�k��","#{$msg.short_name(self)}")
    return text
  end
  #----------------------------------------------------------------
  # �� �Ăѕ��i�j�l�́j
  #----------------------------------------------------------------
  def nickname_master
    text = self.defaultname_hero
    text = @nickname_master if @nickname_master != nil
    text.gsub!("��l����","#{$game_actors[101].name}")
    text.gsub!("��l���Z�k��","#{$msg.short_name($game_actors[101])}")
    return text
  end
  #----------------------------------------------------------------
  # �� defining UK names - temporary definition w/ rescue
  #----------------------------------------------------------------
  def UK_name
    text = self.defaultname_self
    if self.is_a?(Game_Enemy)
      text = $data_enemies[@enemy_id].UK_name rescue text = error
      else text = "not an enemy"
    end
    return text
  end
end