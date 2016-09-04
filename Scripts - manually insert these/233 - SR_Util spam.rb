#==============================================================================
# �� SR_Util�@�F�@���t�t�^����
#------------------------------------------------------------------------------
# �@���t�O�������i�ϑ��j�B
#==============================================================================
module SR_Util
  #---------------------------------------------------------------------------- 
  # �� ���̌��㎞�̃X�v���C�g�쐬�i��{�j
  #----------------------------------------------------------------------------
  def self.gift_graphic_flag(actor)
    $game_switches[177] = false # �E��
    $game_switches[178] = false # �}��
    $game_switches[179] = false # �t���R�[�X�i�������j
    spots = rand(100)
    if actor.have_ability?("����")
      if spots < 30
        $game_switches[178] = true 
      elsif spots < 60 
        $game_switches[177] = true 
      end
    elsif actor.love >= 50
      if spots < 50
        $game_switches[177] = true
      end
    end
  end
  #---------------------------------------------------------------------------- 
  # �� ���̌��㎞�̃X�v���C�g�쐬�i��{�j
  #----------------------------------------------------------------------------
  def self.gift_graphic_make1(actor)
    $sprite = Sprite.new
    name = actor.battler_name
    name = actor.battler_name + "_N" if $game_switches[177]
    if $game_switches[178]
      if RPG::Cache.battler_exist?(actor.battler_name + "_I")
        name = actor.battler_name + "_I" 
      else
        name = actor.battler_name + "_N"
      end
    end
    $game_temp.gift_graphic = name
    graphic = RPG::Cache.battler($game_temp.gift_graphic,actor.battler_hue)
    $sprite.bitmap = Bitmap.new(graphic.width, graphic.height)
    $sprite.bitmap.blt(0, 0, graphic, Rect.new(0, 0, graphic.width, graphic.height), 255)
    $sprite.x = 320
    $sprite.y = 240
    $sprite.y += 60 if actor.boss_graphic?
    $sprite.ox = $sprite.bitmap.width / 2
    $sprite.oy = $sprite.bitmap.height / 2
    $sprite.opacity = 0
  end
  #---------------------------------------------------------------------------- 
  # �� ���̌��㎞�̃X�v���C�g�쐬���̂Q�i�Ԃ������j
  #----------------------------------------------------------------------------
  def self.gift_graphic_make2(actor)
    graphic = RPG::Cache.battler($game_temp.gift_graphic + "_C",actor.battler_hue)
    $sprite.bitmap = Bitmap.new(graphic.width, graphic.height)
    $sprite.bitmap.blt(0, 0, graphic, Rect.new(0, 0, graphic.width, graphic.height), 255)
    # ���tOK�Ȃ�Ԃ�������
    if $game_system.system_sperm == true
      spam_graphic = RPG::Cache.battler($game_temp.gift_graphic + "__S",actor.battler_hue)
      if $game_switches[178]      
        spam_graphic = RPG::Cache.battler($game_temp.gift_graphic + "__Z",actor.battler_hue)
      end
      $sprite.bitmap.blt(0, 0, spam_graphic, Rect.new(0, 0, spam_graphic.width, spam_graphic.height), 255)
    end
    $sprite.x = 320
    $sprite.y = 240
    $sprite.y += 60 if actor.boss_graphic?
    $sprite.ox = $sprite.bitmap.width / 2
    $sprite.oy = $sprite.bitmap.height / 2
  end

  #---------------------------------------------------------------------------- 
  # �� �Q�̖��O�̕����������ȏォ�H
  #----------------------------------------------------------------------------
  def self.names_over?(a_name, b_name, permition_number = 12)
    return ((a_name.size + b_name.size) / 3 > permition_number)
  end
  
  
  
  #---------------------------------------------------------------------------- 
  # �� ���t����
  #----------------------------------------------------------------------------
  def self.spam_plus
    
    if $msg.t_target.is_a?(Game_Actor)
      target = $msg.t_target
    # �Ⓒ�����̂���l���̏ꍇ�A�U���o�g���[�ɐ��t��������B
      if target == $game_actors[101] and $game_actors[101].nude?
        target.white_flash = true
        $game_system.se_play($data_system.actor_collapse_se)
        @wait_count = 30
        # �}�����ł���ꍇ�A���o��
        if target.insert?
          n = 1
          # �}�����ł���G�l�~�[��T���A������ɒ��o��������B
          for enemy in $game_troop.enemies
            if enemy.vagina_insert?
              enemy.add_state(10)
              enemy.lub_female += 60
              $game_temp.sperm_battler = enemy
#              $game_temp.battle_log_text += "\w\n" + enemy.bms_states_update
              # �R�����C�x���g�ɂ�鐸�t�ӏ��̔��f�i�O�͂Ԃ������j
              $game_variables[4] = 1
              $game_temp.sperm_battler.sperm(n) if $game_system.system_sperm
              # ���t���b�V�������͐��tON/OFF�ւ�炸�Z�b�g
              $game_temp.sperm_battler.white_flash = true
              #�X�e�[�g�e�L�X�g��}��
              brk = ""
              brk = "�A\n\m" if SR_Util.names_over?(enemy.name,$msg.t_target.name)
              if enemy == $msg.t_enemy
                if enemy.positive?
                  emotion = "�A�\�R�ōi�������I"
                elsif enemy.negative?
                  emotion = "�A�\�R�Ɏ󂯓��ꂽ�I"
                else
                  emotion = "�A�\�R�ōi�������I"
                end
                text = "#{enemy.name}��#{brk}#{$msg.t_target.name}�̐���#{emotion}"
              else
                text = "#{$msg.t_target.name}�͊������ꂸ�A\m\n#{enemy.name}�̒��ɐ���f���o���Ă��܂����I"
              end
              $game_temp.battle_log_text += text + "\n\m"
#              $game_temp.battle_log_text += "\w\n" + enemy.bms_states_update + "\n"
              # �摜�ύX
              $game_temp.sperm_battler.graphic_change = true
              # ���̖�����\���ɂ���
              $scene.enemies_display($game_temp.sperm_battler)
            end
          end
        else #if target.nude?
        # �}�����łȂ��ꍇ�A�Ԃ�����
        #�������A�t�F�����A�p�C�Y�����̑Ώۂ�����ꍇ�͂�����ɔ��˂���
          n = 0
          if $msg.t_target.penis_oralsex? or $msg.t_target.penis_paizuri?
            # �������ł���G�l�~�[��T���A������ɔ��˂���B
            for enemy in $game_troop.enemies
              if enemy.mouth_oralsex? or enemy.tops_paizuri?
                enemy.add_state(9)
                enemy.lub_female += 15
                $game_temp.sperm_battler = enemy
                # �R�����C�x���g�ɂ�鐸�t�ӏ��̔��f�i�O�͂Ԃ������j
                $game_variables[4] = 0
                $game_temp.sperm_battler.sperm(n) if $game_system.system_sperm
                # ���t���b�V�������͐��tON/OFF�ւ�炸�Z�b�g
                $game_temp.sperm_battler.white_flash = true
                #�X�e�[�g�e�L�X�g��}��
                brk = ""
                brk = "�A\n\m" if SR_Util.names_over?(enemy.name,$msg.t_target.name)
                if enemy.mouth_oralsex?
                  if enemy == $msg.t_enemy
                    if enemy.positive?
                      emotion = "������ƈ��݊������I"
                    elsif enemy.negative?
                      emotion = "������ƈ��ݍ��񂾁I"
                    else
                      emotion = "������ƈ��ݍ��񂾁I"
                    end
                    text = "#{enemy.name}��#{brk}#{$msg.t_target.name}�̐���#{emotion}"
                  else
                    text = "#{$msg.t_target.name}�͊������ꂸ�A\m\n#{enemy.name}�̌����ɐ���f���o���Ă��܂����I"
                  end
                elsif enemy.tops_paizuri?
                  #�����̋��T�C�Y�f�f
                  brk2 = ""
                  brk2 = "�A\n\m" if (enemy.name.size + enemy.bustsize.size) > 33
                  if enemy == $msg.t_enemy
                    text = "#{enemy.name}��\n#{$msg.t_target.name}�̐���#{enemy.bustsize}�Ŏ󂯎~�߂��I"
                  else
                    text = "#{$msg.t_target.name}�͊������ꂸ�A\m\n#{enemy.name}��#{enemy.bustsize}��#{brk2}����f���o���Ă��܂����I"
                  end
                end
                $game_temp.battle_log_text += text + "\n\m"
                # �摜�ύX
                $game_temp.sperm_battler.graphic_change = true
                # ���̖�����\���ɂ���
                $scene.enemies_display($game_temp.sperm_battler)
              end
            end
          else
            $msg.t_enemy.add_state(9)
            $msg.t_enemy.lub_female += 10
            $game_temp.sperm_battler = $msg.t_enemy
            # �R�����C�x���g�ɂ�鐸�t�ӏ��̔��f�i�O�͂Ԃ������j
            $game_variables[4] = 0
            $game_temp.sperm_battler.sperm(n) if $game_system.system_sperm
            # ���t���b�V�������͐��tON/OFF�ւ�炸�Z�b�g
            $game_temp.sperm_battler.white_flash = true
            #�X�e�[�g�e�L�X�g��}��
            brk = ""
            brk = "�A\n\m" if SR_Util.names_over?($msg.t_enemy.name,$msg.t_target.name)
            text = "#{$msg.t_target.name}�͊������ꂸ�A\m\n#{$msg.t_enemy.name}�ɐ���f���o���Ă��܂����I"
            $game_temp.battle_log_text += text + "\n\m"
            # �摜�ύX
            $game_temp.sperm_battler.graphic_change = true
            # ���̖�����\���ɂ���
            $scene.enemies_display($game_temp.sperm_battler)
          end
        end
      elsif not target.is_a?(Game_Enemy)
        $game_system.se_play($data_system.actor_collapse_se)
        target.white_flash = true
        @wait_count = 30
      else
        @wait_count = 8
      end
    end

  end
end
