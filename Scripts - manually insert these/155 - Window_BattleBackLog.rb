#==============================================================================
# �� Window_BattleBackLog
#==============================================================================
class Window_BattleBackLog < Window_Base
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
#    super(-64, -64, 720, 640)
    super(-64, -64, 720, 640)
    self.contents = Bitmap.new(width - 32, height - 32)
    self.back_opacity = 150
    self.z = 1100
    @log_text = ""
    @index = 0
    
    # �������ݒ�
    #--------------------------------------------------------------------------
    @start_x = 164 # �J�n�w���W
    @start_y = 64  # �J�n�x���W
    @max_line = 18 # �ő�\���s��
    @scroll_speed = 24
  end
  #--------------------------------------------------------------------------
  # �� ���O�e�L�X�g�̃��t���b�V��
  #--------------------------------------------------------------------------
  def log_text_refresh
    # ���O�e�L�X�g�ϐ��ɐV�������͂�ǉ�
    @log_text += $game_temp.battle_back_log
    $game_temp.battle_back_log = ""
    # ���s�̏d���𒼂�
    @log_text.gsub!("\n\n","\n")
    
    # �����O�e�L�X�g�̍s�����K��l�𒴂����ꍇ�A�O�̍s����鏈��
    #--------------------------------------------------------------------------
    # �܂��s�ŋ敪�����s��
    @log_text.gsub!("\n","\n/")
    text_lines = @log_text.split(/\//)
    # �󔒂���s�݂̂ɂȂ��Ă���s�͍폜����
    for i in 0...text_lines.size
      if text_lines[i] == "" or text_lines[i] == "\n"
        text_lines[i] = nil
      end
    end
    text_lines.compact!
    # ���߂����s������ꍇ�A���̕��O����폜����
    over_lines = text_lines.size - @max_line
    if over_lines > 0
      for i in 0...over_lines
        text_lines.shift
      end
    end
    # �e�L�X�g�����Ȃ���
    new_text = ""
    for text_one in text_lines
      new_text += text_one
    end
    @log_text = new_text
  end
  #--------------------------------------------------------------------------
  # �� �e�L�X�g�ݒ�
  #--------------------------------------------------------------------------
  def refresh
    # ������
    self.contents.clear
    x = @start_x
    line_deep = 0
    # ���O�e�L�X�g�̕������i�[
    text = @log_text.clone
    # c �� 1 �������擾 (�������擾�ł��Ȃ��Ȃ�܂Ń��[�v)
    while ((c = text.slice!(/./m)) != nil)
      # �O���̏ꍇ
      if c == "\H"
        heart = RPG::Cache.picture("heart")
        self.contents.blt(x + 6 , 24 * line_deep + @start_y + 9, heart, Rect.new(0, 0, 16, 16))
        x += 16
        next
      end
      # ���s�����̏ꍇ
      if c == "\n"
        x = @start_x
        line_deep += 1
        next
      end
      # ������`��
      self.contents.draw_text(4 + x, 24 * line_deep + @start_y, 40, 32, c)
      # x �ɕ`�悵�������̕������Z
      x += self.contents.text_size(c).width #+ 2
      if c == "\065"
        x = @start_x
        line_deep += 1
        next
      end
      # ������`��
      self.contents.draw_text(4 + x, 24 * line_deep + @start_y, 40, 32, c)
      # x �ɕ`�悵�������̕������Z
      x += self.contents.text_size(c).width #+ 2
    end
    # ��ԉ��̍s���\�������悤�ɕ\��
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    # ���b�Z�[�W������΃��O�e�L�X�g�����t���b�V��
    if $game_temp.battle_back_log != ""
      log_text_refresh
    end
    # �\�����łȂ��ꍇ�A������󂯕t���Ȃ�
    return unless self.visible
=begin    
    # �����{�^���̏オ�����ꂽ�ꍇ
    if Input.repeat?(Input::UP)
      self.oy += @scroll_speed
      return
    end
    # �����{�^���̉��������ꂽ�ꍇ
    if Input.repeat?(Input::DOWN)
      self.oy -= @scroll_speed
      return
    end
=end
  end
  #--------------------------------------------------------------------------
  # �� �\�����Ƀ��t���b�V����������
  #--------------------------------------------------------------------------
  def visible=(visible)
    refresh if visible == true
    super
  end
end