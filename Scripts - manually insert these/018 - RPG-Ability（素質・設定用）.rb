#==============================================================================
# �� RPG::Ability
#------------------------------------------------------------------------------
# �@�f���̏��B$data_ability[id]����Q�Ɖ\�B
#==============================================================================
module RPG
  #--------------------------------------------------------------------------
  # �� �f���̓o�^
  #--------------------------------------------------------------------------
  class Ability_registration
    #--------------------------------------------------------------------------
    # �� ���J�C���X�^���X�ϐ�
    #--------------------------------------------------------------------------
    attr_accessor :id            # id
    attr_accessor :name          # ���O
    attr_accessor :description   # ����
    attr_accessor :icon_name   # ����
    attr_accessor :hidden      # ��\���f��
    #--------------------------------------------------------------------------
    # �� �I�u�W�F�N�g������
    #--------------------------------------------------------------------------
    def initialize(ability_id)
      @id = ability_id
      @name = ""
      @description = ""
      @icon_name = "acce_003"
      @hidden = false
      setup(ability_id)
    end
    #--------------------------------------------------------------------------
    # �� �Z�b�g�A�b�v
    #--------------------------------------------------------------------------
    def setup(ability_id)
      
      # �K���f����id���ŕ��Ԃ��߁A�������l�����邱�ƁB
      
      case ability_id
      
      # �� id [0..9] ���ʁA���̑��ŗD��f��
      
      when 0
        @name = "�j" # �Y
        @description = "�j���B���ʁA��������B"      
      when 1
        @name = "��" # �Y
        @description = "�����B���ʁA��������B"
       
      # �� id [10..29] �e���_(�ǌ��������ɉe��)
      #    10�`17�͒j���p(�n�D)�A19�`30�͏����p(������)�ƂȂ�
      when 10
        @name = "���U�߂Ɏア" # �Y
        @description = "�����ɂ��U�߂��󂯂����A��ǌ������㏸���Ă��܂��B"
      when 11
        @name = "��U�߂Ɏア" # �Y
        @description = "�w�⏶�ɂ��U�߂��󂯂����A��ǌ������㏸���Ă��܂��B"
      when 12
        @name = "���U�߂Ɏア" # �Y
        @description = "���[�����ɂ��U�߂��󂯂����A��ǌ������㏸���Ă��܂��B"
      when 13
        @name = "���A�U�߂Ɏア" # �Y
        @description = "�A�\�R�ɂ��U�߂��󂯂����A��ǌ������㏸���Ă��܂��B"
      when 14
        @name = "�n�s�U�߂Ɏア"
        @description = "���Ȃǂ̚n�s�I�ȍU�߂��󂯂����A��ǌ������㏸���Ă��܂��B"
      when 15
        @name = "�ٌ`�U�߂Ɏア"
        @description = "�ٌ`�̂��̂ɂ��U�߂��󂯂����A��ǌ������㏸���Ă��܂��B"
        # ����v���C�ɂĉ���
      when 16
        @name = "�����Ɏア"
        @description = "�����}�������������A��ǌ������㏸���Ă��܂��B"
      when 17
        @name = "��s�Ɏア"
        @description = "���K���U�߂�ꂽ���A��ǌ������㏸���Ă��܂��B"
        # ����v���C�ɂĉ���
      
      when 19
        @name = "����������"
        @description = "�����U�߂�ꂽ���A��ǌ������㏸���Ă��܂��B"
      when 20
        @name = "���O"
        @description = "�����U�߂�ꂽ���A��ǌ������啝�ɏ㏸���Ă��܂��B"
      when 21
        @name = "����������"
        @description = "�����U�߂�ꂽ���A��ǌ������㏸���Ă��܂��B"
      when 22
        @name = "����"
        @description = "�����U�߂�ꂽ���A��ǌ������啝�ɏ㏸���Ă��܂��B"
      when 23
        @name = "���K��������"
        @description = "���K���U�߂�ꂽ���A��ǌ������㏸���Ă��܂��B"
      when 24
        @name = "���K"
        @description = "���K���U�߂�ꂽ���A��ǌ������啝�ɏ㏸���Ă��܂��B"
      when 25
        @name = "�e����������"
        @description = "���K�ɑ}�����ꂽ���A��ǌ������㏸���Ă��܂��B"
        # ����v���C�ɂĉ���
      when 26
        @name = "����"
        @description = "���K�ɑ}�����ꂽ���A��ǌ������啝�ɏ㏸���Ă��܂��B"
        # ����v���C�ɂĉ���
      when 27
        @name = "�A�j��������"
        @description = "�A�\�R���U�߂�ꂽ���A��ǌ������㏸���Ă��܂��B"
      when 28
        @name = "���j"
        @description = "�A�\�R���U�߂�ꂽ���A��ǌ������啝�ɏ㏸���Ă��܂��B"
      when 29
        @name = "���A��������"
        @description = "�A�\�R�ɑ}�����ꂽ���A��ǌ������㏸���Ă��܂��B"
      when 30
        @name = "����"
        @description = "�A�\�R�ɑ}�����ꂽ���A��ǌ������啝�ɏ㏸���Ă��܂��B"
        
      
      # �� id [31..49] �U�������f��
      #    31�`37�̓A�N�^�[�̒ǌ����㏸�A40�`46�͒ǉ��X�L���擾�����ƂȂ�
      when 31
        @name = "�L�b�X�n��"
        @description = "�w�L�b�X�x���g�p�������A�З͂ƒǌ������㏸����B"
      when 32
        @name = "�o�X�g�n��"
        @description = "�w�o�X�g�x���g�p�������A�З͂ƒǌ������㏸����B"
      when 33
        @name = "�q�b�v�n��"
        @description = "�w�q�b�v�x���g�p�������A�З͂ƒǌ������㏸����"
      when 34
        @name = "�N���b�`�n��"
        @description = "�w�N���b�`�x���g�p�������A�З͂ƒǌ������㏸����B"
      when 35
        @name = "�C���T�[�g�n��"
        @description = "�}�����̂ݎg�p�\�ȃX�L�����g�p�������A�З͂ƒǌ������㏸����B"
        # ����v���C�ɂĉ���
      when 36
        @name = "�z�[���h�n��"
        @description = "������S������X�L�����g�p�������A���W�X�g��Փx��������B"
        # ����v���C�ɂĉ���

      when 40
        @name = "��Z�̐S��"
        @description = "�����g�����X�L����̓��ł���B"
      when 41
        @name = "��Z�̐S��"
        @description = "������g�����X�L����̓��ł���B"
      when 42
        @name = "���Z�̐S��"
        @description = "������g�����X�L����̓��ł���B"
      when 43
        @name = "�����̐S��"
        @description = "�����̃X�L����̓��ł���B"
      when 44
        @name = "���s�̐S��"
        @description = "�r���������X�L����̓��ł���"
        # ����v���C�ɂĉ���
      when 45
        @name = "��s�̐S��"
        @description = "�l���������X�L����̓��ł���B"
        # ����v���C�ɂĉ���
      when 46
        @name = "�����̐S��"
        @description = "�}�������ۂɎg�p����X�L����̓��ł���B"
      when 47
        @name = "�ċz�̐S��"
        @description = "���ȉ񕜂̃X�L����̓��ł���B"
      
      
      # �� id [50..99] �D��\���f��
      
      when 50
        @name = "�ō��̎p"
        @description = "�ő僉���N���̃X�e�[�^�X�ɂȂ�B"
        # �����N�A�b�v�O�̖����ł��A
        # �ő僉���N���̏�Ԃ̃X�e�[�^�X�Ƃ��Čv�Z�����B
      when 51
        @name = "����"
        @description = "�����u���v�̖���m��Ȃ���ԁB"
        # ����v���C�ɂĉ���
      when 52
        @name = "���߂Ă�D����"
        @description = "�M���͂��̖����̏�����D�����B"
      when 53
        @name = "����"
        @description = "�����u���v�ƂȂ��Ă��Ȃ���ԁB"
      when 54
        @name = "���߂Ă�D��ꂽ"
        @description = "�M���͂��̖����ɏ��߂Ă�������B"
        # ����v���C�ɂĉ���
      when 55
        @name = "�V���̏���"
        @description = "�i���̏����ł���B"
        # �t�[���[�̑f��
        
      when 56
        @name = "������L"
        @description = "�����ɂ��ā��������Ă���B"
        # ����v���C�ɂĉ���
      when 57
        @name = "����̎�"
        @description = "������o��B"
        # ����v���C�ɂĉ���
      
        
      when 60
        @name = "����"
        @description = "���̖����͋M�����C�ɓ����Ă���B"
      when 61
        @name = "��؂Ȑl"
        @description = "�M���Ƃ��̖����݂͌�����ʂȑ��݂��Ɗ����Ă���B"

      when 70
        @name = "�z��" # �Y
        @description = "�����������Ⓒ���������A�����x�����񕜂���B"
      when 71
        @name = "�T�f�B�X�g"
        @description = "�g�p����r�����̃X�L���̌��ʂ��オ��B"
      when 72
        @name = "�}�]�q�X�g" # �Y
        @description = "�r�����̃X�L�����󂯂��ꍇ�ɕʂ̌��ʂɕς��B"
      when 73
        @name = "�J���X�}" # �Y
        @description = "�퓬�I�����ɐ퓬�ɏo�Ă��鎞�A�_�񂵂₷���Ȃ�B"
      when 74
        @name = "�V���[�X�g���b�v"
        @description = "�����ŕ���E�������ɁA���[�h�������قǓG�S����~���Ԃɂ���B"

        
      when 80
        @name = "���^�����t�H�[�["
        @description = "�ʂ̖����̎p�Ő퓬�ɏo��B�N���C�V�X�ɂȂ�ƌ��ɖ߂�B"
        # �����_�[�C���v�̑f���B�����̏ꍇ�A��Ԍ��̖����̎p�ɂȂ�B
      when 81
        @name = "�������̘A�g" # �Y
        @description = "�퓬���A�y�������̓����z�������Ԃ̃X�L�����g�p�ł���B"
      when 82
        @name = "�������̓���" # �Y
        @description = "�퓬���A�y�������̘A�g�z�������Ԃ������Ɠ����X�L�����g�p�ł���B"
      when 83
        @name = "�d��" # �Y
        @description = "�퓬�ɏo�����ɑ���S�̂��`�F�b�N������Ԃɂ���B"
        
        
      when 91
        @name = "�ł̑̉t" # �Y
        @description = "���̖����̑̉t�ɐG���ƁA��Ԉُ�ɂȂ�B"
        # �l�C�W�������W����f���B
      when 92
        @name = "" 
        @description = ""
        # ���W�F�I����f���B        
      when 93
        @name = "�m�ł��鎩���S" # �Y
        @description = "���̖����͏�Ԉُ�ɂȂ�Ȃ��B"
        # �t���r���A����f���B        
      when 94
        @name = "�ߕq�Ȑg��" # �Y
        @description = "�傫���������󂯂�悤�ɂȂ��Ă��܂��Ă���B"
        # �M���S�[������f���B        
      when 95
        @name = "" 
        @description = ""
        # ���[�K�m�b�g����f���B        
      when 96
        @name = "��ǂ�" 
        @description = "�������^�[�����܂��s�����Ă��Ȃ����A��SS�m����������B"
        # �V���t�F����f���B
      when 97
        @name = "�ώ�" # �Y
        @description = "�ޏ��͋M����_��������B"
        # ���[�~������f��
        
        
        
      # �� id [100..199] �퓬�n�f��
      
      when 103
        @name = "�X�^�~�i"
        @description = "�Ⓒ��̐���E�Ⓒ�^�[������������B"
      when 104
        @name = "�����m��" # �Y
        @description = "�H�ނ𒲗����Ă����B"
      when 105
        @name = "���@�m��"
        @description = "���@���g�p���鎞�̏���u�o���y�������B"

      when 106
        @name = "�G��₷��" # �Y
        @description = "�A�\�R�̏����x���オ��₷���B"
      when 107
        @name = "�G��ɂ���" # �Y
        @description = "�A�\�R�̏����x���オ��ɂ����B"
        
      when 108
        @name = "����" # �Y
        @description = "�\����ԂɂȂ�ɂ����B"
      when 109
        @name = "���C" # �Y
        @description = "���E��ԂɂȂ�ɂ����B"
      when 110
        @name = "�_��" # �Y
        @description = "�ؕ|��ԂɂȂ�ɂ����B"
      when 111 # ���Ԉʒu
        @name = ""
        @description = ""
      when 112
        @name = "�_��" # �Y
        @description = "��჏�ԂɂȂ�ɂ����B"
      when 113
        @name = "��S" # �Y
        @description = "�U����ԂɂȂ�ɂ����B"
      when 114
        @name = "�S��" # �Y
        @description = "�ŏ�����S�Ă̏����x���������A����̏����x���グ�₷���B"
        # �X���C���n�̑f���B
      when 115
        @name = "�v���e�N�V����" # �Y
        @description = "���@�̌��ʂ���،����Ȃ��B"
        # �S�[���h�X���C���̑f���B
      when 116
        @name = "�u���b�L���O" # �Y
        @description = "�������^�[�����܂��s�����Ă��Ȃ����A�󂯂������������B"
        # �K�[�S�C���̑f���B
      when 117
        @name = "����" # �Y
        @description = "���ߏ�Ԃ̎��A�f�����������邪�E�ϗ͂��オ��B"
        # �^�}���̑f���B
      when 118
        @name = "�Ɖu��" # �Y
        @description = "�E�q�̉e�����󂯂��A�łɂ������B"

        
      when 120
        @name = "���g" # �Y
        @description = "�퓬�ɏo�����ɍ��g��ԂɂȂ�B"
      when 121
        @name = "����" # �Y
        @description = "�퓬�ɏo�����ɒ�����ԂɂȂ�B"
      when 122
        @name = "���y��`"
        @description = "�U�����󂯂�ƃ��[�h���グ��B"
      when 123
        @name = "���}���`�X�g" # �Y
        @description = "���[�h�������قǁA�^������������傫���Ȃ�B"
      when 124
        @name = "�n��" # �Y
        @description = "Sensual Stroke�����オ��B"
      when 125
        @name = "���M�ߏ�"
        @description = "���̖������G��Ⓒ���������ɁA�����̏�Ԉُ���񕜂���B"
      when 126
        @name = "�ŗ~" # �Y
        @description = "�����ȊO�̖������Ⓒ�������A�����̖��͂Ɛ��͂��P�i�K�グ��"
      when 127
        @name = "���X�ȍU��" # �Y
        @description = "�A�����ē����X�L���ōU�߂Ă��������������ɂ����B"
=begin
      when 128
        @name = "�b�|"
        @description = "�g�[�N�̐��������オ��B"
      when 129
        @name = "�ۋC"
        @description = "���܂ɑҋ@�^�[���ɂȂ�B"
=end
        
      when 130
        @name = "���@��" # �Y
        @description = "�U�߂�������`�F�b�N������Ԃɂ���B"
      when 131
        @name = "�����I"
        @description = "�퓬�ɏo�����ɂu�o���Q�O����āA�G�S���𒧔�����B"
      when 132
        @name = "�{�f�B�A���}"
        @description = "�퓬�ɏo�����ɂu�o���W����āA���[�h�������グ��B"
      when 133
        @name = "���f�I"
        @description = "�퓬�ɏo�����ɂu�o���S�O����āA�G�S�����m���ŗ~��ɂ���B"
      when 134
        @name = "�T���`�F�b�N" # �Y
        @description = "�퓬�ɏo�����ɂu�o���P�O�O����āA�G�S�����ؕ|�ɂ���B"
      when 135
        @name = "�����̕ۏ�" # �Y
        @description = "�g�p����񕜖��@�̌��ʂ��オ��B"
      when 136
        @name = "�o�b�h�`�F�C��" # �Y
        @description = "�Q�ȏ��Ԉُ킪���������ǌ����₷���B"

      when 140
        @name = "���ԕ�"
        @description = "���Ԃ��ȂɂȂ��Ă���B"
      when 141
        @name = "���t����"
        @description = "���t���ȂɂȂ��Ă���B"
        
      when 150
        @name = "���䖲��" # �Y
        @description = "�N���C�V�X�ɂȂ�Ɛ��͂��オ��B"
      when 151
        @name = "�΍R�S" # �Y
        @description = "�����̐Ⓒ���ɖ����̐����G�̐���菭�Ȃ��ꍇ�A���͂Ƒf�������グ��B"
      when 152
        @name = "�����S"
        @description = "�~��ɂȂ�Ƃu�o���T�O����A���_�͂��グ�ė~����񕜂���B"
      when 153
        @name = "�����̑̎�"
        @description = "�~���Ԃ̎��A�^�[���̏I�������ɂu�o�������񕜂���B"
      when 154
        @name = "���\��" # �Y
        @description = "�\����Ԃ̎��A�E�ϗ͂Ɛ��_�͂��X�ɉ����萸�͂��啝�ɏオ��B"
      
      when 160
        @name = "�L�X�X�C�b�`" # �Y
        @description = "�L�X�������ƃX�C�b�`������B"
      when 161
        @name = "�}�]�X�C�b�`"
        @description = "�l�|�����ƃX�C�b�`������B"
        
      when 170
        @name = "�G�N�X�^�V�[�{��" # �Y
        @description = "�Ⓒ�������A�����ȊO�̖����S����\����Ԃɂ���B"
      when 171
        @name = "����̎�"
        @description = "���y���󂯂�܂œ������A����������Ă����΂炭����΂܂����󂳂��B"
        # �V�[���f�[�����̑f���B
        
        
      # �� id [100..199] �T���n�f��
      when 210
        @name = "�d�o�q�[�����O" # �Y
        @description = "�퓬�������Ƀp�[�e�B�S���̂d�o�����񕜂���B"
      when 211
        @name = "�u�o�q�[�����O" # �Y
        @description = "�퓬�������Ƀp�[�e�B�S���̂u�o�����񕜂���B"
        
      when 212
        @name = "�񕜗�" # �Y
        @description = "�����񕜂���d�o�ʂ������オ��B"
      when 213
        @name = "����񕜗�" # �Y
        @description = "�p�[�e�B�S���̎����񕜂���d�o�ʂ������オ��B"
      when 214
        @name = "������" # �Y
        @description = "�����񕜂���u�o�ʂ������オ��B"
      when 215
        @name = "���鐶����" # �Y
        @description = "�p�[�e�B�S���̎����񕜂���u�o�ʂ������オ��B"
        
      when 220
        @name = "�o�����p��" # �Y
        @description = "�퓬�I�����̎擾�o���l�ʂ�������B"
      when 221
        @name = "�N�W" # �Y
        @description = "�퓬�I�����̃A�C�e���h���b�v�����オ��B"
      when 222
        @name = "���^" # �Y
        @description = "�퓬�I�����ɖႦ��Lps.�̗ʂ�������B"
      when 223
        @name = "�����ւ̗�����"
        @description = "�B���ʘH�Ȃǂ̋߂��Ƀ}�[�J�[���ڂ���ƌ����B"
      when 224
        @name = "�_�E�W���O"
        @description = "�}�b�v��Ō����Ȃ��A�C�e���̏��ʂ�ƃ}�[�J�[�������B"
      when 225
        @name = "�V�[���X�^���v"
        @description = "�p�[�e�B���󂯂�_���[�W������̉������y������B"
      when 226
        @name = "�_�E�g"
        @description = "�������[�Ԃ��Ă���̂����O�Ɏ@�m�ł���B"
      when 227
        @name = "��P�̔���" # �Y
        @description = "�G�V���{���ƐڐG�������ɁA�����炪��������m�����オ��B"
      when 228
        @name = "�x���̔���" # �Y
        @description = "�G�V���{���ƐڐG�������ɁA�G�ɐ��������m����������B"
      when 229
        @name = "���������@" # �Y
        @description = "�_�b�V�����ɓG�V���{���ƐڐG���Ă��A��������ɂ����Ȃ�B"
      when 230
        @name = "�����̋Ɉ�" # �Y
        @description = "��������������ꍇ�A���������オ��B"
      
        
        
      when 240
        @name = "��ۗǂ��̎�" # �Y
        @description = "�̎�ɂ����鎞�Ԃ��Z���Ȃ�B"
      when 241
        @name = "�ڑ����̎�" # �Y
        @description = "�̎�Ŋ󏭂Ȃ��̂���ɓ���₷���Ȃ�B"
        
      when 300
        @name = "��\���f���e�X�g"
        @description = "��\���f���e�X�g�ł��Bhidden���^�̑f���͕\������܂���"
        @hidden = true

      when 301
        @name = "�C���T�[�g" # �Y
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 302
        @name = "�A�N�Z�v�g" # �Y
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 303
        @name = "�V�F���}�b�`" # �Y
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 304
        @name = "�G�L�T�C�g�r���[" # �Y
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 305
        @name = "�G���u���C�X" # �Y /�����z�[���h(�J�r�͏���)
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 306
        @name = "�I�[�����Z�b�N�X" # �Y /�t�F���{�N���j���p
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 307
        @name = "�y���X�R�[�v" # �Y /�p�C�Y���z�[���h
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 308
        @name = "�w�u�����[�t�B�[��" # �Y /�ςӂςӃz�[���h
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 309
        @name = "�t���b�^�i�C�Y" # �Y /�L�b�X�z�[���h
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 310
        @name = "�g���C���h�z�[��" # �Y /���K�g�p�n
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 311
        @name = "�A���h���M���k�X" # �Y /�y�j�X�g�p�n
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 312
        @name = "�e�C���}�X�^���[" # �Y /�K���g�p�n
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 313
        @name = "�e���^�N���}�X�^���[" # �Y /�G��g�p�n
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 314
        @name = "�C�N�C�b�v�f�B���h" # �Y /�f�B���h�����n
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 315
        @name = "�A�C���B�}�X�^���[" # �Y /�ӎg�p�n
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 320
        @name = "�A�k�X�}�[�L���O" # �Y /�K�_������
        @description = "�}���z�[���h�ŋe����_����悤�ɂȂ�"
        @hidden = true
      when 321
        @name = "�o�C���h�}�X�^���[" # �Y /�S���Z����
        @description = "�S���z�[���h����������"
        @hidden = true

        
        
      when 332
        @name = "�������s" # �Y /
        @description = "���̖����͗������ł��Ȃ��B"
        @hidden = true
        
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �f�����܂Ƃ�
  #--------------------------------------------------------------------------
  class Ability
    #--------------------------------------------------------------------------
    # �� ���J�C���X�^���X�ϐ�
    #--------------------------------------------------------------------------
    attr_accessor :data
    #--------------------------------------------------------------------------
    # �� �I�u�W�F�N�g������
    #--------------------------------------------------------------------------
    def initialize
      @data = []
      @max = 400 #�f���̓o�^�����
      for i in 0..@max
        @data[i] = Ability_registration.new(i)
      end
    end
    #--------------------------------------------------------------------------
    # �� �f���̎擾
    #--------------------------------------------------------------------------
    def [](ability_id)
      return @data[ability_id]
    end
    #--------------------------------------------------------------------------
    # �� �f���̌���
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
      
      if n == nil
        text = "�Ή������h�c����������܂���ł����B"
        text += "\n�ȉ��̂��Ƃ��m�F���Ă������B"
        text += "\n�E�뎚�E���i�X�N���v�g�G�f�B�^���S�����j"
        text += "\n�E�y�z��t���Č������Ă��Ȃ���"
        text += "\n�E�f���̏�����������������f��ID�̐����ȉ��łȂ���"
        text += "\n�������[�h�F#{variable}"
        print text
      end
      
      return n
    end

  end
end