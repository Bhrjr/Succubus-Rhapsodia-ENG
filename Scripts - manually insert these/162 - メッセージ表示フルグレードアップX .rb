# ������ No 9. ���b�Z�[�W�\���t���O���[�h�A�b�vX ������
#
# update 2007/12/26
#
#==============================================================================
# �� �J�X�^�}�C�Y�|�C���g
#==============================================================================
class Window_Message < Window_Selectable
  #--------------------------------------------------------------------------
  # �����T�C�Y�ݒ�
  #--------------------------------------------------------------------------
  DEFAULT_FONT_SIZE      =  $default_size      # �W�������T�C�Y( 22�������ݒ� )
  DEFAULT_LINE_SPACE     =  24      # �W���s�ԁ@�@�@( 32�������ݒ� )
  #--------------------------------------------------------------------------
  # ��{���b�Z�[�W�E�B���h�E
  #--------------------------------------------------------------------------
  DEFAULT_RECT           = Rect.new(48, 0, 520, 152)
#  BATTLE_RECT            = Rect.new(118, 292, 544, 150) #��
  BATTLE_RECT            = Rect.new(118, 292, 402, 150) #��
  DEFAULT_BACK_OPACITY   = 160      # �E�B���h�E�̕s�����x
  DEFAULT_STRETCH_ENABLE = true     # �܍s�ȏ�̏ꍇ�����I�ɃT�C�Y��ύX����
  #--------------------------------------------------------------------------
  # �ʏ탂�[�h(�ꕶ�����`��)
  #--------------------------------------------------------------------------
  DEFAULT_TYPING_ENABLE = true  # (false�ɂ���Ɠ����ɑS���͂�\��)
  DEFAULT_TYPING_SPEED  = 0     # �ʏ탂�[�h���̊�{���b�Z�[�W�X�s�[�h(�傫���قǒx��)
  #--------------------------------------------------------------------------
  # �l�X�s�[�h�ݒ�
  #--------------------------------------------------------------------------
  TALK_SPEEDS = {
  }
  #--------------------------------------------------------------------------
  # �C���t�H���[�V�����E�B���h�E
  #--------------------------------------------------------------------------
  INFO_RECT              = Rect.new(-16, 64, 672, DEFAULT_LINE_SPACE + 16)
  #--------------------------------------------------------------------------
  # �e���b�v���[�h (�X�L�b�v�֎~�A�����`�摬�x��x�����A�����I�ɕ��܂�)
  #--------------------------------------------------------------------------
  TELOP_SWITCH_ID       = 9     # �e���b�v���[�h��ON�ɂ���X�C�b�` ID
  TELOP_TYPING_SPEED    = 0     # �e���b�v���[�h���̊�{���b�Z�[�W�X�s�[�h
  TELOP_HOLD_WAIT       = 20    # �������܂ł̑ҋ@����[�P��:F]
  #--------------------------------------------------------------------------
  # �����X�L�b�v�^�^�C�s���O�X�L�b�v
  #--------------------------------------------------------------------------
  KEY_TYPE_SKIP         = Input::C # �^�C�s���O�X�L�b�v(�c����u�ԕ\��)
  KEY_HISPEED_SKIP      = Input::B # �����X�L�b�v
  HISKIP_ENABLE_SWITCH_ID = 10 # �����X�L�b�v��L���ɂ���X�C�b�`��ID.( 0 �͏펞�\)
  SKIP_BAN_SWITCH_ID      = 0 # �����^�^�C�s���O�����ɃX�L�b�v�֎~����X�C�b�`��ID. ( 0 �͏펞�\)
  #--------------------------------------------------------------------------
  # �L�����|�b�v
  #--------------------------------------------------------------------------
  CHARPOP_HEIGHT         =  56      # �L�����|�b�v�̍���
  #--------------------------------------------------------------------------
  # �l�[���E�B���h�E
  #--------------------------------------------------------------------------
  NAME_WINDOW_SKIN        = "MessageName"     # �摜�t�@�C��(Windowskins)
  NAME_WINDOW_OFFSET_X    =   0    # \name �E�B���h�E�̃I�t�Z�b�g�ʒu X
  NAME_WINDOW_OFFSET_Y    =   5     # \name �E�B���h�E�̃I�t�Z�b�g�ʒu Y
  NAME_WINDOW_TEXT_SIZE   =   $default_size_mini    # \name �E�B���h�E�̕����T�C�Y
  NAME_WINDOW_TEXT_COLOR  = Color.new(224,252,255,255) # \name �E�B���h�E�����F
  #--------------------------------------------------------------------------
  # �I�����t�F�[�h�A�E�g (Fade Out Before Terminate)
  #--------------------------------------------------------------------------
  FOBT_DURATION           =  5     # \fade ���w�肵�����̃t�F�[�h�������� 
  #--------------------------------------------------------------------------
  # �����`��SE ���O����
  #--------------------------------------------------------------------------
  NOT_SOUND_CHARACTERS = [" ", "�@", "�E","�", "�A", "�B", "��"]
end
module XRXS9
  #--------------------------------------------------------------------------
  # �����E�F�C�g����
  #--------------------------------------------------------------------------
  TYPEWAITS = ["�E","�","�A","�B","�@"]
  #--------------------------------------------------------------------------
  # ���b�Z�[�W�w�i
  #--------------------------------------------------------------------------
  BACK_NAME = "MessageBack" # (Windowskins)
  BACK_OX   =  0
  BACK_OY   =  24
end
#==============================================================================
# ���b�Z�[�W�w�i
#==============================================================================
class Game_System
  attr_accessor :messageback_name
  def messageback_name
    return @messageback_name.nil? ? XRXS9::BACK_NAME : @messageback_name
  end
end
#==============================================================================
# --- �Z���t���ʉ� ---
#        ���X�N���v�g�F$game_system.speak_se = RPG::AudioFile.new("�t�@�C����")
#        �Ɛݒ肵�Ďg�p���܂��B
#==============================================================================
class Game_System
  attr_accessor :speak_se
  def speak_se_play
    self.se_play(self.speak_se) if self.speak_se != nil
  end
end
#==============================================================================
# --- �L�����|�b�v���E�ʒu�w�� --- [�P�ʁF�}�b�v���W]
#==============================================================================
class Game_System
  attr_accessor :limit_right
end
#==============================================================================
# --- �}�e���A���@�\�A�g
#==============================================================================
class Game_Temp
  attr_accessor :current_material
end
#==============================================================================
# �� Sprite_Pause
#==============================================================================
class Sprite_Pause < Sprite
  def initialize
    super
    self.bitmap = RPG::Cache.windowskin($game_system.windowskin_name)
    self.x = 604
    self.y = 456
    self.z = 5500
    @count = 0
    @wait_count = 0
    update
  end
  def update
    super
    if @wait_count > 0
      @wait_count -= 1
    else
      @count = (@count + 1)%4
      x = 160 + @count % 2
      y =  64 + @count / 2
      self.src_rect.set(x, y, 16, 16)
      @wait_count = 4
    end
  end
end
#==============================================================================
# �I�����E�B���h�E
#==============================================================================
class Window_MessageSelect < Window_Selectable
  #--------------------------------------------------------------------------
  # �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize(window)
    @message_window = window
    super(0,0,160,160)
    self.visible = false
    self.back_opacity = Window_Message::DEFAULT_BACK_OPACITY
    self.contents = Bitmap.new(1,1)
    self.z = 9998
    @column_max = 1
    self.index = -1
  end
  #--------------------------------------------------------------------------
  # �Z�b�g�I
  #--------------------------------------------------------------------------
  def set(texts)
    if texts.empty?
      texts = [""]
    end
    max_width = 1
    for text in texts
      w = self.contents.text_size(text).width
      max_width = w if max_width < w
    end
    self.contents.dispose
    self.contents = Bitmap.new(max_width + 8, texts.size * 32)
    self.width  = self.contents.width  + 32
    self.height = self.contents.height + 32
    y = 0
    for text in texts
      self.contents.draw_text(4, y, max_width, 32, text)
      y += 32
    end
    self.reset
    self.index = 0
    @item_max = texts.size
  end
  #--------------------------------------------------------------------------
  # ���W�̃��Z�b�g
  #--------------------------------------------------------------------------
  def reset
    self.x = @message_window.x + @message_window.width - self.width
    upper = @message_window.y
    under = 480 - (@message_window.y + @message_window.height)
    if upper > under
      self.y = @message_window.y - self.height
    else
      self.y = @message_window.y + @message_window.height
    end
  end
end
#==============================================================================
# �� Window_Message
#==============================================================================
class Window_Message < Window_Selectable
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_reader   :bgframe_sprite  # �w�i�摜
  attr_reader   :select_window   # �I�����E�B���h�E
  # �萔
  AUTO   = 0
  LEFT   = 1
  CENTER = 2
  RIGHT  = 3
  #--------------------------------------------------------------------------
  # �� line_height : �s�̍���(@y�����l)��Ԃ��܂��B
  #--------------------------------------------------------------------------
  def line_height
    return DEFAULT_LINE_SPACE
  end
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  alias xrxs9_initialize initialize
  def initialize
    # �w�i
    @bgframe_sprite = Sprite.new
    @bgframe_sprite.x = 320
    @bgframe_sprite.y =   0
    @bgframe_sprite.z += 3000 
    @bgframe_sprite.oy = XRXS9::BACK_OY
    if $game_temp.in_battle 
      @bgframe_sprite.visible = false
    end
    # ���O�^�u
    @name_skin = RPG::Cache.windowskin(NAME_WINDOW_SKIN)
    # ���͕���
    @text_sprite = Sprite.new
    @text_sprite.opacity = 0
    @text_sprite.bitmap = Bitmap.new(1,1)
    # �I��������
    @select_window = Window_MessageSelect.new(self)
    # ������
    @stand_pictuers = []
    @held_windows = []
    @extra_windows = []
    @extra_sprites = []
    # �|�[�Y�T�C���̍쐬
    @pause = Sprite_Pause.new
    #@pause_flag = false
    # ������
    @line_index = 0
    @telop_hold_count = 0
    # �Ăі߂�
    xrxs9_initialize
    #self.contents.dispose
    #self.contents = Bitmap.new(1,1)
    self.index = -1
    # �|�[�Y�T�C���̐ݒ�
    @pause.visible = false
    # Z���W�̐ݒ�
    @pause.z = self.z + 1
  end
  #--------------------------------------------------------------------------
  # �y��̈ʒu�A��
#--------------------------------------------------------------------------
  def x=(n)
    @text_sprite.x = n + 8
    @select_window.reset
    super
  end
  def y=(n)
    @text_sprite.y = n + 8
    @select_window.reset
    super
  end
  def z=(n)
    @text_sprite.z = n + 3
    super
  end
  def visible=(b)
    @text_sprite.visible = b
    @bgframe_sprite.visible = b
    super
  end
  #--------------------------------------------------------------------------
  # �� �ꎞ����/�o��
  #--------------------------------------------------------------------------
  def hide
    self.visible = false
    @text_sprite.visible = false
    $game_temp.message_window_showing = false
    if @pause.visible
      @pause.visible = false
      @pause_icon_stay = true
    end
  end
  def appear
    self.opacity = 0 if @pause
    self.visible = true
    @text_sprite.visible = true
    $game_temp.message_window_showing = true
    if @pause_icon_stay
      @pause.visible = true
      @pause_icon_stay = false
    end
  end
  #--------------------------------------------------------------------------
  # �� ���
  #--------------------------------------------------------------------------
  alias xrxs9_dispose dispose
  def dispose
    # �Ăі߂�
    xrxs9_dispose
    # �z�[���h���ꂽ�E�B���h�E���J��
    @held_windows.each {|window| window.dispose}
    @held_windows.clear
    # �|�[�Y�T�C��
    @pause.dispose
    # �I�����E�B���h�E
    @select_window.dispose
    # �O���L���b�V���J��
    if @gaiji_cache != nil
      @gaiji_cache.dispose
      @gaiji_cache = nil
    end
    # ���͕���
    @text_sprite.dispose
    # �w�i�s�N�`�������
    @bgframe_sprite.dispose
  end
  #--------------------------------------------------------------------------
  # �� ���b�Z�[�W�I������
  #--------------------------------------------------------------------------
  alias xrxs9_terminate_message terminate_message
  def terminate_message
    # �f�ʂ�t���O���N���A
    @passable = false
    $game_player.messaging_moving = false
    # �I����
    @select_window.visible = false
    $game_temp.message_text = nil
    # �E�B���h�E�z�[���h
    if @window_hold
      # �E�B���h�E��X�v���C�g�̕������쐬
      @held_windows.push(Window_Copy.new(self))
      @held_windows.push(Sprite_Copy.new(@text_sprite))
      for window in @extra_windows
        next if window.disposed?
        @held_windows.push(Window_Copy.new(window))
      end
      for sprite in @extra_sprites
        next if sprite.disposed?
        @held_windows.push(Sprite_Copy.new(sprite))
      end
      # �l�[���E�B���h�E�����
      if @name_frame != nil
        @name_frame.dispose
        @name_frame = nil
      end
      # �ݒ���N���A
      self.opacity = 0
      @text_sprite.opacity = 0
      @extra_windows.clear
      @extra_sprites.clear
    else
      # �z�[���h���ꂽ�E�B���h�E���J��
      @held_windows.each {|object| object.dispose}
      @held_windows.clear
    end
    # �Ăі߂�
    xrxs9_terminate_message
  end
  #--------------------------------------------------------------------------
  # �� �|�b�v�L�����N�^�[�̐ݒ�Ǝ擾
  #--------------------------------------------------------------------------
  def pop_character=(character_id)
    @pop_character = character_id
  end
  def pop_character
    return @pop_character
  end
  #--------------------------------------------------------------------------
  # �� �N���A
  #--------------------------------------------------------------------------
  def clear
    @text_sprite.bitmap.clear
    @text_sprite.bitmap.font.color = normal_color
    @text_sprite.bitmap.font.size  = DEFAULT_FONT_SIZE
    self.opacity      = 255
    self.back_opacity = DEFAULT_BACK_OPACITY
    @text_sprite.opacity  = 255
    @mid_stop     = false       # \!    �@�@�̒��f���t���O
    @current_name = nil         # \name �@�@�̃l�[���ێ�
    @window_hold  = false       # \hold �@�@�̃E�B���h�E�z�[���h�̃t���O
    @stand_pictuer_hold = false # \picthold �̃X�^���h�s�N�`���̕ێ��t���O
    @passable     = false       # \pass �@�@�̑f�ʂ�\�t���O
    @inforesize   = false       # \info�@�@ �̃C���t�H���T�C�Y
    @material     = nil         # \material
    @face_bitmap  = nil         # \f
    # �Œ�ݒ�����[�h
    @auto_align   = LEFT         # ��{�ʒu����
    if $game_temp.in_battle and not $game_temp.in_battle_change
      @default_rect = BATTLE_RECT #��
    else
      @default_rect = DEFAULT_RECT # ��{���b�Z�[�W�E�B���h�E��`
    end
    # ���Ǝc��̂�����ւ�̂��̂�S�� 0 �ŏ�����
    @x = @y = @indent = @line_index = 0
    @cursor_width = @write_wait = @lines_max = 0
    # �e�s�̕`�敝���ʒu�����ݒ菉����
    @line_widths = []
    @line_aligns = []
    # self.pop_character �� nil �̏ꍇ�A�W���ʒu�B-1�̏ꍇ�A�����Z���^�[�B
    # 0�ȏ�̏ꍇ�@�L�����|�b�v�B0�͎�l���A1�ȍ~�̓C�x���g�B
    self.pop_character = nil
    # �l�[���E�B���h�E�����
    if @name_frame != nil
      @name_frame.dispose
      @name_frame = nil
    end
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V�� [�Ē�`]
  #--------------------------------------------------------------------------
  def refresh
    # �r�b�g�}�b�v�̎擾�Ɛݒ�
    if $game_system.messageback_name != ""
      bitmap = RPG::Cache.windowskin($game_system.messageback_name)
      @bgframe_sprite.bitmap = bitmap
      @bgframe_sprite.ox = bitmap.width / 2 + XRXS9::BACK_OX
      self.opacity = 0
    end
    # ������
    self.clear
    # �o�b�N���O�ɉ��s�w���ǉ�
    $game_temp.battle_back_log += "\n" if $game_temp.in_battle
    # �\���҂��̃��b�Z�[�W������ꍇ
    if $game_temp.message_text != nil
      @now_text = $game_temp.message_text
      # ���s�폜�w��\_�����邩�H
      if (/\\_\n/.match(@now_text)) != nil
        $game_temp.choice_start -= 1
        @now_text.gsub!(/\\_\n/) { "" }
      end
      # �C���t�H����
      @inforesize = (@now_text.gsub!(/\\info/) { "" } != nil)
      # �E�B���h�E�ێ��w��\hold�����邩�H
      @window_hold = (@now_text.gsub!(/\\hold/) { "" } != nil)
      # \v�̑����ϊ�
      @now_text.gsub!(/\\[v]\[([0-9]+)\]/) { $game_variables[$1.to_i].to_s }
      # \V��Ǝ����[�`���ɕύX(�ǉ�����)
      begin
        last_text = @now_text.clone
        @now_text.gsub!(/\\[V]\[([IiWwAaSs]?)([0-9]+)\]/) { convart_value($1, $2.to_i) }
      end until @now_text == last_text
      @now_text.gsub!(/\\[Nn]\[([0-9]+)\]/) do
        $game_actors[$1.to_i] != nil ? $game_actors[$1.to_i].name : ""
      end
      # \name ����
      if @now_text.sub!(/\\[Nn]ame\[(.*?)\]/) { "" }
        @current_name = $1
      end
      # �E�B���h�E�|�b�v����
      if @now_text.gsub!(/\\[Pp]\[([0-9]+)\]/) { "" }
        self.pop_character = $1.to_i
      end
      # ��O���t�B�b�N�\���w��
      if (/\\[Ff]\[(.+?),([0-9]+)\]/.match(@now_text)) != nil
        @now_text.gsub!(/\\[Ff]\[(.+?),([0-9]+)\]/) { "" }
        begin
          face = RPG::Cache.picture($1)
          n    = $2.to_i
          rect = Rect.new(n % 4 * 96, n / 4 * 96, 96, 96)
          @face_bitmap = Bitmap.new(96,96)
          @face_bitmap.blt(0, 0, face, rect)
        rescue
          nil
        end
      end
      # ���s�w��
      if (/\\n/.match(@now_text)) != nil
        $game_temp.choice_start += 1
        @now_text.gsub!(/\\n/) { "\n" }
      end
      # �t�F�[�h����
      if @now_text.gsub!(/\\fade/) { "" }
        @fade_count_before_terminate = FOBT_DURATION
      end
      # �f�ʂ蔻��
      if @now_text.gsub!(/\\pass/) { "" }
        @passable = true
        $game_player.messaging_moving = true
      end
      # �����A�����s���폜
      nil while( @now_text.sub!(/\n\n\z/) { "\n" } )
      # �s���̎擾
      @lines_max = @now_text.scan(/\n/).size
      # ���ݓ��ڂ���Ă��鐧�䕶����z��
      rxs = [/\\\w\[(\w+)\]/, /\\[.]/, /\\[|]/, /\\[>]/, /\\[<]/, /\\[!]/,
              /\\[~]/, /\\[i]/, /\\[Oo]\[([0-9]+)\]/, /\\[Hh]\[([0-9]+)\]/,
              /\\[b]\[([0-9]+)\]/, /\\[Rr]\[(.*?)\]/, /\\[B]/, /\\[I]/, /\\[Mm]/]
      # �C���t�H�E�B���h�E�̋����Z���^�����O
      @line_aligns[0] = CENTER if @inforesize
      # �I�����p�̕��͂��J�b�g�I���č\�z
      lines = @now_text.split(/\n/)
      text  = ""
      texts = []
      for i in 0...lines.size
        if i < $game_temp.choice_start
          text += lines[i] + "\n"
        else
          texts.push(lines[i])
        end
      end
      @now_text = text
      @select_window.set(texts)
      #
      # [�s���Ƃ̐ݒ�]
      #
      lines = @now_text.split(/\n/)
      for i in 0..@lines_max
        # �s�̎擾 (�C���f�b�N�X�͋t��)
        line = lines[@lines_max - i]
        # �󔒍s�̏ꍇ�͎���
        next if line == nil
        # ���䕶�������
        line.gsub!(/\\[Ee]\[([0-9]+)\]/) { "\022[#{$1}]" }
        for rx in rxs
          line.gsub!(rx) { "" }
        end
        # �ʒu�������擾
        @line_aligns[@lines_max - i] =
          line.sub!(/\\center/) {""} ? CENTER :
          line.sub!(/\\right/)  {""} ? RIGHT :
          line.sub!(/\\left/)   {""} ? LEFT :
                                       AUTO
        # �s�̉����̎擾�Ɛݒ�
        cx = @text_sprite.bitmap.text_size(line).width
        @line_widths[@lines_max - i] = cx
      end
      # �ʒu�������䕶���̍폜
      @now_text.gsub!(/\\center/) {""}
      @now_text.gsub!(/\\right/) {""}
      @now_text.gsub!(/\\left/) {""}
      # �L�����|�b�v���̃E�B���h�E���T�C�Y
      if self.pop_character != nil and self.pop_character >= 0
        max_x = @line_widths.max.to_i
        n = 0
        if @current_name != nil
          n = @name_skin.width + 2
        end
        self.width  = [max_x + @indent + DEFAULT_FONT_SIZE/2, n].max + 32
        self.height = [@lines_max * line_height, @indent].max + 16
      end
      #
      # �u�ϊ��v
      #
      # �֋X��A"\\\\" �� "\000" �ɕϊ�
      @now_text.gsub!(/\\\\/) { "\000" }
      # "\\C" �� "\001" �ɁA"\\G" �� "\002" �ɁA
      # "\\S" �� "\003" �ɁA"\\A" �� "\004" �ɕϊ�
      @now_text.gsub!(/\\[Cc]\[([0-9]+)\]/) { "\001[#{$1}]" }
      @now_text.gsub!(/\\[Gg]/) { "\002" }
      @now_text.gsub!(/\\[Ss]\[([0-9]+)\]/) { "\003[#{$1}]" }
      @now_text.gsub!(/\\[Aa]\[(.*?)\]/) { "\004[#{$1}]" }
      @now_text.gsub!(/\\[.]/) { "\005" }
      @now_text.gsub!(/\\[|]/) { "\006" }
      # ��������̂���\016�ȍ~���g�p����
      @now_text.gsub!(/\\[>]/) { "\016" }
      @now_text.gsub!(/\\[<]/) { "\017" }
      @now_text.gsub!(/\\[!]/) { "\020" }
      @now_text.gsub!(/\\[~]/) { "\021" }
      @now_text.gsub!(/\\[Ee]\[([0-9]+)\]/) { "\022[#{$1}]" }
      # �C���f���g�ݒ�(�ǉ�����)
      @now_text.gsub!(/\\[i]/) { "\023" }
      # �e�L�X�g���ߗ��w��(�ǉ�����)
      @now_text.gsub!(/\\[Oo]\[([0-9]+)\]/) { "\024[#{$1}]" }
      # �e�L�X�g�T�C�Y�w��(�ǉ�����)
      @now_text.gsub!(/\\[Hh]\[([0-9]+)\]/) { "\025[#{$1}]" }
      @now_text.gsub!(/\\[Ss]ize\[([0-9]+)\]/) { "\025[#{$1}]" }
      # �󔒑}��(�ǉ�����)
      @now_text.gsub!(/\\[b]\[([0-9]+)\]/) { "\026[#{$1}]" }
      # ���r�\��(�ǉ�����)
      @now_text.gsub!(/\\[Rr]\[(.*?)\]/) { "\027[#{$1}]" }
      # Font.bold
      @now_text.gsub!(/\\[B]/) { "\031" }
      # Font.italic
      @now_text.gsub!(/\\[I]/) { "\032" }
      # ���O���\��
      @now_text.gsub!(/\\[H]/) { "\052" }
      # ���A�C�R���\��(�A�C�e��)
      @now_text.gsub!(/\\[T]\[([0-9]+)\]/) { "\050[#{$1}]" }
      # �����b�Z�[�W�\���ヌ�W�X�g�J�n
      @now_text.gsub!(/\\[Tt]/) { "\051" }
      # �����b�Z�[�W�\���ヌ�W�X�g�J�n
      @now_text.gsub!(/\\[Mm]/) { "\053" }
      # �}�e���A���`��
      if @now_text.gsub!(/\\material/) { "" }
        @material = $game_temp.current_material
      end
      # �����ň�U�E�B���h�E�ʒu�X�V
      reset_window
      #
      # \name�����邩�H�`�u�l�[���E�B���h�E�̍쐬�v
      #
      if @current_name != nil
        # �X�L���̎擾
        frame = @name_skin
        # �쐬
        @name_frame = Sprite.new
        @name_frame.bitmap = Bitmap.new(frame.width, frame.height)
        @name_frame.bitmap.font.size = NAME_WINDOW_TEXT_SIZE
        @name_frame.bitmap.blt(0, 0, frame, frame.rect)
        x = self.x + NAME_WINDOW_OFFSET_X
        n = 0
        @name_frame.x = x
        @name_frame.y = self.y + NAME_WINDOW_OFFSET_Y - frame.height
        @name_frame.z = self.z + 2
        @name_frame.bitmap.draw_text(8, 0, frame.width, frame.height, @current_name, n)
        # �G�N�X�g���X�v���C�g�ɓo�^
        @extra_sprites.push(@name_frame)
      end
    end
    # �E�B���h�E���X�V
    reset_window
    # �R���e���c�̍č쐬
    if @text_sprite.bitmap != nil
      @text_sprite.bitmap.dispose
      @text_sprite.bitmap = nil
    end
    @text_sprite.bitmap = Bitmap.new(self.width - 16, self.height - 16)
    @text_sprite.bitmap.font.color = normal_color

    #
    # �I�����̏ꍇ
    #
    if $game_temp.choice_max > 0
      @item_max = $game_temp.choice_max
    #  self.active = true
      self.index = 0
    end
    #
    # ���l���͂̏ꍇ
    #
    if $game_temp.num_input_variable_id > 0
      digits_max = $game_temp.num_input_digits_max
      number = $game_variables[$game_temp.num_input_variable_id]
      @input_number_window = Window_InputNumber.new(digits_max)
      @input_number_window.number = number
      @input_number_window.x = self.x + 8 + @indent
      @input_number_window.y = self.y + $game_temp.num_input_start * 32
    end
    # �^�C�s���O�X�s�[�h���擾
    @write_speed = DEFAULT_TYPING_SPEED
    if @current_name != nil
      speed = TALK_SPEEDS[@current_name]
      @write_speed = speed if speed != nil
    end
    # �e���b�v���[�h�̏ꍇ
    if telop_ok? #$game_switches[TELOP_SWITCH_ID] and $game_temp.in_battle
      @write_speed = TELOP_TYPING_SPEED
      @fade_count_before_terminate = FOBT_DURATION
      @telop_hold_count = $game_system.battle_speed_time(2)
    end
    # �t�H���g�T�C�Y���Đݒ�
    @text_sprite.bitmap.font.size  = DEFAULT_FONT_SIZE
    # ��O���t�B�b�N
    if @face_bitmap != nil
      #y = (self.height - 128) / 2
      @text_sprite.bitmap.blt(8, 0, @face_bitmap, @face_bitmap.rect)
      @indent += 120
      @face_bitmap.dispose
      @face_bitmap = nil
    end
    # �I�����Ȃ�J�[�\���̍X�V
    if @line_index >= $game_temp.choice_start
      @select_window.visible = true
      self.active = true
    end
    # �s������
    line_reset
    # �}�e���A���̏ꍇ
    case @material
    when RPG::Item, RPG::Weapon, RPG::Armor
      text = @material.name
      rect = @text_sprite.bitmap.text_size(text)
      icon = RPG::Cache.icon(@material.icon_name)
      @text_sprite.bitmap.blt(@x + 8, (line_height - 24)/2, icon, icon.rect)
      @text_sprite.bitmap.draw_text(@x + 36, 0, rect.width, line_height, text)
      @x += rect.width + 32
    when Numeric
      text = @material.to_s
      w = @text_sprite.bitmap.text_size(text).width
      @text_sprite.bitmap.font.size  = DEFAULT_FONT_SIZE + 1
      @text_sprite.bitmap.draw_text(@x, 0, w, line_height, text)
      @text_sprite.bitmap.font.size  = DEFAULT_FONT_SIZE - 2
      @text_sprite.bitmap.draw_text(@x + w + 4, 0, 36, line_height, "�X�B��")
      @x += w + 40
    end
    # �u�ԕ\���̏ꍇ�͂��̂܂܃t���[���X�V��  
    update if $game_system.ms_skip_mode == 2
    update unless DEFAULT_TYPING_ENABLE
  end
  #--------------------------------------------------------------------------
  # �� �s������
  #--------------------------------------------------------------------------
  def line_reset
    # �ʒu�����̎擾
    align = @line_aligns[@line_index]
    align = @auto_align if align == AUTO
    align = CENTER if @inforesize
    case align
    when LEFT
      @x  = @indent
      @x += 8 if $game_temp.choice_start <= @line_index
    when CENTER
      @x = self.width / 2 - 16 - @line_widths[@line_index].to_i / 2
    when RIGHT
      @x = self.width - 40 - @line_widths[@line_index].to_i
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V [�Ē�`]
  #--------------------------------------------------------------------------
  def update
    # ���b�Z�[�W�f�ʂ蒆�ɃC�x���g���J�n�����ꍇ
    if @passable and not $game_player.messaging_moving
      self.opacity = 0
      terminate_message
      return
    end
    # �I����
    if @line_index >= $game_temp.choice_start
      @select_window.update
    end
    # �|�[�Y�T�C��
    @pause.update if @pause.visible
    # �Ăі߂�
    super
    # �t���[���X�V��
    update_main
  end
  #--------------------------------------------------------------------------
  # �L�����|�b�v���ғ������H
  #--------------------------------------------------------------------------
  def chara_pop_working?
    return (!self.pop_character.nil? and self.pop_character >= 0)
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update_main
    # �����ɑΉ�
    update_reset_window if chara_pop_working?
    # �����X�L�b�v����
    if hispeed_skippable_now? and Input.press?(KEY_HISPEED_SKIP)
      @text_sprite.opacity = 255
      @fade_in = false
    end
    # �t�F�[�h�C���̏ꍇ�͂����ŏ���
    if @fade_in
      @text_sprite.opacity += 51
      if @input_number_window != nil
        @input_number_window.contents_opacity += 51
      end
      if @text_sprite.opacity == 255
        @fade_in = false
      end
      return
    end
    # �ϊ�
    @now_text = nil if @now_text == ""
    # �\���҂��̃��b�Z�[�W������ꍇ
    if @now_text != nil and not @mid_stop
      # �ꕶ�����Ƃ̃E�F�C�g
      if @write_wait > 0
        @write_wait -= 1
        return
      end
      @text_not_skip = DEFAULT_TYPING_ENABLE
      # �X�L�b�v�s��ԈȊO�͓���s���ŃX�L�b�v
      unless $game_switches[23]
        @text_not_skip = false if $game_system.ms_skip_mode == 2
        if Input.trigger?(Input::C)
          @text_not_skip = false
        elsif Input.press?(Input::CTRL) and not $game_temp.in_battle
          @text_not_skip = false
        end
      end
      # �����`�揈��
      while true
        # c �� @now_text ����1���������擾 
        c = @now_text.slice!(/./m)
        # �A�����s���ɕ������擾�ł��Ȃ��Ȃ�����I��
        if c == nil
          @text_not_skip = true
          break
        end
        # 1�����̕`��
        type_text(c)
        # �I������
        break if @text_not_skip
      end
      @write_wait += @write_speed
      return
    end
    # ���l���͒��̏ꍇ
    if @input_number_window != nil
      @input_number_window.update
      # ����
      if Input.trigger?(Input::C)
        $game_system.se_play($data_system.decision_se)
        $game_variables[$game_temp.num_input_variable_id] = @input_number_window.number
        $game_map.need_refresh = true
        # ���l���̓E�B���h�E�����
        @input_number_window.dispose
        @input_number_window = nil
        terminate_message
      end
      return
    end
    # �e���b�v�z�[���h����
    if $game_switches[TELOP_SWITCH_ID] and @telop_hold_count >= 1
      if $game_temp.talk_resist_flag_log[/\\T/] != nil
        @telop_hold_count = 0
      else
        @telop_hold_count -= 1
      end
      return
    end
    #
    # ���b�Z�[�W�\�����̏ꍇ
    #
    if @contents_showing
      # �I���O�t�F�[�Y�łȂ��ꍇ
      unless @fade_phase_before_terminate
        # ���W�X�g�Q�[�����͌Œ�
        if $game_temp.resistgame_flag >= 2
          #���W�X�g���䕶��
          if $game_temp.talk_resist_flag_log[/\\T/] != nil or $game_temp.talk_resist_flag_log[/\\t/] != nil
            if $game_temp.resistgame_swicth == true
              $msg.resist_flag = true
            else
              $msg.resist_flag = false
            end
          end
          return
        end
        # �I�����̕\�����łȂ���΃|�[�Y�T�C����\��
        if $game_temp.choice_max == 0
          #self.pause = true
          @pause.visible = true
        end
        # ���� (�e���b�v���[�h�Ȃ�{�^���������Ȃ��Ă����s)
        # ���W�X�g�Q�[�����I�����Ă����s
        if Input.trigger?(Input::C) or telop_ok?
=begin
          skippable_now? or $game_temp.resistgame_flag < 0 or
          ($game_switches[TELOP_SWITCH_ID] and not $game_temp.choice_max > 0 and not $game_temp.battle_actor_command_flag) or
          ($game_system.ms_skip_mode == 2 and not $game_temp.choice_max > 0 and not $game_temp.battle_actor_command_flag) or
          ($msg.talk_step == 4 and $game_switches[77] == true)
=end
          if $game_temp.choice_max > 0
            # ���X�N���v�g����̃��b�Z�[�W�\���ł͖����ꍇ�̓f�t�H���g
            if $game_temp.script_message == false
              $game_system.se_play($data_system.decision_se)
              $game_temp.choice_proc.call(self.index)
            else
              # ���X�N���v�g����̃��b�Z�[�W�̏ꍇ�́A����index��Ԃ�
              $game_temp.script_message_index = self.index
              $game_temp.script_message_cancel = false
            end
          end
          if @mid_stop
            @mid_stop = false
            @pause.visible = false
            return
          elsif @fade_count_before_terminate.to_i > 0
            # �I���O�t�F�[�Y��
            @fade_phase_before_terminate = true
          else
            terminate_message
          end
          @pause.visible = false
        end
        # �L�����Z��
        if Input.trigger?(Input::B)
          if $game_temp.choice_max > 0 and $game_temp.choice_cancel_type > 0
             # ���X�N���v�g����̃��b�Z�[�W�\���ł͖����ꍇ�̓f�t�H���g
            if $game_temp.script_message == false
              $game_system.se_play($data_system.cancel_se)
              $game_temp.choice_proc.call($game_temp.choice_cancel_type - 1)
            else
              # ���X�N���v�g����̃��b�Z�[�W�̏ꍇ�́A�L�����Z������index��Ԃ�
              $game_system.se_play($data_system.cancel_se)
              $game_temp.script_message_index = $game_temp.choice_cancel_type - 1
              $game_temp.script_message_cancel = true
            end
            terminate_message
            @pause.visible = false
            return
          end
        end
      end
      # �I���O�F�J�E���g + �t�F�[�h�A�E�g
      if @fade_phase_before_terminate
        # ��O�␳
        @fade_count_before_terminate  = 0 if @fade_count_before_terminate == nil
        # �J�E���g
        @fade_count_before_terminate -= 1
        # �s�����x���v�Z�E�ݒ�
        opacity = @fade_count_before_terminate * (256 / FOBT_DURATION)
        @text_sprite.opacity = opacity
        # �I������
        if @fade_count_before_terminate <= 0
          @fade_count_before_terminate = 0
          @fade_phase_before_terminate = false
          terminate_message
        end
      end
      return
    end
    #
    # �ȉ��A���b�Z�[�W�\�����łȂ��ꍇ
    #
    # �t�F�[�h�A�E�g���ȊO�ŕ\���҂��̃��b�Z�[�W���I����������ꍇ
    if @fade_out == false and $game_temp.message_text != nil
      @contents_showing = true
      $game_temp.message_window_showing = true
      refresh
      Graphics.frame_reset
      self.visible = true
      # ���퓬���łȂ��ꍇ
      unless $game_temp.in_battle and not $game_temp.in_battle_change
        @bgframe_sprite.visible = true
      end
      @text_sprite.opacity = 0
      if @input_number_window != nil
        @input_number_window.contents_opacity = 0
      end
      @fade_in = true
      if $game_temp.script_message == true #��
        $game_temp.script_message_count += 1
      end
      return
    end
    if self.visible
      @fade_out = true
      self.opacity -= 48
      @text_sprite.opacity = self.opacity
      @name_frame.opacity = self.opacity if @name_frame != nil
      if self.opacity == 0
        message_end
      end
      return
    end
  end
  #--------------------------------------------------------------------------
  # �e���b�v���[�h��ԓK�p�\���H
  #--------------------------------------------------------------------------
  def telop_ok?
    return false if $game_switches[73]
    result = false
    result = true if skippable_now?
    if $game_temp.in_battle
      result = true if $game_temp.resistgame_flag < 0
      if $game_switches[TELOP_SWITCH_ID] or $game_system.ms_skip_mode == 2
        result = true if not $game_temp.choice_max > 0 and not $game_temp.battle_actor_command_flag
      end
      result = true if $msg.talk_step == 4 and $game_switches[77] == true
    end
    return result
  end
  #--------------------------------------------------------------------------
  # ���b�Z�[�W�����̏I��
  #--------------------------------------------------------------------------
  def message_end
    self.visible = false
    @fade_out = false
    $game_temp.message_window_showing = false
    $game_temp.script_message = false #��
    $game_temp.script_message_count = 0 #��
#    $game_temp.script_message_cancel = false #��
    @bgframe_sprite.visible = false 
    # �l�[���E�B���h�E�����
    if @name_frame != nil
      @name_frame.dispose
      @name_frame = nil
    end
  end
  #--------------------------------------------------------------------------
  # �ꕶ���̕`��
  #--------------------------------------------------------------------------
  def type_text(text)
    c = text
    
    
    # ���O�ϊ�����
    case c
    when "\000"
      # \\ : �{���̕����ɖ߂�
      c = "\\"
    end
    #
    # [�P��������]
    #
    case c
    when "\001" # \C[n] : �����F��ύX
      @now_text.sub!(/\[([0-9]+)\]/, "")
      color = $1.to_i
      if color >= 0 and color <= 12
        @text_sprite.bitmap.font.color = text_color(color)
        if @opacity != nil
          color = @text_sprite.bitmap.font.color
          @text_sprite.bitmap.font.color = Color.new(color.red, color.green, color.blue, color.alpha * @opacity / 255)
        end
      end
    when "\002" # \g
      # �S�[���h�E�B���h�E���쐬
      if @gold_window == nil
        @gold_window = Window_Gold.new
        @gold_window.x = 560 - @gold_window.width + 64
        if $game_temp.in_battle
          @gold_window.y = 192
        else
          @gold_window.y = self.y >= 128 ? 32 : 384
        end
        @gold_window.back_opacity = self.back_opacity
      end
    when "\003" # \S[n] �̏ꍇ
      # �����F��ύX
      @now_text.sub!(/\[([0-9]+)\]/, "")
      speed = $1.to_i
      if speed >= 0 and speed <= 19
        @write_speed = speed
      end
    when "\005" # \.
      @write_wait += 5
    when "\006" # \|
      @write_wait += 20
    when "\016" # \>
      @text_not_skip = false
    when "\017" # \<
      @text_not_skip = true
    when "\020" # \!
      @mid_stop = true
    when "\021" # \~
      terminate_message
    when "\024" # \0
      @now_text.sub!(/\[([0-9]+)\]/, "")
      @opacity = $1.to_i
      color = @text_sprite.bitmap.font.color
      @text_sprite.bitmap.font.color = Color.new(color.red, color.green, color.blue, color.alpha * @opacity / 255)
    when "\025" # \H
      @now_text.sub!(/\[([0-9]+)\]/, "")
      @text_sprite.bitmap.font.size = [[$1.to_i, 6].max, 32].min
    when "\027" # \R���r
      process_ruby
    when "\030" # �A�C�R���`��
      # �A�C�R���t�@�C�������擾
      @now_text.sub!(/\[(.*?)\]/, "")
      # �A�C�R����`��
      @text_sprite.bitmap.blt(@x , @y * line_height + 8, RPG::Cache.icon($1), Rect.new(0, 0, 24, 24))
      @x += 24
    when "\022" # �O��
      # []�����̏���
      @now_text.sub!(/\[([0-9]+)\]/, "")
      # �O����\��
      @x += draw_gaiji(4 + @x, @y * line_height + (line_height - @text_sprite.bitmap.font.size), $1.to_i)
    when "\031" # \B���� - Font.bold (�r���I�_���a�ł̔��])
      @text_sprite.bitmap.font.bold ^= true
    when "\032" # \I�Α� - Font.italic
      @text_sprite.bitmap.font.italic ^= true
      
    # ��
    when "\052"
      # �O����\��
      heart = RPG::Cache.picture("heart")
      @text_sprite.bitmap.blt(@x + 6 , @y * line_height + 5, heart, Rect.new(0, 0, 16, 16))
      @x += 16
      #@write_wait += 8
      $game_system.speak_se_play
      
      # �f�o�b�O�p�A���������m�F
      if $game_temp.in_battle and not $game_temp.battle_actor_command_flag
        if 4 + @x > @text_sprite.bitmap.width and $DEBUG
          Audio.se_play("Audio/SE/069-Animal04", 80, 100)
          print "�G���[�F���̍s�͉��������𒴉߂��Ă��܂��B\n�������F#{(@x/14)-1}/26�@�����F#{4 + @x}/#{@text_sprite.bitmap.width}"
        end
      end

      # �퓬���Ȃ�o�b�N���O�ɊO���w���ǉ�
      $game_temp.battle_back_log += "\H" if $game_temp.in_battle
    when "\050"
      # �A�C�e���A�C�R����\��
      @now_text.sub!(/\[([0-9]+)\]/, "")
      ico = $1.to_i
      #�����i
      if ico > 10000
        ico -= 10000
        bitmap = RPG::Cache.icon($data_armors[ico].icon_name)
        @text_sprite.bitmap.blt(@x, @y * line_height , bitmap, Rect.new(0, 0, 24, 24))
        @x += 24
      #�A�C�e��
      elsif ico > 0
        bitmap = RPG::Cache.icon($data_items[ico].icon_name)
        @text_sprite.bitmap.blt(@x, @y * line_height , bitmap, Rect.new(0, 0, 24, 24))
        @x += 24
      #���s�X
      elsif ico == 0
        bitmap = RPG::Cache.icon("gem_03")
        @text_sprite.bitmap.blt(@x, @y * line_height, bitmap, Rect.new(0, 0, 24, 24))
        @x += 20
      end
      return if bitmap == nil
#      if $game_variables[24] > 0
#        bitmap = RPG::Cache.icon($data_armors[$game_variables[24]].icon_name)
#        $game_variables[24] = 0
#      elsif $data_items[$game_variables[23]] != nil
#        bitmap = RPG::Cache.icon($data_items[$game_variables[23]].icon_name)
#      end
    when "\051" #\\T
      $game_temp.talk_resist_flag_log += "\\T" if $game_temp.in_battle
      if $game_temp.resistgame_swicth == true
        $msg.resist_flag = true
      else
        $msg.resist_flag = false
      end
    when "\053"
      @write_wait += $game_system.battle_speed_time(1)
    when "\n" # [���s����]
      @y += 1
      @line_index += 1
      line_reset
      # �I�����Ȃ�J�[�\���̍X�V
      if @line_index >= $game_temp.choice_start
        @select_window.visible = true
        self.active = true
      end
      # �퓬���Ȃ�o�b�N���O�ɉ��s�w���ǉ�
      $game_temp.battle_back_log += "\n" if $game_temp.in_battle
    else
      # ������`��
      rect = @text_sprite.bitmap.text_size(c)
      @text_sprite.bitmap.draw_text(4 + @x, line_height * @y, rect.width + 4, line_height, c)
      @x += rect.width
      # �퓬�����A�N�^�[�R�}���h���ȊO�Ȃ�o�b�N���O�ɕ�����ǉ�
      if $game_temp.in_battle and not $game_temp.battle_actor_command_flag
        $game_temp.battle_back_log += c 
      end
      
      # �f�o�b�O�p�A���������m�F
      if $game_temp.in_battle and not $game_temp.battle_actor_command_flag
        if 4 + @x > @text_sprite.bitmap.width and $DEBUG
          Audio.se_play("Audio/SE/069-Animal04", 80, 100)
          print "�G���[�F���̍s�͉��������𒴉߂��Ă��܂��B\n�������F#{(@x/14)-1}/26�@�����F#{4 + @x}/#{@text_sprite.bitmap.width}"
        end
      end

      # �����`�ʂ�SE�����t
      unless NOT_SOUND_CHARACTERS.include?(c)
        $game_system.speak_se_play
      end
      # �^�C�v�E�F�C�g
      if XRXS9::TYPEWAITS.include?(c)
        if $game_temp.in_battle
          @write_wait += $game_system.battle_speed_time(1) #�W���͂R
        else
          @write_wait += 1
        end
      end
    end
 
  end
  #--------------------------------------------------------------------------
  # �� �E�B���h�E�̈ʒu�ƕs�����x�̐ݒ� [�Ē�`]
  #--------------------------------------------------------------------------
  def reset_window
    if @inforesize
      self.x = INFO_RECT.x
      self.y = INFO_RECT.y
      self.width  = INFO_RECT.width
      self.height = INFO_RECT.height
    elsif self.pop_character != nil and self.pop_character >= 0
      update_reset_window
    else
      self.x = @default_rect.x
      self.y = @default_rect.y
      self.width  = @default_rect.width
      self.height = @default_rect.height
      #
      position = $game_system.message_position
      position = 3 if $game_temp.in_battle
      position = 4 if $game_temp.in_battle_change
      position = 5 if $game_temp.in_menu or $game_temp.in_box
      case position
      when 0 # �� 
        self.y = [16, -NAME_WINDOW_OFFSET_Y + 4].max
      when 1 # ��
        self.y = 192
      when 2 # ��
        self.y = 348
      when 3 # �퓬��
#        self.y = 348
      when 4 # �퓬�����E�B���h�E�\����
        self.y = 192
      when 5 # ���j���[��
        self.y = 300
      end
      # �������T�C�Y
      n = [@lines_max, $game_temp.choice_start - 1].min
      if DEFAULT_STRETCH_ENABLE and n >= 5
        # �g�����鍷�����v�Z
        d = @lines_max * line_height + 32 - self.height
        if d > 0
          self.height += d
          case position
          when 1  # ��
            self.y -= d/2
          when 2  # ��
            self.y -= d
          end
        end
      end
      # �w�i�̈ʒu
      @bgframe_sprite.y = self.y
      #
      @select_window.reset
    end
    if $game_system.messageback_name != ""
      self.opacity = 0
    elsif $game_system.message_frame == 0
      self.back_opacity = DEFAULT_BACK_OPACITY
      @bgframe_sprite.visible = true
      #@name_frame.opacity = DEFAULT_BACK_OPACITY unless @name_frame.nil?
    else
      self.opacity = 0
      @bgframe_sprite.visible = false
      #@name_frame.opacity = 0 unless @name_frame.nil?
    end
    # �r�b�g�}�b�v
    self.contents.dispose
    self.contents = Bitmap.new(self.width - 32, self.height - 32)
    # �|�[�Y�T�C���ʒu
    @pause.x = self.x + self.width / 2
    @pause.y = self.y + self.height - 36
  end
  #--------------------------------------------------------------------------
  # �� �E�B���h�E�̈ʒu�ƕs�����x�̐ݒ� (�L�����|�b�v)
  #--------------------------------------------------------------------------
  def update_reset_window
    #
    # �u�L�����|�b�v�v
    #
    if self.pop_character == 0 or $game_map.events[self.pop_character] != nil
      character = get_character(self.pop_character)
      # [X���W]
      n = self.width / 2
      n = [n, @name_skin.width + 16].max if @current_name != nil
      x = character.screen_x - n
      # [Y���W]
      case $game_system.message_position
      when 0
        y  = character.screen_y - CHARPOP_HEIGHT - self.height
      else
        y = character.screen_y + 16
      end
      # [�͈͂ɂ��␳]
      if $game_system.limit_right != nil
        x_max = character.screen_x + 32 * ($game_system.limit_right - character.x) - 16
      else
        x_max = 640
      end
      x_max = x_max - 4 - self.width 
      y_max = 476 - self.height
      x_min = 4
      y_min = 4 + (@name_skin.height - NAME_WINDOW_OFFSET_Y)
      self.x = [[x, x_max].min, x_min].max
      self.y = [[y, y_max].min, y_min].max
      # [�l�[���t���[���A��]
      if  @name_frame != nil
        @name_frame.x = self.x + NAME_WINDOW_OFFSET_X
        @name_frame.y = self.y + NAME_WINDOW_OFFSET_Y - @name_frame.bitmap.height
      end
    end
    # �|�[�Y�T�C���ʒu
    @pause.x = self.x + self.width  - 16
    @pause.y = self.y + self.height - 16
  end
  #--------------------------------------------------------------------------
  # �� �J�[�\���̋�`�X�V [�I�[�o�[���C�h]
  #--------------------------------------------------------------------------
  def update_cursor_rect
    if @index >= 0
      n = $game_temp.choice_start + @index
      self.cursor_rect.set(0 + @indent, n * line_height - 8, @cursor_width, line_height)
    else
      self.cursor_rect.empty
    end
  end
  #--------------------------------------------------------------------------
  # �� �L�����N�^�[�̎擾
  #     parameter : �p�����[�^
  #--------------------------------------------------------------------------
  def get_character(parameter)
    # �p�����[�^�ŕ���
    case parameter
    when 0  # �v���C���[
      return $game_player
    else  # ����̃C�x���g
      events = $game_map.events
      return events == nil ? nil : events[parameter]
    end
  end
  #--------------------------------------------------------------------------
  # ���݁A�^�C�s���O�X�L�b�v���\���H
  #--------------------------------------------------------------------------
  def skippable_now?
    return false if $game_switches[TELOP_SWITCH_ID]
    return ((SKIP_BAN_SWITCH_ID == 0 ? true : !$game_switches[SKIP_BAN_SWITCH_ID]) and 
       (HISKIP_ENABLE_SWITCH_ID == 0 ? true : $game_switches[HISKIP_ENABLE_SWITCH_ID]))
  end
  #--------------------------------------------------------------------------
  # ���݁A�����A�����b�Z�[�W�X�L�b�v���g�p�\���H
  #--------------------------------------------------------------------------
  def hispeed_skippable_now?
    return false if $game_switches[TELOP_SWITCH_ID]
    return (HISKIP_ENABLE_SWITCH_ID == 0 ? true : $game_switches[HISKIP_ENABLE_SWITCH_ID])
  end
  #--------------------------------------------------------------------------
  # �� �����
  #--------------------------------------------------------------------------
  def visible=(b)
    @name_frame.visible = b unless @name_frame.nil?
    @input_number_window.visible  = b unless @input_number_window.nil?
    super
  end
  #--------------------------------------------------------------------------
  # ���\�b�h �e���v���[�g
  #--------------------------------------------------------------------------
  def process_ruby
  end
  def draw_gaiji(x, y, num)
  end
  def convart_value(option, index)
  end
  #--------------------------------------------------------------------------
  # �C���f�b�N�X�̓���
  #--------------------------------------------------------------------------
  def index=(n)
    @select_window.index = n
    super
  end
  #--------------------------------------------------------------------------
  # �C���f�b�N�X�̓���
  #--------------------------------------------------------------------------
  def pause_terminate
    @pause.visible = false
  end
end
#==============================================================================
# �� Window_Copy
#------------------------------------------------------------------------------
#   �w��̃E�B���h�E�̃R�s�[���쐬���܂��B
#==============================================================================
class Window_Copy < Window_Base
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize(window)
    super(window.x, window.y, window.width, window.height)
    self.contents = window.contents.dup unless window.contents.nil?
    self.opacity = window.opacity
    self.back_opacity = window.back_opacity
    self.z = window.z - 3
  end
end
#==============================================================================
# �� Sprite_Copy
#------------------------------------------------------------------------------
#   �w��̃X�v���C�g�̃R�s�[���쐬���܂��B
#==============================================================================
class Sprite_Copy < Sprite
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize(sprite)
    super()
    self.bitmap = sprite.bitmap.dup unless sprite.bitmap.nil?
    self.opacity = sprite.opacity
    self.x = sprite.x
    self.y = sprite.y
    self.z = sprite.z - 3
    self.ox = sprite.ox
    self.oy = sprite.oy
  end
end
#==============================================================================
# �� Interpreter
#==============================================================================
class Interpreter
  #--------------------------------------------------------------------------
  # �� ���͂̕\��
  #--------------------------------------------------------------------------
  def command_101
    # �ق��̕��͂� message_text �ɐݒ�ς݂̏ꍇ
    if $game_temp.message_text != nil
      # �I��
      return false
    end
    # ���b�Z�[�W�I���ҋ@���t���O����уR�[���o�b�N��ݒ�
    @message_waiting = true
    $game_temp.message_proc = Proc.new { @message_waiting = false }
    # message_text �� 1 �s�ڂ�ݒ�
    $game_temp.message_text = @list[@index].parameters[0] + "\n"
    line_count = 1
    # ���[�v
    loop do
      # ���̃C�x���g�R�}���h������ 2 �s�ڈȍ~�̏ꍇ
      if @list[@index+1].code == 401
        # message_text �� 2 �s�ڈȍ~��ǉ�
        $game_temp.message_text += @list[@index+1].parameters[0] + "\n"
        line_count += 1
      # �C�x���g�R�}���h������ 2 �s�ڈȍ~�ł͂Ȃ��ꍇ
      else
        # ���̃C�x���g�R�}���h�����͂̕\���̏ꍇ
        if @list[@index+1].code == 101
          if (/\\next\Z/.match($game_temp.message_text)) != nil
            $game_temp.message_text.gsub!(/\\next/) { "" }
            $game_temp.message_text += @list[@index+1].parameters[0] + "\n"
            # �C���f�b�N�X��i�߂�
            @index += 1
            next
          end
        # ���̃C�x���g�R�}���h���I�����̕\���̏ꍇ
        elsif @list[@index+1].code == 102
          #x# �I��������ʂɎ��܂�ꍇ
          # if @list[@index+1].parameters[0].size <= 4 - line_count
          #end
          # �C���f�b�N�X��i�߂�
          @index += 1
          # �I�����̃Z�b�g�A�b�v
          $game_temp.choice_start = line_count
          setup_choices(@list[@index].parameters)
        # ���̃C�x���g�R�}���h�����l���͂̏����̏ꍇ
        elsif @list[@index+1].code == 103
          # ���l���̓E�B���h�E����ʂɎ��܂�ꍇ
          if line_count < 4
            # �C���f�b�N�X��i�߂�
            @index += 1
            # ���l���͂̃Z�b�g�A�b�v
            $game_temp.num_input_start = line_count
            $game_temp.num_input_variable_id = @list[@index].parameters[0]
            $game_temp.num_input_digits_max = @list[@index].parameters[1]
          end
        end
        # �p��
        return true
      end
      # �C���f�b�N�X��i�߂�
      @index += 1
    end
  end
end
#==============================================================================
# --- ���b�Z�[�W���ړ����� ---
#==============================================================================
class Game_Player < Game_Character
  attr_accessor :messaging_moving
end