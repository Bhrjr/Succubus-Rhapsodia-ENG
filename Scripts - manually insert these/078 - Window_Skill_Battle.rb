#==============================================================================
# �� Window_Skill_Battle
#------------------------------------------------------------------------------
# �@�o�g�����A�g�p�ł���X�L���̈ꗗ��\������E�B���h�E�ł��B
#==============================================================================

class Window_Skill_Battle < Window_Skill
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_reader     :data                     # ����
  attr_reader     :item_max
  attr_accessor   :window                   # ����
  attr_accessor   :actor
=begin
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #     actor : �A�N�^�[
  #--------------------------------------------------------------------------
  def initialize(actor, from_box = false)
    # �퓬���̏ꍇ�̓E�B���h�E����ʒ����ֈړ����A�������ɂ���
    super(40, 68, 560, 256)
    self.z = 2070
    if from_box == false
      @window = Sprite.new
      @window.y = 0
      @window.z = 2060
      @window.bitmap = RPG::Cache.windowskin("battle_index")
      @window.opacity = 255
    end
    self.opacity = 0
    @actor = actor
    @column_max = 2
    @from_box = from_box
    refresh
    self.index = 0    
  end
=end
  #--------------------------------------------------------------------------
  # �� �\����Ԃ̔w�i�摜�Ƃ̘A��
  #--------------------------------------------------------------------------
  def visible=(bool)
    super
    @window.visible = bool if @window != nil
  end
=begin
  #--------------------------------------------------------------------------
  # �� �X�L���̎擾
  #--------------------------------------------------------------------------
  def skill
    return @data[self.index]
  end
=end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    if self.contents != nil
      self.contents.dispose
      self.contents = nil
    end
    @data = []
    skill_box = @actor.battle_skills
    for i in 0...skill_box.size
      skill = $data_skills[skill_box[i]]
      if skill != nil
        if skill.occasion == 0 or skill.occasion == 1
          @data.push(skill)
        end
      end
    end
    # �X�L���\�[�g
    skills_sort
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
    skill = @data[index]
    if @actor.skill_can_use?(skill.id)
      self.contents.font.color = normal_color
    else
      self.contents.font.color = disabled_color
    end    
    self.contents.font.color = normal_color if @from_box
    x = 4 + index % 2 * (248 + 32)
    y = index / 2 * 32
    rect = Rect.new(x, y, self.width / @column_max - 32, 32)
    self.contents.fill_rect(rect, Color.new(0, 0, 0, 0))
    bitmap = RPG::Cache.icon(skill.icon_name)
    opacity = self.contents.font.color == normal_color ? 255 : 128
    self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24), opacity)
    if $game_switches[85] == true and skill.name == "�g�[�N"
      self.contents.draw_text(x + 28, y, 204, 32, "�s���[�g�[�N", 0)
    else
      self.contents.draw_text(x + 28, y, 204, 32, skill.name, 0)
    end
    
    # �X�L���R�X�g

    sp_cost_result = SR_Util.sp_cost_result(@actor, skill)
    if sp_cost_result != 0
      self.contents.draw_text(x + 178, y, 48, 32, "VP", 0) 
      self.contents.draw_text(x + 184, y, 48, 32, "-" + sp_cost_result.to_s, 2) 
    end
  end
=begin
  #--------------------------------------------------------------------------
  # �� �w���v�e�L�X�g�X�V
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_text(self.skill == nil ? "" : self.skill.description)
  end
=end
end
