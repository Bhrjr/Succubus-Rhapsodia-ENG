#==============================================================================
# �� Game_BattlerHold
#------------------------------------------------------------------------------
#�@�o�g���[�̃z�[���h���������N���X�ł��B
#==============================================================================

class Game_BattlerHold
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_accessor :mouth                      # ��
  attr_accessor :tops                       # �㔼�g
  attr_accessor :penis                      # �y�j�X
  attr_accessor :vagina                     # �A�\�R
  attr_accessor :anal                       # �A�i��
  attr_accessor :tail                       # �K��
  attr_accessor :tentacle                   # �G��
  attr_accessor :dildo                      # �f�B���h
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    @mouth    = Game_BattlerHold_Data.new
    @tops     = Game_BattlerHold_Data.new
    @penis    = Game_BattlerHold_Data.new
    @vagina   = Game_BattlerHold_Data.new
    @anal     = Game_BattlerHold_Data.new 
    @tail     = Game_BattlerHold_Data.new
    @tentacle = Game_BattlerHold_Data.new
    @dildo    = Game_BattlerHold_Data.new
  end
  #--------------------------------------------------------------------------
  # �� �p�[�c���̏o��
  #--------------------------------------------------------------------------
  def parts_names
    box = []
    box.push("mouth")
    box.push("tops")
    box.push("penis")
    box.push("vagina")
    box.push("anal")
    box.push("tail")
    box.push("tentacle")
    box.push("dildo")
    return box
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h�󋵂̏o��
  #--------------------------------------------------------------------------
  def hold_output
    reslut = []
    self_parts = [@mouth, @tops, @penis, @vagina, @anal, @tail, @tentacle, @dildo]
    for one in self_parts
      if one.type != nil
        reslut.push([one.battler, one.parts, one.type, one.initiative])
      end
    end
    return reslut
  end
  #--------------------------------------------------------------------------
  # �� �C�j�V�A�`�u���Ƃ��Ă��邩�H
  #--------------------------------------------------------------------------
  def initiative?
    self_parts = [@mouth, @tops, @penis, @vagina, @anal, @tail, @tentacle, @dildo]
    result_number = 0
    for one in self_parts
      if one.type != nil
        result_number += one.initiative
      end
    end
    return (result_number > 0)
  end
  #--------------------------------------------------------------------------
  # �� ���݂̃C�j�V�A�`�u���x��
  #--------------------------------------------------------------------------
  def initiative_level
    self_parts = [@mouth, @tops, @penis, @vagina, @anal, @tail, @tentacle, @dildo]
    result_box = [0]
    for one in self_parts
      if one.type != nil
        result_box.push(one.initiative)
      end
    end
    return (result_box.max)
  end
end

#==============================================================================
# �� Game_BattlerHold_Data
#------------------------------------------------------------------------------
#�@�z�[���h�̏ڍ׏��������N���X�ł��B
#==============================================================================

class Game_BattlerHold_Data
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_accessor :battler                # �A�����Ă��鑊��
  attr_accessor :parts                  # �A�����Ă���ӏ�
  attr_accessor :type                   # �A�����Ă�����@
  attr_accessor :initiative             # �A�����̗L���s��
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    @battler = nil
    @parts = nil
    @type = nil
    @initiative = nil
  end
  #--------------------------------------------------------------------------
  # �� �ݒ�
  #--------------------------------------------------------------------------
  def set(battler, parts, type, initiative)
    @battler = battler
    @parts = parts
    @type = type
    @initiative = initiative
  end
  #--------------------------------------------------------------------------
  # �� �N���A
  #--------------------------------------------------------------------------
  def clear
    @battler = nil
    @parts = nil
    @type = nil
    @initiative = nil
  end
  
end


class Scene_Battle
  #--------------------------------------------------------------------------
  # �� �z�[���h�̉���
  # owner  : ��������o�g���[
  # target : �ݒ肵���ꍇ�A��������͂��̃o�g���[�݂̂ɂ���
  # type   : �P�ȏ�̏ꍇ�A�Ⓒ���p�ɂȂ�
  #--------------------------------------------------------------------------
  def hold_release(owner, target = nil, type = 0)
    # �p�[�c�����擾����
    owner_parts = owner.hold.parts_names
    # �e�p�[�c���ƂɊm�F
    for o_parts_one in owner_parts
      # �p�[�c����ϐ��ɓ����
      checking_parts = eval("owner.hold.#{o_parts_one}")
      # ���̃p�[�c����L���̏ꍇ
      if checking_parts.battler != nil
        # �z�[���h�����ϐ��ɓ����
        hold_target = checking_parts.battler
        # �z�[���h�Ώۂ�target�̏ꍇ�A�������s��
        if hold_target == target or target == nil
          # �z�[���h���葤�̑Ή��p�[�c�z����m�F����
          target_parts_names = SR_Util.holding_parts_name(checking_parts.type, o_parts_one)
          # �Ή��p�[�c���ƂɃ`�F�b�N
          for t_parts_one in target_parts_names
            # �Ή��p�[�c����ϐ��ɓ����
            checking_target_parts = eval("hold_target.hold.#{t_parts_one}")
            # �������s��
            checking_parts.clear
            checking_target_parts.clear
            # �Ⓒ���p�̓A�j����X�L���R���N�g�̏��������s��
            if type >= 1
              hold_target.animation_id = 7
              hold_target.animation_hit = true
              hold_target.graphic_change = true
              hold_target.skill_collect = nil if hold_target.is_a?(Game_Actor)
              hold_target.add_state(12) if hold_target.is_a?(Game_Enemy)
            end
          end
        end
        #-----------------------------------------------------------------------------
      end
    end
    # �Ⓒ���p�̓A�j����X�L���R���N�g�̏��������s��
    if type >= 1
      owner.animation_id = 7
      owner.animation_hit = true
      owner.graphic_change = true
      owner.skill_collect = nil if owner.is_a?(Game_Actor)
      owner.add_state(12) if owner.is_a?(Game_Enemy)
    end
  end
  #--------------------------------------------------------------------------
  # �� �z�[���h�̕t�^
  #--------------------------------------------------------------------------
  def add_hold(skill, active, target)
    #�z�[���h�t�^(����)�����������ꍇ�A�ꎞ�I�ɃX�L���R���N�g��nil�ɖ߂�
    active.skill_collect = nil if active.is_a?(Game_Actor)
    target.skill_collect = nil if target.is_a?(Game_Actor)
    case skill.name
    #�X�L�����Ŕ��f���ĕt�^�B�X�L������ύX�����ꍇ�͂��̓s�x�������邱�ƁB
    when "�C���T�[�g" # �Y
      active.hold.penis.set(target, "�A�\�R", "���}��", 2)
      target.hold.vagina.set(active, "�y�j�X", "���}��", 0)
    when "�A�N�Z�v�g" # �Y
      active.hold.vagina.set(target, "�y�j�X", "���}��", 2)
      target.hold.penis.set(active, "�A�\�R", "���}��", 0)
    when "�I�[�����A�N�Z�v�g" # �Y
      active.hold.mouth.set(target, "�y�j�X", "���}��", 2)
      target.hold.penis.set(active, "��", "���}��", 0)
    when "�I�[�����C���T�[�g" # �Y 
      active.hold.penis.set(target, "��", "���}��", 2)
      target.hold.mouth.set(active, "�y�j�X", "���}��" , 0)
    when "�h���E�l�N�^�[" # �Y
      active.hold.mouth.set(target, "�A�\�R", "�N���j", 2)
      target.hold.vagina.set(active, "��", "�N���j", 0)
    when "�t���b�^�i�C�Y" 
      active.hold.mouth.set(target, "��", "�L�b�X", 2)
      target.hold.mouth.set(active, "��", "�L�b�X", 0)
    when "�o�b�N�C���T�[�g"
      active.hold.penis.set(target, "�A�\�R", "�K�}��", 2)
      target.hold.anal.set(active, "�A�i��", "�K�}��", 0)
    when "�o�b�N�A�N�Z�v�g"
      active.hold.anal.set(target, "�y�j�X", "�K�}��", 2)
      target.hold.penis.set(active, "�A�i��", "�K�}��", 0)
    when "�G�L�T�C�g�r���[" # �Y
      active.hold.vagina.set(target, "��", "��ʋR��", 2)
      target.hold.mouth.set(active, "�A�\�R", "��ʋR��", 0)
    when "�C���������r���[" 
      active.hold.anal.set(target, "��", "�K�R��", 2)
      target.hold.mouth.set(active, "�A�i��", "�K�R��" , 0)
    when "�G���u���C�X" # �Y
      active.hold.tops.set(target, "�㔼�g", "�S��", 2)
      target.hold.tops.set(active, "�㔼�g", "�S��", 0)
    when "�G�L�V�r�W����"
      active.hold.tops.set(target, "�㔼�g", "�J�r", 2)
      target.hold.tops.set(active, "�㔼�g", "�J�r", 0)
    when "�y���X�R�[�v" # �Y
      active.hold.tops.set(target, "�y�j�X", "�p�C�Y��", 2)
      target.hold.penis.set(active, "�㔼�g", "�p�C�Y��", 0)
    when "�w�u�����[�t�B�[��"
      active.hold.tops.set(target, "��", "�ςӂς�", 2)
      target.hold.mouth.set(active, "�㔼�g", "�ςӂς�", 0)
    when "�V�F���}�b�`" # �Y
      active.hold.vagina.set(target, "�A�\�R", "�L���킹", 2)
#      active.hold.anal.set(target, "�A�i��", "�L���킹", 2)
      target.hold.vagina.set(active, "�A�\�R", "�L���킹", 0)
#      active.hold.anal.set(active, "�A�i��", "�L���킹", 0)
    when "�C���T�[�g�e�C��"
      active.hold.tail.set(target, "�A�\�R", "���}��", 2)
      target.hold.vagina.set(active, "�K��", "���}��", 0)
    when "�}�E�X�C���e�C��"
      active.hold.tail.set(target, "�A�\�R", "���}��", 2)
      target.hold.mouth.set(active, "�K��", "���}��", 0)
    when "�o�b�N�C���e�C��"
      active.hold.tail.set(target, "�A�\�R", "�K�}��", 2)
      target.hold.anal.set(active, "�K��", "�K�}��", 0)
    when "�f�B���h�C���T�[�g" # �Y
      active.hold.dildo.set(target, "�A�\�R", "�f�B���h���}��", 2)
      target.hold.vagina.set(active, "�f�B���h", "�f�B���h���}��", 0)
    when "�f�B���h�C���}�E�X" # �Y
      active.hold.dildo.set(target, "��", "�f�B���h���}��", 2)
      target.hold.mouth.set(active, "�f�B���h", "�f�B���h���}��", 0)
    when "�f�B���h�C���o�b�N" # �Y
      active.hold.dildo.set(target, "�A�i��", "�f�B���h�K�}��", 2)
      target.hold.anal.set(active, "�f�B���h", "�f�B���h�K�}��", 0)
    when "�C���T�[�g�e���^�N��"
      active.hold.tentacle.set(target, "�A�\�R", "���}��", 2)
      target.hold.vagina.set(active, "�G��", "���}��", 0)
    when "�}�E�X�C���e���^�N��"
      active.hold.tentacle.set(target, "�A�\�R", "���}��", 2)
      target.hold.mouth.set(active, "�G��", "���}��", 0)
    when "�o�b�N�C���e���^�N��"
      active.hold.tentacle.set(target, "�A�\�R", "�K�}��", 2)
      target.hold.anal.set(active, "�G��", "�K�}��", 0)
    when "�e���^�N���o���f�[�W"
      active.hold.tentacle.set(target, "�㔼�g", "�S��", 2)
      target.hold.tops.set(active, "�G��", "�S��", 0)
    when "�C���T���g�c���["
      active.hold.tentacle.set(target, "�㔼�g", "�J�r", 2)
      target.hold.tops.set(active, "�G��", "�J�r", 0)
    when "�A�C���B�N���[�Y" # �Y
      active.hold.tentacle.set(target, "�㔼�g", "�ӍS��", 2)
      target.hold.tops.set(active, "�G��", "�ӍS��", 0)
    when "�f�����Y�N���[�Y" # �Y
      active.hold.tentacle.set(target, "�㔼�g", "�G��S��", 2)
      target.hold.tops.set(active, "�G��", "�G��S��", 0)
    when "�f�����Y�A�u�\�[�u" # �Y
      active.hold.tentacle.set(target, "�y�j�X", "�G��z��", 2)
      target.hold.penis.set(active, "�G��", "�G��z��", 0)
    when "�f�����Y�h���E" # �Y
      active.hold.tentacle.set(target, "�A�\�R", "�G��N���j", 2)
      target.hold.vagina.set(active, "�G��", "�G��N���j", 0)
    #�����X�L��
    when "�����[�X"
      #�����ΏۂɃz�[���h���L���X�g��t�^����
      target.add_state(12) if target.is_a?(Game_Enemy)
      # �z�[���h�̉����i���̋L�q�����\�b�h�Ɋȗ����j
      hold_release(target, active)
=begin
      #���y�j�X����
      if target.hold.penis.battler == active
        case target.hold.penis.type
        when "���}��"
          active.hold.vagina.set(nil, nil, nil, nil)
        when "���}��"
          active.hold.mouth.set(nil, nil, nil, nil)
        when "�K�}��"
          active.hold.anal.set(nil, nil, nil, nil)
        when "�p�C�Y��"
          active.hold.tops.set(nil, nil, nil, nil)
        when "�G��z��"
          active.hold.tentacle.set(nil, nil, nil, nil)
        end
        target.hold.penis.set(nil, nil, nil, nil)
      #���A�\�R����
      elsif target.hold.vagina.battler == active
        case target.hold.vagina.type
        when "���}��"
          case target.hold.vagina.parts
          when "�y�j�X"
            active.hold.penis.set(nil, nil, nil, nil)
          when "�K��"
            active.hold.tail.set(nil, nil, nil, nil)
          when "�G��"
            active.hold.tentacle.set(nil, nil, nil, nil)
          end
        when "��ʋR��"
          active.hold.mouth.set(nil, nil, nil, nil)
        when "�L���킹"
          active.hold.vagina.set(nil, nil, nil, nil)
          active.hold.anal.set(nil, nil, nil, nil)
          target.hold.anal.set(nil, nil, nil, nil)
        when "�N���j"
          active.hold.mouth.set(nil, nil, nil, nil)
        when "�G��N���j"
          active.hold.tentacle.set(nil, nil, nil, nil)
        when "�f�B���h���}��"
          active.hold.dildo.set(nil, nil, nil, nil)
        end
        target.hold.vagina.set(nil, nil, nil, nil)
      #��������
      elsif target.hold.mouth.battler == active
        case target.hold.mouth.type
        when "���}��"
          case target.hold.mouth.parts
          when "�y�j�X"
            active.hold.penis.set(nil, nil, nil, nil)
          when "�K��"
            active.hold.tail.set(nil, nil, nil, nil)
          when "�G��"
            active.hold.tentacle.set(nil, nil, nil, nil)
          end
        when "��ʋR��"
          active.hold.vagina.set(nil, nil, nil, nil)
        when "�K�R��"
          active.hold.anal.set(nil, nil, nil, nil)
        when "�N���j"
          active.hold.vagina.set(nil, nil, nil, nil)
        when "�L�b�X"
          active.hold.mouth.set(nil, nil, nil, nil)
        when "�f�B���h���}��"
          active.hold.dildo.set(nil, nil, nil, nil)
        end
        target.hold.mouth.set(nil, nil, nil, nil)
      #���A�i������
      elsif target.hold.anal.battler == active
        case target.hold.anal.type
        when "�K�}��"
          case target.hold.anal.parts
          when "�y�j�X"
            active.hold.penis.set(nil, nil, nil, nil)
          when "�K��"
            active.hold.tail.set(nil, nil, nil, nil)
          when "�G��"
            active.hold.tentacle.set(nil, nil, nil, nil)
          end
        when "�K�R��"
          active.hold.mouth.set(nil, nil, nil, nil)
        when "�f�B���h�K�}��"
          active.hold.dildo.set(nil, nil, nil, nil)
        end
        target.hold.anal.set(nil, nil, nil, nil)
      #���㔼�g����
      elsif target.hold.tops.battler == active
        case target.hold.tops.type
        when "�p�C�Y��"
          active.hold.penis.set(nil, nil, nil, nil)
        when "�ςӂς�"
          active.hold.mouth.set(nil, nil, nil, nil)
        when "�G��S��","�ӍS��"
          active.hold.tentacle.set(nil, nil, nil, nil)
        else
          active.hold.tops.set(nil, nil, nil, nil)
        end
        target.hold.tops.set(nil, nil, nil, nil)
      #���K������
      elsif target.hold.tail.battler == active
        case target.hold.tail.type
        when "���}��"
          active.hold.vagina.set(nil, nil, nil, nil)
        when "���}��"
          active.hold.mouth.set(nil, nil, nil, nil)
        when "�K�}��"
          active.hold.anal.set(nil, nil, nil, nil)
        end
        target.hold.tail.set(nil, nil, nil, nil)
      #���G�����
      elsif target.hold.tentacle.battler == active
        case target.hold.tentacle.type
        when "�G��z��"
          active.hold.penis.set(nil, nil, nil, nil)
        when "�G�聊�}��","�G��N���j"
          active.hold.vagina.set(nil, nil, nil, nil)
        when "�G����}��"
          active.hold.mouth.set(nil, nil, nil, nil)
        when "�G��K�}��"
          active.hold.anal.set(nil, nil, nil, nil)
        when "�G��S��","�ӍS��","�G��J�r"
          active.hold.tops.set(nil, nil, nil, nil)
        end
        target.hold.tentacle.set(nil, nil, nil, nil)
      #���f�B���h����
      elsif target.hold.dildo.battler == active
        case target.hold.dildo.type
        when "�f�B���h���}��"
          active.hold.vagina.set(nil, nil, nil, nil)
        when "�f�B���h���}��"
          active.hold.mouth.set(nil, nil, nil, nil)
        when "�f�B���h�K�}��"
          active.hold.anal.set(nil, nil, nil, nil)
        end
        target.hold.dildo.set(nil, nil, nil, nil)
      end
=end
    when "�C���^���v�g"
      #�����ΏۂɃz�[���h���L���X�g��t�^����
      target.add_state(12) if target.is_a?(Game_Enemy)
      if active == $game_actors[101]
        for i in $game_party.actors
          if i != $game_actors[101]
            hold_actor = i
          end
        end
      else
        hold_actor = $game_actors[101]
      end
      #�z�[���h�A�N�^�[�̃X�L���R���N�g������
      hold_actor.skill_collect = nil if hold_actor.is_a?(Game_Actor)
      # �z�[���h�̉����i���̋L�q�����\�b�h�Ɋȗ����j
      hold_release(target, hold_actor)
=begin
      #���y�j�X����
      if target.hold.penis.battler == hold_actor
        case target.hold.penis.type
        when "���}��"
          hold_actor.hold.vagina.set(nil, nil, nil, nil)
        when "���}��"
          hold_actor.hold.mouth.set(nil, nil, nil, nil)
        when "�K�}��"
          hold_actor.hold.anal.set(nil, nil, nil, nil)
        when "�p�C�Y��"
          hold_actor.hold.tops.set(nil, nil, nil, nil)
        when "�G��z��"
          hold_actor.hold.tentacle.set(nil, nil, nil, nil)
        end
        target.hold.penis.set(nil, nil, nil, nil)
      #���A�\�R����
      elsif target.hold.vagina.battler == hold_actor
        case target.hold.vagina.type
        when "���}��"
          case target.hold.vagina.parts
          when "�y�j�X"
            hold_actor.hold.penis.set(nil, nil, nil, nil)
          when "�K��"
            hold_actor.hold.tail.set(nil, nil, nil, nil)
          when "�G��"
            hold_actor.hold.tentacle.set(nil, nil, nil, nil)
          when "�f�B���h"
            hold_actor.hold.dildo.set(nil, nil, nil, nil)
          end
        when "��ʋR��"
          hold_actor.hold.mouth.set(nil, nil, nil, nil)
        when "�L���킹"
          hold_actor.hold.vagina.set(nil, nil, nil, nil)
          hold_actor.hold.anal.set(nil, nil, nil, nil)
          target.hold.anal.set(nil, nil, nil, nil)
        when "�N���j"
          hold_actor.hold.mouth.set(nil, nil, nil, nil)
        when "�G��N���j"
          hold_actor.hold.tentacle.set(nil, nil, nil, nil)
        end
        target.hold.vagina.set(nil, nil, nil, nil)
      #��������
      elsif target.hold.mouth.battler == hold_actor
        case target.hold.mouth.type
        when "���}��"
          case target.hold.mouth.parts
          when "�y�j�X"
            hold_actor.hold.penis.set(nil, nil, nil, nil)
          when "�K��"
            hold_actor.hold.tail.set(nil, nil, nil, nil)
          when "�G��"
            hold_actor.hold.tentacle.set(nil, nil, nil, nil)
          when "�f�B���h"
            hold_actor.hold.dildo.set(nil, nil, nil, nil)
          end
        when "�f�B���h���}��"
          hold_actor.hold.dildo.set(nil, nil, nil, nil)
        when "��ʋR��"
          hold_actor.hold.vagina.set(nil, nil, nil, nil)
        when "�K�R��"
          hold_actor.hold.anal.set(nil, nil, nil, nil)
        when "�N���j"
          hold_actor.hold.vagina.set(nil, nil, nil, nil)
        when "�L�b�X"
          hold_actor.hold.mouth.set(nil, nil, nil, nil)
        end
        target.hold.mouth.set(nil, nil, nil, nil)
      #���A�i������
      elsif target.hold.anal.battler == hold_actor
        case target.hold.anal.type
        when "�K�}��"
          case target.hold.anal.parts
          when "�y�j�X"
            hold_actor.hold.penis.set(nil, nil, nil, nil)
          when "�K��"
            hold_actor.hold.tail.set(nil, nil, nil, nil)
          when "�G��"
            hold_actor.hold.tentacle.set(nil, nil, nil, nil)
          when "�f�B���h"
            hold_actor.hold.dildo.set(nil, nil, nil, nil)
          end
        when "�f�B���h�K�}��"
          hold_actor.hold.dildo.set(nil, nil, nil, nil)
        when "�K�R��"
          hold_actor.hold.mouth.set(nil, nil, nil, nil)
        end
        target.hold.anal.set(nil, nil, nil, nil)
      #���㔼�g����
      elsif target.hold.tops.battler == hold_actor
        case target.hold.tops.type
        when "�p�C�Y��"
          hold_actor.hold.penis.set(nil, nil, nil, nil)
        when "�ςӂς�"
          hold_actor.hold.mouth.set(nil, nil, nil, nil)
        when "�G��S��","�ӍS��"
          hold_actor.hold.tentacle.set(nil, nil, nil, nil)
        else
          hold_actor.hold.tops.set(nil, nil, nil, nil)
        end
        target.hold.tops.set(nil, nil, nil, nil)
      #���K������
      elsif target.hold.tail.battler == hold_actor
        case target.hold.tail.type
        when "���}��"
          hold_actor.hold.vagina.set(nil, nil, nil, nil)
        when "���}��"
          hold_actor.hold.mouth.set(nil, nil, nil, nil)
        when "�K�}��"
          hold_actor.hold.anal.set(nil, nil, nil, nil)
        end
        target.hold.tail.set(nil, nil, nil, nil)
      #���G�����
      elsif target.hold.tentacle.battler == hold_actor
        case target.hold.tentacle.type
        when "�G��z��"
          hold_actor.hold.penis.set(nil, nil, nil, nil)
        when "�G�聊�}��","�G��N���j"
          hold_actor.hold.vagina.set(nil, nil, nil, nil)
        when "�G����}��"
          hold_actor.hold.mouth.set(nil, nil, nil, nil)
        when "�G��K�}��"
          hold_actor.hold.anal.set(nil, nil, nil, nil)
        when "�G��S��","�ӍS��","�G��J�r"
          hold_actor.hold.tops.set(nil, nil, nil, nil)
        end
        target.hold.tentacle.set(nil, nil, nil, nil)
      #���f�B���h����
      elsif target.hold.dildo.battler == hold_actor
        case target.hold.dildo.type
        when "�f�B���h���}��"
          hold_actor.hold.vagina.set(nil, nil, nil, nil)
        when "�f�B���h���}��"
          hold_actor.hold.mouth.set(nil, nil, nil, nil)
        when "�f�B���h�K�}��"
          hold_actor.hold.anal.set(nil, nil, nil, nil)
        end
        target.hold.dildo.set(nil, nil, nil, nil)
      end
=end
#    when "�X�g���O��"
    end
  end

  #--------------------------------------------------------------------------
  # �� �z�[���h�̉���
  #--------------------------------------------------------------------------
  def remove_hold(behavior,remover,type = nil)
#    remover = $msg.t_enemy
    
    case behavior
    when "�Ⓒ" #remover�͐Ⓒ�����L�����N�^�[
      # �z�[���h�̉����i���̋L�q�����\�b�h�Ɋȗ����j
      hold_release(remover, nil, 1)
=begin
      #�����Ώۂ��G�l�~�[�̏ꍇ�A�z�[���h���L���X�g��t�^����
      remover.add_state(12) if remover.is_a?(Game_Enemy)
      remover.skill_collect = nil if remover.is_a?(Game_Actor)
      remover.animation_id = 7
      remover.animation_hit = true
      remover.graphic_change = true
      #������
      if remover.hold.mouth.battler != nil
        target = remover.hold.mouth.battler
        #�����Ώۂ��G�l�~�[�̏ꍇ�A�z�[���h���L���X�g��t�^����
        target.add_state(12) if target.is_a?(Game_Enemy)
        case remover.hold.mouth.type
        when "���}��"
          #���}�����y�j�X�̏ꍇ
          if (target.hold.penis.battler == remover and target.hold.penis.type == "���}��")
            target.hold.penis.set(nil, nil, nil, nil)
          #���}�����K���̏ꍇ
          elsif (target.hold.tail.battler == remover and target.hold.tail.type == "���}��")
            target.hold.tail.set(nil, nil, nil, nil)
          #���}�����G��̏ꍇ
          elsif (target.hold.tentacle.battler == remover and target.hold.tentacle.type == "���}��")
            target.hold.tentacle.set(nil, nil, nil, nil)
          #���}�����f�B���h�̏ꍇ
          elsif (target.hold.dildo.battler == remover and target.hold.dildo.type == "���}��")
            target.hold.dildo.set(nil, nil, nil, nil)
          end
        when "�f�B���h���}��"
          target.hold.dildo.set(nil, nil, nil, nil)
        when "��ʋR��" #��R���d�|�����Ă���ꍇ
          target.hold.vagina.set(nil, nil, nil, nil)
          target.hold.anal.set(nil, nil, nil, nil)
        when "�N���j" #�N���j���d�|���Ă���ꍇ
          target.hold.vagina.set(nil, nil, nil, nil)
        when "�K�R��" #�K�R����d�|�����Ă���ꍇ
          target.hold.anal.set(nil, nil, nil, nil)
        when "�L�b�X" #�L�b�X���d�|�����Ă���ꍇ
          target.hold.mouth.set(nil, nil, nil, nil)
        end
        remover.hold.mouth.set(nil, nil, nil, nil)
        target.animation_id = 7
        target.animation_hit = true
        target.graphic_change = true
        target.skill_collect = nil if target.is_a?(Game_Actor)
      end
      #�A�\�R����
      if remover.hold.vagina.battler != nil
        target = remover.hold.vagina.battler
        #�����Ώۂ��G�l�~�[�̏ꍇ�A�z�[���h���L���X�g��t�^����
        target.add_state(12) if target.is_a?(Game_Enemy)
        case remover.hold.vagina.type
        when "���}��"
          #�A�\�R�}�����y�j�X�̏ꍇ
          if (target.hold.penis.battler == remover and target.hold.penis.type == "���}��")
            target.hold.penis.set(nil, nil, nil, nil)
          #�A�\�R�}�����K���̏ꍇ
          elsif (target.hold.tail.battler == remover and target.hold.tail.type == "���}��")
            target.hold.tail.set(nil, nil, nil, nil)
          #�A�\�R�}�����G��̏ꍇ
          elsif (target.hold.tentacle.battler == remover and target.hold.tentacle.type == "���}��")
            target.hold.tentacle.set(nil, nil, nil, nil)
          #�A�\�R�}�����f�B���h�̏ꍇ
          elsif (target.hold.dildo.battler == remover and target.hold.dildo.type == "���}��")
            target.hold.dildo.set(nil, nil, nil, nil)
          end
        when "�f�B���h���}��"
          target.hold.dildo.set(nil, nil, nil, nil)
        when "�L���킹"
          target.hold.vagina.set(nil, nil, nil, nil)
          target.hold.anal.set(nil, nil, nil, nil)
          remover.hold.anal.set(nil, nil, nil, nil)
        when "�N���j"
          target.hold.mouth.set(nil, nil, nil, nil)
        when "�G��N���j"
          target.hold.tentacle.set(nil, nil, nil, nil)
        when "��ʋR��" #��R���d�|���Ă���ꍇ
          target.hold.mouth.set(nil, nil, nil, nil)
          remover.hold.anal.set(nil, nil, nil, nil)
        end
        remover.hold.vagina.set(nil, nil, nil, nil)
        target.animation_id = 7
        target.animation_hit = true
        target.graphic_change = true
        target.skill_collect = nil if target.is_a?(Game_Actor)
      end
      #�y�j�X����
      if remover.hold.penis.battler != nil
        target = remover.hold.penis.battler
        #�����Ώۂ��G�l�~�[�̏ꍇ�A�z�[���h���L���X�g��t�^����
        target.add_state(12) if target.is_a?(Game_Enemy)
        case remover.hold.penis.type
        when "���}��"
          target.hold.vagina.set(nil, nil, nil, nil)
        when "���}��"
          target.hold.mouth.set(nil, nil, nil, nil)
        when "�K�}��"
          target.hold.anal.set(nil, nil, nil, nil)
        when "�p�C�Y��"
          target.hold.tops.set(nil, nil, nil, nil)
        when "�G��z��"
          target.hold.tentacle.set(nil, nil, nil, nil)
        end
        remover.hold.penis.set(nil, nil, nil, nil)
        target.animation_id = 7
        target.animation_hit = true
        target.graphic_change = true
        target.skill_collect = nil if target.is_a?(Game_Actor)
      end
      #�e������
      if remover.hold.anal.battler != nil
        target = remover.hold.anal.battler
        #�����Ώۂ��G�l�~�[�̏ꍇ�A�z�[���h���L���X�g��t�^����
        target.add_state(12) if target.is_a?(Game_Enemy)
        #�A�i���}�����y�j�X�̏ꍇ
        if (target.hold.penis.battler == remover and target.hold.penis.type == "�K�}��")
          target.hold.penis.set(nil, nil, nil, nil)
        #�A�i���}�����K���̏ꍇ
        elsif (target.hold.tail.battler == remover and target.hold.tail.type == "�K�}��")
          target.hold.tail.set(nil, nil, nil, nil)
        #�A�i���}�����G��̏ꍇ
        elsif (target.hold.tentacle.battler == remover and target.hold.tentacle.type == "�K�}��")
          target.hold.tentacle.set(nil, nil, nil, nil)
        #�A�i���}�����f�B���h�̏ꍇ
        elsif (target.hold.dildo.battler == remover and target.hold.dildo.type == "�K�}��")
          target.hold.dildo.set(nil, nil, nil, nil)
        end
        remover.hold.anal.set(nil, nil, nil, nil)
        target.animation_id = 7
        target.animation_hit = true
        target.graphic_change = true
        target.skill_collect = nil if target.is_a?(Game_Actor)
      end
      #�㔼�g�S������
      if remover.hold.tops.battler != nil
        target = remover.hold.tops.battler
        #�����Ώۂ��G�l�~�[�̏ꍇ�A�z�[���h���L���X�g��t�^����
        target.add_state(12) if target.is_a?(Game_Enemy)
        if (target.hold.tops.battler == remover and (target.hold.tops.type == "�S��" or target.hold.tops.type == "�J�r"))
          target.hold.tops.set(nil, nil, nil, nil)
        elsif (target.hold.tentacle.battler == remover and (target.hold.tops.type == "�G��S��" or target.hold.tops.type == "�G��J�r" or target.hold.tops.type == "�ӍS��"))
          target.hold.tentacle.set(nil, nil, nil, nil)
        elsif (target.hold.penis.battler == remover and target.hold.penis.type == "�p�C�Y��")
          target.hold.penis.set(nil, nil, nil, nil)
        elsif (target.hold.mouth.battler == remover and target.hold.mouth.type == "�ςӂς�")
          target.hold.mouth.set(nil, nil, nil, nil)
        end
        remover.hold.tops.set(nil, nil, nil, nil)
        target.animation_id = 7
        target.animation_hit = true
        target.graphic_change = true
        target.skill_collect = nil if target.is_a?(Game_Actor)
      end
      #�K������
      if remover.hold.tail.battler != nil
        target = remover.hold.tail.battler
        #�����Ώۂ��G�l�~�[�̏ꍇ�A�z�[���h���L���X�g��t�^����
        target.add_state(12) if target.is_a?(Game_Enemy)
        case remover.hold.tail.type
        when "���}��"
          target.hold.vagina.set(nil, nil, nil, nil)
        when "���}��"
          target.hold.mouth.set(nil, nil, nil, nil)
        when "�K�}��"
          target.hold.anal.set(nil, nil, nil, nil)
        end
        remover.hold.tail.set(nil, nil, nil, nil)
        target.animation_id = 7
        target.animation_hit = true
        target.graphic_change = true
        target.skill_collect = nil if target.is_a?(Game_Actor)
      end
      #�G��E�X���C������
      if remover.hold.tentacle.battler != nil
        target = remover.hold.tentacle.battler
        #�����Ώۂ��G�l�~�[�̏ꍇ�A�z�[���h���L���X�g��t�^����
        target.add_state(12) if target.is_a?(Game_Enemy)
        case remover.hold.tentacle.type
        when "�G��z��"
          target.hold.vagina.set(nil, nil, nil, nil)
        when "�G�聊�}��","�G��N���j"
          target.hold.vagina.set(nil, nil, nil, nil)
        when "�G����}��"
          target.hold.mouth.set(nil, nil, nil, nil)
        when "�G��K�}��"
          target.hold.anal.set(nil, nil, nil, nil)
        when "�G��S��","�ӍS��","�G��J�r"
          target.hold.tops.set(nil, nil, nil, nil)
        end
        remover.hold.tentacle.set(nil, nil, nil, nil)
        target.animation_id = 7
        target.animation_hit = true
        target.graphic_change = true
        target.skill_collect = nil if target.is_a?(Game_Actor)
      end
      #�f�B���h����
      if remover.hold.dildo.battler != nil
        target = remover.hold.dildo.battler
        #�����Ώۂ��G�l�~�[�̏ꍇ�A�z�[���h���L���X�g��t�^����
        target.add_state(12) if target.is_a?(Game_Enemy)
        case remover.hold.dildo.type
        when "�f�B���h���}��"
          target.hold.vagina.set(nil, nil, nil, nil)
        when "�f�B���h���}��"
          target.hold.mouth.set(nil, nil, nil, nil)
        when "�f�B���h�K�}��"
          target.hold.anal.set(nil, nil, nil, nil)
        end
        remover.hold.dildo.set(nil, nil, nil, nil)
        target.animation_id = 7
        target.animation_hit = true
        target.graphic_change = true
        target.skill_collect = nil if target.is_a?(Game_Actor)
      end
=end
    end
  end
end