
class HoldPop_Sprite < RPG::Sprite
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_accessor :type                  # �z�[���h���
  attr_accessor :battler               # ���g
  attr_accessor :target                # �Ώۃo�g���[
  attr_accessor :initiative            # �C�j�V�A�`�u
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize(type, battler, target)
    super()
    # �������C���X�^���X�ϐ���
    @type   = type
    @battler = battler
    @target = target
    @initiative = 0
    # ���̑�������
    @delete_flag = false
    @last_x = -100
    @last_y = -100
    self.opacity = 0
    refresh
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    # �t���[���쐬
    graphic = RPG::Cache.windowskin("hold_pop2")
    if @battler.is_a?(Game_Actor)
      graphic = RPG::Cache.windowskin("hold_pop1") if @battler == $game_actors[101]
    end
    if @target.is_a?(Game_Actor)
      graphic = RPG::Cache.windowskin("hold_pop1") if @target == $game_actors[101]
    end
    self.bitmap = Bitmap.new(graphic.width,graphic.height)
    self.bitmap.blt(0, 0, graphic, Rect.new(0, 0, graphic.width, graphic.height), 200)
    
    # �z�[���h���̕`��
    case @type
    when "���}��"
      hold_name = "Inserted"
    when "�L���킹"
      hold_name = "Scissoring"
    when "���}��"
      hold_name = "Fellatio"
    when "�N���j"
      hold_name = "Cunnilingus "
    when "��ʋR��"
      hold_name = "Facesitted"
    when "�K�R��"
      hold_name = "Dark-sided"
    when "�S��"
      hold_name = "Embraced"
    when "�J�r"
      hold_name = "Spread Eagle"
    when "�p�C�Y��"
      hold_name = "Paizuri Locked"
    when "���q���}��"
      hold_name = "Dildo'ed"
    when "���q���}��"
      hold_name = "Mouth Dildo'ed"
    when "���q�K�}��"
      hold_name = "Ass Dildo'ed"
    when "�ӍS��"
      hold_name = "Entangled "
    when "�G��S��"
      hold_name = "Tentacle-Bound"
    when "�G��z��"
      hold_name = "Tentacle-Sucking"
    when "�G��N���j"
      hold_name = "Tentacle-Inserted "
    else
      hold_name = @type
    end
    # �t�]�s�̃z�[���h�͕��������F������
    unless SR_Util.reversible_hold?(@type)
      self.bitmap.font.color = Color.new(255, 255, 128, 255)
    end
    self.bitmap.font.size = $default_size_s_mini
    self.bitmap.draw_text(0, 0, self.bitmap.width , self.bitmap.height, hold_name, 1)

    # �ʒu����
    self.x = @last_x = -100
    self.y = @last_y = -100
    self.ox = self.bitmap.width / 2
    self.oy = self.bitmap.height / 2
    self.z = 1500
  end
  
  #--------------------------------------------------------------------------
  # �� �C�j�V�A�`�u�̕ύX
  #-------------------------------------------------------------------------- 
  def initiative_change(number)
    @initiative += number
    refresh
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h����
  #-------------------------------------------------------------------------- 
  def hold_delete
    @delete_flag = true
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h�������H
  #-------------------------------------------------------------------------- 
  def delete?
    return @delete_flag
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #-------------------------------------------------------------------------- 
  def update
    super
  end
  
end