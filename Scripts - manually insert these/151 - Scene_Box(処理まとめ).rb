class Scene_Box
  #--------------------------------------------------------------------------
  # �� �t�F�[�h
  #--------------------------------------------------------------------------
  def fade
    # �t�F�[�h�C�������B10�t���[���ōs���B
    
    n = 10
    
    case @fade_flag
    
    when 1 # �S�o��
      # �����w�i
      if @center[0].opacity < 120
        @center[0].opacity += 120 / n
      end
      # ��t���[��
      if @overF[@overF.size - 1].y < 0
        for overF in @overF
          overF.y += 100 / n
        end
      end
      # ���t���[��
      if @underF[@underF.size - 1].y > 380
        for underF in @underF
          underF.y -= 100 / n
        end
      end
      # �E�B���h�E
      for window in @window
        window.opacity += 200 / n
      end
      @actor_graphic.opacity += 260 / n
      @left_window.contents_opacity += 260 / n
      @right_window.contents_opacity += 260 / n

      # ���ׂĊ���������t�F�[�h���I������B
      if @overF[@overF.size - 1].y == 0 \
       and @underF[@underF.size - 1].y == 380
        @fade_flag = 0
      end
      return
      
    when 2 # �S����
      # �����w�i
      if @center[0].opacity > 0
        @center[0].opacity -= 120 / n
      end
      # ��t���[��
      if @overF[@overF.size - 1].y > -100
        for overF in @overF
          overF.y -= 100 / n
        end
      end
      # ���t���[��
      if @underF[@underF.size - 1].y < 380 + 100
        for underF in @underF
          underF.y += 100 / n
        end
      end
      # �E�C���h�E
      for window in @window
        window.opacity -= 200 / n
      end
      @actor_graphic.opacity -= 260 / n
      @left_window.contents_opacity -= 260 / n
      @right_window.contents_opacity -= 260 / n

      # ���ׂĊ���������t�F�[�h���I������B
      if @overF[@overF.size - 1].y == -100 \
       and @underF[@underF.size - 1].y == 380 + 100
        # ��\���ł͂Ȃ��ꍇ�͖߂��B
        if @hidden_flag == false
          @return_flag = true
        end
        @fade_flag = 0
      end
      return
      
    when 3 # �R�}���h�p�t���[���ړ��iON�j
      # ��t���[��
      for overF in @overF
        overF.x -= 150 / n
      end
      # ���t���[��
      for underF in @underF
        underF.x += 120 / n
        if underF == @underF[4]
          underF.opacity -= 260 / n
        end
      end
      
      @left_window.contents_opacity -= 260 / n
      @right_window.contents_opacity -= 260 / n
      @window[0].opacity -= 200 / n
      @window[1].opacity -= 200 / n
      
      # ���ׂĊ���������t�F�[�h���I������B
      if @overF[0].x == -150 \
       and @underF[0].x == -120
      @fade_flag = 0
      end
      return

    when 4 # �R�}���h�p�t���[���ړ��iOFF�j
      # ��t���[��
      for overF in @overF
        overF.x += 150 / n
      end
      # ���t���[��
      for underF in @underF
        underF.x -= 120 / n
        if underF == @underF[4]
          underF.opacity += 260 / n
        end
      end
      @left_window.contents_opacity += 260 / n
      @right_window.contents_opacity += 260 / n
      @window[0].opacity += 200 / n
      @window[1].opacity += 200 / n
      # ���ׂĊ���������t�F�[�h���I������B
      if @overF[0].x == 0 \
       and @underF[0].x == -240
       @fade_flag = 0
      end
      return
    end
  end

  #--------------------------------------------------------------------------
  # �� �A��čs������
  #--------------------------------------------------------------------------
  def party_in
    # �p�[�e�B�ɋ󂫂��Ȃ��ꍇ�̓u�U�[��炵�ďI��
    if $game_party.actors.size >= 4
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      $game_temp.message_text = "����ȏ�p�[�e�B�ɓ�����܂���I"
      return
    end
    # SE �����t
    Audio.se_play("Audio/SE/005-System05", 80, 100)
    # �f�̊m�F
    unless $game_party.party_actors.include?($game_actors[110])
      unless $game_party.party_actors.include?($game_actors[111])
        unless $game_party.party_actors.include?($game_actors[112])
          unless $game_party.party_actors.include?($game_actors[113])
            $game_variables[77] = 109
          end
        end
      end
    end
    unless $game_party.party_actors.include?($game_actors[106])
      unless $game_party.party_actors.include?($game_actors[107])
        unless $game_party.party_actors.include?($game_actors[108])
          unless $game_party.party_actors.include?($game_actors[109])
            $game_variables[77] = 105
          end
        end
      end
    end
    unless $game_party.party_actors.include?($game_actors[102])
      unless $game_party.party_actors.include?($game_actors[103])
        unless $game_party.party_actors.include?($game_actors[104])
          unless $game_party.party_actors.include?($game_actors[105])
            $game_variables[77] = 101
          end
        end
      end
    end
    # �󂫑f�̂��ƍ�����
    n = @now_actor.class_id
    body = $game_variables[77] + $data_SDB[n].exp_type
    # �f�[�^�ڑ�
    $game_party.data_move(body, @now_actor, 1)
    @now_actor.class_id = 1
    # �p�[�e�B�ɉ�����
    $game_party.add_actor(body)
    box_sort
    $game_party.battle_actor_refresh
  end
  #--------------------------------------------------------------------------
  # �� �a���鏈��
  #--------------------------------------------------------------------------
  def box_in
    i = 1
    loop do # �{�b�N�X�󂫊m�F
      if i == $game_party.box_max + 1 # �{�b�N�X�����t�̏ꍇ
        # �L�����Z�� SE �����t
        $game_system.se_play($data_system.cancel_se)
        $game_temp.message_text = "�z�[���������ς��ł��I\n�z�[�����󂯂Ă���a���Ă��������I"
        return
      end
      # �󂫁i�N���XID�� 1 �j�̏��ɓ����B
      if $game_actors[i].class_id == 1
        # ���a�����A�N�^�[�̎g�p�X�L����������������
        @now_actor.skill_collect = nil
        n = @now_actor.id
        # �p�[�e�B����O��
        $game_party.remove_actor(n)
        # �f�[�^�ڑ�
#        text = "�y�a����z\n"
#        text +=  "��M���h�c�F#{$game_actors[i].id}\n"
#        text += "��M���N���X�F#{$game_actors[i].class_id}\n"
#        text +=  "���M���h�c�F#{@now_actor.id}\n"
#        text += "���M���N���X�F#{@now_actor.class_id}"
#        print text
        $game_party.data_move(i, @now_actor, 1)
        $game_actors[n].class_id = 1
        # SE �����t
        Audio.se_play("Audio/SE/005-System05", 80, 100)
        break
      else
        i += 1
      end
    end
    box_sort
    $game_party.battle_actor_refresh
  end
  #--------------------------------------------------------------------------
  # �� �_��j��
  #--------------------------------------------------------------------------
  def release
    # SE �����t
    Audio.se_play("Audio/SE/heal02", 80, 100)
    # ��������ӏ����󂫁i�N���XID�� 1 �j�ɂ���
    @now_actor.class_id = 1
    # �p�[�e�B�̖�������������ꍇ���̖������p�[�e�B����O���B
    if $game_party.party_actors.include?(@now_actor)
      $game_party.remove_actor(@now_actor.id)
      $game_party.battle_actor_refresh
    end
    # �{�b�N�X�O�l��
    box_sort
  end
  #--------------------------------------------------------------------------
  # �� �{�b�N�X�̑O�l�ߍ��
  #--------------------------------------------------------------------------
  def box_sort
    box = []
    for i in 1..$game_party.box_max
      box.push($game_actors[i].dup) if $game_actors[i].class_id != 1
      $game_actors[i].class_id = 1
      $game_actors[i].level = 1
      $game_actors[i].name = ""
      $game_actors[i].skills = []
      $game_actors[i].ability = []
    end
    
    for i in 0...box.size
#      text = "�O�l��#{i}\n"
#      text +=  "��M���h�c�F#{box[i].id}\n"
#      text += "��M���N���X�F#{$game_actors[i + 1].class_id}\n"
#      text += "��M���X�L���F#{$game_actors[i + 1].skills}\n"
#      text +=  "���M���h�c�F#{box[i].id}\n"
#      text += "���M���N���X�F#{box[i].class_id}\n"
#      text += "���M���X�L���F#{box[i].skills}"
#      print text
      $game_party.data_move($game_actors[i + 1].id, box[i])
    end
    
#    text = "�{�b�N�X���m�F\n"
#    for a in 1..$game_party.box_max
#      text += "#{$game_actors[a].id}�F#{$game_actors[a].name}�F#{$game_actors[a].class_id}\n"
#      text += "#{$game_actors[a].skills}\n"
#    end
#    print text
  
    
    
    
    @now_actor = @right_window.actor = @left_window.actor_data
  end
  #--------------------------------------------------------------------------
  # �� �{�b�N�X�̕��ёւ���� ##�s����̂��ߌ���v
  #    type : 0:�푰��, 1:���x���� 
  #--------------------------------------------------------------------------
  def pigeonhole(type)
    box = []
    for i in 1..$game_party.box_max
      box.push($game_actors[i].dup) if $game_actors[i].class_id != 1
      $game_actors[i].class_id = 1
      
    end
    
    case type
    when 0
      result = box.sort{|a, b| a.class_id <=> b.class_id }
      if box == result
        box.sort!{|a, b| b.class_id <=> a.class_id }
      else
        box = result
      end
    when 1
      result = box.sort{|a, b| b.level <=> a.level }
      if box == result
        box.sort!{|a, b| a.level <=> b.level }
      else
        box = result
      end
    end
    
    for i in 0...box.size
      $game_party.data_move($game_actors[i + 1],box[i])
    end
    
    @now_actor = @right_window.actor = @left_window.actor_data
    graphic_refresh
end

  
  
end