#==============================================================================
# �� Window_BattleLog
#------------------------------------------------------------------------------
# �@�퓬���̃��b�Z�[�W�\���p�E�B���h�E�ł��B(Window_Message������ɂ��Ă܂�)
#
#   ���ڈ��Ƃ��āA�S�p����20���~4�s�B
#
#==============================================================================
class Window_BattleLog < Window_Base
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
    attr_accessor   :bgframe_sprite         # �o�g�����O�̃E�B���h�E�摜
    attr_accessor   :wait_count             # �E�F�C�g�J�E���g
    attr_accessor   :keep_flag              # �L�[�v�t���O
    attr_accessor   :clear_flag             # �N���A�t���O
    attr_accessor   :last_x                 # �ŏI�擾�w���W
    attr_accessor   :last_y                 # �ŏI�擾�x���W
    attr_accessor   :stay_flag              # �ێ��t���O
    attr_accessor   :pause                  # �ێ��t���O
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    #super(100, 280, 540, 150)
    super(100, 280, 418, 150)
    @bgframe_sprite = Sprite.new
    @bgframe_sprite.x = 0
    @bgframe_sprite.y = -12
    @bgframe_sprite.z = 1
    @wait_count = 0
    @keep_flag = false
    @clear_flag = false
    @last_x = 0
    @last_y = 0
    self.contents = Bitmap.new(width - 32, height - 32)
    self.opacity = 0
    self.visible = false
    bitmap = RPG::Cache.windowskin($game_system.battlelog_back_name)
    @bgframe_sprite.bitmap = bitmap
    @bgframe_sprite.visible = false
    # �|�[�Y�T�C���̍쐬
    @pause = Sprite_Pause.new
    # �|�[�Y�T�C���̐ݒ�
    @pause.visible = false
    # Z���W�̐ݒ�
    @pause.z = self.z + 1
    # �|�[�Y�T�C���ʒu
    @pause.x = self.x + self.width / 2 + 8
    @pause.y = self.y + self.height - 24
    # ��~�t���O
    @stay_flag = false
  end
  #--------------------------------------------------------------------------
  # �� �e�L�X�g�ݒ�
  #     text  : �E�B���h�E�ɕ\�����镶����(��������̔z�񂲂Ɠn���Ă�OK)
  #     align : �A���C�������g (0..�������A1..���������A2..�E����)
  #--------------------------------------------------------------------------
  def refresh
    text = $game_temp.battle_log_text
    
    #p $game_temp.battle_log_text
    
    
    
    
=begin
      # ���O����
      if ["\\","\\\","\\\","\\y\"].include?($game_temp.battle_back_log)
        $game_temp.battle_back_log += "CLEAR"
        $game_temp.battle_back_log.gsub!("\CLEAR","")
      elsif $game_temp.battle_back_log == "\n"
        $game_temp.battle_back_log = ""
      end
=end
    
    
=begin
    # �}�j���A�����[�h�͖�����\������
    if $game_system.system_read_mode == 0
      text += "CHECK"
      if text.match("\\CHECK")
        text.gsub!("CHECK","")
      else
        text.gsub!("CHECK","\\")
      end
    end
=end

=begin    
    # ���O����
    if ["\n","\"].include?(text)
      $game_temp.battle_log_text = ""
      return
    end
=end
    # �L�[�v���Ȃ�Ō�Ɏ擾�������W��ǂݍ���
    if @keep_flag == true
      x = @last_x
      y = @last_y
      @keep_flag = false
    else
      # �L�[�v���ĂȂ����͍��W���N���A
      x = y = 0
      # �o�b�N���O�ɉ��s�w���ǉ�
      $game_temp.battle_back_log += "\n"
    end

    # ���䕶������
    begin
      last_text = text.clone
      text.gsub!(/\\[Vv]\[([0-9]+)\]/) { $game_variables[$1.to_i] }
    end until text == last_text
    text.gsub!(/\\[Nn]\[([0-9]+)\]/) do
      $game_actors[$1.to_i] != nil ? $game_actors[$1.to_i].name : ""
    end
    # �֋X��A"\\\\" �� "\000" �ɕϊ�
    text.gsub!(/\\\\/) { "\000" }
    # "\\C" �� "\001" �ɁA"\\G" �� "\002" �ɕϊ�
    text.gsub!(/\\[Cc]\[([0-9]+)\]/) { "\001[#{$1}]" }
    text.gsub!(/\\[Gg]/) { "\002" }
    # c �� 1 �������擾 (�������擾�ł��Ȃ��Ȃ�܂Ń��[�v)
    while ((c = text.slice!(/./m)) != nil)
      # \\ �̏ꍇ
      if c == "\000"
        # �{���̕����ɖ߂�
        c = "\\"
      end
      # \C[n] �̏ꍇ
      if c == "\001"
        # �����F��ύX
        text.sub!(/\[([0-9]+)\]/, "")
        color = $1.to_i
        if color >= 0 and color <= 7
          self.contents.font.color = text_color(color)
        end
        # ���̕�����
        next
      end
      if c == "\H"
        heart = RPG::Cache.picture("heart")
        self.contents.blt(x + 6 , 24 * y + 10, heart, Rect.new(0, 0, 16, 16))
        x += 16
        # ���̕�����
        next
      end
      # �E�F�C�g����(������)�̏ꍇ
      if c == "\"
        # �E�F�C�g������
        case $game_system.ms_skip_mode
        when 3 #�蓮���胂�[�h
          @wait_count = 1
        when 2 #�f�o�b�O���[�h
          @wait_count = 3
        when 1 #�������[�h
          @wait_count = 4
        else
          @wait_count = ($game_system.battle_speed_time(1) * 3)
        end
        $game_temp.battle_log_wait_flag = true
        # ���̍��W���ێ����ĕԂ�
        @keep_flag = true
        @last_x = x
        @last_y = y
        return
      end
      # �E�F�C�g����(�Z����)�̏ꍇ
      if c == "\"
        # �E�F�C�g������
        case $game_system.ms_skip_mode
        when 3 #�蓮���胂�[�h
          @wait_count = 1
        when 2 #�f�o�b�O���[�h
          @wait_count = 1
        when 1 #�������[�h
          @wait_count = 2
        else
          @wait_count = $game_system.battle_speed_time(1)
        end
        $game_temp.battle_log_wait_flag = true
        # ���̍��W���ێ����ĕԂ�
        @keep_flag = true
        @last_x = x
        @last_y = y
        return
      end
      # �E�F�C�g����(�V�X�e��)�̏ꍇ
      #if c == "\y"
      #  # �E�F�C�g������
      #  case $game_system.ms_skip_mode
      #  when 3 #�蓮���胂�[�h
      #    @wait_count = 1
      #  when 2 #�f�o�b�O���[�h
      #    @wait_count = 8
      #  when 1 #�������[�h
      #    @wait_count = 12
      #  else
      #    @wait_count = $game_system.battle_speed_time(0)
      #  end
      #  $game_temp.battle_log_wait_flag = true
      #  # ���̍��W���ێ����ĕԂ�
      #  @keep_flag = true
      #  @last_x = x
      #  @last_y = y
      #  return
      #end
      # ���s�����̏ꍇ
      if c == "\n"
        # y �� 1 �����Z
        y += 1
        x = 0
        @keep_flag = true
        @last_x = x
        @last_y = y
        # �o�b�N���O�ɉ��s�w���ǉ�
        $game_temp.battle_back_log += "\n"
        # ���O�������ς��Ȃ�N���A�t���O�����ĕԂ�
        if y > 3 #and text != ""
#          if Input.trigger?(Input::C)
            @clear_flag = true
            $game_temp.battle_log_wait_flag = true
            @keep_flag = false
            #���蓮����̏ꍇ�̂݃X�e�C�t���O������
            if $game_system.system_read_mode == 0
              @stay_flag = true
            end
            case $game_system.ms_skip_mode
            when 3 #�蓮���胂�[�h
              @wait_count = 4
            when 2 #�f�o�b�O���[�h
              @wait_count = 8
            when 1 #�������[�h
              @wait_count = 12
            else
              @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time
            end
#          end
          return
        end
        # ���̕�����
        next
      end
      # �蓮���s�����̏ꍇ
      if c == "\"
        # y �� 1 �����Z
        y += 1
        x = 0
        @keep_flag = true
        @last_x = x
        @last_y = y
        #���蓮����̏ꍇ�̂݃X�e�C�t���O������
        if $game_system.system_read_mode == 0
          @stay_flag = true
          @wait_count = 1
        end
        # �o�b�N���O�ɉ��s�w���ǉ�
        $game_temp.battle_back_log += "\n"
        # ���O�������ς��Ȃ�N���A�t���O�����ĕԂ�
        if y > 3 #and text != ""
#          if Input.trigger?(Input::C)
            @clear_flag = true
            $game_temp.battle_log_wait_flag = true
            @keep_flag = false
            case $game_system.ms_skip_mode
            when 3 #�蓮���胂�[�h
              @wait_count = 4
            when 2 #�f�o�b�O���[�h
              @wait_count = 8
            when 1 #�������[�h
              @wait_count = 12
            else
              @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time
            end
#          end
          return
#        elsif y > 3 and text == ""
#          @stay_flag = false
        end
        # ���̕�����
        if $game_system.system_read_mode == 0
          return
        else
          next
        end
      end
      # ������`��
#      self.contents.font.name = ["���C���I"]
      self.contents.draw_text(4 + x, 24 * y, 40, 32, c)
      # x �ɕ`�悵�������̕������Z
      x += self.contents.text_size(c).width #+ 2
      # �f�o�b�O�p�A���������m�F
      if 4 + x > self.contents.width and $DEBUG
        Audio.se_play("Audio/SE/069-Animal04", 80, 100)
        print "�G���[�F���̍s�͉��������𒴉߂��Ă��܂��B\n�������F#{(x/14)-1}/26�@�����F#{4 + x}/#{self.contents.width}"
      end
      # �o�b�N���O�ɕ�����ǉ�
      $game_temp.battle_back_log += c
    end
   self.visible = true
   @bgframe_sprite.visible = true

   
   
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    # �o������
    if @bgframe_sprite.opacity < 255
      @bgframe_sprite.opacity += 51
    end
    if @bgframe_sprite.y > -20
      @bgframe_sprite.y -= 1
      return
    end
    
    # �X�e�C�t���O�������Ă���ꍇ���A�}�j���A�����[�h���̂ݒ�~��Ԃɂ���
    if @stay_flag
      @wait_count = 2
      $game_temp.battle_log_wait_flag = true
      @pause.visible = true
    end

    # �|�[�Y�T�C��
    @pause.update if @pause.visible

    if Input.trigger?(Input::C)
      @wait_count = 1
      if @stay_flag
        $game_temp.battle_log_wait_flag = false
        @stay_flag = false
        @pause.visible = false
      end
    end

    if @stay_flag and $game_system.system_read_mode != 0
      $game_temp.battle_log_wait_flag = false
      @stay_flag = false
      @pause.visible = false
      @wait_count = 1 if @wait_count == 0
    end
    
    if @wait_count > 0
      @wait_count -= 1
      if @wait_count == 0 and @clear_flag == true
        self.contents.clear
        @keep_flag = false
        @clear_flag = false
      end
      return
    end
    
    # ���O����
    if $game_temp.battle_log_text != ""
      log_correction 
    end
    
    # ���b�Z�[�W������΃��t���b�V��
    if $game_temp.battle_log_text != ""
      if $game_temp.battle_log_text == "\n"
        $game_temp.battle_log_text = ""
        return
      end
      refresh
    end
  end
  #--------------------------------------------------------------------------
  # �� ���O����
  #--------------------------------------------------------------------------
  def log_correction

    # �E�F�C�g�̏����𒼂�
    $game_temp.battle_log_text.gsub!("\n\","\\n")
    $game_temp.battle_log_text.gsub!("\\","\\")
    
    # ���s���d�����Ă���ꍇ�A�P�ɂ���
    $game_temp.battle_log_text.gsub!(/(\\\\n)+/,"\\n")
    $game_temp.battle_log_text.gsub!(/(\\\\)+/,"\\")
    
    # \\n�E\\�����̏ꍇ�A�e�L�X�g������
    if ["\\n","\\"].include?($game_temp.battle_log_text)
      $game_temp.battle_log_text = ""
    end

  end
  #--------------------------------------------------------------------------
  # �� ���
  #--------------------------------------------------------------------------
  def dispose
    super
    @bgframe_sprite.dispose
    # �|�[�Y�T�C��
    @pause.dispose
  end
end
#==============================================================================
# ���b�Z�[�W�w�i
#==============================================================================
class Game_System
  attr_accessor :battlelog_back_name
  def battlelog_back_name
    return @battlelog_back_name.nil? ? "battle_message" : @battlelog_back_name
  end
end
