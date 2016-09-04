#==============================================================================
# �� Window_Skill
#------------------------------------------------------------------------------
# �@�X�L����ʁA�o�g����ʂŁA�g�p�ł���X�L���̈ꗗ��\������E�B���h�E�ł��B
#==============================================================================

class Window_Skill < Window_Selectable
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
  def initialize(actor, from_box = false)
    # �퓬���̏ꍇ�̓E�B���h�E����ʒ����ֈړ����A�������ɂ���
    unless $game_temp.in_battle
      super(40, 76, 560, 258)
      self.z = 2050
    else
      super(40, 68, 560, 256)
      self.z = 2060
      if from_box == false
        @window = Sprite.new
        @window.y = 0
        @window.z = 2050
        @window.bitmap = RPG::Cache.windowskin("battle_index")
        @window.opacity = 255
      end
    end
    self.opacity = 0
    @actor = actor
    @column_max = 2
    @from_box = from_box
    refresh
    self.index = 0    
  end
  #--------------------------------------------------------------------------
  # �� �X�L���̎擾
  #--------------------------------------------------------------------------
  def skill
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
    skill_box = @actor.all_skills

    for i in 0...skill_box.size
      skill = $data_skills[skill_box[i]]
      if skill != nil
        @data.push(skill)
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
      self.contents.font.color = text_color(9) if not @actor.skill_learn?(skill.id, "ORIGINAL")
    else
      self.contents.font.color = disabled_color
      self.contents.font.color = normal_color if @from_box
      self.contents.font.color = text_color(11) if not @actor.skill_learn?(skill.id, "ORIGINAL")
    end    
    x = 4 + index % 2 * (248 + 32)
    y = index / 2 * 32
    rect = Rect.new(x, y, self.width / @column_max - 32, 32)
    self.contents.fill_rect(rect, Color.new(0, 0, 0, 0))
    bitmap = RPG::Cache.icon(skill.icon_name)
    if self.contents.font.color == normal_color or self.contents.font.color == text_color(9)
      opacity = 255
    else 
      opacity = 128
    end
    self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24), opacity)
    self.contents.draw_text(x + 28, y, 204, 32, skill.name, 0)
    if skill.sp_cost != 0
      self.contents.draw_text(x + 178, y, 48, 32, "VP", 0) 
      self.contents.draw_text(x + 184, y, 48, 32, "-" + skill.sp_cost.to_s, 2) 
    end
  end
  #--------------------------------------------------------------------------
  # �� �w���v�e�L�X�g�X�V
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_text(self.skill == nil ? "" : self.skill.description)
  end
  #--------------------------------------------------------------------------
  # �� �X�L���\�[�g
  #--------------------------------------------------------------------------
  def skills_sort
    
    @sort_box = []
    #--------------------------------------------------------------------------
    # �����̏��Ԃɔz�u����
    #--------------------------------------------------------------------------
    # ���E�ߌn
    #--------------------------------------------------------------------------
    # ����E�����E����E��
    for i in [2,4]
      skills_sort_push(i)
    end
    #--------------------------------------------------------------------------
    # �������A�^�b�N�X�L��
    #--------------------------------------------------------------------------
    # �L�b�X�E�o�X�g�E�q�b�v�E�N���b�`�E�J���X
    for i in 81..85
      skills_sort_push(i)
    end
    #--------------------------------------------------------------------------
    # ���z�[���h����p�X�L��
    #--------------------------------------------------------------------------
    # �����[�X�E�C���^���v�g�E�X�g���O���܂߂��z�[���h��p�X�L��
    for i in 28..79
      skills_sort_push(i)
    end
    for i in [641,642]
      skills_sort_push(i)
    end
    #--------------------------------------------------------------------------
    # �������T�|�[�g�X�L��+�X�C�[�g�E�B�X�p�[
    #--------------------------------------------------------------------------
    # �u���X�E�E�F�C�g�E�g�[�N�E�X�C�[�g�E�B�X�p�[
    for i in [121,123,9,418]
      skills_sort_push(i)
    end
    #--------------------------------------------------------------------------
    # ���z�[���h�X�L��
    #--------------------------------------------------------------------------
    # �z�[���h�X�L��
    for i in 5..18
      skills_sort_push(i)
    end
    #--------------------------------------------------------------------------
    # ���D��A�^�b�N�X�L��
    #--------------------------------------------------------------------------
    # �f�B�o�E�A�[�E�v���C�X�I�u�n�����E�v���C�X�I�u�V�i�[
    for i in [106,362,363]
      skills_sort_push(i)
    end
    #--------------------------------------------------------------------------
    # ���c�������̂�����
    #--------------------------------------------------------------------------
    for data_one in @data
      @sort_box.push(data_one) 
    end
    #--------------------------------------------------------------------------
    # nil�����ׂď���
    @sort_box.compact!
    # ���ёւ��������̂�@data�Ɉڂ�
    @data = @sort_box
    
    
  end
  #--------------------------------------------------------------------------
  # �� �X�L���\�[�g�A����Ă������\�b�h
  #--------------------------------------------------------------------------
  def skills_sort_push(skill_id)
    if @data.include?($data_skills[skill_id])
      @sort_box.push(@data.delete($data_skills[skill_id])) 
    end
  end
end
