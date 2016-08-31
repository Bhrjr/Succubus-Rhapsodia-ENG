#==============================================================================
# �� Window_NameInput
#------------------------------------------------------------------------------
# �@���O���͉�ʂŁA������I������E�B���h�E�ł��B
#==============================================================================

class Window_NameInput < Window_Base
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_reader   :index                    # �J�[�\���ʒu
  CHARACTER_TABLE =
  [
    "A","B","C","D","E",
    "F","G","H","I","J",
    "K","L","M","N","O",
    "P","Q","R","S","T",
    "U","V","W","X","Y",
    "Z","��","��","��","��",
    "1","2","3","4","5",
    "��", "" ,"��", "" ,"��",
    "��","��","��","��","��",
    "a","b","c","d","e",
    "f","g","h","i","j",
    "k","l","��","n","o",
    "p","��","r","s","t",
    "u","v","��","x","y",
    "z","��","��","��","��",
    "6","7","8","9","0",
    "��","��","��","��","��",
    "�[","�E", "" , "" , "" ,
    "�A","�C","�E","�G","�I",
    "�J","�L","�N","�P","�R",
    "�T","�V","�X","�Z","�\",
    "�^","�`","�c","�e","�g",
    "�i","�j","�k","�l","�m",
    "�n","�q","�t","�w","�z",
    "�}","�~","��","��","��",
    "��", "" ,"��", "" ,"��",
    "��","��","��","��","��",
    "��", "" ,"��", "" ,"��",
    "�K","�M","�O","�Q","�S",
    "�U","�W","�Y","�[","�]",
    "�_","�a","�d","�f","�h",
    "�o","�r","�u","�x","�{",
    "�p","�s","�v","�y","�|",
    "��","��","��","�b","��",
    "�@","�B","�D","�F","�H",
    "�[","�E","��", "" , "" ,
  ]
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    super(0, 128, 640, 352)
    self.contents = Bitmap.new(width - 32, height - 32)
    self.z = 6100
    @index = 0
    refresh
    update_cursor_rect
  end
  #--------------------------------------------------------------------------
  # �� �����̎擾
  #--------------------------------------------------------------------------
  def character
    return CHARACTER_TABLE[@index]
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    for i in 0..179
      x = 4 + i / 5 / 9 * 152 + i % 5 * 28
      y = i / 5 % 9 * 32
      self.contents.draw_text(x, y, 28, 32, CHARACTER_TABLE[i], 1)
    end
    self.contents.draw_text(480, 9 * 32, 64, 32, "Random", 1)
    self.contents.draw_text(544, 9 * 32, 64, 32, "Confirm", 1)
  end
  #--------------------------------------------------------------------------
  # �� �J�[�\���̋�`�X�V
  #--------------------------------------------------------------------------
  def update_cursor_rect
    # �J�[�\���ʒu�� [����] �̏ꍇ
    if @index >= 180 and @index < 360
      self.cursor_rect.set(544, 9 * 32, 64, 32)
    # �J�[�\���ʒu�� [�����_��] �̏ꍇ
    elsif @index >= 360 
      self.cursor_rect.set(480, 9 * 32, 64, 32)
    # �J�[�\���ʒu�� [����] �ȊO�̏ꍇ
    else
      x = 4 + @index / 5 / 9 * 152 + @index % 5 * 28
      y = @index / 5 % 9 * 32
      self.cursor_rect.set(x, y, 28, 32)
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    super
    # �J�[�\���ʒu�� [����] �̏ꍇ
    if @index >= 180 and @index < 360
      # �J�[�\����
      if Input.trigger?(Input::DOWN)
        $game_system.se_play($data_system.cursor_se)
        @index -= 180
      end
      # �J�[�\����
      if Input.repeat?(Input::UP)
        $game_system.se_play($data_system.cursor_se)
        @index -= 180 - 40
      end
      # �J�[�\���Eor��
      if Input.repeat?(Input::LEFT) or Input.repeat?(Input::RIGHT)
        $game_system.se_play($data_system.cursor_se)
        @index += 180
      end
    # �J�[�\���ʒu�� [�����_��] �̏ꍇ
    elsif @index >= 360
      # �J�[�\����
      if Input.trigger?(Input::DOWN)
        $game_system.se_play($data_system.cursor_se)
        @index -= 360
      end
      # �J�[�\����
      if Input.repeat?(Input::UP)
        $game_system.se_play($data_system.cursor_se)
        @index -= 360 - 40
      end
      # �J�[�\���Eor��
      if Input.repeat?(Input::LEFT) or Input.repeat?(Input::RIGHT)
        $game_system.se_play($data_system.cursor_se)
        @index -= 180
      end
    # �J�[�\���ʒu�� [����] �ȊO�̏ꍇ
    else
      # �����{�^���̉E�������ꂽ�ꍇ
      if Input.repeat?(Input::RIGHT)
        # ������Ԃ����s�[�g�łȂ��ꍇ���A
        # �J�[�\���ʒu���E�[�ł͂Ȃ��ꍇ
        if Input.trigger?(Input::RIGHT) or
           @index / 45 < 3 or @index % 5 < 4
          # �J�[�\�����E�Ɉړ�
          $game_system.se_play($data_system.cursor_se)
          if @index % 5 < 4
            @index += 1
          else
            @index += 45 - 4
          end
          if @index >= 180
            @index -= 180
          end
        end
      end
      # �����{�^���̍��������ꂽ�ꍇ
      if Input.repeat?(Input::LEFT)
        # ������Ԃ����s�[�g�łȂ��ꍇ���A
        # �J�[�\���ʒu�����[�ł͂Ȃ��ꍇ
        if Input.trigger?(Input::LEFT) or
           @index / 45 > 0 or @index % 5 > 0
          # �J�[�\�������Ɉړ�
          $game_system.se_play($data_system.cursor_se)
          if @index % 5 > 0
            @index -= 1
          else
            @index -= 45 - 4
          end
          if @index < 0
            @index += 180
          end
        end
      end
      # �����{�^���̉��������ꂽ�ꍇ
      if Input.repeat?(Input::DOWN)
        # �J�[�\�������Ɉړ�
        $game_system.se_play($data_system.cursor_se)
        if @index % 45 < 40
          @index += 5
        else
          @index += 180 - 40
        end
      end
      # �����{�^���̏オ�����ꂽ�ꍇ
      if Input.repeat?(Input::UP)
        # ������Ԃ����s�[�g�łȂ��ꍇ���A
        # �J�[�\���ʒu����[�ł͂Ȃ��ꍇ
        if Input.trigger?(Input::UP) or @index % 45 >= 5
          # �J�[�\������Ɉړ�
          $game_system.se_play($data_system.cursor_se)
          if @index % 45 >= 5
            @index -= 5
          else
            @index += 180
          end
        end
      end
      # L �{�^���� R �{�^���������ꂽ�ꍇ
      if Input.repeat?(Input::L) or Input.repeat?(Input::R)
        # �Ђ炪�� / �J�^�J�i �ړ�
        $game_system.se_play($data_system.cursor_se)
        if @index / 45 < 2
          @index += 90
        else
          @index -= 90
        end
      end
    end
    update_cursor_rect
  end
end
