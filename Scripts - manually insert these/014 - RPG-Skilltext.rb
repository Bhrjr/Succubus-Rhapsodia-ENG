#==============================================================================
# �� RPG::Skill
#------------------------------------------------------------------------------
# �@�X�L���ʃ��b�Z�[�W�i�[
#
#   ���X�L���e�L�X�g�͈�s������Q�S�����A�Q�s�܂łɂł��邾���}���鎖
#==============================================================================
module RPG
  class Skill
    def message(skill, type, myself, user)
      text = ""
      #�����_����_�X�L���A�܂��̓e�L�X�g�����X�L���̏ꍇ
      if skill.element_set.include?(9) or skill.element_set.include?(43)
        return text 
      end
      action = ""
      myname = myself.name
      username = user.name
      skill_name = skill.name.split(/\//)[0]
      target = $game_temp.battle_target_battler[0] if $game_temp.battle_target_battler[0] != nil
      targetname = $game_temp.battle_target_battler[0].name if $game_temp.battle_target_battler[0] != nil
      premess = "#{myname}��"
      avoid = "������#{myname}�͂��΂₭���킵���I"
      $game_variables[17] = rand(100) #�X�L���p����
      # �Ώۂ������̏ꍇ�̃e�L�X�g
      range = target.is_a?(Game_Actor) ? $game_party.battle_actors : $game_troop.enemies
      exist_count = 0
      for one in range
        exist_count += 1 if one.exist?
      end
      rangetext = exist_count > 1 ? "����" : ""
      
      
  #================================================================================================================================#
      # ������ȍs���̏ꍇ�i�����Ŕ��f�j
      # �����@
      if skill.element_set.include?(5)
        action = premess + "#{skill_name}�̖��@���r�������I"
        avoid = "#{myname}�ɂ͌����Ȃ������I"
      #------------------------------------------------------------------------#
      # ���C���Z���X
      elsif skill.element_set.include?(129)
        action = premess + "#{skill_name}���g�����I"
        avoid = "#{myname}�ɂ͌����Ȃ������I"
      else
        action = premess + "#{targetname}�����������I"
        avoid = "#{myname}�ɂ͌����Ȃ������I"
      end
      #------------------------------------------------------------------------#
      # �u���C�N�t���O(�d�|����Ǝ󂯎�̖��O���������v���P�Q���z����ꍇ�A���s�����ރt���O)
      # �e�L�X�g���e�ɂ���ẮA���܂Ȃ��Ă��ǂ��ꍇ������̂ōl���ē���邱��
      # brk�́u����Ǝ����̖��O�v�Abrk3�́u����̖��O�Ƒ���̋��T�C�Y�v��f�f����
      # brk2�̓X�L���P�ʂŌʎw�肵�Ă��邽�߁A�ꊇ�ł͐ݒ肵�Ȃ�
      brk = brk2 = brk3 = brk4 = ""
      if targetname != nil
        brk = "�A\n\m" if SR_Util.names_over?(myname,targetname)
        brk3 = "\n" if targetname.size + target.bustsize.size > 39 #����r�Ɩ��O�����킹�ĂP�R�����z���Ő܂�Ԃ�
        brk4 = "\n" if targetname.size > 24 #�Ώۂ̖��O���W�����z���Ő܂�Ԃ�
      end
      #------------------------------------------------------------------------#
      #�z�[���h���삻�̑��p�E���i�ʌ`�e�\��
      emotion = "���΂�ŁA" #�ėp
      case myself.personality
      when "�z�C","�����C","�_�a", "���M"
        emotion = "���Y���ۂ��΂݂𕂂��ׂ�ƁA"
        emotion = "�y�����Ɍ������䂪�߁A" if $game_variables[17] < 33
        emotion = "�ɂ���Ɩڂ��ׂ߂�ƁA" if $game_variables[17] > 66
      when "�Ӓn��","����","����", "�C��" #
        emotion = "�Ӓn�����Ɍ������䂪�߁A"
        emotion = "�v�킹�Ԃ�ȏ΂݂𕂂��ׁA" if $game_variables[17] < 33
        emotion = "�������Ɩڂ��ׂ߂�ƁA" if $game_variables[17] > 66
      when "�D�F","��i","�|��", "�ƑP" #
        emotion = "�����ȏ΂݂𕂂��ׂ�ƁA"
        emotion = "�v�킹�Ԃ�ȏ΂݂𕂂��ׁA" if $game_variables[17] < 33
        emotion = "���Ȑ��ꂩ�����ė����ۂ�A" if $game_variables[17] > 66
      when "�V�R","�Â���", "���C" #
        emotion = "���׋C�ɔ��΂݂Ȃ���A"
        emotion = "������#{targetname}�̊�����߂�ƁA" if $game_variables[17] < 33
        emotion = "���Y���ۂ��΂݂𕂂��ׂ�ƁA" if $game_variables[17] > 66
      when "���C","�]��", "����" #
        emotion = "����ɋ}�������悤�ɁA"
        emotion = "�ӂ����������̂悤�ɁA" if $game_variables[17] < 33
        emotion = "���炿��Ɨl�q���f���A" if $game_variables[17] > 66
      when "�s�v�c","�W��","�A�C" #
        emotion = "������#{targetname}�̊�����߁A"
        emotion = "�������䂩�ꂽ�悤�ȕ\��ŁA" if $game_variables[17] < 33
        emotion = "������[�������悤�������ƁA" if $game_variables[17] > 66
      when "����" #���[�~��
        emotion = "����ɋ}�������悤�ɁA"
        emotion = "�ӂ����������̂悤�ɁA" if $game_variables[17] < 33
        emotion = "���炿��Ɨl�q���f���A" if $game_variables[17] > 66
      when "�I����" #���F���~�B�[�i
        emotion = "���Y���ۂ��΂݂𕂂��ׂ�ƁA"
        emotion = "�y�����Ɍ������䂪�߁A" if $game_variables[17] < 33
        emotion = "�ɂ���Ɩڂ��ׂ߂�ƁA" if $game_variables[17] > 66
      end
      #------------------------------------------------------------------------#
      #�K���̌`�e
      case $data_SDB[target.class_id].name
      when "���b�T�[�T�L���o�X","�T�L���o�X", "���F���~�B�[�i"
        tail = "���Ȃ₩�ȐK��"
      when "�C���v","�f�r��","�f�\����", "���[�K�m�b�g"
        tail = "�߂̂���K��"
      when "���[�L���b�g","���[�E���t","�^�}��"
        tail = "�ӂ��ӂ��̐K��"
      when "�t���r���A", "�l�C�W�������W", "�T�L���o�X���[�h"
        tail = "���������K��"
      when "�t�@�~���A", "���W�F�I", "�V���t�F"
        tail = "�ؚ��ȐK��"
      when "�K�[�S�C��"
        tail = "�p�������K��"
      else
        tail = "�K��"
      end
      #------------------------------------------------------------------------#
      ##{pantsu}�̌`�e
      case $data_SDB[target.class_id].name
      when "�l��" #���E�N
        pantsu = "����"
      when "�C���v","�f�r��","�f�[����", "�S�u����", "�M�����O�R�}���_�["
        pantsu = "�p���c"
      when "�i�C�g���A"
        pantsu = "���z"
      when "���[�E���t", "���[�L���b�g", "�^�}��"
        pantsu = "�ҕz"
      when "�X���C��", "�S�[���h�X���C��"
        pantsu = "�҂̔S�t"
      when "�K�[�S�C��"
        pantsu = "�҂̊┧"
      else
        pantsu = "�V���[�c"
      end
      #------------------------------------------------------------------------#
      #�U�߂̌`�e
      # �ǌ����łȂ��ꍇ
      if $game_switches[78] == false
        tec = ["�ɋ}������","�������ނ悤��"]
        tec.push("���ꂽ�l�q��") if myself.positive?
        tec.push("�S�����l�q��") if myself.positive?
        tec.push("�p���炤�l�q��������") if myself.negative?
        tec.push("�����Ƃ肵���\���") if myself.negative?
      # �ǌ����̏ꍇ
      else
        tec = ["�����Ƃ肵���\���","�������ނ悤��"]
        tec.push("�x�ފԂ��^����") if myself.positive?
        tec.push("����������ނ悤��") if myself.positive?
        tec.push("�����Ƃ����\���") if myself.negative?
        tec.push("�M�S��") if myself.negative?
      end
      tec = tec[rand(tec.size)]
  #================================================================================================================================#
      # ���X�L�����Ŕ��f(�z�[���h���͓G�������ʂ̂��߂������)
      case skill.name
  #------------------------------------------------------------------------#
      when "����E����"
        if target.is_a?(Game_Enemy) #�G�l�~�[��E������
          action = premess + "�A\n\m#{targetname}�̕���E�����悤�Ǝ��݂��I"
          #�X���C���n�͐�p�̃e�L�X�g�ƂȂ�
          action = premess + "�A\n\m#{targetname}���Z���S�t�𗎂Ƃ����Ǝ��݂��I" if target.tribe_slime?
        elsif target.is_a?(Game_Actor) #�A�N�^�[���E�������
          action = premess + "�A\n\m#{targetname}�̕���E�����悤�Ƃ����I"
          #�X���C���n�͐�p�̃e�L�X�g�ƂȂ�
          action = premess + "�A\n\m#{targetname}���Z���S�t�𗎂Ƃ����Ƃ��Ă����I" if target.tribe_slime?
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "����E��"
        action = "#{myname}�͕���E�����I"
        action = "#{myname}�͕���E���̂Ă��I" if myself.berserk == true
        #�X���C���n�͐�p�̃e�L�X�g�ƂȂ�
        action = "#{myname}�͐g�ɓZ���S�t�𗎂Ƃ����I" if target.tribe_slime?
        action = "#{myname}�̓Z���Ă���S�t���e����сA\n�L���ȗ��̂��I��ɂȂ����I" if target.tribe_slime? and myself.berserk == true
        avoid = ""
  #------------------------------------------------------------------------#
      when "�C���T�[�g","�V�F���}�b�`","�A�N�Z�v�g","�f�B���h�C���T�[�g"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          case $mood.point
          when 50..100
            case $data_SDB[target.class_id].name
            when "�C���v", "�t�@�~���A", "�S�u����", "�M�����O�R�}���_�[", "���j�[�N�^�C�N�[��"
              action = premess + "�A\n\m#{targetname}�̏����ȑ̋���ォ��g�ݕ������I"
            when "�L���X�g", "�v�`�E�B�b�`", "������", "�X���C��"
              action = premess + "�A\n\m#{targetname}�ؚ̉��ȑ̋���ォ��g�ݕ������I"
            else
              action = premess + "�A\n\m#{targetname}���ォ��g�ݕ������I"
            end
          else
            case $data_SDB[target.class_id].name
            when "�C���v", "�t�@�~���A", "�S�u����", "�M�����O�R�}���_�[", "���j�[�N�^�C�N�[��"
              action = premess + "�A\n\m#{targetname}�̏����ȑ̋�������|�����I"
            when "�L���X�g", "�v�`�E�B�b�`", "������", "�X���C��"
              action = premess + "�A\n\m#{targetname}�ؚ̉��ȑ̋�������|�����I"
            else
              action = premess + "�A\n\m#{targetname}�������|�����I"
            end
          end
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          case $mood.point
          when 50..100
            action = "#{targetname}�́A\n\m#{myname}�ɑg�ݕ������Ă��܂����I"
          else
            action = "#{targetname}�́A\n\m#{myname}�ɉ����|���ꂽ�I"
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�o�b�N�C���T�[�g","�f�B���h�C���o�b�N"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          case $mood.point
          when 50..100
            case $data_SDB[target.class_id].name
            when "�C���v", "�t�@�~���A", "�S�u����", "�M�����O�R�}���_�[", "���j�[�N�^�C�N�[��"
              action = premess + "�A\n\m#{targetname}�̏����ȑ̋���ォ��g�ݕ������I"
            when "�L���X�g", "�v�`�E�B�b�`", "������", "�X���C��"
              action = premess + "�A\n\m#{targetname}�ؚ̉��ȑ̋���ォ��g�ݕ������I"
            else
              action = premess + "�A\n\m#{targetname}���ォ��g�ݕ������I"
            end
          else
            case $data_SDB[target.class_id].name
            when "�C���v", "�t�@�~���A", "�S�u����", "�M�����O�R�}���_�[", "���j�[�N�^�C�N�[��"
              action = premess + "�A\n\m#{targetname}�̏����ȑ̋�������|�����I"
            when "�L���X�g", "�v�`�E�B�b�`", "������", "�X���C��"
              action = premess + "�A\n\m#{targetname}�ؚ̉��ȑ̋�������|�����I"
            else
              action = premess + "�A\n\m#{targetname}�������|�����I"
            end
          end
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          case $mood.point
          when 50..100
            action = "#{targetname}�́A\n\m#{myname}�ɑg�ݕ������Ă��܂����I"
          else
            action = "#{targetname}�́A\n\m#{myname}�ɉ����|���ꂽ�I"
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�I�[�����C���T�[�g","�f�B���h�C���}�E�X"
        if skill.name == "�f�B���h�C���}�E�X"
          penis_word = "�f�B���h"
        else
          penis_word = "�y�j�X"
        end
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + "�A������u��#{penis_word}��\n\m#{targetname}�̌����ɓ˂������I"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          action = premess + "�A������u��#{penis_word}��\n\m#{targetname}�̌����ɓ˂��o�����I"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�G�L�T�C�g�r���["
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          case $mood.point
          when 50..100
            case $data_SDB[target.class_id].name
            when "�C���v", "�t�@�~���A", "�S�u����", "�M�����O�R�}���_�[", "���j�[�N�^�C�N�[��"
              action = premess + "�A\n\m#{targetname}�̏����ȑ̋���ォ��g�ݕ������I"
            when "�L���X�g", "�v�`�E�B�b�`", "������", "�X���C��"
              action = premess + "�A\n\m#{targetname}�ؚ̉��ȑ̋���ォ��g�ݕ������I"
            else
              action = premess + "�A\n\m#{targetname}���ォ��g�ݕ������I"
            end
          else
            case $data_SDB[target.class_id].name
            when "�C���v", "�t�@�~���A", "�S�u����", "�M�����O�R�}���_�["
              action = premess + "�A\n\m#{targetname}�̏����ȑ̋�������|�����I"
            when "�L���X�g", "�v�`�E�B�b�`", "������", "�X���C��"
              action = premess + "�A\n\m#{targetname}�ؚ̉��ȑ̋�������|�����I"
            else
              action = premess + "�A\n\m#{targetname}�������|�����I"
            end
          end
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          if myself.full_nude?
            case $mood.point
            when 50..100
              action = "#{targetname}�̎��E�����ς��ɁA\n\m�w�ŊJ���ꂽ#{myname}�̃A�\�R���f��I"
            else
              action = "#{targetname}�̎��E�����ς��ɁA\n\m#{myname}�̃A�\�R���f��I"
            end
          else
            case $data_SDB[myself.class_id].name
            when "�L���X�g","�t�@�~���A","�v�`�E�B�b�`","�E�B�b�`"
              action = "#{targetname}�̎��E�����ς��ɁA\n\m�X�J�[�g���������グ��#{myname}�̎p���f��I"
            when "���b�T�[�T�L���o�X","�T�L���o�X"
              action = "#{targetname}�̎��E�����ς��ɁA\n\m#{myname}�̃A�\�R�𕢂������ȕz�n���f��I"
            when "�C���v","�f�r��"
              action = "#{targetname}�̎��E�����ς��ɁA\n\m#{myname}�̌��N�I�ȋr���f��I"
            when "�X���C��"
              action = "#{targetname}�̎��E�����ς��ɁA\n\m�������̔S�t�ɕ���ꂽ#{myname}�̃A�\�R���f��I"
            when "�i�C�g���A"
              action = "#{targetname}�̎��E�����ς��ɁA\n\m����̕z�n�ɕ���ꂽ������#{myname}�̃A�\�R���f��I"
            else
              action = "#{targetname}�̎��E�����ς��ɁA\n\m#{myname}�̃A�\�R���f��I"
            end
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�C���������r���["
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          case $mood.point
          when 50..100
            case $data_SDB[target.class_id].name
            when "�C���v", "�t�@�~���A", "�S�u����", "�M�����O�R�}���_�[", "���j�[�N�^�C�N�[��"
              action = premess + "�A\n\m#{targetname}�̏����ȑ̋���ォ��g�ݕ������I"
            when "�L���X�g", "�v�`�E�B�b�`", "������", "�X���C��"
              action = premess + "�A\n\m#{targetname}�ؚ̉��ȑ̋���ォ��g�ݕ������I"
            else
              action = premess + "�A\n\m#{targetname}���ォ��g�ݕ������I"
            end
          else
            case $data_SDB[target.class_id].name
            when "�C���v", "�t�@�~���A", "�S�u����", "�M�����O�R�}���_�[", "���j�[�N�^�C�N�[��"
              action = premess + "�A\n\m#{targetname}�̏����ȑ̋�������|�����I"
            when "�L���X�g", "�v�`�E�B�b�`", "������", "�X���C��"
              action = premess + "�A\n\m#{targetname}�ؚ̉��ȑ̋�������|�����I"
            else
              action = premess + "�A\n\m#{targetname}�������|�����I"
            end
          end
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          case $mood.point
          when 50..100
            action = "#{targetname}�̖ڂ̑O�ɁA\n\m#{myname}�̂��K�������Ă����I"
          else
            action = "#{targetname}�̖ڂ̑O�ɁA\n\m#{myname}�̂��K�������Ă����I"
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�h���E�l�N�^�["
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + "�A\n\m#{targetname}�̗��������E�ɊJ�������I"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          if myself.positive?
            emotion = "�d���ȏ΂݂𕂂��ׂ�"
          elsif myself.negative?
            emotion = "���t���̂悤�ɐO���񂹂�"
          else
            emotion = "�������Ɛ��L�΂���"
          end
          action = "#{targetname}�̃A�\�R�Ɋ���߂Â��A\n\m#{myname}��#{emotion}�I"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�I�[�����A�N�Z�v�g"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + "�A\n\m#{targetname}�̗��������E�ɊJ�������I"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          if myself.positive?
            emotion = "���t���̂悤�ɐO���񂹂�"
          elsif myself.negative?
            emotion = "�ӂ��������悤�Ɍ����J����"
          else
            emotion = "�������ƌ����J����"
          end
          action = "#{targetname}�̃y�j�X�Ɋ���߂Â��A\n\m#{myname}��#{emotion}�I"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�t���b�^�i�C�Y"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + "�A\n\m#{targetname}������񂹂��I"
          action = premess + "�A\n\m#{targetname}�̊��U����������I" if target.holding?
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          if myself.positive?
            action = premess + "�A\n\m#{targetname}������񂹂Ă����I"
          elsif myself.negative?
            action = premess + "�ڂ����ƁA\n\m#{targetname}�̐O�Ɋ���߂Â��Ă����I"
          else
            action = premess + "�A\n\m#{targetname}������񂹂Ă����I"
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�G���u���C�X"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + "�A\n\m#{targetname}�Ɍ�납����������I"
          action = premess + "�A\n\m#{targetname}�ɕ����킳�����I" if target.holding?
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          action = "#{targetname}�̔w�ォ��A\n\m#{myname}���������Ă����I"
          action = "#{targetname}�ɕ����킳��悤�ɁA\n\m#{myname}���������Ă����I" if target.holding?
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�y���X�R�[�v"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + "�A\n\m#{targetname}�̍��ɕ��������I"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          action = premess + "����#{myself.bustsize}�ŁA\n\m#{targetname}�̃y�j�X�������Ƃ��Ă����I"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�w�u�����[�t�B�[��"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + "�r���L���A\n\m#{targetname}�ɕ������Ԃ������I"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          action = premess + "����#{myself.bustsize}�ŁA\n\m#{targetname}�ɕ������Ԃ����Ă����I"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�f�����Y�A�u�\�[�u"
        action = "#{myname}�̑���G��̐悪�J���A\n\m#{targetname}�̃y�j�X������������Ƃ��Ă���I"
        avoid = ""
  #------------------------------------------------------------------------#
      when "�f�����Y�h���E"
        action = "#{myname}�̑���G�肪������忂��A\n\m#{targetname}�̃A�\�R�ɐ����ǂ��L�тĂ����I"
        avoid = ""
  #------------------------------------------------------------------------#
      when "�w�u�����[�t�B�[��"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + "�r���L���A\n\m#{targetname}�ɕ������Ԃ������I"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          action = premess + "����#{myself.bustsize}�ŁA\n\m#{targetname}�ɕ������Ԃ����Ă����I"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�����[�X"
        action = premess + "�̐���ς��A\n\m#{targetname}���痣��悤�Ǝ��݂��I"
        action = premess + "�g�̂��悶��A\n\m#{targetname}���牽�Ƃ�����悤�Ǝ��݂��I" if myself.initiative_level == 0
        avoid = ""
  #------------------------------------------------------------------------#
      when "�C���^���v�g"
        if myself == $game_actors[101]
          for i in $game_party.actors
            if i.exist? and i != $game_actors[101]
              partner = i
            end
          end
          action = premess + "#{partner.name}������񂹁A\n\m�������Ă���#{targetname}�Ɨ������Ǝ��݂��I"
        elsif myself.positive?
          action = premess + "�v�킹�Ԃ�ȑԓx�ŁA\n\m#{targetname}�̋C����炻���Ǝ��݂��I"
        elsif myself.negative?
          action = premess + "#{$game_actors[101].name}�ɕ������A\n\m#{targetname}�Ƃ̊ԂɊ����ē��낤�Ǝ��݂��I"
        else
          action = premess + "�v�킹�Ԃ�ȑԓx�ŁA\n\m#{targetname}�̋C����炻���Ǝ��݂��I"
        end
        avoid = ""
      end
################################################################################
      # ��ID�Ŕ��f
      case skill.id
  #------------------------------------------------------------------------#
      when 9     #�g�[�N
        case $mood.point
        when 50..100
          action = premess + "�A\n\m#{targetname}�ɂ����Ƃ����₢���I"
        else
          action = premess + "�A\n\m#{targetname}�Ɍ�肩�����I"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 81    #�L�b�X
        held = ""
        if myself.holding?
          held = "�̐���ς���"
        end
        case $mood.point
        when 50..100
          case myself.personality
          when "�����C", "�r��", "����"
            action = premess + "#{held}�A\n\m#{targetname}�̐O�������ɒD�����I"
          when "�D�F", "�Â���"
            action = premess + "#{held}�A\n\m#{targetname}�Ə�M�I�ȃL�X�����킵���I"
          when "�W��", "���C", "���"
            action = premess + "#{held}�A\n\m#{targetname}�̐O�ɁA�����ƐO���d�˂��I"
          else
            action = premess + "#{held}�A\n\m#{targetname}�ƔZ���ȃL�X�����킵���I"
          end
        else
          action = premess + "#{held}�A\n\m#{targetname}�ƃL�X�����킵���I"
        end
  #------------------------------------------------------------------------#
      when 82    #�o�X�g
        brk2 = ""
        brk2 = "\n\m" if targetname.size + target.bustsize.size > 36 and $mood.point >= 50 #���\���Ɩ������𑫂��ĂP�Q�����z��
        if target.nude?
          if skill.element_set.include?(71) #����g�p
            action = premess + "��ŁA\n\m#{targetname}��#{target.bustsize}��#{brk2}���������I"
            action = premess + "���L�΂��A\n\m#{targetname}��#{target.bustsize}��#{brk2}���������I" if myself.holding?
          elsif skill.element_set.include?(72) #�����g�p
            action = premess + "���ŁA\n\m#{targetname}��#{target.bustsize}��#{brk2}���������I"
            action = premess + "�̐���ς��āA\n\m����#{targetname}��#{target.bustsize}��#{brk2}���������I" if myself.holding?
          end
        else
          if skill.element_set.include?(71) #����g�p
            action = premess + "��ŁA���z����\n\m#{targetname}��#{target.bustsize}��#{brk2}���������I"
            action = premess + "���L�΂��A���z����\n\m#{targetname}��#{target.bustsize}��#{brk2}���������I" if myself.holding?
          elsif skill.element_set.include?(72) #�����g�p
            action = premess + "���ŁA���z����\n\m#{targetname}��#{target.bustsize}��#{brk2}���������I"
            action = premess + "�̐���ς��āA���z����\n\m����#{targetname}��#{target.bustsize}��#{brk2}���������I" if myself.holding?
          end
        end
        #���[�h�ɂ��U�ߕ��ω��f�f
        case $mood.point
        when 0..100#50..100
          action.gsub!("���","�w��") 
          action.gsub!("����","���")
          #�U���Ώې؂�ւ�
          if $game_variables[17] > 50
            action.gsub!("����","����") 
            action.gsub!("�c��݂����̋�","���炵������") 
            action.gsub!("�T�܂�����","���U��ȓ���") 
            action.gsub!("�`�̗ǂ���","���������") 
            action.gsub!("�L���ȋ�","���������") 
            action.gsub!("���͂��鋹","���������") 
          end
          #���i�f�f
          case myself.personality
          when "�����C", "�r��", "����"
            action.gsub!("����","�r�X��������") 
          when "�D�F", "�_�a"
            action.gsub!("����","���߂���������") 
          when "�W��", "���C", "���", "�Â���"
            action.gsub!("����","�D��������") 
          else
            action.gsub!("����","���J�Ɉ���") 
          end
        end
        #�X���C���p�e�L�X�g���`
        if $data_SDB[target.class_id].name == "�X���C��"
          action.gsub!("���z����","�S�t��������") 
        end
  #------------------------------------------------------------------------#
      when 83    #�q�b�v
        brk2 = ""
        brk2 = "\n\m" if targetname.size > 24 and $mood.point >= 50 #�W�����z���̖�����
        if target.nude?
          if skill.element_set.include?(71) #����g�p
            action = premess + "��ŁA\n\m#{targetname}�̂��K�����������I"
            action = premess + "���L�΂��A\n\m#{targetname}�̂��K�����������I" if myself.holding?
          elsif skill.element_set.include?(72) #�����g�p
            action = premess + "���ŁA\n\m#{targetname}�̂��K�����������I"
            action = premess + "�̐���ς��āA\n\m����#{targetname}�̂��K��#{brk2}���������I" if myself.holding?
          end
        else
          if skill.element_set.include?(71) #����g�p
            action = premess + "��ŁA#{pantsu}�z����\n\m#{targetname}�̂��K�����������I"
            action = premess + "���L�΂��A#{pantsu}�z����\n\m#{targetname}�̂��K�����������I" if myself.holding?
          elsif skill.element_set.include?(72) #�����g�p
            action = premess + "���ŁA#{pantsu}�z����\n\m#{targetname}�̂��K�����������I"
            action = premess + "�̐���ς��āA#{pantsu}�z����\n\m����#{targetname}�̂��K��#{brk2}���������I" if myself.holding?
          end
        end
        #���[�h�ɂ��U�ߕ��ω��f�f
        case $mood.point
        when 50..100
          action.gsub!("���","�w��") 
          action.gsub!("����","���")
          #�U���Ώې؂�ւ�
          if $game_variables[17] > 80
            action.gsub!("���K","�e��") 
          end
          #���i�f�f
          case myself.personality
          when "�����C", "�r��", "����"
            action.gsub!("����","�r�X��������") 
          when "�D�F", "�_�a"
            action.gsub!("����","���߂���������") 
          when "�W��", "���C", "���", "�Â���"
            action.gsub!("����","�D��������") 
          else
            action.gsub!("����","���J�Ɉ���") 
          end
        end
  #------------------------------------------------------------------------#
      when 84    #�N���b�`
        brk2 = ""
        brk2 = "\n\m" if targetname.size > 24 and $mood.point >= 50 #�W�����z���̖�����
        if target.nude?
          if skill.element_set.include?(71) #����g�p
            action = premess + "��ŁA\n\m#{targetname}�̃A�\�R��#{brk2}���������I"
            action = premess + "���L�΂��A\n\m#{targetname}�̃A�\�R��#{brk2}���������I" if myself.holding?
          elsif skill.element_set.include?(72) #�����g�p
            action = premess + "���ŁA\n\m#{targetname}�̃A�\�R��#{brk2}���������I"
            action = premess + "�̐���ς��āA\n\m����#{targetname}�̃A�\�R��#{brk2}���������I" if myself.holding?
          end
        else
          if skill.element_set.include?(71) #����g�p
            action = premess + "��ŁA#{pantsu}�z����\n\m#{targetname}�̃A�\�R��#{brk2}���������I"
            action = premess + "���L�΂��A#{pantsu}�z����\n\m#{targetname}�̃A�\�R��#{brk2}���������I" if myself.holding?
          elsif skill.element_set.include?(72) #�����g�p
            action = premess + "���ŁA#{pantsu}�z����\n\m#{targetname}�̃A�\�R��#{brk2}���������I"
            action = premess + "�̐���ς��āA#{pantsu}�z����\n\m����#{targetname}�̃A�\�R��#{brk2}���������I" if myself.holding?
          end
        end
        #���[�h�ɂ��U�ߕ��ω��f�f
        case $mood.point
        when 50..100
          action.gsub!("���","�w��") 
          action.gsub!("����","���")
          #�U���Ώې؂�ւ�
          if $game_variables[17] > 50
            action.gsub!("�A�\�R","�A�j") 
          end
          #���i�f�f
          case myself.personality
          when "�����C", "�r��", "����"
            action.gsub!("����","�r�X��������") 
          when "�D�F", "�_�a"
            action.gsub!("����","���߂���������") 
          when "�W��", "���C", "���", "�Â���"
            action.gsub!("����","�D��������") 
          else
            action.gsub!("����","���J�Ɉ���") 
          end
        end
  #------------------------------------------------------------------------#
      when 52    #�V�F���}�b�`�A�X�N���b�`(�z�[���h��)
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\m�A�\�R���C�荇�킹���I"
        if $mood.point > 50
          #���i�f�f
          case myself.personality
          when "�����C", "����"
            action.gsub!("�C�荇�킹","�������C�荇�킹") 
          when "�D�F", "�_�a"
            action.gsub!("�C�荇�킹","���߂������C�荇�킹") 
          when "��i", "�Ӓn��"
            action.gsub!("�C�荇�킹","�ł炷�悤�ɎC�荇�킹") 
          when "�W��", "���C", "�Â���"
            action.gsub!("�C�荇�킹","�������ƎC�荇�킹") 
          else
            action.gsub!("�C�荇�킹","�C�荇�킹") 
          end
        end
  #------------------------------------------------------------------------#
      when 32,35,37,41,47,34,38 #�X�E�B���O�A�O���C���h
        action = premess + "����U�����I"
        if $mood.point > 50
          #���i�f�f
          case myself.personality
          when "�����C", "�r��"
            action.gsub!("����","�r�X��������") 
          when "�D�F", "�_�a"
            action.gsub!("����","���߂���������") 
          when "���", "�Ӓn��"
            action.gsub!("����","�ɋ}�t���č���") 
          when "���C", "�Â���", "�V�R"
            action.gsub!("����","�ꏊ�����ɍ���") 
          else
            action.gsub!("����","����������") 
          end
        end
      when 33 #�w���B�X�E�B���O
        action = premess + "�傫������U�����I"
        if $mood.point > 50
          #���i�f�f
          case myself.personality
          when "�����C", "�r��"
            action.gsub!("�傫������","�@������悤�ɍ���") 
          when "�D�F", "�_�a"
            action.gsub!("�傫������","���˂�悤�ɍ���") 
          when "���", "�Ӓn��"
            action.gsub!("�傫������","�ŉ���˂��悤�ɍ���") 
          when "���C", "�Â���", "�V�R"
            action.gsub!("�傫������","��S�s���ɍ���") 
          else
            action.gsub!("�傫������","����������") 
          end
        end
  #------------------------------------------------------------------------#
      when 55   #���C�f�B���O
        if myself.nude?
          action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\m�O��ɍ���U�����I"
          action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\m������������U�����I" if $mood.point > 50
        else
          case $data_SDB[myself.class_id].name
          when "�L���X�g","�t�@�~���A","�v�`�E�B�b�`","�E�B�b�`"
            action = premess + "�X�J�[�g�̒[�������A\n\m#{targetname}�̌��ɃV���[�c�������t�����I"
          when "���b�T�[�T�L���o�X","�T�L���o�X"
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌��ɃV���[�c�������t�����I"
          when "�C���v","�f�r��"
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌��Ƀp���c�������t�����I"
          when "�X���C��"
            action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\m�҂̌E�݂����������t���Ă����I"
          when "�i�C�g���A"
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌��ɔ��z�z���̃A�\�R�������t�����I"
          else
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌��ɃA�\�R�������t�����I"
          end
        end
  #------------------------------------------------------------------------#
      when 91   #�c�[�p�t
        #�ꕔ���i�Ŋ�{�e�L�X�g����
        case myself.personality
        when "�����C", "����", "�Ӓn��"
          action = premess + "#{myself.bustsize}�̒J�Ԃ��A\n\m#{targetname}�̊�ɉ����t�����I"
        else
          action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̊���ݍ��񂾁I"
        end
  #------------------------------------------------------------------------#
      when 71   #���b�N
        if target.full_nude?
          case $mood.point
          when 50..100
            action = premess + "�A\n\m#{targetname}�̃A�\�R���œ˂��グ���I"
          else
            action = premess + "�A\n\m#{targetname}�̃A�\�R���ň��������I"
          end
          #�U���Ώې؂�ւ�
          if $game_variables[17] > 50
            action.gsub!("�A�\�R","�A�j") 
          end
        else
          case $data_SDB[target.class_id].name
          when "�X���C��"
            action = premess + "�S�t�z���ɁA\n\m#{targetname}�̃A�\�R���œ˂��グ���I"
          when "�i�C�g���A"
            action = premess + "���z�z���ɁA\n\m#{targetname}�̃A�\�R���œ˂��グ���I"
          else
            action = premess + "#{pantsu}�z���ɁA\n\m#{targetname}�̃A�\�R���œ˂��グ���I"
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 72   #���b�N(�ΐK)
        case $mood.point
        when 50..100
          action = premess + "�A\n\m#{targetname}�̋e�����œ˂��グ���I"
        else
          action = premess + "�A\n\m#{targetname}�̋e�����ň��������I"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 73   #�~�X�`�[�t
        case $mood.point
        when 50..100
          action = premess + "���L�΂��A\n\m#{targetname}�̃A�\�R�����������I"
          action = premess + "�������߂��܂܁A\n\m#{targetname}�̐O�������ɒD�����I" if $game_variables[17] > 50
        else
          action = premess + "���L�΂��A\n\m#{targetname}�̑��҂�D�������ŉ񂵂��I"
          action = premess + "�������߂��܂܁A\n\m#{targetname}��#{target.bustsize}���h�������I" if $game_variables[17] > 50
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 74   #���A�J���X
        case $mood.point
        when 50..100
          action = premess + "����ŁA\n\m#{targetname}�̃A�\�R�̈��������݂��I"
          action = premess + "�U������āA\n\m#{targetname}�ƃL�X�����݂��I" if $game_variables[17] > 50
        else
          action = premess + "����ŁA\n\m#{targetname}�̑��҂�D�������ŉ񂵂��I"
          action = premess + "�̂��悶��A\n\m#{targetname}��#{target.bustsize}���h�������I" if $game_variables[17] > 50
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 641   #�f�����Y�X���[�g
        action = "#{myname}�̑���G�肪�A\n\m#{targetname}�̃y�j�X���Ԓf�Ȃ��z���グ�Ă���I"
        action = "#{myname}�̑���G��̂Ђ����A\n\m#{targetname}�̃y�j�X��₦�ԂȂ��h�����Ă���I"  if $game_variables[17] > 50
        avoid = ""
  #------------------------------------------------------------------------#
      when 642   #�f�����Y�T�b�N
        action = "#{myname}�̑���G�肪�A\n\m#{targetname}�̃A�\�R���Ԓf�Ȃ��z�������Ă���I"
        action = "#{myname}�̑���G��̂Ђ����A\n\m#{targetname}�̃A�\�R��₦�ԂȂ��������Ă���I"  if $game_variables[17] > 50
        avoid = ""
  #------------------------------------------------------------------------#
      when 79   #���b�N���X
        action = premess + "�g���悶��A\n\m�̐���ς��悤�Ǝ��݂��I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 101   #�e�B�[�Y
        action = premess + "�A\n\m#{targetname}���ł炷�悤�Ɉ��������I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 104   #�g���b�N���C�h
        action = premess + "�A\n\m#{targetname}�̕s�ӂ����|�M�����I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 106   #�f�B�o�E�A�[
        action = premess + "�Â�悤�ɁA\n\m#{targetname}�̑̋���܂��������I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 121   #�u���X
        action = "#{myname}�͑��𐮂����I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 122   #�J�[���u���X
        action = "#{myname}�͐[�������z�����݁A\n\m���ꂽ�ċz����߂��I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 123   #�E�F�C�g
        action = "#{myname}�͗l�q�����������Ă���c�c"
        avoid = ""
  #------------------------------------------------------------------------#
      when 124   #�C���g���X�g
        action = "#{myname}�͐g�̗̂͂𔲂����I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 125   #���t���b�V��
        action = "#{myname}�͈ӎ����W�����A\n\m���g�̏�ԕω���S�đł��������I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 126   #�`�F�b�N
        action = premess + "�A\n\m#{targetname}�̎��𒲂ׂ��I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 127   #�A�i���C�Y
        action = premess + "�A\n\m#{targetname}�̎������X�܂Œ��ׂ��I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 140   #�e���v�e�[�V����
        action = premess + "�A\n\m#{targetname}�ɉ��߂������̋�𖣂������I"
        avoid = "������#{myname}�ɂ͌����Ȃ������I"
  #------------------------------------------------------------------------#
      when 145   #�K�[�h
        action = premess + "�g�\�����I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 146   #�C���f���A
        action = premess + "�ڂ���A�ӎ����W���������I"
        avoid = ""
  #------------------------------------------------------------------------#
      when 148   #�A�s�[��
        case $data_classes[myself.class_id].name
        when "���b�T�[�T�L���o�X"
          action = premess + "�v�킹�Ԃ�ȑԓx��������I"
        when "�T�L���o�X" #
          action = premess + "�v�킹�Ԃ�ȑԓx��������I"
        when "�C���v" #
          action = premess + "��ڎg���Ŗ����ɗV��łƂ����񂾁I"
        when "�f�r��" #
          action = premess + "��������悤�ȑԓx��������I"
        when "�X���C��" #
          action = premess + "�v�킹�Ԃ�ȑԓx��������I"
        when "�i�C�g���A" #
          action = premess + "�Ƃ��Ƃ����ڂŖ�����U�����I"
        when "�L���X�g" #
          action = premess + "�킴�Ƌ������ӂ�������I"
          action = premess + "���h���Ȏp�Ŗ�����U�����I" if myself.nude?
        when "�v�`�E�B�b�`" #
          action = premess + "��������悤�ȑԓx��������I"
        when "�E�B�b�`" #
          action = premess + "��������悤�ȑԓx��������I"
        when "�t�@�~���A" #
          action = premess + "�h���X�̐����������グ�Č������I"
          action = premess + "���h���Ȏp�Ŗ�����U�����I" if myself.nude?
        when "���j�[�N�T�L���o�X" #
          action = premess + "�v�킹�Ԃ�ȑԓx��������I"
        else
          action = premess + "�v�킹�Ԃ�ȑԓx��������I"
        end
        n = 0
=begin
        s_range = myself.is_a?(Game_Enemy) ? $game_troop.enemies : $game_party.party_actors
        for i in s_range
          if i.exist?
            n += 1
          end
        end
        s_range_text = n > 1 ? "����" : ""
        action += "\n\m����#{s_range_text}�̋�����#{myname}�Ɉڂ����I" if myself.is_a?(Game_Actor)
        action += "\n\m#{$game_actors[101].name}#{s_range_text}�͖ڂ����������Ă��܂����I" if myself.is_a?(Game_Enemy)
=end
        avoid = ""
      when 149   #�v�����H�[�N
          action = premess + "����̑_���������������I"
        
        
  #------------------------------------------------------------------------#        
      when 260   #�i���
        action = premess + "\n\m#{targetname}�̑̂��Ȃ���i��߂������I"
  #------------------------------------------------------------------------#        
      when 261   #��قǂ�
        action = premess + "\n\m#{targetname}�̎������قǂ��������I"
  #------------------------------------------------------------------------#        
      when 262   #�Â₩��
        action = premess + "\n\m#{targetname}�̓��������ƕ��ŊÂ₩�����I"
  #------------------------------------------------------------------------#        
      when 263   #�X�p���N
        action = premess + "\n\m#{targetname}�̂��K�𐨂��ǂ��@�����I"
  #------------------------------------------------------------------------#        
      when 275   #�₯�����R�A��
        action = premess + "�k���Ȃ���ジ��������Ă���I"
  #------------------------------------------------------------------------#        
      when 276   #�q�[���[�L�����O
        action = premess + "�E�ӂ����߂��r��U�肩�Ԃ����I\n\m�h����f�₷��ꌂ��#{targetname}�ɕ������I�I"
  #------------------------------------------------------------------------#        
      when 277   #���e�I�G�N���v�X
        action = premess + "��ł̖��@���r�������I\n\m�V�͊��ꐯ�͍ӂ��A��ł̎ܔM�����E�����ݍ��ށI"
  #------------------------------------------------------------------------#        
      when 278   #���[���h�u���C�J�[
        action = premess + "����Ȗ��͂���o�����I\n\m�S�l�ނ̊�]���A�E�C���A�������I\n\m�Ռ`���������苎��I�I"
  #------------------------------------------------------------------------#        
      when 297   #�t�B�A�[(�ؕ|���s������)
        action = premess + "�g�̂��v���悤�ɓ����Ȃ��I"
  #------------------------------------------------------------------------#        
      when 298   #�t���[�A�N�V����
        case $data_classes[myself.class_id].name
        when "���b�T�[�T�L���o�X"
          action = premess + "�A\n\m#{targetname}�̎��͂��щ���Ă���c�c"
          action = premess + "�A\n\m�H���𓮂����ėV��ł���c�c" if $game_variables[17] >= 50
        when "�T�L���o�X" #
          action = premess + "���f�I�ȏ΂݂𕂂��ׂĂ���c�c"
          action = premess + "�����̐K���̎��������Ă���c�c" if $game_variables[17] >= 50
        when "�T�L���o�X���[�h" #
          action = premess + "���f�I�ȏ΂݂𕂂��ׂĂ���c�c"
          action = premess + "�����̐K���̎��������Ă���c�c" if $game_variables[17] >= 50
        when "�C���v" #
          action = premess + "�A\n\m#{targetname}�̎��͂��щ���Ă���c�c"
          action = premess + "�A\n\m�H���𓮂����ėV��ł���c�c" if $game_variables[17] >= 50
        when "�f�r��" #
          action = premess + "�l���݂�����悤�ɁA\n\m#{targetname}���ώ@���Ă���c�c"
          action = premess + "#{targetname}�ɁA\n\m�d�����ȏ΂݂������Ă���c�c" if $game_variables[17] >= 50
        when "�f�[����" #
          action = premess + "�l���݂�����悤�ɁA\n\m#{targetname}���ώ@���Ă���c�c"
          action = premess + "#{targetname}�ɁA\n\m�d�����ȏ΂݂������Ă���c�c" if $game_variables[17] >= 50
        when "�X���C��" #
          action = premess + "�g�̂��Ղ�Ղ�U��킹�Ă���c�c"
          action = premess + "�A\n\m�����̐g�̂�F�X�Ȍ`�ɕς��ėV��ł���c�c" if $game_variables[17] >= 50
        when "�S�[���h�X���C��" #
          action = premess + "�g�̂��Ղ�Ղ�U��킹�Ă���c�c"
          action = premess + "�A\n\m�����̐g�̂�F�X�Ȍ`�ɕς��ėV��ł���c�c" if $game_variables[17] >= 50
        when "�i�C�g���A" #
          action = premess + "������ڂ���ƌ��߂Ă���c�c"
          action = premess + "�������ȓ��ŁA\n\m#{targetname}�̊�����߂Ă���c�c" if $game_variables[17] >= 50
        when "�L���X�g" #
          action = premess + "���̗���𒼂��Ă���c�c" if not myself.nude?
          action = premess + "�v���o�������̂悤�ɁA\n\m�Q�Ăĕ��̗���𒼂��n�߂��c�c" if not myself.nude? and $mood.point > 25
          action = premess + "���������킻�킵�Ă���c�c" if myself.nude?
        when "�X���C��" #
          action = premess + "���̗���𒼂��Ă���c�c" if not myself.nude?
          action = premess + "�v���o�������̂悤�ɁA\n\m�Q�Ăĕ��̗���𒼂��n�߂��c�c" if not myself.nude? and $mood.point > 25
          action = premess + "���������킻�킵�Ă���c�c" if myself.nude?
        when "�v�`�E�B�b�`" #
          action = premess + "�l���݂�����悤�ɁA\n\m#{targetname}���ώ@���Ă���c�c"
          action = premess + "�X�q�̎������n�߂��c�c" if $game_variables[17] >= 50
        when "�E�B�b�`" #
          action = premess + "�l���݂�����悤�ɁA\n\m#{targetname}���ώ@���Ă���c�c"
          action = premess + "�X�q�̎������n�߂��c�c" if $game_variables[17] >= 50
        when "�t�@�~���A" #
          action = premess + "#{targetname}�̗l�q���M���A\n\m�����l������ł���c�c"
          action = premess + "�����ƒ��߂̗���𒼂����c�c" if not myself.nude?
          action = premess + "�Â��ɂ�������ł���c�c" if $game_variables[17] >= 50
        when "���[�E���t" #
          action = premess + "�X�萺���グ�Ă���c�c"
          action = premess + "�K����U���Ă���c�c" if $game_variables[17] >= 50
        when "���[�L���b�g" #
          action = premess + "�ёU�������Ă���c�c"
          action = premess + "���낲��ƍA��炵�Ă���c�c" if $game_variables[17] >= 50
        when "�S�u����" #
          action = premess + "�l�q���M���Ă���c�c"
          action = premess + "�^�������ɁA\n\m#{targetname}�̊�����߂Ă���c�c" if $game_variables[17] >= 50
        when "�M�����O�R�}���_�[" #
          action = premess + "�l�q���M���Ă���c�c"
          action = premess + "�^�������ɁA\n\m#{targetname}�̊�����߂Ă���c�c" if $game_variables[17] >= 50
        when "�v���[�X�e�X" #
          action = premess + "�l�q���M���Ă���c�c"
          action = premess + "���̗���𒼂��Ă���c�c" if not myself.nude?
          action = premess + "��W�Ȗڂ��ŁA\n\m#{targetname}�����߂Ă���c�c" if $game_variables[17] >= 50
        when "�J�[�X���C�K�X" #
          action = premess + "�l���݂�����悤�ɁA\n\m#{targetname}���ώ@���Ă���c�c"
          action = premess + "#{targetname}�ɁA\n\m�d�����ȏ΂݂������Ă���c�c" if $game_variables[17] >= 50
        when "�A�����E�l" #
          action = premess + "�j�R���Ɣ��΂𕂂��ׂ��c�c"
          action = premess + "�s�G�ȏ΂݂𕂂��ׂĂ���c�c" if $game_variables[17] >= 50
        when "�}�^���S" #
          action = premess + "���̗���𒼂��Ă���c�c" if not myself.nude?
          action = premess + "�v���o�������̂悤�ɁA\n\m�Q�Ăĕ��̗���𒼂��n�߂��c�c" if not myself.nude? and $mood.point > 25
          action = premess + "���������킻�킵�Ă���c�c" if myself.nude?
        when "�_�[�N�G���W�F��" #
          action = premess + "�������ڂ��Ŕ��΂�ł���c�c"
          action = premess + "�s�G�ȏ΂݂𕂂��ׂĂ���c�c" if $game_variables[17] >= 50
        when "�K�[�S�C��" #
          action = premess + "�x������悤�ɁA\n\m#{targetname}���ώ@���Ă���c�c"
          action = premess + "��W�Ȗڂ��ŁA\n\m#{targetname}�����߂Ă���c�c" if $game_variables[17] >= 50
        when "�~�~�b�N" #
          action = premess + "���f�I�ȏ΂݂𕂂��ׂĂ���c�c"
          action = premess + "�󔠂̒����m�F���Ă���c�c" if $game_variables[17] >= 50
        when "�^�}��" #
          action = premess + "�l���݂�����悤�ɁA\n\m#{targetname}���ώ@���Ă���c�c"
          action = premess + "�����ƐK����h�炵�Ă���c�c" if $game_variables[17] >= 50
        when "������"
          action = premess + "�A\n\m#{targetname}�̎��͂��щ���Ă���c�c"
          action = premess + "���f�I�ȏ΂݂𕂂��ׂĂ���c�c"if $game_variables[17] >= 50
        else
          action = premess + "�l�q���M���Ă���c�c"
          # ���j�[�N�G�l�~�[
          case $data_classes[myself.class_id].color
          when "�l�C�W�������W"
            action = premess + "�j�R���Ɣ��΂𕂂��ׂ��c�c"
            action = premess + "�����Ɨh��Ă���c�c" if $game_variables[17] >= 50
          when "���W�F�I"
            action = premess + "�l�q���M���Ă���c�c"
            action = premess + "�l���݂�����悤�ɁA\n\m#{targetname}���ώ@���Ă���c�c" if $game_variables[17] >= 50
          when "�t���r���A"
            action = premess + "�����I�Ȗڂ��ŁA\n\m#{targetname}�����Ă���c�c"
            action = premess + "�s�G�ȏ΂݂𕂂��ׂĂ���c�c" if $game_variables[17] >= 50
          when "�M���S�[��"
            action = premess + "�x������悤�ɁA\n\m#{targetname}���ώ@���Ă���c�c"
            action = premess + "���̗���𒼂��Ă���c�c" if not myself.nude?
            action = premess + "�v���o�������̂悤�ɁA\n\m�Q�Ăĕ��̗���𒼂��n�߂��c�c" if not myself.nude? and $mood.point > 25
            action = premess + "���������킻�킵�Ă���c�c" if myself.nude?
            # ���E���
            if $game_switches[395]
              action = premess + "���΂������Ă���c�c"
            # ���E�j����
            elsif $game_switches[394]
              action = premess + "�k���Ă���c�c"
            end
          when "���[�K�m�b�g"
            action = premess + "�G��ɐ����|���Ă���c�c"
            action = premess + "#{targetname}�ɁA\n\m�d�����ȏ΂݂������Ă���c�c" if $game_variables[17] >= 50
          when "�V���t�F"
            action = premess + "�j�R���Ɣ��΂𕂂��ׂ��c�c"
            action = premess + "���f�I�ȏ΂݂𕂂��ׂĂ���c�c" if $game_variables[17] >= 50
          when "���[�~��"
            action = premess + "�������ڂ��Ŕ��΂�ł���c�c"
            action = premess + "�f����R�炵�Ă���c�c" if $game_variables[17] >= 50
          when "���F���~�B�[�i"
            action = premess + "�����I�Ȗڂ��ŁA\n\m#{targetname}�����Ă���c�c"
            action = premess + "�s�G�ȏ΂݂𕂂��ׂĂ���c�c" if $game_variables[17] >= 50
          end
        end
        if myself.holding?
#          action = premess + "���������΂��Ă���c�c"
          action = premess + "�g�ウ���Ă���c�c" if myself.crisis?
        end
        avoid = ""
  #------------------------------------------------------------------------#        
      when 299   #�G���[�V����
        case myself.personality
        when "�D�F"
          if target.holding?
            action = premess + "�����������肽�����ɁA\n\m#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "���������΂��Ă���c�c"
            action = premess + "�d�����΂݂𕂂��ׁA\n\m#{targetname}�̗������߂Ă���c�c" if $game_variables[17] >= 50 and target.nude?
          end
        when "��i" #
          if target.holding?
            action = premess + "�s�ׂ��C�ɂȂ�̂��A\n\m#{targetname}�B�����ڂŊώ@���Ă���c�c"
          else
            action = premess + "�_�炩�����΂𕂂��ׂĂ���c�c"
            action = premess + "���񂾓��ŁA\n\m#{targetname}�����߂Ă���c�c" if $game_variables[17] >= 50 and myself.crisis?
          end
        when "����" #
          if target.holding?
            action = premess + "���G�ȕ\��ŁA\n\m#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "�������悤�Ȏ����ŁA\n\m#{targetname}���ɂ�ł���c�I"
            action = premess + "���炿��Ɖ��ڂŁA\n\m#{targetname}�̗l�q�����������Ă���c�c" if $mood.point > 24
            action = premess + "�����ɋC�Â��ƁA\n\m#{targetname}����Ղ��Ɩڂ���炵���c�c" if $mood.point > 49
          end
        when "�W��" #
          if target.holding?
            action = premess + "�w�����킦�āA\n\m#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "���邭��Ɣ����w�ɗ��߂Ă���c�c"
            action = premess + "�ڂ���āA\n\m�������v���ɒ^���Ă���c�c" if $game_variables[17] >= 50
          end
        when "�_�a" #
          if target.holding?
            action = premess + "���΂𕂂��ׂāA\n\m#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "�_�炩�����΂𕂂��ׂĂ���c�c"
          end
        when "�����C" #
          if target.holding?
            action = premess + "����z���ꂽ�Ƃ΂���ɁA\n\m#{targetname}�B�����ĉ��������Ă���c�c"
          else
            action = premess + "���ނ悤�ȖڂŁA\n\m#{targetname}�̗l�q���f���Ă���c�c"
          end
        when "���C" #
          if target.holding?
            action = premess + "��𗼎�ŕ����āA\n\m#{targetname}�B�̍s�ׂ����Ȃ��悤�ɂ��Ă���c�c"
            action = premess + "��𗼎�ŕ������A\n\m���Ԃ���#{targetname}�B�̍s�ׂ����Ă���c�c" if $mood.point > 24
            action = premess + "�H������悤�ɁA\n\m#{targetname}�B�̍s�ׂ����Ă���c�c" if $mood.point > 49
          else
            action = premess + "���ނ��āA\n\m�����������������ɂ��Ă���c�c"
            action = premess + "�p�����������ɁA\n\m#{targetname}����ڂ���炵�Ă���c�c"
            action = premess + "�����������Ȃ���A\n\m#{targetname}�����߂Ă���c�c" if $mood.point > 24
          end
        when "�z�C" #
          if target.holding?
            action = premess + "�����������肽�����ɁA\n\m#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "���ʂ̏Ί�ŁA\n\m#{targetname}�̊��`������ł���c�c"
          end
        when "�Ӓn��" #
          if target.holding?
            action = premess + "�s�ׂ��C�ɂȂ�̂��A\n\m#{targetname}�B�����ڂŊώ@���Ă���c�c"
          else
            action = premess + "���₩�ȖڂŁA\n\m#{targetname}�̗l�q���M���Ă���c�c"
            action = premess + "�������v�������悤�ɁA\n\m�j�����Ə΂݂𕂂��ׂ��c�c" if $game_variables[17] >= 50
          end
        when "�V�R" #
          action = premess + "�ځ[���Ɨ]���������Ă���c�c"
        when "�]��" #
          if target.holding?
            action = premess + "�w�����킦�āA\n\m#{targetname}�B�̍s�ׂ������ƌ��߂Ă���c�c"
          else
            action = premess + "�A\n\m#{targetname}����̓�����������Ă���c�c"
          end
        when "����" #
          if target.holding?
            action = premess + "�s�ׂ��C�ɂȂ�̂��A\n\m#{targetname}�B�����ڂŊώ@���Ă���c�c"
            action = premess + "�H������悤�ɁA\n\m#{targetname}�B�̍s�ׂ����Ă���c�c" if $mood.point > 24
          else
            action = premess + "���M���X�̊�ŁA\n\m�s�G�ȏ΂݂𕂂��ׂĂ���c�c"
            action = premess + "�S�Ȃ������킻�킵�Ă���c�c" if $mood.point > 24
            action = premess + "���̂������ӂ����Ă���c�c" if $mood.point > 49
          end
        when "�|��" #
          if target.holding?
            action = premess + "�d�����΂݂𕂂��ׂāA\n\m#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "���������΂��Ă���c�c"
          end
        when "�Â���" #
          if target.holding?
            action = premess + "�����ÁX�̖ڂŁA\n\m#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "�����ÁX�̖ڂŁA\n\m#{targetname}�����߂Ă���c�c"
          end
        when "�s�v�c" #
          if target.holding?
            action = premess + "�����l���Ă��邩����Ȃ��\��ŁA\n\m#{targetname}�B�̍s�ׂ������낵�Ă���c�c"
          else
            action = premess + "�����v�����̂��A\n\m���˂ɂ��̏�ł����Ɨx��n�߂��c�c"
          end
        when "�ƑP" #�t���r���A��p
          if target.holding?
            action = premess + "#{targetname}�̎����ɋC�t���A\n\m��l�[�������悤�ɔ��΂񂾁c�c"
          else
            action = premess + "#{targetname}�̎����ɋC�t���A\n\m��l�[�������悤�ɔ��΂񂾁c�c"
          end
        else
          action = premess + "���������΂��Ă���c�c"
        end
        if myself.holding?
          action = premess + "���������΂��Ă���c�c"
          action = premess + "�g�ウ���Ă���c�c" if myself.crisis?
        end
        avoid = ""
  #------------------------------------------------------------------------#
  # ���L�b�X�n
  #------------------------------------------------------------------------#
      when 301   #�L�b�X��
        case myself.personality
        when "�W��", "���C"
          action = premess + "�A\n\m#{targetname}�̐O�ɂ����ƐO���d�˂Ă����I"
        else
          action = premess + "�A\n\m#{targetname}�ɂ����ƃL�X�����Ă����I"
        end
      when 302   #�L�b�X��
        case myself.personality
        when "�W��", "���C"
          action = premess + "�ڂ���āA\n\m#{targetname}�ɂ����ƃL�X�����Ă����I"
        else
          action = premess + "�A\n\m#{targetname}�ɃL�X�����Ă����I"
        end
      when 303   #�L�b�X��
        case myself.personality
        when "�W��", "���C", "����"
          action = premess + "�ڂ���āA\n\m#{targetname}�Ɖ��x���L�X���J��Ԃ��Ă����I"
        else
          action = premess + "��𗍂߂�悤�ɁA\n\m#{targetname}�ɏ�M�I�ȃL�X�����Ă����I"
        end
      when 304   #�L�b�X�K�E
        case myself.personality
        when "�W��", "���C", "����"
          action = premess + "����񂾓��ŁA\n\m�Â�悤��#{targetname}�ɃL�X�����Ă����I"
        else
          action = premess + "��𗍂߂�悤�ɁA\n\m#{targetname}�ɏ�M�I�ȃL�X�����Ă����I"
        end
      when 305   #�L�b�X�ǌ�
        case myself.personality
        when "�W��", "���C", "����"
          action = premess + "��ڌ����ɁA\n\m���x��#{targetname}�ɃL�X���d�˂Ă����I"
        else
          action = premess + "�Ȃ����������A\n\m#{targetname}�ɏ�M�I�ȃL�X���d�˂Ă����I"
        end
      when 308   #���u���B�L�b�X
        action = premess + "���炵�����΂�ŁA\n\m#{targetname}�ɂ����ƃL�X�����Ă����I"
      when 309   #���}���X�L�b�X
        action = premess + "���΂݂𕂂��ׁA\n\m#{targetname}�Ə�M�I�ȃL�X�����킵���I"
      when 310   #�t�@�V�l�C�g�L�b�X
        action = premess + "�d���ȏ΂݂𕂂��ׁA\n\m#{targetname}������񂹂Ă��̐O��D�����I"
  #------------------------------------------------------------------------#
  # ����Z�n
  #------------------------------------------------------------------------#
      when 319   #��U�߃y�j�X��
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̃y�j�X�ɗD�����G��Ă����I"
          action = premess + "�w�ŁA\n\m#{targetname}�̃y�j�X�ɗD�����G��Ă����I" if $game_variables[17] > 50
          action += "\n\m�ʂ߂��тт��y�j�X�ɉ��������ݏグ��I" if target.lub_male >= 60
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃y�j�X�ɂ����ƐG��Ă����I"
        end
      when 320   #��U�߃y�j�X
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̃y�j�X�𕏂łĂ����I"
          action = premess + "�w��ŁA\n\m#{targetname}�̃y�j�X�𕏂łĂ����I" if $game_variables[17] > 50
          action += "\n\m�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃y�j�X�𕏂łĂ����I"
        end
      when 321   #��U�߃y�j�X��
        if target.nude?
          #�e�L�X�g����
          action = premess + "#{tec}�A\n\m���#{targetname}�̃y�j�X�𕏂ŉ񂵂��I"
          action = premess + "#{tec}�A\n\�w���#{targetname}�̃y�j�X�𕏂ŉ񂵂��I" if $game_variables[17] > 50
          action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
          action.gsub!("�l�q��","�����") #�\���̕ύX
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̃y�j�X�𕏂ŉ񂵂��I"
        end
      when 322   #��U�߃y�j�X�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃y�j�X���v���܂ܘM�ԁI"
          action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
          action.gsub!("�l�q��","�����") #�\���̕ύX
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̃y�j�X�𕏂ŉ񂵂��I"
        end
      when 323   #��U���Ίۏ�
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̑܂�D�����������Ă����I"
          action = premess + "�w��ŁA\n\m#{targetname}�̑܂�D�������łĂ����I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̑܂���ł������Ă����I"
        end
      when 324   #��U���ΊەK�E
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̑܂𕏂ŉ񂵂Ă����I"
          action = premess + "�w��ŁA\n\m#{targetname}�̑܂�D��������ł����I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̑܂���ŕ��ŉ񂵂��I"
        end
      when 325   #��U�߃y�j�X�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃y�j�X���X�Ɉ��������I"
          action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
        else
          action = premess + "���荞�܂�����ŁA\n\m#{targetname}�̃y�j�X���X�ɘM���Ă����I"
        end
      when 326   #��U���Ίےǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̑܂��X�ɕ��ŉ񂵂Ă����I"
        else
          action = premess + "���荞�܂�����ŁA\n\m#{targetname}�̑܂��X�ɕ��ŉ񂵂Ă����I"
        end
  #------------------------------------------------------------------------#
      when 328   #��U�ߋ���
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}��#{target.bustsize}��#{brk3}�D�����G��Ă����I"
          action = premess + "��ŁA\n\m#{targetname}�̓���ɗD�����G��Ă����I" if target.boy?
        else
          action = premess + "���̏ォ��A\n\m#{targetname}��#{target.bustsize}��#{brk3}��ŗD�����G��Ă����I"
        end
        #���T�C�Y�f�f(�b�J�b�v�)
        case $data_SDB[target.class_id].bust_size
        when 4,5 #�c,�d
          action.gsub!("��������","�����") 
        end
      when 329   #��U�ߋ�
        if target.nude?
          action = premess + "����ŁA\n\m#{targetname}��#{target.bustsize}��#{brk3}���݂������Ă����I"
          action = premess + "�w��ŁA\n\m#{targetname}�̓�����h�����Ă����I" if target.boy?
        else
          action = premess + "���̏ォ��A\n\m#{targetname}��#{target.bustsize}��#{brk3}��ŕ��ŉ񂵂Ă����I"
        end
        #���T�C�Y�f�f(�b�J�b�v�)
        case $data_SDB[target.class_id].bust_size
        when 1,2 #�`,�a
          action.gsub!("���݂�������","�����") 
        end
      when 330   #��U�ߋ���
        if target.nude?
          action = premess + "�w��ŁA\n\m#{targetname}�̓�����܂ݎh�����Ă����I"
          action = premess + "�w��ŁA\n\m#{targetname}�̓�����I�݂Ɏh�����Ă����I" if target.boy?
        else
          action = premess + "���Ɏ�����荞�܂��A\n\m#{targetname}��#{target.bustsize}��#{brk3}���݂������Ă����I"
        end
        #���T�C�Y�f�f(�b�J�b�v�)
        case $data_SDB[target.class_id].bust_size
        when 1,2 #�`,�a
          action.gsub!("���݂�������","�����") 
        end
      when 331   #��U�ߋ��K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}��#{target.bustsize}��#{brk3}�v���܂ܘM�ԁI"
          action = premess + "#{tec}�A\n\m#{targetname}�̓�����I�݂Ɏh�����Ă����I" if target.boy?
          action.gsub!("�l�q��","�����") #�\���̕ύX
        else
          action = premess + "���Ɏ�����荞�܂��A\n\m#{targetname}��#{target.bustsize}��#{brk3}�v���܂ܘM�ԁI"
        end
      when 332   #��U�ߋ��ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}��#{target.bustsize}��#{brk3}�X�ɝ��݂��������I"
          action = premess + "#{tec}�A\n\m#{targetname}�̓�����I�݂Ɏh�����Ă����I" if target.boy?
        else
          action = premess + "���Ɋ��荞�܂�����ŁA\n\m#{targetname}��#{target.bustsize}���X�ɘM�ԁI"
        end
        #���T�C�Y�f�f(�b�J�b�v�)
        case $data_SDB[target.class_id].bust_size
        when 1,2 #�`,�a
          action.gsub!("���݂�������","����ł���") 
        end
  #------------------------------------------------------------------------#
      when 334   #��U�߃A�\�R��
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̃A�\�R�ɗD�����G��Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃A�\�R�ɗD�����G��Ă����I"
        end
      when 335   #��U�߃A�\�R
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̃A�\�R�𕏂łĂ����I"
          action = premess + "�w��ŁA\n\m#{targetname}�̃A�\�R�̓������#{brk4}�������Ă����I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃A�\�R�𕏂łĂ����I"
        end
      when 336   #��U�߃A�\�R��
        if target.nude?
          action = premess + "�w���A\n\m#{targetname}�̃A�\�R�̉��܂œ���Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̃A�\�R���w�ň������Ă����I"
        end
      when 337   #��U�߃A�\�R�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃A�\�R���v���܂ܘM�ԁI"
          action.gsub!("�l�q��","�����") if $game_variables[17] > 50 #��x�ύX����ƕύX�Ώە������Ȃ��Ȃ�̂ŏ����͐��
          action.gsub!("�l�q��","�w�g����") 
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̃A�\�R���v���܂ܘM�ԁI"
        end
      when 338   #��U�߉A�j��
        if target.nude?
          action = premess + "�w��ŁA\n\m#{targetname}�̉A�j��D�������łĂ����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̉A�j��D�������łĂ����I"
        end
      when 339   #��U�߉A�j
        if target.nude?
          action = premess + "�w��ŁA\n\m#{targetname}�̉A�j���������h�����Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̉A�j���h�����Ă����I"
        end
      when 340   #��U�߉A�j�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̉A�j���w�Ŏv���܂ܘM�ԁI"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̉A�j���w��ł܂݂������I"
        end
      when 341   #��U�߃A�\�R�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃A�\�R���X�ɍU�ߗ��Ă�I"
        else
          action = premess + "#{pantsu}�Ɋ��荞�܂�����ŁA\n\m#{targetname}�̃A�\�R���X�ɘM�ԁI"
        end
      when 342   #��U�߉A�j�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̉A�j���w��ŘM�ԁI"
        else
          action = premess + "#{pantsu}�Ɋ��荞�܂����w��ŁA\n\m#{targetname}�̉A�j���X�ɘM�ԁI"
        end
  #------------------------------------------------------------------------#
      when 344   #��U�ߐK��
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̂��K�������ƕ��łĂ����I"
        else
          action = premess + "#{pantsu}�z���ɁA\n\m#{targetname}�̂��K�������ƕ��łĂ����I"
        end
      when 345   #��U�ߐK
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̂��K�𝆂݂������Ă����I"
        else
          action = premess + "#{pantsu}�z���ɁA\n\m#{targetname}�̂��K�𝆂݂������Ă����I"
        end
      when 346   #��U�ߐK��
        if target.nude?
          action = premess + "����ŁA\n\m#{targetname}�̂��K���������݂������Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̂��K�𝆂݂������Ă����I"
        end
      when 347   #��U�ߐK�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̂��K���v���܂ܘM�ԁI"
          action.gsub!("�l�q��","�����") #�\���̕ύX
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̂��K���v���܂ܘM�ԁI"
        end
      when 348   #��U�ߑO���B��
        if target.nude?
          action = premess + "�w��ŁA\n\m#{targetname}�̋e�����h�����Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̋e�����h�����Ă����I"
        end
      when 349   #��U�ߑO���B
        if target.nude?
          action = premess + "�w��ŁA\n\m#{targetname}�̋e����h�����Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̋e����w�Ŏh�����Ă����I"
        end
      when 350   #��U�ߑO���B�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̋e����w�ň������Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m�w��#{targetname}�̋e����������Ă����I"
        end
      when 351   #��U�߃A�i����
        if target.nude?
          action = premess + "�w��ŁA\n\m#{targetname}�̋e�����h�����Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̋e�����h�����Ă����I"
        end
      when 352   #��U�߃A�i��
        if target.nude?
          action = premess + "�w��ŁA\n\m#{targetname}�̋e����h�����Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̋e����w�Ŏh�����Ă����I"
        end
      when 353   #��U�߃A�i���K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̋e����w�ň������Ă����I�I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m�w��#{targetname}�̋e����������Ă����I"
        end
      when 354   #��U�ߐK�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m�����#{targetname}�̂��K��M�ԁI"
        else
          action = premess + "#{pantsu}�Ɋ��荞�܂�����ŁA\n\m#{targetname}�̂��K���X�ɘM�ԁI"
        end
      when 355   #��U�ߑO���B�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m�w��#{targetname}�̋e����X�Ɉ������Ă����I"
        else
          action = premess + "#{pantsu}�Ɋ��荞�܂����w�ŁA\n\m#{targetname}�̋e����X�Ɉ������Ă����I"
        end
      when 356   #��U�߃A�i���ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m�w��#{targetname}�̋e����X�Ɉ������Ă����I"
        else
          action = premess + "#{pantsu}�Ɋ��荞�܂����w�ŁA\n\m#{targetname}�̋e����X�Ɉ������Ă����I"
        end
     #------------------------------------------------------------------------#
      when 359   #�Z�b�g�T�[�N��
        action = premess + "�����ɖ��@�w��`�����I"
      when 360   #�R�[���h�^�b�`
        points = ["���","�w��","������"]
        if myself.nude?
          points.push("�y�j�X","��") if myself.boy?
          points.push("�A�\�R","�A�j","��","����","���K") unless myself.boy?
        end
        points = points[rand(points.size)]
        action = premess + "�Ђ��肵����ŁA\n\m#{targetname}��#{points}�����������I"
        action = premess + "�Ђ��肵���w��ŁA\n\m#{targetname}��#{points}�����������I"
        avoid = ""
     #------------------------------------------------------------------------#
      when 361   #�T�f�B�X�g�J���X
        action = premess + "�Ӓn���Ȏ���ŁA\n\m#{targetname}�����������I"
     #------------------------------------------------------------------------#
      when 362   #�v���C�X�I�u�n����
        action = premess + "�A\n\m#{targetname + rangetext}�����܂˂����������I"
     #------------------------------------------------------------------------#
      when 363   #�v���C�X�I�u�V�i�[
        action = premess + "�A\n\m#{targetname + rangetext}�����܂˂����������I"
     #------------------------------------------------------------------------#
      when 364   #�y���\�i�u���C�N
        action = premess + "#{targetname}�̊�O�ŁA\n\m��������ׂ����I"
     #------------------------------------------------------------------------#
      when 365   #�L���X�g�R�[��
        action = "�����E��#{$game_actors[101].name}�̋L������\n�ߋ��̖ώ��𐶂ݏo�����I"
  #------------------------------------------------------------------------#
  # �����Z�n
  #------------------------------------------------------------------------#
      when 375   #���U�߃y�j�X��
        if target.nude?
          action = premess + "�O�ŁA\n\m#{targetname}�̃y�j�X�ɂ����ƐG��Ă����I"
          action = premess + "���ŁA\n\m#{targetname}�̃y�j�X���������r�߂Ă����I" if $game_variables[17] > 50
          action += "\n\m�ʂ߂��тт��y�j�X�ɉ��������ݏグ��I" if target.lub_male >= 60
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̌ҊԂɂ����ƃL�X���Ă����I"
        end
      when 376   #���U�߃y�j�X
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̃y�j�X���r�߂Ă����I"
          action = premess + "���ŁA\n\m#{targetname}�̃y�j�X���r�߂Ă����I" if $game_variables[17] > 50
          action += "\n\m�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̌ҊԂɃL�X���Ă����I"
        end
      when 377   #���U�߃y�j�X��
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃y�j�X�̐�[��#{brk4}�r�߉񂵂Ă����I"
          action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}�z���ɁA\n\m#{targetname}�̃y�j�X���r�ߏグ�Ă����I"
        end
      when 378   #���U�߃y�j�X�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃y�j�X��#{brk4}���������r�ߏグ�Ă����I"
          action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}�z���ɁA\n\m#{targetname}�̃y�j�X���r�߉񂵂Ă����I"
        end
      when 379   #���U���Ίۏ�
        if target.nude?
          action = premess + "�O�ŁA\n\m#{targetname}�̑܂�D�����z���グ�Ă����I"
        else
          action = premess + "#{pantsu}�z���ɁA\n\m#{targetname}�̑܂ɃL�X���Ă����I"
        end
      when 380   #���U���ΊەK�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̑܂��r�߉񂵂Ă����I"
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}�z���ɁA\n\m#{targetname}�̑܂��r�߉񂵂Ă����I"
        end
      when 381   #���U�߃y�j�X�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃y�j�X���X���r�ߏグ�Ă����I"
          action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
        else
          action = premess + "�Ȃ���#{pantsu}�z���ɁA\n\m#{targetname}�̃y�j�X���r�߉񂵂Ă����I"
        end
      when 382   #���U���Ίےǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̑܂��X���r�ߏグ�Ă����I"
        else
          action = premess + "�Ȃ���#{pantsu}�z���ɁA\n\m#{targetname}�̑܂��r�߉񂵂Ă����I"
        end
  #------------------------------------------------------------------------#
      when 384   #���U�ߋ���
        if target.nude?
          action = premess + "�O�ŁA\n\m#{targetname}��#{target.bustsize}��#{brk3}�����ƃL�X���Ă����I"
        else
          action = premess + "���̏ォ��A\n\m#{targetname}��#{target.bustsize}��#{brk3}�����ƃL�X���Ă����I"
        end
      when 385   #���U�ߋ�
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}��#{target.bustsize}��#{brk3}�Ȃ����Ă����I"
          action = premess + "���ŁA\n\m#{targetname}��#{target.bustsize}��#{brk3}�r�߂Ă����I" if $game_variables[17] > 50
        else
          action = premess + "���̏ォ��A\n\m#{targetname}��#{target.bustsize}�ɃL�X���Ă����I"
        end
      when 386   #���U�ߋ���
        if target.nude?
          action = premess + "���ŁA\n\m#{targetname}��#{target.bustsize}��#{brk3}�r�߉񂵂Ă����I"
          action = premess + "#{tec}�A\n\m#{targetname}�̓�����r�߉񂵂Ă����I" if $game_variables[17] > 50
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "���̌��Ԃ���A\n\m#{targetname}��#{target.bustsize}���r�߉񂵂Ă����I"
        end
      when 387   #���U�ߋ��K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}��#{target.bustsize}��#{brk3}�����z���グ�Ă����I"
          action = premess + "#{tec}�A\n\m#{targetname}�̓���������z���グ�Ă����I" if $game_variables[17] > 50
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "���̌��Ԃ���A\n\m#{targetname}��#{target.bustsize}�������z���Ă����I"
        end
      when 388   #���U�ߋ��ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}��#{target.bustsize}��#{brk3}�X���r�߉񂵂��I"
          action = premess + "#{tec}�A\n\m#{targetname}�̓�����X�ɋz���グ���I" if $game_variables[17] > 50
        else
          action = premess + "���̌��Ԃ���A\n\m#{targetname}��#{target.bustsize}���X�ɋ����z���Ă����I"
        end
  #------------------------------------------------------------------------#
      when 390   #���U�߃A�\�R��
        if target.nude?
          action = premess + "�O�ŁA\n\m#{targetname}�̃A�\�R�ɂ����ƃL�X���Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃A�\�R�ɂ����ƃL�X���Ă����I"
        end
      when 391   #���U�߃A�\�R
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̃A�\�R���r�߂Ă����I"
          action = premess + "�O�ŁA\n\m#{targetname}�̃A�\�R�ɃL�X�����Ă����I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃A�\�R���r�߂Ă����I"
        end
      when 392   #���U�߃A�\�R��
        if target.nude?
          action = premess + "�������ڂ߁A\n\m#{targetname}�̃A�\�R�ɑ}��Ă����I"
          action = premess + "#{tec}�A\n\m#{targetname}�̃A�\�R�������z���グ���I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�����炵�A\n\m#{targetname}�̃A�\�R���r�߉񂵂Ă����I"
        end
      when 393   #���U�߃A�\�R�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃A�\�R���v���܂ܘM�ԁI"
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}���ƁA\n\m#{targetname}�̃A�\�R�ɐ��˂�����Ă����I"
        end
      when 394   #���U�߉A�j��
        if target.nude?
          action = premess + "���ŁA\n\m#{targetname}�̉A�j��D�����������Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̉A�j����ň������Ă����I"
        end
      when 395   #���U�߉A�j
        if target.nude?
          action = premess + "���ŁA\n\m#{targetname}�̉A�j���r�ߏグ�Ă����I"
        else
          action = premess + "#{pantsu}�����炵�A\n\m#{targetname}�̉A�j���r�ߏグ�Ă����I"
        end
      when 396   #���U�߉A�j�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̉A�j���v���܂ܘM�ԁI"
        else
          action = premess + "#{pantsu}���ƁA\n\m#{targetname}�̉A�j��O�ŋz���グ���I"
        end
      when 397   #���U�߃A�\�R�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃A�\�R�����X���r�ߏグ��I"
        else
          action = premess + "#{tec}�A\n\m#{targetname}�̃A�\�R��#{pantsu}�z���ɘM�ԁI"
        end
      when 398   #���U�߉A�j�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m����#{targetname}�̉A�j�����X�ɘM�ԁI"
        else
          action = premess + "#{tec}�A\n\m#{pantsu}����#{targetname}�̉A�j��O�ŋz���グ��I"
        end
  #------------------------------------------------------------------------#
      when 400   #���U�ߐK��
        if target.nude?
          action = premess + "�O�ŁA\n\m#{targetname}�̂��K�ɂ����ƃL�X�����Ă����I"
        else
          action = premess + "#{pantsu}�z���ɁA\n\m#{targetname}�̂��K�ɂ����ƃL�X�����Ă����I"
        end
      when 401   #���U�ߐK
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̂��K���r�ߏグ�Ă����I"
        else
          action = premess + "#{pantsu}�z���ɁA\n\m#{targetname}�̂��K���r�ߏグ�Ă����I"
        end
      when 402   #���U�ߐK��
        if target.nude?
          action = premess + "�O�ŁA\n\m#{targetname}�̂��K�ɊÊ��݂��Ă����I"
        else
          action = premess + "#{pantsu}���ƁA\n\m�O��#{targetname}�̂��K�ɊÊ��݂��Ă����I"
        end
      when 403   #���U�ߐK�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̂��K���r�߉񂵂Ă����I"
        else
          action = premess + "#{pantsu}�����ł��炵�A\n\m#{targetname}�̂��K���r�߉񂵂Ă����I"
        end
      when 404   #���U�ߑO���B��
        if target.nude?
          action = premess + "���ŁA\n\m#{targetname}�̑O���B���h�����Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̋e�����h�����Ă����I"
        end
      when 405   #���U�ߑO���B
        if target.nude?
          action = premess + "���ŁA\n\m#{targetname}�̋e�����ӂ��r�߉񂵂Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̋e����Ŏh�����Ă����I"
        end
      when 406   #���U�ߑO���B�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̋e��̉��܂Ő�����Ă����I"
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}���ƁA\n\m#{targetname}�̋e��̉��܂Ő�����Ă����I"
        end
      when 407   #���U�߃A�i����
        if target.nude?
          action = premess + "���ŁA\n\m#{targetname}�̋e�����h�����Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̋e�����h�����Ă����I"
        end
      when 408   #���U�߃A�i��
        if target.nude?
          action = premess + "���ŁA\n\m#{targetname}�̋e����ӂ��r�߉񂵂Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̋e����Ŏh�����Ă����I"
        end
      when 409   #���U�߃A�i���K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̋e��̉��܂Ő�����Ă����I"
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}���ƁA\n\m#{targetname}�̋e��̉��܂Ő�����Ă����I"
        end
      when 410   #���U�ߐK�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m���#{targetname}�̂��K�����X���r�߉񂷁I"
        else
          action = premess + "#{tec}�A\n\m#{targetname}�̂��K���X���r�߉񂵂Ă����I"
        end
      when 411   #���U�ߑO���B�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̋e����ň������Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̋e��ɍX�ɐ�����Ă����I"
        end
      when 409   #���U�߃A�i���ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m�X��#{targetname}�̋e����ň������Ă����I"
        else
          action = premess + "#{pantsu}�����炵�A\n\m#{targetname}�̋e�������r�ߏグ�Ă����I"
        end
    #------------------------------------------------------------------------#
      when 415   #�n�E�����O
        action = premess + "���炩�ɗY���т��グ���I"
    #------------------------------------------------------------------------#
      when 416   #�����̌��t��
        action = premess + "#{targetname}�̐O��D�����I"
    #------------------------------------------------------------------------#
      when 417   #�j���̌��t��
        action = premess + "#{targetname}�̐O��D�����I"
    #------------------------------------------------------------------------#
      when 418   #�X�C�[�g�E�B�X�p�[
        action = premess + "#{targetname}�ɊÂ��������I"
    #------------------------------------------------------------------------#
      when 419   #�A�����b�L�[���A
        action = premess + "�s�g�ɖ����I"
    #------------------------------------------------------------------------#
      when 421   #�����Ȃ���
        action = premess + "�����ʂ������ŁA\n\m#{targetname}���ꊅ�����I"
  #------------------------------------------------------------------------#
  # �����Z�n
  #------------------------------------------------------------------------#
      #�p�C�Y���͗��җ����݂̂̂��߁A���߃e�L�X�g�͖���
      when 431   #�p�C�Y����
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̃y�j�X������ł����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɉ��������ݏグ��I" if target.lub_male >= 60
      when 432   #�p�C�Y��
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̃y�j�X�����݂������Ă����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 433   #�p�C�Y����
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̃y�j�X�����ˉ񂵂Ă����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 434   #�p�C�Y���K�E
        action = premess + "#{tec}�A\n\m#{myself.bustsize}�̒J�ԂɃy�j�X�����݁A\n\m#{targetname}�̔������y���݂Ȃ���M�ԁI"
        action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 435   #�C��t����
        action = premess + "#{myself.bustsize}���A\n\m#{targetname}�̃y�j�X�ɎC��t���Ă����I"
        #���T�C�Y�f�f(�J�b�v�w��A�b�ȏ�ɂ͕K�v�Ȃ�)
        case $data_SDB[myself.class_id].bust_size
        when 2 #�a
          action.gsub!("���A","�ŁA") 
          action.gsub!("�ɎC��t���Ă���","���������Ɗ撣���Ă���") 
        end
      when 436   #�p�C�Y���ǌ�
        action = premess + "#{tec}�A\n\m#{myself.bustsize}�ɋ��܂ꂽ�y�j�X��M�ԁI"
        action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 437   #�C��t�����ǌ�
        #���T�C�Y�f�f(�J�b�v�w��A�b�ȏ�ɂ͕K�v�Ȃ�)
        case $data_SDB[myself.class_id].bust_size
        when 2 #�a
          action = premess + "#{tec}�A\n\m#{myself.bustsize}�ōX�Ƀy�j�X���C��グ�Ă����I"
        else
          action = premess + "#{tec}�A\n\m#{myself.bustsize}���X�Ƀy�j�X�ɎC��t���Ă����I"
        end
  #------------------------------------------------------------------------#
      when 439   #�ςӂςӏ�
        #�ł炵�̂ݒ��߂ςӂςӂ����݂���
        if target.nude?
          action = premess + "#{myself.bustsize}�̒J�Ԃ��A\n\m#{targetname}�̊�ɉ����t���Ă����I"
        else
          action = premess + "��̖c��݂�\n\m#{targetname}�̊�ɉ������ĂĂ����I"
        end
        #���T�C�Y�f�f(�b�J�b�v�)
        case $data_SDB[myself.class_id].bust_size
        when 3 #�b
          action.gsub!("���","�`�̗ǂ����") 
        when 4 #�c
          action.gsub!("���","�L���ȓ��") 
        when 5 #�d�ȏ�
          action.gsub!("���","���|�I�ȓ��") 
        end
      when 440   #�ςӂς�
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̊���ݍ���ł����I"
      when 441   #�ςӂςӋ�
        action = premess + "#{myself.bustsize}�̒J�ԂɁA\n\m#{targetname}�̊������ŕ������߂Ă����I"
      when 442   #�ςӂςӕK�E
        action = premess + "#{myself.bustsize}�̒J�ԂɁA\n\m#{targetname}�̊�������#{brk4}�����������߂Ă����I"
      when 443   #������
        action = premess + "#{myself.bustsize}�ŁA\n\m#{targetname}�̊�ɕ������Ă����I"
      when 444   #�ςӂςӒǌ�
        action = premess + "#{tec}�A\n\m#{myself.bustsize}�̒J�Ԃ��X�ɉ����t���Ă����I"
      when 445   #�������ǌ�
        #���T�C�Y�f�f(�J�b�v�w��A�b�ȏ�ɂ͕K�v�Ȃ�)
        case $data_SDB[myself.class_id].bust_size
        when 2 #�a
          action = premess + "#{tec}�A\n\m#{myself.bustsize}�ōX�ɕ������߂Ă����I"
        else
          action = premess + "#{tec}�A\n\m#{myself.bustsize}���X�ɉ������ĂĂ����I"
        end
  #------------------------------------------------------------------------#
      when 447   #�����킹��
        action = premess + "#{myself.bustsize}���A\n\m#{targetname}��#{target.bustsize}��#{brk3}�������ĂĂ����I"
      when 448   #�����킹
        action = premess + "#{myself.bustsize}���A\n\m#{targetname}��#{target.bustsize}��#{brk3}�C��t���Ă����I"
      when 449   #�����킹��
        action = premess + "�݂��̋����C�肠�킹�A\n\m����̓����#{targetname}�̓����M���Ă����I"
      when 450   #�����킹�K�E
        action = premess + "�������������āA\n\m#{targetname}��#{myself.bustsize}���C����Ă����I\n\m�݂��̋�������ɘc�ݗx��I"
      when 451   #���C��t����
        action = premess + "#{myself.bustsize}���A\n\m#{targetname}��#{target.bustsize}��#{brk3}�������ĂĂ����I"
      when 452   #���C��t���K�E
        action = premess + "#{myself.bustsize}���A\n\m#{targetname}��#{target.bustsize}��#{brk3}�C��t���Ă����I"
      when 453   #�����킹�ǌ�
        brk2 = ""
        brk2 = "\n" if myself.bustsize.size + target.bustsize.size > 36 #���҂̋��\���𑫂��ĂP�Q�����z���Ő܂�Ԃ�
        action = premess + "#{tec}�A\n\m#{myself.bustsize}��#{target.bustsize}��#{brk2}�݂��ɎC��t�������I"
      when 454   #���C��t���ǌ�
        brk2 = ""
        brk2 = "\n" if myself.bustsize.size + target.bustsize.size > 36 #���҂̋��\���𑫂��ĂP�Q�����z���Ő܂�Ԃ�
        action = premess + "#{tec}�A\n\m#{myself.bustsize}��#{target.bustsize}��#{brk2}�݂��ɎC��t�������I"
  #------------------------------------------------------------------------#
  # ���A�\�R�Z�n(�O�񂪗��Ȃ��߁A���������߂̃e�L�X�g�͖���)
  #------------------------------------------------------------------------#
      when 473   #�f�ҏ�
        action = premess + "�A�\�R�������t���A\n\m#{targetname}�̃y�j�X���������C���Ă����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɉ��������ݏグ��I" if target.lub_male >= 60
      when 474   #�f��
        action = premess + "�A�\�R�������t���A\n\m#{targetname}�̃y�j�X���������Ă����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 475   #�f�ҋ�
        action = premess + "�A�\�R�������t���A\n\m#{targetname}�̃y�j�X���������グ�Ă����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 476   #�f�ҕK�E
        action = premess + "#{tec}�A\n\m#{targetname}�ɔn���ɂȂ�#{brk4}�y�j�X��M��ł���I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 477   #�f�Ғǌ�
        action = premess + "#{tec}�A\n\m#{targetname}�ɔn���̂܂�#{brk4}�y�j�X��M��ł���I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
  #------------------------------------------------------------------------#
  # �����Z�n
  #------------------------------------------------------------------------#
      when 486   #���R�L��
        if target.nude?
          action = premess + "���̗��ŁA\n\m#{targetname}�̃y�j�X��D�����������Ă����I"
          action += "\n\m�ʂ߂��тт��y�j�X�ɉ��������ݏグ��I" if target.lub_male >= 60
        else
          action = premess + "���̏ォ��A\n\m#{targetname}�̃y�j�X�𑫂̗���#{brk4}�h�����Ă����I"
        end
      when 487   #���R�L
        if target.nude?
          action = premess + "���̎w�ŁA\n\m#{targetname}�̃y�j�X���������Ă����I"
          action += "\n\m�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
        else
          action = premess + "���̏ォ��A\n\m#{targetname}�̃y�j�X�𑫂̎w��#{brk4}�������Ă����I"
        end
      when 488   #���R�L�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃y�j�X�𑫂Ŏv���܂ܘM�ԁI"
          action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
        else
          action = premess + "���̒��ɑ�����˂�����A\n\m#{targetname}�̃y�j�X���X�ɑ��w�ŘM���Ă����I"
        end
      when 489   #���R�L�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃y�j�X���X�ɑ��ōU�ߗ��Ă�I"
          action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
        else
          action = premess + "���̒��ɑ�����˂����݁A\n\m#{targetname}�̃y�j�X�𑫎w�ŘM���Ă����I"
        end
  #------------------------------------------------------------------------#
      when 491   #���U�ߋ���
        if target.nude?
          action = premess + "���̎w�ŁA\n\m#{targetname}��#{target.bustsize}��#{brk3}�����݂Ɏh�����Ă����I"
        else
          action = premess + "���̏ォ��A\n\m#{targetname}��#{target.bustsize}��#{brk3}�����Ŏh�����Ă����I"
        end
      when 492   #���U�ߋ�
        if target.nude?
          action = premess + "���̎w�ŁA\n\m#{targetname}��#{target.bustsize}��#{brk3}���݂������Ă����I"
          action = premess + "���̎w�ŁA\n\m#{targetname}�̓���������P��グ�Ă����I" if $game_variables[17] > 50
        else
          action = premess + "���̏ォ��A\n\m#{targetname}��#{target.bustsize}��#{brk3}���̎w�Ŏh�����Ă����I"
        end
      when 493   #���U�ߋ��K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}��#{target.bustsize}��#{brk3}���Ŏv���܂ܘM�ԁI"
        else
          action = premess + "���̌��Ԃ��瑫����˂�����A\n\m#{targetname}��#{target.bustsize}��#{brk3}�v���܂ܘM�ԁI"
        end
      when 494   #���U�ߋ��ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}��#{target.bustsize}��#{brk3}���ōX�ɍU�ߗ��Ă�I"
        else
          action = premess + "���̌��Ԃ��瑫����˂����݁A\n\m#{targetname}��#{target.bustsize}��#{brk3}���ōX�Ɏh�����Ă����I"
        end
  #------------------------------------------------------------------------#
      when 496   #���U�߃A�\�R��
        if target.nude?
          action = premess + "�����ŁA\n\m#{targetname}�̃A�\�R�������݂Ɏh�����Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃A�\�R�𑫗��Ŏh�����Ă����I"
        end
      when 497   #���U�߃A�\�R
        if target.nude?
          action = premess + "���̎w�ŁA\n\m#{targetname}�̃A�\�R�����肮��h�����Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃A�\�R�𑫂̎w�Ŏh�����Ă����I"
        end
      when 498   #���U�߃A�\�R�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃A�\�R�𑫎w�Ŏv���܂ܘM�ԁI"
        else
          action = premess + "#{pantsu}�ɑ�����˂�����A\n\m#{targetname}�̃A�\�R���v���܂ܘM�ԁI"
        end
      when 499   #���U�߃A�\�R�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\m#{targetname}�̃A�\�R��#{brk4}���w�łȂ����U�ߗ��Ă�I"
        else
          action = premess + "#{pantsu}�ɂ˂����񂾑���ŁA\n\m#{targetname}�̃A�\�R���X�ɍU�ߗ��Ă�I"
        end
  #------------------------------------------------------------------------#
  # �������Z
  #------------------------------------------------------------------------#
      when 508   #�����E�����
        case $game_variables[17]
        when 0..24
          action = premess + "���ŁA\n\m#{targetname}�̎�؂������ƂȂ����Ă����I"
        when 25..50
          action = premess + "�O�ŁA\n\m#{targetname}�̎����Ԃ��Ê��݂��Ă����I"
        when 51..75
          action = premess + "�A\n\m#{targetname}�̊z�ɂ����ƃL�X�������I"
        else
          action = premess + "�A\n\m#{targetname}�̖j�ɂ����ƃL�X�������I"
        end
      when 509   #�����E�㔼�g
        case $game_variables[17]
        when 0..24
          action = premess + "��ŁA\n\m#{targetname}�̔w����D�������łĂ����I"
        when 25..50
          action = premess + "���ŁA\n\m#{targetname}�̂ւ��̎�����r�߂Ă����I"
        when 51..75
          action = premess + "��ڎg���ŁA\n\m#{targetname}�̎w�𒚔J�ɂ���Ԃ��Ă����I"
        else
          action = premess + "���ŁA\n\m#{targetname}�̘e�������ƂȂ����Ă����I"
        end
      when 510   #�����E�����g(��ɋr)
        case $game_variables[17]
        when 0..24
          action = premess + "�w��ŁA\n\m#{targetname}�̍��������ƂȂ����Ă����I"
        when 25..50
          action = premess + "��ŁA\n\m#{targetname}�̑������𕏂łĂ����I"
        when 51..75
          action = premess + "�����̋r���A\n\m#{targetname}�̑��ɗ��܂��Ă����I"
        else
          action = premess + "��ŁA\n\m#{targetname}�̑��̎w�𒚔J���r�߂Ă����I"
        end
      when 511   #�����E������
        action = premess + "�w��ŁA\n\m#{targetname}�̔����ӂ��Ƃ����グ�Ă����I"
        action = premess + "��̂Ђ�ŁA\n\m#{targetname}�̔������킳��ƕ��łĂ����I" if $game_variables[17] > 50
      when 512   #�����E��������
        action = premess + "�A\n\m#{targetname}��D�����������߂Ă����I"
  #------------------------------------------------------------------------#
      when 515   #�K���U�߁��E��
        action = premess + "#{targetname}��#{pantsu}�̒��ɁA\n\m#{tail}����荞�܂��y�j�X���������Ă����I"
        action = premess + "#{targetname}�̃y�j�X�ɁA\n\m#{tail}�𗍂߂ĎC��グ�Ă����I" if target.nude?
  #------------------------------------------------------------------------#
      when 523   #�K���U�ߋ��E��
        action = premess + "#{tail}���g���A\n\m���̊Ԃ���#{targetname}��#{brk3}#{target.bustsize}�����������I"
        action = premess + "#{tail}���g���A\n\m#{targetname}��#{target.bustsize}�����������I" if target.nude?
  #------------------------------------------------------------------------#
      when 528   #�K���U�߁��E��
        action = premess + "#{targetname}��#{pantsu}�̒��ɁA\n\m#{tail}����荞�܂��ăA�\�R���������Ă����I"
        action = premess + "#{targetname}�̃A�\�R�ɁA\n\m#{tail}���C��t���Ĉ������Ă����I" if target.nude?
  #------------------------------------------------------------------------#
      when 536   #�K���U�ߐK�E��
        action = premess + "#{targetname}��#{pantsu}�̌��Ԃ���A\n\m#{tail}�����荞�܂��Ĉ������Ă����I"
        action = premess + "#{targetname}�̂��K�ɁA\n\m#{tail}�����点�Ĉ������Ă����I" if target.nude?
  #------------------------------------------------------------------------#
  # ������g�̌n
  #------------------------------------------------------------------------#
      when 586   #���X�g���[�V����
        action = "#{myname}�̐g�̂̔S�t�������Ă����c�c�I\n\m#{myname}�̐g�̂��ĂєS�t�ŕ���ꂽ�I"
      when 587   #�X���C�~�[���L�b�h
        action = premess + "�g�̂̔S�t����Ɏ��A\n\m#{targetname}�̕��̌��Ԃ��痬������Ă����I"
        action = premess + "�g�̂̔S�t����Ɏ��A\n\m#{targetname}�̐g�̂ɓh����Ă����I" if target.nude?
      when 588   #����
        action = premess + "#{targetname}�����サ���I"
      when 589   #�o�b�h�X�|�A
        action = premess + "�A\n\m#{targetname}�ɖE�q�𐁂��������I"
      when 590   #�X�|�A�N���E�h
        action = premess + "�ӂ��ʂɖE�q��U��܂����I"
      when 591   #�A�C���B�N���[�Y
        action = premess + "���Ȃ�ӂ��A\n\m#{targetname}�̐g�̂Ɋ����t�����I"
      when 592   #�f�����Y�N���[�Y
        action = "#{myname}�̑���G�肪�A\n\m忂��悤��#{targetname}�̐g�̂Ɋ����t�����I"
      when 599   #�ő�
        action = premess + "�������}�����Ă��I"
      when 600   #��S
        action = premess + "�ڂ��҂�W�������I"
      when 601   #�{�\�̌Ăъo�܂�
        action = premess + "���ɖ���{�\���Ăъo�܂����I"
      when 602   #���M�ߏ�
        action = premess + "����̔��e�ɐ������ꂽ�I"# + "\n\m���̗h�邬�Ȃ����M�͗͂ƂȂ�I"
    #------------------------------------------------------------------------#
      when 611   #�����b�N�X�^�C��
        action = premess + "���₩�Ȏ���������I"
      when 612   #�X�C�[�g�A���}
        action = premess + "�Â������U��܂����I"
      when 613   #�p�b�V�����r�[�g
        action = premess + "�ە����A���C�����߂��I"
      when 614   #�}�C���h�p�t���[��
        action = premess + "�_�炩�ȍ����U��܂����I"
      when 615   #���b�h�J�[�y�b�g
        action = premess + "���b�h�J�[�y�b�g���g�����I"
      when 618   #�X�g�����W�X�|�A
        action = premess + "��ȖE�q��U��܂����I"
      when 619   #�E�B�[�N�X�|�A
        action = premess + "�E�q��U��܂����I"
      when 620   #�Д�
        action = premess + "�Д������I"
      when 621   #�S�͂�
        action = premess + "�����ƌ��߂��I"
      when 622   #�S�Ă͌�
        action = premess + "�S�Ă͌����Ǝv���m�点���I"
      when 625   #���u�t���O�����X
        action = premess + "�s���N�F�̍����U��܂����I"
      when 626   #�X���C���t�B�[���h
        action = premess + "�g�̂̔S�t�����͂ɍL�����I"
    #------------------------------------------------------------------------#
      when 631   #������󂯂�
        action = premess + "������󂯂��I"
  #------------------------------------------------------------------------#
  # ���O���C���h�n
  #------------------------------------------------------------------------#
      when 751   #�O���C���h��
        waist = ["��������","�T���߂�"]
        waist.push("��������") if myself.positive?
        waist.push("�ł炷�悤��") if myself.positive?
        waist.push("����������") if myself.negative?
        waist.push("�p�炢��") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}���𓮂����Ă����I"
      when 752   #�O���C���h��
        waist = ["�O���","���E��"]
        waist.push("�񂷂悤��") if myself.positive?
        waist.push("�p�炢��") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}����U���Ă����I"
      when 753   #�O���C���h��
        waist = ["��_��","�傫��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist.push("�������\���") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}����U��n�߂��I"
      when 754   #�O���C���h�K�E
        waist = ["��_��","�傫��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist.push("�������\���") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}����U���Ă����I"
      when 755   #���߂�
        action = premess + "�A�\�R��������ƒ��߂Ă����I"
        action = "#{myname}�̃A�\�R��������ƒ��܂����I" if myself.negative?
      when 756   #���߂�K�E
        action = premess + "�A�\�R��������Ƌ������߂Ă����I"
        action = "#{myname}�̃A�\�R��������Ƌ������܂����I" if myself.negative?
      when 757   #�O���C���h�ǌ�
        waist = ["��_��","�傫��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{tec}�A\n\m�X��#{waist}����O�コ���Ă����I"
      when 758   #���߂�ǌ�
        action = "#{myname}�̃A�\�R���ʂ̐������̂悤�ɁA\n#{targetname}�̃y�j�X�����\�I�ɒ��ߕt����I"
  #------------------------------------------------------------------------#
      when 760   #�L���킹��
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\m�A�\�R���m���������Ă��I"
      when 761   #�L���킹
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\m�A�\�R���m���C�荇�킹���I"
      when 762   #�L���킹��
        waist = ["��_��","����","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\m�A�\�R���m��#{waist}�C�荇�킹���I"
      when 763   #�L���킹�K�E
        waist = ["��_��","����","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\m�A�\�R���m��#{waist}�C�荇�킹���I"
      when 764   #�L���킹�ǌ�
        waist = ["��_��","����","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{brk}#{targetname}�̋r������A\n\m�X�ɃA�\�R���m��#{waist}�C�荇�킹���I"
  #------------------------------------------------------------------------#
      when 766   #���C�f�B���O��
        if myself.nude?
          action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\m�A�\�R�����ɉ����t���Ă����I"
        else
          case $data_SDB[myself.class_id].name
          when "�L���X�g","�t�@�~���A","�v�`�E�B�b�`","�E�B�b�`"
            action = premess + "�X�J�[�g�̒[�������A\n\m#{targetname}�̌���#{pantsu}�������t�����I"
          when "���b�T�[�T�L���o�X","�T�L���o�X"
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌���#{pantsu}�������t�����I"
          when "�C���v","�f�r��"
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌���#{pantsu}�������t�����I"
          when "�X���C��"
            action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\m�҂̌E�݂������t���Ă����I"
          when "�i�C�g���A"
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌���#{pantsu}�z���̃A�\�R�������t�����I"
          else
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌���#{pantsu}�������t�����I"
          end
        end
      when 767   #���C�f�B���O
        if myself.nude?
          action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\m�������ƍ���O��ɐU���Ă����I"
        else
          case $data_SDB[myself.class_id].name
          when "�L���X�g","�t�@�~���A","�v�`�E�B�b�`","�E�B�b�`"
            action = premess + "�X�J�[�g�̒[�������A\n\m#{targetname}�̌���#{pantsu}�������t�����I"
          when "���b�T�[�T�L���o�X","�T�L���o�X"
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌���#{pantsu}�������t�����I"
          when "�C���v","�f�r��"
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌���#{pantsu}�������t�����I"
          when "�X���C��"
            action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\m�҂̌E�݂����������t���Ă����I"
          when "�i�C�g���A"
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌���#{pantsu}�z���̃A�\�R�������t�����I"
          else
            action = premess + "���𗎂Ƃ��A\n\m#{targetname}�̌���#{pantsu}�������t�����I"
          end
        end
      when 768   #���C�f�B���O�K�E
        waist = ["��_��","�񂷂悤��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{brk}#{targetname}�Ɍ����t����悤�ɁA\n\m��̏��#{waist}����U���Ă����I"
      when 769   #���C�f�B���O�ǌ�
        waist = ["��_��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("�x��悤��") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{brk}#{targetname}�ɔn���̂܂܁A\n\m�X��#{waist}����O��ɐU���Ă����I"
  #------------------------------------------------------------------------#
      when 772   #�G�i�W�[�h���C��
        action = premess + "�i����悤�ɍ���U���Ă����I"
      when 773   #���x���h���C��
        action = premess + "�i����悤�ɍ���U���Ă����I"
  #------------------------------------------------------------------------#
      when 788   #�t�F���`�I��
        action = premess + "#{targetname}�̃y�j�X���A\n\m���ř������܂܂������Ɛ�𔇂킹�Ă����I"
      when 789   #�t�F���`�I
        action = premess + "#{targetname}�̃y�j�X���A\n\m���ř������܂܂������Ƃ���Ԃ��Ă����I"
      when 790   #�t�F���`�I��
        action = premess + "#{targetname}�̃y�j�X���A\n\m���ř������܂ܐ���r�߉񂵂Ă����I"
      when 791   #�t�F���`�I�K�E
        action = premess + "#{targetname}�̃y�j�X���A\n\m���ř������܂܉��������r�߉񂵂Ă����I"
      when 792   #�X���[�g
        action = premess + "#{targetname}�̃y�j�X���A\n\m�������Ƌz���グ�Ă����I"
      when 793   #�X���[�g�K�E
        action = premess + "#{targetname}�̃y�j�X���A\n\m���ݍ��ނ悤�ɋz���グ�Ă����I"
      when 794   #�t�F���`�I�ǌ�
        action = premess + "#{targetname}�̃y�j�X���A\n\m���ə������܂ܐ�ōX���r�߉񂵂Ă����I"
      when 795   #�X���[�g�ǌ�
        action = premess + "#{targetname}�̃y�j�X���A\n\m�ɋ}��t���čX�ɋz���グ�Ă����I"
  #------------------------------------------------------------------------#
      when 797   #�N���j��
        action = premess + "#{targetname}�̃A�\�R���A\n\m���S�̂ł������Ƌz���グ�Ă����I"
      when 798   #�N���j
        action = premess + "#{targetname}�̃A�\�R�ɁA\n\m�������đO��ɔ����������Ă����I"
      when 799   #�N���j��
        action = premess + "#{targetname}�̃A�\�R���A\n\m���S�̂ŉA�j���Ƌ����z���グ�Ă����I"
      when 800   #�N���j�K�E
        action = premess + "#{targetname}�̃A�\�R�ɁA\n\m�����点���܂Ő����ǂ��˂�����Ă����I"
      when 801   #�N���j�ǌ�
        action = premess + "#{targetname}�̃A�\�R���A\n\m���ŋz���t�����܂܍X�ɐ�ň������Ă����I"
  #------------------------------------------------------------------------#
      when 803   #�f�B�[�v�L�b�X��
        action = premess + "#{targetname}�ƁA\n\m�������ƌ݂��̐�𗍂߂������I"
      when 804   #�f�B�[�v�L�b�X
        action = premess + "#{targetname}�ƁA\n\m�݂��̐�𗍂߂������I"
      when 805   #�f�B�[�v�L�b�X��
        action = premess + "#{targetname}�ƁA\n\m�݂��Ɍ������O���Â肠�����I"
      when 806   #�f�B�[�v�L�b�X�K�E
        action = premess + "#{targetname}�̌����ɁA\n\m����r�ߓ�����t�𗬂�����ł����I"
      when 807   #�f�B�[�v�L�b�X�ǌ�
        action = premess + "�Ȃ����������A\n\m#{targetname}�̌����������W����I"
  #------------------------------------------------------------------------#
      when 828   #�w�ʍS���E�X�^���_��
        action = premess + "#{targetname}�Ɩ������A\n\m��؂ɂӂ����Ƒ��𐁂������Ă����I"
        action = premess + "#{targetname}�Ɩ������A\n\m�����Ԃ�O�ŊÊ��݂��Ă����I"
      when 829   #�w�ʍS���E�K�E�_��
        if target.boy?
          action = premess + "#{targetname}�Ɩ������A\n\m��؂��ł������r�߂����Ă����I"
          action = premess + "#{targetname}�Ɩ������A\n\m���L�΂��ăy�j�X���w�ň������Ă����I" unless target.hold.penis.battler != nil
        else
          action = premess + "#{targetname}�Ɩ������A\n\m#{target.bustsize}�𝆂݂������Ă����I"
          action = premess + "#{targetname}�Ɩ������A\n\m�A�\�R�Ɏ��L�΂��w�ň������Ă����I" unless target.hold.vagina.battler != nil
        end
      when 830   #�w�ʍS���ǌ�
        if target.boy?
          action = premess + "#{tec}�A\n\m���������܂�#{targetname}��#{brk4}�L�X�̉J���~�点���I"
          action = premess + "#{tec}�A\n\m���������܂�#{targetname}�̃y�j�X��#{brk4}�w�ŘM�ԁI" unless target.hold.penis.battler != nil
        else
          action = premess + "#{tec}�A\n\m���������܂�#{targetname}��#{target.bustsize}��#{brk4}���������I"
          action = premess + "#{tec}�A\n\m���������܂�#{targetname}�̃A�\�R��#{brk4}�w�ŘM�񂾁I" unless target.hold.vagina.battler != nil
        end
  #------------------------------------------------------------------------#
      #�p�C�Y���n
      when 836   #�X�g���[�N��
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̃y�j�X��������ƈ������Ă����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 837   #�X�g���[�N
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̃y�j�X������ł������Ă����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 838   #�X�g���[�N��
        action = premess + "#{myself.bustsize}�̒J�ԂɃy�j�X�����݁A\n\m#{targetname}����ڌ����Ɍ��Ȃ����𔇂킹�Ă����I"
        target.lub_male += 4
        action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 839   #�X�g���[�N�K�E
        action = premess + "#{myself.bustsize}�̒J�ԂɃy�j�X�����݁A\n\m#{targetname}�̔������y���ނ��̂悤�ɘM��ł����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 840   #�X�g���[�N�ǌ�
        action = premess + "�X��#{myself.bustsize}�������t���A\n\m#{targetname}�̃y�j�X�ɐ�𔇂킹�Ȃ���C��グ���I"
        target.lub_male += 4
        action += "\n\m�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
  #------------------------------------------------------------------------#
      #�ςӂςӌn
      when 842   #�v���X��
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̊��D������ݍ���ł����I"
      when 843   #�v���X
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̊��������߂Ă����I"
      when 844   #�v���X��
        action = premess + "#{myself.bustsize}�̒J�Ԃ��A\n\m#{targetname}�̊��������Ɖ����t���Ă����I"
      when 845   #�v���X�K�E
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\m#{targetname}�̊�����݂��ˉ񂵂Ă����I"
      when 846   #�v���X�ǌ�
        action = premess + "�X��#{myself.bustsize}�ŁA\n\m#{targetname}�̊���ݍ��݂��ˉ񂷁I"
  #------------------------------------------------------------------------#
      #�f�B���h�n
      when 891   #�f�B���h���}���E��
        waist = ["��������","�T���߂�"]
        waist.push("��������") if myself.positive?
        waist.push("�ł炷�悤��") if myself.positive?
        waist.push("����������") if myself.negative?
        waist.push("�p�炢��") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}���𓮂����Ă����I"
      when 892   #�f�B���h���}��
        waist = ["�O���"]
        waist.push("�������ނ悤��") if myself.positive?
        waist.push("�p�炢��") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}����U���Ă����I"
      when 893   #�f�B���h���}���E�K�E
        waist = ["��_��","�傫��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("�P��悤��") if myself.positive?
        waist.push("�g�̂�͂��") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist.push("�������\���") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}����U��n�߂��I"
      when 894   #�f�B���h���}���E�ǌ�
        waist = ["��_��","�傫��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("�P��悤��") if myself.positive?
        waist.push("�g�̂�͂��") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{tec}�A\n\m�X��#{waist}����O�コ���Ă����I"
  #------------------------------------------------------------------------#
      when 896   #�f�B���h���}���E��
        waist = ["��������","�T���߂�"]
        waist.push("��������") if myself.positive?
        waist.push("�ł炷�悤��") if myself.positive?
        waist.push("����������") if myself.negative?
        waist.push("�p�炢��") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}���𓮂����Ă����I"
      when 897   #�f�B���h���}��
        waist = ["�O���"]
        waist.push("�������ނ悤��") if myself.positive?
        waist.push("�p�炢��") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}����U���Ă����I"
      when 898   #�f�B���h���}���E�K�E
        waist = ["��_��","�傫��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("�P��悤��") if myself.positive?
        waist.push("�g�̂�͂��") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist.push("�������\���") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}����U��n�߂��I"
      when 899   #�f�B���h���}���E�ǌ�
        waist = ["��_��","�傫��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("�P��悤��") if myself.positive?
        waist.push("�g�̂�͂��") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{tec}�A\n\m�X��#{waist}����O�コ���Ă����I"
  #------------------------------------------------------------------------#
      when 901   #�f�B���h�K�}���E��
        waist = ["��������","�T���߂�"]
        waist.push("��������") if myself.positive?
        waist.push("�ł炷�悤��") if myself.positive?
        waist.push("����������") if myself.negative?
        waist.push("�p�炢��") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}���𓮂����Ă����I"
      when 902   #�f�B���h�K�}��
        waist = ["�O���"]
        waist.push("�������ނ悤��") if myself.positive?
        waist.push("�p�炢��") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}����U���Ă����I"
      when 903   #�f�B���h�K�}���E�K�E
        waist = ["��_��","�傫��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("�P��悤��") if myself.positive?
        waist.push("�g�̂�͂��") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist.push("�������\���") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{waist}����U��n�߂��I"
      when 904   #�f�B���h�K�}���E�ǌ�
        waist = ["��_��","�傫��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("�P��悤��") if myself.positive?
        waist.push("�g�̂�͂��") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{tec}�A\n\m�X��#{waist}����O�コ���Ă����I"
  #------------------------------------------------------------------------#
      #�G��n
      when 733   #�G��t�F���`�I�E��
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\m�y�j�X��������܂܂���������忂����������I"
      when 734   #�G��t�F���`�I
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\m�y�j�X��������܂܂������Ƃ���Ԃ��Ă����I"
      when 735   #�G��t�F���`�I�E�K�E
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\m�y�j�X��������܂܌���������Ԃ��Ă����I"
      when 736   #�G��t�F���`�I�E�ǌ�
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\m�y�j�X��������܂܍X�ɂ���Ԃ��Ă����I"
  #------------------------------------------------------------------------#
      when 738   #�G��N���j�E��
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\m�A�\�R�ɒ���t�����܂܂���������忂����������I"
      when 739   #�G��N���j
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\m�A�\�R�ɒ���t�����܂܂������Ƌz���グ�Ă����I"
      when 740   #�G��N���j�E�K�E
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\m�A�\�R�ɒ���t�����܂܉A�j���Ƌ����z���グ�Ă����I"
      when 741   #�G��N���j�E�ǌ�
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\m�A�\�R�ɒ���t�����܂܍X�ɋz���グ�Ă����I"
  #------------------------------------------------------------------------#
      when 942   #��˂��グ��
        action = premess + "���ŁA\n\m#{targetname}�̃A�\�R��������˂��グ���I"
        action = premess + "��ŁA\n\m#{targetname}�̃A�\�R���r�߉񂵂��I" if $game_variables[17] > 50
      when 943   #��˂��グ�K
        action = premess + "���ŁA\n\m#{targetname}�̋e���������˂��グ���I"
        action = premess + "��ŁA\n\m#{targetname}�̋e�����r�߉񂵂��I" if $game_variables[17] > 50
      when 944   #������
        action = premess + "���R�ɓ��������ŁA\n\m#{targetname}��#{target.bustsize}��h�݂͂ɂ����I"
        action = premess + "���R�ɓ��������ŁA\n\m#{targetname}��#{target.bustsize}��������h�݂͂ɂ����I" if myself.mouth_riding?
        action = premess + "���R�ɓ�������w�ŁA\n\m#{targetname}�̓����E�ݏグ���I" if $game_variables[17] > 50
      when 945   #�K����
        action = premess + "���R�ɓ��������ŁA\n\m#{targetname}�̂��K��h�݂͂ɂ����I"
        action = premess + "���R�ɓ�������w�ŁA\n\m#{targetname}�̋e����h�������I" if $game_variables[17] > 80
      when 946   #�w�ʈ���
        action = premess + "\n\m#{targetname}�̑������𕏂ŉ񂵂��I"
        action = premess + "\n\m#{targetname}�̃A�\�R���w�ň��������I" if $game_variables[17] > 50
      when 947   #�L�X����
        action = premess + "����߂Â��A\n\m#{targetname}�ɃL�X�������I"
        action = premess + "����߂Â��A\n\m#{targetname}�Ɖ��߂�������𗍂܂����I" if $game_variables[17] > 50
      when 948   #�������t��
        action = premess + "���𓮂����A\n\m#{targetname}�̊�ɃA�\�R���C������I"
        action = premess + "���𓮂����A\n\m#{targetname}�̊�ɃA�\�R�������t�����I" if $game_variables[17] > 50
      when 949   #�A�\�R�U�ߔ���
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̃A�\�R�𕏂łĂ����I"
          action = premess + "�w��ŁA\n\m#{targetname}�̃A�\�R�̓������#{brk4}�������Ă����I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃A�\�R�𕏂łĂ����I"
        end
      when 950   #�A�j�U�ߔ���
        if target.nude?
          action = premess + "�w��ŁA\n\m#{targetname}�̉A�j���������h�����Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̉A�j���h�����Ă����I"
        end
      when 951   #�y�j�X�U�ߔ���
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̃y�j�X�𕏂łĂ����I"
          action = premess + "�w��ŁA\n\m#{targetname}�̃y�j�X�𕏂łĂ����I" if $game_variables[17] > 50
          action += "\n\m�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
        else
          action = premess + "#{pantsu}�̏ォ��A\n\m#{targetname}�̃y�j�X�𕏂łĂ����I"
        end
      when 952   #�ΊۍU�ߔ���
        if target.nude?
          action = premess + "��ŁA\n\m#{targetname}�̑܂�D�����������Ă����I"
          action = premess + "�w��ŁA\n\m#{targetname}�̑܂�D�������łĂ����I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\m#{targetname}�̑܂���ł������Ă����I"
        end
      when 953   #�������C��t������
        action = premess + "�A�\�R�������t���A\n\m#{targetname}�̃y�j�X�ɎC����Ă����I"
        action += "\n\m�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 954   #�������C��t������
        action = premess + "�A�\�R�������t���A\n\m#{targetname}�ƃA�\�R�ɎC����Ă����I"
=begin
      when 947   #�K���Ŋ�P
        action = premess + "�K�����g���A\n\m���p����#{targetname}�̃A�\�R���h�����Ă����I"
        action = premess + "�K�����g���A\n\m���p����#{targetname}�̋����������Ă����I" if $game_variables[17] > 50
      when 948   #�G��Ŋ�P
        action = premess + "�G����g���A\n\m���p����#{targetname}�̃A�\�R���h�����Ă����I"
        action = premess + "�G����g���A\n\m���p����#{targetname}�̋����������Ă����I" if $game_variables[17] > 50
=end  
  #------------------------------------------------------------------------#
      when 956   #�L�b�X�ŉ���
        action = premess + "#{emotion}\n\m#{targetname}�̐O���ǂ��A#{brk4}��𗍂߂Ă����I"
      when 957   #���U�߂ŉ���
        action = premess + "#{emotion}\n\m#{targetname}��#{target.bustsize}��#{brk4}���݂��������I"
      when 958   #�K�U�߂ŉ���
        action = premess + "#{emotion}\n\m#{targetname}�̂��K��#{brk4}���݂��������I"
      when 959   #�A�i���U�߂ŉ���
        action = premess + "#{emotion}\n\m#{targetname}�̋e������œ˂��Ă����I"
      when 960   #�A�\�R�U�߂ŉ���
        action = premess + "#{emotion}\n\m#{targetname}�̃A�\�R���ň������Ă����I"
      when 961   #�A�j�U�߂ŉ���
        action = premess + "#{emotion}\n\m#{targetname}�̉A�j�����r�ߏグ�Ă����I"
      when 962   #�y�j�X�U�߂ŉ���
        #�t�A�i���ŔƂ�����
        if target.anal_analsex?
          action = premess + "#{emotion}\n\m����Ƃ����#{targetname}�̃y�j�X��\n�����r�ߏグ�Ă����I"
          action = premess + "#{emotion}\n\m����Ƃ����#{targetname}�̃y�j�X��\n��ł������Ă����I" if $game_variables[17] > 50
        #�R����
        else
          action = premess + "#{emotion}\n\m�g�������Ȃ�#{targetname}�̃y�j�X��\n�����r�ߏグ�Ă����I"
          action = premess + "#{emotion}\n\m�g�������Ȃ�#{targetname}�̃y�j�X��\n��ł������Ă����I"if $game_variables[17] > 50
        end
      when 963   #�ΊۍU�߂ŉ���
        #�t�A�i���ŔƂ�����
        if target.anal_analsex?
          action = premess + "#{emotion}\n\m����Ƃ����#{targetname}���Ίۂ�\n�����r�ߏグ�Ă����I"
          action = premess + "#{emotion}\n\m����Ƃ����#{targetname}���Ίۂ�\n�w�ň������Ă����I" if $game_variables[17] > 50
        #�R����
        else
          action = premess + "#{emotion}\n\m�g�������Ȃ�#{targetname}���Ίۂ�\n�����r�ߏグ�Ă����I"
          action = premess + "#{emotion}\n\m�g�������Ȃ�#{targetname}���Ίۂ�\n�w�ň������Ă����I"if $game_variables[17] > 50
        end
      when 964   #����U���ǌ�
        action = premess + "#{tec}�A\n\m�X��#{targetname}���������Ă����I"
  #------------------------------------------------------------------------#
      when 967   #�������U�߂�
        action = premess + "#{emotion}\n\m#{targetname}��D�������������I"
      when 968   #�����E���w����
        action = premess + "�A\n\m#{targetname}�̗l�q�������ÁX�ȗl�q�Ō��߂Ă���c�c"
        #�z�[���h���삻�̑��p�E���i�ʌ`�e�\��
        case myself.personality
        when "�Ӓn��","����","����","�����C" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\m#{targetname}�̗l�q���ɂ�ɂ�ƒ��߂Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\m��������悤�ȕs�G�ȏ΂݂𕂂��ׂ��c�c�I"
          end
        when "�D�F","�|��" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\m#{targetname}�̗l�q���ɂ�ɂ�ƒ��߂Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\m�����ȏ΂݂𕂂��ׂĎ菵�����Ă����c�c�I"
          end
        when "�z�C","�Â���","�_�a","��i" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\m#{targetname}�̗l�q�������ÁX�ȗl�q�Ō��߂Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\m���������҂��邩�̂悤�ȏ΂݂𕂂��ׂ��c�c"
          end
        when "���C" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\m#{targetname}�̗l�q��M���ۂ����Ō��߂Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\m�p������悤�Ɋ����炵�Ă��܂����c�c"
          end
        when "�]��","�W��" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\m#{targetname}�̗l�q��M�S�Ɋώ@���Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\m���������҂��邩�̂悤�Ȋ፷���������Ă����c�c"
          end
        when "�s�v�c","�V�R" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\m#{targetname}������Ƃ�Ƃ����\��Ō��Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\m�ɂ�����Ɣ��΂񂾁c�c"
          end
        when "�ƑP" #�t���r���A��p
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\m#{targetname}�̗l�q��ʔ������Ɋώ@���Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\m�����ȏ΂݂𕂂��ׂĎ菵�����Ă����c�c�I"
          end
        end
        if myself.holding?
          action = premess + "�g�ウ���Ă���I"
        end
      when 969   #����
        #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
        if target.holding?
          if myself.holding_now? and not (myself.tops_binding? or myself.tentacle_binding?)
            if myself.vagina_insert?
              action = premess + "#{targetname}�ƌq����A\n\m�����#{myself.bustsize}���w�ňԂ߂Ă���c�c�I"
            elsif myself.mouth_oralsex?
              action = premess + "#{targetname}�̃y�j�X��j����A\n\m����̃A�\�R�Ɏw�𔇂킹�ĈԂ߂Ă���c�c�I"
            elsif myself.vagina_riding?
              action = premess + "#{targetname}�̊�Ɍׂ�A\n\m�����#{myself.bustsize}���w�ňԂ߂Ă���c�c�I"
            elsif myself.shellmatch?
              action = premess + "#{targetname}�Ɖ����g�𗍂߂����A\n\m�����#{myself.bustsize}���w�ňԂ߂Ă���c�c�I"
            else
              action = premess + "#{targetname}�̒s�Ԃ𒭂߂A\n\m����̐g�̂��Ԃ߂Ă���c�c�I"
            end
          elsif myself.tops_binding? or myself.tentacle_binding?
            action = premess + "#{targetname}�̒s�Ԃ𒭂߂A\n\m�S�����ꂽ����̏�Ԃɐg�ウ���Ă���c�c�I"
          else
            action = premess + "#{targetname}�̒s�Ԃ𒭂߂A\n\m����̐g�̂��Ԃ߂Ă���c�c�I"
          end
        #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
        else
          action = premess + "����̐g�̂��Ԃ߂Ă���c�c�I"
        end
  #------------------------------------------------------------------------#        
      when 970   #���x�~(�z�[���h���̂u�o�؂�Ή�)
        sp_plus = [(myself.maxsp / 8).ceil, 50].min
        #�^�[�Q�b�g�w��(�G���u���C�X���̃^�[�Q�b�g��D��)
        if myself.hold.tops.battler != nil and myself.hold.tops.parts != "�G��"
          hold_action = "#{myself.hold.tops.battler.name}�ɐg�̂�a��"
        else
          #���큄�K�����̏��ɗD��x�����܂�
          if myself.hold.penis.battler != nil
            hold_action = "#{myself.hold.penis.battler.name}�ɐg�̂�a��"
          elsif myself.hold.vagina.battler != nil
            hold_action = "#{myself.hold.vagina.battler.name}�ɐg�̂��ς�"
          elsif myself.hold.anal.battler != nil
            hold_action = "#{myself.hold.anal.battler.name}�ɐg�̂��ς�"
          elsif myself.hold.dildo.battler != nil
            hold_action = "#{myself.hold.dildo.battler.name}�ɐg�̂��ς�"
          elsif myself.hold.mouth.battler != nil
            hold_action = "#{myself.hold.mouth.battler.name}�ɐg�̂��ς�"
          else
            hold_action = "�g�̗̂͂𔲂�"
          end
        end
        #�����ӂ������Ă���ꍇ
        if myself.hold.mouth.battler != nil
          action = premess + "#{hold_action}�A\n\m���Ƃ��ċz�𗎂������悤�Ƃ��Ă���c�c�I"
        else
          action = premess + "#{hold_action}�A\n\m�ċz�𗎂������悤�Ƃ��Ă���c�c�I"
        end
        myself.sp += sp_plus
      when 971   #������
        action = premess + "�g���悶��A\n\m�̐���ς��悤�Ǝ��݂��I"
      when 981   #�\������
        if target.nude?
          action = premess + "��ɐg��C���A\n#{targetname}�̐g�̂��v���܂܂��Â����I"
          action = premess + "��ɐg��C���A\n#{targetname}�̋����v���܂܂��Â����I" if $msg.at_parts == "�ΏہF��"
          action = premess + "��ɐg��C���A\n#{targetname}�̊���r�X���������񂹁A\n�O��L�������킹���Â����I" if $msg.at_parts == "�ΏہF��"
          action = premess + "��ɐg��C���A\n#{targetname}�̂��K���r�X�������݂��������I" if $msg.at_parts == "�ΏہF�K"
          action = premess + "��ɐg��C���A\n#{targetname}�̃A�\�R���v���܂܂��Â����I" if $msg.at_parts == "�ΏہF�A�\�R"
          action = premess + "��ɐg��C���A\n#{targetname}�̃y�j�X��L�������킹���Â����I" if $msg.at_parts == "�ΏہF�y�j�X"
        else
          action = premess + "��ɐg��C���A\n#{targetname}�̐g�̂��v���܂܂��Â����I"
          action = premess + "��ɐg��C���A\n#{targetname}�̕��𐨂��悭�͂���������ƁA\n���̋����v���܂܂��Â����I" if $msg.at_parts == "�ΏہF��"
          action = premess + "��ɐg��C���A\n#{targetname}�̊���r�X���������񂹁A\n���̐O��L�������킹���Â����I" if $msg.at_parts == "�ΏہF��"
          action = premess + "��ɐg��C���A\n���Ȃǈӂɉ�Ȃ��Ƃ΂���ɁA\n#{targetname}�̂��K���r�X�������݂��������I" if $msg.at_parts == "�ΏہF�K"
          action = premess + "��ɐg��C���A\n���Ȃǈӂɉ�Ȃ��Ƃ΂���ɁA\n#{targetname}�̃A�\�R���v���܂܂��Â����I" if $msg.at_parts == "�ΏہF�A�\�R"
          action = premess + "��ɐg��C���A\n���Ȃǈӂɉ�Ȃ��Ƃ΂���ɁA\n#{targetname}�̃y�j�X��L�������킹���Â����I" if $msg.at_parts == "�ΏہF�y�j�X"
        end
        action = premess + "#{targetname}�̃A�\�R���A\n���𗧂Ăċ����z���グ���I"if myself.mouth_riding?
        action = premess + "#{targetname}�̋e�����A\n�r�X��������r�߉񂵂��I"if myself.mouth_hipriding?
      when 982   #�\�������E�ǌ�
        action = premess + "�Ȃ����������A\n�b�̂悤��#{targetname}�̐g�̂��Â��Ă���I"
      when 983   #�\���s�X�g��
        #�C���T�[�g�A�f�B���h�n�A�I�[�����n�A�N���j�n
        action = premess + "#{targetname}��g�ݕ����A\n�b�̂悤�ɍr�X��������ł��t�����I" if myself.penis_insert?
        action = premess + "#{targetname}��g�ݕ����A\n�Ӓn�����ȏ΂݂𕂂��ׂč���ł��t�����I" if myself.dildo_insert?
        action = premess + "#{targetname}�̓���͂݁A\n���x���A�̉��܂Ńf�B���h���˂����ꂽ�I" if myself.dildo_oralsex?
        action = premess + "#{targetname}�̍���͂݁A\n�n�s�I�ȏ΂݂𕂂��׉��x������ł������I" if myself.dildo_analsex?
        action = premess + "#{targetname}�̓���͂݁A\n�A�̉��܂Ńy�j�X���r�X�����˂����񂾁I" if myself.penis_oralsex?
        action = premess + "#{targetname}��g�ݕ����A\n���΂ȉ��𗧂ĂČ������y�j�X���z���グ���I" if myself.mouth_oralsex?
        action = "��������#{myname}������G�肪�A\n#{targetname}�̃A�\�R�ɋz���t���A\n�@���΂ȉ��𗧂ĂČ������z���グ�Ă����I" if myself.tentacle_draw?
        action = "��������#{myname}������G�肪�A\n#{targetname}�̃y�j�X�ɋz���t���A\n�@���΂ȉ��𗧂ĂČ������z���グ�Ă����I" if myself.tentacle_absorbing?
      when 984   #�\���s�X�g���E�ǌ�
        action = premess + "�Ȃ����������A\n#{targetname}��Ƃ��Ă���I"
        action = "#{myname}�̐G��́A\n�Ȃ���������#{targetname}��Ƃ��Ă���I" if myself.tentacle_draw? or myself.tentacle_absorbing?
      when 985   #�\���O���C���h
        #�A�N�Z�v�g�A�V�F���}�b�`�A�y���X�R�[�v�A�G�L�T�C�g�r���[
        action = premess + "#{targetname}��g�ݕ����A\n�b�̂悤�ɍr�X�����������˂点���I"
        action = premess + "#{targetname}��g�ݕ����A\n#{myself.bustsize}�Ńy�j�X��M��ł���I" if myself.tops_paizuri?
      when 986   #�\���O���C���h�E�ǌ�
        action = premess + "�Ȃ����������A\n#{targetname}��Ƃ��Ă���I"
      when 987   #�\������(VP�؂�)
        action = premess + "����؂点���A\n�Փ��ɔC����#{targetname}�����������I\n�������A�v���悤�ɐg�̂��������Ȃ��I"
      when 988   #�\������(��U��)
        action = premess + "#{targetname}�����������I\n�������A�����̂��܂�茳����܂�Ȃ��I\w\n#{targetname}�͉������󂯂Ă��Ȃ��I"
        action = premess + "#{targetname}�����������I\n�������A�����̂��܂�g�̂����܂������Ȃ��I\w\n#{targetname}�͉������󂯂Ă��Ȃ��I" if myself.hold.tops.battler != nil
  #------------------------------------------------------------------------#
      end
      #������̔G��x�ŕ␳�e�L�X�g�C��(�X�L���З͂�������̌���)
      if skill.element_set.include?(97) and skill.power != 0 and target.girl?
        case target.lub_female
        when 81..255
          action += "\n\m�h�����󂯂邽�тɁA�A�\�R���爤���̐��򖗂��オ��c�I" if target.nude?
          action += "\n\m#{targetname}��#{pantsu}���爤�����H�藎����c�I" unless target.nude?
        when 61..80
          action += "\n\m�A�\�R�̈���Ȑ��������傫���Ȃ��Ă����c�I" if target.nude?
          action += "\n\m#{targetname}��#{pantsu}�͈����ŔG��Ă���c�I" unless target.nude?
        when 41..60
          action += "\n\m#{targetname}�̓��҂������������Ɨ����c�I" if target.nude?
          action += "\n\m#{targetname}��#{pantsu}�̐��݂��Z���Ȃ��Ă����c�I" unless target.nude?
        when 25..40
          action += "\n\m�A�\�R�������Ȑ������R�ꕷ�����Ă���c�I" if target.nude?
          action += "\n\m#{targetname}��#{pantsu}�ɐ��݂������o�Ă����c�I" unless target.nude?
        end
      end
      # ���b�Z�[�W�o��
      case type
      when "action"
        #�X���C���n�͕����S�t�ɒu��������(�b��)
        if $data_SDB[target.class_id].name == "�X���C��"
          action.gsub!("��","�S�t") 
        end
        text = action
      when "avoid"
        text = avoid
      end
      
      
      
      return text
    end
  end
end

