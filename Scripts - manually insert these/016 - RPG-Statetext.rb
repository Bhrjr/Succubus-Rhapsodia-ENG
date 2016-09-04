#==============================================================================
# �� RPG::Sprite
#------------------------------------------------------------------------------
# �@�X�e�[�g�ʃ��b�Z�[�W�i�[
#==============================================================================
module RPG
  class State
    def name
      return @name.split(/\//)[0]
    end
    def message(state, type, myself, user)
      
      myname = myself.name if myself != nil
      username = user.name if user != nil
      master = $game_actors[101].name
      state_name = state.name.split(/\//)[0]
      effect = recover = report =  ""
      
      case state.id
      when 1 # �퓬�s�\
        effect = recover = report =  ""
      when 2 # ����
        effect = "" #{myname}�͐Ⓒ�ɒB�����I"
        recover = "#{myname}�͋C�͂�U��i�藧���オ�����I"
        report = "#{myname}�͎ː��̗]�C�ŗ͂�����Ȃ��I"
      when 3 # �Ⓒ
        effect = "" #{myname}�͐Ⓒ�ɒB�����I"
        recover = "#{myname}�̐g�̂̋��������܂����I"
        report = "#{myname}�͐Ⓒ�̗]�C�ŗ͂�����Ȃ��I"
      when 6 # �N���C�V�X
        effect = "#{myname}�͂��������ɂȂ��Ă����c�I"
        recover = "#{myname}�͗������������߂����I"
        report = "#{myname}�͂��������ɂȂ��Ă���I"
      when 5 # ��
        if user.is_a?(Game_Actor)
          if myself.is_a?(Game_Actor)
            effect = "#{myname}�͗��ɂȂ����I"
            effect = "#{myname}�𗇂ɂ����I" if $msg.tag == "���ԒE��"
          else
            effect = "#{myname}�𗇂ɂ����I"
            effect = "#{myname}�͗��ɂȂ����I" if $msg.tag == "�����E��"
          end
        elsif user.is_a?(Game_Enemy)
          if myself.is_a?(Game_Actor)
            effect = "#{myname}�͗��ɂ��ꂽ�I"
            effect = "#{myname}�͌�����܂܂ɗ��ɂȂ����I" if $game_switches[89] == true
          else
            effect = "#{myname}�͗��ɂȂ����I"
          end
        end
      when 8 # �}��
        if user.is_a?(Game_Actor)
          effect = "#{username}��#{myname}�ɑ}�������I"
        elsif user.is_a?(Game_Enemy)
          effect = "#{myname}��#{username}�ɔƂ��ꂽ�I"
        end
      when 13 # �f�B���C
        effect = "#{myname}�͋����ē������݂����I"
        recover = ""
      when 17 # ��ɃX�^��
        if $game_temp.used_skill != nil
          if user.is_a?(Game_Actor)
            if $game_temp.used_skill.element_set.include?(10) #�����n
              effect = "#{myname}�͌������U�߂���g�ɂȂ��Ă���I"
            elsif $game_temp.used_skill.element_set.include?(11) #�芭�n
              effect = "#{myname}�͋e�����U�߂���g�ɂȂ��Ă���I"
            else #��Ɍn
              effect = "#{myname}�͒ɂ݂Ŏ�g�ɂȂ��Ă���I"
            end
          else
            if $game_temp.used_skill.element_set.include?(10) #�����n
              effect = "#{myname}�͌������U�߂��C���U�炳�ꂽ�I"
            elsif $game_temp.used_skill.element_set.include?(11) #�芭�n
              effect = "#{myname}�͋e�����U�߂��͂������Ă��܂����I"
            else #��Ɍn
              effect = "#{myname}�͒ɂ݂ŋC���U�炳�ꂽ�I"
            end
          end
        else
          if user.is_a?(Game_Actor)
            effect = "#{myname}�͒ɂ݂Ŏ�g�ɂȂ��Ă���I"
          else
            effect = "#{myname}�͒ɂ݂ŋC���U�炳�ꂽ�I"
          end
        end
        recover = ""
      when 14 # �鏊�����x��
        #������Game_Battler3�̃X�L���G�t�F�N�g�Őݒ�
        effect = recover = report =  ""
      when 19 # ������L��
        effect = "#{myname}�̉A�j����剻���n�߂�c�c�I\n\m#{myname}�̌ҊԂɃy�j�X���o�������I"
        recover = "#{myname}�̃y�j�X�͏����������I"
      when 20 # ������(��)
        effect = "#{myname}�̃y�j�X�������ттĂ����I"
        recover = ""
      when 21 # ������(��)
        effect = "#{myname}�̃y�j�X�͏\�񕪂Ɋ����тт��I"
        recover = ""
      when 22 # ������(��)
        effect = "#{myname}�̃A�\�R���G��Ă����I"
        effect = "#{myname}�̃A�\�R�͔S�t�łʂ߂��Ă���I" if myself.states.include?(27) or myself.states.include?(28)
#        effect = "#{myname}�̃A�\�R����A\n\m���X�ɖ������ݏo�Ă����c�I"
#        effect = "#{myname}�̃A�\�R���A\n\m�t�������S�t�̂����łʂ�ʂ邵�Ă����c�I" if myself.states.include?(27) or myself.states.include?(28)
        recover = ""
      when 23 # ������(��)
        effect = "#{myname}�̃A�\�R���\���ɔG��Ă����I"
        effect = "#{myname}�̃A�\�R�͔S�t�ŏ\���ɂʂ߂��Ă���I" if myself.states.include?(27) or myself.states.include?(28)
#        effect = "#{myname}�̃A�\�R����A\n\m�Ƃ��Ɩ����H�藎���ė����c�I"
#        effect = "#{myname}�̃A�\�R�́A\n\m�S�t�Ɩ{�l�̖��Ƃŏ\�񕪂ɔG��Ă����c�I" if myself.states.include?(27) or myself.states.include?(28)
        recover = ""
      when 24 # ������(��)
        effect = "#{myname}�̃A�\�R���爤�t�����o�Ă���I"
        effect = "#{myname}�̃A�\�R�͔S�t�ŏ\���ɂʂ߂��Ă���I" if myself.states.include?(27) or myself.states.include?(28)
#        effect = "#{myname}�̃A�\�R����A\n\m�����~�߂ǂȂ����o���ė���c�I"
#        effect = "#{myname}�̃A�\�R�́A\n\m�S�t�Ɩ{�l�̖��ƂŊ��ɂ����傮���傾�c�I" if myself.states.include?(27) or myself.states.include?(28)
        recover = ""
      #�A�i���n�X�e�[�g�͑̌��łł͖����ڂȂ̂ŁA��쓮�h�~�̂��߃e�L�X�g����
      when 25 # �����`(��)
        effect = "" #"#{myname}�̋e�傪�����ттĂ����c�I"
        recover = ""
      when 26 # �����`(��)
        effect = "" #"#{myname}�̋e��͏\�񕪂Ɋ����тт��I"
        recover = ""
      when 27 # �S�t����(��)
        effect = recover = ""
      when 28 # �S�t����(��)
        effect = recover = ""
      when 29 # �X���C��
        effect = recover = ""
      when 30 # ����
        effect = "#{myname}�͈��łɖ`����Ă��܂����I"
        report = "#{myname}�͈��łɖ`����Ă���I"
        recover = "#{myname}��I�ވ��ł������Ă����c�c\w\n" +
                  "����A#{myname}�̐g�̂��ٗl�ɉΏƂ�n�߂��I"
        if type == "recover"
          myself.add_state(35)
          myself.add_states_log.clear
        end
      when 32 # �X�^���F�h�L�h�L
        effect = "#{myname}�͎v�킸�h�L���Ƃ����I"
        effect = "#{myname}�̓h�L�h�L���Ă����c�c�I" if $msg.tag == "��d" or $msg.tag == "����"
        recover = ""
      when 33 # �X�^���F�т�����
        effect = "#{myname}�͋����ċC���U���Ă��܂����I"
        recover = ""
      when 34 # ����
        effect = "#{myname}�͐S��D��ꂽ�I"
        recover = "#{myname}�͐��C�����߂����I"
        report = "#{myname}�͎����̕\��𕂂��ׂĂ���c�I"
        # ���o�ɓ���������X�L���̏ꍇ�A���b�Z�[�W��ω�
#        if skill != nil and skill != ""
#          if skill.element_set.include?(21)
#            effect = "#{myname}�̎�����#{username}�ɓB�t���ɂȂ����I\w\n" + 
#                     "#{myname}�͐S��D��ꂽ�I"
#          end
#        end
      when 35 # �~��
        if user.is_a?(Game_Actor)
          effect = "#{myname}��~������I"
          effect = "#{myname}�͗~��Ă��܂����I" if $msg.tag == "��d"
        elsif user.is_a?(Game_Enemy)
          effect = "#{myname}�͗~��Ă��܂����I"
        end
        recover = "#{myname}�͉�����߂����I"
        report = "#{myname}�͗~��Ă���I"
      when 36 # �\��
        if user.is_a?(Game_Actor)
          effect = "#{myname}�̉��Y�ꂳ�����I"
          effect = "#{myname}�͉��Y��Ă��܂����I" if $msg.tag == "��d"
        elsif user.is_a?(Game_Enemy)
          effect = "#{myname}�͉��Y��Ă��܂����I"
        end
        recover = "#{myname}�͉�ɕԂ����I"
        report = "#{myname}�͐��~������������Ȃ��I"
      when 37 # ���E
        if user.is_a?(Game_Actor)
          effect = "#{myname}�̐g�̗̂͂����킹���I"
          effect = "#{myname}�̐g�̂���͂������Ă����c�c�I" if $msg.tag == "��d"
          effect = "#{myname}�̐g�̂���͂������Ă����c�c�I" if myself.is_a?(Game_Actor)
          effect = "#{myname}�͋C������ė͂�����Ȃ��Ȃ����I" if $game_temp.used_skill.name == "�����Ȃ���"
        elsif user.is_a?(Game_Enemy)
          effect = "#{myname}�̐g�̂���͂������Ă��܂����I"
          effect = "���ł�#{myname}�̐g�̂���͂������Ă����I" if myself.state?(30)
          effect = "#{myname}�͋C������ė͂�����Ȃ��Ȃ����I" if $game_temp.used_skill.name == "�����Ȃ���"
        end
        recover = "#{myname}�ɗ͂��߂��Ă����I"
        report = "#{myname}�͐g�̂ɗ͂�����Ȃ��I"
      when 38 # �ؕ|
        if user.is_a?(Game_Actor)
          effect = "#{myname}�ɈЈ�����^�����I"
          effect = "#{myname}�͏��ɓI�ɂȂ��Ă��܂����I" if $msg.tag == "��d"
        elsif user.is_a?(Game_Enemy)
          effect = "#{myname}�͏��ɓI�ɂȂ��Ă��܂����I"
        end
        recover = "#{myname}�͋C�������������I"
        report = "#{myname}�͏��ɓI�ɂȂ��Ă���I"
      when 39 # ���
        if user.is_a?(Game_Actor)
          effect = "#{myname}��Ⴢ������I"
          effect = "#{myname}�̐g�̂����񂾂�Ⴢ�Ă����c�c�I" if myself.is_a?(Game_Actor)
        elsif user.is_a?(Game_Enemy)
          effect = "#{myname}�͐g�̂���Ⴢ��Ă��܂����I"
          effect = "���ł�#{myname}�̐g�̂�Ⴢ�Ă����I" if myself.state?(30)
        end
        recover = "#{myname}�̐g�̖̂�Ⴢ��������I"
        report = "#{myname}�͐g�̂�Ⴢ�Ă���c�c�I"
      when 40 # �U��
        if user.is_a?(Game_Actor)
          effect = "#{myname}�̈ӎ��𗐂����I"
          effect = "#{myname}�̈ӎ����N�O�Ƃ��Ă����c�c�I" if myself.is_a?(Game_Actor)
          effect = "#{myname}�̈ӎ����N�O�Ƃ��Ă����c�c�I" if $msg.tag == "��d"
        elsif user.is_a?(Game_Enemy)
          effect = "#{myname}�͋C���U�炳��Ă��܂����I"
          effect = "#{myname}�̈ӎ����N�O�Ƃ��Ă����c�c�I" if $msg.tag == "��d"
          effect = "���ł�#{myname}�͈ӎ����W���ł��Ȃ��Ȃ����I" if myself.state?(30)
        end
        recover = "#{myname}�͎G�O��ǂ��������I"
        report = "#{myname}�͈ӎ����W���ł��Ȃ��I"
      when 41 # ���g
        effect = "#{myname}�͋C�������g���Ă����I"
        recover = "#{myname}�̋��������܂����I"
        report = ""
      when 42 # ����
        effect = "#{myname}�͋C�������������Ă����I"
        recover = "#{myname}�̋C�������ɖ߂����I"
        report = ""
      when 45 # �S�g���x�A�b�v
        effect = "#{myname}�͉����ɕq���ɂȂ����I"
        effect = "#{myname}�̐g�̂����łŕq���ɂȂ����I" if myself.state?(30)
        recover = ""
      when 46 # �����x�A�b�v
        effect = "#{myname}�͌��ւ̉����ɕq���ɂȂ����I"
        recover = ""
      when 47 # �����x�A�b�v
        effect = "#{myname}�͋��ւ̉����ɕq���ɂȂ����I"
        recover = ""
      when 48 # �K���x�A�b�v
        effect = "#{myname}�͂��K�ւ̉����ɕq���ɂȂ����I"
        recover = ""
      when 49 # �����x�A�b�v
        effect = "#{myname}�̓y�j�X�ւ̉����ɕq���ɂȂ����I"
        recover = ""
      when 50 # �����x�A�b�v
        effect = "#{myname}�̓A�\�R�ւ̉����ɕq���ɂȂ����I"
        recover = ""

      when 80 # �X�e�[�g����
        effect = "#{myname}�̔\�͂����������I" if myself.is_a?(Game_Actor)
        effect = "#{myname}�̔\�͂��������ꂽ�I" if myself.is_a?(Game_Enemy)
        case $msg.tag
        when "����", "���́{"
          effect.gsub!("�\��","����") 
        when "�E�ϗ�", "�E�ϗ́{"
          effect.gsub!("�\��","�E�ϗ�") 
        when "����", "���́{"
          effect.gsub!("�\��","����") 
        when "��p��", "��p���{"
          effect.gsub!("�\��","��p��") 
        when "�f����", "�f�����{"
          effect.gsub!("�\��","�f����") 
        when "���_��", "���_�́{"
          effect.gsub!("�\��","���_��") 
        end
        if $msg.tag[/�{/] != nil
          effect.gsub!("����","�X�ɋ���") 
        end
        myself.remove_state(80)
        recover = ""
      when 81 # �X�e�[�g����
        effect = "#{myname}�̔\�͂���̉��������I" if myself.is_a?(Game_Enemy)
        effect = "#{myname}�͔\�͂���̉�������ꂽ�I" if myself.is_a?(Game_Actor)
        case $msg.tag
        when "����", "���́|"
          effect.gsub!("�\��","����") 
        when "�E�ϗ�", "�E�ϗ́|"
          effect.gsub!("�\��","�E�ϗ�") 
        when "����", "���́|"
          effect.gsub!("�\��","����") 
        when "��p��", "���́|"
          effect.gsub!("�\��","��p��") 
        when "�f����", "�f�����|"
          effect.gsub!("�\��","�f����") 
        when "���_��", "���_�́|"
          effect.gsub!("�\��","���_��") 
        end
        if $msg.tag[/�|/] != nil
          effect.gsub!("��̉�","�X�Ɏ�̉�") 
        end
        myself.remove_state(81)
        recover = ""
      when 82 # �X�e�[�g�S����
        effect = "#{myname}�̑S�\�͂����������I" if myself.is_a?(Game_Actor)
        effect = "#{myname}�̑S�\�͂��������ꂽ�I" if myself.is_a?(Game_Enemy)
        myself.remove_state(82)
        recover = ""
      when 83 # �X�e�[�g�S����
        effect = "#{myname}�̑S�\�͂���̉��������I" if myself.is_a?(Game_Enemy)
        effect = "#{myname}�͑S�\�͂���̉�������ꂽ�I" if myself.is_a?(Game_Actor)
        myself.remove_state(83)
        recover = ""
      when 84 # �X�e�[�g�ێ�
        effect = "������#{myname}�ɂ͌��ʂ����������I"
        myself.remove_state(84)
        recover = ""
      when 85 # ��������
        effect = "#{myname}�̔\�͋��������������I" if myself.is_a?(Game_Enemy)
        effect = "#{myname}�̔\�͋������������ꂽ�I" if myself.is_a?(Game_Actor)
        myself.remove_state(85)
        recover = ""
      when 86 # �ቺ����
        effect = "#{myname}�̔\�͎�̉������������I" if myself.is_a?(Game_Actor)
        effect = "#{myname}�̔\�͎�̉����������ꂽ�I" if myself.is_a?(Game_Enemy)
        myself.remove_state(86)
        recover = ""
      when 87 # �S����
        effect = "#{myname}�̑S�\�͂����ɖ߂����I" if myself.is_a?(Game_Enemy)
        effect = "#{myname}�̑S�\�͂����ɖ߂��ꂽ�I" if myself.is_a?(Game_Actor)
        myself.remove_state(87)
        recover = ""
      when 93,94 # �h�䒆�A��h�䒆
        effect = "#{myname}�͉�������g������Ă���I"
        recover = ""
      when 95 # ���C����
        effect = "#{myname}�͖����̍D���ɔC���邱�Ƃɂ����I"
        report = "#{myname}�͖����̐������܂܂ɂȂ��Ă���I"
        recover = ""
      when 96 # �U��
=begin
�@�@    s_range = myself.is_a?(Game_Enemy) ? $game_troop.enemies : $game_party.battle_actors
        for i in s_range
          if i.exist?
            n += 1
          end
        end
        s_range_text = n > 1 ? "����" : ""
        effect += "����#{s_range_text}�̋�����#{myname}�Ɉڂ����I" if myself.is_a?(Game_Actor)
        effect += "#{master}#{s_range_text}��#{myname}��\n�ڂ����������Ă��܂����I" if myself.is_a?(Game_Enemy)
=end
      when 97 # �L�X�X�C�b�`�N��
        effect = "#{myname}�̓L�X������ăX�C�b�`���������I"
        recover = ""
      when 98 # ���@�w
        effect = "#{myname}�̏����閂�@�̏�������Ȃ����I"
        recover = "#{myname}�̑����̖��@�w�����ł����I"
      when 99 # �}�[�L���O
        effect = "#{myself.marking_battler.name}��#{myname}��\n"+
                 "�ڂ�t�����Ă��܂����I"
        recover = "#{myname}��#{myself.marking_battler.name}�ւ�\m\n"+
                  "�����������������I"
      when 101 # �j��
        effect = "#{myname}�͏�Ԉُ�ɋ����Ȃ����I"
        recover = "#{myname}�̏j���������Ȃ����I"
      when 102 # �ő�
        effect = "#{myname}�ْ̋������܂��Ă����I"
        recover = "#{myname}�ْ̋����������I"
        report = ""
      when 103 # ��S
        effect = "#{myname}�̐��_���������܂��ꂽ�I"
        recover = "#{myname}�̏W�����؂ꂽ�I"
        report = ""
      when 104 # ����
        recover = "#{myname}�̒����������������I"
        report = "#{myname}�͒������Ă���I"
=begin
        # ���Ȃ��������ŗ�����
�@�@    s_range = $game_troop.enemies if myself.is_a?(Game_Enemy)
        s_range = $game_party.battle_actors if myself.is_a?(Game_Actor)
        for i in s_range
          if i.exist?
            n += 1
          end
        end
        s_range_text = n > 1 ? "����" : ""
        effect += "#{myname}�͖���#{s_range_text}����ڂ�����ꂽ�I" if myself.is_a?(Game_Actor)
        effect += "#{master}#{s_range_text}��#{myname}��\n�C�����������Ă��܂����I" if myself.is_a?(Game_Enemy)
=end
      when 105 # �S��
        if user.is_a?(Game_Actor)
          effect = "#{myname}�͍S������Ă��܂����I"
        elsif user.is_a?(Game_Enemy)
          effect = "#{myname}���S�������I"
        end
        recover = "#{myname}�͍S����������ꂽ�I"
        report = "#{myname}�̐g�͍̂S������Ă���I"
      when 106 # �j��
        effect = "#{myname}�̖{�����\����Ă��܂����I"
        report = "#{myname}�͖{�������U�����Ƃ��ł��Ȃ��I"
        recover = "#{myname}�͗��������߂����I"
      end
      # ���b�Z�[�W�o��
      case type
      when "effect"
        text = effect
      when "recover"
        text = recover
      when "report"
        text = report
      end
      return text
    end
  end
end