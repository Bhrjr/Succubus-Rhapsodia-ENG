#==============================================================================
# �� Window_Partychange
#------------------------------------------------------------------------------
# �@�p�[�e�B�����o�[��\������E�B���h�E�ł��B
#==============================================================================

class Window_Partychange < Window_Selectable
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    super(0, 68, 640, 320)
    self.contents = Bitmap.new(width - 32, height - 32)
    self.z = 2070
    self.opacity = 0
    @index = 0
    @item_max = $game_party.party_actors.size
    @column_max = 2
    @window = Sprite.new
    @window.y = 0
    @window.z = 2050
    @window.bitmap = RPG::Cache.windowskin("battle_index")
    @window.opacity = 255
    refresh
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def dispose
    super
    @window.dispose
  end
  #--------------------------------------------------------------------------
  # �� �w���v�e�L�X�g�X�V
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_text("Confirm party.")
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    
    self.contents.clear
    
    self.contents.font.size = $default_size
    
    

    actors = $game_party.party_actors
    actors.each_index { |i|
    x = 4 + i % 2 * (240 + 32)
    y = i / 2 * 110

      # ��퓬�����o�[�͔w�i���Â�����
#      if i >= actors.size
#        self.contents.fill_rect(0, y, width - 32, 78, Color.new(0, 0, 0, 96))
#      end
      draw_actor_info(actors[i], x, y)
    }
  end
  #--------------------------------------------------------------------------
  # �� �A�N�^�[���`��
  #--------------------------------------------------------------------------
  def draw_actor_info(actor, x, y)
    
    self.contents.font.size = $default_size_mini

    draw_actor_graphic(actor, x + 72, y + 60)
    draw_actor_name(actor, x + 120, y)
    draw_actor_class(actor, x + 130, y + 20)

    self.contents.draw_text(x + 28, y + 64, 88, 24, "Lv." + actor.level.to_s, 1)
    draw_actor_state(actor, x + 28, y + 80, 88, 1, 1)

    self.contents.draw_text(x + 120, y + 40, 88, 24, "EP")
    draw_actor_hp(actor, x + 120, y + 38)
    self.contents.draw_text(x + 120, y + 62, 88, 24, "VP")
    draw_actor_sp(actor, x + 120, y + 60)
    draw_actor_fed(actor, x + 120, y + 88) if actor != $game_actors[101]
  end
  #--------------------------------------------------------------------------
  # �� �J�[�\����`�X�V
  #--------------------------------------------------------------------------
  def update_cursor_rect
    # �J�[�\���ʒu -1 �͑S�I��
    if @index <= -2
      # �J�[�\���̕����v�Z
      cursor_width = self.contents.width / 2 - 32
      # �J�[�\���̍��W���v�Z
      x = (@index + 10) % @column_max * cursor_width + 32
      y = (@index + 10) / @column_max * 110
      # �J�[�\���̋�`���X�V
      self.cursor_rect.set(x, y, cursor_width, 110)
  	  return
    elsif @index == -1
      self.cursor_rect.set(32, 0, self.width - 96, 240)
  	  return
    end
    # ���݂̍s���擾
    row = @index
    # ���݂̍s���A�\������Ă���擪�̍s���O�̏ꍇ
    if row < self.top_row
      # ���݂̍s���擪�ɂȂ�悤�ɃX�N���[��
      self.top_row = row
    end
    # ���݂̍s���A�\������Ă���Ō���̍s�����̏ꍇ
    if row > self.top_row + (self.page_row_max - 1)
      # ���݂̍s���Ō���ɂȂ�悤�ɃX�N���[��
      self.top_row = row - (self.page_row_max - 1)
    end
    # �J�[�\���̕����v�Z
    cursor_width = self.contents.width / 2 - 32
    # �J�[�\���̍��W���v�Z
    x = @index % @column_max * cursor_width + 32
    y = @index / @column_max * 110
    # �J�[�\���̋�`���X�V
    self.cursor_rect.set(x, y, cursor_width, 110)
  end
  #--------------------------------------------------------------------------
  # �� �擪�̍s�̎擾
  #--------------------------------------------------------------------------
  def top_row
    # �E�B���h�E���e�̓]���� Y ���W���A1 �s�̍��� 116 �Ŋ���
    return self.oy / 116
  end
  #--------------------------------------------------------------------------
  # �� �擪�̍s�̐ݒ�
  #     row : �擪�ɕ\������s
  #--------------------------------------------------------------------------
  def top_row=(row)
    # row �� 0 �` row_max - 1 �ɏC��
    row = [[row, 0].max, row_max - 1].min
    # row �� 1 �s�̍��� 116 ���|���A�E�B���h�E���e�̓]���� Y ���W�Ƃ���
    self.oy = row * 116
  end
  #--------------------------------------------------------------------------
  # �� 1 �y�[�W�ɕ\���ł���s���̎擾
  #--------------------------------------------------------------------------
  def page_row_max
    return 4
  end
  #--------------------------------------------------------------------------
  # �� �s���̎擾
  #--------------------------------------------------------------------------
  def row_max
    return $game_party.party_actors.size
  end
  #--------------------------------------------------------------------------
  # �� HP�̕`��
  #--------------------------------------------------------------------------
  def draw_actor_hp(actor, x, y, width = 144)
    
    
        # �ϐ�rate�� ���݂�HP/MHP����
    if actor.maxhp != 0
      rate = actor.hp.to_f / actor.maxhp
    else
      rate = 0
    end
    # plus_x:X���W�̈ʒu�␳ rate_x:X���W�̈ʒu�␳(%) plus_y:Y���W�̈ʒu�␳
    # plus_width:���̕␳ rate_width:���̕␳(%) height:�c��
    # align1:�`��^�C�v1 0:���l�� 1:�������� 2:�E�l��
    # align2:�`��^�C�v2 0:��l�� 1:�������� 2:���l��
    # align3:�Q�[�W�^�C�v 0:���l�� 1:�E�l��
    plus_x = 0
    rate_x = 0
    plus_y = 25
    plus_width = 0
    rate_width = 100
    height = 7
    align1 = 1
    align2 = 2
    align3 = 0
    # �O���f�[�V�����ݒ� grade1:��Q�[�W grade2:���Q�[�W
    # (0:���ɃO���f�[�V���� 1:�c�ɃO���f�[�V���� 2:�΂߂ɃO���f�[�V����(���d)�j
    grade1 = 1
    grade2 = 0
    # �F�ݒ�Bcolor1:�O�g�Ccolor2:���g
    # color3:��Q�[�W�_�[�N�J���[�Ccolor4:��Q�[�W���C�g�J���[
    # color5:���Q�[�W�_�[�N�J���[�Ccolor6:���Q�[�W���C�g�J���[
    color1 = Color.new(0, 0, 0, 192)
    color2 = Color.new(255, 255, 192, 192)
    color3 = Color.new(0, 0, 0, 192)
    color4 = Color.new(64, 0, 0, 192)
    color5 = Color.new(80 - 24 * rate, 80 * rate, 14 * rate, 192)
    color6 = Color.new(240 - 72 * rate, 240 * rate, 62 * rate, 192)
    # �ϐ�sp�ɕ`�悷��Q�[�W�̕�����
    if actor.maxhp != 0
      hp = (width + plus_width) * actor.hp * rate_width / 100 / actor.maxhp
    else
      hp = 0
    end
    # �Q�[�W�̕`��
    gauge_rect(x + plus_x + width * rate_x / 100, y + plus_y,
                width, plus_width + width * rate_width / 100,
                height, hp, align1, align2, align3,
                color1, color2, color3, color4, color5, color6, grade1, grade2)
    # �I���W�i����HP�`�揈�����Ăяo��
    # MaxHP ��`�悷��X�y�[�X�����邩�v�Z
    if width - 32 >= 108
      hp_x = x + width - 108
      flag = true
    elsif width - 32 >= 48
      hp_x = x + width - 48
      flag = false
    end
    hp_x = x + 70
    self.contents.font.color = actor.hp == 0 ? knockout_color :
    actor.hp <= actor.maxhp / 4 ? crisis_color : normal_color
    self.contents.draw_text(hp_x, y - 2, 32, 32, actor.hp.to_s, 2)
    self.contents.font.color = normal_color
    self.contents.draw_text(hp_x + 24, y - 2, 32, 32, " / ", 1)
    self.contents.draw_text(hp_x + 48, y - 2, 32, 32, actor.maxhp.to_s, 0)
  end
  #--------------------------------------------------------------------------
  # �� SP �̕`��
  #     actor : �A�N�^�[
  #     x     : �`��� X ���W
  #     y     : �`��� Y ���W
  #     width : �`���̕�
  #--------------------------------------------------------------------------
  def draw_actor_sp(actor, x, y, width = 144)
        # �ϐ�rate�� ���݂�SP/MSP����
    if actor.maxsp != 0
      rate = actor.sp.to_f / actor.maxsp
    else
      rate = 1
    end
    # plus_x:X���W�̈ʒu�␳ rate_x:X���W�̈ʒu�␳(%) plus_y:Y���W�̈ʒu�␳
    # plus_width:���̕␳ rate_width:���̕␳(%) height:�c��
    # align1:�`��^�C�v1 0:���l�� 1:�������� 2:�E�l��
    # align2:�`��^�C�v2 0:��l�� 1:�������� 2:���l��
    # align3:�Q�[�W�^�C�v 0:���l�� 1:�E�l��
    plus_x = 0
    rate_x = 0
    plus_y = 25
    plus_width = 0
    rate_width = 100
    height = 7
    align1 = 1
    align2 = 2
    align3 = 0
    # �O���f�[�V�����ݒ� grade1:��Q�[�W grade2:���Q�[�W
    # (0:���ɃO���f�[�V���� 1:�c�ɃO���f�[�V���� 2:�΂߂ɃO���f�[�V����(���d)�j
    grade1 = 1
    grade2 = 0
    # �F�ݒ�Bcolor1:�O�g�Ccolor2:���g
    # color3:��Q�[�W�_�[�N�J���[�Ccolor4:��Q�[�W���C�g�J���[
    # color5:���Q�[�W�_�[�N�J���[�Ccolor6:���Q�[�W���C�g�J���[
    color1 = Color.new(0, 0, 0, 192)
    color2 = Color.new(255, 255, 192, 192)
    color3 = Color.new(0, 0, 0, 192)
    color4 = Color.new(0, 64, 0, 192)
    color5 = Color.new(14 * rate, 80 - 24 * rate, 80 * rate, 192)
    color6 = Color.new(62 * rate, 240 - 72 * rate, 240 * rate, 192)
    # �ϐ�sp�ɕ`�悷��Q�[�W�̕�����
    if actor.maxsp != 0
      sp = (width + plus_width) * actor.sp * rate_width / 100 / actor.maxsp
    else
      sp = (width + plus_width) * rate_width / 100
    end
    # �Q�[�W�̕`��
    gauge_rect(x + plus_x + width * rate_x / 100, y + plus_y,
                width, plus_width + width * rate_width / 100,
                height, sp, align1, align2, align3,
                color1, color2, color3, color4, color5, color6, grade1, grade2)
    # �I���W�i����SP�`�揈�����Ăяo��

    # MaxSP ��`�悷��X�y�[�X�����邩�v�Z
    if width - 32 >= 108
      sp_x = x + width - 108
      flag = true
    elsif width - 32 >= 48
      sp_x = x + width - 48
      flag = false
    end
    sp_x = x + 70
    self.contents.font.color = actor.sp == 0 ? knockout_color :
    actor.sp <= actor.maxsp / 4 ? crisis_color : normal_color
    self.contents.draw_text(sp_x, y - 2, 32, 32, actor.sp.to_s, 2)
    self.contents.font.color = normal_color
    self.contents.draw_text(sp_x + 24, y - 2, 32, 32, " / ", 1)
    self.contents.draw_text(sp_x + 48, y - 2, 32, 32, actor.maxsp.to_s, 0)
  end


end
