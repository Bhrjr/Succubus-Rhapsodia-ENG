#==============================================================================
# �� RPG::SDB
#------------------------------------------------------------------------------
# �@�f���̏��B$data_SDB[id]����Q�Ɖ\�B
#==============================================================================
module RPG
  #--------------------------------------------------------------------------
  # �� �푰�l�̓o�^
  #--------------------------------------------------------------------------
  class Succubus_registration
    #--------------------------------------------------------------------------
    # �� ���J�C���X�^���X�ϐ�
    #--------------------------------------------------------------------------  
    attr_accessor :name             # �푰��
    attr_accessor :class_id         # �N���XID
    attr_accessor :exp_type         # �o���l�e�[�u���^�C�v
    attr_accessor :graphics         # �O���t�B�b�N
    attr_accessor :maxhp            # �ő�d�o 
    attr_accessor :maxsp            # �ő�u�o
    attr_accessor :str              # ����
    attr_accessor :dex              # ��p��
    attr_accessor :agi              # �f����
    attr_accessor :int              # ���_��
    attr_accessor :atk              # ����
    attr_accessor :pdef             # �E�ϗ�
    attr_accessor :mdef             # �����S
    attr_accessor :digest           # �󕠗�
    attr_accessor :absorb           # �z����
    attr_accessor :maxrune          # �ő僋�[������
    attr_accessor :d_power          # ���̖���
    attr_accessor :next_rank_id     # �������N�h�c
    attr_accessor :contract_level   # �_���x
    attr_accessor :years_type       # �N��^�C�v
    attr_accessor :legless          # ���g�p�s��
    attr_accessor :tail             # �U���Ɏg����K���̗L��
    #(�Eyears_type:�ڈ� 1:12�ȉ�, 2:15�ȉ�, 3:20�ȉ�, 4:29�ȉ�, 5:30�ȏ� )
    attr_accessor :bust_size        # �o�X�g�T�C�Y
    #(�Ebust_size :�ڈ� 1:A�ȉ�, 2:B, 3:C, 4:D, 5:E�ȏ� )
    attr_accessor :hold_rate        # �z�[���h�Z�g�p�̕p�x
    attr_accessor :exp              # �擾�o���l
    attr_accessor :gold             # �擾���z
    attr_accessor :default_name_self# �f�t�H���g�l�[��(�����̈�l��)
    attr_accessor :default_name_hero# �f�t�H���g�l�[��(�Ύ�l���̓�l��)
    
    #--------------------------------------------------------------------------
    # �� �I�u�W�F�N�g������
    #--------------------------------------------------------------------------
    def initialize(race_id)
      @next_rank_id = 0
      @years_type = 1
      @legless = false
      @tail = nil
      @bust_size = 0
      @hold_rate = []
      @exp = 10
      @gold = 10
      setup(race_id)
    end
    #--------------------------------------------------------------------------
    # �� �푰�l�̎擾
    #     race_id : �푰 ID
    #--------------------------------------------------------------------------
    def setup(race_id)

      @class_id = race_id
      
      case race_id
      #------------------------------------------------------------------------
      # �����l��
      #
      # ��l���B�u�o�������A���Ƃ͎����ĕ��ϓI�B
      # �����x�▲�̖��͔͂������Ȃ����߂ɂO�B
      #------------------------------------------------------------------------
      when 2 #�l��/�j
        @name, @graphics = "Hu��an", "hero1"
        @class_id, @exp_type = race_id, 2
        @maxhp, @maxsp = 300, 600
        @str, @dex, @agi, @int = 100, 50, 80, 50
        @atk, @pdef, @mdef = 50, 50, 100
        @digest, @absorb = 0, 0
        @maxrune, @d_power = 5, 0
        @years_type, @bust_size = 3, 0
        @default_name_self = "�l"
        @default_name_hero = "�N"
              
      #------------------------------------------------------------------------
      # �����T�L���o�X��
      #
      # ���b�T�[�͏��X����Ȃ����A���̃Q�[���ɒu���Ă̐퓬�v���̊�{�ƂȂ�푰�B
      # ���ϐ����ȏ�̔\�͂������A�����N���オ�閈�ɖ����x��z���ʂ��d���Ȃ�B
      #------------------------------------------------------------------------
      when 5,6 
        @name = "Lesser Succubus "
        @exp_type = 1
        @maxhp, @maxsp = 350, 300
        @str, @dex, @agi, @int = 60, 50, 45, 42
        @atk, @pdef, @mdef = 90, 40, 100
        @digest, @absorb = 4, 150
        @maxrune, @d_power = 3, 1
        @years_type, @bust_size = 3, 3
        @tail = true
        @hold_rate[0] = [682,687,695] #������
        @hold_rate[1] = [683,684,689,697,700,710] #���[�h20�O��ŉ���
        @hold_rate[2] = [688,698,701,705,706,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,692,696,702,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @exp = 10
        @gold = 8
        case race_id 
        when 5 # ��
          @graphics = "lesser_succubus1-1"
          @next_rank_id = 10
          @default_name_self = "�A�^�V"
          @default_name_hero = "���Z����"
        when 6 # ��
          @graphics = "lesser_succubus1-2"
          @next_rank_id = 11
          @default_name_self = "�A�^�V"
          @default_name_hero = "���Z����"
        end
      #------------------------------------------------------------------------
      when 10,11 
        @name = "Succubus"
        @exp_type = 1
        @maxhp, @maxsp =  380, 360
        @str, @dex, @agi, @int = 90, 70, 85, 60
        @atk, @pdef, @mdef = 120, 65, 100
        @digest, @absorb = 5, 320
        @years_type, @bust_size = 3, 4
        @tail = true
        @maxrune, @d_power = 3, 2
        @hold_rate[0] = [682,687,697] #������
        @hold_rate[1] = [683,684,689,695,700,710] #���[�h20�O��ŉ���
        @hold_rate[2] = [688,698,701,705,706,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,692,696,702,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 10
        @exp = 18
        @gold = 14
        case race_id 
        when 10 # ��
          @graphics = "succubus1-1"
          @next_rank_id = 15
          @default_name_self = "�A�^�V"
          @default_name_hero = "�L�~"
        when 11 # ��
          @graphics = "succubus1-2"
          @next_rank_id = 16
          @default_name_self = "�A�^�V"
          @default_name_hero = "�L�~"
        end
      #------------------------------------------------------------------------
      when 15,16 
        @name = "Succubus Lord "
        @exp_type = 1
        @maxhp, @maxsp =  400, 380
        @str, @dex, @agi, @int = 100, 100, 100, 82
        @atk, @pdef, @mdef = 140, 80, 100
        @digest, @absorb = 6, 500
        @years_type, @bust_size = 4, 5
        @tail = true
        @maxrune, @d_power = 3, 3
        @hold_rate[0] = [682,687,698] #������
        @hold_rate[1] = [683,684,689,695,697,700,710] #���[�h20�O��ŉ���
        @hold_rate[2] = [688,701,705,706,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,692,696,702,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 20
        @exp = 26
        @gold = 20
        case race_id 
        when 15 # ��
          @graphics = "succubus_lord2-1"
          @default_name_self = "��"
          @default_name_hero = "�M��"
        when 16 # ��
          @graphics = "succubus_lord2-2"
          @default_name_self = "��"
          @default_name_hero = "�M��"
        end
        
      #------------------------------------------------------------------------
      # �����f�r����
      #
      # �C���v�͑f���������邪�A�f�r���ȍ~����͒ᑬ�ɂȂ�A�퓬�͂��オ��B
      # �T�L���o�X��ɔ�ׁA���@�𑽂��o����B��ʎ�قǖ����x��z���ʂ��d���Ȃ�B
      #------------------------------------------------------------------------
      when 21,22 
        @name = "I��p"
        @exp_type = 1
        @maxhp, @maxsp = 290, 250
        @str, @dex, @agi, @int = 100, 38, 75, 38
        @atk, @pdef, @mdef = 60, 40, 100
        @digest, @absorb = 3, 110
        @maxrune, @d_power = 3, 1
        @years_type, @bust_size = 1, 1
        @tail = true
        @hold_rate[0] = [682,695] #������
        @hold_rate[1] = [683,684,687,689,700,710] #���[�h20�O��ŉ���
        @hold_rate[2] = [688,701,702,705,706,707,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [697,698,691,692,696,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @exp = 10
        @gold = 5
        case race_id 
        when 21 # ��
          @graphics = "imp0-1"
          @next_rank_id = 26
          @default_name_self = "�����Z�k��"
          @default_name_hero = "���Ɂ[�����"
        when 22 # ��
          @graphics = "imp0-2"
          @next_rank_id = 27
          @default_name_self = "�{�N"
          @default_name_hero = "��l����"
        end
      #------------------------------------------------------------------------
      when 26,27 # �f�r��
        @name = "Devil "
        @exp_type = 1
        @maxhp, @maxsp = 370, 370
        @str, @dex, @agi, @int = 110, 55, 65, 100
        @atk, @pdef, @mdef = 110, 62, 100
        @digest, @absorb = 5, 320
        @years_type, @bust_size = 3, 4
        @tail = true
        @hold_rate[0] = [682,683,684] #������
        @hold_rate[1] = [687,688,689,700,710] #���[�h20�O��ŉ���
        @hold_rate[2] = [695,697,698,701,702,705,706,707,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,692,696,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @maxrune, @d_power = 3, 2
        @contract_level = 10
        @exp = 18
        @gold = 14
        case race_id 
        when 26 # ��
          @graphics = "devil1-1"
          @next_rank_id = 31
          @default_name_self = "������"
          @default_name_hero = "�Z����"
        when 27 # ��
          @graphics = "devil1-2"
          @next_rank_id = 32
          @default_name_self = "��"
          @default_name_hero = "��l����"
        end
      #------------------------------------------------------------------------
      when 31,32 # �f�\����
        @name = "De��on"
        @exp_type = 1
        @maxhp, @maxsp = 400, 400
        @str, @dex, @agi, @int = 150, 75, 65, 140
        @atk, @pdef, @mdef = 135, 80, 100
        @digest, @absorb = 6, 500
        @years_type, @bust_size = 4, 5
        @tail = true
        @hold_rate[0] = [682,683,698] #������
        @hold_rate[1] = [687,684,688,689,700,710] #���[�h20�O��ŉ���
        @hold_rate[2] = [695,696,697,692,701,702,705,706,707,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @maxrune, @d_power = 3, 3
        @contract_level = 20
        @exp = 26
        @gold = 20
        case race_id 
        when 31 # ��
          @graphics = "daemon2-1"
          @default_name_self = "������"
          @default_name_hero = "�V��"
        when 32 # ��
          @graphics = "daemon2-2"
          @default_name_self = "��"
          @default_name_hero = "��l����"
        end
        
      #------------------------------------------------------------------------
      # �����E�B�b�`��
      #
      # �ϋv�E�f�����͒��r���[�����A���_�͂̐L�т��ǂ��A���@�O��̍U�߂����ӁB
      # �T���X�L����������������A�퓬��������x�ł���B���̂܂܂ł͊�p�n�R�B
      #------------------------------------------------------------------------
      when 37,38 
        @name = "Little Witch"
        @exp_type = 2
        @maxhp, @maxsp = 200, 230
        @str, @dex, @agi, @int = 30, 40, 40, 80
        @atk, @pdef, @mdef = 45, 30, 100
        @digest, @absorb = 2, 100
        @maxrune, @d_power = 3, 1
        @years_type, @bust_size = 2, 2
        @hold_rate[0] = [687,688] #������
        @hold_rate[1] = [682,683,689,695] #���[�h20�O��ŉ���
        @hold_rate[2] = [684,698,700,701,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,692,696,697,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @exp = 9
        @gold = 10
        case race_id 
        when 37 # ��
          @graphics = "petit_witch0-1"
          @next_rank_id = 42
          @default_name_self = "�{�N"
          @default_name_hero = "���Z����"
        when 38 # ��
          @graphics = "petit_witch0-2"
          @next_rank_id = 43
          @default_name_self = "�{�N"
          @default_name_hero = "���Z����"
        end
      #------------------------------------------------------------------------
      when 42,43 
        @name = "Witch "
        @exp_type = 2
        @maxhp, @maxsp = 310, 350
        @str, @dex, @agi, @int = 65, 50, 50, 140
        @atk, @pdef, @mdef = 70, 50, 100
        @digest, @absorb = 3, 200
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 3, 3
        @hold_rate[0] = [687,688,695] #������
        @hold_rate[1] = [682,683,689,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [684,692,697,700,701,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,696,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 8
        @exp = 17
        @gold = 18
        case race_id 
        when 42 # ��
          @graphics = "witch1-1"
          @default_name_self = "��"
          @default_name_hero = "�N"
        when 43 # ��
          @graphics = "witch1-2"
          @default_name_self = "�l"
          @default_name_hero = "�N"
       end

      #------------------------------------------------------------------------
      # �����L���X�g��
      #
      # �f����������������x�ŁA���Ƃ͕��ψȉ��B�퓬�ɂ͌����Ă��Ȃ��푰�B
      # �T���X�L�������x���X�L�����o�������x�̌��肪�����ƁA�T���Ɍ����Ă���B
      #------------------------------------------------------------------------
      when 53,54
        @name = "Caster"
        @exp_type = 2
        @maxhp, @maxsp = 220, 220
        @str, @dex, @agi, @int = 30, 35, 60, 30
        @atk, @pdef, @mdef = 40, 40, 100
        @digest, @absorb = 2, 50
        @maxrune, @d_power = 3, 1
        @years_type, @bust_size = 2, 1
        @hold_rate[0] = [689,695] #������
        @hold_rate[1] = [687,688] #���[�h20�O��ŉ���
        @hold_rate[2] = [682,683,684,697,698] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,692,700,701,702,710,711,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [696,705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 2
        @exp = 7
        @gold = 15
        case race_id 
        when 53 # ��
          @graphics = "cast0-1"
          @default_name_self = "�킽��"
          @default_name_hero = "���Z����"
        when 54 # ��
          @graphics = "cast0-1"
          @maxhp, @maxsp = 400, 300
          @str, @dex, @agi, @int = 100, 100, 60, 100
          @atk, @pdef, @mdef = 200, 40, 100
          @default_name_self = "��"
          @default_name_hero = "��l����"
        end

      #------------------------------------------------------------------------
      # �����X���C����
      #
      # �X�e�[�^�X�͉����������ψȉ��B���̑��薞���x�̌���͍Œ�l�B
      # ���[�����T����ł��邽�߁A�J�X�^�}�C�Y��������B
      #------------------------------------------------------------------------
      when 63 
        @name = "Slave "
        @exp_type = 1
        @maxhp, @maxsp = 200, 200
        @str, @dex, @agi, @int = 30, 30, 30, 30
        @atk, @pdef, @mdef = 30, 30, 100
        @digest, @absorb = 1, 30
        @maxrune, @d_power = 5, 1
        @years_type, @bust_size = 2, 1
        @hold_rate[0] = [682,683,687,688] #������
        @hold_rate[1] = [684,689,691,692,697,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [695,700,701,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [696,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 8
        @exp = 5
        @gold = 0
        case race_id 
        when 63 # ��
          @graphics = "slave0-1"
          @default_name_self = "�킽��"
          @default_name_hero = "�Z�l"
        end

      #------------------------------------------------------------------------
      # �����i�C�g���A��
      #
      # �W�Q�X�L�������̎푰�ł���A���_�͂Ƒf����������������������ȊO�͕��}�B
      # �P�̂ł͐퓬����ŁA�����₤�p�[�e�B�\�z���d�v�Ȏ푰�B
      #------------------------------------------------------------------------
      when 74,75
        @name = "Night��are"
        @exp_type = 3
        @maxhp, @maxsp = 330, 300
        @str, @dex, @agi, @int = 35, 47, 110, 80
        @atk, @pdef, @mdef = 75, 58, 100
        @digest, @absorb = 3, 180
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 3, 3
        @hold_rate[0] = [684,692,695] #������
        @hold_rate[1] = [687,688,689,691,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [696,697] #���[�h40�O��ŉ���
        @hold_rate[3] = [682,683,700,701,702,710,711,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 4
        @exp = 14
        @gold = 8
        case race_id 
        when 74 # ��
          @graphics = "nightmare1-1"
          @default_name_self = "��"
          @default_name_hero = "���Ɂ[����"
        when 75 # ��
          @graphics = "nightmare1-2"
          @default_name_self = "��"
          @default_name_hero = "���Ɂ[����"
        end

      #------------------------------------------------------------------------
      # �����X���C����
      #
      # ���ϋv�Ƃ���Ȃ�̉ΉA��p�f���������f�����͍Œ�B���_�͂����\�Ⴂ�B
      # ���W�X�g�ɑ΂��Ĕ��Ɏキ�A�����x�̌�����d�߂ƁA���Ȃ�Ȃ������B
      #------------------------------------------------------------------------
      when 80 
        @name = "Sli��e"
        @exp_type = 3
        @maxhp, @maxsp = 500, 350
        @str, @dex, @agi, @int = 50, 50, 20, 25
        @atk, @pdef, @mdef = 90, 85, 100
        @digest, @absorb = 4, 230
        @years_type, @bust_size = 3, 4
        @maxrune, @d_power = 3, 2
        @hold_rate[0] = [682,683,695] #������
        @hold_rate[1] = [687,688,697,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [684,691,692,700,701,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [689,696,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 4
        @exp = 14
        @gold = 1
        case race_id 
        when 80 # ��
          @graphics = "slime1-1"
          @default_name_self = "������"
          @default_name_hero = "���ɂ�����"
        end
      #------------------------------------------------------------------------
      # ���S�[���h�X���C��
      #
      # �X���C�����������������悤�ȃX�e�[�^�X�����B
      # ���̕��A�����x�̌���͑��߁B
      #------------------------------------------------------------------------
      when 90
        @name = "Gold Sli��e "
        @exp_type = 3
        @maxhp, @maxsp = 480, 310
        @str, @dex, @agi, @int = 50, 50, 20, 60
        @atk, @pdef, @mdef = 90, 110, 100
        @digest, @absorb = 4, 350
        @years_type, @bust_size = 3, 4
        @maxrune, @d_power = 3, 3
        @hold_rate[0] = [682,683,695] #������
        @hold_rate[1] = [687,688,697,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [684,691,692,700,701,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [689,696,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 20
        @exp = 20
        @gold = 50
        case race_id 
        when 90 # ��
          @graphics = "gold_slime1-1"
          @default_name_self = "�킽��"
          @default_name_hero = "���Z����"
        end

      #------------------------------------------------------------------------
      # �����t�@�~���A��
      #
      # �S�̓I�ɕ��ς���≺�B�L���X�g�ɔ�ׂ�Ƃ��퓬�I�B
      # �T���X�L�������x���X�L�����o�������x�̌��肪�����ƁA�T���Ɍ����B
      #------------------------------------------------------------------------
      when 96,97
        @name = "Familiar"
        @exp_type = 3
        @maxhp, @maxsp = 240, 220
        @str, @dex, @agi, @int = 30, 65, 40, 50
        @atk, @pdef, @mdef = 50, 40, 100
        @digest, @absorb = 2, 90
        @maxrune, @d_power = 3, 1
        @years_type, @bust_size = 2, 1
        @tail = true
        @hold_rate[0] = [687,688,695] #������
        @hold_rate[1] = [682,683,697,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [684,691,692,700,701,702,710,711,712] #���[�h40�O��ŉ���
        @hold_rate[3] = [689,696] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 8
        @exp = 10
        @gold = 9
        case race_id 
        when 96 # ��
          @graphics = "familiar0-1"
          @default_name_self = "����"
          @default_name_hero = "����l�l"
        when 97 # ��
          @graphics = "familiar0-2"
          @default_name_self = "����"
          @default_name_hero = "�}�X�^�["
          @hold_rate[1] += [710,711,712]
        end

      #------------------------------------------------------------------------
      # �������[�E���t��
      #
      # ���͂̍����z�[���h�A�^�b�J�[�B�C���T�[�g�n�������B
      # �f�������������A��p���A���_�͂͒Ⴍ�����x�̌�������߁B
      #------------------------------------------------------------------------
      when 100,101
        @name = "Werewolf"
        @exp_type = 3
        @maxhp, @maxsp = 350, 340
        @str, @dex, @agi, @int = 150, 50, 105, 22
        @atk, @pdef, @mdef = 70, 50, 100
        @digest, @absorb = 4, 210
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 3, 2
        @tail = true
        @hold_rate[0] = [682,684,687,688] #������
        @hold_rate[1] = [683,695,700,701] #���[�h20�O��ŉ���
        @hold_rate[2] = [689,697,698,702] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,692,696,710,711,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 8
        @exp = 16
        @gold = 4
        case race_id 
        when 100 # ��
          @graphics = "werewolf1-1"
          @default_name_self = "�ڂ�"
          @default_name_hero = "����l"
        when 101 # ��
          @graphics = "werewolf1-2"
          @default_name_self = "����"
          @default_name_hero = "����l"
        end
        
      #------------------------------------------------------------------------
      # �������[�L���b�g��
      #
      # �f�������������͂����������B���͕��ϐ����B��p�n�R�ɂȂ肪���B
      # �ł��邱�Ƃ͑����̂ŃJ�X�^�}�C�Y����B
      #------------------------------------------------------------------------
      when 104,105
        @name = "Werecat "
        @exp_type = 3
        @maxhp, @maxsp = 300, 300
        @str, @dex, @agi, @int = 90, 80, 110, 70
        @atk, @pdef, @mdef = 70, 50, 100
        @digest, @absorb = 3, 160
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 3, 1
        @tail = true
        @hold_rate[0] = [684,689,695] #������
        @hold_rate[1] = [682,683,687,688] #���[�h20�O��ŉ���
        @hold_rate[2] = [692,697,698,700,701,705,706,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,696,702,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 8
        @exp = 15
        @gold = 15
        case race_id 
        when 104 # ��
          @graphics = "werecat1-1"
          @default_name_self = "������"
          @default_name_hero = "���ɂ�����"
        when 105 # ��
          @graphics = "werecat1-2"
          @default_name_self = "������"
          @default_name_hero = "���ɂ�����"
        end
        
      #------------------------------------------------------------------------
      # �����S�u������
      #
      # �S�u�����͐��̓A�^�b�J�[�Ɋ�����C���v�̂悤�ȃX�e�[�^�X�B
      # �M�����O�R�}���_�[�͈��芴���ł��邪�U�����\�͂����܂ŁB
      #------------------------------------------------------------------------
      when 108
        @name = "Goblin"
        @exp_type = 2
        @maxhp, @maxsp = 290, 260
        @str, @dex, @agi, @int = 120, 50, 80, 20
        @atk, @pdef, @mdef = 70, 40, 100
        @digest, @absorb = 3, 160
        @maxrune, @d_power = 3, 1
        @years_type, @bust_size = 1, 1
        @hold_rate[0] = [684,695] #������
        @hold_rate[1] = [682,683,687,688,700,710] #���[�h20�O��ŉ���
        @hold_rate[2] = [689,692,697,698,701,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,696,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 4
        @exp = 12
        @gold = 10
        case race_id 
        when 108 # ��
          @graphics = "goblin0-1"
          @next_rank_id = 111
          @default_name_self = "������"
          @default_name_hero = "�Ɂ[�����"
        end
      #------------------------------------------------------------------------
      when 111
        @name = "Goblin Leader "
        @exp_type = 2
        @maxhp, @maxsp = 350, 320
        @str, @dex, @agi, @int = 110, 50, 80, 90
        @atk, @pdef, @mdef = 95, 70, 100
        @digest, @absorb = 4, 300
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 1, 1
        @hold_rate[0] = [687,688] #������
        @hold_rate[1] = [682,683,684,695,700,710] #���[�h20�O��ŉ���
        @hold_rate[2] = [689,692,697,698,701,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,696,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 12
        @exp = 17
        @gold = 18
        case race_id 
        when 111 # ��
          @graphics = "gangcommander0-1"
          @default_name_self = "������"
          @default_name_hero = "�Ɂ[����"
        end

      #------------------------------------------------------------------------
      # �����v���[�X�e�X��
      #
      # �ϋv���΂��B�������U�����\�͖����ɓ������B
      # �񕜎�i���L�x�����A�z�[���h�ɂ͎キ����������₷���B
      #------------------------------------------------------------------------
      when 118
        @name = "Priestess "
        @exp_type = 3
        @maxhp, @maxsp = 380, 340
        @str, @dex, @agi, @int = 5, 5, 30, 120
        @atk, @pdef, @mdef = 5, 150, 100
        @digest, @absorb = 3, 230
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 3, 2
        @hold_rate[0] = [] #������
        @hold_rate[1] = [] #���[�h20�O��ŉ���
        @hold_rate[2] = [689,695] #���[�h40�O��ŉ���
        @hold_rate[3] = [682,683,684,687,688,691,692,696,697,698,700,701,702,710,711,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 15
        @exp = 14
        @gold = 17
        case race_id 
        when 118 # ��
          @graphics = "priestess1-1"
          @default_name_self = "��"
          @default_name_hero = "�M��"
        end

      #------------------------------------------------------------------------
      # �����J�[�X���C�K�X��
      #
      # ����o�X�e�n�E�B�b�`�B
      # �E�B�b�`����p�ł͂Ȃ����̂́A�f�̍U�����\�̓E�B�b�`�ȏ�B
      #------------------------------------------------------------------------
      when 122
        @name = "Cursed Magus"
        @exp_type = 3
        @maxhp, @maxsp = 310, 350
        @str, @dex, @agi, @int = 70, 50, 40, 140
        @atk, @pdef, @mdef = 92, 50, 100
        @digest, @absorb = 3, 270
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 4, 4
        @hold_rate[0] = [682,683,687,688,689] #������
        @hold_rate[1] = [684,692,695,697,698,710,711] #���[�h20�O��ŉ���
        @hold_rate[2] = [691,700,701,712] #���[�h40�O��ŉ���
        @hold_rate[3] = [696,702] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 8
        @exp = 16
        @gold = 16
        case race_id 
        when 122 # ��
          @graphics = "cursemagus2-1"
          @default_name_self = "�A�^�V"
          @default_name_hero = "�A�i�^"
        end
        
      #------------------------------------------------------------------------
      # �����A�����E�l��
      #
      # ���͂̍����A�^�b�J�[�B�f�����ȊO�͕��ϓI�Ȕ\�͒l�B
      # �y���}���`�X�g�z�ɂ�荂���[�h���̔����͂�����B
      #------------------------------------------------------------------------
      when 126,127
        @name = "Alraune "
        @exp_type = 3
        @maxhp, @maxsp = 370, 320
        @str, @dex, @agi, @int = 80, 80, 25, 50
        @atk, @pdef, @mdef = 100, 70, 100
        @digest, @absorb = 4, 300
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 3, 3
        @hold_rate[0] = [689] #������
        @hold_rate[1] = [687,688,695,698,718] #���[�h20�O��ŉ���
        @hold_rate[2] = [682,683,697,700,701,710,711,717,719] #���[�h40�O��ŉ���
        @hold_rate[3] = [684,691,692,696,702,712,715,716] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707] #���[�h100�ŉ���
        @contract_level = 6
        @exp = 16
        @gold = 8
        case race_id 
        when 126 # ��
          @graphics = "alraune1-1"
          @default_name_self = "�킽��"
          @default_name_hero = "���ɂ�����"
        when 127 # ��
          @graphics = "alraune1-2"
          @default_name_self = "��"
          @default_name_hero = "���Z�l"
        end

      #------------------------------------------------------------------------
      # �����}�^���S��
      #
      # �ݑ��^�o�X�e�T���B�i�C�g���A�Ƃ͈Ⴂ�A�����̃o�X�e�������_���ɕt�����B
      # �ϋv�͂��������A�Η͂͂���܂�Ƃ��������B�i�C�g���A�̑��݌݊��B
      #------------------------------------------------------------------------
      when 133
        @name = "Matango "
        @exp_type = 3
        @maxhp, @maxsp = 420, 310
        @str, @dex, @agi, @int = 35, 47, 35, 60
        @atk, @pdef, @mdef = 80, 90, 100
        @digest, @absorb = 3, 280
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 4, 3
        @hold_rate[0] = [687,688,695] #������
        @hold_rate[1] = [682,683,689,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [684,697,700,701,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,692,696,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 6
        @exp = 15
        @gold = 8
        case race_id 
        when 133 # ��
          @graphics = "matango2-1"
          @default_name_self = "��"
          @default_name_hero = "�M��"
        end
        
      #------------------------------------------------------------------------
      # �����_�[�N�G���W�F����
      #
      # �퓬�x���ƍU���̗����������^�C�v�B
      # �E�B�b�`��J�[�X���C�K�X����p�ł͖������A�P�̂ł��\���ȉΗ͂����B
      #------------------------------------------------------------------------
      when 137
        @name = "Dark Angel"
        @exp_type = 3
        @maxhp, @maxsp = 310, 350
        @str, @dex, @agi, @int = 70, 80, 95, 80
        @atk, @pdef, @mdef = 100, 50, 100
        @digest, @absorb = 3, 220
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 3, 3
        @hold_rate[0] = [689,695,698] #������
        @hold_rate[1] = [684,687,688,692,697] #���[�h20�O��ŉ���
        @hold_rate[2] = [682,683,691,700,701,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [696,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 10
        @exp = 17
        @gold = 15
        case race_id 
        when 137 # ��
          @graphics = "dark_angel1-1"
          @default_name_self = "�킽����"
          @default_name_hero = "���Ȃ�"
        end
        
      #------------------------------------------------------------------------
      # �����K�[�S�C����
      #
      # �E�ϗ͂��f�ō��������y���^�C�v�B������p���������ȊO�͂��������B
      # �U���\�͖͂����͂Ȃ����A�U���X�L���ɖR���������܂ŋ����͂Ȃ��B
      #------------------------------------------------------------------------
      when 141
        @name = "Gargoyle"
        @exp_type = 3
        @maxhp, @maxsp = 380, 340
        @str, @dex, @agi, @int = 90, 45, 60, 70
        @atk, @pdef, @mdef = 80, 135, 100
        @digest, @absorb = 3, 240
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 3, 4
        @tail = true
        @hold_rate[0] = [684,695] #������
        @hold_rate[1] = [682,683,687,688,696,698,700,701,710,711] #���[�h20�O��ŉ���
        @hold_rate[2] = [692,697,702,705,706,712] #���[�h40�O��ŉ���
        @hold_rate[3] = [689,691,707] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 10
        @exp = 17
        @gold = 10
        case race_id 
        when 141 # ��
          @graphics = "gargoyle1-1"
          @default_name_self = "������"
          @default_name_hero = "�}�X�^�["
        end
        
      #------------------------------------------------------------------------
      # �����~�~�b�N��
      #
      # �ϋv�^�x���^�C�v�B�E�B�b�`�ƃK�[�S�C���𑫂��ĂQ�Ŋ������悤�Ȑ��\�B
      # �U�����\�����@�ŋ������Đ키���Ƃ��O��B
      #------------------------------------------------------------------------
      when 145,146
        @name = "Mi��ic"
        @exp_type = 3
        @maxhp, @maxsp = 360, 350
        @str, @dex, @agi, @int = 70, 50, 40, 110
        @atk, @pdef, @mdef = 80, 110, 100
        @digest, @absorb = 3, 270
        @maxrune, @d_power = 3, 2
        @years_type, @bust_size = 3, 3
        @hold_rate[0] = [697,698] #������
        @hold_rate[1] = [684,687,688,689,691,692,695,710,711] #���[�h20�O��ŉ���
        @hold_rate[2] = [682,683,700,701,712] #���[�h40�O��ŉ���
        @hold_rate[3] = [696,702] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 12
        @exp = 18
        @gold = 22
        case race_id 
        when 145 # ��
          @graphics = "mimic1-1"
          @default_name_self = "���^�V"
          @default_name_hero = "���Z����"
        when 146 # ��
          @graphics = "mimic1-2"
          @default_name_self = "�킽����"
          @default_name_hero = "�V�������"
        end
        
      #------------------------------------------------------------------------
      # �����^�}����
      #
      # �f���y�����z�ɂ��A���ϋv�ݑ��A�^�b�J�[�ƒ�ϋv�����A�^�b�J�[�̊�����B
      # �g�����Ȃ��͓̂�����A�X�e�[�^�X���͕̂���Ȃ��D�G�B
      #------------------------------------------------------------------------
      when 152
        @name = "Ta��a��o"
        @exp_type = 4
        @maxhp, @maxsp = 380, 380
        @str, @dex, @agi, @int = 100, 110, 110, 90
        @atk, @pdef, @mdef = 130, 30, 100
        @digest, @absorb = 6, 500
        @maxrune, @d_power = 3, 3
        @years_type, @bust_size = 3, 3
        @tail = true
        @hold_rate[0] = [689,705,706,707] #������
        @hold_rate[1] = [687,688,691,692,695,697,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [682,683,684,696] #���[�h40�O��ŉ���
        @hold_rate[3] = [700,701,702,710,711,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 20
        @exp = 22
        @gold = 25
        case race_id 
        when 152 # ��
          @graphics = "tamamo1-1"
          @default_name_self = "����"
          @default_name_hero = "���Ȃ�"
        end
        
      #------------------------------------------------------------------------
      # ������������
      #
      # �ϋv�ʂ����A�Η͂ƃX�s�[�h�ɓ���������ϋv�����A�^�b�J�[�B
      # ���@������Ȃ�Ɋo���A�����𗘗p�����x���ɂ��g����
      #------------------------------------------------------------------------
      when 156
        @name = "Lili��"
        @exp_type = 3
        @maxhp, @maxsp = 300, 340
        @str, @dex, @agi, @int = 100, 110, 120, 80
        @atk, @pdef, @mdef = 140, 20, 100
        @digest, @absorb = 5, 500
        @maxrune, @d_power = 3, 3
        @years_type, @bust_size = 2, 3
        @tail = true
        @hold_rate[0] = [682,684,687] #������
        @hold_rate[1] = [683,688,689,695,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [691,692,697,700,701,705,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [696,702,706,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 12
        @exp = 20
        @gold = 10
        case race_id 
        when 156 # ��
          @graphics = "lilim0-1"
          @default_name_self = "��"
          @default_name_hero = "��l����"
        end
        
      #------------------------------------------------------------------------
      # �������j�[�N����
      #------------------------------------------------------------------------
      # �����l�C�W�������W
      #
      # �ϋv�^�o�X�e�T���B�d�o�A�u�o�͂��Ȃ荂���B�f�����A���_�͂͒v���I�B
      # �U�����\�������킯�ł͂Ȃ��A�U�����邾���Ŏ��R�ƃo�X�e�����̂ŋ��́B
      #------------------------------------------------------------------------
      when 251 #���j�[�N�T�L���o�X/�l�C�W�������W
        @name, @graphics = "Neijorange", "boss_neijurange"
        @exp_type = 4
        @maxhp, @maxsp =  500, 400
        @str, @dex, @agi, @int = 80, 60, 5, 20
        @atk, @pdef, @mdef = 90, 100, 100
        @digest, @absorb = 6, 580
        @maxrune, @d_power = 3, 50
        @years_type, @bust_size = 3, 4
        @tail = true
        @hold_rate[0] = [684,687,688] #������
        @hold_rate[1] = [682,683,695,697,689,698,705,706] #���[�h20�O��ŉ���
        @hold_rate[2] = [692,700,701,707,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,696,702,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @default_name_self = "������"
        @default_name_hero = "�L�~"
      #------------------------------------------------------------------------
      # �������W�F�I
      #
      # �t�B�[���h�^�x���^���j�[�N�B���b�T�[�T�L���o�X���x�͍U�����\�͂���B
      # �f�������������A�u�o�͂��Ȃ�Ⴍ�퓬�ł̓X�^�~�i�؂ꂪ�����B
      #------------------------------------------------------------------------
      when 252 #���j�[�N�T�L���o�X/���W�F�I
        @name, @graphics = "Rejeo ", "boss_rejeo"
        @exp_type = 4
        @maxhp, @maxsp = 350, 200
        @str, @dex, @agi, @int = 60, 80, 110, 80
        @atk, @pdef, @mdef = 90, 30, 100
        @digest, @absorb = 3, 350
        @maxrune, @d_power = 3, 50
        @years_type, @bust_size = 2, 1
        @tail = true
        @hold_rate[0] = [689,695] #������
        @hold_rate[1] = [687,688] #���[�h20�O��ŉ���
        @hold_rate[2] = [683,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [682,684,691,692,696,697,698,700,701,702,705,706,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @default_name_self = "��"
        @default_name_hero = "��l����"
      #------------------------------------------------------------------------
      # �����t���r���A
      #
      # �����ἨA�^�b�J�[�B�U�����\���Ƃɂ��������A�f���������Ȃ荂���B
      # �ϋv�͂͌����ĒႭ�͂Ȃ����̂́A�s���̎c�鏊�B
      #------------------------------------------------------------------------
      when 253 #���j�[�N�T�L���o�X/�t���r���A
        @name, @graphics = "Fulbeua ", "boss_fulbeua"
        @exp_type = 4
        @maxhp, @maxsp =  360, 400
        @str, @dex, @agi, @int = 110, 95, 102, 70
        @atk, @pdef, @mdef = 170, 50, 100
        @digest, @absorb = 6, 620
        @maxrune, @d_power = 3, 50
        @years_type, @bust_size = 3, 4
        @tail = true
        @hold_rate[0] = [682,683,684,687,688] #������
        @hold_rate[1] = [689,697,698,700,701,705] #���[�h20�O��ŉ���
        @hold_rate[2] = [691,692,702,706,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [695,696,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @default_name_self = "��"
        @default_name_hero = "�M��"
      #------------------------------------------------------------------------
      # �����M���S�[��
      #
      # �����̂�������B�c��Ȃu�o�ɂ��ϋv�ʂ͑������E����Ă���B
      # �U�����\�͒Ⴍ�A�퓬�^�x���^�C�v�B���_�͂��c��ŁA���@�̌��ʂ͍����B
      #------------------------------------------------------------------------
      when 254 #���j�[�N�T�L���o�X/�M���S�[��
        @name, @graphics = "Gilgoon ", "boss_gilgoon"
        @exp_type = 4
        @maxhp, @maxsp =  250, 1000
        @str, @dex, @agi, @int = 30, 30, 40, 300
        @atk, @pdef, @mdef = 40, 5, 100
        @digest, @absorb = 4, 500
        @maxrune, @d_power = 3, 50
        @years_type, @bust_size = 1, 1
        @hold_rate[0] = [683,687,688,700,701,710,711] #������
        @hold_rate[1] = [689,691,697,698,702,712] #���[�h20�O��ŉ���
        @hold_rate[2] = [682,684,692] #���[�h40�O��ŉ���
        @hold_rate[3] = [695,696] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @default_name_self = "��"
        @default_name_hero = "�M�l"
      #------------------------------------------------------------------------
      # �������[�K�m�b�g
      #
      # �G��ɂ��z�[���h�A�^�b�J�[�B�f�̔\�͂͒Ⴂ���A�G��X�L�������́B
      # �u�o�͍������̂́A�G��X�L���̏���u�o�͍��߁B���_�͂͗D�G�B
      #------------------------------------------------------------------------
      when 255 #���j�[�N�T�L���o�X/���[�K�m�b�g
        @name, @graphics = "Yuganaught", "boss_youganot"
        @exp_type = 4
        @maxhp, @maxsp =  320, 470
        @str, @dex, @agi, @int = 40, 80, 90, 180
        @atk, @pdef, @mdef = 100, 80, 100
        @digest, @absorb = 6, 600
        @maxrune, @d_power = 3, 50
        @years_type, @bust_size = 2, 2
        @tail = true
        @hold_rate[0] = [717,717,717,718,718,718] #������
        @hold_rate[1] = [684,688,692,689,698,700,701,705] #���[�h20�O��ŉ���
        @hold_rate[2] = [682,687,697,702,706,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [683,691,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [695,696] #���[�h100�ŉ���
        @contract_level = 0
        @default_name_self = "�{�N"
        @default_name_hero = "�L�~"
      #------------------------------------------------------------------------
      # �����V���t�F
      #
      # �x���ƍU���𗼗����郆�j�[�N�B���l���ɓ������Ă���B
      # �f�̍U�����\�͒Ⴂ���y���}���`�X�g�z�����ŁA�Η͂ɂ����҂ł���
      #------------------------------------------------------------------------
      when 256 #���j�[�N�T�L���o�X/�V���t�F
        @name, @graphics = "Sylphe", "boss_shilphe"
        @exp_type = 4
        @maxhp, @maxsp =  380, 380
        @str, @dex, @agi, @int = 90, 100, 50, 90
        @atk, @pdef, @mdef = 90, 90, 100
        @digest, @absorb = 5, 550
        @maxrune, @d_power = 3, 50
        @years_type, @bust_size = 3, 4
        @tail = true
        @hold_rate[0] = [689,695] #������
        @hold_rate[1] = [687,688,697,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [683,692,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [682,684,691,696,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [700,701,702,705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @default_name_self = "��"
        @default_name_hero = "��l�����l"
      #------------------------------------------------------------------------
      # �������[�~��
      #
      # ���������ȃX�e�[�^�X�B���_�͂������A���@�����p�Ɏg����B
      # �Η͂͂����܂łƂ�������ۂł͂Ȃ����A�\���������B
      #------------------------------------------------------------------------
      when 257 #���j�[�N�T�L���o�X/���[�~��
        @name, @graphics = "Ramile", "boss_rarmil"
        @exp_type = 4
        @maxhp, @maxsp = 400, 450
        @str, @dex, @agi, @int = 80, 50, 60, 250
        @atk, @pdef, @mdef = 80, 80, 100
        @digest, @absorb = 5, 580
        @maxrune, @d_power = 3, 50
        @years_type, @bust_size = 4, 4
        @hold_rate[0] = [687,689,697,698] #������
        @hold_rate[1] = [682,684,692] #���[�h20�O��ŉ���
        @hold_rate[2] = [691] #���[�h40�O��ŉ���
        @hold_rate[3] = [683,688,695,696,700,701,702,710,711,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [705,706,707,715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @default_name_self = "��"
        @default_name_hero = "��l����"
      #------------------------------------------------------------------------
      # �������F���~�B�[�i
      #
      # �P���퓬�\�͂Ō����΍ŋ��B�S�Ăɒu���č������ȃX�e�[�^�X������
      # ���̑���󕠗��͍ő�l��7�B���S�ɐ퓬�����ƂȂ��Ă���B
      #------------------------------------------------------------------------
      when 258 #���j�[�N�T�L���o�X/���F���~�B�[�i
        @name, @graphics = "Vermiena", "boss_vermiena"
        @exp_type = 4
        @maxhp, @maxsp = 450, 450
        @str, @dex, @agi, @int = 140, 140, 100, 100
        @atk, @pdef, @mdef = 160, 100, 100
        @digest, @absorb = 7, 1000
        @maxrune, @d_power = 3, 50
        @years_type, @bust_size = 3, 5
        @tail = true
        @hold_rate[0] = [687,688,689] #������
        @hold_rate[1] = [682,683,697,698] #���[�h20�O��ŉ���
        @hold_rate[2] = [684,692,700,701,705,710,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,695,696,702,706,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 0
        @default_name_self = "��"
        @default_name_hero = "��l����"
      #------------------------------------------------------------------------
      # �������̑�
      #------------------------------------------------------------------------
      else
        @name = "Succubus"
        @exp_type = 1
        @maxhp, @maxsp =  380, 360
        @str, @dex, @agi, @int = 90, 70, 85, 60
        @atk, @pdef, @mdef = 120, 65, 100
        @digest, @absorb = 5, 320
        @years_type, @bust_size = 3, 4
        @tail = true
        @maxrune, @d_power = 3, 2
        @hold_rate[0] = [682,687,697] #������
        @hold_rate[1] = [683,684,689,695,700,710] #���[�h20�O��ŉ���
        @hold_rate[2] = [688,698,701,705,706,711] #���[�h40�O��ŉ���
        @hold_rate[3] = [691,692,696,702,707,712] #���[�h60�O��ŉ���
        @hold_rate[4] = [715,716,717,718,719] #���[�h100�ŉ���
        @contract_level = 10
        @exp = 18
        @gold = 14
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �푰�l���܂Ƃ�
  #--------------------------------------------------------------------------
  class SDB
    #--------------------------------------------------------------------------
    # �� ���J�C���X�^���X�ϐ�
    #--------------------------------------------------------------------------
    attr_accessor :data
    #--------------------------------------------------------------------------
    # �� �I�u�W�F�N�g������
    #--------------------------------------------------------------------------
    def initialize
      @data = []
      @max = 300 #�f���̓o�^�����
      for i in 0..@max
        @data[i] = Succubus_registration.new(i)
      end
    end
    #--------------------------------------------------------------------------
    # �� �푰�l�̎擾
    #--------------------------------------------------------------------------
    def [](succubus_id)
      return @data[succubus_id]
    end
  end
end