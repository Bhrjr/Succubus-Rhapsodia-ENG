#==============================================================================
# �� Incense_System
#------------------------------------------------------------------------------
# �@�C���Z���X
#==============================================================================

class Incense
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_accessor :name                        # ���O
  attr_accessor :remaining_turn              # �c��^�[��
  attr_accessor :start_text                  # �J�n�e�L�X�g
  attr_accessor :fragranting_text            # �p�����e�L�X�g
  attr_accessor :end_text                    # �I���e�L�X�g
  # �X�e�[�^�X�␳
  attr_accessor :atk_rate
  attr_accessor :pdef_rate
  attr_accessor :str_rate                    
  attr_accessor :dex_rate                     
  attr_accessor :agi_rate
  attr_accessor :int_rate
  attr_accessor :plus_rate
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize(incense_name)
    
    @name = incense_name
    @remaining_turn = 5
    @start_text       = ""
    @fragranting_text = ""
    @end_text         = ""
    @plus_rate = [0,0,0,0,0,0]
    
    @atk_rate  = 100
    @pdef_rate = 100
    @str_rate  = 100
    @dex_rate  = 100
    @agi_rate  = 100
    @int_rate  = 100
    
    actors_word  = "����"
    enemies_word = "����" # ��ŉ��ς���
    field_word   = "����"
    brk_word   = "brk"
    
    case incense_name
    
    #--------------------------------------------------------------------------
    # ���w����
    #-------------------------------------------------------------------|------
    when "�����b�N�X�^�C��" # �Y
      @start_text       = "#{actors_word}�Ɉ����̎����K�ꂽ�I"
      @fragranting_text = "#{actors_word}�Ɉ����̎�������Ă���c�c�I"
      @end_text         = "#{actors_word}�̈����̎����I������I"
      # ���^�[���I�����ɏ���
    #-------------------------------------------------------------------|------
    when "�X�C�[�g�A���}" # �Y
#      @start_text       = "#{actors_word}�ɊÂ����肪�������߂��I"
      @start_text       = "#{actors_word}�̖��͂��㏸�����I"
      @fragranting_text = "#{actors_word}�͊Â�����ɕ�܂�Ă���c�c�I"
      @end_text         = "#{actors_word}����Â����肪���ꂽ�I"
      @plus_rate[0] = 50
      @atk_rate  = 150
      # ���͋���
    #-------------------------------------------------------------------|------
    when "�p�b�V�����r�[�g" # �Y
#      @start_text       = "#{actors_word}�̂��C�����܂����I"
      @start_text       = "#{actors_word}�̐��͂Ƒf�������㏸�����I"
      @fragranting_text = "#{actors_word}�̂��C�͍��܂��Ă���c�c�I"
      @end_text         = "#{actors_word}�̂��C�������������I"
      @plus_rate[2] = 130
      @plus_rate[4] = 130
      # ���́A�f��������
    #-------------------------------------------------------------------|------
    when "�}�C���h�p�t���[��" # �Y
#      @start_text       = "#{actors_word}�ɏ_���ȍ��肪�������߂�I"
      @start_text       = "#{actors_word}�͏�Ԉُ�ɋ����Ȃ����I"
      @fragranting_text = "#{actors_word}�͏_���ȍ����Z���Ă���c�c�I"
      @end_text         = "#{actors_word}����_���ȍ��肪���ꂽ�I"
      # �o�X�e�ϐ��l����
    #-------------------------------------------------------------------|------
    when "���b�h�J�[�y�b�g" # �Y
      @start_text       = "#{actors_word}�͒��Ԃ̏o�Ԃ̏����𐮂����I"
      @fragranting_text = "#{actors_word}��#{brk_word}���Ԃ̏o�Ԃ̏����������Ă���I"
      @end_text         = "#{actors_word}��#{brk_word}���b�h�J�[�y�b�g�������Ȃ����I"
      # ���ŏo�Ă��������̖��́E�f��������
    #-------------------------------------------------------------------|------
    when "�����̎�" # �i�v�j
      @fragranting_text = "#{actors_word}�͐g�̂��x�߂Ă���c�c�I"
      # �񕜗ʃA�b�v
    #-------------------------------------------------------------------|------

#      @start_text       = "#{field_word}�Ɋ��\�I�ȍ��肪�������߂�I"
    #--------------------------------------------------------------------------
    # �G�w����
    #--------------------------------------------------------------------|------
    when "�X�g�����W�X�|�A" # �Y
#      @start_text       = "#{enemies_word}�Ɋ�ȖE�q���Y���n�߂��I"
      @start_text       = "#{enemies_word}�͏�Ԉُ�Ɏキ�Ȃ����I"
      @fragranting_text = "#{enemies_word}�Ɋ�ȖE�q���Y���Ă���c�c�I"
      @end_text         = "#{enemies_word}�ɕY����ȖE�q�������Ȃ����I"
      # �o�X�e�ϐ��l����
    #--------------------------------------------------------------------|------
    when "�E�B�[�N�X�|�A" # �Y
#      @start_text       = "#{enemies_word}�ɈÂ��E�q���Y���n�߂��I"
      @start_text       = "#{enemies_word}�ɔ��Â��E�q���Y���n�߂��I"
      @fragranting_text = "#{enemies_word}�ɔ��Â��E�q���Y���Ă���c�c�I"
      @end_text         = "#{enemies_word}�ɔ��Â��Y���E�q�������Ȃ����I"
      # ��Ԉُ펞�A��r�r���A�b�v�B
    #--------------------------------------------------------------------|------
    when "��ɂ�" # �i�v�j
      @fragranting_text = "#{enemies_word}�ْ͋����ɕ�܂�Ă���c�c�I"
      # �ؕ|���A���_�͂�1/2�ɂȂ�
    #--------------------------------------------------------------------|------
    when "�Д�" # �Y
#      @start_text       = "#{enemies_word}�͈Д�����Ă��܂����I"
      @start_text       = "#{enemies_word}�̓��W�X�g�Ɏキ�Ȃ����I"
      @fragranting_text = "#{enemies_word}�͈Д�����Ă���c�c�I"
      @end_text         = "#{enemies_word}�̈Д��̌��ʂ������Ȃ����I"
      # ���W�X�g��Փx����
    #--------------------------------------------------------------------|------
    when "�S�͂�" # �Y
      @start_text       = "#{enemies_word}�͓������Ȃ��Ȃ����I"
      @fragranting_text = "#{enemies_word}�͌�딯��������Ă���I"
      @end_text         = "#{enemies_word}�̐S�݂͂̌��ʂ������Ȃ����I"
      # �������Ȃ��B
    #--------------------------------------------------------------------|----
    when "�S�Ă͌�" # �Y
      @start_text       = "#{enemies_word}�̊��o���}���ɑN���ɂȂ�I"
      @fragranting_text = "#{enemies_word}�̊��o���N���ɂȂ��Ă���c�c�I"
      @end_text         = "#{enemies_word}�̑N��������܂����I"
      # ��r�r���A�b�v
    #--------------------------------------------------------------------|------
      
    # �S�̌���
    #-------------------------------------------------------------------------
    when "���u�t���O�����X" # �Y
      @start_text       = "#{field_word}�Ɋ��\�I�ȍ��肪�������߂�I"
      @fragranting_text = "#{field_word}�͊��\�I�ȍ���ɕ�܂�Ă���c�c�I"
      @end_text         = "#{field_word}���犯�\�I�ȍ��肪���ꂽ�I"
      # ���^�[���J�n���Ƀ��[�h�A�b�v
    #-------------------------------------------------------------------------
    when "�X���C���t�B�[���h" # �Y
      @start_text       = "#{field_word}�ɔS�t���L�������I"
      @fragranting_text = "#{field_word}�͔S�t���L�����Ă���c�c�I"
      @end_text         = "#{field_word}�ɍL�����Ă����S�t�������Ȃ����I"
      # �U���ŏ㏸���鏁���x�ʂ��オ��
    #--------------------------------------------------------------------------
    
    # ����ȊO�͖��O�����Z�b�g���A��ł���܂邲�Ə����Ă��炤
    else 
      @name = ""
    end
  end
end

class Incense_System
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_accessor :data
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    @data = [[],[],[]]
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�^�X�␳���l
  #--------------------------------------------------------------------------
  def inc_adjusted_value(battler, type)
    n = 0
    value = 100
    n = 0 if battler.is_a?(Game_Actor)
    n = 1 if battler.is_a?(Game_Enemy)
    n = battler if battler.is_a?(Integer)
    for i in [n, 2].uinq!
      for inc_one in @data[n]
        value += inc_one.plus_rate[type]
      end
    end
    return value
  end
  #--------------------------------------------------------------------------
  # �� ���̃C���Z���X�����邩�H
  #--------------------------------------------------------------------------
  def actors_inc
    return @data[0][0]
  end
  def enemies_inc
    return @data[1][0]
  end
  def all_inc
    return @data[2][0]
  end
  #--------------------------------------------------------------------------
  # �� ���̃C���Z���X�����邩
  #--------------------------------------------------------------------------
  def exist?(name, battler)
    result = false
    n = 0
    n = 0 if battler.is_a?(Game_Actor)
    n = 1 if battler.is_a?(Game_Enemy)
    n = battler if battler.is_a?(Integer)
    for i in [n, 2].uinq!
      for incense in @data[i]
        result = true if incense.name == name
      end
    end
    return result 
  end
  #--------------------------------------------------------------------------
  # �� �g�p�҂Ɣ���������C���Z���X��ǉ�����
  #--------------------------------------------------------------------------
  def use_incense(user, val)
    result = false
    # val���X�L���������̓A�C�e���łȂ��ꍇ�I��
    unless val.is_a?(RPG::Skill) or val.is_a?(RPG::Item)
      return false
    end
    # ���ʔ͈͂���K�؂ȉӏ��ɒǉ�
    case val.scope
    when 2 # �G�S�́@���G�R
      result = add_incense(val.name, 1) if user.is_a?(Game_Actor)
      result = add_incense(val.name, 0) if user.is_a?(Game_Enemy)
    when 4 # �����S�́@�����R
      result = add_incense(val.name, 0) if user.is_a?(Game_Actor)
      result = add_incense(val.name, 1) if user.is_a?(Game_Enemy)
    when 7 # �g�p�ҁ@���S��
      result = add_incense(val.name, 2)
    end
    return result
  end
  #--------------------------------------------------------------------------
  # �� �C���Z���X��ǉ�
  #--------------------------------------------------------------------------
  def add_incense(name, box_number)
    # ���łɂ���ꍇ�͏I��
    return false if exist?(name, box_number)
    # �C���Z���X�̒ǉ�
    @data[box_number].push(Incense.new(name))
    # �ݒ肳��Ă��Ȃ��C���Z���X�̏ꍇ�A�폜����
    if @data[box_number][@data[box_number].size - 1].name == ""
      @data[box_number].delete(@data[box_number][@data[box_number].size - 1])
      return false
    end
    add_text(name, box_number)
    return true
  end
  #--------------------------------------------------------------------------
  # �� �C���Z���X���폜
  #--------------------------------------------------------------------------
  def delete_incense(name, box_number)
    for incense in @data[box_number]
      if incense.name == name
        remove_text(name, box_number)
        @data[box_number].delete(incense)
#        text =
#          case box_number
#          when 0;"������#{incense.name}�̌��ʂ������Ȃ���"
#          when 1;"�G��#{incense.name}�̌��ʂ������Ȃ���"
#          when 2;"���#{incense.name}�̌��ʂ������Ȃ���"
#          end
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �C���Z���X��S�ă��Z�b�g�i�����ЂƂł��������Ȃ��true��Ԃ��j
  #--------------------------------------------------------------------------
  def delete_incense_all
    result = false
    result = true if @data != [[],[],[]]
    @data = [[],[],[]]
    return result
  end
  #--------------------------------------------------------------------------
  # �� �^�[���I�����̌���
  #--------------------------------------------------------------------------
  def turn_end_reduction
    index = 0
    for data_one in @data
      for incense in data_one
        incense.remaining_turn -= 1
        delete_incense(incense.name, index) if incense.remaining_turn <= 0
      end
      index += 1
    end
  end
  #--------------------------------------------------------------------------
  # �� �C���Z���X�t�^�e�L�X�g
  #--------------------------------------------------------------------------
  def add_text(name, box_number)
    txt = ""
    if $incense.data[box_number] != []
      for incense_one in $incense.data[box_number]
        if incense_one.name == name
          txt += text_alter(incense_one.start_text + "\\", box_number)
        end
      end
    end
    if txt != ""
      if $game_system.system_read_mode != 0
        txt += "CLEAR"
        txt.sub!("\\CLEAR","")
      end
      $game_temp.battle_log_text += txt
    else
      return ""
    end
  end
  #--------------------------------------------------------------------------
  # �� �C���Z���X�����e�L�X�g
  #--------------------------------------------------------------------------
  def remove_text(name, box_number)
    txt = ""
    if $incense.data[box_number] != []
      for incense_one in $incense.data[box_number]
        if incense_one.name == name
          txt += text_alter(incense_one.end_text + "\\", box_number)
        end
      end
    end
    if txt != ""
      if $game_system.system_read_mode != 0
        txt += "CLEAR"
        txt.sub!("\\CLEAR","")
      end
      # ���O�Ƀe�L�X�g���������ꍇ�͉��s��}��
      txt = "\\" + txt if $game_temp.battle_log_text != "" 
      $game_temp.battle_log_text += txt
    else
      return ""
    end
  end
  #--------------------------------------------------------------------------
  # �� �C���Z���X�p���e�L�X�g
  #--------------------------------------------------------------------------
  def keep_text_call
    txt = ""
    for i in 0..2
      if $incense.data[i] != []
        for incense_one in $incense.data[i]
          txt += text_alter(incense_one.fragranting_text + "\\", i)
        end
      end
    end
    if txt != ""
      if $game_system.system_read_mode != 0
        txt += "CLEAR"
        txt.sub!("\\CLEAR","")
      end
      $game_temp.battle_log_text += txt
    else
      return ""
    end
  end
  #--------------------------------------------------------------------------
  # �� �e�L�X�g���̉���
  #--------------------------------------------------------------------------
  def text_alter(text, box_number)
    count = 0
    delegate = nil
    text.gsub!("����", "����") if box_number == 1
    
    for actor in $game_party.battle_actors
      if actor.exist?
        delegate = actor if delegate == nil
        count += 1
      end
    end
    if delegate != nil
      s1 = delegate.name
      s1 += "����" if count > 1
      change_flag = text.gsub!("����", s1)
      text.gsub!("brk", "\\n") if change_flag != nil and s1.size > 10 * 3
    end
    count = 0
    delegate = nil  
    for enemy in $game_troop.enemies
      if enemy.exist?
        delegate = enemy if delegate == nil
        count += 1
      end
    end
    if delegate != nil
      s2 = delegate.name
      s2 += "����" if count > 1
      change_flag = text.gsub!("����", s2)
      text.gsub!("brk", "\\n") if change_flag != nil and  s2.size > 10 * 3
    end
    text.gsub!("brk", "")
    return text
  end
end