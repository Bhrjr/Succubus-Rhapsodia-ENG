#==============================================================================
# �� Window_BoxLeft
#------------------------------------------------------------------------------
# �@�{�b�N�X��ʂŁA�a�����Ă��閲���̖��O��\������E�B���h�E�B
#==============================================================================

class Window_Battle_Command < Window_Base
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_accessor   :index                    # �J�[�\���ʒu
  attr_accessor   :window                   # ����
  attr_accessor   :skill                    # �X�L��
  attr_accessor   :item                     # �A�C�e��
  attr_accessor   :change                   # �p�[�e�B���
  attr_accessor   :escape                   # ����
  attr_accessor   :help                     # �R�}���h���
  attr_accessor   :fade_flag                # �t�F�[�h�p
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    super(0, 300, 640, 100)
    self.opacity = 0
    self.active = false
    self.visible = false
    @index = 0
    @fade_flag = 0
    
    # ����
    @window = Sprite.new
    @window.y = -12
    @window.z = 4
    @window.bitmap = RPG::Cache.windowskin("command_window")
    @window.opacity = 51
    # �X�L��
    @skill = Sprite.new
    @skill.y = -20
    @skill.z = 4
    @skill.bitmap = RPG::Cache.windowskin("command_skill")
    @skill.opacity = 100
    # �A�C�e��
    @item = Sprite.new
    @item.y = -20
    @item.z = 4
    @item.bitmap = RPG::Cache.windowskin("command_item")
    @item.opacity = 100
    # �p�[�e�B���
    @change = Sprite.new
    @change.y = -20
    @change.z = 4
    @change.bitmap = RPG::Cache.windowskin("command_change")
    @change.opacity = 100
    # ����
    @escape = Sprite.new
    @escape.y = -20
    @escape.z = 4
    @escape.bitmap = RPG::Cache.windowskin("command_escape")
    @escape.opacity = 100
    # �R�}���h���
    @help = Sprite.new
    @help.x = 220
    @help.y = 390
    @help.z = 100
    @help.bitmap = Bitmap.new(300, 200)
    @help.bitmap.font.size = $default_size_mini
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    if @help.bitmap != nil
      @help.bitmap.clear
    end
    x = 0
    y = 0
    case self.index
    when 0 # �X�L��
      @skill.opacity = 255
      @item.opacity = 100
      @change.opacity = 100
      @escape.opacity = 100
      @help.bitmap.draw_text(x, y, 200, 30, "Use a technique", 1) 
    when 1 # �A�C�e��
      @skill.opacity = 100
      @item.opacity = 255
      @change.opacity = 100
      @escape.opacity = 100
      @help.bitmap.draw_text(x, y, 200, 30, "Use an item", 1) 
    when 2 # �p�[�e�B���
      @skill.opacity = 100
      @item.opacity = 100
      @change.opacity = 255
      @escape.opacity = 100
      @help.bitmap.draw_text(x, y, 200, 30, "Switch partner", 1) 
    when 3 # ����
      @skill.opacity = 100
      @item.opacity = 100
      @change.opacity = 100
      @escape.opacity = 255
      @help.bitmap.draw_text(x, y, 200, 30, "Run away", 1) 
    end
  end
  #--------------------------------------------------------------------------
  # �� �|�[�Y�p�ꎞ�o��/�B��
  #--------------------------------------------------------------------------
  def hide
    for i in [@window,@skill,@item,@change,@escape,help]
      i.visible = false
    end
  end
  def appear
    for i in [@window,@skill,@item,@change,@escape,help]
      i.visible = true
    end
  end
  #--------------------------------------------------------------------------
  # �� �t�F�[�h
  #--------------------------------------------------------------------------
  def fade
    
    case @fade_flag
    when 1 # �t�F�[�h�C��
      # �o������
      if @window.opacity < 255
        @window.opacity += 51
      end
      if @window.y > -20
        @window.y -= 1
      end
      @fade_flag = 0 if window.y == -20
    when 2 # �t�F�[�h�A�E�g
    end
    
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    
    if @fade_flag > 0
      fade
      return 
    end
    if self.active == true
      # ���b�Z�[�W�\�����̏ꍇ�̓{�b�N�X��������b�N
      if $game_temp.message_window_showing
        return
      end
      # �E�{�^���������ꂽ�ꍇ
      if Input.repeat?(Input::RIGHT)
        # SE �����t
        Audio.se_play("Audio/SE/005-System05", 80, 100)
        if @index == 3
          @index = 0
        else
          @index += 1
        end
        refresh
      end
      # ���{�^���������ꂽ�ꍇ
      if Input.repeat?(Input::LEFT)
        # SE �����t
        Audio.se_play("Audio/SE/005-System05", 80, 100)
        if @index == 0
          @index = 3
        else
          @index -= 1
        end
        refresh
      end
    end
  end
end
