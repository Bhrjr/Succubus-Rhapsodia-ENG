#==============================================================================
# �� Game_Battler TextMake
#------------------------------------------------------------------------------
# �@�o�g�����b�Z�[�W����
#==============================================================================

class Game_Battler
  ##################
  #�� �X�e�[�g�� #
  ##################
  def bms_states_report
    text = ""
    # �X�e�[�g��report���ݒ肳��Ă�����̂�S�Ď擾
    # �������N���C�V�X�͏��O
    for i in self.states
      if $data_states[i].id != 6 and self.exist? and not self.dead?
        ms = $data_states[i].message($data_states[i],"report",self,nil)
        text = (text + ms + "\w\q") if ms != ""
      end
    end
    # ���b�Z�[�W�\��
    if text != ""
      text += "CLEAR"
      text.sub!("\w\qCLEAR","")
      return text
    else
      return ""
    end
  end
  ######################
  #�� �X�e�[�g�ω���#
  ######################
  def bms_states_update(user_battler = nil)
    user = $game_temp.battle_active_battler
    user = nil if $game_temp.battle_active_battler == [] and user_battler == nil #�^�[���J�n���̂�
    user = user_battler if user_battler != nil
    ms1 = ms2 = ""
    text1 = text2 = ""
    if (self.add_states_log == [] and self.remove_states_log == [])
      return ""
    end
    # �X�e�[�g�t����
    if self.add_states_log != []
      for i in self.add_states_log
        ms1 = i.message(i,"effect", self, user)
        # �퓬�s�\�Ȃ�񍐏I��
        if i.id == 1
          text1 = ms1
          self.add_states_log.clear
          return text1
        end
        #���s��}��
        text1 = text1 + ms1 + "\w\q" if ms1 != ""
      end
      #�i�[�I�������烍�O����������
      self.add_states_log.clear
    end
    # �X�e�[�g������
    if self.remove_states_log != [] and not self.dead?
      for i in self.remove_states_log
        ms2 = i.message(i,"recover", self, user)
        #���s��}��
        text2 = text2 + ms2 + "\w\q" if ms2 != ""
      end
      #�i�[�I�������烍�O����������
      self.remove_states_log.clear
    end
    # �e�L�X�g���`
    text = text1 + text2
    # ���b�Z�[�W�o��
    if text != ""
      #���͂�����ꍇ�A�Ō�̉��s������
      text += "CLEAR"
      text.sub!("\w\qCLEAR","")
      return text
    else
      return ""
    end
  end
  #-------------------------#
  # �� �X�L���g�p���b�Z�[�W #
  #-------------------------#
  def bms_useskill(skill)
    user = $game_temp.battle_active_battler
    text = skill.message(skill, "action", self, user)
    if text != "" and text != nil
      text = text + "\q"
      # �����ɂ��ΏەύX���������Ă���ꍇ�A�U�����b�Z�[�W���o��
      if $game_temp.incite_flag
        text = "#{user.name}�͗U������Ă���I\q\m" + text
      end
      $game_temp.battle_log_text = text
    end
  end
  #-----------------------------#
  # �� �X�L���g�p���ʃ��b�Z�[�W #
  #-----------------------------#
  def bms_skill_effect(skill)
    user = $game_temp.battle_active_battler
    plus = ""
    text = ""
    if self.damage.is_a?(Numeric)
      myname = self.name
      username = $game_temp.battle_active_battler.name
      damage = self.damage
      # ���N���e�B�J������
      if self.critical and self.damage != "Miss"
#        plus += "�Z���V���A���X�g���[�N�I\w\q"
        plus += "Sensual Stroke�I\w\q"
        self.animation_id = 103
        self.animation_hit = true
        self.damage_pop = true
        # ���[�h�A�b�v
        $mood.rise(1 + rand(5))
      else
        plus = ""
      end
      # ���_���[�W����(�l���}�C�i�X�Ȃ�񕜃X�L��)
      if damage > 0
        if user.is_a?(Game_Actor)
          text = "#{myname}�� #{damage.to_s} �̉�����^�����I"
          text = "#{myname}�͉����Őg�ウ���Ă���I" if self.weaken? and not self.dead?
          text = "#{myname}�̐g�̂������ő傫�����˂�I" if self.sp_down_flag == true
        else
          text = "#{myname}�� #{damage.to_s} �̉������󂯂��I"
          text = "#{myname}�͉����Őg�ウ���Ă���I" if self.weaken?
          text = "#{myname}�̐g�̂������ő傫�����˂�I" if self.sp_down_flag == true
          text = "#{myname}�̊��͂�����Ă����c�c�I" if self.weaken? and self == $game_actors[101]
          text = "#{myname}�̐������E�𒴂��či����I" if self.sp_down_flag == true and self == $game_actors[101]
        end
      elsif damage == 0# and damage < 1
        if user.is_a?(Game_Actor)
          text = "#{myname}�ɉ�����^�����Ȃ��I"
        else
          text = "#{myname}�͉������󂯂Ȃ������I"
        end
        #-------------------------------------------------------------------------
        # �{�C�ɂȂ閲�����܂��{�C���o���Ă��Ȃ����߂Ɏ��_���Ȃ��ꍇ�A�e�L�X�g��ύX
        #-------------------------------------------------------------------------
        if SR_Util.enemy_before_earnest?(self)
          text = "#{myname}�̐g�̂������ő傫�����˂�I"
        end
      else
        n = self.damage * 80 / 100
        text = "#{myname}�̂d�o�� #{(damage.abs).to_s} �񕜂����I"
      end
    elsif self.damage == "Miss"
      text = skill.message(skill,"avoid", self, user)
    end
    text = plus + text if plus != ""
    
# �_���[�W�����X�L���Ń��[�h���オ��Ȃ��̂�Scene_Battle�ɈڐA
=begin
    # ���[�h�A�b�v����
    #------------------------------------------------------
    # ���[�h�A�b�v��
    if skill.element_set.include?(20)
      $mood.rise(1)
    # ���[�h�A�b�v��
    elsif skill.element_set.include?(21)
      $mood.rise(4)
    # ���[�h�A�b�v��
    elsif skill.element_set.include?(22)
      $mood.rise(10)
    end
=end

    
    return text
  end
  #---------------------------------#
  # �� ���o�X�L���g�p���ʃ��b�Z�[�W #
  #---------------------------------#
  def bms_direction_skill_effect(skill)
    text = ""
    myname = self.name
    username = $game_temp.battle_active_battler.name
    #------------------------------------------------------------------------#        
    # ������X�L��
    case skill.id
    when 419   #�A�����b�L�[���A
      text = "#{$game_actors[101].name}�͕s�K�ɂȂ��Ă��܂����I\w\q"
      # �s�K�łȂ��ꍇ�A�s�K��Ԃɂ���B
      if $game_variables[61] == 0
        $game_variables[61] = 50 
      end
    when 239   #�V���C�j���O���C�W
      text = "�ł��ق��M���̓S�Ƃ��A�������҂ǂ����т��I�I\w\q"
    end
    #------------------------------------------------------------------------#        
    return text
  end
 
  #---------------------------#
  # �� �A�C�e���g�p���b�Z�[�W #
  #---------------------------#
  def bms_useitem(item)
    user = $game_temp.battle_active_battler
    text = item.message(item, "action", self, user)
    if text != nil
      text = text + "\q"
      $game_temp.battle_log_text = text
    end
  end
  #-------------------------------#
  # �� �A�C�e���g�p���ʃ��b�Z�[�W #
  #-------------------------------#
  def bms_item_effect(item)
    user = $game_temp.battle_active_battler
    text = ""
    myname = self.name
    damage = self.damage
    # EP��VP�����񕜂̏ꍇ
    if (item.recover_hp_rate > 0 or item.recover_hp > 0) and
       (item.recover_sp_rate > 0 or item.recover_sp > 0)
      text = "#{myname}�̂d�o�� #{(damage.abs).to_s} �񕜂����I\q" + 
             "#{myname}�̂u�o�� #{(recover_sp).to_s} �񕜂����I"
      text = "���������͌��ʂ����������I" if self.state?("����")
    # EP�̂݉񕜂̏ꍇ
    elsif (item.recover_hp_rate > 0 or item.recover_hp > 0)
      text = "#{myname}�̂d�o�� #{(damage.abs).to_s} �񕜂����I"
      text = "���������͌��ʂ����������I" if self.state?("����")
    # VP�̂݉񕜂̏ꍇ
    elsif (item.recover_sp_rate > 0 or item.recover_sp > 0)
      text = "#{myname}�̂u�o�� #{(recover_sp).to_s} �񕜂����I"
    # ���蕨�A�C�e���A�C�e���̏ꍇ
    elsif item.element_set.include?(199)
      text = bms_present_response
    end
    # �~�X�̏ꍇ������b�Z�[�W��\��
    if self.damage == "Miss"
      text = item.message(item,"avoid", self, user)
    end
    # ���b�Z�[�W�\��
    return text
  end
  #-------------------------------#
  # �� ���蕨���󂯎��������     #
  #-------------------------------#
  def bms_present_response
    text = ""
    myname = self.name
    user = $game_temp.battle_active_battler.name
    # ���i���ƂɕύX
    case self.personality
    #------------------------------------------------------------------------
    when "�D�F","����","�ƑP"
      text = "#{myname}�͎v�킹�Ԃ�ɔ��΂񂾁c�c�I"
    #------------------------------------------------------------------------
    when "�z�C","�V�R","�Â���","���C"
      text = "#{myname}�͖��ʂ̏΂݂Ŋ�񂾁c�c�I"
    #------------------------------------------------------------------------
    when "�D�F","��i","�_�a","�]��","���M"
      text = "#{myname}�͑f���Ɋ��ł���悤���c�c�I"
    #------------------------------------------------------------------------
    when "�����C","�Ӓn��","�C��","����"
      text = "#{myname}�͊��w���ďƂ���B�����c�c�I"
    #------------------------------------------------------------------------
    when "�W��","�s�v�c","�|��","�A�C"
      text = "#{myname}�͂ǂ������ł���悤���c�c�I"
    #------------------------------------------------------------------------
    when "���C","����","����"
      text = "#{myname}�͊��Ԃ����ďƂ�Ă���c�c�I"
    #------------------------------------------------------------------------
    when "�I����"
      text = "#{myname}�͂����ʔ�����悤�ɁA\n\m#{user}�����Ě}�΂����c�c�I"
    #------------------------------------------------------------------------
    else
      text = "#{myname}�͊��ł���悤���c�c�I"
    end
    # �Ԃ�
    return text
  end
  
end