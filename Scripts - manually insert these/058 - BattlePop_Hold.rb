class BattlePop_Hold
  
  attr_accessor :battler                  # �o�g���[
  attr_accessor :action_list             # �o�g���[
  attr_accessor :initiative
  attr_accessor :display  
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize(battler)
    @battler = battler
    @data = []
    @fade_flag = 0
    @delete_flag = false
    @action_order = false
    @action_step = 0
    @action_list = []
    @wait_count = 0
    @initiative = 0
    @last_initiative = @initiative
    @initiative_graphic = HoldPop_Initiative_Sprite.new(@initiative)
    @display = false
    hold_pop_max = 3
  end
  #--------------------------------------------------------------------------
  # �� ���
  #-------------------------------------------------------------------------- 
  def dispose
    for data in @data
      data.dispose
    end
    @initiative_graphic.dispose
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #-------------------------------------------------------------------------- 
  def refresh
    # �o�g���[�������ꍇ�͓������Ȃ�
    return @battler == nil 
  end

  #--------------------------------------------------------------------------
  # �� �z�[���h�̒ǉ�
  #   type   : ��ʁi���}���A��ʋR�擙�j
  #   battler: ����
  #   target : �ڑ�����
  #   initiative : �����C�j�V�A�`�u
  #-------------------------------------------------------------------------- 
  def add_hold(type, battler, target)
    @data.push(HoldPop_Sprite.new(type, battler, target))
    @data[@data.size - 1].appear
    @data[@data.size - 1].whiten
    Audio.se_play("Audio/SE/se_maoudamashii_chime09", 80, 150)
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h�̏���
  #-------------------------------------------------------------------------- 
  def delete_hold(type, battler, target)
    # �o�g���[�������ꍇ�͓������Ȃ�
    return if @battler == nil
    exist_flag = false
    for data_one in @data
      if data_one.type == type and data_one.battler == battler and data_one.target == target
        data_one.escape
        data_one.hold_delete
        exist_flag = true
      end
    end
    # �Ώۃz�[���h���Ȃ��ꍇ�I��
    return if exist_flag == false
    # �c��̏���
    Audio.se_play("Audio/SE/heal02", 80, 100)
    @wait_count = $game_system.battle_speed_time(0)
    @delete_flag = true
  end
  #--------------------------------------------------------------------------
  # �� �C�j�V�A�`�u�̕ύX
  #-------------------------------------------------------------------------- 
  def initiative_change(plus_initiative)
    # �o�g���[�������ꍇ�͓������Ȃ�
    return if @battler == nil
    @initiative += plus_initiative
    @initiative_graphic.now_initiative = @initiative
    refresh
  end
  #--------------------------------------------------------------------------
  # �� �t�F�[�h�C���w��
  #-------------------------------------------------------------------------- 
  def fade_in_order
    @fade_flag = 1
  end
  #--------------------------------------------------------------------------
  # �� �t�F�[�h�A�E�g�w��
  #-------------------------------------------------------------------------- 
  def fade_out_order
    @fade_flag = 2
  end
  #--------------------------------------------------------------------------
  # �� �|�b�v�̎w��
  #-------------------------------------------------------------------------- 
  def pop_order(action_list = [])
    @action_order = true
    @action_list = action_list
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #-------------------------------------------------------------------------- 
  def update
    # �o�g���[�������ꍇ�͓������Ȃ�
    return if @battler == nil
    
    # �C�j�V�A�`�u�O���t�B�b�N�̍X�V
    @initiative_graphic.update
    
    # �\����Ԃ�A��
    for data in @data
      data.visible = @display if data != nil
    end
    @initiative_graphic.visible = @display
    
    # ���W���m��i�A�N�^�[���X�V�����x�ɕω�����̂�update�Ŋm��j
    # �A�N�^�[�̏ꍇ
    if @battler.is_a?(Game_Actor)
      # �A�N�^�[�P�ł���ꍇ�͍����ɔz�u
      if @battler == $game_party.battle_actors[0]
        @x_basepoint = 55
        @y_basepoint = 420
      # ����ȍ~�͉E���ɔz�u
      else 
        @x_basepoint = 585
        @y_basepoint = 420
      end
    # �G�l�~�[�̏ꍇ
    elsif @battler.is_a?(Game_Enemy)
      @x_basepoint = @battler.screen_x - 20
      temp_picture = RPG::Cache.battler(@battler.battler_name, 0)
      @y_basepoint = @battler.screen_y - (temp_picture.height / 2) - 60
      if temp_picture.height <= 410
        @y_basepoint = @battler.screen_y - (temp_picture.height / 2) - 60
      end
      # ���W��O����
      case @battler.class_name
      when "Succubus"
        @x_basepoint += 15
      when "Little Witch "
        @y_basepoint += 30
      when "Sli��e"
        @x_basepoint += 15
      end
      @x_basepoint += 25 if @battler.boss_graphic?
    end
    # nil�̕������l�߂�
    @data.compact!
    # ���W�ɍ��킹�Ĕz�u
    # �G�l�~�[�̏ꍇ�A�w����W���牺�ɑ��₷
    if @battler.is_a?(Game_Enemy)
      @initiative_graphic.x = @x_basepoint
      @initiative_graphic.y = @y_basepoint - 18
      for i in 0...@data.size
        @data[i].x = @x_basepoint
        @data[i].y = @y_basepoint + (18 * i)
      end
    # �A�N�^�[�̏ꍇ�A�w����W�𐔂ɍ��킹�Ĉ����グ�Ă��牺�ɑ��₷�B
    elsif @battler.is_a?(Game_Actor)
      y_point = @y_basepoint - (18 * @data.size)
      for i in 0...@data.size
        @data[i].x = @x_basepoint
        @data[i].y = y_point + (18 * i)
      end
      @initiative_graphic.x = @x_basepoint
      @initiative_graphic.y = y_point - 18
    end
    # �|�b�v���ƂɍX�V
    for pop in @data
      pop.update
    end
    # �E�F�C�g������Ύ~�߂�
    if @wait_count > 0
      @wait_count -= 1
      return 
    end

    # �t�F�[�h
    fade_time = 10
    case @fade_flag
    when 1 # �t�F�[�h�C��
      count = 0
      for pop in @data
        pop.opacity += 260 / fade_time 
      end
      @initiative_graphic.opacity += 260 / fade_time 
      if @initiative_graphic.opacity == 255
        @fade_flag = 0
      end
    when 2 # �t�F�[�h�A�E�g
      count = 0
      for pop in @data
        pop.opacity -= 260 / fade_time
        count += 1 if pop.opacity == 0
      end
      @initiative_graphic.opacity -= 260 / fade_time 
      if @initiative_graphic.opacity == 0
        @fade_flag = 0
      end
    end
    return if @fade_flag != 0

    # �����t���O�������Ă���ꍇ�͏����w���̂���|�b�v������
    if @delete_flag and @action_order == false
      for i in 0...@data.size
        if @data[i].delete?
          @data[i].dispose
          @data[i] = nil
        end
      end
      @delete_flag = false
    end
    
    if @initiative != @last_initiative and @action_order == 0
      @action_order = true
    end
    
    # �A�N�V�������N�����ꍇ�̓A�N�V������W�J����
    if @action_order
      action_update
      return
    end

  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�V�����ꊇ)
  #-------------------------------------------------------------------------- 
  def action_update
    case @action_step
    when 0; action_update_step0 
    when 1; action_update_step1
    when 2; action_update_step2
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�V�����@�X�e�b�v�O�F�t�F�[�h�C��)
  #-------------------------------------------------------------------------- 
  def action_update_step0
    # �t�F�[�h�C�����w��
    fade_in_order
    # �X�e�b�v��i�߂�
    @action_step = 1
  end
  #--------------------------------------------------------------------------
  # �� �C�j�V�A�`�u�̊m�F
  #-------------------------------------------------------------------------- 
  def initiative_check
    if @initiative != @last_initiative
      @initiative_graphic.now_initiative = @initiative
      for data in @data
        data.initiative = @initiative if data != nil
      end
      @last_initiative = @initiative
    end
    data_count = 0
    for data in @data
      if data.delete?
        next
      end
      data_count += 1
    end
    @initiative_graphic.now_data_size = data_count
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�V�����@�X�e�b�v�P�F�A�N�V����)
  #-------------------------------------------------------------------------- 
  def action_update_step1
    for list in @action_list
      case list[0]
      when 1 # �ǉ�
        add_hold(list[1],list[2],list[3])
      when 2 # �폜
        delete_hold(list[1],list[2],list[3])
      when 3 # �폜
        @initiative = list[1]
      end
    end
    initiative_check
    # �E�F�C�g������
    @wait_count = $game_system.battle_speed_time(0) + $game_system.important_wait_time
    # �X�e�b�v��i�߂�
    @action_step = 2
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�N�V�����@�X�e�b�v�Q�F�t�F�[�h�A�E�g)
  #-------------------------------------------------------------------------- 
  def action_update_step2
    # �t�F�[�h�A�E�g���w��
    fade_out_order
    # �t���O�n�����t���b�V��
    @action_step = 0
    @action_order = false
    @action_list = []
  end
  
  
end