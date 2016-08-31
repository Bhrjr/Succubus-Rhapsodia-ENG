#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Menu
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    $game_system.system_fed = 0 if $game_system.system_fed == nil
    @index = 0
    
    # 0:��������, 1:�S�o��, 2:�S���� 3,�|�[�Y�p
    @fade_flag = 1
    
    # 0:��������, 1:�p�[�e�B, 2:�A�C�e��, 3:�V�X�e��, -1:�A�N�^�[�I��
    @command = 0
    
    # 0:�X�e�[�^�X, 1:�f��, 2:�X�L��
    @party_command = 0
    
    
    @return_flag = false
    @hidden_flag = false
    @pause_flag  = false 
    
    @select_color = Color.new(255, 255, 255)
    @nonselect_color = Color.new(84, 98, 79)
    
    # ����
    @center = []
    @center[0] = Sprite.new
    @center[0].y = 0
    @center[0].opacity = 0
    @center[0].bitmap = RPG::Cache.windowskin("menu_back")
    @center[0].z = 2000
    @center[0].visible = true
    @center[0].blend_type = 2
    for i in 0..$game_party.party_actors.size - 1
      case i
      when 0
        x = 5
        y = 14
        type = 1
      when 1
        x = 325
        y = 24
        type = 1
      when 2
        x = 5
        y = 204
        type = 2
      when 3
        x = 325
        y = 214
        type = 2
      end
      @center[i + 1] = Window_MenuStatus.new(x, y, $game_party.party_actors[i], type)
    end
    
    
    # �p�[�e�B�I��p
    @select = Sprite.new
    @select.bitmap = RPG::Cache.windowskin("menu_status0")
    @select.x = @center[1].x + 16
    @select.y = @center[1].y + 16
    @select.z = 2060
    @select.visible = false
    @select.opacity = 0

    @now_select = Sprite.new
    @now_select.bitmap = RPG::Cache.windowskin("menu_status0")
    @now_select.x = @center[1].x + 16
    @now_select.y = @center[1].y + 16
    @now_select.z = 2060
    @now_select.opacity = 200
    @now_select.visible = false
    
    @select_index = 0
    @now_select_index = 0
    @seleck_blink_flag  = false
    @select_blink_check = false
    
    # ��t���[��
    @overF = []
    for i in 0..1
      @overF[i] = Sprite.new
      @overF[i].y = 0 - 100
      @overF[i].z = 2100
      @overF[i].visible = true
    end
    @overF[0].bitmap = RPG::Cache.windowskin("menu_overF")
    @overF[0].x = 0 #-150
    @overF[1].bitmap = Bitmap.new(640, 100)
    @overF_text = $game_party.gold.to_s + "�@" + $data_system.words.gold
    
    # ���t���[��
    @underF = []
    for i in 0..5
      @underF[i] = Sprite.new
      @underF[i].y = 380 + 100
      @underF[i].z = 3100
      @underF[i].visible = true
    end
    @underF[0].bitmap = RPG::Cache.windowskin("menu_underF")
    @underF[0].x = -240 #-120
    @underF[1].bitmap = RPG::Cache.windowskin("menu_underF_party")
    @underF[2].bitmap = RPG::Cache.windowskin("menu_underF_item")
    @underF[3].bitmap = RPG::Cache.windowskin("menu_underF_system")

    @underF[4].x = 106
    @underF[4].bitmap = Bitmap.new(180, 100)
    @underF[4].bitmap.font.size = $default_size_mini
    
    @underF[5].x = 430
    @underF[5].bitmap = Bitmap.new(180, 100)
    @underF[5].bitmap.font.size = $default_size_mini
    @underF[5].bitmap.draw_text(0, 56, 180, 20, "Contracted Succubi:", 0)
    @underF[5].bitmap.draw_text(0, 56, 180, 20, $game_party.home_actors.to_s + " / " + $game_party.box_max.to_s, 2)
    @underF[5].bitmap.draw_text(0, 76, 180, 20, "Total Dream Power:", 0)
    @underF[5].bitmap.draw_text(0, 76, 180, 20, $game_party.all_d_power.to_s, 2)
    
    @window = []
    for i in 0..2
      @window[i] = Sprite.new
      @window[i].z = 2020
      @window[i].visible = false
      @window[i].opacity = 200
    end
    @window[0].bitmap = RPG::Cache.windowskin("menu_windowL")
    @window[0].y = 40
    @window[1].bitmap = RPG::Cache.windowskin("menu_windowL")
    @window[1].x = 640 - 20
    @window[1].y = 40
   
    
    @actor_graphic = Sprite.new
    @actor_graphic.z = 2010
    @actor_graphic.visible = true
    
    # �A�C�e���p

    # ������ʕ\���p�@0:��������, 1:�o��, 2:����
    @equip_fade_flag = 0
    # ������ʗp�@0:��������, 1:�����I��, 2:�����ύX��
    @equip_time = 0

    @message_window = Window_Message.new
    # �w���v�E�B���h�E�A�A�C�e���E�B���h�E���쐬
    @help_window = Window_Help.new
    @help_window.visible = false

    @item_window = Window_Item.new
    @item_window.visible = false
    # �^�[�Q�b�g�E�B���h�E���쐬 (�s���E��A�N�e�B�u�ɐݒ�)
    @target_window = Window_Target.new
    @target_window.visible = false
    @target_window.active = false
    
    
    @menu_party_command_window = []
    
    commands = ["Status", "Cancel"]
    @menu_party_command_window[0] = Window_Command.new(120, commands)
    commands = ["Status", "Move", "Feed", "Cancel"]
    @menu_party_command_window[1] = Window_Command.new(120, commands)
    for window in @menu_party_command_window
      window.x = (640 - window.width) / 2
      window.y = (480 - window.height) / 2
      window.z = 2100
      window.opacity = 220
      window.visible = false
      window.active = false
    end
          
#    if $data_config.getLine(2) == "full" #�t���X�N���[��
#      $game_system.system_fullscreen = true
#      @f_screen1 = 1
#    elsif $data_config.getLine(2) == "window" #�E�C���h�E
#      $game_system.system_fullscreen = false
#      @f_screen1 = 0
#    end
#    @f_screen2 = nil
    
  end
  #--------------------------------------------------------------------------
  # �� ���C������
  #--------------------------------------------------------------------------
  def main
    $game_temp.in_menu = true
    # �g�����W�V�������s
    Graphics.transition(0)
    # ���C�����[�v
    loop do
      # �Q�[����ʂ��X�V
      Graphics.update
      # ���͏����X�V
      Input.update
      # �t���[���X�V
      update
      # �V�[���I������
      break if @return_flag
    end
    # �g�����W�V��������
    Graphics.freeze
    # �E�B���h�E�����
    dispose
  end
  #--------------------------------------------------------------------------
  # �� ���
  #--------------------------------------------------------------------------
  def dispose
    
    for center in @center
      center.dispose
    end
    for overF in @overF
      overF.dispose
    end
    for underF in @underF
      underF.dispose
    end
    for window in @window
      window.dispose
    end
    @help_window.dispose
    @help_window.window.dispose
    @item_window.dispose
    @target_window.dispose
    @select.dispose
    @message_window.dispose
    @menu_party_command_window[0].dispose
    @menu_party_command_window[1].dispose
    $game_temp.in_menu = false
    
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update

    refresh
    @message_window.update
    
    
    
    # ���b�Z�[�W�\�����̏ꍇ�̓{�b�N�X��������b�N
    if $game_temp.message_window_showing
      return
    end

    # �Z���N�g���\�����̏ꍇ�̓u�����N������
    if @select_blink_flag
      select_blink
    end
    
    # �t�F�[�h�t���O�������Ă���ꍇ�̓t�F�[�h
    if @fade_flag != 0
      fade
      return
    end
    
    # �|�[�Y��ԃt���O�������Ă���ꍇ�͑�������b�N
    if @pause_flag == true
      # �{�^���������΃��j���[�ɖ߂�
      if Input.trigger?(Input::A) \
       or Input.trigger?(Input::B) \
       or Input.trigger?(Input::C)
        # ���� SE �����t
        $game_system.se_play($data_system.decision_se)
        # �߂�
        @fade_flag = 1
        @pause_flag = false
        @overF_text = $game_party.gold.to_s + "�@" + $data_system.words.gold
      end
      return
    end
    
    # �t���[���X�V
    case @command
    when 0 # ���j���[
      update_menu_command
    when -1 # �A�N�^�[�I��
      update_actor_select
    when 1 # �p�[�e�B
      update_party
    when 2 # �A�C�e��
      update_item
    when 3 # �V�X�e��
      update_system
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V�i���j���[�R�}���h�j
  #--------------------------------------------------------------------------
  def update_menu_command
    
    # �E�{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # SE �����t
      Audio.se_play("Audio/SE/005-System05", 80, 100)
      if @index == 2
        @index = 0
      else
        @index += 1
      end
      return
    end
    # ���{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::LEFT)
      # SE �����t
      Audio.se_play("Audio/SE/005-System05", 80, 100)
      if @index == 0
        @index = 2
      else
        @index -= 1
      end
      return
    end
    # A �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::A)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      @pause_flag = true
      @fade_flag = 3
      @overF_text = "MAP PAUSE"
      return
    end
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      case @index
      when 0 # �p�[�e�B
        @overF_text = "P a r t y"
        @select.visible = true
        @select_index = 0
        @select_blink_flag = true
        @command = -1
      when 1 # �A�C�e��
        @fade_flag = 4
        @overF_text = "I t e m"
        @command = 2
        # �w���v�E�B���h�E���֘A�t��
        @item_window.index = 0
        @item_window.help_window = @help_window
        @help_window.visible = true
        @help_window.window.visible = true
        @item_window.visible = true
        @window[0].visible = true
        @window[0].y = 40
        n = 340
        @help_window.y = n
        @help_window.window.y = n
      when 2 # �V�X�e��
        @fade_flag = 4
        @overF_text = "S y s t e m"
        @command = 3
        # �w���v�E�B���h�E���֘A�t��
        @center_window = Window_SystemLeft.new
        @center_window.help_window = @help_window
        @help_window.visible = true
        @help_window.window.visible = true
        @window[0].visible = true
        @window[0].y = 40
        n = 340
        @help_window.y = n
        @help_window.window.y = n
      end
      return
    end
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �}�b�v��ʂɐ؂�ւ�
      @fade_flag = 2
      return
    end
    
  end

  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    
    @overF[1].bitmap.clear
    @overF[1].bitmap.draw_text(375, 0, 200, 32, @overF_text, 1)
    
    @underF[4].bitmap.clear
    case @index
    when 0 # Party
      @underF[1].color = @select_color
      @underF[2].color = @nonselect_color
      @underF[3].color = @nonselect_color
      @underF[4].bitmap.draw_text(0, 36, 180, 20, "Examine party members", 1)
    when 1 # Item
      @underF[1].color = @nonselect_color
      @underF[2].color = @select_color
      @underF[3].color = @nonselect_color
      @underF[4].bitmap.draw_text(0, 36, 180, 20, "Use an item", 1)
    when 2 # System
      @underF[1].color = @nonselect_color
      @underF[2].color = @nonselect_color
      @underF[3].color = @select_color
      @underF[4].bitmap.draw_text(0, 36, 180, 20, "Change settings", 1)
    end
    
    if @select.visible == true
      @select.x = @center[@select_index + 1].x + 16
      @select.y = @center[@select_index + 1].y + 16
    end
    
    if @now_select.visible == true
      @now_select.x = @center[@now_select_index + 1].x + 16
      @now_select.y = @center[@now_select_index + 1].y + 16
    end
    
  end
  
  
  #--------------------------------------------------------------------------
  # �� �����E�B���h�E�̍X�V
  #--------------------------------------------------------------------------
  def center_refresh
    for i in 1..@center.size - 1
      @center[i].refresh
    end
  end
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
      # �����X�e�[�^�X
      if @center[@center.size - 1].contents_opacity < 255
        for i in 1..@center.size - 1
          @center[i].contents_opacity += 260 / n
        end
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
      # ���ׂĊ���������t�F�[�h���I������B
      if @center[0].opacity == 120 \
       and @center[@center.size - 1].contents_opacity == 255 \
       and @overF[@overF.size - 1].y == 0 \
       and @underF[@underF.size - 1].y == 380
        @fade_flag = 0
      end
      return
      
    when 2 # �S����
      # �����w�i
      if @center[0].opacity > 0
        @center[0].opacity -= 120 / n
      end
      # �����X�e�[�^�X
      if @center[@center.size - 1].contents_opacity > 0
        for i in 1..@center.size - 1
          @center[i].contents_opacity -= 260 / n
        end
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
      # ���ׂĊ���������t�F�[�h���I������B
      if @center[0].opacity == 0 \
       and @center[@center.size - 1].contents_opacity == 0 \
       and @overF[@overF.size - 1].y == -100 \
       and @underF[@underF.size - 1].y == 380 + 100
        # ��\���ł͂Ȃ��ꍇ�͖߂��B
        if @hidden_flag == false
          @return_flag = true
        end
        @fade_flag = 0
      end
      return
      
    when 3 # �|�[�Y�p
      # �����w�i
      if @center[0].opacity > 0
        @center[0].opacity -= 120 / n
      end
      # �����X�e�[�^�X
      if @center[@center.size - 1].contents_opacity > 0
        for i in 1..@center.size - 1
          @center[i].contents_opacity -= 260 / n
        end
      end
      # ���t���[��
      if @underF[@underF.size - 1].y < 380 + 100
        for underF in @underF
          underF.y += 100 / n
        end
      end
      # ���ׂĊ���������t�F�[�h���I������B
      if @center[0].opacity == 0 \
       and @center[@center.size - 1].contents_opacity == 0 \
       and @underF[@underF.size - 1].y == 380 + 100
        # ��\���ł͂Ȃ��ꍇ�͖߂��B
        if @pause_flag == false
          @return_flag = true
        end
        @fade_flag = 0
      end
      return

    when 4 # �R�}���h�p�t���[���ړ��iON�j
      # �����X�e�[�^�X
      if @center[@center.size - 1].contents_opacity > 0
        for i in 1..@center.size - 1
          @center[i].contents_opacity -= 260 / n
        end
      end
      # ��t���[��
      if @overF[0].x > -150
        for overF in @overF
          overF.x -= 150 / n
        end
      end
      # ���t���[��
      if @underF[0].x < -120
        for underF in @underF
          underF.x += 120 / n
          if underF == @underF[5]
            underF.opacity -= 260 / n
          end
        end
      end
      # ���ׂĊ���������t�F�[�h���I������B
      if @center[@center.size - 1].contents_opacity == 0 \
       and @overF[0].x == -150 \
       and @underF[0].x == -120
       @fade_flag = 0
      end
      return

    when 5 # �R�}���h�p�t���[���ړ��iOFF�j
      # �����X�e�[�^�X
      if @center[@center.size - 1].contents_opacity < 255
        for i in 1..@center.size - 1
          @center[i].contents_opacity += 260 / n
        end
      end
      # ��t���[��
      if @overF[0].x < 0
        for overF in @overF
          overF.x += 150 / n
        end
      end
      # ���t���[��
      if @underF[0].x > -240
        for underF in @underF
          underF.x -= 120 / n
          if underF == @underF[5]
            underF.opacity += 260 / n
          end
        end
      end
      # ���ׂĊ���������t�F�[�h���I������B
      if @center[@center.size - 1].contents_opacity == 255 \
       and @overF[0].x == 0 \
       and @underF[0].x == -240
       @fade_flag = 0
      end
      return

    when 6 # �A�C�e����ʂ���I��
      # �����w�i
      if @center[0].opacity > 0
        @center[0].opacity -= 120 / n
      end
      # �����X�e�[�^�X
      if @center[@center.size - 1].contents_opacity > 0
        for i in 1..@center.size - 1
          @center[i].contents_opacity -= 260 / n
        end
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
      
      @window[0].opacity -= 260 / n
      @help_window.contents_opacity -= 260 / n
      @help_window.window.opacity -= 260 / n
      @item_window.back_opacity -= 260 / n
      @item_window.contents_opacity -= 260 / n
      
      # ���ׂĊ���������t�F�[�h���I������B
      if @center[0].opacity == 0 \
       and @center[@center.size - 1].contents_opacity == 0 \
       and @overF[@overF.size - 1].y == -100 \
       and @underF[@underF.size - 1].y == 380 + 100
        # ��\���ł͂Ȃ��ꍇ�͖߂��B
        if @hidden_flag == false
          @return_flag = true
        end
        @fade_flag = 0
      end
      return
      
    when 7 # �����o�[���p
      
      @center[@select_index + 1].contents_opacity -= 260 / n
      @center[@now_select_index + 1].contents_opacity -= 260 / n
      
      if @center[@now_select_index + 1].contents_opacity == 0
        @fade_flag = 8
        # �w�肵�������o�[����シ��
        $game_party.actors[@select_index] = @select_actor2
        $game_party.actors[@now_select_index] = @select_actor1
        $game_party.battle_actor_refresh
        # ��ʂ̃��t���b�V��
        for i in 0..$game_party.party_actors.size - 1
          @center[i + 1].actor = $game_party.party_actors[i]
          @center[i + 1].refresh
        end
      end
      return
      
    when 8 # �����o�[���p
      
      @center[@select_index + 1].contents_opacity += 260 / n
      @center[@now_select_index + 1].contents_opacity += 260 / n
      if @center[@now_select_index + 1].contents_opacity == 255
        @fade_flag = 0
        @overF_text = "P a r t y"
        @select_blink_flag = true
      end
      return
            

      
    
    when 9 # �X�L����ʂ���I��
      # �����w�i
      if @center[0].opacity > 0
        @center[0].opacity -= 120 / n
      end
      # �����X�e�[�^�X
      if @center[@center.size - 1].contents_opacity > 0
        for i in 1..@center.size - 1
          @center[i].contents_opacity -= 260 / n
        end
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
      
      @window[0].opacity -= 260 / n
      @help_window.contents_opacity -= 260 / n
      @help_window.window.opacity -= 260 / n
      @center_window.back_opacity -= 260 / n
      @center_window.contents_opacity -= 260 / n
      @center_window1.contents_opacity -= 260 / n
      @actor_graphic.opacity -= 260 / n
      
      # ���ׂĊ���������t�F�[�h���I������B
      if @center[0].opacity == 0 \
       and @center[@center.size - 1].contents_opacity == 0 \
       and @overF[@overF.size - 1].y == -100 \
       and @underF[@underF.size - 1].y == 380 + 100
        # ��\���ł͂Ȃ��ꍇ�͖߂��B
        if @hidden_flag == false
          @return_flag = true
        end
        @fade_flag = 0
      end
      return
    end
      
    
  end
  
  #--------------------------------------------------------------------------
  # �� �Z���N�g�u�����N
  #--------------------------------------------------------------------------
  def select_blink
    n = 15
    if @select.opacity < 255 and @select_blink_check == false
      @select.opacity += 260 / n
      @select_blink_check = true if @select.opacity == 255
    elsif @select.opacity > 0 and @select_blink_check == true
      @select.opacity -= 260 / n
      @select_blink_check = false if @select.opacity == 0      
    end
  end
end