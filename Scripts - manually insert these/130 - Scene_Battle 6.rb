#==============================================================================
# �� Scene_Battle (������` 6)
#------------------------------------------------------------------------------
# �@�o�g����ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Battle
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (����s��)
  #--------------------------------------------------------------------------
  def update_phase4_step105
    # ������
    support_exist = false
    text = ""
    # �o�g�����O���N���A
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    # �g�p�Ώۂ��m�F
    actor_crisis_box = []
    actor_bad_state_box = []
    actor_status_down_box = []
    for actor_one in $game_party.battle_actors
      # �d�o�񔼕������̃A�N�^�[�i��l���̂݁j
      actor_crisis_box.push(actor_one) if actor_one.hpp < 60 and actor_one == $game_actors[101]
      # ��Ԉȏオ�Q�ȏ�̃A�N�^�[
      actor_bad_state_box.push(actor_one) if actor_one.bad_state_number >= 2
      n = 0
      # �㉻���R�ȏ�̃A�N�^�[
      for i in 0..5
        n += actor_one.state_runk[i] * -1 if actor_one.state_runk[i] < 0
      end
      actor_status_down_box.push(actor_one) if n >= 2
    end
    #--------------------------------------------------------------------------
    # ���[�~���L���X�g�̉���
    #--------------------------------------------------------------------------
    if $game_switches[401]
      # ���[�~���L���X�g�̖��O��ϐ��ɓ����
      supporter = $game_actors[122].name
      # �Q�̔{���̃^�[���ɖ��@���r��������B
      if $game_temp.battle_turn % 2 == 0
        # ��̂��̂قǗD��
        #--------------------------------------------------------------------------
        # ���R�̒N�����d�o�񔼕������̎��́A300���x�̉񕜂��s��
        #--------------------------------------------------------------------------
        if actor_crisis_box.size > 0
          # ��l����D��
          if actor_crisis_box.include?($game_actors[101])
            target = $game_actors[101]
          else 
            target = actor_crisis_box[0]
          end
          # ��
          heal = 350 + rand(10) - rand(10)
          target.hp += heal
          target.animation_id = 70
          target.animation_hit = true
          text += "#{supporter}�̓C���X�y�^�����r�������I" + "\w\q"
          text += "#{target.name}�̂d�o�� #{heal.to_s} �񕜂����I" + "\w\q"
          if target.hpp >= $mood.crisis_point(target) + rand(5)
            target.remove_state(6)
            target.crisis_flag = false
            text += target.bms_states_update
            target.remove_states_log.clear
            target.graphic_change = true
          end
        #--------------------------------------------------------------------------
        # �o�X�e���Q�ȏ�|�����Ă���ꍇ�͂���̉���
        #--------------------------------------------------------------------------
        elsif actor_bad_state_box.size > 0
          # ��l����D��
          if actor_bad_state_box.include?($game_actors[101])
            target = $game_actors[101]
          else 
            target = actor_bad_state_box[0]
          end
          target.animation_id = 73
          target.animation_hit = true
          text += "#{supporter}�̓g�����I�[�����r�������I" + "\w\q"
          for i in 34..40
            target.remove_state(i)
          end
          text += target.bms_states_update
          target.remove_states_log.clear
        #--------------------------------------------------------------------------
        # �㉻���v���R�ȏ�̏ꍇ�͂���̉���
        #--------------------------------------------------------------------------
        elsif actor_status_down_box.size > 0
          # ��l����D��
          if actor_status_down_box.include?($game_actors[101])
            target = $game_actors[101]
          else 
            target = actor_status_down_box[0]
          end
          target.animation_id = 74
          target.animation_hit = true
          text += "#{supporter}�̓C�[�U�J�[�����r�������I"
          # �C�[�U�J�[���̍��ڂ�ʂ�
          text += special_status_check(target,[221])
          target.add_states_log.clear
          target.remove_states_log.clear
        #--------------------------------------------------------------------------
        # �s���`�������ꍇ�͎��R�S�̂�100���x����
        #--------------------------------------------------------------------------
        else
          text += "#{supporter}�̓C���X�V�[�h�E�A���_���r�������I" + "\w\q"
          for actor_one in $game_party.battle_actors
            heal = 150 + rand(10) - rand(10)
            actor_one.hp += heal
            actor_one.animation_id = 69
            actor_one.animation_hit = true
            text += "#{actor_one.name}�̂d�o�� #{heal.to_s} �񕜂����I" + "\w\q"
            if actor_one.hpp >= $mood.crisis_point(actor_one) + rand(5)
              actor_one.remove_state(6)
              actor_one.crisis_flag = false
              text += actor_one.bms_states_update
              actor_one.remove_states_log.clear
              actor_one.graphic_change = true
            end
          end
        end
        # �e�L�X�g�ɒǉ�
        $game_temp.battle_log_text = text
        support_exist = true
      # �R�̔{���ȊO�̃^�[���͉r��
      else
        Audio.se_play("Audio/SE/087-Action02", 80, 100)
        $game_temp.battle_log_text = "#{supporter}�͉r�����Ă���I"
        support_exist = true
      end
    end
    # ���삪���������ꍇ�A�E�F�C�g��t����
    if support_exist
      # �X�e�[�^�X�̃��t���b�V��
      @status_window.refresh
      #���V�X�e���E�F�C�g
      if $game_temp.battle_log_text != ""
        @wait_count = system_wait_make($game_temp.battle_log_text)
      end
    end
    # �X�e�b�v 103 �Ɉڍs
    @phase4_step = 103
  end
  #--------------------------------------------------------------------------
  # �� �X�e�[�^�X�㏸�e�L�X�g���쐬
  #--------------------------------------------------------------------------
  def special_status_check(battler_one, skill_id_box = [])
    text = ""
    for i in skill_id_box
      battler_one.capacity_alteration_effect($data_skills[i]) 
      m = "#{battler_one.bms_states_update}"
      if m != "������#{battler_one.name}�ɂ͌��ʂ����������I"
        text += "\w\q" + m
      end
    end
    return text
  end
  #--------------------------------------------------------------------------
  # �� �C���Z���X����
  #--------------------------------------------------------------------------
  def incense_effect
    # �o�g���[���Ɍ��ʂ��������
    text = ""
    for battler_one in $game_party.battle_actors + $game_troop.enemies
      # �����b�N�X�^�C���͏���
      if $incense.exist?("�����b�N�X�^�C��", battler_one)
        battler_one.hp += battler_one.maxhp / 16
        if battler_one.hpp >= $mood.crisis_point(battler_one) + rand(5)
          battler_one.remove_state(6)
          battler_one.crisis_flag = false
          text += battler_one.bms_states_update
          battler_one.graphic_change = true
          battler_one.remove_states_log.clear
        end
        battler_one.animation_id = 51
        battler_one.animation_hit = true
      end
    end
    $game_temp.battle_log_text += text if text != ""
    $mood.rise(4) if $incense.exist?("���u�t���O�����X", 2)
    # �X�e�[�^�X�̃��t���b�V��
    @status_window.refresh
  end  
  #--------------------------------------------------------------------------
  # �� �C���Z���X����
  #--------------------------------------------------------------------------
  def incense_start_effect
    text = ""
    case @command.name
    when "�����b�N�X�^�C��"
      for target_one in @target_battlers
        heal_one = target_one.maxhp / 16
        target_one.hp += heal_one
        text += "#{target_one.name}�̂d�o�� #{heal_one.to_s} �񕜂����I" + "\w\q"
        if target_one.hpp >= $mood.crisis_point(target_one) + rand(5)
          target_one.remove_state(6)
          target_one.crisis_flag = false
          text += target_one.bms_states_update
          target_one.remove_states_log.clear
          target_one.graphic_change = true
        end
      end
    when "���u�t���O�����X"
      $mood.rise(4)
    end
    text = "\w\q" + text if text != ""
    return text
  end  
  #--------------------------------------------------------------------------
  # �� �X�^�����\�b�h
  #--------------------------------------------------------------------------
  def battler_stan(battler)
    @action_battlers.delete(battler)
  end
  #--------------------------------------------------------------------------
  # �� �o�����G�t�F�N�g�̎w��
  #--------------------------------------------------------------------------
  def appear_effect_order(battlers=[])
    @effect_order_battlers = []
    for battler_one in battlers.dup
      @effect_order_battlers.push(battler_one) if battler_one.exist?
    end
    @appear_effect_step_count = 0
    @go_appear_effect_step = true
  end  
  #--------------------------------------------------------------------------
  # �� �Ⓒ���G�t�F�N�g�̎w��
  #--------------------------------------------------------------------------
  def dead_effect_order(battlers=[])
    @effect_order_battlers = []
    for battler_one in battlers.dup
      @effect_order_battlers.push(battler_one) if battler_one.exist?
    end
    @dead_effect_step_count = 0
    @go_dead_effect_step = true
  end  
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (����F�o�����G�t�F�N�g)
  #--------------------------------------------------------------------------
  def appear_effect_step
    # ���͂̃��t���b�V��
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    # ���[�v�����t���O��������
    end_flag = false
    #----------------------------------------------------------------------
    # �f���m�F�̃��[�v���J�n
    while end_flag == false
      # �����ʂ�Ȃ������p�ɏI���t���O�𗧂Ă�B
      end_flag = true
      #----------------------------------------------------------------------
      # 0�F�f���y���g�z�Ɓy�����z
      # �퓬�Q�����ɍ��gor������ԂɂȂ�B
      #----------------------------------------------------------------------
      if @appear_effect_step_count == 0
        for battler in @effect_order_battlers
          text = ""
          # �y���g�z�������A�y�����z�������ꍇ�́y���g�z����
          if battler.have_ability?("���g") \
           and not battler.have_ability?("����")
            text += "\w\q" if $game_temp.battle_log_text != ""
            text += "#{battler.name}�͋������Ă���I"
            $game_temp.battle_log_text += text
            battler.animation_id = 123
            battler.animation_hit = true
            # ���̃o�g���[�����g��Ԃɂ���
            battler.add_state(41)
            battler.add_states_log.clear
          end
          text = ""
          # �y�����z�������A�y���g�z�������ꍇ�́y�����z����
          if battler.have_ability?("����") \
           and not battler.have_ability?("���g")
            text += "\w\q" if $game_temp.battle_log_text != ""
            text += "#{battler.name}�͗��������Ă���I"
            $game_temp.battle_log_text += text
            battler.animation_id = 124
            battler.animation_hit = true
            # ���̃o�g���[�𒾒���Ԃɂ���
            battler.add_state(42)
            battler.add_states_log.clear
          end
        end
        # �G�t�F�N�g���m�F�����̂Ń��[�v���I�������Ȃ�
        end_flag = false
      end
      #----------------------------------------------------------------------
      # 1�F�f���y�S�́z
      # ������Ԃŏ����x�������B
      #----------------------------------------------------------------------
      if @appear_effect_step_count == 1
        for battler in @effect_order_battlers
          if battler.have_ability?("�S��")
            # �j�܂��͗�����L�̏ꍇ�A���̏����������グ��
            if battler.boy? or battler.futanari?
              if battler.lub_male < 60
                battler.lub_male = 60
                battler.add_state(21)
              end
            end
            # ���i�܂��͗�����L�j�̏ꍇ�A���̏����������グ��
            if battler.girl? or battler.futanari?
              if battler.lub_female < 60
                battler.lub_female = 60
                battler.add_state(23)
              end
            end
            # ���ʂɊւ�炸�A�e���̏����������グ��
            if battler.lub_anal < 60
              battler.lub_anal = 60
              battler.add_state(23)
            end
            # �e�L�X�g�\�����Ȃ��̂ŃX�e�[�g���O���N���A
            battler.add_states_log = []
          end
        end
        # �G�t�F�N�g���m�F�����̂Ń��[�v���I�������Ȃ�
        end_flag = false
      end
      #----------------------------------------------------------------------
      # 2�F�f���y�T���`�F�b�N�z�i�����j
      # �o�����ɓG�S�����ؕ|��Ԃɂ���B
      #----------------------------------------------------------------------
      if @appear_effect_step_count == 2
        for battler in @effect_order_battlers
          text = ""
          if battler.have_ability?("�T���`�F�b�N") and battler.is_a?(Game_Actor)
            # �u�o������ł��邩
            go_flag = false
            go_flag = true if battler.sp > 100
            # �t���O�������Ă���Ώ������s��
            if go_flag
              # �R�X�g������
              battler.sp -= 100
              battler.animation_id = 190
              battler.animation_hit = true
              text += "\w\q" if $game_temp.battle_log_text != ""
              text += "#{battler.name}�͑�������|�ɋ�藧�Ă��I"
              if battler.is_a?(Game_Actor)
                for enemy in $game_troop.enemies
                  if enemy.exist?
                    enemy.add_state(38, false, true)
                    if enemy.add_states_log.include?($data_states[38])
                      enemy.animation_id = 80
                      enemy.animation_hit = true
                      text += "\w\q" + enemy.bms_states_update(battler)
                    end
                  end
                end
              end
              $game_temp.battle_log_text += text
            end
          end
        end
        # �G�t�F�N�g���m�F�����̂Ń��[�v���I�������Ȃ�
        end_flag = false
      end
      #----------------------------------------------------------------------
      # 3�F�f���y�T���`�F�b�N�z�i�G�j
      # �o�����ɓG�S�����ؕ|��Ԃɂ���B
      #----------------------------------------------------------------------
      if @appear_effect_step_count == 3
        for battler in @effect_order_battlers
          text = ""
          if battler.have_ability?("�T���`�F�b�N") and battler.is_a?(Game_Enemy)
            # �u�o������ł��邩
            go_flag = false
            go_flag = true if battler.sp > 100
            # �t���O�������Ă���Ώ������s��
            if go_flag
              # �R�X�g������
              battler.sp -= 100
              battler.animation_id = 190
              battler.animation_hit = true
              text += "\w\q" if $game_temp.battle_log_text != ""
              text += "#{battler.name}�͑�������|�ɋ�藧�Ă��I"
              if battler.is_a?(Game_Enemy)
                for actor in $game_party.battle_actors
                  if actor.exist?
                    actor.add_state(38, false, true)
                    if actor.add_states_log.include?($data_states[38])
                      actor.animation_id = 80
                      actor.animation_hit = true
                      text += "\w\q" + actor.bms_states_update(battler)
                    end
                  end
                end
              end
              $game_temp.battle_log_text += text
            end
          end
        end
        # �G�t�F�N�g���m�F�����̂Ń��[�v���I�������Ȃ�
        end_flag = false
      end
      #----------------------------------------------------------------------
      # 4�F�f���y�d��z
      # �o�����ɑ���S�����`�F�b�N��Ԃɂ���B
      #----------------------------------------------------------------------
      if @appear_effect_step_count == 4
        for battler in @effect_order_battlers
          text = ""
          if battler.have_ability?("�d��")
            if battler.is_a?(Game_Actor)
              for enemy in $game_troop.enemies
                if enemy.exist? and enemy.checking < 1
                  enemy.checking = 1
                end
              end
            elsif battler.is_a?(Game_Enemy)
              for actor in $game_party.battle_actors
                if actor.exist? and actor.checking < 1
                  actor.checking = 1
                end
              end
            end
          end
        end
        # �G�t�F�N�g���m�F�����̂Ń��[�v���I�������Ȃ�
        end_flag = false
      end
      #----------------------------------------------------------------------
      # 5�F�C���Z���X�u���b�h�J�[�y�b�g�v
      # �o�����ɖ��͂Ƒf��������������B
      #----------------------------------------------------------------------
      if @appear_effect_step_count == 5
        for battler in @effect_order_battlers
          text = ""
          if $incense.exist?("���b�h�J�[�y�b�g", battler)
            text += "\w\q" if $game_temp.battle_log_text != ""
            text += "#{battler.name}�͌��I�ȓ�����ʂ������I"
            battler.animation_id = 55
            battler.animation_hit = true
            # ���̃o�g���[�̖��͂Ɛ��͂��P�i�K�グ��
            # ���i���u�����A�R���I�u�����̋������ڂ�ʂ�
            text += special_status_check(battler,[171,187])
            $game_temp.battle_log_text += text
            battler.add_states_log.clear
            n = 0 if battler.is_a?(Game_Actor)
            n = 1 if battler.is_a?(Game_Enemy)
            $incense.delete_incense("���b�h�J�[�y�b�g", n)
            Audio.se_play("Audio/SE/059-Applause01", 80, 100)
          end
        end
        # �G�t�F�N�g���m�F�����̂Ń��[�v���I�������Ȃ�
        end_flag = false
      end
      #----------------------------------------------------------------------
      # �J�E���g��i�߂�
      @appear_effect_step_count += 1
      # �e�L�X�g������Ȃ�E�F�C�g�������ĕԂ�
      return if effect_text_check
    end
    #------------------------------------------------------------------------
    # �t���O��؂�A�ʏ�̃X�e�b�v�֖߂�
    @go_appear_effect_step = false
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (����F�Ⓒ���G�t�F�N�g)
  #--------------------------------------------------------------------------
  def dead_effect_step
    # ���͂̃��t���b�V��
    @battle_log_window.contents.clear
    @battle_log_window.keep_flag = false
    $game_temp.battle_log_text = ""
    # ���[�v�����t���O��������
    end_flag = false
    
    #----------------------------------------------------------------------
    # �f���m�F�̃��[�v���J�n
    while end_flag == false
      # �����ʂ�Ȃ������p�ɏI���t���O�𗧂Ă�B
      end_flag = true
      #----------------------------------------------------------------------
      # 0 : �f���y�ŗ~�z
      # �����ȊO�̖������Ⓒ�������A�����̖��͂Ɛ��͂��P�i�K�グ��
      #----------------------------------------------------------------------
      if @dead_effect_step_count == 0
        # �S�����m�F
        for battler in @effect_order_battlers
          text = ""
          effect_text = ""
          if battler.have_ability?("�ŗ~")
            go_flag = false
            # �Ⓒ�����o�g���[�̒��ɁA�����ȊO�̖���������ꍇ�t���O�𗧂Ă�
            for ecstasy_battler in @ecstasy_battlers_clone
              if ecstasy_battler != battler and
               ((battler.is_a?(Game_Actor) and ecstasy_battler.is_a?(Game_Actor)) or
               (battler.is_a?(Game_Enemy) and ecstasy_battler.is_a?(Game_Enemy)))
                go_flag = true
              end
            end
            # �t���O�������Ă���Ώ������s��
            if go_flag
              text += "\w\q" if $game_temp.battle_log_text != ""
              text += "#{battler.name}�͖����̐Ⓒ�����čV�����I"
              # ���̃o�g���[�̖��͂Ɛ��͂��P�i�K�グ��
              # ���i���u�����A�G���_�u�����̋������ڂ�ʂ�
              effect_text += special_status_check(battler,[171,179])
              # ���ʂ�����Ȃ�\��������
              if effect_text != ""
                battler.animation_id = 123
                battler.animation_hit = true
                $game_temp.battle_log_text += text + effect_text
              end
              battler.add_states_log.clear
            end
          end
        end
        # �G�t�F�N�g���m�F�����̂Ń��[�v���I�������Ȃ�
        end_flag = false
      end
      #----------------------------------------------------------------------
      # 1 : �f���y�΍R�S�z
      # �����̐Ⓒ���ɖ����̐����G�̐���菭�Ȃ��ꍇ�A���͂Ƒf�������グ��B
      #----------------------------------------------------------------------
      if @dead_effect_step_count == 1
        # �S�����m�F
        for battler in @effect_order_battlers
          text = ""
          effect_text = ""
          if battler.have_ability?("�΍R�S")
            # �t���O��������
            go_flag = false
            # �Ⓒ�����o�g���[�̒��ɁA����������ꍇ�t���O�𗧂Ă�
            for ecstasy_battler in @ecstasy_battlers_clone
              if (battler.is_a?(Game_Actor) and ecstasy_battler.is_a?(Game_Actor)) or
               (battler.is_a?(Game_Enemy) and ecstasy_battler.is_a?(Game_Enemy))
                go_flag = true
              end
            end
            # �t���O�������Ă��Ȃ��ꍇ���̃o�g���[��
            next if go_flag == false
            # �t���O���ď������i�g���񂵁j
            go_flag = false
            # �������Ă��閡���̐��ƓG�̐��𒲂ׂ�
            actors_number = 0
            enemies_number = 0
            for actor in $game_party.party_actors
              actors_number += 1 if actor.exist?
            end
            for enemy in $game_troop.enemies
              enemies_number += 1 if enemy.exist?
            end
            # ������ < �G���ɂȂ��Ă���ꍇ�A�t���O�𗧂Ă�
            if (battler.is_a?(Game_Actor) and enemies_number > actors_number) or
             (battler.is_a?(Game_Enemy) and actors_number > enemies_number)
              go_flag = true
            end
            # �t���O�������Ă���Ώ������s��
            if go_flag
              text += "\w\q" if $game_temp.battle_log_text != ""
              text += "#{battler.name}�͕s���ȏ󋵂ɑ΍R�S��R�₵���I"
              # ���̃o�g���[�̐��͂Ƒf�������P�i�K�グ��
              # �G���_�u�����A�R���I�u�����̋������ڂ�ʂ�
              effect_text += special_status_check(battler,[179,187])
              # ���ʂ�����Ȃ�\��������
              if effect_text != ""
                battler.animation_id = 123
                battler.animation_hit = true
                $game_temp.battle_log_text += text + effect_text
              end
              battler.add_states_log.clear
            end
          end
        end
        # �G�t�F�N�g���m�F�����̂Ń��[�v���I�������Ȃ�
        end_flag = false
      end
      #----------------------------------------------------------------------
      # 2 : �f���y�G�N�X�^�V�[�{���z
      # �������Ⓒ�������A�����ȊO�̖����S����\����Ԃɂ���B
      #----------------------------------------------------------------------
      if @dead_effect_step_count == 2
        # �S�����m�F
        for battler in @effect_order_battlers
          text = ""
          if battler.have_ability?("�G�N�X�^�V�[�{��")
            # �t���O��������
            go_flag = false
            # �Ⓒ�����o�g���[�̒��ɁA����������ꍇ�t���O�𗧂Ă�
            for ecstasy_battler in @ecstasy_battlers_clone
              if ecstasy_battler == battler
                go_flag = true
                break
              end
            end
            # ���R�������������Ȃ��ꍇ�̓t���O�����낷
            army = $game_party.battle_actors if battler.is_a?(Game_Actor)
            army = $game_troop.enemies if battler.is_a?(Game_Enemy)
            army_count = 0
            for army_one in army
              army_count += 1 if army_one.exist?
            end
            go_flag = false if army_count <= 1
            # �t���O�������Ă���Ώ������s��
            if go_flag
              text += "\w\q" if $game_temp.battle_log_text != ""
              text += "#{battler.name}�̐Ⓒ�����̖������h������I"
              # ���ʑΏۂ�����z����쐬
              effect_battlers = []
              # �����ȊO�̖����S����z��ɓ����B
              if battler.is_a?(Game_Actor)
                for actor in $game_party.battle_actors
                  effect_battlers.push(actor) if actor.exist? and actor != battler
                end
              elsif battler.is_a?(Game_Enemy)
                for enemy in $game_troop.enemies
                  effect_battlers.push(enemy) if enemy.exist? and enemy != battler
                end
              end
              # ���ʑΏۑS���ɏ������s��
              for effected_one in effect_battlers
                # �\����ϐ��v�Z����ŕt�^
                effected_one.add_state(36, false, true)
                # ����ɂ��\����ԂɂȂ������A�A�j���[�V�����ƃe�L�X�g��\��
                if effected_one.add_states_log.include?($data_states[36])
                  effected_one.animation_id = 123
                  effected_one.animation_hit = true
                  text += "\w\q" + effected_one.bms_states_update
                else
                  text += "\w\q" + "#{effected_one.name}�ɂ͌��ʂ��Ȃ������I"
                end
              end
              $game_temp.battle_log_text += text
              battler.add_states_log.clear
            end
          end
        end
        # �G�t�F�N�g���m�F�����̂Ń��[�v���I�������Ȃ�
        end_flag = false
      end
      #--------------------------------------------------------------------
      # �J�E���g���P�i�߂�
      @dead_effect_step_count += 1
      # �e�L�X�g������Ȃ�E�F�C�g�������ĕԂ�
      return if effect_text_check
    end
    #------------------------------------------------------------------------
    # �t���O��؂�A�ʏ�̃X�e�b�v�֖߂�
    @go_dead_effect_step = false
  end

  #--------------------------------------------------------------------------
  # �� �t���[���X�V �o�����A�Ⓒ���G�t�F�N�g�̃e�L�X�g�`�F�b�N
  #--------------------------------------------------------------------------
  def effect_text_check
    return_flag = false
    # �e�L�X�g������ꍇ�A�E�F�C�g����胁�\�b�h���I��������B
    if $game_temp.battle_log_text != ""
      @status_window.refresh
      $game_temp.battle_log_text += "\w\q" if $game_system.system_read_mode == 0
      #���V�X�e���E�F�C�g
      @wait_count = system_wait_make($game_temp.battle_log_text)
      return_flag = true
    end
    return return_flag
  end
end