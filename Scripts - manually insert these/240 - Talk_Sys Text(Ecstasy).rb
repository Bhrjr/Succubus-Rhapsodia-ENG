#==============================================================================
# �� Talk_Sys(������` 3)
#------------------------------------------------------------------------------
#   �����̌���������A�\�����邽�߂̃N���X�ł��B
#   ���̃N���X�̃C���X�^���X�� $msg �ŎQ�Ƃ���܂��B
#   �����ł͐Ⓒ���̃e�L�X�g��ݒ肵�܂�
#==============================================================================
class Talk_Sys
  def make_text
#########################################################################################################
#����{���ǂݍ���
 t_actor = $msg.t_target.name #��b�Ώۂ̃A�N�^�[��
 speaker = $msg.t_enemy.name #��b���̃G�l�~�[��
 master = $game_actors[101].name #��l����
 #�����݂���Ȃ�A�p�[�g�i�[��
 if $msg.t_partner != nil
   servant = $msg.t_target.name
   servant = $msg.t_partner.name if $msg.t_target == $game_actors[101] 
 else
   servant = nil
 end
 #���|���������͉�b�Ώۂ��Ăяo��
 if $game_switches[97]
   coop_leader = $msg.coop_leader.name
 else
   coop_leader = nil
 end
 # �f�o�b�O�p
 if $game_switches[97] and $DEBUG # �|������������
   error = "���G���[���e"
   unless master.is_a?(String)
     error += "\n�}�X�^�[��������ł͂Ȃ�"
   end
   unless speaker.is_a?(String)
     error += "\n�X�s�[�J�[��������ł͂Ȃ�"
   end
   unless coop_leader.is_a?(String)
     error += "\n�o�b�N�G�l�~�[��������ł͂Ȃ�"
   end
   unless error == "���G���[���e"
     print error
   end
 end
#########################################################################################################
if $game_temp.battle_active_battler.is_a?(Game_Enemy)
#========================================================================================================
case $msg.at_type
#----------------------------------------------------------------------------------------
when "�z�[���h�U��"
#----------------------------------------------------------------------------------------
when "�L�X"
#----------------------------------------------------------------------------------------
when "��"
#----------------------------------------------------------------------------------------
when "��"
#----------------------------------------------------------------------------------------
when "��"
#----------------------------------------------------------------------------------------
when "��"
#----------------------------------------------------------------------------------------
when "��"
#----------------------------------------------------------------------------------------
end
#========================================================================================================
#�����b�Z�[�W�������ꍇ�A�ėp�U�߃e�L�X�g������
if m = ""
  case $msg.talk_step
  when 1 #������
    emotion = ["���΂𕂂���","�������y���ނ��̂悤��"]
    emotion.push("��ڌ�����","�Â���悤�Ȏd���") if $msg.t_enemy.age == 1
    emotion.push("�d���ȏ΂݂𕂂���") if $msg.t_enemy.age >= 3
    emotion.push("���Y���ۂ��΂݂𕂂���") if $msg.t_enemy.positive?
    emotion.push("������Ɣ��΂ނ�") if $msg.t_enemy.negative?
    emotion.push("�̂ނ悤�ȕ\���","�ɂ��Ə΂�","�������Ɩڂ��ׂ߂��") if $msg.t_enemy.personality == "����" or $msg.t_enemy.personality == "�Ӓn��" or $msg.t_enemy.personality == "�I����"
    emotion = ["�����Ƃ����\���","�M���ۂ�����"] if $msg.t_enemy.crisis?
    emotion = emotion[rand(emotion.size)]
    #------
    action = ["�ł炷�悤��","�ɋ}������"]
    action.push("��_��","������") if $msg.t_enemy.positive?
    action.push("�D����","���J��") if $msg.t_enemy.negative?
    action.push("�ꏊ����") if $msg.t_enemy.personality == "�]��" or $msg.t_enemy.personality == "�Â���"
    action = action[rand(action.size)]
    #------
    if $msg.t_enemy.inserting_now? and $msg.t_enemy.vagina_insert?
      text = ["����U���Ă����I","���𓮂����Ă����I"]
      text = text[rand(text.size)]
    elsif $msg.t_enemy.oralsex_now? and $msg.t_enemy.mouth_oralsex?
      text = ["#{t_actor}�̃y�j�X���r�߉񂵂Ă����I","#{t_actor}�̃y�j�X������Ԃ��Ă����I"]
      text = text[rand(text.size)]
    else
      text = "#{t_actor}���������Ă����I"
    end
    m = "#{speaker}��#{emotion}�A\n#{action}#{text}"
  #-------------------------------------------------------------------------------------------------
  when 2..5 #���A�g
    if $msg.t_enemy.ecstasy_emotion == "��"
      emotion = ["#{coop_leader}�ɔ��΂�"]
      emotion.push("#{coop_leader}�ɖڔz����","#{coop_leader}�ɍ��킹") if $msg.t_enemy.age >= 3 or $msg.t_enemy.tribe == $msg.coop_leader.tribe
      emotion.push("#{coop_leader}�ɑ�����") if $msg.t_enemy.negative?
    elsif $msg.t_enemy.ecstasy_emotion == "�{"
      emotion = ["#{coop_leader}�ɕ�������"]
      emotion.push("#{coop_leader}���ɂނ�","#{coop_leader}�ɒ��荇��") if $msg.t_enemy.age >= 3 or $msg.t_enemy.tribe == $msg.coop_leader.tribe
      emotion.push("���G�ȕ\��𕂂���","�s�����Ȏ�����") if $msg.t_enemy.negative?
    end
    emotion = emotion[rand(emotion.size)]
    #------
    if $msg.t_enemy.ecstasy_emotion == "��"
      action = ["#{t_actor}�̒�R��j�Q���Ă����I","#{t_actor}�̓���������������ł����I"]
    elsif $msg.t_enemy.ecstasy_emotion == "�{"
      action = ["#{t_actor}���������͂��߂��I","#{t_actor}�ɖ������Ă����I"]
    end
    #���A�N�Z�v�g(���}��)���
    if $msg.t_enemy.vagina_insert?
      action = ["������������O�コ���Ă����I","���������𓮂����Ă����I","�A�\�R��������ƒ��߂Ă����I","����������O�コ���Ă����I","������������U���Ă����I"]
    #���I�[�����A�N�Z�v�g(���}��)���
    elsif $msg.t_enemy.mouth_oralsex?
      action = ["#{t_actor}�̃y�j�X������Ԃ��Ă����I","#{t_actor}�̃y�j�X���������r�߉񂵂��I","#{t_actor}�̃y�j�X���A���܂ň��ݍ���ł����I"]
    #���o�b�N�A�N�Z�v�g(�K�}��)���
    elsif $msg.t_enemy.anal_analsex?
      action = ["������������O�コ���Ă����I","���������𓮂����Ă����I","�e����������ƒ��߂Ă����I","����������O�コ���Ă����I","������������U���Ă����I"]
    #���G���u���C�X(����)���
    elsif $msg.t_enemy.tops_binder?
      action = ["���������܂�#{t_actor}���������Ă����I"]
    #���y���X�R�[�v(�p�C�Y��)���
    elsif $msg.t_enemy.tops_paizuri?
      action = ["#{$msg.t_enemy.bustsize}�ŋ���#{t_actor}�̃y�j�X���A\n�������������ŎC��グ�Ă����I"]
    #���w�u�����[�t�B�[��(�ςӂς�)���
    elsif $msg.t_enemy.tops_pahupahu?
      action = ["�Ⓒ���O��#{t_actor}�̊���A\n#{$msg.t_enemy.bustsize}�ŕ������߂Ă����I"]
    #���G�L�T�C�g�r���[(��ʋR��)���
    elsif $msg.t_enemy.vagina_riding?
      action = ["#{t_actor}�̊�ɋR�悵���܂܁A\n���𗎂Ƃ��ăA�\�R�������t���Ă����I"]
      action.push("#{t_actor}�̊�ɋR�悵���܂܁A\n�������ƍ���O�コ���Ă����I")
      action.push("#{t_actor}�̊�ɋR�悵���܂܁A\n�������������O�コ���Ă����I") if $msg.t_enemy.positive?
    #���C���������r���[(�K��ʋR��)���
    elsif $msg.t_enemy.anal_hipriding?
      action = ["#{t_actor}�̊�ɋR�悵���܂܁A\n���𗎂Ƃ��Ă��K�������t���Ă����I"]
      action.push("#{t_actor}�̊�ɋR�悵���܂܁A\n�������ƍ���O�コ���Ă����I")
      action.push("#{t_actor}�̊�ɋR�悵���܂܁A\n���K�����������O�コ���Ă����I") if $msg.t_enemy.positive?
    #���V�F���}�b�`(�L���킹)���
    elsif $msg.t_enemy.shellmatch?
      action = ["#{t_actor}�̋r������č���U���Ă����I","#{t_actor}�̋r������č��𓮂����Ă����I"]
      action.push("#{t_actor}�ƃA�\�R�𖧒��������܂܁A\n�������˂点�ăA�\�R���h�����Ă����I") if $msg.t_enemy.positive?
    #���t���b�^�i�C�Y(�f�B�[�v�L�X)���
    elsif $msg.t_enemy.deepkiss?
      action = ["#{t_actor}������񂹁A�M���L�X�����킵���I","#{t_actor}�ƔZ���ȃL�X�����킵���I"]
    #���h���E�l�N�^�[(�N���j�����O�X)���
    elsif $msg.t_enemy.mouth_draw?
      action = ["#{t_actor}�̃A�\�R�ɐ��}������Ă����I","#{t_actor}�̃A�\�R���������r�ߏグ�Ă����I"]
      action.push("#{t_actor}�̈��������𗧂Ăċz���Ă����I") if $msg.t_enemy.positive?
    #���f�B���h�C���T�[�g(�f�B���h���}��)���
    elsif $msg.t_enemy.dildo_insert?
      action = ["#{t_actor}�̔������y���ނ悤�ɁA\n�f�B���h�����������O�コ���Ă����I"]
    #���f�B���h�C���}�E�X(�f�B���h���}��)���
    elsif $msg.t_enemy.dildo_oralsex?
      action = ["#{t_actor}�̔������y���ނ悤�ɁA\n�f�B���h�����������O�コ���Ă����I"]
    #���f�B���h�C���o�b�N(�f�B���h�K�}��)���
    elsif $msg.t_enemy.dildo_analsex?
      action = ["#{t_actor}�̔������y���ނ悤�ɁA\n�f�B���h�����������O�コ���Ă����I"]
    end
    action = action[rand(action.size)]
    #------
    m = "#{speaker}��#{emotion}�A\n#{action}"
  #-------------------------------------------------------------------------------------------------
  when 7 #���ǌ�(����z�[���h�̂�)
    emotion = ["���΂𕂂���","�������y���݂Ȃ���"]
    emotion.push("��ڌ�����","�Â���悤��") if $msg.t_enemy.age == 1
    emotion.push("�d���ȕ\���") if $msg.t_enemy.age >= 3
    emotion.push("���Y���ۂ��΂�") if $msg.t_enemy.positive?
    emotion.push("������Ɣ��΂�") if $msg.t_enemy.negative?
    emotion.push("�̂ނ悤�Ȏ�����","�ɂ�ɂ�Ə΂�","�������Ɩڂ��ׂ�") if $msg.t_enemy.personality == "����" or $msg.t_enemy.personality == "�Ӓn��" or $msg.t_enemy.personality == "�I����"
    emotion = ["�����Ƃ����\���","�M�ɕ��������悤��"] if $msg.t_enemy.crisis?
    emotion = emotion[rand(emotion.size)]
    #------
    action = ["�X�ɏł炷�悤��"]
    action.push("�X�Ɍ�����") if $msg.t_enemy.positive?
    action.push("���������") if $msg.t_enemy.negative?
    action.push("��蒚�J��") if $msg.t_enemy.personality == "�]��"
    action = action[rand(action.size)]
    if $msg.t_enemy.inserting_now? and $msg.t_enemy.vagina_insert?
      text = ["����U���Ă����I","���𓮂����Ă����I"]
      text = text[rand(text.size)]
    elsif $msg.t_enemy.oralsex_now? and $msg.t_enemy.mouth_oralsex?
      text = ["#{t_actor}�̃y�j�X���r�߉񂵂Ă����I","#{t_actor}�̃y�j�X������Ԃ��Ă����I"]
      text = text[rand(text.size)]
    else
      text = "#{t_actor}���������Ă����I"
    end
    #------
    m = "#{speaker}��#{emotion}�A\n#{action}#{text}"
  #-------------------------------------------------------------------------------------------------
  when 9 #���Ƃǂ�
    emotion = ["�Ƃǂ߂Ƃ΂����","������Ə������΂�"]
    emotion.push("��ڌ�����","�Â���悤��") if $msg.t_enemy.age == 1
    emotion.push("�d���ȕ\���") if $msg.t_enemy.age >= 3
    emotion.push("���Y���ۂ��΂�") if $msg.t_enemy.positive?
    emotion.push("�΂݂��₳��") if $msg.t_enemy.negative?
    emotion.push("�̂ނ悤�Ȏ�����","�ɂ�ɂ�Ə΂�","�������Ɩڂ��ׂ�") if $msg.t_enemy.personality == "����" or $msg.t_enemy.personality == "�Ӓn��" or $msg.t_enemy.personality == "�I����"
    emotion = ["�����Ƃ����\���","�M�ɕ��������悤��"] if $msg.t_enemy.crisis?
    emotion = emotion[rand(emotion.size)]
    #------
    action = ["��݊|����悤��"]
    action.push("�I�m�Ȉ�����") if $msg.t_enemy.age >= 3
    action.push("�Ȃ���������") if $msg.t_enemy.positive?
    action.push("��_��") if $msg.t_enemy.negative?
    action.push("�Ȃ������J��","��S�s����") if $msg.t_enemy.personality == "�]��"
    action = action[rand(action.size)]
    if $msg.t_enemy.inserting_now? and $msg.t_enemy.vagina_insert?
      text = ["����U���Ă����I","���𓮂����Ă����I"]
      text = text[rand(text.size)]
    elsif $msg.t_enemy.oralsex_now? and $msg.t_enemy.mouth_oralsex?
      text = ["#{t_actor}�̃y�j�X���r�߉񂵂Ă����I","#{t_actor}�̃y�j�X������Ԃ��Ă����I"]
      text = text[rand(text.size)]
    else
      text = "#{t_actor}���U�ߗ��Ă��I"
    end
    #------
    m = "#{speaker}��#{emotion}�A\n#{action}#{text}"
  #-------------------------------------------------------------------------------------------------
  when 10 #���]�C
    action = ["�������ȏ΂݂𕂂��ׂĂ���c�c�I","���������Ə΂��Ă���c�c�I"]
    action.push("�d���ȏ΂݂𕂂��ׁA\n#{t_actor}�����߂Ă���c�c�I") if $msg.t_enemy.age >= 3
    action.push("���΂݂Ȃ���A\n#{t_actor}�̔��𕏂łĂ���c�c�I") if $msg.t_enemy.personality == "��i"
    action.push("�̂ނ悤�ȓ��ŁA\n#{t_actor}�������낵�Ă���c�c�I") if $msg.t_enemy.personality == "����"
    action.push("�ɂ�ɂ�Ə΂��Ȃ���A\n#{t_actor}�������낵�Ă���c�c�I") if $msg.t_enemy.personality == "�Ӓn��"
    action.push("�����ւ����悤�ȕ\��ŁA\n#{t_actor}�������낵�Ă���c�c�I") if $msg.t_enemy.personality == "�����C"
    action.push("�����̍s�ׂ��v���o���A\n�p�����������Ă���c�c�I") if $msg.t_enemy.personality == "���C"
    action.push("#{t_actor}�ɖ������A\n�����������ɖj���肵�Ă���c�c�I") if $msg.t_enemy.personality == "�Â���"
    action.push("�������悤�ȕ\��ŁA\n#{t_actor}�����߂Ă���c�c�I") if $msg.t_enemy.personality == "�s�v�c"
    action = action[rand(action.size)]
    #------
    m = "#{speaker}��#{action}"
  #-------------------------------------------------------------------------------------------------
  when 11..14 #���A�g�]�C
    if $msg.t_enemy.ecstasy_emotion == "��"
      emotion = ["�ꑧ����","����������"]
      emotion.push("��萋�����\���") if $msg.t_enemy.tribe == $msg.coop_leader.tribe
      emotion.push("�y�����ȗl�q��") if $msg.t_enemy.positive?
      emotion.push("�������肽�l�q��") if $msg.t_enemy.negative?
    elsif $msg.t_enemy.ecstasy_emotion == "�{"
      emotion = ["���ߑ�������","���G�ȕ\���","�c�O�����ȗl�q��"]
    end
    emotion = emotion[rand(emotion.size)]
    #------
    if $msg.t_enemy.ecstasy_emotion == "��"
      action = ["#{cp_leader}�ɔ��΂񂾁c�c�I","#{t_actor}�ɔ��΂񂾁c�c�I"]
      action.push("�s�ׂ̗]�C���y����ł���c�c�I") if $msg.t_enemy.age >= 3
      action.push("#{cp_leader}�ƏΊ�����������Ă���c�c�I") if $msg.t_enemy.tribe == $msg.coop_leader.tribe
    elsif $msg.t_enemy.ecstasy_emotion == "�{"
      action = ["#{cp_leader}�ɕs�����Ȏ����𑗂����c�c�I","#{t_actor}�ɕs�����Ȏ����𑗂����c�c�I"]
      action.push("#{cp_leader}�ɍ��߂����Ȏ����𑗂��Ă���I") if $msg.t_enemy.personality == "�|��"
      action.push("#{cp_leader}�ɕs���̐����グ�Ă���c�c�I") if $msg.t_enemy.personality == "����"
      action.push("#{t_actor}��߂����Ɍ��߂Ă���c�c") if $msg.t_enemy.personality == "���C"
    end
    action = action[rand(action.size)]
    #------
    m = "#{speaker}��#{emotion}�A\n#{action}"
  #-------------------------------------------------------------------------------------------------
  when 20 #���퓬�p��(�z�[���h���̏ꍇ�͉�������)
    emotion = ["������Ə΂�"]
    emotion.push("���Y���ۂ��΂�") if $msg.t_enemy.age == 1
    emotion.push("�������ȕ\���") if $msg.t_enemy.age >= 3
    emotion.push("�������ȕ\���") if $msg.t_enemy.positive?
    emotion.push("������Ə΂�") if $msg.t_enemy.negative?
    emotion.push("�Ӓn�����ȏ΂݂𕂂���") if $msg.t_enemy.personality == "����" or $msg.t_enemy.personality == "�Ӓn��" or $msg.t_enemy.personality == "�I����"
    emotion = ["���c�ɂ�������"] if $msg.t_enemy.crisis?
    emotion = emotion[rand(emotion.size)]
    #------
    action = ["#{t_actor}���痣�ꂽ�c�c�I"]
    action.push("#{t_actor}�ɂ����ƌ��t������ƁA\n#{t_actor}����������c�c�I") if $msg.t_enemy.age >= 3 or $msg.t_enemy.personality == "�]��"
    action.push("#{t_actor}����������c�c�I") if $msg.t_enemy.positive?
    action = action[rand(action.size)]
    #------
    m = "#{speaker}��#{emotion}�A\n#{action}"
  #-------------------------------------------------------------------------------------------------
  when 21 #���퓬�p��(�z�[���h���̏ꍇ�͌p��)
    emotion = ["������Ə΂�"]
    emotion.push("���Y���ۂ��΂�") if $msg.t_enemy.age == 1
    emotion.push("�d���ȏ΂݂𕂂���") if $msg.t_enemy.age >= 3
    emotion.push("�x�މɂ�����") if $msg.t_enemy.positive?
    emotion.push("������Ə΂�") if $msg.t_enemy.negative?
    emotion.push("�ɂ��Ə΂݂𕂂���") if $msg.t_enemy.personality == "����" or $msg.t_enemy.personality == "�Ӓn��" or $msg.t_enemy.personality == "�I����"
    emotion = ["�����Ƃ����\���","�M�ɕ������ꂽ�悤��"] if $msg.t_enemy.crisis?
    emotion = emotion[rand(emotion.size)]
    #------
    action = ["#{t_actor}�ɕ������Ԃ����Ă����c�c�I"]
    #���A�N�Z�v�g(���}��)���
    if $msg.t_enemy.vagina_insert?
      action = ["#{t_actor}�̏�ōĂэ���U��͂��߂��I"]
      action.push("#{t_actor}�̔������y���ނ悤�ɁA\n�������������O�コ���Ă����I") if $msg.t_enemy.positive?
      action.push("�����󂯎~�߂��]�C�������ł���c�c�I") if $msg.t_enemy.negative?
    #���I�[�����A�N�Z�v�g(���}��)���
    elsif $msg.t_enemy.mouth_oralsex?
      action = ["#{t_actor}�̃y�j�X��������܂܁A\n�������ƌ��𓮂����Ă����I"]
      action.push("#{t_actor}�̐���������ƈ��ݍ��ނƁA\n�X�ɍi����悤�Ƀy�j�X������Ԃ��Ă����I") if $msg.t_enemy.positive?
      action.push("�����Ƃ�Ƃ����\��ŁA\n#{t_actor}�̃y�j�X������Ԃ葱���Ă���c�c�I") if $msg.t_enemy.negative?
    #���o�b�N�A�N�Z�v�g(�K�}��)���
    elsif $msg.t_enemy.anal_analsex?
      action = ["#{t_actor}�̏�ŁA�Ăэ���U��͂��߂��I"]
      action.push("#{t_actor}�̔������y���ނ悤�ɁA\n�������������O�コ���Ă���I") elsif $msg.t_enemy.positive?
      action.push("�����󂯎~�߂��]�C�������ł���c�c�I") if $msg.t_enemy.negative?
    #���G���u���C�X(����)���
    elsif $msg.t_enemy.tops_binder?
      action = ["#{t_actor}�ɍX�ɖ������Ă����c�c�I"]
    #���y���X�R�[�v(�p�C�Y��)���
    elsif $msg.t_enemy.tops_paizuri?
      action = ["�Ⓒ�����΂����#{t_actor}�̃y�j�X���A\n����#{$msg.t_enemy.bustsize}�ŘM�ё����Ă���c�c�I"]
      action.push("���ɕ����ꂽ�����r�ߎ��ƁA\n������#{$msg.t_enemy.bustsize}�ŋ��ݍ���ł����I") if $msg.t_enemy.positive?
    #���w�u�����[�t�B�[��(�ςӂς�)���
    elsif $msg.t_enemy.tops_pahupahu?
      action = ["�Ⓒ�����΂����#{t_actor}�̊���A\n����#{$msg.t_enemy.bustsize}�ōX�ɕ������߂Ă����I"]
    #���G�L�T�C�g�r���[(��ʋR��)���
    elsif $msg.t_enemy.vagina_riding?
      action = ["#{t_actor}�̊�ɋR�悵���܂܁A\n�X�ɍ��𗎂Ƃ��A�\�R�������t���Ă����I"]
      action.push("#{t_actor}�̊�ɋR�悵���܂܁A\n�������������O�コ���Ă����I") if $msg.t_enemy.positive?
      action.push("#{t_actor}�̊�ɋR�悵���܂܁A\n�����Ƃ����\��ō���U���Ă���I") if $msg.t_enemy.negative?
    #���C���������r���[(�K��ʋR��)���
    elsif $msg.t_enemy.anal_hipriding?
      action = ["#{t_actor}�̊�ɋR�悵���܂܁A\n�X�ɍ��𗎂Ƃ����K�������t���Ă����I"]
      action.push("#{t_actor}�̊�ɋR�悵���܂܁A\n���K�����������O�コ���Ă����I") if $msg.t_enemy.positive?
      action.push("#{t_actor}�̊�ɋR�悵���܂܁A\n�����Ƃ����\��ł��K��U���Ă���I") if $msg.t_enemy.negative?
    #���V�F���}�b�`(�L���킹)���
    elsif $msg.t_enemy.shellmatch?
      action = ["#{t_actor}�̋r������č���U��͂��߂��I"]
    #���t���b�^�i�C�Y(�f�B�[�v�L�X)���
    elsif $msg.t_enemy.deepkiss?
      action = ["#{t_actor}�̊������񂹍X�ɃL�X�𑱂����I"]
    #���h���E�l�N�^�[(�N���j�����O�X)���
    elsif $msg.t_enemy.mouth_draw?
      action = ["#{t_actor}�̃A�\�R���r�ߑ����Ă���I"]
    #���f�B���h�C���T�[�g(�f�B���h���}��)���
    elsif $msg.t_enemy.dildo_insert?
      action = ["#{t_actor}�̔������y���ނ悤�ɁA\n�Ăуf�B���h�����������O�コ���Ă����I"]
    #���f�B���h�C���}�E�X(�f�B���h���}��)���
    elsif $msg.t_enemy.dildo_oralsex?
      action = ["#{t_actor}�̔������y���ނ悤�ɁA\n�Ăуf�B���h�����������O�コ���Ă����I"]
    #���f�B���h�C���o�b�N(�f�B���h�K�}��)���
    elsif $msg.t_enemy.dildo_analsex?
      action = ["#{t_actor}�̔������y���ނ悤�ɁA\n�Ăуf�B���h�����������O�コ���Ă����I"]
    end
    action = action[rand(action.size)]
    #------
    m = "#{speaker}��#{emotion}�A\n#{action}"
  #-------------------------------------------------------------------------------------------------
  when 30 #���I��
    #���Ώۂ���l���Ŗ����ꍇ�A�퓬�p������e�L�X�g�ɂ���
    if $msg.t_target != $game_actors[101]
      action = ["�Ɍ�������A���΂�","�Ɋ��҂̊፷���������Ă���"]
      action.push("�ɈӖ��[�Ȕ��΂݂������Ă���") if $msg.t_enemy.age >= 3 or $msg.t_enemy.personality == "�|��"
      action.push("�ɔM�������𑗂��Ă���") if $msg.t_enemy.positive?
      action.push("�ɋC�p�����������ɔ��΂�") if $msg.t_enemy.negative?
      action = action[rand(action.size)]
      #------
      m = "#{speaker}��#{servant}���痣��A\n#{master}#{action}�c�c�I"
    #���Ώۂ���l���̏ꍇ�A�퓬�I�����Î�����e�L�X�g�ɂ���
    else
      emotion = ["������Ə΂�"]
      emotion.push("���Y���ۂ��΂�") if $msg.t_enemy.age == 1
      emotion.push("�d���ȏ΂݂𕂂���") if $msg.t_enemy.age >= 3
      emotion.push("�y�����ȗl�q��") if $msg.t_enemy.positive?
      emotion.push("������Ə΂�") if $msg.t_enemy.negative?
      emotion.push("�ɂ��Ə΂݂𕂂���") if $msg.t_enemy.personality == "����" or $msg.t_enemy.personality == "�Ӓn��" or $msg.t_enemy.personality == "�I����"
      emotion = ["�����Ƃ����\���","�M�ɕ������ꂽ�悤��"] if $msg.t_enemy.crisis?
      emotion = emotion[rand(emotion.size)]
      #------
      action = ["#{t_actor}�ɋ߂Â��Ă���c�c�I"]
      action.push("#{t_actor}�ɕ������Ԃ����Ă����c�c�I") if $msg.t_enemy.positive?
      action = action[rand(action.size)]
      #------
      m = "#{speaker}��#{emotion}�A\n#{action}"
    end
  #-------------------------------------------------------------------------------------------------
  when 50 #���Ⓒ(�V�X�e���e�L�X�g)
    m = "#{t_actor}�͂���ȏ�ς����Ȃ��I\\|\\|"
    m = "#{t_actor}�̚b�������ӂ�ɋ����I\\|\\|" unless $msg.t_target.boy?
  end
end
#========================================================================================================
elsif $game_temp.battle_active_battler.is_a?(Game_Actor)
#========================================================================================================
#���΃G�l�~�[�����F�Ⓒ�e�L�X�g
case $msg.talk_step
#������
when 1
  tec = action = []
  case $msg.at_type
  #���z�[���h�U�ߌn
  when "�X�E�B���O","�w���B�X�E�B���O","�X�N���b�`"
    action = ["�̐g�̂������Ők����I"]
    action.push("�����ۑ傫�țg�����R���I") if $msg.t_target.positive?
    action.push("���猾�t�ɂȂ�Ȃ��g�����R���I") if $msg.t_target.negative?
    action.push("�̏����Ȑg�̂��傫�����˂�I") if $msg.t_target.girl? and $msg.t_target.age == 1
    action = action[rand(action.size)]
    #�e�L�X�g�o��
    m = "#{t_actor}������U�邽�сA\n#{speaker}#{action}"
  #���L�b�X�n(����)
  when "�L�b�X"
    tec = ["��M�I��"]
    tec.push("���f�I��","��_��") if $msg.t_target.positive?
    tec.push("��S�s����","�Ђ��ނ���") if $msg.t_target.negative?
    tec.push("�S����","�d����") if $msg.t_target.girl? and $msg.t_target.age > 2
    tec.push("�ꏊ������","���炵��") if $msg.t_target.girl? and $msg.t_target.age < 3
    tec = tec[rand(tec.size)]
    action = ["�̐g�̂������ɐk����I","�͓������悤�ȕ\��𕂂��ׂĂ���I"]
    action = action[rand(action.size)]
    #�e�L�X�g�o��
    m = "#{t_actor}��#{tec}���t���ŁA\n#{speaker}#{action}"
  #�����̑���ʓI�ȍU��
  else
    tec = ["��M�I��"]
    tec.push("���f�I��","��_��") if $msg.t_target.positive?
    tec.push("��S�s����","�M�S��") if $msg.t_target.negative?
    tec.push("�S����","�d����") if $msg.t_target.girl? and $msg.t_target.age > 2
    tec.push("�ꏊ������","�Ђ��ނ���") if $msg.t_target.girl? and $msg.t_target.age < 3
    tec = tec[rand(tec.size)]
    action = ["�̐g�̂������ɐk����I","�̌�����g�����R���I","�̐g�̂��傫���k����I"]
    action = action[rand(action.size)]
    #�e�L�X�g�o��
    m = "#{t_actor}��#{tec}�����ŁA\n#{speaker}#{action}"
  end
#���ǌ�(����z�[���h�̂�)
when 7
  case $msg.at_type
  when "�X�E�B���O","�w���B�X�E�B���O"
    action = "�ڊ|���č���ł������I"
    action = "�̍���͂݁A�͋����˂��グ���I" if $msg.t_target.penis_intv == 0
    m = "#{speaker}#{action}"
  when "�X�N���b�`"
    m = "#{t_actor}�͍X�Ɍ������A\n#{speaker}�ƃA�\�R���C�荇�킹���I"
  else
    m = "#{t_actor}�͍X�Ɍ������A\n#{speaker}�̕q���ȕ������U�ߗ��Ă��I"
  end
#���Ƃǂ�
when 9
  action = ["�̐g�̂��A\n�|�̂悤�ɑ傫�����Ȃ�I","�̛g�����A\n�ЂƂ���傫�����͂ɋ����I"]
  action.push("�̐g�̂��A\n���܂�̉����ɂ�����Ƌ�����I")
  action = action[rand(action.size)]
  #�e�L�X�g�o��
  m = "#{speaker}#{action}"
#���]�C�s��
when 10
  action = ["�����Őg�ウ���Ă���c�c�I","�������悤�ȕ\��Ŗウ�Ă���c�c�I"]
  action.push("�����Ƃ����\��𕂂��ׂĂ���c�c�I") if $msg.t_target.positive?
  action.push("�r���������Ȃ���ウ�Ă���c�c�I") if $msg.t_target.negative?
  action = action[rand(action.size)]
  #�e�L�X�g�o��
  m = "#{speaker}��#{action}"
#���z�[���h�p��(�z�[���h���̂�)
when 21
  m = "#{t_actor}�͈�ċz�u���ƁA\n�Ă�#{speaker}�ɕ������Ԃ������I"
else
  m = ""
end
#========================================================================================================
end #game_enemy/actor
#========================================================================================================
#���e�L�X�g���`
if  m != ""
  m += "TALKTEXT"
  $msg.text4 = m
end
#########################################################################################################
end #def
end #class

=begin
#**********************************************************************************************
 ���g�[�N�X�e�b�v�̋L�q�l��
 #���Ⓒ�O
 #����
  1�F�Ώۂ̂d�o���O�ɂ����L�����N�^�[�̍s��
 #�Q�`�S�͘A�g��p
  2�F�A�g�L�����N�^�[�P�̍s��(�L�����N�^�[�P�����݂����)
  3�F�A�g�L�����N�^�[�Q�̍s��(�L�����N�^�[�Q�����݂����)
  4�F�A�g�L�����N�^�[�R�̍s��(�L�����N�^�[�R�����݂����)
 #����
  7�F�Ώۂ̂d�o���O�ɂ����L�����N�^�[�̒ǌ�
     ���C���T�[�g�A�y���X�R�[�v�A�I�[�����C���T�[�g�A�o�b�N�C���T�[�g�A�V�F���}�b�`�̂T�̂ݔ�������
       �A�g���A�ʏ�U�����A���̑��z�[���h���͔�΂��Ď��Ɉڍs
  9�F�Ώۂ̂d�o���O�ɂ����L�����N�^�[�̂Ƃǂ߂̍s��
 #���Ⓒ��
 10�F�Ώۂ̂d�o���O�ɂ����L�����N�^�[�̗]�C�s��
 #11�`13�͘A�g��p
 11�F�A�g�L�����N�^�[�P�̗]�C�s��(�L�����N�^�[�P�����݂����)
 12�F�A�g�L�����N�^�[�Q�̗]�C�s��(�L�����N�^�[�Q�����݂����)
 13�F�A�g�L�����N�^�[�R�̗]�C�s��(�L�����N�^�[�R�����݂����)
 #�z�[���h���̂ݕ\��
 20�F�]�C��A�d�o���O�ɂ����L�����N�^�[���z�[���h����������ꍇ
 21�F�]�C��A�d�o���O�ɂ����L�����N�^�[���z�[���h���p������ꍇ
 #����
 30�F�Ώۂ̂u�o���O�ƂȂ����ꍇ(���_)
 50�F�Ⓒ���O�̃e�L�X�g�\��(�V�X�e��)
#**********************************************************************************************
=end
