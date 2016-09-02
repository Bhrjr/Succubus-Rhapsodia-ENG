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
      myname = myself.name #rescue myname = "*TODO*"
      username = user.name #rescue username = "*TODO*"
      skill_name = skill.UK_name rescue skill_name = "skill name error"   
      target = $game_temp.battle_target_battler[0] if $game_temp.battle_target_battler[0] != nil
      targetname = $game_temp.battle_target_battler[0].name if $game_temp.battle_target_battler[0] != nil
      premess = "#{myname}"
      avoid = "But #{myname} quickly dodged out of the ��ay!"
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
        action = premess + " casts #{skill_name}"
        avoid = "It had no effect on #{myname}!"
      #------------------------------------------------------------------------#
      # ���C���Z���X
      elsif skill.element_set.include?(129)
        action = premess + " used #{skill_name}!"
        avoid = "It had no effect on #{myname}!"
      else
        action = premess + " caressed #{targetname}!"
        avoid = "It had no effect on #{myname}!"
      end
      #------------------------------------------------------------------------#
      # �u���C�N�t���O(�d�|����Ǝ󂯎�̖��O���������v���P�Q���z����ꍇ�A���s�����ރt���O)
      # �e�L�X�g���e�ɂ���ẮA���܂Ȃ��Ă��ǂ��ꍇ������̂ōl���ē���邱��
      # brk�́u����Ǝ����̖��O�v�Abrk3�́u����̖��O�Ƒ���̋��T�C�Y�v��f�f����
      # brk2�̓X�L���P�ʂŌʎw�肵�Ă��邽�߁A�ꊇ�ł͐ݒ肵�Ȃ�
      brk = brk2 = brk3 = brk4 = ""
      if targetname != nil
        brk = "�A\n\" if SR_Util.names_over?(myname,targetname)
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
      when "Lesser Succubus ","Succubus", "Vermiena"
        tail = "flexible tail"
      when "I��p","Devil ","De��on", "Yuganaught"
        tail = "spaded tail"
      when "Werecat ","Werewolf","Ta��a��o"
        tail = "fluffy tail"
      when "Fulbeua ", "Neijorange", "Succubus Lord "
        tail = "glossy tail"
      when "Familiar", "Rejeo ", "Sylphe"
        tail = "delicate tail"
      when "Gargoyle"
        tail = "squarish tail"
      else
        tail = "tail"
      end
      #------------------------------------------------------------------------#
      ##{pantsu}�̌`�e
      case $data_SDB[target.class_id].name
      when "Hu��an" #���E�N
        pantsu = "under��ear"
      when "I��p","Devil ","De��on", "Goblin", "Goblin Leader "
        pantsu = "panties"
      when "Night��are"
        pantsu = "tights"
      when "Werewolf", "Werecat ", "Ta��a��o"
        pantsu = "loin cloth"
      when "Sli��e", "Gold Sli��e "
        pantsu = "loin mucus"
      when "Gargoyle"
        pantsu = "groin slate"
      else
        pantsu = "panties"
      end
      #------------------------------------------------------------------------#
      #�U�߂̌`�e
      # �ǌ����łȂ��ꍇ
      if $game_switches[78] == false
        tec = ["erratically","amorously"]
        tec.push("skillfully") if myself.positive?
        tec.push("smoothly") if myself.positive?
        tec.push("coyly") if myself.negative?
        tec.push("blissfully") if myself.negative?
      # �ǌ����̏ꍇ
      else
        tec = ["delightfully","amorously"]
        tec.push("relentlessly") if myself.positive?
        tec.push("provokingly") if myself.positive?
        tec.push("ecstatically") if myself.negative?
        tec.push("eagerly") if myself.negative?
      end
      tec = tec[rand(tec.size)]
  #================================================================================================================================#
      # ���X�L�����Ŕ��f(�z�[���h���͓G�������ʂ̂��߂������)
      case skill.name
  #------------------------------------------------------------------------#
      when "����E����"
        if target.is_a?(Game_Enemy) #�G�l�~�[��E������
          action = premess + ",\n\ atte��pts to take off #{targetname}'s clothes!"
          #�X���C���n�͐�p�̃e�L�X�g�ƂȂ�
          action = premess + ",\n\ attempts to push\n\ away #{targetname}'s protective slime!" if target.tribe_slime?
        elsif target.is_a?(Game_Actor) #�A�N�^�[���E�������
          action = premess + ",\n\ tries to take off #{targetname}'s clothes!"
          #�X���C���n�͐�p�̃e�L�X�g�ƂȂ�
          action = premess + ",\n\ tries to push away #{targetname}'s protective slime!" if target.tribe_slime?
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "����E��"
        if myself == $game_actors[101]
          action = "#{myname} took off his clothes!"
        else
          action = "#{myname} took off her clothes!"
        end
        if myself == $game_actors[101]
          action = "#{myname} thre�� off his clothes! " if myself.berserk == true
        else
          action = "#{myname} thre�� off her clothes! " if myself.berserk == true
        end
        #�X���C���n�͐�p�̃e�L�X�g�ƂȂ�
        action = "#{myname} released her protective sli��e coating!" if target.tribe_slime?
        action = "#{myname}'s sli��e coating splits and explodes\n off of her, revealing her voluptuously naked body!" if target.tribe_slime? and myself.berserk == true
        avoid = ""
  #------------------------------------------------------------------------#
      when "�C���T�[�g","�V�F���}�b�`","�A�N�Z�v�g","�f�B���h�C���T�[�g"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          case $mood.point
          when 50..100
            case $data_SDB[target.class_id].name
            when "I��p", "Familiar", "Goblin", "Goblin Leader ", "Unique Tycoon "
              action = premess + ",\n\ pins do��n #{targetname}'s s��all body fro�� above!"
            when "Caster", "Little Witch", "Lili��", "Slave "
              action = premess + ",\n\ pins do��n #{targetname}'s delicate body fro�� above!"
            else
              action = premess + ",\n\ pins do��n #{targetname}'s body fro�� above!"
            end
          else
            case $data_SDB[target.class_id].name
            when "I��p", "Familiar", "Goblin", "Goblin Leader ", "Unique Tycoon "
              action = premess + ",\n\ pushes do��n #{targetname}'s s��all body!"
            when "Caster", "Little Witch", "Lili��", "Slave "
              action = premess + ",\n\ pushes do��n #{targetname}'s delicate body!"
            else
              action = premess + ",\n\ pushes do��n #{targetname}'s body!"
            end
          end
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          case $mood.point
          when 50..100
            action = "#{targetname},\n\ has been pinned do��n by #{myname}!"
          else
            if target == $game_actors[101]
            action = "#{myname},\n\ forcibly sits do��n on top of #{targetname}!"
            else
            action = "#{targetname},\n\ has been pushed do��n by #{myname}!"
            end
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�o�b�N�C���T�[�g","�f�B���h�C���o�b�N"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          case $mood.point
          when 50..100
            case $data_SDB[target.class_id].name
            when "I��p", "Familiar", "Goblin", "Goblin Leader ", "Unique Tycoon "
              action = premess + ",\n\ pins do��n #{targetname}'s s��all body fro�� above!"
            when "Caster", "Little Witch", "Lili��", "Slave "
              action = premess + ",\n\ pins do��n #{targetname}'s delicate body fro�� above!"
            else
              action = premess + ",\n\ pins do��n #{targetname}'s body fro�� above!"
            end
          else
            case $data_SDB[target.class_id].name
            when "I��p", "Familiar", "Goblin", "Goblin Leader ", "Unique Tycoon "
              action = premess + ",\n\ pushes do��n #{targetname}'s s��all body!"
            when "Caster", "Little Witch", "Lili��", "Slave "
              action = premess + ",\n\ pushes do��n #{targetname}'s delicate body!"
            else
              action = premess + ",\n\ pushes do��n #{targetname}'s body!"
            end
          end
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          case $mood.point
          when 50..100
            action = "#{targetname},\n\ has been pinned do��n by #{myname}!"
          else
            action = "#{targetname},\n\ has been pushed do��n by #{myname}!"
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
            when "I��p", "Familiar", "Goblin", "Goblin Leader ", "Unique Tycoon "
              action = premess + ",\n\ pins do��n #{targetname}'s s��all body fro�� above!"
            when "Caster", "Little Witch", "Lili��", "Slave "
              action = premess + ",\n\ pins do��n #{targetname}'s delicate body fro�� above!"
            else
              action = premess + ",\n\ pins do��n #{targetname}'s body fro�� above!"
            end
          else
            case $data_SDB[target.class_id].name
            when "I��p", "Familiar", "Goblin", "Goblin Leader ", "Unique Tycoon "
              action = premess + ",\n\ pushes do��n #{targetname}'s s��all body!"
            when "Caster", "Little Witch", "Lili��", "Slave "
              action = premess + ",\n\ pushes do��n #{targetname}'s delicate body!"
            else
              action = premess + ",\n\ pushes do��n #{targetname}'s body!"
            end
          end
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          if myself.full_nude?
            case $mood.point
            when 50..100
              if target == $game_actors[101]
              action = "Giving #{targetname} a full vie�� of her nethers,\n\ #{myname} opens up her crotch ��ith her fingers\n\ and starts lo��ering herself over his face!"
              else
              action = "Giving #{targetname} a full vie�� of her nethers,\n\ #{myname} opens up her crotch ��ith her fingers\n\ and starts lo��ering herself over her face!"
              end
            else
              if target == $game_actors[101]
              action = "Sho��ing #{targetname} a clear vie�� of her nethers,\n\ #{myname} tries to ��ash herself do��n\n\  on his face!"
              else
              action = "Sho��ing #{targetname} a clear vie�� of her nethers,\n\ #{myname} tries to ��ash herself do��n\n\  on her face!"
              end
            end
          else
            case $data_SDB[myself.class_id].name
            when "Caster","Familiar","Little Witch","Witch "
              action = "Standing over #{targetname}'s face,\n\ #{myname} lifts up her skirt to give him a clear vie��!"
            when "Lesser Succubus ","Succubus"
              action = "�govering over #{targetname}'s face,\n\#{myname}'s revealing panties can be clearly seen!"
            when "I��p","Devil "
              if target == $game_actors[101]
              action = "Flying over #{targetname}'s face,\n\#{myname} gives him a vie�� bet��een her strong legs!"
              else
              action = "Flying over #{targetname}'s face,\n\#{myname} gives her a vie�� bet��een her strong legs!"
              end
            when "Sli��e"
              if target == $game_actors[101]
              action = "Slithering over #{targetname},\n\ #{myname} covers him in sli��e and begins\n aligning herself\n\  to his head!"
              else
              action = "Slithering over #{targetname},\n\ #{myname} covers her in sli��e and begins\n aligning herself\n\  to her head!"
              end
            when "Night��are"
              action = "�govering over #{targetname}'s face,\n\#{myname} offers an enticing vie�� through her thin panties!"
            else
              if target == $game_actors[101]
              action = "#{myname} aligns herself over #{targetname}'s face,\n\ and begins to lo��er herself!"
              else
              action = "#{myname} aligns herself over #{targetname}'s face,\n\ and begins to lo��er herself!"
              end
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
            when "I��p", "Familiar", "Goblin", "Goblin Leader ", "Unique Tycoon "
              action = premess + ",\n\ pins do��n #{targetname}'s s��all body fro�� above!"
            when "Caster", "Little Witch", "Lili��", "Slave "
              action = premess + ",\n\ pins do��n #{targetname}'s delicate body fro�� above!"
            else
              action = premess + ",\n\ pins do��n #{targetname}'s body fro�� above!"
            end
          else
            case $data_SDB[target.class_id].name
            when "I��p", "Familiar", "Goblin", "Goblin Leader ", "Unique Tycoon "
              action = premess + ",\n\ pushes do��n #{targetname}'s s��all body!"
            when "Caster", "Little Witch", "Lili��", "Slave "
              action = premess + ",\n\ pushes do��n #{targetname}'s delicate body!"
            else
              action = premess + ",\n\ pushes do��n #{targetname}'s body!"
            end
          end
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          case $mood.point
          when 50..100
            action = "Loo��ing over #{targetname}'s eyes,\n\#{myname}'s ass dra��s closer!"
          else
            action = "Loo��ing over #{targetname}'s eyes,\n\#{myname}'s ass dra��s closer!"
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�h���E�l�N�^�["
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + ",\n\ buries face-first bet��een #{targetname}'s legs,\\n deep into her crotch!"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          if myself.positive?
            emotion = "eats out her pussy ��ith a seductive s��ile"
          elsif myself.negative?
            emotion = "puckers her lips to plants a kiss"
          else
            emotion = "gingerly sticks out her tongue"
          end
          action = "Bringing her face closer to #{targetname}'s pussy,\n\ #{myname} #{emotion}!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�I�[�����A�N�Z�v�g"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + ",\n\ buries face-first bet��een #{targetname}'s legs,\\n deep into her crotch!"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          if myself.positive?
            emotion = "puckers her lips to plant a kiss"
          elsif myself.negative?
            emotion = "opens her ��outh ��ide ��ith certainty"
          else
            emotion = "opens her ��outh slo��ly"
          end
          action = "Bringing her face close to #{targetname}'s penis,\n\ #{myname} #{emotion}!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�t���b�^�i�C�Y"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + ",\n\ pulls #{targetname} in close!"
          action = premess + ",\n\ turns #{targetname} around to ��eet face-to-face!" if target.holding?
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          if myself.positive?
            action = premess + ",\n\ pulls #{targetname} in close!"
          elsif myself.negative?
            action = premess + " closes her eyes,\n\ bringing her face close to #{targetname}'s lips!"
          else
            action = premess + ",\n\ pulls #{targetname} in close!"
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�G���u���C�X"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + ",\n\ clings to #{targetname} fro�� the rear!"
          action = premess + ",\n\ bends over #{targetname}, e��bracing her fro�� behind!" if target.holding?
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          action = "#{myname} clings to #{targetname} fro�� the rear!"
          action = "#{myname} bends over #{targetname}, e��bracing fro�� behind!" if target.holding?
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�y���X�R�[�v"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + ",\n\ clings to #{targetname}'s ��aist!"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          action = "#{myname} tries to bury #{targetname}'s penis in her #{myself.bustsize}!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�w�u�����[�t�B�[��"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + " extends out her arms,\n\ pressing down on #{targetname}!"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          action = premess + "\ tries to\n envelop #{targetname} in her #{myself.bustsize}!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�f�����Y�A�u�\�[�u"
        action = "#{myname} opens up a tentacle,\n\ and begins bringing it down over #{targetname}'s penis!"
        avoid = ""
  #------------------------------------------------------------------------#
      when "�f�����Y�h���E"
        action = "#{myname}'s tentacle wriggles suspiciously,\n\ then lunges at #{targetname}'s crotch!"
        avoid = ""
  #------------------------------------------------------------------------#
      when "�w�u�����[�t�B�[��"
        if target.is_a?(Game_Enemy) #�G�l�~�[���z�[���h����
          action = premess + " extends out her arms,\n\ pressing down on #{targetname}!"
        elsif target.is_a?(Game_Actor) #�A�N�^�[���z�[���h�����
          action = premess + "\ tries to\n envelop #{targetname} in her #{myself.bustsize}!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when "�����[�X"
        action = premess + " t��ists around,\\n in atte��pt to separate fro�� #{targetname}'s hold!"
        action = premess + " struggles about,\\n atte��pting to escape fro�� #{targetname}'s hold!" if myself.initiative_level == 0
        avoid = ""
  #------------------------------------------------------------------------#
      when "�C���^���v�g"
        if myself == $game_actors[101]
          for i in $game_party.actors
            if i.exist? and i != $game_actors[101]
              partner = i
            end
          end
          action = premess + "#{partner.name}������񂹁A\n\�������Ă���#{targetname}�Ɨ������Ǝ��݂��I"
        elsif myself.positive?
          action = premess + "�v�킹�Ԃ�ȑԓx�ŁA\n\#{targetname}�̋C����炻���Ǝ��݂��I"
        elsif myself.negative?
          action = premess + "#{$game_actors[101].name}�ɕ������A\n\#{targetname}�Ƃ̊ԂɊ����ē��낤�Ǝ��݂��I"
        else
          action = premess + "�v�킹�Ԃ�ȑԓx�ŁA\n\#{targetname}�̋C����炻���Ǝ��݂��I"
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
          action = premess + ",\n\ ��hispers quietly into #{targetname}'s ear!"
        else
          action = premess + ",\n\ starts speaking to #{targetname}!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 81    #�L�b�X
        held = ""
        if myself.holding?
          held = " changed posture,\n\ and"
        end
        case $mood.point
        when 50..100
          case myself.personality
          when "�����C", "�r��", "����"
            action = premess + "#{held} aggressively presses a kiss against #{targetname}'s lips!"
          when "�D�F", "�Â���"
            action = premess + "#{held} exchanged a passionate kiss ��ith #{targetname}!"
          when "�W��", "���C", "���"
            action = premess + "#{held} gently presses her lips against #{targetname}'s!"
          else
            action = premess + "#{held} exchanged a strong kiss ��ith #{targetname}!"
          end
        else
          action = premess + "#{held} exchanged kisses ��ith #{targetname}!"
        end
  #------------------------------------------------------------------------#
      when 82    #�o�X�g
        brk2 = ""
        brk2 = "\n\" if targetname.size + target.bustsize.size > 36 and $mood.point >= 50 #���\���Ɩ������𑫂��ĂP�Q�����z��
        if target.nude?
          if skill.element_set.include?(71) #����g�p
            if myself == $game_actors[101]
            action = premess + " uses his hands to caress #{targetname}'s\n\ #{target.bustsize}!"
            else
            action = premess + " uses her hands to caress\n\ #{targetname}'s #{target.bustsize}!"
            end
            action = premess + " reaches out a hand to caress\n\ #{targetname}'s #{target.bustsize}!" if myself.holding?
          elsif skill.element_set.include?(72) #�����g�p
            if myself == $game_actors[101]
            action = premess + " caresses #{targetname}'s #{target.bustsize}\n\ ��ith his ��outh!"
            else
            action = premess + " caresses #{targetname}'s\n\ #{target.bustsize} ��ith her ��outh!"
            end
            if myself == $game_actors[101]
            action = premess + " shifts his body, suckling \n\#{targetname}'s #{target.bustsize} ��ith his ��outh!" if myself.holding?
            else
            action = premess + " shifts her body, suckling \n\#{targetname}'s #{target.bustsize} ��ith her ��outh!" if myself.holding?
            end
          end
        else
          if skill.element_set.include?(71) #����g�p
            if myself == $game_actors[101]
            action = premess + " uses his hands to caress #{targetname}'s\n\ #{target.bustsize} through her clothes!"
            else
              if target == $game_actors[101]
              action = premess + " uses her hands to caress\n\ #{targetname}'s #{target.bustsize} through his clothes!"
              else
              action = premess + " uses her hands to caress\n\ #{targetname}'s #{target.bustsize} through her clothes!"
              end
            end
            if target == $game_actors[101]
            action = premess + " reaches out a hand to caress #{targetname}'s\n\ #{target.bustsize}\n\ through his clothes!" if myself.holding?
            else
            action = premess + " reaches out a hand to caress\n\ #{targetname}'s #{target.bustsize}\n\ through her clothes!" if myself.holding?
            end
          elsif skill.element_set.include?(72) #�����g�p
            if myself == $game_actors[101]
            action = premess + " uses his ��outh to caress #{targetname}'s\n\ #{target.bustsize} through her clothes!"
            else
              if target == $game_actors[101]
              action = premess + " uses her ��outh to caress\n\ #{targetname}'s #{target.bustsize} through his clothes!"
              else
              action = premess + " uses her ��outh to caress\n\ #{targetname}'s #{target.bustsize} through her clothes!"
              end
            end
            if myself == $game_actors[101]
            action = "Shifting his body, he suckles \n\#{targetname}'s #{target.bustsize} through her\n\ clothes ��ith his ��outh!" if myself.holding?
            else
              if target == $game_actors[101]
              action = "Shifting her body, she suckles \n\#{targetname}'s #{target.bustsize} through his\n\ clothes ��ith her ��outh!" if myself.holding?
              else
              action = "Shifting her body, she suckles \n\#{targetname}'s #{target.bustsize} through her\n\ clothes ��ith her ��outh!" if myself.holding?
              end
            end
          end
        end
        #���[�h�ɂ��U�ߕ��ω��f�f
        case $mood.point
        when 0..100#50..100
          action.gsub!("���","�w��") 
          action.gsub!("����","���")
          #�U���Ώې؂�ւ�
          if $game_variables[17] > 50
            action.gsub!("chest","nipples") 
            action.gsub!("youthful breasts","pretty nipples") 
            action.gsub!("shapely breasts","pointed nipples") 
            action.gsub!("round breasts","supple nipples") 
            action.gsub!("voluptuous breasts","supple nipples") 
            action.gsub!("incredible breasts","supple nipples") 
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
        brk2 = "\n\" if targetname.size > 24 and $mood.point >= 50 #�W�����z���̖�����
        if target.nude?
          if skill.element_set.include?(71) #����g�p
            if myself == $game_actors[101]
            action = premess + " uses his hands to caress\n\ #{targetname}'s butt!"
            else
            action = premess + " uses her hands to caress\n\ #{targetname}'s butt!"
            end
            action = premess + " reaches out a hand to caress\n\ #{targetname}'s ass!" if myself.holding?
          elsif skill.element_set.include?(72) #�����g�p
            if myself == $game_actors[101]
            action = premess + " uses his ��outh to caress\n\ #{targetname}'s butt!"
            else
            action = premess + " uses her ��outh to caress\n\ #{targetname}'s butt!"
            end
            if myself == $game_actors[101]
            action = premess + " shifts his body to caress #{targetname}'s\n\ ass ��ith his ��outh!" if myself.holding?
            else
            action = premess + " shifts her body to caress\n\ #{targetname}'s ass ��ith her ��outh!" if myself.holding?
            end
          end
        else
          if skill.element_set.include?(71) #����g�p
            if myself == $game_actors[101]
            action = premess + " uses his hands to caress #{targetname}'s\n\ ass through her #{pantsu}!"
            else
              if target == $game_actors[101]
              action = premess + " uses her hands to caress\n\ #{targetname}'s butt through his #{pantsu}!"
              else
              action = premess + " uses her hands to caress\n\ #{targetname}'s ass through her #{pantsu}!"
              end
            end
            if target == $game_actors[101]
            action = premess + " reaches out a hand to caress\n\ #{targetname}'s butt through his #{pantsu}!" if myself.holding?
            else
            action = premess + " reaches out a hand to caress\n\ #{targetname}'s ass through her #{pantsu}!" if myself.holding?
            end
          elsif skill.element_set.include?(72) #�����g�p
            if myself == $game_actors[101]
            action = premess + " uses his ��outh to caress #{targetname}'s\n\ ass through her #{pantsu}!"
            else
              if target == $game_actors[101]
              action = premess + " uses her ��outh to caress\n\ #{targetname}'s butt through his #{pantsu}!"
              else
              action = premess + " uses her ��outh to caress\n\ #{targetname}'s ass through her #{pantsu}!"
              end
            end
            if myself == $game_actors[101]
            action = premess + " shifts his body to caress #{targetname}'s\n\ ass through her #{pantsu}!" if myself.holding?
            else
              if target == $game_actors[101]
              action = premess + " shifts her body to caress\n\ #{targetname}'s butt through his #{pantsu}!" if myself.holding?
              else
              action = premess + " shifts her body to caress\n\ #{targetname}'s ass through her #{pantsu}!" if myself.holding?
              end
            end
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
        brk2 = "\n\" if targetname.size > 24 and $mood.point >= 50 #�W�����z���̖�����
        if target.nude?
          if skill.element_set.include?(71) #����g�p
            if myself == $game_actors[101]
            action = premess + " uses his hands\n\ to caress #{targetname}'s crotch!"
            else
            action = premess + " uses her hands\n\ to caress #{targetname}'s crotch!"
            end
            action = premess + " reaches out a hand to\n\ caress #{targetname}'s crotch!" if myself.holding?
          elsif skill.element_set.include?(72) #�����g�p
            if myself == $game_actors[101]
            action = premess + " uses his ��outh\n\ to caress #{targetname}'s crotch!"
            else
            action = premess + " uses her ��outh\n\ to caress #{targetname}'s crotch!"
            end
            if myself == $game_actors[101]
            action = premess + " shifts his body to caress\n\ #{targetname}'s crotch ��ith his ��outh!" if myself.holding?
            else
            action = premess + " shifts her body to caress\n\ #{targetname}'s crotch ��ith her ��outh!" if myself.holding?
            end
          end
        else
          if skill.element_set.include?(71) #����g�p
            if myself == $game_actors[101]
            action = premess + " uses his hands to caress #{targetname}'s\n\ pussy through her #{pantsu}!"
            else
              if target == $game_actors[101]
              action = premess + " uses her hands to caress\n\ #{targetname}'s penis through his #{pantsu}!"
              else
              action = premess + " uses her hands to caress\n\ #{targetname}'s pussy through her #{pantsu}!"
              end
            end
            if target == $game_actors[101]
            action = premess + " reaches out a hand to caress\n\ #{targetname}'s penis through his #{pantsu}!" if myself.holding?
            else
            action = premess + " reaches out a hand to caress\n\ #{targetname}'s pussy through her #{pantsu}!" if myself.holding?
            end
          elsif skill.element_set.include?(72) #�����g�p
            if myself == $game_actors[101]
            action = premess + " uses his ��outh to caress #{targetname}'s\n\ pussy through her #{pantsu}!"
            else
              if target == $game_actors[101]
              action = premess + " uses her ��outh to caress\n\ #{targetname}'s penis through his #{pantsu}!"
              else
              action = premess + " uses her ��outh to caress\n\ #{targetname}'s pussy through her #{pantsu}!"
              end
            end
            if myself == $game_actors[101]
            action = premess + " shifts his body to caress\n\ #{targetname}'s pussy through her #{pantsu}!" if myself.holding?
            else
              if target == $game_actors[101]
              action = premess + " shifts her body to caress\n\ #{targetname}'s penis through his #{pantsu}!" if myself.holding?
              else
              action = premess + " shifts her body to caress\n\ #{targetname}'s pussy through her #{pantsu}!" if myself.holding?
              end
            end
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
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\�A�\�R���C�荇�킹���I"
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
        if myself == $game_actors[101]
          action = premess + " thrusts his pelvis!"
        else
          action = premess + " shakes her waist!"
        end
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
          action = "Straddling #{targetname}'s face,\n\ #{myname} shakes her hips back and forth!"
          action = "Riding on top of #{targetname}'s face,\n\ #{myname} grinds her hips back and forth!" if $mood.point > 50
        else
          case $data_SDB[myself.class_id].name
          when "Caster","Familiar","Little Witch","Witch "
            action = "Fro�� underneath her skirt,\n\ #{myname} presses her undergar��ents against\n\ #{targetname}'s ��outh!"
          when "Lesser Succubus ","Succubus"
            action = "#{myname} drops do��n, pressing\n\ her #{pantsu} against #{targetname}'s ��outh!"
          when "I��p","Devil "
            action = "#{myname} drops do��n, pressing\n\ her #{pantsu} against #{targetname}'s ��outh!"
          when "Sli��e"
            action = "Riding on top of #{targetname}'s face,\n\ #{myname} presses her pussy into\n\ #{targetname}'s ��outh!"
          when "Night��are"
            action = "#{myname} drops do��n, pressing\n\ her #{pantsu} against #{targetname}'s ��outh!"
          else
            action = "#{myname} drops do��n, pressing\n\ her pussy against #{targetname}'s ��outh!"
          end
        end
  #------------------------------------------------------------------------#
      when 91   #�c�[�p�t
        #�ꕔ���i�Ŋ�{�e�L�X�g����
        case myself.personality
        when "�����C", "����", "�Ӓn��"
          action = premess + " pushes #{targetname}'s face\n\ bet��een her #{myself.bustsize}!"
        else
          action = premess + " ��raps #{targetname}'s face\n\ bet��een her #{myself.bustsize}!"
        end
  #------------------------------------------------------------------------#
      when 71,61   #���b�N
        if target.full_nude?
          case $mood.point
          when 50..100
            if myself == $game_actors[101]
            action = premess + " licks #{targetname}'s\n\ pussy ��ith his tongue!"
            else
            action = premess + " licks #{targetname}'s\n\ pussy ��ith her tongue!"
            end
          else
            if myself == $game_actors[101]
            action = premess + " caresses #{targetname}'s\n\ pussy ��ith his tongue!"
            else
            action = premess + " caresses #{targetname}'s\n\ pussy ��ith her tongue!"
            end
          end
          #�U���Ώې؂�ւ�
          if $game_variables[17] > 50
            action.gsub!("�A�\�R","�A�j") 
          end
        else
          case $data_SDB[target.class_id].name
          when "Sli��e"
            if myself == $game_actors[101]
            action = "Through her thick sli��e, #{myname}\n\ pushes against #{targetname}'s pussy ��ith his tongue!"
            else
            action = "Through her thick sli��e, #{myname}\n\ pushes against #{targetname}'s pussy ��ith her tongue!"
            end
          when "Night��are"
            if myself == $game_actors[101]
            action = "Through her thin loin cloth, #{myname}\n\ pushes against #{targetname}'s pussy ��ith his tongue!"
            else
            action = "Through her thin loin cloth, #{myname}\n\ pushes against #{targetname}'s pussy ��ith her tongue!"
            end
          else
            if myself == $game_actors[101]
            action = "Through her #{pantsu}, #{myname}\n\ pushes against #{targetname}'s pussy ��ith his tongue!"
            else
            action = "Through her #{pantsu}, #{myname}\n\ pushes against #{targetname}'s pussy ��ith her tongue!"
            end
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 72   #���b�N(�ΐK)
        case $mood.point
        when 50..100
          if myself == $game_actors[101]
          action = premess + " pushes against #{targetname}'s\n\ sphincter ��ith his tongue!"
          else
          action = premess + " pushes against #{targetname}'s\n\ sphincter ��ith her tongue!"
          end
        else
          if myself == $game_actors[101]
          action = premess + " caresses #{targetname}'s\n\ sphincter ��ith his tongue!"
          else
          action = premess + " caresses #{targetname}'s\n\ sphincter ��ith her tongue!"
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 73   #�~�X�`�[�t
        case $mood.point
        when 50..100
          action = premess + " reaches out with her hand,\n\ and caresses #{targetname}'s crotch!"
          if myself == $game_actors[101]
          action = premess + " embraces #{targetname} closely,\n\ and forces her tongue in his mouth!" if $game_variables[17] > 50
          else
          action = premess + " embraces #{targetname} closely,\n\ and forces her tongue in her mouth!" if $game_variables[17] > 50
          end
        else
          action = premess + " reaches out,\n\ softly stroking #{targetname}'s thighs!"
          if myself == $game_actors[101]
          action = premess + " holds back #{targetname} with her arms\n\ as she fondles her #{target.bustsize}!" if $game_variables[17] > 50
        else
          action = premess + " holds down #{targetname}\n\ with her arms while she rubs his #{target.bustsize}!" if $game_variables[17] > 50
          end
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 74   #���A�J���X
        case $mood.point
        when 50..100
          action = premess + " caresses #{targetname}'s\n\ crotch from the rear!"
          action = premess + " turns around, \n\ and tries to kiss #{targetname}!" if $game_variables[17] > 50
        else
          action = premess + "����ŁA\n\#{targetname}�̑��҂�D�������ŉ񂵂��I"
          action = premess + "�̂��悶��A\n\#{targetname}��#{target.bustsize}���h�������I" if $game_variables[17] > 50
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 641   #�f�����Y�X���[�g
        action = "#{myname}�̑���G�肪�A\n\#{targetname}�̃y�j�X���Ԓf�Ȃ��z���グ�Ă���I"
        action = "#{myname}�̑���G��̂Ђ����A\n\#{targetname}�̃y�j�X��₦�ԂȂ��h�����Ă���I"  if $game_variables[17] > 50
        avoid = ""
  #------------------------------------------------------------------------#
      when 642   #�f�����Y�T�b�N
        action = "#{myname}�̑���G�肪�A\n\#{targetname}�̃A�\�R���Ԓf�Ȃ��z�������Ă���I"
        action = "#{myname}�̑���G��̂Ђ����A\n\#{targetname}�̃A�\�R��₦�ԂȂ��������Ă���I"  if $game_variables[17] > 50
        avoid = ""
  #------------------------------------------------------------------------#
      when 79   #���b�N���X
        if myself == $game_actors[101]
        action = premess + "  shifts his body around, \n\ trying to change posture!"
        else
        action = premess + "  shifts her body around, \n\ trying to change posture!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 101   #�e�B�[�Y
        action = premess + ",\n\ teasingly caresses #{targetname}!"
        avoid = ""
  #------------------------------------------------------------------------#
      when 104   #�g���b�N���C�h
        action = premess + ",\n\ suddenly attacks #{targetname}!"
        avoid = ""
  #------------------------------------------------------------------------#
      when 106   #�f�B�o�E�A�[
        action = premess + " voraciously gropes and \n\ rubs down #{targetname}'s body!"
        avoid = ""
  #------------------------------------------------------------------------#
      when 121   #�u���X
        action = "#{myname} takes a deep breath!"
        avoid = ""
  #------------------------------------------------------------------------#
      when 122   #�J�[���u���X
        if myself == $game_actors[101]
        action = "#{myname} inhales deeply,\n\ calming his breathing!"
        else
        action = "#{myname} inhales deeply,\n\ calming her breathing!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 123   #�E�F�C�g
        action = "#{myname} ��aits and observes..."
        avoid = ""
  #------------------------------------------------------------------------#
      when 124   #�C���g���X�g
        if myself == $game_actors[101]
        action = "#{myname} relaxes his body!"
        else
        action = "#{myname} relaxes her body!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 125   #���t���b�V��
        if myself == $game_actors[101]
        action = "#{myname} calms his mind,\n\ clearing it of all abnormalities!"
        else
        action = "#{myname} calms her mind,\n\ clearing it of all abnormalities!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 126   #�`�F�b�N
        action = premess + " inspects #{targetname}!"
        avoid = ""
  #------------------------------------------------------------------------#
      when 127   #�A�i���C�Y
        action = premess + " exhaustively analyzes #{targetname}!"
        avoid = ""
  #------------------------------------------------------------------------#
      when 140   #�e���v�e�[�V����
        action = premess + "�A\n\#{targetname}�ɉ��߂������̋�𖣂������I"
        avoid = "������#{myname}�ɂ͌����Ȃ������I"
  #------------------------------------------------------------------------#
      when 145   #�K�[�h
        action = premess + " took a defensive stance!"
        avoid = ""
  #------------------------------------------------------------------------#
      when 146   #�C���f���A
        if myself == $game_actors[101]
        action = premess + " closed his eyes, focusing his ��ind!"
        else
        action = premess + " closed her eyes, focusing her ��ind!"
        end
        avoid = ""
  #------------------------------------------------------------------------#
      when 148   #�A�s�[��
        case $data_classes[myself.class_id].name
        when "Lesser Succubus "
          action = premess + " poses suggestively!"
        when "Succubus" #
          action = premess + " ��akes a suggestive pose!"
        when "I��p" #
          action = premess + " pesters the ene��y to\n\ play ��ith her!"
        when "Devil " #
          action = premess + " ��akes a provocative pose!"
        when "Sli��e" #
          action = premess + " poses suggestively!"
        when "Night��are" #
          action = premess + " invites the ene��y ��ith\n\ her sleepy eyes!"
        when "Caster" #
          action = premess + " pretends to be frightened!"
          action = premess + " invites the ene��y ��ith\n\ her defenseless appearance!" if myself.nude?
        when "Little Witch" #
          action = premess + " did a provocative pose!"
        when "Witch " #
          action = premess + " ��akes a provocative pose!"
        when "Familiar" #
          action = premess + " tucks up the he�� of her dress!"
          action = premess + " invites the ene��y ��ith\n\ her defenseless appearance!" if myself.nude?
        when "Unique Succubus " #
          action = premess + " ��akes a suggestive pose!"
        else
          action = premess + " ��akes a suggestive pose!"
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
        action += "\n\����#{s_range_text}�̋�����#{myname}�Ɉڂ����I" if myself.is_a?(Game_Actor)
        action += "\n\#{$game_actors[101].name}#{s_range_text}�͖ڂ����������Ă��܂����I" if myself.is_a?(Game_Enemy)
=end
        avoid = ""
      when 149   #�v�����H�[�N
          action = premess + " provokes the ene��y into attacking her!"
        
        
  #------------------------------------------------------------------------#        
      when 260   #�i���
        action = premess + " checks out #{targetname}!"
  #------------------------------------------------------------------------#        
      when 261   #��قǂ�
        action = premess + "\n\#{targetname}�̎������قǂ��������I"
  #------------------------------------------------------------------------#        
      when 262   #�Â₩��
        action = premess + "\n\#{targetname}�̓��������ƕ��ŊÂ₩�����I"
  #------------------------------------------------------------------------#        
      when 263   #�X�p���N
        action = premess + " gives #{targetname} a strong spank!"
  #------------------------------------------------------------------------#        
      when 275   #�₯�����R�A��
        action = premess + "�k���Ȃ���ジ��������Ă���I"
  #------------------------------------------------------------------------#        
      when 276   #�q�[���[�L�����O
        action = premess + "�E�ӂ����߂��r��U�肩�Ԃ����I\n\�h����f�₷��ꌂ��#{targetname}�ɕ������I�I"
  #------------------------------------------------------------------------#        
      when 277   #���e�I�G�N���v�X
        action = premess + "��ł̖��@���r�������I\n\�V�͊��ꐯ�͍ӂ��A��ł̎ܔM�����E�����ݍ��ށI"
  #------------------------------------------------------------------------#        
      when 278   #���[���h�u���C�J�[
        action = premess + "����Ȗ��͂���o�����I\n\�S�l�ނ̊�]���A�E�C���A�������I\n\�Ռ`���������苎��I�I"
  #------------------------------------------------------------------------#        
      when 297   #�t�B�A�[(�ؕ|���s������)
        action = premess + "�g�̂��v���悤�ɓ����Ȃ��I"
  #------------------------------------------------------------------------#        
      when 298   #�t���[�A�N�V����
        case $data_classes[myself.class_id].name
        when "Lesser Succubus "
          action = premess + " curiously flies around #{targetname}...."
          action = premess + "�A\n\�H���𓮂����ėV��ł���c�c" if $game_variables[17] >= 50
        when "Succubus" #
          action = premess + " s��iles alluringly...."
          action = premess + " is groo��ing her tail...." if $game_variables[17] >= 50
        when "Succubus Lord " #
          action = premess + " ��ears a captivating s��ile...."
          action = premess + " is groo��ing her tail...." if $game_variables[17] >= 50
        when "I��p" #
          action = premess + "�A\n\#{targetname}�̎��͂��щ���Ă���c�c"
          action = premess + "�A\n\�H���𓮂����ėV��ł���c�c" if $game_variables[17] >= 50
        when "Devil " #
          action = premess + " ��atches #{targetname} appraisingly, observing hi��..."
          action = premess + " s��iles ��ysteriously at #{targetname}...." if $game_variables[17] >= 50
        when "De��on" #
          action = premess + " ��atches #{targetname} appraisingly, observing hi��..."
          action = premess + " s��iles ��ysteriously at #{targetname}...." if $game_variables[17] >= 50
        when "Sli��e" #
          action = premess + "�g�̂��Ղ�Ղ�U��킹�Ă���c�c"
          action = premess + "�A\n\�����̐g�̂�F�X�Ȍ`�ɕς��ėV��ł���c�c" if $game_variables[17] >= 50
        when "Gold Sli��e " #
          action = premess + "�g�̂��Ղ�Ղ�U��킹�Ă���c�c"
          action = premess + "�A\n\�����̐g�̂�F�X�Ȍ`�ɕς��ėV��ł���c�c" if $game_variables[17] >= 50
        when "Night��are" #
          action = premess + " floats about, staring listlessly...."
          action = premess + " stares at #{targetname}'s\\n face ��ith sleepy eyes...." if $game_variables[17] >= 50
        when "Caster" #
          action = premess + " is tidying up her clothes..." if not myself.nude?
          action = premess + ", as through having just noticed, quickly starts fixing her clothes..." if not myself.nude? and $mood.point > 25
          action = premess + " see��s so��e��hat restless...." if myself.nude?
        when "Slave " #
          action = premess + "���̗���𒼂��Ă���c�c" if not myself.nude?
          action = premess + "�v���o�������̂悤�ɁA\n\�Q�Ăĕ��̗���𒼂��n�߂��c�c" if not myself.nude? and $mood.point > 25
          action = premess + "���������킻�킵�Ă���c�c" if myself.nude?
        when "Little Witch" #
          action = premess + "�l���݂�����悤�ɁA\n\#{targetname}���ώ@���Ă���c�c"
          action = premess + "�X�q�̎������n�߂��c�c" if $game_variables[17] >= 50
        when "Witch " #
          action = premess + "�l���݂�����悤�ɁA\n\#{targetname}���ώ@���Ă���c�c"
          action = premess + "�X�q�̎������n�߂��c�c" if $game_variables[17] >= 50
        when "Familiar" #
          action = premess + "#{targetname}�̗l�q���M���A\n\�����l������ł���c�c"
          action = premess + "�����ƒ��߂̗���𒼂����c�c" if not myself.nude?
          action = premess + "�Â��ɂ�������ł���c�c" if $game_variables[17] >= 50
        when "Werewolf" #
          action = premess + "�X�萺���グ�Ă���c�c"
          action = premess + "�K����U���Ă���c�c" if $game_variables[17] >= 50
        when "Werecat " #
          action = premess + "�ёU�������Ă���c�c"
          action = premess + "���낲��ƍA��炵�Ă���c�c" if $game_variables[17] >= 50
        when "Goblin" #
          action = premess + "�l�q���M���Ă���c�c"
          action = premess + "�^�������ɁA\n\#{targetname}�̊�����߂Ă���c�c" if $game_variables[17] >= 50
        when "Goblin Leader " #
          action = premess + "�l�q���M���Ă���c�c"
          action = premess + "�^�������ɁA\n\#{targetname}�̊�����߂Ă���c�c" if $game_variables[17] >= 50
        when "Priestess " #
          action = premess + "�l�q���M���Ă���c�c"
          action = premess + "���̗���𒼂��Ă���c�c" if not myself.nude?
          action = premess + "��W�Ȗڂ��ŁA\n\#{targetname}�����߂Ă���c�c" if $game_variables[17] >= 50
        when "Cursed Magus" #
          action = premess + "�l���݂�����悤�ɁA\n\#{targetname}���ώ@���Ă���c�c"
          action = premess + "#{targetname}�ɁA\n\�d�����ȏ΂݂������Ă���c�c" if $game_variables[17] >= 50
        when "Alraune " #
          action = premess + "�j�R���Ɣ��΂𕂂��ׂ��c�c"
          action = premess + "�s�G�ȏ΂݂𕂂��ׂĂ���c�c" if $game_variables[17] >= 50
        when "Matango " #
          action = premess + "���̗���𒼂��Ă���c�c" if not myself.nude?
          action = premess + "�v���o�������̂悤�ɁA\n\�Q�Ăĕ��̗���𒼂��n�߂��c�c" if not myself.nude? and $mood.point > 25
          action = premess + "���������킻�킵�Ă���c�c" if myself.nude?
        when "Dark Angel" #
          action = premess + "�������ڂ��Ŕ��΂�ł���c�c"
          action = premess + "�s�G�ȏ΂݂𕂂��ׂĂ���c�c" if $game_variables[17] >= 50
        when "Gargoyle" #
          action = premess + "�x������悤�ɁA\n\#{targetname}���ώ@���Ă���c�c"
          action = premess + "��W�Ȗڂ��ŁA\n\#{targetname}�����߂Ă���c�c" if $game_variables[17] >= 50
        when "Mi��ic" #
          action = premess + "���f�I�ȏ΂݂𕂂��ׂĂ���c�c"
          action = premess + "�󔠂̒����m�F���Ă���c�c" if $game_variables[17] >= 50
        when "Ta��a��o" #
          action = premess + "�l���݂�����悤�ɁA\n\#{targetname}���ώ@���Ă���c�c"
          action = premess + "�����ƐK����h�炵�Ă���c�c" if $game_variables[17] >= 50
        when "Lili��"
          action = premess + "�A\n\#{targetname}�̎��͂��щ���Ă���c�c"
          action = premess + "���f�I�ȏ΂݂𕂂��ׂĂ���c�c"if $game_variables[17] >= 50
        else
          action = premess + "�l�q���M���Ă���c�c"
          # ���j�[�N�G�l�~�[
          case $data_classes[myself.class_id].color
          when "Neijorange"
            action = premess + "�j�R���Ɣ��΂𕂂��ׂ��c�c"
            action = premess + "�����Ɨh��Ă���c�c" if $game_variables[17] >= 50
          when "Rejeo "
            action = premess + "�l�q���M���Ă���c�c"
            action = premess + "�l���݂�����悤�ɁA\n\#{targetname}���ώ@���Ă���c�c" if $game_variables[17] >= 50
          when "Fulbeua "
            action = premess + "�����I�Ȗڂ��ŁA\n\#{targetname}�����Ă���c�c"
            action = premess + "�s�G�ȏ΂݂𕂂��ׂĂ���c�c" if $game_variables[17] >= 50
          when "Gilgoon "
            action = premess + "�x������悤�ɁA\n\#{targetname}���ώ@���Ă���c�c"
            action = premess + "���̗���𒼂��Ă���c�c" if not myself.nude?
            action = premess + "�v���o�������̂悤�ɁA\n\�Q�Ăĕ��̗���𒼂��n�߂��c�c" if not myself.nude? and $mood.point > 25
            action = premess + "���������킻�킵�Ă���c�c" if myself.nude?
            # ���E���
            if $game_switches[395]
              action = premess + "���΂������Ă���c�c"
            # ���E�j����
            elsif $game_switches[394]
              action = premess + "�k���Ă���c�c"
            end
          when "Yuganaught"
            action = premess + "�G��ɐ����|���Ă���c�c"
            action = premess + "#{targetname}�ɁA\n\�d�����ȏ΂݂������Ă���c�c" if $game_variables[17] >= 50
          when "Sylphe"
            action = premess + "�j�R���Ɣ��΂𕂂��ׂ��c�c"
            action = premess + "���f�I�ȏ΂݂𕂂��ׂĂ���c�c" if $game_variables[17] >= 50
          when "Ramile"
            action = premess + "�������ڂ��Ŕ��΂�ł���c�c"
            action = premess + "�f����R�炵�Ă���c�c" if $game_variables[17] >= 50
          when "Vermiena"
            action = premess + "�����I�Ȗڂ��ŁA\n\#{targetname}�����Ă���c�c"
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
            action = premess + "�����������肽�����ɁA\n\#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "���������΂��Ă���c�c"
            action = premess + "�d�����΂݂𕂂��ׁA\n\#{targetname}�̗������߂Ă���c�c" if $game_variables[17] >= 50 and target.nude?
          end
        when "��i" #
          if target.holding?
            action = premess + "�s�ׂ��C�ɂȂ�̂��A\n\#{targetname}�B�����ڂŊώ@���Ă���c�c"
          else
            action = premess + "�_�炩�����΂𕂂��ׂĂ���c�c"
            action = premess + "���񂾓��ŁA\n\#{targetname}�����߂Ă���c�c" if $game_variables[17] >= 50 and myself.crisis?
          end
        when "����" #
          if target.holding?
            action = premess + "���G�ȕ\��ŁA\n\#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "�������悤�Ȏ����ŁA\n\#{targetname}���ɂ�ł���c�I"
            action = premess + "���炿��Ɖ��ڂŁA\n\#{targetname}�̗l�q�����������Ă���c�c" if $mood.point > 24
            action = premess + "�����ɋC�Â��ƁA\n\#{targetname}����Ղ��Ɩڂ���炵���c�c" if $mood.point > 49
          end
        when "�W��" #
          if target.holding?
            action = premess + "�w�����킦�āA\n\#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "���邭��Ɣ����w�ɗ��߂Ă���c�c"
            action = premess + "�ڂ���āA\n\�������v���ɒ^���Ă���c�c" if $game_variables[17] >= 50
          end
        when "�_�a" #
          if target.holding?
            action = premess + "���΂𕂂��ׂāA\n\#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "�_�炩�����΂𕂂��ׂĂ���c�c"
          end
        when "�����C" #
          if target.holding?
            action = premess + "����z���ꂽ�Ƃ΂���ɁA\n\#{targetname}�B�����ĉ��������Ă���c�c"
          else
            action = premess + "���ނ悤�ȖڂŁA\n\#{targetname}�̗l�q���f���Ă���c�c"
          end
        when "���C" #
          if target.holding?
            action = premess + "��𗼎�ŕ����āA\n\#{targetname}�B�̍s�ׂ����Ȃ��悤�ɂ��Ă���c�c"
            action = premess + "��𗼎�ŕ������A\n\���Ԃ���#{targetname}�B�̍s�ׂ����Ă���c�c" if $mood.point > 24
            action = premess + "�H������悤�ɁA\n\#{targetname}�B�̍s�ׂ����Ă���c�c" if $mood.point > 49
          else
            action = premess + "���ނ��āA\n\�����������������ɂ��Ă���c�c"
            action = premess + "�p�����������ɁA\n\#{targetname}����ڂ���炵�Ă���c�c"
            action = premess + "�����������Ȃ���A\n\#{targetname}�����߂Ă���c�c" if $mood.point > 24
          end
        when "�z�C" #
          if target.holding?
            action = premess + "�����������肽�����ɁA\n\#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "���ʂ̏Ί�ŁA\n\#{targetname}�̊��`������ł���c�c"
          end
        when "�Ӓn��" #
          if target.holding?
            action = premess + "�s�ׂ��C�ɂȂ�̂��A\n\#{targetname}�B�����ڂŊώ@���Ă���c�c"
          else
            action = premess + "���₩�ȖڂŁA\n\#{targetname}�̗l�q���M���Ă���c�c"
            action = premess + "�������v�������悤�ɁA\n\�j�����Ə΂݂𕂂��ׂ��c�c" if $game_variables[17] >= 50
          end
        when "�V�R" #
          action = premess + "�ځ[���Ɨ]���������Ă���c�c"
        when "�]��" #
          if target.holding?
            action = premess + "�w�����킦�āA\n\#{targetname}�B�̍s�ׂ������ƌ��߂Ă���c�c"
          else
            action = premess + "�A\n\#{targetname}����̓�����������Ă���c�c"
          end
        when "����" #
          if target.holding?
            action = premess + "�s�ׂ��C�ɂȂ�̂��A\n\#{targetname}�B�����ڂŊώ@���Ă���c�c"
            action = premess + "�H������悤�ɁA\n\#{targetname}�B�̍s�ׂ����Ă���c�c" if $mood.point > 24
          else
            action = premess + "���M���X�̊�ŁA\n\�s�G�ȏ΂݂𕂂��ׂĂ���c�c"
            action = premess + "�S�Ȃ������킻�킵�Ă���c�c" if $mood.point > 24
            action = premess + "���̂������ӂ����Ă���c�c" if $mood.point > 49
          end
        when "�|��" #
          if target.holding?
            action = premess + "�d�����΂݂𕂂��ׂāA\n\#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "���������΂��Ă���c�c"
          end
        when "�Â���" #
          if target.holding?
            action = premess + "�����ÁX�̖ڂŁA\n\#{targetname}�B�̍s�ׂ����߂Ă���c�c"
          else
            action = premess + "�����ÁX�̖ڂŁA\n\#{targetname}�����߂Ă���c�c"
          end
        when "�s�v�c" #
          if target.holding?
            action = premess + "�����l���Ă��邩����Ȃ��\��ŁA\n\#{targetname}�B�̍s�ׂ������낵�Ă���c�c"
          else
            action = premess + "�����v�����̂��A\n\���˂ɂ��̏�ł����Ɨx��n�߂��c�c"
          end
        when "�ƑP" #�t���r���A��p
          if target.holding?
            action = premess + "#{targetname}�̎����ɋC�t���A\n\��l�[�������悤�ɔ��΂񂾁c�c"
          else
            action = premess + "#{targetname}�̎����ɋC�t���A\n\��l�[�������悤�ɔ��΂񂾁c�c"
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
          action = premess + "�A\n\#{targetname}�̐O�ɂ����ƐO���d�˂Ă����I"
        else
          action = premess + "�A\n\#{targetname}�ɂ����ƃL�X�����Ă����I"
        end
      when 302   #�L�b�X��
        case myself.personality
        when "�W��", "���C"
          action = premess + "�ڂ���āA\n\#{targetname}�ɂ����ƃL�X�����Ă����I"
        else
          action = premess + "�A\n\#{targetname}�ɃL�X�����Ă����I"
        end
      when 303   #�L�b�X��
        case myself.personality
        when "�W��", "���C", "����"
          action = premess + "�ڂ���āA\n\#{targetname}�Ɖ��x���L�X���J��Ԃ��Ă����I"
        else
          action = premess + "��𗍂߂�悤�ɁA\n\#{targetname}�ɏ�M�I�ȃL�X�����Ă����I"
        end
      when 304   #�L�b�X�K�E
        case myself.personality
        when "�W��", "���C", "����"
          action = premess + "����񂾓��ŁA\n\�Â�悤��#{targetname}�ɃL�X�����Ă����I"
        else
          action = premess + "��𗍂߂�悤�ɁA\n\#{targetname}�ɏ�M�I�ȃL�X�����Ă����I"
        end
      when 305   #�L�b�X�ǌ�
        case myself.personality
        when "�W��", "���C", "����"
          action = premess + "��ڌ����ɁA\n\���x��#{targetname}�ɃL�X���d�˂Ă����I"
        else
          action = premess + "�Ȃ����������A\n\#{targetname}�ɏ�M�I�ȃL�X���d�˂Ă����I"
        end
      when 308   #���u���B�L�b�X
        action = premess + "���炵�����΂�ŁA\n\#{targetname}�ɂ����ƃL�X�����Ă����I"
      when 309   #���}���X�L�b�X
        action = premess + "���΂݂𕂂��ׁA\n\#{targetname}�Ə�M�I�ȃL�X�����킵���I"
      when 310   #�t�@�V�l�C�g�L�b�X
        action = premess + "�d���ȏ΂݂𕂂��ׁA\n\#{targetname}������񂹂Ă��̐O��D�����I"
  #------------------------------------------------------------------------#
  # ����Z�n
  #------------------------------------------------------------------------#
      when 319   #��U�߃y�j�X��
        if target.nude?
          action = premess + " gently touches #{targetname}'s\n\ penis ��ith her hand!"
          action = premess + " gently brushes #{targetname}'s\n\ penis ��ith her finger!" if $game_variables[17] > 50
          action += "\n\ precu�� dribbles out fro�� the pleasure!" if target.lub_male >= 60
        else
          if target == $game_actors[101]
          action = "#{myname} gently strokes #{targetname}'s\n\ penis through his #{pantsu}!"
          else
          action = "#{myname} gently strokes #{targetname}'s\n\ penis through her #{pantsu}!"
          end
        end
      when 320   #��U�߃y�j�X
        if target.nude?
          action = premess + " strokes #{targetname}'s\n\ penis ��ith her hand!"
          action = premess + " strokes #{targetname}'s\n\ penis ��ith her finger!" if $game_variables[17] > 50
          action += "\n\ precu�� is spilling out fro�� the intense pleasure!" if target.lub_male >= 60
        else
          if target == $game_actors[101]
          action = "#{myname} strokes #{targetname}'s\n\ penis through his #{pantsu}!"
          else
          action = "#{myname} strokes #{targetname}'s\n\ penis through her #{pantsu}!"
          end
        end
      when 321   #��U�߃y�j�X��
        if target.nude?
          #�e�L�X�g����
          action = premess + "#{tec},\n\ pu��ps #{targetname}'s penis ��ith her hand!"
          action = premess + "#{tec},\n runs her fingers over #{targetname}'s penis!" if $game_variables[17] > 50
          action += "\n\ precu�� is spilling out fro�� the intense pleasure!" if target.lub_male >= 60
          action.gsub!("�l�q��","�����") #�\���̕ύX
        else
          if target == $game_actors[101]
          action = "#{myname} quickly slips her\n\ hand into #{targetname}'s #{pantsu},\n\ running her hands over his penis!"
          else
          action = "#{myname} quickly slips her\n\ hand into #{targetname}'s #{pantsu},\n\ running her hands over her penis!"
          end
        end
      when 322   #��U�߃y�j�X�K�E
        if target.nude?
          action = premess + "#{tec} happily plays\n\ around ��ith #{targetname}'s penis�I"
          action += "\n\ precu�� is spilling out fro�� the intense pleasure!" if target.lub_male >= 60
          action.gsub!("�l�q��","�����") #�\���̕ύX
        else
          if target == $game_actors[101]
          action = "#{myname} quickly slips her\n\ hand into #{targetname}'s #{pantsu},\n\ running her hands over his penis!"
          else
          action = "#{myname} quickly slips her\n\ hand into #{targetname}'s #{pantsu},\n\ running her hands over her penis!"
          end
        end
      when 323   #��U���Ίۏ�
        if target.nude?
          action = premess + " gently rubs her\n\ hand over #{targetname}'s testicles!"
          action = premess + " gently runs her\n\ fingers over #{targetname}'s testicles!" if $game_variables[17] > 50
        else
          if target == $game_actors[101]
          action = "#{myname} quickly slips her\n\ hand into #{targetname}'s #{pantsu},\n\ rubbing her hands over his scrotu��!"
          else
          action = "#{myname} quickly slips her\n\ hand into #{targetname}'s #{pantsu},\n\ rubbing her hands over her scrotu��!"
          end
        end
      when 324   #��U���ΊەK�E
        if target.nude?
          action = premess + " ��assages #{targetname}'s\n\\ testicles ��ith her hand!"
          action = premess + " feels up #{targetname}'s\n\\ testicles ��ith her fingers!" if $game_variables[17] > 50
        else
          if target == $game_actors[101]
          action = "#{myname} quickly slips her\n\ hand into #{targetname}'s #{pantsu},\n\ feeling up his scrotu��!"
          else
          action = "#{myname} quickly slips her\n\ hand into #{targetname}'s #{pantsu},\n\ feeling up her scrotu��!"
          end
        end
      when 325   #��U�߃y�j�X�ǌ�
        if target.nude?
          action = premess + "#{tec} continues to\n\ caress #{targetname}'s penis so��e ��ore!"
          action += "\n\ precu�� keeps spilling out fro�� the intense pleasure!" if target.lub_male >= 60
        else
          action = "#{myname} slips her hand in again\n\ to grope #{targetname}'s penis so��e ��ore!"
        end
      when 326   #��U���Ίےǌ�
        if target.nude?
          action = premess + "#{tec} continues to\n\ fondle #{targetname}'s balls so��e ��ore!"
        else
          action = "#{myname} slips her hand in again\n\ to fondle #{targetname}'s balls so��e ��ore!"
        end
  #------------------------------------------------------------------------#
      when 328   #��U�ߋ���
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}��#{target.bustsize}��#{brk3}�D�����G��Ă����I"
          action = premess + "��ŁA\n\#{targetname}�̓���ɗD�����G��Ă����I" if target.boy?
        else
          action = premess + "���̏ォ��A\n\#{targetname}��#{target.bustsize}��#{brk3}��ŗD�����G��Ă����I"
        end
        #���T�C�Y�f�f(�b�J�b�v�)
        case $data_SDB[target.class_id].bust_size
        when 4,5 #�c,�d
          action.gsub!("��������","�����") 
        end
      when 329   #��U�ߋ�
        if target.nude?
          action = premess + "����ŁA\n\#{targetname}��#{target.bustsize}��#{brk3}���݂������Ă����I"
          action = premess + "�w��ŁA\n\#{targetname}�̓�����h�����Ă����I" if target.boy?
        else
          action = premess + "���̏ォ��A\n\#{targetname}��#{target.bustsize}��#{brk3}��ŕ��ŉ񂵂Ă����I"
        end
        #���T�C�Y�f�f(�b�J�b�v�)
        case $data_SDB[target.class_id].bust_size
        when 1,2 #�`,�a
          action.gsub!("���݂�������","�����") 
        end
      when 330   #��U�ߋ���
        if target.nude?
          action = premess + "�w��ŁA\n\#{targetname}�̓�����܂ݎh�����Ă����I"
          action = premess + "�w��ŁA\n\#{targetname}�̓�����I�݂Ɏh�����Ă����I" if target.boy?
        else
          action = premess + "���Ɏ�����荞�܂��A\n\#{targetname}��#{target.bustsize}��#{brk3}���݂������Ă����I"
        end
        #���T�C�Y�f�f(�b�J�b�v�)
        case $data_SDB[target.class_id].bust_size
        when 1,2 #�`,�a
          action.gsub!("���݂�������","�����") 
        end
      when 331   #��U�ߋ��K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}��#{target.bustsize}��#{brk3}�v���܂ܘM�ԁI"
          action = premess + "#{tec}�A\n\#{targetname}�̓�����I�݂Ɏh�����Ă����I" if target.boy?
          action.gsub!("�l�q��","�����") #�\���̕ύX
        else
          action = premess + "���Ɏ�����荞�܂��A\n\#{targetname}��#{target.bustsize}��#{brk3}�v���܂ܘM�ԁI"
        end
      when 332   #��U�ߋ��ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}��#{target.bustsize}��#{brk3}�X�ɝ��݂��������I"
          action = premess + "#{tec}�A\n\#{targetname}�̓�����I�݂Ɏh�����Ă����I" if target.boy?
        else
          action = premess + "���Ɋ��荞�܂�����ŁA\n\#{targetname}��#{target.bustsize}���X�ɘM�ԁI"
        end
        #���T�C�Y�f�f(�b�J�b�v�)
        case $data_SDB[target.class_id].bust_size
        when 1,2 #�`,�a
          action.gsub!("���݂�������","����ł���") 
        end
  #------------------------------------------------------------------------#
      when 334   #��U�߃A�\�R��
        if target.nude?
          action = premess + " gently rubs #{targetname}'s crotch!"
        else
          action = premess + " gently rubs #{targetname}'s crotch\\n through her #{pantsu}!"
        end
      when 335   #��U�߃A�\�R
        if target.nude?
          action = premess + " strokes #{targetname}'s crotch!"
          action = premess + "�w��ŁA\n\#{targetname}�̃A�\�R�̓������#{brk4}�������Ă����I" if $game_variables[17] > 50
        else
          action = premess + " #{pantsu}�̏ォ��A\n\#{targetname}�̃A�\�R�𕏂łĂ����I"
        end
      when 336   #��U�߃A�\�R��
        if target.nude?
          action = premess + "�w���A\n\#{targetname}�̃A�\�R�̉��܂œ���Ă����I"
        else
          action = premess + " #{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̃A�\�R���w�ň������Ă����I"
        end
      when 337   #��U�߃A�\�R�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃A�\�R���v���܂ܘM�ԁI"
          action.gsub!("�l�q��","�����") if $game_variables[17] > 50 #��x�ύX����ƕύX�Ώە������Ȃ��Ȃ�̂ŏ����͐��
          action.gsub!("�l�q��","�w�g����") 
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̃A�\�R���v���܂ܘM�ԁI"
        end
      when 338   #��U�߉A�j��
        if target.nude?
          action = premess + "�w��ŁA\n\#{targetname}�̉A�j��D�������łĂ����I"
        else
          action = premess + " #{pantsu}�̏ォ��A\n\#{targetname}�̉A�j��D�������łĂ����I"
        end
      when 339   #��U�߉A�j
        if target.nude?
          action = premess + "�w��ŁA\n\#{targetname}�̉A�j���������h�����Ă����I"
        else
          action = premess + " #{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̉A�j���h�����Ă����I"
        end
      when 340   #��U�߉A�j�K�E
        if target.nude?
          action = premess + " #{tec}�A\n\#{targetname}�̉A�j���w�Ŏv���܂ܘM�ԁI"
        else
          action = premess + " #{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̉A�j���w��ł܂݂������I"
        end
      when 341   #��U�߃A�\�R�ǌ�
        if target.nude?
          action = premess + " #{tec}�A\n\#{targetname}�̃A�\�R���X�ɍU�ߗ��Ă�I"
        else
          action = premess + " #{pantsu}�Ɋ��荞�܂�����ŁA\n\#{targetname}�̃A�\�R���X�ɘM�ԁI"
        end
      when 342   #��U�߉A�j�ǌ�
        if target.nude?
          action = premess + " #{tec}�A\n\#{targetname}�̉A�j���w��ŘM�ԁI"
        else
          action = premess + " #{pantsu}�Ɋ��荞�܂����w��ŁA\n\#{targetname}�̉A�j���X�ɘM�ԁI"
        end
  #------------------------------------------------------------------------#
      when 344   #��U�ߐK��
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}�̂��K�������ƕ��łĂ����I"
        else
          action = premess + " #{pantsu}�z���ɁA\n\#{targetname}�̂��K�������ƕ��łĂ����I"
        end
      when 345   #��U�ߐK
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}�̂��K�𝆂݂������Ă����I"
        else
          action = premess + " #{pantsu}�z���ɁA\n\#{targetname}�̂��K�𝆂݂������Ă����I"
        end
      when 346   #��U�ߐK��
        if target.nude?
          action = premess + "����ŁA\n\#{targetname}�̂��K���������݂������Ă����I"
        else
          action = premess + " #{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̂��K�𝆂݂������Ă����I"
        end
      when 347   #��U�ߐK�K�E
        if target.nude?
          action = premess + " #{tec}�A\n\#{targetname}�̂��K���v���܂ܘM�ԁI"
          action.gsub!("�l�q��","�����") #�\���̕ύX
        else
          action = premess + " #{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̂��K���v���܂ܘM�ԁI"
        end
      when 348   #��U�ߑO���B��
        if target.nude?
          action = premess + " �w��ŁA\n\#{targetname}�̋e�����h�����Ă����I"
        else
          action = premess + " #{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̋e�����h�����Ă����I"
        end
      when 349   #��U�ߑO���B
        if target.nude?
          action = premess + "�w��ŁA\n\#{targetname}�̋e����h�����Ă����I"
        else
          action = premess + " #{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̋e����w�Ŏh�����Ă����I"
        end
      when 350   #��U�ߑO���B�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̋e����w�ň������Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\�w��#{targetname}�̋e����������Ă����I"
        end
      when 351   #��U�߃A�i����
        if target.nude?
          action = premess + "�w��ŁA\n\#{targetname}�̋e�����h�����Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̋e�����h�����Ă����I"
        end
      when 352   #��U�߃A�i��
        if target.nude?
          action = premess + "�w��ŁA\n\#{targetname}�̋e����h�����Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̋e����w�Ŏh�����Ă����I"
        end
      when 353   #��U�߃A�i���K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̋e����w�ň������Ă����I�I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\�w��#{targetname}�̋e����������Ă����I"
        end
      when 354   #��U�ߐK�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\�����#{targetname}�̂��K��M�ԁI"
        else
          action = premess + "#{pantsu}�Ɋ��荞�܂�����ŁA\n\#{targetname}�̂��K���X�ɘM�ԁI"
        end
      when 355   #��U�ߑO���B�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\�w��#{targetname}�̋e����X�Ɉ������Ă����I"
        else
          action = premess + "#{pantsu}�Ɋ��荞�܂����w�ŁA\n\#{targetname}�̋e����X�Ɉ������Ă����I"
        end
      when 356   #��U�߃A�i���ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\�w��#{targetname}�̋e����X�Ɉ������Ă����I"
        else
          action = premess + "#{pantsu}�Ɋ��荞�܂����w�ŁA\n\#{targetname}�̋e����X�Ɉ������Ă����I"
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
        action = premess + "�Ђ��肵����ŁA\n\#{targetname}��#{points}�����������I"
        action = premess + "�Ђ��肵���w��ŁA\n\#{targetname}��#{points}�����������I"
        avoid = ""
     #------------------------------------------------------------------------#
      when 361   #�T�f�B�X�g�J���X
        action = premess + "�Ӓn���Ȏ���ŁA\n\#{targetname}�����������I"
     #------------------------------------------------------------------------#
      when 362   #�v���C�X�I�u�n����
        action = premess + "�A\n\#{targetname + rangetext}�����܂˂����������I"
     #------------------------------------------------------------------------#
      when 363   #�v���C�X�I�u�V�i�[
        action = premess + "�A\n\#{targetname + rangetext}�����܂˂����������I"
     #------------------------------------------------------------------------#
      when 364   #�y���\�i�u���C�N
        action = premess + "#{targetname}�̊�O�ŁA\n\��������ׂ����I"
     #------------------------------------------------------------------------#
      when 365   #�L���X�g�R�[��
        action = "�����E��#{$game_actors[101].name}�̋L������\n�ߋ��̖ώ��𐶂ݏo�����I"
  #------------------------------------------------------------------------#
  # �����Z�n
  #------------------------------------------------------------------------#
      when 375   #���U�߃y�j�X��
        if target.nude?
          action = "#{myname} gently kisses up and do��n #{targetname}'s penis!"
          action = "#{myname} quietly licks #{targetname}'s penis ��ith\n\ the tip of her tongue!" if $game_variables[17] > 50
          action += "\n\ A pleasant, sli��y sensation runs do��n his penis!" if target.lub_male >= 60
        else
          action = "Through the #{pantsu}, #{myname}\n\ tenderly kisses bet��een #{targetname}'s crotch!"
        end
      when 376   #���U�߃y�j�X
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}�̃y�j�X���r�߂Ă����I"
          action = "#{myname} licks #{targetname}'s penis ��ith the tip of her tongue!" if $game_variables[17] > 50
          action += "\n\ A pleasant, sli��y sensation runs do��n his penis!" if target.lub_male >= 60
        else
          action = "Through the #{pantsu},\n\ #{myname} kisses bet��een #{targetname}'s crotch!"
        end
      when 377   #���U�߃y�j�X��
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃y�j�X�̐�[��#{brk4}�r�߉񂵂Ă����I"
          action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}�z���ɁA\n\#{targetname}�̃y�j�X���r�ߏグ�Ă����I"
        end
      when 378   #���U�߃y�j�X�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃y�j�X��#{brk4}���������r�ߏグ�Ă����I"
          action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}�z���ɁA\n\#{targetname}�̃y�j�X���r�߉񂵂Ă����I"
        end
      when 379   #���U���Ίۏ�
        if target.nude?
          action = premess + "�O�ŁA\n\#{targetname}�̑܂�D�����z���グ�Ă����I"
        else
          action = premess + "#{pantsu}�z���ɁA\n\#{targetname}�̑܂ɃL�X���Ă����I"
        end
      when 380   #���U���ΊەK�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̑܂��r�߉񂵂Ă����I"
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}�z���ɁA\n\#{targetname}�̑܂��r�߉񂵂Ă����I"
        end
      when 381   #���U�߃y�j�X�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃y�j�X���X���r�ߏグ�Ă����I"
          action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
        else
          action = premess + "�Ȃ���#{pantsu}�z���ɁA\n\#{targetname}�̃y�j�X���r�߉񂵂Ă����I"
        end
      when 382   #���U���Ίےǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̑܂��X���r�ߏグ�Ă����I"
        else
          action = premess + "�Ȃ���#{pantsu}�z���ɁA\n\#{targetname}�̑܂��r�߉񂵂Ă����I"
        end
  #------------------------------------------------------------------------#
      when 384   #���U�ߋ���
        if target.nude?
          action = premess + "�O�ŁA\n\#{targetname}��#{target.bustsize}��#{brk3}�����ƃL�X���Ă����I"
        else
          action = premess + "���̏ォ��A\n\#{targetname}��#{target.bustsize}��#{brk3}�����ƃL�X���Ă����I"
        end
      when 385   #���U�ߋ�
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}��#{target.bustsize}��#{brk3}�Ȃ����Ă����I"
          action = premess + "���ŁA\n\#{targetname}��#{target.bustsize}��#{brk3}�r�߂Ă����I" if $game_variables[17] > 50
        else
          action = premess + "���̏ォ��A\n\#{targetname}��#{target.bustsize}�ɃL�X���Ă����I"
        end
      when 386   #���U�ߋ���
        if target.nude?
          action = premess + "���ŁA\n\#{targetname}��#{target.bustsize}��#{brk3}�r�߉񂵂Ă����I"
          action = premess + "#{tec}�A\n\#{targetname}�̓�����r�߉񂵂Ă����I" if $game_variables[17] > 50
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "���̌��Ԃ���A\n\#{targetname}��#{target.bustsize}���r�߉񂵂Ă����I"
        end
      when 387   #���U�ߋ��K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}��#{target.bustsize}��#{brk3}�����z���グ�Ă����I"
          action = premess + "#{tec}�A\n\#{targetname}�̓���������z���グ�Ă����I" if $game_variables[17] > 50
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "���̌��Ԃ���A\n\#{targetname}��#{target.bustsize}�������z���Ă����I"
        end
      when 388   #���U�ߋ��ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}��#{target.bustsize}��#{brk3}�X���r�߉񂵂��I"
          action = premess + "#{tec}�A\n\#{targetname}�̓�����X�ɋz���グ���I" if $game_variables[17] > 50
        else
          action = premess + "���̌��Ԃ���A\n\#{targetname}��#{target.bustsize}���X�ɋ����z���Ă����I"
        end
  #------------------------------------------------------------------------#
      when 390   #���U�߃A�\�R��
        if target.nude?
          action = premess + "�O�ŁA\n\#{targetname}�̃A�\�R�ɂ����ƃL�X���Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̃A�\�R�ɂ����ƃL�X���Ă����I"
        end
      when 391   #���U�߃A�\�R
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}�̃A�\�R���r�߂Ă����I"
          action = premess + "�O�ŁA\n\#{targetname}�̃A�\�R�ɃL�X�����Ă����I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̃A�\�R���r�߂Ă����I"
        end
      when 392   #���U�߃A�\�R��
        if target.nude?
          action = premess + "�������ڂ߁A\n\#{targetname}�̃A�\�R�ɑ}��Ă����I"
          action = premess + "#{tec}�A\n\#{targetname}�̃A�\�R�������z���グ���I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�����炵�A\n\#{targetname}�̃A�\�R���r�߉񂵂Ă����I"
        end
      when 393   #���U�߃A�\�R�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃A�\�R���v���܂ܘM�ԁI"
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}���ƁA\n\#{targetname}�̃A�\�R�ɐ��˂�����Ă����I"
        end
      when 394   #���U�߉A�j��
        if target.nude?
          action = premess + "���ŁA\n\#{targetname}�̉A�j��D�����������Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̉A�j����ň������Ă����I"
        end
      when 395   #���U�߉A�j
        if target.nude?
          action = premess + "���ŁA\n\#{targetname}�̉A�j���r�ߏグ�Ă����I"
        else
          action = premess + "#{pantsu}�����炵�A\n\#{targetname}�̉A�j���r�ߏグ�Ă����I"
        end
      when 396   #���U�߉A�j�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̉A�j���v���܂ܘM�ԁI"
        else
          action = premess + "#{pantsu}���ƁA\n\#{targetname}�̉A�j��O�ŋz���グ���I"
        end
      when 397   #���U�߃A�\�R�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃A�\�R�����X���r�ߏグ��I"
        else
          action = premess + "#{tec}�A\n\#{targetname}�̃A�\�R��#{pantsu}�z���ɘM�ԁI"
        end
      when 398   #���U�߉A�j�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\����#{targetname}�̉A�j�����X�ɘM�ԁI"
        else
          action = premess + "#{tec}�A\n\#{pantsu}����#{targetname}�̉A�j��O�ŋz���グ��I"
        end
  #------------------------------------------------------------------------#
      when 400   #���U�ߐK��
        if target.nude?
          action = premess + "�O�ŁA\n\#{targetname}�̂��K�ɂ����ƃL�X�����Ă����I"
        else
          action = premess + "#{pantsu}�z���ɁA\n\#{targetname}�̂��K�ɂ����ƃL�X�����Ă����I"
        end
      when 401   #���U�ߐK
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}�̂��K���r�ߏグ�Ă����I"
        else
          action = premess + "#{pantsu}�z���ɁA\n\#{targetname}�̂��K���r�ߏグ�Ă����I"
        end
      when 402   #���U�ߐK��
        if target.nude?
          action = premess + "�O�ŁA\n\#{targetname}�̂��K�ɊÊ��݂��Ă����I"
        else
          action = premess + "#{pantsu}���ƁA\n\�O��#{targetname}�̂��K�ɊÊ��݂��Ă����I"
        end
      when 403   #���U�ߐK�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̂��K���r�߉񂵂Ă����I"
        else
          action = premess + "#{pantsu}�����ł��炵�A\n\#{targetname}�̂��K���r�߉񂵂Ă����I"
        end
      when 404   #���U�ߑO���B��
        if target.nude?
          action = premess + "���ŁA\n\#{targetname}�̑O���B���h�����Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̋e�����h�����Ă����I"
        end
      when 405   #���U�ߑO���B
        if target.nude?
          action = premess + "���ŁA\n\#{targetname}�̋e�����ӂ��r�߉񂵂Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̋e����Ŏh�����Ă����I"
        end
      when 406   #���U�ߑO���B�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̋e��̉��܂Ő�����Ă����I"
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}���ƁA\n\#{targetname}�̋e��̉��܂Ő�����Ă����I"
        end
      when 407   #���U�߃A�i����
        if target.nude?
          action = premess + "���ŁA\n\#{targetname}�̋e�����h�����Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̋e�����h�����Ă����I"
        end
      when 408   #���U�߃A�i��
        if target.nude?
          action = premess + "���ŁA\n\#{targetname}�̋e����ӂ��r�߉񂵂Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̋e����Ŏh�����Ă����I"
        end
      when 409   #���U�߃A�i���K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̋e��̉��܂Ő�����Ă����I"
          action.gsub!("�l�q��","��g����") #�\���̕ύX
        else
          action = premess + "#{pantsu}���ƁA\n\#{targetname}�̋e��̉��܂Ő�����Ă����I"
        end
      when 410   #���U�ߐK�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\���#{targetname}�̂��K�����X���r�߉񂷁I"
        else
          action = premess + "#{tec}�A\n\#{targetname}�̂��K���X���r�߉񂵂Ă����I"
        end
      when 411   #���U�ߑO���B�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̋e����ň������Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̋e��ɍX�ɐ�����Ă����I"
        end
      when 409   #���U�߃A�i���ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\�X��#{targetname}�̋e����ň������Ă����I"
        else
          action = premess + "#{pantsu}�����炵�A\n\#{targetname}�̋e�������r�ߏグ�Ă����I"
        end
    #------------------------------------------------------------------------#
      when 415   #�n�E�����O
        action = premess + " lets out a loud ho��l!"
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
        action = premess + "�����ʂ������ŁA\n\#{targetname}���ꊅ�����I"
  #------------------------------------------------------------------------#
  # �����Z�n
  #------------------------------------------------------------------------#
      #�p�C�Y���͗��җ����݂̂̂��߁A���߃e�L�X�g�͖���
      when 431   #�p�C�Y����
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\#{targetname}�̃y�j�X������ł����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɉ��������ݏグ��I" if target.lub_male >= 60
      when 432   #�p�C�Y��
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\#{targetname}�̃y�j�X�����݂������Ă����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 433   #�p�C�Y����
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\#{targetname}�̃y�j�X�����ˉ񂵂Ă����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 434   #�p�C�Y���K�E
        action = premess + "#{tec}�A\n\#{myself.bustsize}�̒J�ԂɃy�j�X�����݁A\n\#{targetname}�̔������y���݂Ȃ���M�ԁI"
        action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 435   #�C��t����
        action = premess + "#{myself.bustsize}���A\n\#{targetname}�̃y�j�X�ɎC��t���Ă����I"
        #���T�C�Y�f�f(�J�b�v�w��A�b�ȏ�ɂ͕K�v�Ȃ�)
        case $data_SDB[myself.class_id].bust_size
        when 2 #�a
          action.gsub!("���A","�ŁA") 
          action.gsub!("�ɎC��t���Ă���","���������Ɗ撣���Ă���") 
        end
      when 436   #�p�C�Y���ǌ�
        action = premess + "#{tec}�A\n\#{myself.bustsize}�ɋ��܂ꂽ�y�j�X��M�ԁI"
        action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 437   #�C��t�����ǌ�
        #���T�C�Y�f�f(�J�b�v�w��A�b�ȏ�ɂ͕K�v�Ȃ�)
        case $data_SDB[myself.class_id].bust_size
        when 2 #�a
          action = premess + "#{tec}�A\n\#{myself.bustsize}�ōX�Ƀy�j�X���C��グ�Ă����I"
        else
          action = premess + "#{tec}�A\n\#{myself.bustsize}���X�Ƀy�j�X�ɎC��t���Ă����I"
        end
  #------------------------------------------------------------------------#
      when 439   #�ςӂςӏ�
        #�ł炵�̂ݒ��߂ςӂςӂ����݂���
        if target.nude?
          action = premess + "#{myself.bustsize}�̒J�Ԃ��A\n\#{targetname}�̊�ɉ����t���Ă����I"
        else
          action = premess + "��̖c��݂�\n\#{targetname}�̊�ɉ������ĂĂ����I"
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
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\#{targetname}�̊���ݍ���ł����I"
      when 441   #�ςӂςӋ�
        action = premess + "#{myself.bustsize}�̒J�ԂɁA\n\#{targetname}�̊������ŕ������߂Ă����I"
      when 442   #�ςӂςӕK�E
        action = premess + "#{myself.bustsize}�̒J�ԂɁA\n\#{targetname}�̊�������#{brk4}�����������߂Ă����I"
      when 443   #������
        action = premess + "#{myself.bustsize}�ŁA\n\#{targetname}�̊�ɕ������Ă����I"
      when 444   #�ςӂςӒǌ�
        action = premess + "#{tec}�A\n\#{myself.bustsize}�̒J�Ԃ��X�ɉ����t���Ă����I"
      when 445   #�������ǌ�
        #���T�C�Y�f�f(�J�b�v�w��A�b�ȏ�ɂ͕K�v�Ȃ�)
        case $data_SDB[myself.class_id].bust_size
        when 2 #�a
          action = premess + "#{tec}�A\n\#{myself.bustsize}�ōX�ɕ������߂Ă����I"
        else
          action = premess + "#{tec}�A\n\#{myself.bustsize}���X�ɉ������ĂĂ����I"
        end
  #------------------------------------------------------------------------#
      when 447   #�����킹��
        action = premess + "#{myself.bustsize}���A\n\#{targetname}��#{target.bustsize}��#{brk3}�������ĂĂ����I"
      when 448   #�����킹
        action = premess + "#{myself.bustsize}���A\n\#{targetname}��#{target.bustsize}��#{brk3}�C��t���Ă����I"
      when 449   #�����킹��
        action = premess + "�݂��̋����C�肠�킹�A\n\����̓����#{targetname}�̓����M���Ă����I"
      when 450   #�����킹�K�E
        action = premess + "�������������āA\n\#{targetname}��#{myself.bustsize}���C����Ă����I\n\�݂��̋�������ɘc�ݗx��I"
      when 451   #���C��t����
        action = premess + "#{myself.bustsize}���A\n\#{targetname}��#{target.bustsize}��#{brk3}�������ĂĂ����I"
      when 452   #���C��t���K�E
        action = premess + "#{myself.bustsize}���A\n\#{targetname}��#{target.bustsize}��#{brk3}�C��t���Ă����I"
      when 453   #�����킹�ǌ�
        brk2 = ""
        brk2 = "\n" if myself.bustsize.size + target.bustsize.size > 36 #���҂̋��\���𑫂��ĂP�Q�����z���Ő܂�Ԃ�
        action = premess + "#{tec}�A\n\#{myself.bustsize}��#{target.bustsize}��#{brk2}�݂��ɎC��t�������I"
      when 454   #���C��t���ǌ�
        brk2 = ""
        brk2 = "\n" if myself.bustsize.size + target.bustsize.size > 36 #���҂̋��\���𑫂��ĂP�Q�����z���Ő܂�Ԃ�
        action = premess + "#{tec}�A\n\#{myself.bustsize}��#{target.bustsize}��#{brk2}�݂��ɎC��t�������I"
  #------------------------------------------------------------------------#
  # ���A�\�R�Z�n(�O�񂪗��Ȃ��߁A���������߂̃e�L�X�g�͖���)
  #------------------------------------------------------------------------#
      when 473   #�f�ҏ�
        action = premess + "�A�\�R�������t���A\n\#{targetname}�̃y�j�X���������C���Ă����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɉ��������ݏグ��I" if target.lub_male >= 60
      when 474   #�f��
        action = premess + "�A�\�R�������t���A\n\#{targetname}�̃y�j�X���������Ă����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 475   #�f�ҋ�
        action = premess + "�A�\�R�������t���A\n\#{targetname}�̃y�j�X���������グ�Ă����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 476   #�f�ҕK�E
        action = premess + "#{tec}�A\n\#{targetname}�ɔn���ɂȂ�#{brk4}�y�j�X��M��ł���I"
        action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 477   #�f�Ғǌ�
        action = premess + "#{tec}�A\n\#{targetname}�ɔn���̂܂�#{brk4}�y�j�X��M��ł���I"
        action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
  #------------------------------------------------------------------------#
  # �����Z�n
  #------------------------------------------------------------------------#
      when 486   #���R�L��
        if target.nude?
          action = premess + "���̗��ŁA\n\#{targetname}�̃y�j�X��D�����������Ă����I"
          action += "\n\�ʂ߂��тт��y�j�X�ɉ��������ݏグ��I" if target.lub_male >= 60
        else
          action = premess + "���̏ォ��A\n\#{targetname}�̃y�j�X�𑫂̗���#{brk4}�h�����Ă����I"
        end
      when 487   #���R�L
        if target.nude?
          action = premess + "���̎w�ŁA\n\#{targetname}�̃y�j�X���������Ă����I"
          action += "\n\�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
        else
          action = premess + "���̏ォ��A\n\#{targetname}�̃y�j�X�𑫂̎w��#{brk4}�������Ă����I"
        end
      when 488   #���R�L�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃y�j�X�𑫂Ŏv���܂ܘM�ԁI"
          action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
        else
          action = premess + "���̒��ɑ�����˂�����A\n\#{targetname}�̃y�j�X���X�ɑ��w�ŘM���Ă����I"
        end
      when 489   #���R�L�ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃y�j�X���X�ɑ��ōU�ߗ��Ă�I"
          action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
        else
          action = premess + "���̒��ɑ�����˂����݁A\n\#{targetname}�̃y�j�X�𑫎w�ŘM���Ă����I"
        end
  #------------------------------------------------------------------------#
      when 491   #���U�ߋ���
        if target.nude?
          action = premess + "���̎w�ŁA\n\#{targetname}��#{target.bustsize}��#{brk3}�����݂Ɏh�����Ă����I"
        else
          action = premess + "���̏ォ��A\n\#{targetname}��#{target.bustsize}��#{brk3}�����Ŏh�����Ă����I"
        end
      when 492   #���U�ߋ�
        if target.nude?
          action = premess + "���̎w�ŁA\n\#{targetname}��#{target.bustsize}��#{brk3}���݂������Ă����I"
          action = premess + "���̎w�ŁA\n\#{targetname}�̓���������P��グ�Ă����I" if $game_variables[17] > 50
        else
          action = premess + "���̏ォ��A\n\#{targetname}��#{target.bustsize}��#{brk3}���̎w�Ŏh�����Ă����I"
        end
      when 493   #���U�ߋ��K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}��#{target.bustsize}��#{brk3}���Ŏv���܂ܘM�ԁI"
        else
          action = premess + "���̌��Ԃ��瑫����˂�����A\n\#{targetname}��#{target.bustsize}��#{brk3}�v���܂ܘM�ԁI"
        end
      when 494   #���U�ߋ��ǌ�
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}��#{target.bustsize}��#{brk3}���ōX�ɍU�ߗ��Ă�I"
        else
          action = premess + "���̌��Ԃ��瑫����˂����݁A\n\#{targetname}��#{target.bustsize}��#{brk3}���ōX�Ɏh�����Ă����I"
        end
  #------------------------------------------------------------------------#
      when 496   #���U�߃A�\�R��
        if target.nude?
          action = premess + "�����ŁA\n\#{targetname}�̃A�\�R�������݂Ɏh�����Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̃A�\�R�𑫗��Ŏh�����Ă����I"
        end
      when 497   #���U�߃A�\�R
        if target.nude?
          action = premess + "���̎w�ŁA\n\#{targetname}�̃A�\�R�����肮��h�����Ă����I"
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̃A�\�R�𑫂̎w�Ŏh�����Ă����I"
        end
      when 498   #���U�߃A�\�R�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃A�\�R�𑫎w�Ŏv���܂ܘM�ԁI"
        else
          action = premess + "#{pantsu}�ɑ�����˂�����A\n\#{targetname}�̃A�\�R���v���܂ܘM�ԁI"
        end
      when 499   #���U�߃A�\�R�K�E
        if target.nude?
          action = premess + "#{tec}�A\n\#{targetname}�̃A�\�R��#{brk4}���w�łȂ����U�ߗ��Ă�I"
        else
          action = premess + "#{pantsu}�ɂ˂����񂾑���ŁA\n\#{targetname}�̃A�\�R���X�ɍU�ߗ��Ă�I"
        end
  #------------------------------------------------------------------------#
  # �������Z
  #------------------------------------------------------------------------#
      when 508   #�����E�����
        case $game_variables[17]
        when 0..24
          action = premess + "���ŁA\n\#{targetname}�̎�؂������ƂȂ����Ă����I"
        when 25..50
          action = premess + "�O�ŁA\n\#{targetname}�̎����Ԃ��Ê��݂��Ă����I"
        when 51..75
          action = premess + "�A\n\#{targetname}�̊z�ɂ����ƃL�X�������I"
        else
          action = premess + "�A\n\#{targetname}�̖j�ɂ����ƃL�X�������I"
        end
      when 509   #�����E�㔼�g
        case $game_variables[17]
        when 0..24
          action = premess + "��ŁA\n\#{targetname}�̔w����D�������łĂ����I"
        when 25..50
          action = premess + "���ŁA\n\#{targetname}�̂ւ��̎�����r�߂Ă����I"
        when 51..75
          action = premess + "��ڎg���ŁA\n\#{targetname}�̎w�𒚔J�ɂ���Ԃ��Ă����I"
        else
          action = premess + "���ŁA\n\#{targetname}�̘e�������ƂȂ����Ă����I"
        end
      when 510   #�����E�����g(��ɋr)
        case $game_variables[17]
        when 0..24
          action = premess + "�w��ŁA\n\#{targetname}�̍��������ƂȂ����Ă����I"
        when 25..50
          action = premess + "��ŁA\n\#{targetname}�̑������𕏂łĂ����I"
        when 51..75
          action = premess + "�����̋r���A\n\#{targetname}�̑��ɗ��܂��Ă����I"
        else
          action = premess + "��ŁA\n\#{targetname}�̑��̎w�𒚔J���r�߂Ă����I"
        end
      when 511   #�����E������
        action = premess + "�w��ŁA\n\#{targetname}�̔����ӂ��Ƃ����グ�Ă����I"
        action = premess + "��̂Ђ�ŁA\n\#{targetname}�̔������킳��ƕ��łĂ����I" if $game_variables[17] > 50
      when 512   #�����E��������
        action = premess + "�A\n\#{targetname}��D�����������߂Ă����I"
  #------------------------------------------------------------------------#
      when 515   #�K���U�߁��E��
        action = premess + "#{targetname}��#{pantsu}�̒��ɁA\n\#{tail}����荞�܂��y�j�X���������Ă����I"
        action = premess + "#{targetname}�̃y�j�X�ɁA\n\#{tail}�𗍂߂ĎC��グ�Ă����I" if target.nude?
  #------------------------------------------------------------------------#
      when 523   #�K���U�ߋ��E��
        action = premess + "#{tail}���g���A\n\���̊Ԃ���#{targetname}��#{brk3}#{target.bustsize}�����������I"
        action = premess + "#{tail}���g���A\n\#{targetname}��#{target.bustsize}�����������I" if target.nude?
  #------------------------------------------------------------------------#
      when 528   #�K���U�߁��E��
        action = premess + "#{targetname}��#{pantsu}�̒��ɁA\n\#{tail}����荞�܂��ăA�\�R���������Ă����I"
        action = premess + "#{targetname}�̃A�\�R�ɁA\n\#{tail}���C��t���Ĉ������Ă����I" if target.nude?
  #------------------------------------------------------------------------#
      when 536   #�K���U�ߐK�E��
        action = premess + "#{targetname}��#{pantsu}�̌��Ԃ���A\n\#{tail}�����荞�܂��Ĉ������Ă����I"
        action = premess + "#{targetname}�̂��K�ɁA\n\#{tail}�����点�Ĉ������Ă����I" if target.nude?
  #------------------------------------------------------------------------#
  # ������g�̌n
  #------------------------------------------------------------------------#
      when 586   #���X�g���[�V����
        action = "#{myname}�̐g�̂̔S�t�������Ă����c�c�I\n\#{myname}�̐g�̂��ĂєS�t�ŕ���ꂽ�I"
      when 587   #�X���C�~�[���L�b�h
        action = premess + "�g�̂̔S�t����Ɏ��A\n\#{targetname}�̕��̌��Ԃ��痬������Ă����I"
        action = premess + "�g�̂̔S�t����Ɏ��A\n\#{targetname}�̐g�̂ɓh����Ă����I" if target.nude?
      when 588   #����
        action = premess + "#{targetname}�����サ���I"
      when 589   #�o�b�h�X�|�A
        action = premess + "�A\n\#{targetname}�ɖE�q�𐁂��������I"
      when 590   #�X�|�A�N���E�h
        action = premess + "�ӂ��ʂɖE�q��U��܂����I"
      when 591   #�A�C���B�N���[�Y
        action = premess + "���Ȃ�ӂ��A\n\#{targetname}�̐g�̂Ɋ����t�����I"
      when 592   #�f�����Y�N���[�Y
        action = "#{myname}�̑���G�肪�A\n\忂��悤��#{targetname}�̐g�̂Ɋ����t�����I"
      when 599   #�ő�
        action = premess + "�������}�����Ă��I"
      when 600   #��S
        action = premess + "�ڂ��҂�W�������I"
      when 601   #�{�\�̌Ăъo�܂�
        action = premess + "���ɖ���{�\���Ăъo�܂����I"
      when 602   #���M�ߏ�
        action = premess + "����̔��e�ɐ������ꂽ�I"# + "\n\���̗h�邬�Ȃ����M�͗͂ƂȂ�I"
    #------------------------------------------------------------------------#
      when 611   #�����b�N�X�^�C��
        action = premess + " calls for relaxation!"
      when 612   #�X�C�[�g�A���}
        action = premess + " is releasing a s��eet fragrance!"
      when 613   #�p�b�V�����r�[�g
        action = premess + "�ە����A���C�����߂��I"
      when 614   #�}�C���h�p�t���[��
        action = premess + " lets off a gentle fragrance!"
      when 615   #���b�h�J�[�y�b�g
        action = premess + " used Red Carpet!"
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
        action = premess + "#{tec}�A\n\�X��#{waist}����O�コ���Ă����I"
      when 758   #���߂�ǌ�
        action = "#{myname}�̃A�\�R���ʂ̐������̂悤�ɁA\n#{targetname}�̃y�j�X�����\�I�ɒ��ߕt����I"
  #------------------------------------------------------------------------#
      when 760   #�L���킹��
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\�A�\�R���m���������Ă��I"
      when 761   #�L���킹
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\�A�\�R���m���C�荇�킹���I"
      when 762   #�L���킹��
        waist = ["��_��","����","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\�A�\�R���m��#{waist}�C�荇�킹���I"
      when 763   #�L���킹�K�E
        waist = ["��_��","����","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{brk}#{targetname}�Ƌr�𗍂߂����A\n\�A�\�R���m��#{waist}�C�荇�킹���I"
      when 764   #�L���킹�ǌ�
        waist = ["��_��","����","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("��������") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{brk}#{targetname}�̋r������A\n\�X�ɃA�\�R���m��#{waist}�C�荇�킹���I"
  #------------------------------------------------------------------------#
      when 766   #���C�f�B���O��
        if myself.nude?
          action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\�A�\�R�����ɉ����t���Ă����I"
        else
          case $data_SDB[myself.class_id].name
          when "Caster","Familiar","Little Witch","Witch "
            action = premess + "�X�J�[�g�̒[�������A\n\#{targetname}�̌���#{pantsu}�������t�����I"
          when "Lesser Succubus ","Succubus"
            action = premess + "drops do��n her hips�A\n\#{targetname}�̌���#{pantsu}�������t�����I"
          when "I��p","Devil "
            action = premess + "drops do��n her hips�A\n\#{targetname}�̌���#{pantsu}�������t�����I"
          when "Sli��e"
            action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\�҂̌E�݂������t���Ă����I"
          when "Night��are"
            action = premess + "drops do��n her hips�A\n\#{targetname}�̌���#{pantsu}�z���̃A�\�R�������t�����I"
          else
            action = premess + "drops do��n her hips�A\n\#{targetname}�̌���#{pantsu}�������t�����I"
          end
        end
      when 767   #���C�f�B���O
        if myself.nude?
          action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\�������ƍ���O��ɐU���Ă����I"
        else
          case $data_SDB[myself.class_id].name
          when "Caster","Familiar","Little Witch","Witch "
            action = premess + "�X�J�[�g�̒[�������A\n\#{targetname}�̌���#{pantsu}�������t�����I"
          when "Lesser Succubus ","Succubus"
            action = premess + "���𗎂Ƃ��A\n\#{targetname}�̌���#{pantsu}�������t�����I"
          when "I��p","Devil "
            action = premess + "���𗎂Ƃ��A\n\#{targetname}�̌���#{pantsu}�������t�����I"
          when "Sli��e"
            action = premess + "#{brk}#{targetname}�ɂ܂��������܂܁A\n\�҂̌E�݂����������t���Ă����I"
          when "Night��are"
            action = premess + "���𗎂Ƃ��A\n\#{targetname}�̌���#{pantsu}�z���̃A�\�R�������t�����I"
          else
            action = premess + "���𗎂Ƃ��A\n\#{targetname}�̌���#{pantsu}�������t�����I"
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
        action = premess + "#{brk}#{targetname}�Ɍ����t����悤�ɁA\n\��̏��#{waist}����U���Ă����I"
      when 769   #���C�f�B���O�ǌ�
        waist = ["��_��","������"]
        waist.push("�ɋ}������") if myself.positive?
        waist.push("���˂�悤��") if myself.positive?
        waist.push("�x��悤��") if myself.positive?
        waist.push("�ꏊ������") if myself.negative?
        waist.push("��S�s����") if myself.negative?
        waist = waist[rand(waist.size)]
        action = premess + "#{brk}#{targetname}�ɔn���̂܂܁A\n\�X��#{waist}����O��ɐU���Ă����I"
  #------------------------------------------------------------------------#
      when 772   #�G�i�W�[�h���C��
        action = premess + "�i����悤�ɍ���U���Ă����I"
      when 773   #���x���h���C��
        action = premess + "�i����悤�ɍ���U���Ă����I"
  #------------------------------------------------------------------------#
      when 788   #�t�F���`�I��
        action = premess + "#{targetname}�̃y�j�X���A\n\���ř������܂܂������Ɛ�𔇂킹�Ă����I"
      when 789   #�t�F���`�I
        action = premess + "#{targetname}�̃y�j�X���A\n\���ř������܂܂������Ƃ���Ԃ��Ă����I"
      when 790   #�t�F���`�I��
        action = premess + "#{targetname}�̃y�j�X���A\n\���ř������܂ܐ���r�߉񂵂Ă����I"
      when 791   #�t�F���`�I�K�E
        action = premess + "#{targetname}�̃y�j�X���A\n\���ř������܂܉��������r�߉񂵂Ă����I"
      when 792   #�X���[�g
        action = premess + "#{targetname}�̃y�j�X���A\n\�������Ƌz���グ�Ă����I"
      when 793   #�X���[�g�K�E
        action = premess + "#{targetname}�̃y�j�X���A\n\���ݍ��ނ悤�ɋz���グ�Ă����I"
      when 794   #�t�F���`�I�ǌ�
        action = premess + "#{targetname}�̃y�j�X���A\n\���ə������܂ܐ�ōX���r�߉񂵂Ă����I"
      when 795   #�X���[�g�ǌ�
        action = premess + "#{targetname}�̃y�j�X���A\n\�ɋ}��t���čX�ɋz���グ�Ă����I"
  #------------------------------------------------------------------------#
      when 797   #�N���j��
        action = premess + "#{targetname}�̃A�\�R���A\n\���S�̂ł������Ƌz���グ�Ă����I"
      when 798   #�N���j
        action = premess + "#{targetname}�̃A�\�R�ɁA\n\�������đO��ɔ����������Ă����I"
      when 799   #�N���j��
        action = premess + "#{targetname}�̃A�\�R���A\n\���S�̂ŉA�j���Ƌ����z���グ�Ă����I"
      when 800   #�N���j�K�E
        action = premess + "#{targetname}�̃A�\�R�ɁA\n\�����点���܂Ő����ǂ��˂�����Ă����I"
      when 801   #�N���j�ǌ�
        action = premess + "#{targetname}�̃A�\�R���A\n\���ŋz���t�����܂܍X�ɐ�ň������Ă����I"
  #------------------------------------------------------------------------#
      when 803   #�f�B�[�v�L�b�X��
        action = premess + "#{targetname}�ƁA\n\�������ƌ݂��̐�𗍂߂������I"
      when 804   #�f�B�[�v�L�b�X
        action = premess + "#{targetname}�ƁA\n\�݂��̐�𗍂߂������I"
      when 805   #�f�B�[�v�L�b�X��
        action = premess + "#{targetname}�ƁA\n\�݂��Ɍ������O���Â肠�����I"
      when 806   #�f�B�[�v�L�b�X�K�E
        action = premess + "#{targetname}�̌����ɁA\n\����r�ߓ�����t�𗬂�����ł����I"
      when 807   #�f�B�[�v�L�b�X�ǌ�
        action = premess + "�Ȃ����������A\n\#{targetname}�̌����������W����I"
  #------------------------------------------------------------------------#
      when 828   #�w�ʍS���E�X�^���_��
        action = premess + "#{targetname}�Ɩ������A\n\��؂ɂӂ����Ƒ��𐁂������Ă����I"
        action = premess + "#{targetname}�Ɩ������A\n\�����Ԃ�O�ŊÊ��݂��Ă����I"
      when 829   #�w�ʍS���E�K�E�_��
        if target.boy?
          action = premess + "#{targetname}�Ɩ������A\n\��؂��ł������r�߂����Ă����I"
          action = premess + "#{targetname}�Ɩ������A\n\���L�΂��ăy�j�X���w�ň������Ă����I" unless target.hold.penis.battler != nil
        else
          action = premess + "#{targetname}�Ɩ������A\n\#{target.bustsize}�𝆂݂������Ă����I"
          action = premess + "#{targetname}�Ɩ������A\n\�A�\�R�Ɏ��L�΂��w�ň������Ă����I" unless target.hold.vagina.battler != nil
        end
      when 830   #�w�ʍS���ǌ�
        if target.boy?
          action = premess + "#{tec}�A\n\���������܂�#{targetname}��#{brk4}�L�X�̉J���~�点���I"
          action = premess + "#{tec}�A\n\���������܂�#{targetname}�̃y�j�X��#{brk4}�w�ŘM�ԁI" unless target.hold.penis.battler != nil
        else
          action = premess + "#{tec}�A\n\���������܂�#{targetname}��#{target.bustsize}��#{brk4}���������I"
          action = premess + "#{tec}�A\n\���������܂�#{targetname}�̃A�\�R��#{brk4}�w�ŘM�񂾁I" unless target.hold.vagina.battler != nil
        end
  #------------------------------------------------------------------------#
      #�p�C�Y���n
      when 836   #�X�g���[�N��
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\#{targetname}�̃y�j�X��������ƈ������Ă����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 837   #�X�g���[�N
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\#{targetname}�̃y�j�X������ł������Ă����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 838   #�X�g���[�N��
        action = premess + "#{myself.bustsize}�̒J�ԂɃy�j�X�����݁A\n\#{targetname}����ڌ����Ɍ��Ȃ����𔇂킹�Ă����I"
        target.lub_male += 4
        action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 839   #�X�g���[�N�K�E
        action = premess + "#{myself.bustsize}�̒J�ԂɃy�j�X�����݁A\n\#{targetname}�̔������y���ނ��̂悤�ɘM��ł����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
      when 840   #�X�g���[�N�ǌ�
        action = premess + "�X��#{myself.bustsize}�������t���A\n\#{targetname}�̃y�j�X�ɐ�𔇂킹�Ȃ���C��グ���I"
        target.lub_male += 4
        action += "\n\�ʂ߂��тт��y�j�X�ɋ�������������I" if target.lub_male >= 60
  #------------------------------------------------------------------------#
      #�ςӂςӌn
      when 842   #�v���X��
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\#{targetname}�̊��D������ݍ���ł����I"
      when 843   #�v���X
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\#{targetname}�̊��������߂Ă����I"
      when 844   #�v���X��
        action = premess + "#{myself.bustsize}�̒J�Ԃ��A\n\#{targetname}�̊��������Ɖ����t���Ă����I"
      when 845   #�v���X�K�E
        action = premess + "#{myself.bustsize}�̒J�ԂŁA\n\#{targetname}�̊�����݂��ˉ񂵂Ă����I"
      when 846   #�v���X�ǌ�
        action = premess + "�X��#{myself.bustsize}�ŁA\n\#{targetname}�̊���ݍ��݂��ˉ񂷁I"
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
        action = premess + "#{tec}�A\n\�X��#{waist}����O�コ���Ă����I"
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
        action = premess + "#{tec}�A\n\�X��#{waist}����O�コ���Ă����I"
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
        action = premess + "#{tec}�A\n\�X��#{waist}����O�コ���Ă����I"
  #------------------------------------------------------------------------#
      #�G��n
      when 733   #�G��t�F���`�I�E��
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\�y�j�X��������܂܂���������忂����������I"
      when 734   #�G��t�F���`�I
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\�y�j�X��������܂܂������Ƃ���Ԃ��Ă����I"
      when 735   #�G��t�F���`�I�E�K�E
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\�y�j�X��������܂܌���������Ԃ��Ă����I"
      when 736   #�G��t�F���`�I�E�ǌ�
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\�y�j�X��������܂܍X�ɂ���Ԃ��Ă����I"
  #------------------------------------------------------------------------#
      when 738   #�G��N���j�E��
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\�A�\�R�ɒ���t�����܂܂���������忂����������I"
      when 739   #�G��N���j
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\�A�\�R�ɒ���t�����܂܂������Ƌz���グ�Ă����I"
      when 740   #�G��N���j�E�K�E
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\�A�\�R�ɒ���t�����܂܉A�j���Ƌ����z���グ�Ă����I"
      when 741   #�G��N���j�E�ǌ�
        action = "#{myname}�̑���G�肪�A#{targetname}��\n\�A�\�R�ɒ���t�����܂܍X�ɋz���グ�Ă����I"
  #------------------------------------------------------------------------#
      when 942   #��˂��グ��
        action = premess + "���ŁA\n\#{targetname}�̃A�\�R��������˂��グ���I"
        action = premess + "��ŁA\n\#{targetname}�̃A�\�R���r�߉񂵂��I" if $game_variables[17] > 50
      when 943   #��˂��グ�K
        action = premess + "���ŁA\n\#{targetname}�̋e���������˂��グ���I"
        action = premess + "��ŁA\n\#{targetname}�̋e�����r�߉񂵂��I" if $game_variables[17] > 50
      when 944   #������
        action = premess + "���R�ɓ��������ŁA\n\#{targetname}��#{target.bustsize}��h�݂͂ɂ����I"
        action = premess + "���R�ɓ��������ŁA\n\#{targetname}��#{target.bustsize}��������h�݂͂ɂ����I" if myself.mouth_riding?
        action = premess + "���R�ɓ�������w�ŁA\n\#{targetname}�̓����E�ݏグ���I" if $game_variables[17] > 50
      when 945   #�K����
        action = premess + "���R�ɓ��������ŁA\n\#{targetname}�̂��K��h�݂͂ɂ����I"
        action = premess + "���R�ɓ�������w�ŁA\n\#{targetname}�̋e����h�������I" if $game_variables[17] > 80
      when 946   #�w�ʈ���
        action = premess + "\n\#{targetname}�̑������𕏂ŉ񂵂��I"
        action = premess + "\n\#{targetname}�̃A�\�R���w�ň��������I" if $game_variables[17] > 50
      when 947   #�L�X����
        action = premess + "����߂Â��A\n\#{targetname}�ɃL�X�������I"
        action = premess + "����߂Â��A\n\#{targetname}�Ɖ��߂�������𗍂܂����I" if $game_variables[17] > 50
      when 948   #�������t��
        action = premess + "���𓮂����A\n\#{targetname}�̊�ɃA�\�R���C������I"
        action = premess + "���𓮂����A\n\#{targetname}�̊�ɃA�\�R�������t�����I" if $game_variables[17] > 50
      when 949   #�A�\�R�U�ߔ���
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}�̃A�\�R�𕏂łĂ����I"
          action = premess + "�w��ŁA\n\#{targetname}�̃A�\�R�̓������#{brk4}�������Ă����I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̃A�\�R�𕏂łĂ����I"
        end
      when 950   #�A�j�U�ߔ���
        if target.nude?
          action = premess + "�w��ŁA\n\#{targetname}�̉A�j���������h�����Ă����I"
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̉A�j���h�����Ă����I"
        end
      when 951   #�y�j�X�U�ߔ���
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}�̃y�j�X�𕏂łĂ����I"
          action = premess + "�w��ŁA\n\#{targetname}�̃y�j�X�𕏂łĂ����I" if $game_variables[17] > 50
          action += "\n\�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
        else
          action = premess + "#{pantsu}�̏ォ��A\n\#{targetname}�̃y�j�X�𕏂łĂ����I"
        end
      when 952   #�ΊۍU�ߔ���
        if target.nude?
          action = premess + "��ŁA\n\#{targetname}�̑܂�D�����������Ă����I"
          action = premess + "�w��ŁA\n\#{targetname}�̑܂�D�������łĂ����I" if $game_variables[17] > 50
        else
          action = premess + "#{pantsu}�Ɏ�����荞�܂��A\n\#{targetname}�̑܂���ł������Ă����I"
        end
      when 953   #�������C��t������
        action = premess + "�A�\�R�������t���A\n\#{targetname}�̃y�j�X�ɎC����Ă����I"
        action += "\n\�ʂ߂��тт��y�j�X�ɉ���������I" if target.lub_male >= 60
      when 954   #�������C��t������
        action = premess + "�A�\�R�������t���A\n\#{targetname}�ƃA�\�R�ɎC����Ă����I"
=begin
      when 947   #�K���Ŋ�P
        action = premess + "�K�����g���A\n\���p����#{targetname}�̃A�\�R���h�����Ă����I"
        action = premess + "�K�����g���A\n\���p����#{targetname}�̋����������Ă����I" if $game_variables[17] > 50
      when 948   #�G��Ŋ�P
        action = premess + "�G����g���A\n\���p����#{targetname}�̃A�\�R���h�����Ă����I"
        action = premess + "�G����g���A\n\���p����#{targetname}�̋����������Ă����I" if $game_variables[17] > 50
=end  
  #------------------------------------------------------------------------#
      when 956   #�L�b�X�ŉ���
        action = premess + "#{emotion}\n\#{targetname}�̐O���ǂ��A#{brk4}��𗍂߂Ă����I"
      when 957   #���U�߂ŉ���
        action = premess + "#{emotion}\n\#{targetname}��#{target.bustsize}��#{brk4}���݂��������I"
      when 958   #�K�U�߂ŉ���
        action = premess + "#{emotion}\n\#{targetname}�̂��K��#{brk4}���݂��������I"
      when 959   #�A�i���U�߂ŉ���
        action = premess + "#{emotion}\n\#{targetname}�̋e������œ˂��Ă����I"
      when 960   #�A�\�R�U�߂ŉ���
        action = premess + "#{emotion}\n\#{targetname}�̃A�\�R���ň������Ă����I"
      when 961   #�A�j�U�߂ŉ���
        action = premess + "#{emotion}\n\#{targetname}�̉A�j�����r�ߏグ�Ă����I"
      when 962   #�y�j�X�U�߂ŉ���
        #�t�A�i���ŔƂ�����
        if target.anal_analsex?
          action = premess + "#{emotion}\n\����Ƃ����#{targetname}�̃y�j�X��\n�����r�ߏグ�Ă����I"
          action = premess + "#{emotion}\n\����Ƃ����#{targetname}�̃y�j�X��\n��ł������Ă����I" if $game_variables[17] > 50
        #�R����
        else
          action = premess + "#{emotion}\n\�g�������Ȃ�#{targetname}�̃y�j�X��\n�����r�ߏグ�Ă����I"
          action = premess + "#{emotion}\n\�g�������Ȃ�#{targetname}�̃y�j�X��\n��ł������Ă����I"if $game_variables[17] > 50
        end
      when 963   #�ΊۍU�߂ŉ���
        #�t�A�i���ŔƂ�����
        if target.anal_analsex?
          action = premess + "#{emotion}\n\����Ƃ����#{targetname}���Ίۂ�\n�����r�ߏグ�Ă����I"
          action = premess + "#{emotion}\n\����Ƃ����#{targetname}���Ίۂ�\n�w�ň������Ă����I" if $game_variables[17] > 50
        #�R����
        else
          action = premess + "#{emotion}\n\�g�������Ȃ�#{targetname}���Ίۂ�\n�����r�ߏグ�Ă����I"
          action = premess + "#{emotion}\n\�g�������Ȃ�#{targetname}���Ίۂ�\n�w�ň������Ă����I"if $game_variables[17] > 50
        end
      when 964   #����U���ǌ�
        action = premess + "#{tec}�A\n\�X��#{targetname}���������Ă����I"
  #------------------------------------------------------------------------#
      when 967   #�������U�߂�
        action = premess + "#{emotion}\n\#{targetname}��D�������������I"
      when 968   #�����E���w����
        action = premess + "�A\n\#{targetname}�̗l�q�������ÁX�ȗl�q�Ō��߂Ă���c�c"
        #�z�[���h���삻�̑��p�E���i�ʌ`�e�\��
        case myself.personality
        when "�Ӓn��","����","����","�����C" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\#{targetname}�̗l�q���ɂ�ɂ�ƒ��߂Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\��������悤�ȕs�G�ȏ΂݂𕂂��ׂ��c�c�I"
          end
        when "�D�F","�|��" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\#{targetname}�̗l�q���ɂ�ɂ�ƒ��߂Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\�����ȏ΂݂𕂂��ׂĎ菵�����Ă����c�c�I"
          end
        when "�z�C","�Â���","�_�a","��i" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\#{targetname}�̗l�q�������ÁX�ȗl�q�Ō��߂Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\���������҂��邩�̂悤�ȏ΂݂𕂂��ׂ��c�c"
          end
        when "���C" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\#{targetname}�̗l�q��M���ۂ����Ō��߂Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\�p������悤�Ɋ����炵�Ă��܂����c�c"
          end
        when "�]��","�W��" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\#{targetname}�̗l�q��M�S�Ɋώ@���Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\���������҂��邩�̂悤�Ȋ፷���������Ă����c�c"
          end
        when "�s�v�c","�V�R" #
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\#{targetname}������Ƃ�Ƃ����\��Ō��Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\�ɂ�����Ɣ��΂񂾁c�c"
          end
        when "�ƑP" #�t���r���A��p
          #���Ă���Ώۂ��z�[���h��Ԃ̏ꍇ
          if target.holding?
            action = premess + "�A\n\#{targetname}�̗l�q��ʔ������Ɋώ@���Ă���c�c"
          #���Ă���Ώۂ������Ɠ��l�O��̏ꍇ
          else
            action = premess + "#{targetname}�Ǝ����������ƁA\n\�����ȏ΂݂𕂂��ׂĎ菵�����Ă����c�c�I"
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
              action = premess + "#{targetname}�ƌq����A\n\�����#{myself.bustsize}���w�ňԂ߂Ă���c�c�I"
            elsif myself.mouth_oralsex?
              action = premess + "#{targetname}�̃y�j�X��j����A\n\����̃A�\�R�Ɏw�𔇂킹�ĈԂ߂Ă���c�c�I"
            elsif myself.vagina_riding?
              action = premess + "#{targetname}�̊�Ɍׂ�A\n\�����#{myself.bustsize}���w�ňԂ߂Ă���c�c�I"
            elsif myself.shellmatch?
              action = premess + "#{targetname}�Ɖ����g�𗍂߂����A\n\�����#{myself.bustsize}���w�ňԂ߂Ă���c�c�I"
            else
              action = premess + "#{targetname}�̒s�Ԃ𒭂߂A\n\����̐g�̂��Ԃ߂Ă���c�c�I"
            end
          elsif myself.tops_binding? or myself.tentacle_binding?
            action = premess + "#{targetname}�̒s�Ԃ𒭂߂A\n\�S�����ꂽ����̏�Ԃɐg�ウ���Ă���c�c�I"
          else
            action = premess + "#{targetname}�̒s�Ԃ𒭂߂A\n\����̐g�̂��Ԃ߂Ă���c�c�I"
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
          action = premess + "#{hold_action}�A\n\���Ƃ��ċz�𗎂������悤�Ƃ��Ă���c�c�I"
        else
          action = premess + "#{hold_action}�A\n\�ċz�𗎂������悤�Ƃ��Ă���c�c�I"
        end
        myself.sp += sp_plus
      when 971   #������
        action = premess + " t��ists about, \n\ trying to change posture!"
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
        action = premess + "#{targetname}�̓���͂݁A\n���x���A�̉��܂Œ��^���˂����ꂽ�I" if myself.dildo_oralsex?
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
        action = premess + "#{targetname}�����������I\n�������A�����̂��܂�茳����܂�Ȃ��I\\n#{targetname}�͉������󂯂Ă��Ȃ��I"
        action = premess + "#{targetname}�����������I\n�������A�����̂��܂�g�̂����܂������Ȃ��I\\n#{targetname}�͉������󂯂Ă��Ȃ��I" if myself.hold.tops.battler != nil
  #------------------------------------------------------------------------#
      end
      #������̔G��x�ŕ␳�e�L�X�g�C��(�X�L���З͂�������̌���)
      if skill.element_set.include?(97) and skill.power != 0 and target.girl?
        case target.lub_female
        when 81..255
          action += "\n\�h�����󂯂邽�тɁA�A�\�R���爤���̐��򖗂��オ��c�I" if target.nude?
          action += "\n\#{targetname}��#{pantsu}���爤�����H�藎����c�I" unless target.nude?
        when 61..80
          action += "\n\�A�\�R�̈���Ȑ��������傫���Ȃ��Ă����c�I" if target.nude?
          action += "\n\#{targetname}��#{pantsu}�͈����ŔG��Ă���c�I" unless target.nude?
        when 41..60
          action += "\n\#{targetname}�̓��҂������������Ɨ����c�I" if target.nude?
          action += "\n\#{targetname}��#{pantsu}�̐��݂��Z���Ȃ��Ă����c�I" unless target.nude?
        when 25..40
          action += "\n\�A�\�R�������Ȑ������R�ꕷ�����Ă���c�I" if target.nude?
          action += "\n\#{targetname}��#{pantsu}�ɐ��݂������o�Ă����c�I" unless target.nude?
        end
      end
      # ���b�Z�[�W�o��
      case type
      when "action"
        #�X���C���n�͕����S�t�ɒu��������(�b��)
        if $data_SDB[target.class_id].name == "Sli��e"
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

