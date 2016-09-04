#==============================================================================
# �� RPG::Personality
#------------------------------------------------------------------------------
# �@���i�̏��B$data_personality["���O"]����Q�Ɖ\�B
#==============================================================================
module RPG
  #--------------------------------------------------------------------------
  # �� ���i�̓o�^
  #--------------------------------------------------------------------------
  class Personality_registration
    #--------------------------------------------------------------------------
    # �� ���J�C���X�^���X�ϐ�
    #--------------------------------------------------------------------------
    attr_accessor :id              # id
    attr_accessor :name            # ���O
    attr_accessor :attack_regist   # �U�ߎ��̃��W�X�g�␳
    attr_accessor :defense_regist  # �󂯎��̃��W�X�g�␳
    attr_accessor :talk_pattern    # �D�މ�b�̎��
    attr_accessor :talk_difficulty # ��b��Փx
    attr_accessor :special_attack  # ����U���̎g�p�J������
    
    # �f�[�^�ǋL
    
    #--------------------------------------------------------------------------
    # �� �I�u�W�F�N�g������
    #--------------------------------------------------------------------------
    def initialize(personality_id)
      @id = personality_id
      @name = ""
      @attack_regist = []
      @defense_regist = []
      #��b�^�C�v��[�v��]���������ꍇ�̃����_���I���B
      #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
      #�Ή����鐔�l�����݂�$mood.point�ȉ��Ȃ�I�����ɓ���
      @talk_pattern = [0,0,0,0,0,0,0,0,0]
      #��b��Փx�F���̉�b�ɑ΂���v���̓x������\��
      #���W�X�g�Q�[�W�̖�󐔂ƂȂ�
      #�l���傫���قǂ��̉�b���I�΂ꂽ�ۂɒf��Â炭�Ȃ�
      @talk_difficulty = [3,3,3,3,3,3,3,3,3]
      #�z�[���h�����U�����s���X�C�b�`
      #�P�`�R�i�K����A�K�萔�Ƀ��[�h�l���B����Ǝg�p����悤�ɂȂ�
      @special_attack = [20,40,60]
      setup(personality_id)
    end
    #--------------------------------------------------------------------------
    # �� �Z�b�g�A�b�v
    #--------------------------------------------------------------------------
    def setup(personality_id)
      case personality_id
      when 0
        @name = "�D�F"
        @attack_regist = [2, 2, 3, 3, 4]
        @defense_regist = [0, 0, -1, -2, -3]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 20, 20, 30, 20, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [15,30,45]
      when 1
        @name = "��i"
        @attack_regist = [0, 1, 1, 1, 2]
        @defense_regist = [2, 2, 1, 1, 0]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 40, 40, 50, 30, 50, 70, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [25,45,65]
      when 2
        @name = "����"
        @attack_regist = [2, 2, 1, 1, 0]
        @defense_regist = [3, 2, 1, 0, -1]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 10, 10, 20, 10, 40, 50, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [30,50,70]
      when 3
        @name = "�W��"
        @attack_regist = [0, 0, 0, 0, 1]
        @defense_regist = [0, 0, 0, 0, -1]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 30, 30, 60, 40, 40, 70, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [30,50,70]
      when 4
        @name = "�_�a"
        @attack_regist = [0, 0, 0, 1, 3]
        @defense_regist = [-1, -1, -1, 0, 0]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 10, 20, 30, 40, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [25,45,65]
      when 5
        @name = "�����C"
        @attack_regist = [1, 1, 2, 2, 3]
        @defense_regist = [1, 1, 1, 0, -1]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 40, 20, 30, 30, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 6
        @name = "���C"
        @attack_regist = [-2, -2, -1, 0, 1]
        @defense_regist = [4, 3, 1, -1, -3]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 50, 40, 60, 60, 60, 80, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [35,55,75]
      when 7
        @name = "�z�C"
        @attack_regist = [1, 1, 1, 2, 2]
        @defense_regist = [0, 0, -1, -1, -2]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 0, 0, 40, 30, 50, 70, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 8
        @name = "�Ӓn��"
        @attack_regist = [0, 1, 1, 2, 3]
        @defense_regist = [2, 1, 0, -1, -2]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 30, 0, 10, 10, 30, 50, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [25,45,65]
      when 9
        @name = "�V�R"
        @attack_regist = [-1, -1, 0, 1, 2]
        @defense_regist = [0, 0, -1, -1, -2]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 20, 20, 70, 50, 30, 70, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 10
        @name = "�]��"
        @attack_regist = [-1, -1, -1, 0, 1]
        @defense_regist = [-2, -2, -2, -3, -3]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 60, 60, 60, 60, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [15,30,45]
      when 11
        @name = "����"
        @attack_regist = [3, 1, 0, -1, -2]
        @defense_regist = [3, 1, 0, -1, -2]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 10, 30, 30, 30, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,45,70]
      when 12
        @name = "�|��"
        @attack_regist = [2, 3, 3, 4, 4]
        @defense_regist = [-1, -2, -3, -4, -5]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 0, 0, 0, 0, 50, 20, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [10,25,40]
      when 13
        @name = "�Â���"
        @attack_regist = [-1, 2, 3, 3, 3]
        @defense_regist = [0, 0, 0, -1, -1]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 20, 20, 40, 0, 50, 20, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 14
        @name = "�s�v�c"
        @attack_regist = [2, -3, 3, -4, 4]
        @defense_regist = [-2, 3, -3, 4, -4]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 0, 0, 0, 0, 0, 0, 50]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [10,20,30]
      when 15
        @name = "�^�ʖ�"
        @attack_regist = [0, 1, 1, 2, 2]
        @defense_regist = [1, 1, 1, 0, 0]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 20, 20, 30, 20, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 16
        @name = "�r��"
        @attack_regist = [1, 2, 2, 3, 4]
        @defense_regist = [0, 0, 0, -1, -1]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 20, 20, 30, 20, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 17
        @name = "���"
        @attack_regist = [0, 0, 0, 1, 1]
        @defense_regist = [2, 2, 3, 3, 4]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 20, 20, 30, 20, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 18
        @name = "�ƑP" # ���t���r���A�̐��i
        @attack_regist = [2, 3, 3, 4, 4]
        @defense_regist = [3, 1, -2, -3, -3]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 0, 0, 0, 0, 20, 50, 255]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 19
        @name = "�C��" # �����W�F�I�̐��i�@�����C�x�[�X
        @attack_regist = [1, 1, 2, 2, 3]
        @defense_regist = [1, 1, 1, 0, -1]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 40, 20, 30, 30, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 20
        @name = "���C" # ���l�C�W�������W�̐��i�@�_�a�x�[�X
        @attack_regist = [0, 0, 0, 1, 3]
        @defense_regist = [-1, -1, -1, 0, 0]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 10, 20, 30, 40, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [25,45,65]
      when 21
        @name = "�A�C" # �����[�K�m�b�g�̐��i�@�V�R�x�[�X
        @attack_regist = [-1, -1, 0, 1, 2]
        @defense_regist = [0, 0, -1, -1, -2]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 20, 20, 70, 50, 30, 70, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 22
        @name = "����" # ���M���S�[���̐��i�@�����x�[�X
        @attack_regist = [3, 1, 0, -1, -2]
        @defense_regist = [3, 1, 0, -1, -2]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 10, 30, 30, 30, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,45,70]
      when 23
        @name = "���M" # ���V���t�F�̐��i�@��i�x�[�X
        @attack_regist = [0, 1, 1, 1, 2]
        @defense_regist = [2, 2, 1, 1, 0]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 40, 40, 50, 30, 50, 70, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [25,45,65]
      when 24
        @name = "����" # �����[�~���̐��i�@�^�ʖڃx�[�X
        @attack_regist = [0, 1, 1, 2, 2]
        @defense_regist = [1, 1, 1, 0, 0]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 20, 20, 30, 20, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      when 25
        @name = "�I����" # �����F���~�B�[�i�̐��i�@�|���x�[�X
        @attack_regist = [2, 3, 3, 4, 4]
        @defense_regist = [-1, -2, -3, -4, -5]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 0, 0, 0, 0, 50, 20, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [10,25,40]
      else
        @name = "���ݒ�"
        @attack_regist = [0, 0, 0, 1, 1]
        @defense_regist = [2, 2, 3, 3, 4]
        #["�D��","����","�E��E","�E��A","����","��d","�z��","�}��","�_��"]
        @talk_pattern = [0, 0, 20, 20, 30, 20, 40, 60, 100]
        @talk_difficulty = [3, 4, 4, 4, 4, 3, 4, 6, 3]
        @special_attack = [20,40,60]
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �f�����܂Ƃ�
  #--------------------------------------------------------------------------
  class Personality
    #--------------------------------------------------------------------------
    # �� ���J�C���X�^���X�ϐ�
    #--------------------------------------------------------------------------
    attr_accessor :data
    #--------------------------------------------------------------------------
    # �� �I�u�W�F�N�g������
    #--------------------------------------------------------------------------
    def initialize
      @data = []
      @max = 50 #���i�̓o�^�����
      for i in 0..@max
        @data[i] = Personality_registration.new(i)
      end
    end
    #--------------------------------------------------------------------------
    # �� ���i�̎擾
    # personality_name : ���i��(id�����Ă��Ή��\)
    #--------------------------------------------------------------------------
    def [](personality_name)
      # ������ȊO�̏ꍇ�������̏ꍇ
      unless personality_name.is_a?(String)
        return @data[personality_name]
      end
      # �ȉ��A�����񌟍�
      for data in @data
        if data.name == personality_name
          return data
        end
      end
      # �o�^���ꂽ���O�������ꍇ
      return @data[0]
    end
    #--------------------------------------------------------------------------
    # �� ���iid�̌���
    #    type : �����w��   variable : ������
    #--------------------------------------------------------------------------
    def search(type, variable)
      case type
      when 0 # ���O�łh�c����������
        for data in @data
          if data.name == variable
            n = data.id
            break
          end
        end
      end
      return n
    end
  end
end