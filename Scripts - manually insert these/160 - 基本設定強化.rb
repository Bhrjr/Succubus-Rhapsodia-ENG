#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
#_/    �� ��{�ݒ苭�� - KGC_Base Reinforce ��
#_/    �� Last update : 2009/08/23 ��
#_/----------------------------------------------------------------------------
#_/  RPGXP�̊�{�@�\������ɋ������܂��B(�o�O�C��������)
#_/============================================================================
#_/ ��X�e�[�g�A�C�R���\��[StateIcon]���艺
#_/  �Ȃ�ׂ���̕� ([Scene_Debug] �̒����t��) �ɓ������Ă��������B
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

#==============================================================================
# �� �J�X�^�}�C�Y���� - Customize ��
#==============================================================================

module KGC
  # ���퓬�w�i�S�̉�
  BR_BATTLEBACK_FULL = true
  # ���퓬���̃X�e�[�^�X�E�B���h�E����
  #  BR_BATTLEBACK_FULL �� true �̂Ƃ��ɗL���B
  BR_WINDOW_TRANSPARENT_BATTLE = true
  # �����C���t�F�[�Y���ɃE�B���h�E����
  #  BR_WINDOW_TRANSPARENT_MAIN_PHASE �� false �̂Ƃ��ɗL���B
  BR_WINDOW_TRANSPARENT_MAIN_PHASE = true
  # �����C���t�F�[�Y���ɃE�B���h�E�w�i����������
  #  BR_WINDOW_TRANSPARENT_MAIN_PHASE �� false �̂Ƃ��ɗL���B
  BR_WINDOW_BACK_CLEAR_MAIN_PHASE = true
  # �����C���t�F�[�Y���ɁA�E�B���h�E�����̕s�����x�������Ȃ�
  BR_WINDOW_OPACITY_FIX = true

  # ���퓬���̖��O�\�����e������
  BR_SHADOW_TEXT_NAME_BATTLE = true
  # ���퓬���̃X�e�[�g�\�����e������
  #  ���T�C�g�̃X�e�[�g�֘A�X�N���v�g���o�O��ꍇ�� false �ɂ��Ă��������B
  #  ��X�e�[�g�A�C�R���\���� �������͖����ł��B
  BR_SHADOW_TEXT_STATE_BATTLE = true

  # ���퓬�J�n�g�����W�V����(nil �ŉ���)
  BR_BATTLE_START_TRANSITION = nil
  #BR_BATTLE_START_TRANSITION = "016-Diamond02"
end

#������������������������������������������������������������������������������

$imported = {} if $imported == nil
$imported["Base Reinforce"] = true

#==============================================================================
# �� RPG::Sprite
#==============================================================================

class RPG::Sprite
  def animation_set_sprites(sprites, cell_data, position)
    for i in 0..15
      sprite = sprites[i]
      pattern = cell_data[i, 0]
      if sprite == nil || pattern == nil || pattern == -1
        sprite.visible = false if sprite != nil
        next
      end
      sprite.visible = true
      sprite.src_rect.set(pattern % 5 * 192, pattern / 5 * 192, 192, 192)
      if position == 3
        if self.viewport != nil
          sprite.x = self.viewport.rect.width / 2
          if self.viewport.rect.height == 481
            sprite.y = 300
          else
            sprite.y = self.viewport.rect.height / 2
          end
        else
          sprite.x, sprite.y = 320, 240
        end
      else
        sprite.x = self.x - self.ox + self.src_rect.width / 2
        sprite.y = self.y - self.oy + self.src_rect.height / 2
        sprite.y -= self.src_rect.height / 4 if position == 0
        sprite.y += self.src_rect.height / 4 if position == 2
      end
      sprite.x += cell_data[i, 1]
      sprite.y += cell_data[i, 2]
      sprite.z = 2000
      sprite.ox = sprite.oy = 96
      sprite.zoom_x = cell_data[i, 3] / 100.0
      sprite.zoom_y = cell_data[i, 3] / 100.0
      sprite.angle = cell_data[i, 4]
      sprite.mirror = (cell_data[i, 5] == 1)
      sprite.opacity = cell_data[i, 6] * self.opacity / 255.0
      sprite.blend_type = cell_data[i, 7]
    end
  end
end

#������������������������������������������������������������������������������

#==============================================================================
# �� Sprite_Battler
#==============================================================================

class Sprite_Battler < RPG::Sprite
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  alias update_KGC_Base_Reinforce update
  def update
    # �o�g���[�� nil �̏ꍇ
    if @battler == nil
      @battler_name = nil
      @battler_hue = nil
    end

    update_KGC_Base_Reinforce
  end
end

#������������������������������������������������������������������������������

#==============================================================================
# �� Spriteset_Battle
#==============================================================================

if KGC::BR_BATTLEBACK_FULL
class Spriteset_Battle
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  alias update_KGC_Base_Reinforce update
  def update
    # ���̏��������s
    update_KGC_Base_Reinforce

    @viewport1.rect.height = 480
    @viewport2.rect.height = 481
    # �o�g���o�b�N���ύX���ꂽ�ꍇ
    if @battleback_name2 != $game_temp.battleback_name
      # �S�̉�
      @battleback_name2 = $game_temp.battleback_name
      mag_x = 640.0 / @battleback_sprite.bitmap.width
      mag_y = 480.0 / @battleback_sprite.bitmap.height
      @battleback_sprite.zoom_x = mag_x
      @battleback_sprite.zoom_y = mag_y
    end
  end
end
end

#������������������������������������������������������������������������������

#==============================================================================
# �� Window_BattleStatus
#==============================================================================

class Window_BattleStatus < Window_Base
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  alias initialize_KGC_Base_Reinforce initialize
  def initialize
    initialize_KGC_Base_Reinforce

    # �w�i����
    if KGC::BR_WINDOW_TRANSPARENT_BATTLE
      self.opacity = 0
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  if KGC::BR_BATTLEBACK_FULL && !KGC::BR_WINDOW_TRANSPARENT_BATTLE
  def update
    super
    # ���C���t�F�[�Y�̂Ƃ��͕s�����x����≺����(���łɃE�B���h�E����)
    if $game_temp.battle_main_phase
      if self.contents_opacity > 224 && !KGC::BR_WINDOW_OPACITY_FIX
        self.contents_opacity -= 2
      end
      if self.opacity > 0 && KGC::BR_WINDOW_TRANSPARENT_MAIN_PHASE
        self.opacity -= 16
      end
      if self.back_opacity > 128 && KGC::BR_WINDOW_BACK_CLEAR_MAIN_PHASE
        self.back_opacity -= 8
      end
    else
      if self.contents_opacity < 255
        self.contents_opacity += 2
      end
      if self.opacity < 255 && KGC::BR_WINDOW_TRANSPARENT_MAIN_PHASE
        self.opacity += 16
      end
      if self.back_opacity < 255 && KGC::BR_WINDOW_BACK_CLEAR_MAIN_PHASE
        self.back_opacity += 8
      end
    end
  end
  elsif KGC::BR_WINDOW_OPACITY_FIX
  def update
    super
  end
  end
  if KGC::BR_SHADOW_TEXT_NAME_BATTLE
  #--------------------------------------------------------------------------
  # �� ���O�̕`��
  #--------------------------------------------------------------------------
  def draw_actor_name(actor, x, y)
    self.contents.font.color = normal_color
    self.contents.draw_shadow_text(x, y, 120, 32, actor.name)
  end
  end
  if KGC::BR_SHADOW_TEXT_STATE_BATTLE && !$imported["StateIcon"]
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�̕`��
  #--------------------------------------------------------------------------
  def draw_actor_state(actor, x, y, width = 120)
    text = make_battler_state_text(actor, width, true)
    self.contents.font.color = actor.dead? ? knockout_color : normal_color
    self.contents.font.color = crisis_color if actor.state?(15)
    self.contents.draw_shadow_text(x, y, width, 32, text)
  end
  end
end

#������������������������������������������������������������������������������

class Interpreter
#==============================================================================
# ���������� Interpreter 3 ����������
#==============================================================================
  #--------------------------------------------------------------------------
  # �� ��������
  #--------------------------------------------------------------------------
  alias command_111_KGC_Base_Rainforce command_111
  def command_111
    result = false
    # ��������
    if @parameters[0] == 4
      actor = $game_actors[@parameters[1]]
      if actor != nil && @parameters[2] == 4
        result = (actor.armor1_id == @parameters[3] ||
                  actor.armor2_id == @parameters[3] ||
                  actor.armor3_id == @parameters[3] ||
                  actor.armor4_id == @parameters[3])
      end
      # ���茋�ʂ��n�b�V���Ɋi�[
      @branch[@list[@index].indent] = result
      # ���茋�ʂ��^�������ꍇ
      if @branch[@list[@index].indent]
        # ����f�[�^���폜
        @branch.delete(@list[@index].indent)
        # �p��
        return true
      end
    end

    return command_111_KGC_Base_Rainforce
  end
#==============================================================================
# ���������� Interpreter 7 ����������
#==============================================================================
  #--------------------------------------------------------------------------
  # �� �X�N���v�g
  #--------------------------------------------------------------------------
  def command_355
    # script �� 1 �s�ڂ�ݒ�
    script = @list[@index].parameters[0] + "\n"
    # ���[�v
    loop {
      # ���̃C�x���g�R�}���h���X�N���v�g 2 �s�ڈȍ~�̏ꍇ
      if @list[@index+1].code == 655
        # script �� 2 �s�ڈȍ~��ǉ�
        script += @list[@index+1].parameters[0] + "\n"
      # �C�x���g�R�}���h���X�N���v�g 2 �s�ڈȍ~�ł͂Ȃ��ꍇ
      else
        # ���[�v���f
        break
      end
      # �C���f�b�N�X��i�߂�
      @index += 1
    }
    # �]��
    result = eval(script)
    # �p��
    return true
  end
end

#������������������������������������������������������������������������������

class Scene_Battle
#==============================================================================
# ���������� Scene_Battle 1 ����������
#==============================================================================
  #--------------------------------------------------------------------------
  # �� ���C������
  #--------------------------------------------------------------------------
  if KGC::BR_BATTLE_START_TRANSITION != nil
  def main
    # �g�����W�V�������s
    Graphics.transition(40,
      "Graphics/Transitions/" + KGC::BR_BATTLE_START_TRANSITION)
    # �g�����W�V��������
    Graphics.freeze
    # �퓬�p�̊e��ꎞ�f�[�^��������
    $game_temp.in_battle = true
    $game_temp.battle_turn = 0
    $game_temp.battle_event_flags.clear
    $game_temp.battle_abort = false
    $game_temp.battle_main_phase = false
    $game_temp.battleback_name = $game_map.battleback_name
    $game_temp.forcing_battler = nil
    # �o�g���C�x���g�p�C���^�v���^��������
    $game_system.battle_interpreter.setup(nil, 0)
    # �g���[�v������
    @troop_id = $game_temp.battle_troop_id
    $game_troop.setup(@troop_id)
    # �A�N�^�[�R�}���h�E�B���h�E���쐬
    
    
#    @actor_command_window = Window_Battle_Command.new
#    s1 = $data_system.words.attack
#    s2 = $data_system.words.skill
#    s3 = $data_system.words.guard
#    s4 = $data_system.words.item
#    @actor_command_window = Window_Command.new(160, [s1, s2, s3, s4])
#    @actor_command_window.y = 160
#    @actor_command_window.back_opacity = 160
#    @actor_command_window.active = false
#    @actor_command_window.visible = false
    # ���̑��̃E�B���h�E���쐬
#    @party_command_window = Window_PartyCommand.new
    @help_window = Window_Help.new
    @help_window.back_opacity = 160
    @help_window.visible = false
    @status_window = Window_BattleStatus.new
    @message_window = Window_Message.new
    # ���z�[���h
    @hold = Game_BattlerHold.new
    # ���o�g���Î~�t���O
    @pause = false
    @helphide = false
    @window_flag = false
    #���[�h�E�_���[�W�Ɋւ���^�[������
    # ���A�����ē����X�L�����g���Ă����
    $repeat_skill_num = 0
    $game_switches[9] = false
    # ������ǂݏo���̃t���O���Z�b�g
    $msg.callsign = 99
    $msg.talk_step = 0
    $msg.tag = ""
    $game_switches[77] = false #�Ⓒ�t���O�X�C�b�`
    $game_switches[78] = false #�ǌ��t���O�X�C�b�`
    $game_switches[79] = false #�g�[�N�t���O�X�C�b�`
    $game_switches[82] = false #�ł炵�t���O�X�C�b�`
    @hold_shake = nil #�z�[���h�������̃V�F�C�N����
    # ����_�˂��֘A�̃��Z�b�g
    $weak_number = 0 #��_�˂������i��
    $weak_result = 0 #��_�˂����s��������
    $game_temp.error_message = ""
    #���b�Z�[�W�\�����x��ݒ�
    case $game_system.system_battle_speed
    when 0
      $game_switches[9] = false
      $game_variables[45] = 16
      $game_variables[46] = 4
      $game_variables[47] = 30
    when 1
      $game_switches[9] = true
      $game_variables[45] = 8
      $game_variables[46] = 2
      $game_variables[47] = 48
    when 2
      $game_switches[9] = true
      $game_variables[45] = 4
      $game_variables[46] = 1
      $game_variables[47] = 32
    when 3
      $game_switches[9] = true
      $game_variables[45] = 16
      $game_variables[46] = 1
      $game_variables[47] = 16
    else
      $game_switches[9] = false
      $game_variables[45] = 16
      $game_variables[46] = 1
      $game_variables[47] = 32
    end
    # �S�o�g���[�̃��Z�b�g
    for enemy in $game_troop.enemies
      enemy.state_runk = [0, 0, 0, 0, 0, 0]
      enemy.ecstasy_count = []
      enemy.crisis_flag = false
      enemy.hold_reset
      enemy.ecstasy_turn = 0
      enemy.sp_down_flag = false
      enemy.talk_weak_check = []
      # �S�o�g���[�̃X�e�[�g���O�����ׂăN���A
      enemy.add_states_log.clear
      enemy.remove_states_log.clear
      #�x�b�h�C�����A�󕠏P�����͍ŏ������_�`�F�b�N��true�ɂ���
      if $game_switches[85] == true or $game_switches[86] == true
        enemy.checking = 1
      else
        enemy.checking = 0
      end
    end
    for actor in $game_party.party_actors
      actor.state_runk = [0, 0, 0, 0, 0, 0]
      actor.ecstasy_count = []
      actor.crisis_flag = false
      actor.skill_collect = nil
      actor.hold_reset
      actor.lub_male = 0
      actor.lub_female = 0
      actor.lub_anal = 0
      actor.ecstasy_turn = 0
      actor.sp_down_flag = false
      actor.talk_weak_check = []
      #�J���x�G���[�΍�
      actor.used_mouth = 0 if actor.used_mouth == nil
      actor.used_anal = 0 if actor.used_anal == nil
      actor.used_sadism = 0 if actor.used_sadism == nil
      # �S�o�g���[�̃X�e�[�g���O�����ׂăN���A
      actor.add_states_log.clear
      actor.remove_states_log.clear
      #�x�b�h�C�����A�󕠏P�����͍ŏ������_�`�F�b�N��true�ɂ���
      if $game_switches[85] == true or $game_switches[86] == true
        actor.checking = 1
      else
        actor.checking = 0
      end
    end
    # ���S�o�g���[���̋L�^
    battlers_record
    # �������[�h��������
    $mood = Mood_System.new
    # ���C���Z���X��������
    $incense = Incense_System.new
    
    #�o�g�����O��\������E�B���h�E���쐬 ��
    @battle_log_window = Window_BattleLog.new
    @battle_log_window.visible = false
    
    # ���o�g���Î~�p�X�v���C�g�쐬
#    @stasis = Sprite.new
#    @stasis.bitmap = RPG::Cache.windowskin("battle_stasis")
#    @stasis.visible = false
#    @stasis.z = 10000

    # �X�v���C�g�Z�b�g���쐬
    @spriteset = Spriteset_Battle.new
    # �E�F�C�g�J�E���g��������
    @wait_count = 0
    # �g�����W�V�������s
    if $data_system.battle_transition == ""
      Graphics.transition(20)
    else
      Graphics.transition(40, "Graphics/Transitions/" +
        $data_system.battle_transition)
    end
    # �v���o�g���t�F�[�Y�J�n
    start_phase1
    # ���C�����[�v
    loop {
      Graphics.update
      Input.update
      update
      break if $scene != self
    }
    # �}�b�v�����t���b�V��
    $game_map.refresh
    # �g�����W�V��������
    Graphics.freeze
    # �E�B���h�E�����
    @actor_command_window.dispose if @actor_command_window != nil
    @party_command_window.dispose
    @help_window.dispose
    @status_window.dispose
    @message_window.dispose
    @skill_window.dispose if @skill_window != nil
    @item_window.dispose if @item_window != nil
    @result_window.dispose if @result_window != nil
    @battle_log_window.dispose if @battle_log_window != nil # ��
    # �X�v���C�g�Z�b�g�����
    @spriteset.dispose
    # �������[�h���J��
    $mood.dispose
    # �^�C�g����ʂɐ؂�ւ����̏ꍇ
    if $scene.is_a?(Scene_Title)
      # ��ʂ��t�F�[�h�A�E�g
      Graphics.transition
      Graphics.freeze
    end
    # �퓬�e�X�g����Q�[���I�[�o�[��ʈȊO�ɐ؂�ւ����̏ꍇ
    if $BTEST && !$scene.is_a?(Scene_Gameover)
      $scene = nil
    end
  end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    # ��F6�L�[�ŏ��Ăяo��
    if Input.trigger?(Input::F6) and $DEBUG
      
      message = ""
      message += "����̏��\n"
      message += "���[�h : #{$mood.point}\n"
        message += "���b�Z�[�W���x : #{$game_system.system_battle_speed}\n"
        message += "���b�Z�[�W���[�h : #{$game_system.system_read_mode}\n"
        message += "�X�L�b�v���[�h : #{$game_system.ms_skip_mode}\n"
      print message 
      
      
      
      $game_party.party_actors.each_with_index { |actor, index|
        message  = "actor [#{index + 1} / #{$game_party.party_actors.size}]\n"
        message += "name : #{actor.name}\n"
        message += "EP : #{actor.hp} / #{actor.maxhp}\n"
        message += "VP : #{actor.sp} / #{actor.maxsp}\n"
        message += "class : #{actor.race_name} #{actor.race_color}\n"
        message += "states : [#{actor.states.join(',')}]\n"
        message += "personality : [#{actor.personality}]\n"
        message += "battler_name : \"#{actor.battler_name}\"\n"
        message += "�����x�� : \"#{actor.lub_male}\"\n" if actor.have_ability?("�j") or actor.have_ability?("������L")
        message += "�����x�� : \"#{actor.lub_female}\"\n" if actor.have_ability?("��")
        message += "�����x�` : \"#{actor.lub_anal}\"\n" if $game_variables[40] > 0
        message += "�\�͕ω��x : \"#{actor.state_runk}\"\n"
        if actor.rankup_flag == true and actor.rankup_flag != nil
          message += "�����N�A�b�v�o�� : ����\n" 
        end
        message += "�Ⓒ�� : \"#{actor.ecstasy_count.size}\"\n"
        message += "Hold/�y�j�X : \"#{actor.hold.penis.type}\"\n" if actor.hold.penis.battler != nil
        message += "Hold/�A�\�R : \"#{actor.hold.vagina.type}\"\n" if actor.hold.vagina.battler != nil
        message += "Hold/�� : \"#{actor.hold.mouth.type}\"\n" if actor.hold.mouth.battler != nil
        message += "Hold/�A�i�� : \"#{actor.hold.anal.type}\"\n" if actor.hold.anal.battler != nil
        message += "Hold/�㔼�g : \"#{actor.hold.tops.type}\"\n" if actor.hold.tops.battler != nil
        message += "Hold/�K�� : \"#{actor.hold.tail.type}\"\n" if actor.hold.tail.battler != nil
        message += "Hold/�G�� : \"#{actor.hold.tentacle.type}\"\n" if actor.hold.tentacle.battler != nil
        message += "Hold/�f�B���h : \"#{actor.hold.dildo.type}\"\n" if actor.hold.dildo.battler != nil
        message += "Hold�C�j�V�A�`�u : \"#{actor.initiative_level}\"\n"
       
        print message
      }
      $game_troop.enemies.each_with_index { |enemy, index|
        message  = "enemy [#{index + 1} / #{$game_troop.enemies.size}]\n"
        message += "name : #{enemy.name}\n"
        message += "Lv : #{enemy.level}\n"
        message += "EP : #{enemy.hp} / #{enemy.maxhp}\n"
        message += "VP : #{enemy.sp} / #{enemy.maxsp}\n"
        message += "���� : #{enemy.atk}\n"
        message += "�E�ϗ� : #{enemy.pdef}\n"
        message += "���� : #{enemy.str}\n"
        message += "��p�� : #{enemy.dex}\n"
        message += "�f���� : #{enemy.agi}\n"
        message += "���_�� : #{enemy.int}\n"
        message += "�擾�o���l : #{enemy.exp}\n"
        message += "�擾���z : #{enemy.gold}\n"
        message += "�h���b�v : \n"
        for treasure in enemy.treasure
          case treasure[0]
          when 0
            message += "�@#{$data_items[treasure[1]].name} #{treasure[2]}��\n"  
          when 1
            message += "�@#{$data_weapons[treasure[1]].name} #{treasure[2]}��\n"  
          when 2
            message += "�@#{$data_armors[treasure[1]].name} #{treasure[2]}��\n"  
          end
        end
        #{enemy.treasure}\n"
        message += "class : #{enemy.race_name} #{enemy.race_color}\n"
        message += "states : [#{enemy.states.join(',')}]\n"
        message += "personality : [#{enemy.personality}]\n"
        message += "battler_name : \"#{enemy.battler_name}\"\n"
        message += "�F�D�x : \"#{enemy.love}\"\n"
        message += "�D���x : \"#{enemy.friendly}\"\n"
        message += "�����x�� : \"#{enemy.lub_male}\"\n" if enemy.have_ability?("������L")
        message += "�����x�� : \"#{enemy.lub_female}\"\n" if enemy.have_ability?("��")
        message += "�����x�` : \"#{enemy.lub_anal}\"\n" if $game_variables[40] > 0
        message += "�\�͕ω��x : \"#{enemy.state_runk}\"\n"
        if enemy.rankup_flag == true and enemy.rankup_flag != nil
          message += "�����N�A�b�v�o�� : ����\n" 
        end
        message += "�Ⓒ�� : \"#{enemy.ecstasy_count.size}\"\n"
        message += "Hold/�y�j�X : \"#{enemy.hold.penis.type}\"\n" if enemy.hold.penis.battler != nil
        message += "Hold/�A�\�R : \"#{enemy.hold.vagina.type}\"\n" if enemy.hold.vagina.battler != nil
        message += "Hold/�� : \"#{enemy.hold.mouth.type}\"\n" if enemy.hold.mouth.battler != nil
        message += "Hold/�A�i�� : \"#{enemy.hold.anal.type}\"\n" if enemy.hold.anal.battler != nil
        message += "Hold/�㔼�g : \"#{enemy.hold.tops.type}\"\n" if enemy.hold.tops.battler != nil
        message += "Hold/�K�� : \"#{enemy.hold.tail.type}\"\n" if enemy.hold.tail.battler != nil
        message += "Hold/�G�� : \"#{enemy.hold.tentacle.type}\"\n" if enemy.hold.tentacle.battler != nil
        message += "Hold/�f�B���h : \"#{enemy.hold.dildo.type}\"\n" if enemy.hold.dildo.battler != nil
        message += "�y�ޏꒆ�z\"\n" unless enemy.exist?
        message += "���́F\"#{enemy.nickname_self}\"\n"
        message += "���́F\"#{enemy.nickname_master}\"\n"
        print message
      }
    end
    # �|�[�Y�Ɋւ���X�V
    pause_update
    # �|�[�Y�ɕԂ���������Input�������̂܂܈����p�����Ȃ����߁A��x�Ԃ�
    if @pause_return_flag
      @pause_return_flag = false
      return
    end
    # �|�[�Y���͂����ŕԂ�
    if @pause
      return
    end
    
    # ���c�L�[�ŕ��͂���������(����)
#    if Input.trigger?(Input::Z)
#      if $game_switches[9]
#        case $game_variables[50]
#        when 1
#          $game_variables[50] += 1
#          Audio.se_play("Audio/SE/046-Book01", 90, 110)
#        when 2
#          $game_variables[50] += 1
#          Audio.se_play("Audio/SE/046-Book01", 90, 120)
#        when 3
#          $game_variables[50] += 1
#          Audio.se_play("Audio/SE/046-Book01", 90, 130)
#        when 4
#          $game_variables[50] = 0
#          $game_switches[9] = false
#        Audio.se_play("Audio/SE/046-Book01", 90, 100)
#        make_message_speed
#        @ms_speed.visible = true
#        end
#      else
#        $game_switches[9] = true
#        $game_variables[50] += 1
#        Audio.se_play("Audio/SE/046-Book01", 90, 100)
#        make_message_speed
#        @ms_speed.visible = false
#      end
#    end
    #���p�L�[(�k�{�^��)�Ń��b�Z�[�W���[�h�ύX
    if Input.trigger?(Input::L) and (@window_flag == true or @phase == 4)
      if $game_system.system_read_mode >= 2
        $game_system.system_read_mode = 0
      else
        $game_system.system_read_mode += 1
      end
      if @msg_mode != nil
        if @msg_mode.bitmap != nil
          @msg_mode.bitmap.dispose
        end
      end
      @msg_mode = Sprite.new
      @msg_mode.opacity = 255
      #�����[�h���Ƃɉ摜�\���ƃX�C�b�`���O
      case $game_system.system_read_mode
      #�蓮���[�h
      when 0
        @msg_mode.bitmap = RPG::Cache.picture("ms_mode_0")
        $game_switches[9] = false
      #���������[�h(�W��)
      when 1
        @msg_mode.bitmap = RPG::Cache.picture("ms_mode_1")
        $game_switches[9] = false
      #�������[�h
      when 2
        @msg_mode.bitmap = RPG::Cache.picture("ms_mode_2")
        $game_switches[9] = true
      end
      Audio.se_play("Audio/SE/AC_Book2", 90, 100)
    end
    if @msg_mode != nil
      @msg_mode.opacity -= 3 if @msg_mode.opacity > 0
      @msg_mode.opacity -= 4 if @msg_mode.opacity < 200 and @msg_mode.opacity > 0
    end
    #45���I�[�g���b�Z�[�WID�A46�����b�Z�[�W�E�F�C�g�A47���o�g���E�F�C�g�ɂȂ�
    if Input.trigger?(Input::R) and (@window_flag == true or @phase == 4)
      if $game_system.system_battle_speed >= 2
        $game_system.system_battle_speed = 0
      else
        $game_system.system_battle_speed += 1
      end
      if @msg_speed != nil
        if @msg_speed.bitmap != nil
          @msg_speed.bitmap.dispose
        end
      end
      @msg_speed = Sprite.new
      @msg_speed.opacity = 255
      #�ϐ�45�F�V�X�e���E�F�C�g(�t�F�C�Y�̍��Ԃ̃E�F�C�g)
      #�ϐ�46�F���b�Z�[�W�E�F�C�g(\m��\w�̊�l)
      #�ϐ�47�F�I�[�g���[�h���x(�e���b�v���̂ݗL��)
      case $game_system.system_battle_speed
      when 0
#        $game_variables[45] = 60
#        $game_variables[46] = 5
#        $game_variables[47] = 60
        @msg_speed.bitmap = RPG::Cache.picture("ms_speed_0")
      when 1
#        $game_variables[45] = 30
#        $game_variables[46] = 3
#        $game_variables[47] = 40
        @msg_speed.bitmap = RPG::Cache.picture("ms_speed_1")
      when 2
#        $game_variables[45] = 16
#        $game_variables[46] = 1
#        $game_variables[47] = 28
        @msg_speed.bitmap = RPG::Cache.picture("ms_speed_2")
      end
      Audio.se_play("Audio/SE/AC_Book2", 90, 100)
    end
    if @msg_speed != nil
      @msg_speed.opacity -= 3 if @msg_speed.opacity > 0
      @msg_speed.opacity -= 4 if @msg_speed.opacity < 200 and @msg_speed.opacity > 0
    end
    
    # �o�g���C�x���g���s���̏ꍇ
    if $game_system.battle_interpreter.running?
      @running = true
      # �C���^�v���^���X�V
      $game_system.battle_interpreter.update
      # �A�N�V��������������Ă���o�g���[�����݂��Ȃ��ꍇ
      if $game_temp.forcing_battler == nil
        # �o�g���C�x���g�̎��s���I������ꍇ
        unless $game_system.battle_interpreter.running?
          if @phase != 6
            # �퓬�p���̏ꍇ�A�o�g���C�x���g�̃Z�b�g�A�b�v���Ď��s
            unless judge
              setup_battle_event
            end
          end
        end
        # �A�t�^�[�o�g���t�F�[�Y�łȂ��A���b�Z�[�W���\������Ă��Ȃ�
        # ���A�j���\�����ł͂Ȃ��ꍇ
        if @phase != 5 && !@message_window.visible && !@spriteset.effect?
          # �X�e�[�^�X�E�B���h�E�����t���b�V��
          @status_window.refresh
        end
      end
    elsif @running
      # �X�e�[�^�X�E�B���h�E�����t���b�V��
      @status_window.refresh
      @running = false
    end
    
    # �V�X�e�� (�^�C�}�[)�A��ʂ��X�V
    $game_system.update
    $game_screen.update
    # �^�C�}�[�� 0 �ɂȂ����ꍇ
    if $game_system.timer_working && $game_system.timer == 0
      # �o�g�����f
      $game_temp.battle_abort = true
    end
    # �E�B���h�E���X�V
    @battle_log_window.update #��
    @help_window.update
#    @party_command_window.update

    if @actor_command_window != nil and @phase == 3
      @actor_command_window.update 
    end

    @status_window.update
    @message_window.update

    if @phase != 6
      # �X�v���C�g�Z�b�g���X�V
      @spriteset.update
    end
    
    # ���S�o�g���[���̋L�^
    battlers_record
    
    #--���W�X�g�Q�[�����Ăяo���ꂽ�ꍇ��---------------------------
    if $game_temp.resistgame_flag == 1
      if @active_battler.is_a?(Game_Enemy)
        type = 0
      else
        if $game_switches[79]
          type = 0
        else
          type = 1
        end
      end
      #�Ă΂��x��new�ŏ���������(������ʂŕ�������s���鎖������̂�)
      if $game_switches[79] == true
        if $game_temp.talk_resist_flag_log[/\\T/] != nil
          @resistgame = Resist_Game.new($game_temp.resistgame_difficulty, type, $game_system.system_regist)
          $game_temp.resistgame_swicth = true
          $game_temp.resistgame_flag = 2
        end
      else
        @resistgame = Resist_Game.new($game_temp.resistgame_difficulty, type, $game_system.system_regist)
        $game_temp.resistgame_swicth = true
        $game_temp.resistgame_flag = 2
      end
      $game_system.menu_disabled = true
    elsif $game_temp.resistgame_flag >= 2
      if $game_temp.talk_resist_flag_log != ""
        if $game_temp.talk_resist_flag_log[/\\T/] != nil
          if $msg.resist_flag == true
            #�Q�[�����Ă�(�߂�l�������:true ���s:false)
            @resistgame.game_start
            return
          end
        else
          #�Q�[�����Ă�(�߂�l�������:true ���s:false)
          @resistgame.game_start
          return
        end
      else
        #�Q�[�����Ă�(�߂�l�������:true ���s:false)
        @resistgame.game_start
        return
      end
      
    elsif $game_temp.resistgame_flag < 0 #�I��鎞�Aflag�ɂ́u-1�v������
      
      #�Q�[�����J�����ďI���
      @resistgame.dispose
      $game_temp.resistgame_swicth = false
      $game_temp.resistgame_flag = 0
      $game_system.menu_disabled = false
      $msg.resist_flag = false
      #
#      @wait_count = 20
      @battle_log_window.contents.clear

      
      # �o�g�����O���N���A
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
    end
    #-----------------------------------------------------------------------
    # ���R�����C�x���g������o�g�����O�E�B���h�E�������ꍇ�̏���
    #   ��Ƀg�[�N�����p
    if $msg.battlelogwindow_dispose == true
      # �o�g�����O���N���A
      @battle_log_window.contents.clear
      @battle_log_window.keep_flag = false
      $game_temp.battle_log_text = ""
      #�t���O���~�낷
      $msg.battlelogwindow_dispose = false
    end
    #-----------------------------------------------------------------------
    # ���R�����C�x���g������X�e�[�^�X�E�B���h�E���X�V����ꍇ�̏���
    #   ��Ƀg�[�N�����p
    if $msg.stateswindow_refresh == true
      #�X�e�[�^�X�E�B���h�E���X�V
      @status_window.refresh
      #�t���O���~�낷
      $msg.stateswindow_refresh = false
    end
    #-----------------------------------------------------------------------
    # ���R�����C�x���g������z�[���h�󋵂��X�L���ȊO�ōX�V����ꍇ�̏���
    #   ��Ƀg�[�N�����p
    if $msg.hold_initiative_refresh.size >= 2
      # �z�[���h�C�j�V�A�`�u�̍X�V�w��
      #hold_initiative(@skill, $msg.hold_initiative_refresh[0], $msg.hold_initiative_refresh[1])
      hold_initiative_down($msg.hold_initiative_refresh[1])
      # �z�[���h�|�b�v
      hold_pops_order
      #�t���O���~�낷
      #$game_temp.skill_selection
      $msg.hold_initiative_refresh = []
    end
    #-----------------------------------------------------------------------
    # ���R�����C�x���g������z�[���h�C�j�V�A�`�u���X�V����ꍇ�̏���
    #   ��Ƀg�[�N�����p
    if $msg.hold_pops_refresh == true
      # �z�[���h�|�b�v�̎w��
      hold_pops_order
      #�t���O���~�낷
      $msg.hold_pops_refresh = false
    end
    #-----------------------------------------------------------------------
    # ���R�����C�x���g������X�L���E�B���h�E���̂��X�V����ꍇ�̏���
    #   ��Ƀg�[�N�����p
    if $msg.skillwindow_change != nil
      #�X�L�����\���̃w���v�E�B���h�E���o�Ă��鎞�̂ݓK�p
      if @help_window.window.visible == true
        #���̂�close�̏ꍇ�A�w���v�E�B���h�E����������
        if $msg.skillwindow_change == "close"
          @help_window.window.visible = false
          @help_window.set_text("")
        else
          # �w���v�E�B���h�E�ɕύX��̖��̂�\��
          @help_window.set_text($msg.skillwindow_change, 1)
        end
      end
      #�t���O���~�낷
      $msg.skillwindow_change = nil
    end
    #-----------------------------------------------------------------------

    # �g�����W�V�����������̏ꍇ
    if $game_temp.transition_processing
      # �g�����W�V�����������t���O���N���A
      $game_temp.transition_processing = false
      # �g�����W�V�������s
      if $game_temp.transition_name == ""
        Graphics.transition(20)
      else
        Graphics.transition(40, "Graphics/Transitions/" +
          $game_temp.transition_name)
      end
    end
    # �������[�h���X�V
    $mood.update
    # ���b�Z�[�W�E�B���h�E�\�����̏ꍇ
    if $game_temp.message_window_showing
      return
    end
    
    # �G�t�F�N�g�\�����̏ꍇ
    if @spriteset.effect?
      return
    end
    # �Q�[���I�[�o�[�̏ꍇ
    if $game_temp.gameover
      # �Q�[���I�[�o�[��ʂɐ؂�ւ�
      $scene = Scene_Gameover.new
      return
    end
    # �^�C�g����ʂɖ߂��ꍇ
    if $game_temp.to_title
      # �^�C�g����ʂɐ؂�ւ�
      $scene = Scene_Title.new
      return
    end
    # �o�g�����f�̏ꍇ
    if $game_temp.battle_abort
      # �o�g���J�n�O�� BGM �ɖ߂�
      $game_system.bgm_play($game_temp.map_bgm)
      # �o�g���I��
      battle_end(1)
      return
    end
    
    # ���o�g�����O���E�F�C�g���Ă���ꍇ�A�A�����ăE�F�C�g����B
    if @battle_log_window.wait_count > 0 and $game_temp.battle_log_wait_flag == true
      @wait_count += @battle_log_window.wait_count
      $game_temp.battle_log_wait_flag = false
    end
    # �E�F�C�g���̏ꍇ
    if @wait_count > 0
      # �E�F�C�g�J�E���g�����炷
      @wait_count -= 1
      return
    end
    
    # �G�l�~�[�̕\�����E�F�C�g��ɗ\�񂵂Ă���ꍇ�A�\��������
    if @display_order_enemy != nil
      enemies_display(@display_order_enemy)
      @display_order_enemy = nil
    end
    
    
    # �A�N�V��������������Ă���o�g���[�����݂����A
    # ���o�g���C�x���g�����s���̏ꍇ
    if $game_temp.forcing_battler == nil &&
       $game_system.battle_interpreter.running?
      return
    end
    
    # ����t�F�C�Y������ꍇ�͂������D��
    if @go_appear_effect_step
      appear_effect_step
      return
    end
    if @go_dead_effect_step
      dead_effect_step
      return
    end
    # �t�F�[�Y�ɂ���ĕ���
    case @phase
    when 0  # �X�^�[�g�t�F�[�Y
      update_phase0
    when 1  # �v���o�g���t�F�[�Y
      update_phase1
    when 2  # �p�[�e�B�R�}���h�t�F�[�Y
      update_phase2
    when 3  # �A�N�^�[�R�}���h�t�F�[�Y
      update_phase3
    when 4  # ���C���t�F�[�Y
      update_phase4
    when 5  # �A�t�^�[�o�g���t�F�[�Y
      update_phase5
    when 6  # �_��t�F�[�Y
      update_phase6
    end
  end
  #--------------------------------------------------------------------------
  # �� �o�g���I��
  #     result : ���� (0:���� 1:���� 2:�s�k)
  #--------------------------------------------------------------------------
  alias battle_end_KGC_Base battle_end
  def battle_end(result)
    #���C���Z���X������
    $incense = nil
    # �I�[�g�X�e�[�g���X�V
    for actor in $game_party.actors
      for i in 1...($imported["EquipExtension"] ? actor.equip_type.size : 5)
        actor.update_auto_state(nil, $data_armors[
          $imported["EquipExtension"] ? actor.armor_id[i] :
          eval("actor.armor#{i}_id")])
      end
    end

    battle_end_KGC_Base(result)
  end
end