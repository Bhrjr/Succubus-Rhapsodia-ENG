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
    self.contents.draw_text(x + 168, y + (y_a * 0), 200, 24, "Map Settings")
    #
    self.contents.font.color = normal_color  
    self.contents.font.size = $default_size
    self.contents.draw_text(x, y + (y_a * 1), 200, 24, "Default Movement")
    self.contents.draw_text(x, y + (y_a * 2), 200, 24, "Partner Feeding")
    self.contents.draw_text(x, y + (y_a * 3), 200, 24, "Crystal Priority")
    self.contents.draw_text(x, y + (y_a * 4), 200, 24, "Partner Appetite")
    #
    self.contents.font.color = crisis_color
    self.contents.font.size = 22
    self.contents.draw_text(x + 168, y + (y_a * 5), 200, 24, "Battle Settings")
    #
    self.contents.font.color = normal_color  
    self.contents.font.size = $default_size
    self.contents.draw_text(x, y + (y_a * 6), 200, 24, "Battle Speed")
    self.contents.draw_text(x, y + (y_a * 7), 200, 24, "Message Mode")
    self.contents.draw_text(x, y + (y_a * 8), 200, 24, "Resist Minigame Delay")
    self.contents.draw_text(x, y + (y_a * 9), 200, 24, "Bukkake")
    self.contents.draw_text(x, y + (y_a * 10), 200, 24, "Cursor Memory")
    self.contents.draw_text(x, y + (y_a * 11), 200, 24, "Erotic Messages")
    #
    self.contents.font.color = crisis_color
    self.contents.font.size = 22
    self.contents.draw_text(x + 184, y + (y_a * 12), 200, 24, "Other")
    #
    self.contents.font.color = normal_color  
    self.contents.font.size = $default_size
    self.contents.draw_text(x, y + (y_a * 13), 200, 24, "Screen Size")    
    self.contents.draw_text(x, y + (y_a * 14), 200, 24, "Stop Game")    

    self.cursor_rect.set(x - 4, y - 4 + (y_a * @index) - self.oy, 130, 32)
   
    
    x = 270
    #���f�t�H���g�ړ�
    x_a = 48
    color_change(1, false)
    self.contents.draw_text(x, y + (y_a * 1), 200, 24, "Walk")
    color_change(1, true)
    self.contents.draw_text(x + x_a + 2, y + (y_a * 1), 200, 24, "Dash")
    #�����̌���
    x_a = 48
    color_change(2, true)
    self.contents.draw_text(x, y + (y_a * 2), 200, 24, "Show")
    color_change(2, false)
    self.contents.draw_text(x + x_a + 8, y + (y_a * 2), 200, 24, "Hide")
    #���|�[�g�ݒ�
    x_a = 84
    color_change(3, false)
    self.contents.draw_text(x, y + (y_a * 3), 200, 24, "Save")
    color_change(3, true)
    self.contents.draw_text(x + x_a - 20, y + (y_a * 3), 200, 24, "Teleport")
    #���󕠓x
    x_a = 48
    color_change(4, 0)
    self.contents.draw_text(x + (x_a * 0), y + (y_a * 4), 200, 24, "Normal")
    color_change(4, 1)
    self.contents.draw_text(x + (x_a * 1) + 24, y + (y_a * 4), 200, 24, "Small")
    color_change(4, 2)
    self.contents.draw_text(x + (x_a * 2) + 30, y + (y_a * 4), 200, 24, "Constrained")
    #���o�g���X�s�[�h
    x_a = 48
    color_change(6, 0)
    self.contents.draw_text(x + (x_a * 0), y + (y_a * 6), 200, 24, "Slow")
    color_change(6, 1)
    self.contents.draw_text(x + (x_a * 1) + 20, y + (y_a * 6), 200, 24, "Normal")
    color_change(6, 2)
    self.contents.draw_text(x + (x_a * 2) + 48, y + (y_a * 6), 200, 24, "Fast")
    #�����b�Z�[�W���[�h
    x_a = 84
    color_change(7, 0)
    self.contents.draw_text(x + (x_a * 0), y + (y_a * 7), 200, 24, "Manual")
    color_change(7, 1)
    self.contents.draw_text(x + (x_a * 1) - 6, y + (y_a * 7), 200, 24, "Semiauto")
    color_change(7, 2)
    self.contents.draw_text(x + (x_a * 2), y + (y_a * 7), 200, 24, "Auto")
    #�����W�X�g�P�\����
    x_a = 48
    color_change(8, 0)
    self.contents.draw_text(x + (x_a * 0), y + (y_a * 8), 200, 24, "Short")
    color_change(8, 1)
    self.contents.draw_text(x + (x_a * 1) + 6, y + (y_a * 8), 200, 24, "Normal")
    color_change(8, 2)
    self.contents.draw_text(x + (x_a * 2) + 22, y + (y_a * 8), 200, 24, "Long")
    color_change(8, 3)
    self.contents.draw_text(x + (x_a * 3) + 24, y + (y_a * 8), 200, 24, "Relaxed")
    #�����t�O���t�B�b�N�\��
    x_a = 48
    color_change(9, true)
    self.contents.draw_text(x, y + (y_a * 9), 200, 24, "Show")
    color_change(9, false)
    self.contents.draw_text(x + x_a + 8, y + (y_a * 9), 200, 24, "Hide")
    #���J�[�\���ʒu�L��
    x_a = 48
    color_change(10, true)
    self.contents.draw_text(x, y + (y_a * 10), 200, 24, "Yes")
    color_change(10, false)
    self.contents.draw_text(x + x_a, y + (y_a * 10), 200, 24, "No")
    #���G���e�B�b�N���b�Z�[�W
    x_a = 48
    color_change(11, 0)
    self.contents.draw_text(x, y + (y_a * 11), 200, 24, "Simple")
    color_change(11, 1)
    self.contents.draw_text(x + x_a + 24, y + (y_a * 11), 200, 24, "Normal")
    color_change(11, 2)
    self.contents.draw_text(x + (x_a * 2) + 48, y + (y_a * 11), 200, 24, "Detailed")
    
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
      text = "Movement type when no key is pressed."
    when 2 # ���̌���C�x���g
      text = "Show or hide partner feeding animation. (Used from party menu)"
    when 3 # �|�[�g�ݒ�
      text = "Set whether �Save� or �Teleport� is listed first."
    when 4 # �󕠓x
      text = "Set how fast partner Satiety decreases."
    when 6 # �o�g���X�s�[�h
      text = "Set the overall battle speed."
    when 7 # ���b�Z�[�W�X�s�[�h
      text = "Set the battle messages display delay."
    when 8 # ���W�X�g�P�\
      text = "Set how much time you get for the Resist minigame."
    when 9 # ���t�O���t�B�b�N
      text = "Whether cum graphics show when applicable."
    when 10 # �J�[�\���ʒu�L��
      text = "Allows cursor to jump to the last used skill in battle."
    when 11 # �G���e�B�b�N���b�Z�[�W
      text = "Set how talkative the succubi are in battle."
    when 13 # �t���X�N���[����
      text = "Full screen or window."
    when 14 # �Q�[������߂�
      text = "Quit the game, or return to the title menu.�B"
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
