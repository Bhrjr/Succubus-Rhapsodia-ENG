#==============================================================================
# �� Scene_Battle (���̑�)
#==============================================================================

class Scene_Battle  

  #--------------------------------------------------------------------------
  # �� �G�l�~�[�̕\����Ԃ̕ύX
  #--------------------------------------------------------------------------
  def enemies_display(active_enemy)
    return unless active_enemy.exist?
    
    # �S�G�l�~�[���m�F���A�A�N�e�B�u�G�l�~�[�݂̂�\������B
    for enemy in $game_troop.enemies
      if enemy == active_enemy
        enemy.display = true
      else
        enemy.display = false
      end
    end
    # �A�N�e�B�u�G�l�~�[���{�X�摜�ł͂Ȃ��ꍇ�A�{�X�ȊO�̃G�l�~�[�����ׂĕ\���B
    unless active_enemy.boss_graphic?
      for enemy in $game_troop.enemies
        unless enemy.boss_graphic?
          enemy.display = true
        end
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �G�l�~�[�s�������p
  #--------------------------------------------------------------------------
  def enemy_action_swicthes(enemy = @active_battler)
    # �G�l�~�[���g�̏��
    $game_switches[101] = !enemy.full_nude?
    $game_switches[103] = enemy.full_nude?
    $game_switches[104] = !enemy.crisis?
    $game_switches[105] = enemy.crisis?
    $game_switches[106] = enemy.holding?
    # ���g�̂g�o������ x �ȏ�
    $game_switches[109] = (enemy.hpp >= 100)
    $game_switches[110] = (enemy.hpp >= 80)
    $game_switches[111] = (enemy.hpp >= 50)
    $game_switches[112] = (enemy.hpp >= 20)
    # ���g�̏����x�� x �ȏ�
    $game_switches[114] = (enemy.lub_female >= 90)
    $game_switches[115] = (enemy.lub_female >= 60)
    $game_switches[116] = (enemy.lub_female >= 30)
    # ���g�̃X�e�[�g���
    $game_switches[121] = enemy.state?(98) # ���@�w
    # �G�l�~�[�����������
    $game_switches[144] = ($game_temp.first_attack_flag == 2)
    # �G�l�~�[����������
    $game_switches[143] = enemy.can_struggle?
    # �G�l�~�[���{�C�}�����
    $game_switches[142] = enemy.earnest and enemy.vagina_insert?
    
    # �G�l�~�[�g���[�v�̏��
    ex = tk = nd = 0
    hd = []
    tp = []
    enemys_state_runk_total = 0
    for enemy_one in $game_troop.enemies
      if enemy_one.exist?
        ex += 1
        if enemy_one.talkable?
          tk += 1
        end
        unless enemy_one.full_nude?
          nd += 1
        end
        if enemy_one.holding? and enemy_one != enemy
          hd.push(enemy_one)
        end
        if $data_SDB[enemy_one.class_id].name == $data_SDB[enemy.class_id].name
          tp.push(enemy_one)
        end
        for i in enemy_one.state_runk
          enemys_state_runk_total += i
        end
      end
    end
    $game_switches[126] = (nd > 0)
    $game_switches[127] = (nd == 0)

    $game_switches[131] = (hd.size > 0)
    $game_switches[132] = (ex = 1)
    $game_switches[133] = (ex > 1)
    $game_switches[134] = (tk > 1)
    $game_switches[135] = (tp.size > 1)
    $game_switches[136] = enemy.dancing?
    
    actors_state_runk_total = 0
    # �A�N�^�[�̏��
    for actor_one in $game_party.battle_actors
      if actor_one.exist?
        for i in actor_one.state_runk
          actors_state_runk_total += i
        end
      end
    end
    
    
    
    #--------------------------------------------------------------------------
    # �w�C�g�B��
    hate_result = false
    # �C�x���g�A�n�e�d�A�{�X���������Ă�����̂̂�
    if ($data_enemies[enemy.id].element_ranks[124] == 1 or
     $data_enemies[enemy.id].element_ranks[125] == 1 or 
     $data_enemies[enemy.id].element_ranks[126] == 1 or 
     $data_enemies[enemy.id].element_ranks[128] == 1)
      # �����F�w�C�g�J�E���g���U�܂ŗ��߂�
      hate_result = true if $game_temp.battle_hate_count >= 6
      # �����F�A�N�^�[�S���̋����l���G�l�~�[�S���̋����l���S�ȏ㍂��
      hate_result = true if actors_state_runk_total >= 4 + enemys_state_runk_total
    end
    # �����F�s�K���
    hate_result = true if $game_party.unlucky?
    # �m�肳����
    $game_switches[145] = hate_result
    #--------------------------------------------------------------------------
    # ������B��
    allowance_result = false
    # ���X�{�X�ȊO�̂�
    unless $data_enemies[enemy.id].element_ranks[128] == 1
      # �����F�w�C�g�J�E���g���}�C�i�X
      allowance_result = true if $game_temp.battle_hate_count < 0
      # �����F�G�l�~�[�S���̋����l���A�N�^�[�S���̋����l���S�ȏ㍂��
      allowance_result = true if enemys_state_runk_total >= 4 + actors_state_runk_total
      # �����F��l���̂u�o���P�^�S�ȉ����A�G�l�~�[�̂u�o���P�^�Q�ȏ�
      allowance_result = true if $game_actors[101].spp <= 25 and enemy.spp >= 50
    end
    # �m�肳����
    $game_switches[146] = allowance_result
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�g�Ȃǂ̃E�F�C�g�`�F�b�N
  #--------------------------------------------------------------------------
  def system_wait_make(text)
    result = 0
    if text != ""
      # �s���ɍ��킹�ăE�F�C�g������
      text_size = text.split(/[\n\]/).size
    else 
      text_size = 0
    end
    case $game_system.ms_skip_mode
    when 3 #�蓮���胂�[�h
      result = (4 * text_size)
    when 2 #�f�o�b�O���[�h
      result = 8
    when 1 #�������[�h
      result = 12
    else
      # �X�e�[�g�֌W�̓X�e�[�g�̐������E�F�C�g�����Z
      result = $game_system.battle_speed_time(0) + $game_system.important_wait_time + (4 * text_size)
    end
    return result
  end
  #--------------------------------------------------------------------------
  # �� �ȈՃ��[�h�̃��[�h�Ǘ�
  #    battler �F �s�����o�g���[
  #    skill   �F �s�����o�g���[�̎g�����X�L��
  #--------------------------------------------------------------------------
  def system_simplemode_moodcheck(battler)
    #�ȈՃ��[�h�Ŗ����ꍇ�͒ʏ폈���ɖ߂�
    return unless $game_system.system_message == 0
    up = false
    down = false
    #���W�X�g����
    if @resist_flag == true
      if battler.is_a?(Game_Actor)
        case $msg.tag
        when "��l����������E��","�p�[�g�i�[��������E��"
          up = true
        when "��l�����������z�[���h","�p�[�g�i�[���������z�[���h"
          if $msg.at_type == "�����z�[���h����" or $msg.at_type == "���ԃz�[���h����"
            down = true
          else
            up = true
          end
        end
      else
        case $msg.tag
        when "��������l����E��","�������p�[�g�i�[��E��"
          down = true
        when "��������l�����z�[���h","�������p�[�g�i�[���z�[���h"
          down = true
       end
      end
    #���W�X�g���s
    elsif @resist_flag == false
      if battler.is_a?(Game_Actor)
        case $msg.tag
        when "��l����������E��","�p�[�g�i�[��������E��"
          down = true
        when "��l�����������z�[���h","�p�[�g�i�[���������z�[���h"
          if $msg.at_type == "�����z�[���h����" or $msg.at_type == "���ԃz�[���h����"
            up = true
          else
            down = true
          end
        end
      else
        case $msg.tag
        when "��������l����E��","�������p�[�g�i�[��E��"
          up = true
        when "��������l�����z�[���h","�������p�[�g�i�[���z�[���h"
          up = true
        end
      end
    #���̑�
    else
      case $msg.tag
      #��������E��
      when "����������E��","���������Ԗ�����E��"
        up = true
      when "��l��������E��","�p�[�g�i�[������E��"
        up = true
      when "��l�����p�[�g�i�[��E��","�p�[�g�i�[����l����E��"
        up = true
      end
    end
    #���[�h�̑������s��
    if up == true
      pt = 6 + rand(3) - rand(3)
      $mood.rise(pt)
      if $msg.t_enemy != nil
        $msg.t_enemy.like(2)
      end
    elsif down == true
      pt = -4 + rand(2) - rand(3)
      $mood.rise(pt)
    end
    #���W�X�g�t���O�𖳌�������
    @resist_flag = nil
  end
end