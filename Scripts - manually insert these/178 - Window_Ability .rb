#==============================================================================
# �� Window_Ability
#------------------------------------------------------------------------------
# �@�X�L����ʁA�o�g����ʂŁA�g�p�ł���X�L���̈ꗗ��\������E�B���h�E�ł��B
#==============================================================================

class Window_Ability < Window_Selectable
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_reader     :data                     # ����
  attr_reader     :item_max
  attr_accessor   :window                   # ����
  attr_accessor   :actor
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #     actor : �A�N�^�[
  #--------------------------------------------------------------------------
  def initialize(actor, type = 0)
    # �퓬���̏ꍇ�̓E�B���h�E����ʒ����ֈړ����A�������ɂ���
    super(90, 76, 460, 258)
    self.z = 2050
    self.opacity = 0
    self.active = false
    @column_max = 2
    @actor = actor
    refresh
    self.index = 0
  end
  #--------------------------------------------------------------------------
  # �� �X�L���̎擾
  #--------------------------------------------------------------------------
  def ability_data
    return @data[self.index]
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    if self.contents != nil
      self.contents.dispose
      self.contents = nil
    end
    @data = []
    for i in 0...@actor.all_ability.size
      ability = $data_ability[@actor.all_ability[i]]
      if ability != nil
        unless ability.hidden # ����J�f���͏��O
          @data.push(ability)
        end
      end
    end
    # ���ڐ��� 0 �łȂ���΃r�b�g�}�b�v���쐬���A�S���ڂ�`��
    @item_max = @data.size
    if @item_max > 0
      self.contents = Bitmap.new(width - 32, row_max * 32)
      for i in 0...@item_max
        draw_item(i)
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� ���ڂ̕`��
  #     index : ���ڔԍ�
  #--------------------------------------------------------------------------
  def draw_item(index)
    ability = @data[index]
    self.contents.font.color = normal_color
    self.contents.font.color = text_color(9) if not @actor.have_ability?(ability.id, "ORIGINAL")
    # �퓬���̏ꍇ�̓E�B���h�E����ʒ����ֈړ����A�������ɂ���
    x = 4 + index % 2 * (198 + 32)
    y = index / 2 * 32
    rect = Rect.new(x, y, self.width / @column_max - 32, 32)
    self.contents.fill_rect(rect, Color.new(0, 0, 0, 0))
    bitmap = RPG::Cache.icon(ability.icon_name)
    opacity = 255
    self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24), opacity)
    self.contents.draw_text(x + 28, y, 204, 32, "�y" + ability.UK_name + "�z" , 0)
  end
  #--------------------------------------------------------------------------
  # �� �w���v�e�L�X�g�X�V
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_text(self.ability_data == nil ? "" : self.ability_data.description)
  end
end
