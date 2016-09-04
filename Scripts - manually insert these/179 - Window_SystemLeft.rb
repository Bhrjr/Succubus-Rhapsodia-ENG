#==============================================================================
# �� Window_Status
#------------------------------------------------------------------------------
# �@�X�e�[�^�X��ʂŕ\������A�t���d�l�̃X�e�[�^�X�E�B���h�E�ł��B
#==============================================================================

class Window_SystemLeft < Window_Base
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_accessor   :index
  attr_accessor   :max
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #     actor : �A�N�^�[
  #--------------------------------------------------------------------------
  def initialize
    super(50, 46, 540, 288)
    # ���l�ݒ�---------------------------------------------------------------
    @max = 15 # ���ڐ��B���݂���ꍇ�͂����𑝂₷�B
    #------------------------------------------------------------------------
    self.contents = Bitmap.new(width - 32, @max * 32)
    self.z = 2050
    self.back_opacity = 0
    self.active = true
    @index = 1
    refresh
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    self.contents.font.color = normal_color  

    row_refresh
    
    x = 50
    y = 0
    y_a = 32
    
    self.contents.font.color = crisis_color
    self.contents.font.size = 22
    self.contents.draw_text(x + 168, y + (y_a * 0), 200, 24, "�}�b�v�ݒ�")
    #
    self.contents.font.color = normal_color  
    self.contents.font.size = $default_size
    self.contents.draw_text(x, y + (y_a * 1), 200, 24, "�f�t�H���g�ړ����@")
    self.contents.draw_text(x, y + (y_a * 2), 200, 24, "���̌���C�x���g")
    self.contents.draw_text(x, y + (y_a * 3), 200, 24, "�|�[�g�@�\�ݒ�")
    self.contents.draw_text(x, y + (y_a * 4), 200, 24, "�p�[�g�i�[�󕠓x")
    #
    self.contents.font.color = crisis_color
    self.contents.font.size = 22
    self.contents.draw_text(x + 168, y + (y_a * 5), 200, 24, "�o�g���ݒ�")
    #
    self.contents.font.color = normal_color  
    self.contents.font.size = $default_size
    self.contents.draw_text(x, y + (y_a * 6), 200, 24, "�o�g���X�s�[�h")
    self.contents.draw_text(x, y + (y_a * 7), 200, 24, "���b�Z�[�W���[�h")
    self.contents.draw_text(x, y + (y_a * 8), 200, 24, "���W�X�g�P�\����")
    self.contents.draw_text(x, y + (y_a * 9), 200, 24, "���t�O���t�B�b�N�\��")
    self.contents.draw_text(x, y + (y_a * 10), 200, 24, "�J�[�\���ʒu�L��")
    self.contents.draw_text(x, y + (y_a * 11), 200, 24, "�G���e�B�b�N���b�Z�[�W")
    #
    self.contents.font.color = crisis_color
    self.contents.font.size = 22
    self.contents.draw_text(x + 184, y + (y_a * 12), 200, 24, "���̑�")
    #
    self.contents.font.color = normal_color  
    self.contents.font.size = $default_size
    self.contents.draw_text(x, y + (y_a * 13), 200, 24, "��ʕ\���T�C�Y�؂�ւ�")    
    self.contents.draw_text(x, y + (y_a * 14), 200, 24, "�Q�[�����f")    

    self.cursor_rect.set(x - 4, y - 4 + (y_a * @index) - self.oy, 130, 32)
   
    
    x = 270
    #���f�t�H���g�ړ�
    x_a = 48
    color_change(1, false)
    self.contents.draw_text(x, y + (y_a * 1), 200, 24, "���s")
    color_change(1, true)
    self.contents.draw_text(x + x_a, y + (y_a * 1), 200, 24, "�_�b�V��")
    #�����̌���
    x_a = 48
    color_change(2, true)
    self.contents.draw_text(x, y + (y_a * 2), 200, 24, "����")
    color_change(2, false)
    self.contents.draw_text(x + x_a, y + (y_a * 2), 200, 24, "���Ȃ�")
    #���|�[�g�ݒ�
    x_a = 84
    color_change(3, false)
    self.contents.draw_text(x, y + (y_a * 3), 200, 24, "�L�^�D��")
    color_change(3, true)
    self.contents.draw_text(x + x_a, y + (y_a * 3), 200, 24, "�]�ڗD��")
    #���󕠓x
    x_a = 48
    color_change(4, 0)
    self.contents.draw_text(x + (x_a * 0), y + (y_a * 4), 200, 24, "�W��")
    color_change(4, 1)
    self.contents.draw_text(x + (x_a * 1), y + (y_a * 4), 200, 24, "���H")
    color_change(4, 2)
    self.contents.draw_text(x + (x_a * 2), y + (y_a * 4), 200, 24, "�ߐ�")
    #���o�g���X�s�[�h
    x_a = 48
    color_change(6, 0)
    self.contents.draw_text(x + (x_a * 0), y + (y_a * 6), 200, 24, "�x��")
    color_change(6, 1)
    self.contents.draw_text(x + (x_a * 1), y + (y_a * 6), 200, 24, "�W��")
    color_change(6, 2)
    self.contents.draw_text(x + (x_a * 2), y + (y_a * 6), 200, 24, "����")
    #�����b�Z�[�W���[�h
    x_a = 84
    color_change(7, 0)
    self.contents.draw_text(x + (x_a * 0), y + (y_a * 7), 200, 24, "�}�j���A��")
    color_change(7, 1)
    self.contents.draw_text(x + (x_a * 1), y + (y_a * 7), 200, 24, "�Z�~�I�[�g")
    color_change(7, 2)
    self.contents.draw_text(x + (x_a * 2), y + (y_a * 7), 200, 24, "�t���I�[�g")
    #�����W�X�g�P�\����
    x_a = 48
    color_change(8, 0)
    self.contents.draw_text(x + (x_a * 0), y + (y_a * 8), 200, 24, "�Z��")
    color_change(8, 1)
    self.contents.draw_text(x + (x_a * 1), y + (y_a * 8), 200, 24, "�W��")
    color_change(8, 2)
    self.contents.draw_text(x + (x_a * 2), y + (y_a * 8), 200, 24, "����")
    color_change(8, 3)
    self.contents.draw_text(x + (x_a * 3), y + (y_a * 8), 200, 24, "�ڑ�")
    #�����t�O���t�B�b�N�\��
    x_a = 48
    color_change(9, true)
    self.contents.draw_text(x, y + (y_a * 9), 200, 24, "�\��")
    color_change(9, false)
    self.contents.draw_text(x + x_a, y + (y_a * 9), 200, 24, "��\��")
    #���J�[�\���ʒu�L��
    x_a = 48
    color_change(10, true)
    self.contents.draw_text(x, y + (y_a * 10), 200, 24, "����")
    color_change(10, false)
    self.contents.draw_text(x + x_a, y + (y_a * 10), 200, 24, "���Ȃ�")
    #���G���e�B�b�N���b�Z�[�W
    x_a = 48
    color_change(11, 0)
    self.contents.draw_text(x, y + (y_a * 11), 200, 24, "�Ȉ�")
    color_change(11, 1)
    self.contents.draw_text(x + x_a, y + (y_a * 11), 200, 24, "�W��")
    color_change(11, 2)
    self.contents.draw_text(x + (x_a * 2), y + (y_a * 11), 200, 24, "�ڍ�")
    
#    x_a = 96
#    color_change(5, false)
#    self.contents.draw_text(x, y + (y_a * 5), 200, 24, "�E�B���h�E")
#    color_change(5, true)
#    self.contents.draw_text(x + x_a, y + (y_a * 5), 200, 24, "�t���X�N���[��")
    
 
  end
  #--------------------------------------------------------------------------
  # �� �J���[�ύX�p
  #--------------------------------------------------------------------------
  def color_change(type, variables)
    
    case type
    when 1 # �_�b�V���ύX
      if $game_system.system_dash == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    when 2 # ���̌���C�x���g
      if $game_system.system_present == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    when 3 # �|�[�g�ݒ�
      if $game_switches[33] == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    when 4 # �󕠓x����
      if $game_system.system_fed == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    when 6 # �o�g���X�s�[�h
      if $game_system.system_battle_speed == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    when 7 # ���b�Z�[�W���[�h
      if $game_system.system_read_mode == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    when 8 # ���W�X�g����
      if $game_system.system_regist == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    when 9 # ���t�O���t�B�b�N
      if $game_system.system_sperm == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    when 10 # �J�[�\���ʒu�L��
      if $game_system.system_arrow == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    when 11 # �G���e�B�b�N���b�Z�[�W
      if $game_system.system_message == variables
        self.contents.font.color = normal_color  
      else
        self.contents.font.color = disabled_color
      end
    end
    
  end

  #--------------------------------------------------------------------------
  # �� �w���v�E�B���h�E�̐ݒ�
  #     help_window : �V�����w���v�E�B���h�E
  #--------------------------------------------------------------------------
  def help_window=(help_window)
    @help_window = help_window
    # �w���v�e�L�X�g���X�V (update_help �͌p����Œ�`�����)
    if self.active and @help_window != nil
      update_help
    end
  end
  
  #--------------------------------------------------------------------------
  # �� �w���v�e�L�X�g�X�V
  #--------------------------------------------------------------------------
  def update_help
    case @index
    when 0,5,12 #���ږ�
      text = ""
    when 1 # �f�t�H���g�ړ�
      text = "����L�[�������Ă��Ȃ����̈ړ����@�̐ݒ�����܂��B"
    when 2 # ���̌���C�x���g
      text = "���̌���C�x���g�����邩�ۂ���ݒ肵�܂��B"
    when 3 # �|�[�g�ݒ�
      text = "�|�[�g�@�\�u�Z�[�u�v�Ɓu�e���|�[�g�v�̂ǂ������ɕ\�����邩�ݒ肵�܂��B"
    when 4 # �󕠓x
      text = "�p�[�g�i�[�����̋󕠓x�̌������ݒ�����܂��B"
    when 6 # �o�g���X�s�[�h
      text = "�퓬�S�̂̑��x��ݒ肵�܂��B"
    when 7 # ���b�Z�[�W�X�s�[�h
      text = "�퓬���̃��b�Z�[�W�̕\�����Ԃ�ݒ肵�܂��B"
    when 8 # ���W�X�g�P�\
      text = "���W�X�g�P�\���Ԃ̐ݒ�����܂��B"
    when 9 # ���t�O���t�B�b�N
      text = "��l�������ŐⒸ�����ꍇ�A���薲���ɐ��t�������邩��ݒ肵�܂��B"
    when 10 # �J�[�\���ʒu�L��
      text = "�퓬���A���O�Ɏg�p�����X�L���̈ʒu���L�����邩���Ȃ�����ݒ肵�܂��B"
    when 11 # �G���e�B�b�N���b�Z�[�W
      text = "�퓬�Ŗ����̉�b���ǂ̒��x�\�����邩�ݒ肵�܂��B"
    when 13 # �t���X�N���[����
      text = "�Q�[����ʂ̃t���X�N���[���^�E�B���h�E�̐؂�ւ����s���܂��B"
    when 14 # �Q�[������߂�
      text = "�Q�[���𒆒f���܂��B���Ɏn�߂鎞�͍Ō�ɃZ�[�u����������ƂȂ�܂��B"
    end
    @help_window.set_text(text == nil ? "" : text)
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    super
    # �w���v�e�L�X�g���X�V (update_help �͌p����Œ�`�����)
    if self.active and @help_window != nil
      update_help
    end
  end
  #--------------------------------------------------------------------------
  # �� �s�ʒu����
  #--------------------------------------------------------------------------
  def row_refresh
    # ���݂̍s���擾
    row = @index
    if row < self.oy / 32
      self.oy = row * 32
    end
    if row > (self.oy / 32) + 7
      self.oy = (row - 7) * 32
    end
  end

  
  
end
