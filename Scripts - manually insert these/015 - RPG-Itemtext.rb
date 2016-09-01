#==============================================================================
# �� RPG::Skill
#------------------------------------------------------------------------------
# �@�A�C�e���ʃ��b�Z�[�W�i�[
#==============================================================================
module RPG
  class Item
    def message(item, type, myself, user)
      text = ""
      action = ""
      myname = myself.name
      username = user.name
      itemname = item.name
      target = $game_temp.battle_target_battler[0] if $game_temp.battle_target_battler[0] != nil
      targetname = $game_temp.battle_target_battler[0].name if $game_temp.battle_target_battler[0] != nil
      prm = "#{myname}��"
      action = prm + "#{itemname}���g�����I"
      avoid = "#{myname}�͂��΂₭���킵���I"
      # �������Ŕ��f
#      if item.element_set.include?(121)
#        action = dodge = ""
#      end
      # ��ID�Ŕ��f(�K�v�ɉ����Čʐݒ�)
      case item.id
      when 51,52,53 # �����ȃ|�s�[�A�N�₩�ȉԊ��A���}���X�u�[�P
        action = prm + "#{targetname}��\n\066#{itemname}��n�����I"
        avoid  = "������#{myname}�͂����\�������������c�c"
      end
      # ���b�Z�[�W�o��
      case type
      when "action"
        text = action
      when "avoid"
        text = avoid
      end
      return text
    end
  end
end