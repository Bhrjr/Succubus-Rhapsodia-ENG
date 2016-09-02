#==============================================================================
# �� Game_Battler (������` 5)
#------------------------------------------------------------------------------
# �@�e�폈��
#   �E�����x����
#   �E�A�C�e�����ʏ���
#   �E�X���b�v�_���[�W����
#   �E�����v�Z����
#   �E�X�e�[�g�u���Łv����
#==============================================================================

class Game_Battler
  #--------------------------------------------------------------------------
  # �� �A�C�e���̌��ʓK�p
  #     item : �A�C�e��
  #--------------------------------------------------------------------------
  def item_effect(item)
    # �N���e�B�J���t���O���N���A
    self.critical = false
    # �A�C�e���̌��ʔ͈͂� HP 1 �ȏ�̖����ŁA������ HP �� 0�A
    # �܂��̓A�C�e���̌��ʔ͈͂� HP 0 �̖����ŁA������ HP �� 1 �ȏ�̏ꍇ
    # �i��҂͑���216�����Ă���Ζ����j
    if ((item.scope == 3 or item.scope == 4) and self.hp == 0) or
       ((item.scope == 5 or item.scope == 6) and self.hp >= 1 and not item.element_set.include?(216))
      # ���\�b�h�I��
      return false
    end
    # �L���t���O���N���A
    effective = false
    # �R�����C�x���g ID ���L���̏ꍇ�͗L���t���O���Z�b�g
    effective |= item.common_event_id > 0
    # ��������
    hit_result = (rand(100) < item.hit)
    # �s�m���ȃX�L���̏ꍇ�͗L���t���O���Z�b�g
    effective |= item.hit < 100
    # �����̏ꍇ
    if hit_result == true
      # �񕜗ʂ��v�Z
      recover_hp = maxhp * item.recover_hp_rate / 100 + item.recover_hp
      recover_sp = maxsp * item.recover_sp_rate / 100 + item.recover_sp
      if recover_hp < 0
        recover_hp += self.pdef * item.pdef_f / 20
        recover_hp += self.mdef * item.mdef_f / 20
        recover_hp = [recover_hp, 0].min
      end
      # �����C��
      recover_hp *= elements_correct(item.element_set)
      recover_hp /= 100
      recover_sp *= elements_correct(item.element_set)
      recover_sp /= 100
      # ���U
      if item.variance > 0 and recover_hp.abs > 0
        amp = [recover_hp.abs * item.variance / 100, 1].max
        recover_hp += rand(amp+1) + rand(amp+1) - amp
      end
      if item.variance > 0 and recover_sp.abs > 0
        amp = [recover_sp.abs * item.variance / 100, 1].max
        recover_sp += rand(amp+1) + rand(amp+1) - amp
      end
#      # �񕜗ʂ̕��������̏ꍇ
#      if recover_hp < 0
#        # �h��C��
#        if self.guarding?
#          recover_hp /= 2
#        end
#      end
      # HP �񕜗ʂ̕����𔽓]���A�_���[�W�̒l�ɐݒ�
      self.damage = -recover_hp
      # HP ����� SP ����
      last_hp = self.hp
      last_sp = self.sp
      self.hp += recover_hp
      self.sp += recover_sp
      # ���N���C�V�X����iVP���c���Ă��Ȃ��ꍇ�͔�΂��j
      if self.sp > 0 and self.hp > 0 and $game_temp.in_battle
        #�_���[�W�̏ꍇ
        if (self.hp < last_hp) and not self.states.include?(6)
          if self.hpp <= $mood.crisis_point(self) + rand(5)
            self.add_state(6)
          end
        #�񕜂̏ꍇ
        elsif $mood != nil and (self.hp > last_hp) and self.states.include?(6)
          if self.hpp >= $mood.crisis_point(self) + rand(5)
            self.remove_state(6)
            self.crisis_flag = false
          end
        end
      end
      #�F�D�x�̏㏸�i���蕨�A�C�e���̏ꍇ�j
      if self.is_a?(Game_Enemy) and item.parameter > 0 and item.element_set.include?(199)
        # ���蕨���܂��󂯎���Ă����ꍇ
        unless self.present_fully?
          last_friendly = self.friendly
          self.friendly += item.parameter
          self.present_count += 1
          eff_flag_friendly |= self.friendly != last_friendly
        end
      end
      # ���_��Ԃ��񕜂�������̂́A�����x���R�O�ȉ��̏ꍇ�ɂR�O�܂ŉ񕜂�����B
      if (item.scope == 5 or item.scope == 6) and recover_sp > 0
        last_fed = self.fed
        if self.fed < 30
          self.fed = 30
        end
        eff_flag_fed |= self.fed != last_fed
        # �퓬�����o�[�����t���b�V��
        $game_party.battle_actor_refresh
      end
      #�����x�̉�
      if self.is_a?(Game_Actor) and item.parameter > 0 and item.element_set.include?(119)
        last_fed = self.fed
        self.fed += item.parameter
        eff_flag_fed |= self.fed != last_fed
      end
      #���x���A�b�v
      if item.parameter > 0 and item.element_set.include?(201)
        last_level = self.level
        self.level += item.parameter
        eff_flag_level |= self.level != last_level
      end
      effective |= self.hp != last_hp
      effective |= self.sp != last_sp
      effective |= eff_flag_friendly
      effective |= eff_flag_fed
      effective |= eff_flag_level
      # �X�e�[�g�ω�
      # �A�C�e���ŃX�e�[�g�ω��𔭐�������ꍇ�͌ʂɐݒ�
      @state_changed = false
#      effective |= states_plus(item.plus_state_set)
      effective |= states_minus(item.minus_state_set)
      # �p�����[�^�㏸�l���L���̏ꍇ
      if item.parameter_type > 0 and item.parameter_points != 0
        # �p�����[�^�ŕ���
        case item.parameter_type
        when 1  # MaxHP
          @maxhp_plus += item.parameter_points
        when 2  # MaxSP
          @maxsp_plus += item.parameter_points
        when 3  # �r��
          @str_plus += item.parameter_points
        when 4  # ��p��
          @dex_plus += item.parameter_points
        when 5  # �f����
          @agi_plus += item.parameter_points
        when 6  # ����
          @int_plus += item.parameter_points
        end
        # �L���t���O���Z�b�g
        effective = true
      end
      # HP �񕜗��Ɖ񕜗ʂ� 0 �̏ꍇ
      if item.recover_hp_rate == 0 and item.recover_hp == 0
        # �_���[�W�ɋ󕶎����ݒ�
        self.damage = ""
        # SP �񕜗��Ɖ񕜗ʂ� 0�A�p�����[�^�㏸�l�������̏ꍇ
        if item.recover_sp_rate == 0 and item.recover_sp == 0 and
           (item.parameter_type == 0 or item.parameter_points == 0)
          # �X�e�[�g�ɕω����Ȃ��ꍇ
          if not @state_changed and not eff_flag_friendly and not eff_flag_fed and not eff_flag_level
            # �_���[�W�� "Miss" ��ݒ�
            self.damage = "Miss"
          end
        end
      end
    # �~�X�̏ꍇ
    else
      # �_���[�W�� "Miss" ��ݒ�
      self.damage = "Miss"
    end
    # �퓬���łȂ��ꍇ
    unless $game_temp.in_battle
      # �_���[�W�� nil ��ݒ�
      self.damage = nil
    end
    # ���\�b�h�I��
    return effective
  end
  #--------------------------------------------------------------------------
  # �� �X���b�v�_���[�W�̌��ʓK�p
  #--------------------------------------------------------------------------
  def slip_damage_effect
    # �_���[�W��ݒ�
    self.damage = self.maxhp / 10
    # ���U
    if self.damage.abs > 0
      amp = [self.damage.abs * 15 / 100, 1].max
      self.damage += rand(amp+1) + rand(amp+1) - amp
    end
    # HP ����_���[�W�����Z
    self.hp -= self.damage
    # ���\�b�h�I��
    return true
  end
  #--------------------------------------------------------------------------
  # �� �����C���̌v�Z
  #     element_set : ����
  #--------------------------------------------------------------------------
  def elements_correct(element_set)
    # �������̏ꍇ
    if element_set == []
      # 100 ��Ԃ�
      return 100
    end
    # �^����ꂽ�����̒��ōł��ア���̂�Ԃ�
    # �����\�b�h element_rate �́A���̃N���X����p������� Game_Actor
    #   ����� Game_Enemy �N���X�Œ�`�����
    weakest = -100
    for i in element_set
      weakest = [weakest, self.element_rate(i)].max
    end
    return weakest
  end
  #--------------------------------------------------------------------------
  # �� ���ŕt�^��(�l�C�W�������W��p����)
  #    target : �t�^�Ώ�
  #--------------------------------------------------------------------------
  def special_mushroom(target)
    
    # ���łɈ��łł���ꍇ�A���\�b�h�I��
    return if target.state?(30)
    
    # ���ł�ϐ��v�Z�L��ŕt�^
    target.add_state(30,false,true)
    # ���ł��t�^�ł��Ă��Ȃ��ꍇ�A���\�b�h�I��
    return unless target.state?(30)
    
    # �����ł�����̂�ϐ����݂Ō���
    bs = [37,39,40]
    # ���E
    registance = target.state_percent(nil, 37, nil)
    if target.states.include?(37) or rand(100) >= registance
      bs.delete(37) 
    end
    # ���
    registance = target.state_percent(nil, 39, nil)
    if target.states.include?(39) or rand(100) >= registance
      bs.delete(39) 
    end
    # �U��
    registance = target.state_percent(nil, 40, nil)
    if target.states.include?(40) or rand(100) >= registance
      bs.delete(40) 
    end
    
    # �����ł�����̂��Ȃ��ꍇ�A���\�b�h�I��
    return if bs == []
    
    # �����ł�����̂̒�����P�I��ł��̃X�e�[�g��t�^
    bs = bs[rand(bs.size)]
    target.add_state(bs)

  end
  #--------------------------------------------------------------------------
  # �� �j�ʂ̕���
  #--------------------------------------------------------------------------
  def persona_break
    
    # �����ł�����̂�ϐ����݂Ō���
    bs = [35,36,38,40]
    # �~��
    registance = self.state_percent(nil, 35, nil)
    if self.states.include?(35) or rand(100) >= registance
      bs.delete(35) 
    end
    # �\��
    registance = self.state_percent(nil, 36, nil)
    if self.states.include?(36) or rand(100) >= registance
      bs.delete(36) 
    end
    # �ؕ|
    registance = self.state_percent(nil, 38, nil)
    if self.states.include?(38) or rand(100) >= registance
      bs.delete(38) 
    end
    # �U��
    registance = self.state_percent(nil, 40, nil)
    if self.states.include?(40) or rand(100) >= registance
      bs.delete(40) 
    end
    
    # �����ł�����̂��Ȃ��ꍇ�A���\�b�h�I��
    return if bs == []
    
    # �����ł�����̂̒�����P�I��ł��̃X�e�[�g��t�^
    bs = bs[rand(bs.size)]
    self.add_state(bs)
  end
  #--------------------------------------------------------------------------
  # �� �L�X�X�C�b�`�n�m�H
  #--------------------------------------------------------------------------
  def kiss_switch_on?
    return self.state?(97)
  end

end