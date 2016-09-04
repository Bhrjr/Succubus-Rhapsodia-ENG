#==============================================================================
# �� Scene_PartyForm
#------------------------------------------------------------------------------
# �@�p�[�e�B�Ґ����s���N���X�ł��B
#==============================================================================

class Scene_Partychange
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #     call_scene  : �Ăяo���� (0..���j���[  1..�}�b�v  2..�퓬)
  #     menu_index  : ���j���[�R�}���hINDEX
  #     can_discont : ���f�\
  #     min_members : �Œ�l��
  #--------------------------------------------------------------------------
  def initialize(call_scene = 0, now_index = 0)
    @call_scene = call_scene
    @now_index = now_index
  end
  #--------------------------------------------------------------------------
  # �� ���C������
  #--------------------------------------------------------------------------
  def main
    
    
    @status_command = 0
    
    # ����
    @back = Sprite.new
    @back.bitmap = RPG::Cache.windowskin("default_back")
    @back.bitmap = RPG::Cache.windowskin("default_back_2") if $PRODUCT_VERSION
    @back.visible = true
    @back.z = 5000
    # �E�B���h�E
    @window = Sprite.new
    @window.bitmap = RPG::Cache.windowskin("menu_windowL")
    @window.y = 40
    @window.z = 5020
    @window.opacity = 200
    @window.visible = true
    # �����E�B���h�E
    @center_window = Window_Status.new($game_party.party_actors[@now_index])
    @center_window.z = 5100
    @center_window1 = Window_SkillStatus.new($game_party.party_actors[@now_index])
    @center_window1.z= 5100
    @center_window1.visible = false
    # �w���v�E�B���h�E
    @help_window = Window_Help.new
    @help_window.visible = true
    @help_window.z = 5020
    @help_window.window.z = 5015
    @help_window.window.visible = true
    @help_window.y = 340
    @help_window.window.y = 340
    
    # �A�N�^�[�O���t�B�b�N
    @actor_graphic = Sprite.new
    @actor_graphic.x = 320
    @actor_graphic.y = 240
    @actor_graphic.z = 5010
    
    refresh
    
    
    # �g�����W�V�������s
    Graphics.transition(8)
    # ���C�����[�v
    loop {
      # �Q�[����ʂ��X�V
      Graphics.update
      # ���͏����X�V
      Input.update
      # �t���[���X�V
      update
      # �V�[���I������
      break if scene_end?
    }
    # �g�����W�V��������
    Graphics.freeze
    # �E�B���h�E�����
    
    @actor_graphic.dispose
    @center_window.dispose
    @center_window1.dispose
    @back.dispose
    @window.dispose
    @help_window.dispose
  end
  #--------------------------------------------------------------------------
  # �� ���t���b�V��
  #--------------------------------------------------------------------------
  def refresh
    actor = $game_party.party_actors[@now_index]
        
    @actor_graphic.bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
    @actor_graphic.x = 320
    @actor_graphic.y = 240
    @actor_graphic.y += 60 if actor.boss_graphic?
    @actor_graphic.ox = @actor_graphic.bitmap.width / 2
    @actor_graphic.oy = @actor_graphic.bitmap.height / 2
    @center_window1.actor = @center_window.actor = actor
    @center_window.refresh
    @center_window1.refresh
    
    case @status_command
    when 0
      text = "�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
    when 1
      text = "����F�X�L���m�F�@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
    when 2
      text = "����F�f���m�F�@�����F�\�������o�[�ύX�@�����F�E�B���h�E�ύX"
    end
    @help_window.set_text(text, 1)
    
  end
  #--------------------------------------------------------------------------
  # �� �V�[���I������
  #--------------------------------------------------------------------------
  def scene_end?
    if @call_scene == 2
      return @return_flag
    else
      return $scene != self
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    
    if @center_window.active
      update_center_active
      return
    end
    
    case @status_command
    when 0
      update_status
    when 1
      update_skill
    when 2
      update_ability
    end
        
    # �E �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::RIGHT)
      # �J�[�\�� SE �����t
      @now_index += 1
      @now_index = 0 if @now_index >= $game_party.party_actors.size
      $game_system.se_play($data_system.cursor_se)
      refresh
      return
    end
    
    # �� �{�^���������ꂽ�ꍇ
    if Input.repeat?(Input::LEFT)
      # �J�[�\�� SE �����t
      @now_index -= 1
      @now_index = $game_party.party_actors.size - 1 if @now_index < 0
      $game_system.se_play($data_system.cursor_se)
      refresh
      return
    end
    
    
  end
  #--------------------------------------------------------------------------
  # �� ���̉�ʂɖ߂�
  #--------------------------------------------------------------------------
  def return_scene
    case @call_scene
    when 0
      # ���j���[��ʂɖ߂�
      if $imported["MenuAlter"]
        index = KGC::MA_COMMANDS.index(7)
        if index != nil
          $scene = Scene_Menu.new(index)
        else
          $scene = Scene_Menu.new
        end
      else
        $scene = Scene_Menu.new(@menu_index)
      end
    when 1
      # �}�b�v��ʂɖ߂�
      $scene = Scene_Map.new
    when 2
      @return_flag  = true
    end
  end
end