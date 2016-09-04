#==============================================================================
# �� Window_Base
#------------------------------------------------------------------------------
# �@�Q�[�����̂��ׂẴE�B���h�E�̃X�[�p�[�N���X�ł��B
#==============================================================================

class Window_Base < Window
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #     x      : �E�B���h�E�� X ���W
  #     y      : �E�B���h�E�� Y ���W
  #     width  : �E�B���h�E�̕�
  #     height : �E�B���h�E�̍���
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height)
    super()
    @windowskin_name = $game_system.windowskin_name
    self.windowskin = RPG::Cache.windowskin(@windowskin_name)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.z = 100
  end
  #--------------------------------------------------------------------------
  # �� ���
  #--------------------------------------------------------------------------
  def dispose
    # �E�B���h�E���e�̃r�b�g�}�b�v���ݒ肳��Ă���Ή��
    if self.contents != nil
      self.contents.dispose
    end
    super
  end
  #--------------------------------------------------------------------------
  # �� �����F�擾
  #     n : �����F�ԍ� (0�`7)
  #--------------------------------------------------------------------------
  def text_color(n)
    case n
    when 0 #��
      return Color.new(255, 255, 255, 255)
    when 1
      return Color.new(128, 128, 255, 255)
    when 2
      return Color.new(255, 128, 128, 255)
    when 3
      return Color.new(128, 255, 128, 255)
    when 4
      return Color.new(128, 255, 255, 255)
    when 5
      return Color.new(255, 128, 255, 255)
    when 6
      return Color.new(255, 255, 128, 255)
    when 7
      return Color.new(192, 192, 192, 255)
    when 8 #���i���z�J���[�j
      return Color.new(230, 220, 60, 255)
    when 9 #���΁i�A�C�e���J���[�j
      return Color.new(160, 255, 230, 255)
    when 10 #���F�i�����i�J���[�j
      return Color.new(140, 255, 100, 255)
    when 11 #���΁i�A�C�e���J���[���j
      return Color.new(160, 255, 230, 128)      
    when 12 #���F�i�q���g���́j
      return Color.new(255,239,133, 255)     
    else
      normal_color
    end
  end
  #--------------------------------------------------------------------------
  # �� �ʏ핶���F�̎擾
  #--------------------------------------------------------------------------
  def normal_color
    return Color.new(255, 255, 255, 255)
  end
  #--------------------------------------------------------------------------
  # �� ���������F�̎擾
  #--------------------------------------------------------------------------
  def disabled_color
    return Color.new(255, 255, 255, 128)
  end
  #--------------------------------------------------------------------------
  # �� �V�X�e�������F�̎擾
  #--------------------------------------------------------------------------
  def system_color
    return Color.new(192, 224, 255, 255)
  end
  #--------------------------------------------------------------------------
  # �� �s���`�����F�̎擾
  #--------------------------------------------------------------------------
  def crisis_color
    return Color.new(255, 255, 64, 255)
  end
  #--------------------------------------------------------------------------
  # �� �퓬�s�\�����F�̎擾
  #--------------------------------------------------------------------------
  def knockout_color
    return Color.new(255, 64, 0)
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    super
    # �E�B���h�E�X�L�����ύX���ꂽ�ꍇ�A�Đݒ�
    if $game_system.windowskin_name != @windowskin_name
      @windowskin_name = $game_system.windowskin_name
      self.windowskin = RPG::Cache.windowskin(@windowskin_name)
    end
  end
  #--------------------------------------------------------------------------
  # �� �O���t�B�b�N�̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #--------------------------------------------------------------------------
  def draw_actor_graphic(actor, x, y)
    bitmap = RPG::Cache.character(actor.character_name, actor.character_hue)
    cw = bitmap.width / 4
    ch = bitmap.height / 4
    src_rect = Rect.new(0, 0, cw, ch)
    self.contents.blt(x - cw / 2, y - ch, bitmap, src_rect)
  end
  #--------------------------------------------------------------------------
  # �� ���O�̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #--------------------------------------------------------------------------
  def draw_actor_name(actor, x, y)
    self.contents.font.color = normal_color
    self.contents.draw_text(x, y, 140, 32, actor.name)
  end
  #--------------------------------------------------------------------------
  # �� �N���X�̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #--------------------------------------------------------------------------
  def draw_actor_class(actor, x, y)
    self.contents.font.color = normal_color
    self.contents.draw_text(x, y, 236, 32, actor.class_name)
  end
  #--------------------------------------------------------------------------
  # �� ���x���̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #--------------------------------------------------------------------------
  def draw_actor_level(actor, x, y)
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 32, 32, "Lv")
    self.contents.font.color = normal_color
    self.contents.draw_text(x + 32, y, 24, 32, actor.level.to_s, 2)
  end
  #--------------------------------------------------------------------------
  # �� �`��p�̃X�e�[�g������쐬
  #     actor       : �A�N�^�[
  #     width       : �`���̕�
  #     need_normal : [����] ���K�v���ǂ��� (true / false)
  #--------------------------------------------------------------------------
  def make_battler_state_text(battler, width, need_normal, type)
    # ���ʂ̕����擾
    brackets_width = self.contents.text_size("[]").width
    # �X�e�[�g���̕�������쐬
    text = ""
    for i in battler.states
      if $data_states[i].rating >= 1
        if text == ""
          text = $data_states[i].name
        else
          new_text = text + "/" + $data_states[i].name
          text_width = self.contents.text_size(new_text).width
          if text_width > width - brackets_width
            break
          end
          text = new_text
        end
      end
    end
    # �X�e�[�g���̕����񂪋�̏ꍇ�� "[����]" �ɂ���
    if text == ""
      if need_normal
        if $game_temp.in_battle and type == 0
          text = "LV." + battler.level.to_s
        else
          text = "[����]"
        end
      end
    else
      # ���ʂ�����
      text = "[" + text + "]"
    end
    # ���������������Ԃ�
    return text
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #     width : �`���̕�
  #--------------------------------------------------------------------------
  def draw_actor_state(actor, x, y, width = 120, align = 0, type = 0)
    text = make_battler_state_text(actor, width, true, type)
    self.contents.font.color = actor.dead? ? knockout_color : normal_color
    self.contents.font.color = crisis_color if actor.state?(15)
    self.contents.draw_text(x, y, width, 32, text, align)
  end
  #--------------------------------------------------------------------------
  # �� EXP �̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #--------------------------------------------------------------------------
  def draw_actor_exp(actor, x, y)
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 24, 32, "E")
    self.contents.font.color = normal_color
    self.contents.draw_text(x + 24, y, 84, 32, actor.exp_s, 2)
    self.contents.draw_text(x + 108, y, 12, 32, "/", 1)
    self.contents.draw_text(x + 120, y, 84, 32, actor.next_exp_s)
  end
  #--------------------------------------------------------------------------
  # �� HP �̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #     width : �`���̕�
  #--------------------------------------------------------------------------
  def draw_actor_hp(actor, x, y, width = 144, type = 0)
    # MaxHP ��`�悷��X�y�[�X�����邩�v�Z
    if width - 32 >= 108
      hp_x = x + width - 108
      flag = true
    elsif width - 32 >= 48
      hp_x = x + width - 48
      flag = false
    end
    # ���퓬���̏ꍇ�z�u��ύX
    if $game_temp.in_battle and type == 0
      battle_y = 93
      if actor == $game_party.actors[0]
        unless actor.weaken?
          self.contents.font.color = actor.hp == 0 ? knockout_color :
           actor.hp <= actor.maxhp / 4 ? crisis_color : normal_color
          hp_x = 200
          self.contents.draw_text(hp_x, battle_y, 32, 32, actor.hp.to_s, 2)
          self.contents.font.color = normal_color
          self.contents.draw_text(hp_x + 24, battle_y, 32, 32, " / ", 1)
          self.contents.draw_text(hp_x + 48, battle_y, 32, 32, actor.maxhp.to_s, 0)
        end
      else
        unless actor.weaken?
          self.contents.font.color = actor.hp == 0 ? knockout_color :
           actor.hp <= actor.maxhp / 4 ? crisis_color : normal_color
           hp_x = 326
          self.contents.draw_text(hp_x, battle_y, 32, 32, actor.hp.to_s, 2)
          self.contents.font.color = normal_color
          self.contents.draw_text(hp_x + 24, battle_y, 32, 32, " / ", 1)
          self.contents.draw_text(hp_x + 48, battle_y, 32, 32, actor.maxhp.to_s, 0)
        end
      end
    # ���퓬���͔z�u���ς��
    else
      hp_x = x + 70
      self.contents.font.color = actor.hp == 0 ? knockout_color :
      actor.hp <= actor.maxhp / 4 ? crisis_color : normal_color
      self.contents.draw_text(hp_x, y - 2, 32, 32, actor.hp.to_s, 2)
      self.contents.font.color = normal_color
      self.contents.draw_text(hp_x + 24, y - 2, 32, 32, " / ", 1)
      self.contents.draw_text(hp_x + 48, y - 2, 32, 32, actor.maxhp.to_s, 0)
    end
  end
  #--------------------------------------------------------------------------
  # �� SP �̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #     width : �`���̕�
  #--------------------------------------------------------------------------
  def draw_actor_sp(actor, x, y, width = 144, type = 0)
    # MaxSP ��`�悷��X�y�[�X�����邩�v�Z
    if width - 32 >= 108
      sp_x = x + width - 108
      flag = true
    elsif width - 32 >= 48
      sp_x = x + width - 48
      flag = false
    end
    # ���퓬���͔z�u���ς��
    if $game_temp.in_battle and type == 0 
      battle_y = 111
      if actor == $game_party.actors[0]
        self.contents.font.color = actor.sp == 0 ? knockout_color :
         actor.sp <= actor.maxsp / 4 ? crisis_color : normal_color
        sp_x = 200
        self.contents.draw_text(sp_x, battle_y, 32, 32, actor.sp.to_s, 2)
        self.contents.font.color = normal_color
        self.contents.draw_text(sp_x + 24, battle_y, 32, 32, " / ", 1)
        self.contents.draw_text(sp_x + 48, battle_y, 32, 32, actor.maxsp.to_s, 0)
      else
        self.contents.font.color = actor.sp == 0 ? knockout_color :
         actor.sp <= actor.maxsp / 4 ? crisis_color : normal_color
        sp_x = 326
        self.contents.draw_text(sp_x, battle_y, 32, 32, actor.sp.to_s, 2)
        self.contents.font.color = normal_color
        self.contents.draw_text(sp_x + 24, battle_y, 32, 32, " / ", 1)
        self.contents.draw_text(sp_x + 48, battle_y, 32, 32, actor.maxsp.to_s, 0)
      end
    # ���퓬���łȂ��ꍇ
    else
      sp_x = x + 70
      self.contents.font.color = actor.sp == 0 ? knockout_color :
      actor.sp <= actor.maxsp / 4 ? crisis_color : normal_color
      self.contents.draw_text(sp_x, y - 2, 32, 32, actor.sp.to_s, 2)
      self.contents.font.color = normal_color
      self.contents.draw_text(sp_x + 24, y - 2, 32, 32, " / ", 1)
      self.contents.draw_text(sp_x + 48, y - 2, 32, 32, actor.maxsp.to_s, 0)
    end   
  end
  
  #--------------------------------------------------------------------------
  # �� �����x �̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #     width : �`���̕�
  #--------------------------------------------------------------------------
  def draw_actor_fed(actor, x, y, width = 144)
    self.contents.draw_text(x, y, width, 24, "�����x")
    self.contents.font.color = actor.fed <= 10 ? knockout_color :
     actor.fed <= 20 ? crisis_color : normal_color
    self.contents.draw_text(x - 44, y, width, 24, actor.fed.to_s, 2)
    self.contents.font.color = normal_color
    self.contents.draw_text(x, y, width, 24, "/" + 100.to_s, 2)  
  end
  #--------------------------------------------------------------------------
  # �� �p�����[�^�̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #     type  : �p�����[�^�̎�� (0�`6)
  #--------------------------------------------------------------------------
  def draw_actor_parameter(actor, x, y, type)
    case type
    when 0
      parameter_name = $data_system.words.atk
      parameter_value = actor.atk
    when 1
      parameter_name = $data_system.words.pdef
      parameter_value = actor.pdef
    when 2
      parameter_name = $data_system.words.mdef
      parameter_value = actor.mdef
    when 3
      parameter_name = $data_system.words.str
      parameter_value = actor.str
    when 4
      parameter_name = $data_system.words.dex
      parameter_value = actor.dex
    when 5
      parameter_name = $data_system.words.agi
      parameter_value = actor.agi
    when 6
      parameter_name = $data_system.words.int
      parameter_value = actor.int
    end
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 120, 32, parameter_name)
    self.contents.font.color = normal_color
    self.contents.draw_text(x + 50, y, 36, 32, parameter_value.to_s, 2)
  end
  #--------------------------------------------------------------------------
  # �� �A�C�e�����̕`��
  #     item : �A�C�e��
  #     x    : �`��� X ���W
  #     y    : �`��� Y ���W
  #--------------------------------------------------------------------------
  def draw_item_name(item, x, y)
    if item == nil
      return
    end
    bitmap = RPG::Cache.icon(item.icon_name)
    self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24))
    self.contents.font.color = normal_color
    self.contents.draw_text(x + 28, y, 212, 32, item.name)
  end
end
