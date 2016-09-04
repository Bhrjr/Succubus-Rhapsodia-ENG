#==============================================================================
# �� Game_Enemy
#------------------------------------------------------------------------------
# �@�G�l�~�[�������N���X�ł��B���̃N���X�� Game_Troop �N���X ($game_troop) ��
# �����Ŏg�p����܂��B
#==============================================================================

class Game_Enemy < Game_Battler
  
  #--------------------------------------------------------------------------
  # �� ���̍쐬
  #--------------------------------------------------------------------------
  def make_individuality(personality = "", ability = ["���ݒ�"])
=begin
    box = []
    for action in $data_enemies[id].actions
      box.push($data_skills[action.skill_id].name) 
    end
    p [name] + box
=end
    # ���@���̍쐬�@��

    # ���ǋL����-----------------------------------
    #
    # �G�l�~�[�̂h�c���画�f
    # �Epersonality_group :  ���i�O���[�v�̎擾�@
    # �Eability_group     :  �f���O���[�v�̎擾�@[�f����/(�����m��/100)]
    #
    # ---------------------------------------------
    
    # �f�t�H���g
    personality_group = [0, "�D�F", "�z�C", "�Ӓn��"]
    ability_group = []
    # ���̃��x���܂łɏK�����Ă���f�������ׂē���
    for i in 1..self.level
      for j in $data_classes[self.class_id].learnings
        if j[0] == i
          if j[1] == 1
            ability_group += [j[2]]
          end
        end
      end
    end
    
    # �G�l�~�[�̃N���X���ƂɎ����ݒ�
    case self.class_name
    # -----------------------------------------------------------------------
    when "���b�T�[�T�L���o�X","�T�L���o�X","�T�L���o�X���[�h"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�D�F", "�z�C", "�z�C"]
       when "��" ; [1, "�D�F", "�D�F", "�D�F"]
       end
    # -----------------------------------------------------------------------
    when "�C���v","�f�r��","�f�[����"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�����C", "����", "����"]
       when "��" ; [1, "����", "����", "����"]
       end
    # -----------------------------------------------------------------------
    when "�v�`�E�B�b�`","�E�B�b�`"
      personality_group = 
       case self.class_color
       when "��" ; [1, "��i", "�W��", "�W��"]
       when "��" ; [1, "�D�F", "�D�F", "�D�F"]
       end
    # -----------------------------------------------------------------------
    when "�L���X�g"
      personality_group = 
       case self.class_color
       when "��" ; [1, "���C", "���C", "�]��"]
       when "��" ; [1, "�D�F", "�D�F", "�D�F"] 
       end
       ability_group += ["���A��������/100"] if self.class_color == "��"
    # -----------------------------------------------------------------------
    when "�X���C��"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�]��", "�]��", "�|��"]
       end
    # -----------------------------------------------------------------------
    when "�i�C�g���A"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�W��", "�W��", "�s�v�c"]
       when "��" ; [1, "�V�R", "�V�R", "�V�R"]
       end
    # -----------------------------------------------------------------------
    when "�X���C��"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�V�R", "�_�a", "�_�a"]
       end
    # -----------------------------------------------------------------------
    when "�S�[���h�X���C��"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�_�a", "�_�a", "��i"]
       end
    # -----------------------------------------------------------------------
    when "�t�@�~���A"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�]��", "�W��", "�W��"]
       when "��" ; [1, "�|��", "�|��", "�|��"]
       end
    # -----------------------------------------------------------------------
    when "���[�E���t"
      personality_group = 
       case self.class_color
       when "��" ; [1, "����", "����", "�Â���"]
       when "��" ; [1, "�����C", "�����C", "�����C"]
       end
    # -----------------------------------------------------------------------
    when "���[�L���b�g"
      personality_group = 
       case self.class_color
       when "��" ; [2, "�V�R", "�V�R", "�Ӓn��"]
       when "��" ; [1, "�s�v�c", "�s�v�c", "�s�v�c"]
       end
    # -----------------------------------------------------------------------
    when "�S�u����", "�M�����O�R�}���_�["
      personality_group = 
       case self.class_color
       when "��" ; [1, "�z�C", "�Â���", "�Â���"]
       end
    # -----------------------------------------------------------------------
    when "�v���[�X�e�X"
      personality_group = 
       case self.class_color
       when "��" ; [1, "��i", "����", "����"]
       end
    # -----------------------------------------------------------------------
    when "�J�[�X���C�K�X"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�D�F", "�|��", "�|��"]
       end
    # -----------------------------------------------------------------------
    when "�A�����E�l"
      personality_group = 
       case self.class_color
       when "��" ; [1, "��i", "��i", "�Â���"]
       when "��" ; [1, "�Ӓn��", "�Ӓn��", "�Ӓn��"]
       end
    # -----------------------------------------------------------------------
    when "�}�^���S"
      personality_group = 
       case self.class_color
       when "��" ; [1, "���C", "��i", "��i"]
       end
    # -----------------------------------------------------------------------
    when "�_�[�N�G���W�F��"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�Ӓn��", "�_�a", "�_�a"]
       end
    # -----------------------------------------------------------------------
    when "�K�[�S�C��"
      personality_group = 
       case self.class_color
       when "��" ; [1, "����", "�����C", "�����C"]
       end
    # -----------------------------------------------------------------------
    when "�~�~�b�N"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�Ӓn��", "�z�C", "�z�C"]
       when "��" ; [1, "�s�v�c", "�s�v�c", "�s�v�c"]
       end
    # -----------------------------------------------------------------------
    when "�^�}��"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�D�F", "����", "����"]
       end
    # -----------------------------------------------------------------------
    when "������"
      personality_group = 
       case self.class_color
       when "��" ; [1, "�D�F", "�Ӓn��", "�Ӓn��"]
       end
    # -----------------------------------------------------------------------
    when "���j�[�N�T�L���o�X","���j�[�N�^�C�N�[��","���j�[�N�E�B�b�`"
      case self.class_color
      when "�l�C�W�������W"
        personality_group = [1, "���C", "���C", "���C"]
        ability_group += ["����������/100"]
      when "���W�F�I"
        personality_group = [1, "�C��", "�C��", "�C��"]
        ability_group += ["����������/100"]
      when "�t���r���A"
        personality_group = [1, "�ƑP", "�ƑP", "�ƑP"]
        ability_group += ["�A�j��������/100"]
      when "�M���S�[��"
        personality_group = [1, "����", "����", "����"]
        ability_group += ["����������/100"]
      when "���[�K�m�b�g"
        personality_group = [1, "�A�C", "�A�C", "�A�C"]
        ability_group += ["���K��������/100"]
      when "�V���t�F"
        personality_group = [1, "���M", "���M", "���M"]
        ability_group += ["����������/100"]
      when "���[�~��"
        personality_group = [1, "����", "����", "����"]
        ability_group += ["����������/100"]
        ability_group += ["�ώ�/100"]
      when "���F���~�B�[�i"
        personality_group = [1, "�I����", "�I����", "�I����"]
        ability_group += ["���A��������/100"]
      end
    end
    # -----------------------------------------------------------------------
    #  �� �G�l�~�[ID���ƂɎ蓮�ݒ�
    # -----------------------------------------------------------------------
    case self.id
    when 25 # �e�X�g�p�C���v
      personality_group = [1, "�����C", "�����C", "�����C"]
    when 26 # �e�X�g�p�~�~�b�N
      personality_group = [1, "�Ӓn��", "�Ӓn��", "�Ӓn��"]
    when 27 # �e�X�g�p�L���X�g
      personality_group = [1, "���C", "���C", "���C"]
    when 29 # �e�X�g�p�t�@�~���A
      personality_group = [1, "�|��", "�|��", "�|��"]
    when 31 # Lv.1 # �`���[�g���A��
      personality_group = [1, "�D�F", "�D�F", "�D�F"]
      ability_group += ["����������/100"]
    when 81 # Lv.1 # �`���[�g���A��
      personality_group = [1, "�D�F", "�D�F", "�D�F"]
      ability_group += ["����������/100"]
    when 95,139,297 # ���C�o���T�L���o�X
      personality_group = [1, "�z�C", "�z�C", "�z�C"]
      ability_group += ["����������/100"]
    when 96,140,298 # ���C�o���f�r��
      personality_group = [1, "�����C", "�����C", "�����C"]
      ability_group += ["���K��������/100"]
    # -----------------------------------------------------------------------
    # ���a�n�r�r
    # -----------------------------------------------------------------------
    when 65 # �T�L���o�X/��@Lv.18
      personality_group = [1, "�z�C", "�z�C", "�z�C"]
      ability_group += ["����������/100"]
    when 66 # �f�r��/�΁@Lv.18
      personality_group = [1, "�����C", "�����C", "�����C"]
      ability_group += ["���K��������/100"]
    end
    

    
=begin
    # -----------------------------------------------------------------------
    #  �� �G�l�~�[ID���ƂɎ蓮�ݒ�
    # -----------------------------------------------------------------------
    case self.id
    when 1 # �e�X�g�p���b�T�[�T�L���o�X
      personality_group = [0, "�D�F", "�z�C", "�Ӓn��"]
    
    when 9 # �e�X�g�pOFE���b�T�[�T�L���o�X
      personality_group = [1, "�D�F", "�D�F", "�D�F"]
      ability_group += ["�z��/100", "���g/100", "�n��/100"]
    when 25 # �e�X�g�p�C���v
      personality_group = [1, "�����C", "�����C", "�����C"]
    when 26 # �e�X�g�p�T�L���o�X
      personality_group = [1, "�D�F", "�D�F", "�D�F"]
    when 27 # �e�X�g�p�L���X�g
      personality_group = [1, "���C", "���C", "���C"]
    when 28 # �e�X�g�p�X���C��
      personality_group = [1, "�V�R", "�V�R", "�V�R"]
    # -----------------------------------------------------------------------
    #
    # ���������������
    #
    # -----------------------------------------------------------------------
      
    # -----------------------------------------------------------------------
    #
    # �����b�T�[�T�L���o�X/��
    # -----------------------------------------------------------------------
    when 31 # Lv.1 # �`���[�g���A��
      personality_group = [1, "�D�F", "�z�C", "�z�C"]
      ability_group += ["����������/100"]
    when 32 # Lv.1 
      personality_group = [1, "�D�F", "�z�C", "�z�C"]
    when 33 # Lv.3
      personality_group = [1, "�D�F", "�z�C", "�z�C"]
    when 34 # Lv.6
      personality_group = [1, "�D�F", "�z�C", "�z�C"]
    when 35 # Lv.8
      personality_group = [1, "�D�F", "�z�C", "�z�C"]
    when 36 # Lv.10
      personality_group = [1, "�D�F", "�z�C", "�z�C"]
    # -----------------------------------------------------------------------
    #
    # ���T�L���o�X/��
    # -----------------------------------------------------------------------
    when 38 # Lv.10
      personality_group = [1, "�D�F", "�z�C", "�z�C"]
    when 39 # Lv.13
      personality_group = [1, "�D�F", "�z�C", "�z�C"]
      
    # -----------------------------------------------------------------------
    #
    # ���C���v/��
    # -----------------------------------------------------------------------
    when 41 # Lv.1
      personality_group = [1, "�����C", "����", "����"]
    when 42 # Lv.3
      personality_group = [1, "�����C", "����", "����"]
    when 43 # Lv.5
      personality_group = [1, "�����C", "����", "����"]
    when 44 # Lv.8
      personality_group = [1, "�����C", "����", "����"]
    when 45 # Lv.10
      personality_group = [1, "�����C", "����", "����"]

    # -----------------------------------------------------------------------
    #
    # ���L���X�g/���F
    # -----------------------------------------------------------------------
    when 47 # Lv.1
      personality_group = [1, "���C", "�]��", "�]��"]
    when 48 # Lv.3
      personality_group = [1, "���C", "�]��", "�]��"]
      
    # -----------------------------------------------------------------------
    #
    # ���i�C�g���A/��
    # -----------------------------------------------------------------------
# �����u�W���v�Ɓu�W���v�����݂��Ă����̂ł��񂸂��L��ɓ���(2014-0819)    
    when 50 # Lv.4
      personality_group = [1, "�W��", "�W��", "�s�v�c"]
    when 51 # Lv.6
      personality_group = [1, "�W��", "�W��", "�s�v�c"]
    when 52 # Lv.8
      personality_group = [1, "�W��", "�W��", "�s�v�c"]
    when 53 # Lv.10
      personality_group = [1, "�W��", "�W��", "�s�v�c"]

    # -----------------------------------------------------------------------
    #
    # ���X���C��/��
    # -----------------------------------------------------------------------
    when 55 # Lv.2
      personality_group = [1, "�V�R", "�_�a", "�_�a"]
    when 56 # Lv.5
      personality_group = [1, "�V�R", "�_�a", "�_�a"]

    # -----------------------------------------------------------------------
    #
    # ���v�`�E�B�b�`/��
    # -----------------------------------------------------------------------
    when 58 # Lv.4
      personality_group = [1, "��i", "�W��", "�W��"]
    when 59 # Lv.8
      personality_group = [1, "��i", "�W��", "�W��"]
    when 60 # Lv.10
      personality_group = [1, "��i", "�W��", "�W��"]
      
    # -----------------------------------------------------------------------
    #
    # ���E�B�b�`/��
    # -----------------------------------------------------------------------
    when 62 # Lv.10
      personality_group = [1, "��i", "�W��", "�W��"]
    when 63 # Lv.13
      personality_group = [1, "��i", "�W��", "�W��"]
      
    # -----------------------------------------------------------------------
    #
    # ���t�@�~���A/��
    # -----------------------------------------------------------------------
    when 72 # Lv.10
      personality_group = [1, "�]��", "�W��", "�W��"]
      
    # -----------------------------------------------------------------------
    #
    # ���f�r��/��
    # -----------------------------------------------------------------------
    when 77 # Lv.12
      personality_group = [1, "�����C", "����", "����"]

    # -----------------------------------------------------------------------
    #
    # ���a�n�r�r
    # -----------------------------------------------------------------------
     when 65 # �T�L���o�X/��@Lv.18
      personality_group = [1, "�z�C", "�z�C", "�z�C"] # �����ł���Ȃ�_�a
      ability_group += ["����������/100"]
     when 66 # �f�r��/�΁@Lv.18
      personality_group = [1, "�����C", "�����C", "�����C"] # �����ł���Ȃ獂��
      ability_group += ["���K��������/100"]
     when 75 # �t���r���A�@Lv.25
      personality_group = [1, "�ƑP", "�ƑP", "�ƑP"] # �����ł���Ȃ獂��
      ability_group += ["�A�j��������/100"]

    # -----------------------------------------------------------------------
    #
    # ���n�E�e�E�d
    # -----------------------------------------------------------------------
    when 68 # ���b�T�[�T�L���o�X/���@Lv.10
      personality_group = [1, "�D�F", "�D�F", "�D�F"]
    when 69 # ���b�T�[�T�L���o�X/���@Lv.15
      personality_group = [1, "�D�F", "�D�F", "�D�F"]
    when 70 # �T�L���o�X/���@Lv.20
      personality_group = [1, "�D�F", "�D�F", "�D�F"]
    when 73 # �v�`�E�B�b�`/���@Lv.16
      personality_group = [1, "�D�F", "�D�F", "�D�F"]
    when 74 # �E�B�b�`/���@Lv.18
      personality_group = [1, "�D�F", "�D�F", "�D�F"]
    end

    # ---------------------------------------------

=end
    
    # ��_�������Ă��Ȃ���Ύ�_�f��������
    if not ability_group.include?("����������/100") \
     and not ability_group.include?("����������/100") \
     and not ability_group.include?("���K��������/100") \
     and not ability_group.include?("�A�j��������/100") \
     and not ability_group.include?("���A��������/100") 
      # ��_�f���̌���
      case rand(4)
      when 0
        ability_group += ["����������/100"]
      when 1
        ability_group += ["����������/100"]
      when 2
        ability_group += ["���K��������/100"]
      when 3
        ability_group += ["�A�j��������/100"]
      end
    end
    
    
    

    # ���i�m��
    if personality == ""
      c = rand(10)
      case personality_group[0]
      when 0 # [6 : 3 : 1]
        if c <= 5
          self.personality = personality_group[1]
        elsif c >= 6 and c <= 8
          self.personality = personality_group[2]
        else
          self.personality = personality_group[3]
        end
      when 1 # [5 : 4 : 1]
        if c <= 4
          self.personality = personality_group[1]
        elsif c >= 5 and c <= 8
          self.personality = personality_group[2]
        else
          self.personality = personality_group[3]
        end
      when 2 # [4 : 3 : 3]
        if c <= 3
          self.personality = personality_group[1]
        elsif c >= 4 and c <= 6
          self.personality = personality_group[2]
        else
          self.personality = personality_group[3]
        end
      end
    else
      # ����������ꍇ�A���̂܂܃G�l�~�[�̐��i�ɂ���B
      self.personality = personality
    end
    
    # �f���m��
    if ability == ["���ݒ�"]
      for i in ability_group
        c = rand(100) + 1
        # ������̎��͊m���ɉ����ďK��
        if i.is_a?(String)
          if c <= i.split(/\//)[1].to_i
            n = $data_ability.search(0, i.split(/\//)[0])
            self.gain_ability(n)
          end
        # �����̎��͊m��ŏK��
        else
          self.gain_ability(i)
        end
      end
    else
      # ����������ꍇ�A���̂܂܃G�l�~�[�̑f���ɂ���B
      for i in ability
        n = i
        n = $data_ability.search(0, i) if i.is_a?(String)
        self.gain_ability(n)
      end
    end

    # �ď̂�ݒ�i�C�x���g��{�X�ł���ꍇ�͏����j
    unless ($data_enemies[@enemy_id].element_ranks[124] == 1 or
     $data_enemies[@enemy_id].element_ranks[126] == 1 or 
     $data_enemies[@enemy_id].element_ranks[128] == 1)
      $msg.defaultname_select(self)
    end
    
    # ���łɏ����F�D�x���m��
    # �����l30�i���x���P�Łj
    self.friendly = 31
    # ����Ɏ푰���̌_���x�ɍ��킹�ĉ�����B
    self.friendly -= $data_SDB[self.class_id].contract_level * 3
    # ����Ƀ��x�����P�オ���Ă��閈�ɉ�����B
    for i in 1..self.level
      self.friendly -= 1
    end
    
  end

end
