#==============================================================================
# �� Talk_Sys
#------------------------------------------------------------------------------
#   �����̌���������A�\�����邽�߂̃N���X�ł��B
#   ���̃N���X�̃C���X�^���X�� $msg �ŎQ�Ƃ���܂��B
# 
#==============================================================================
class Talk_Sys
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
  attr_accessor :callsign                 # ����Ăяo���L�[
  attr_accessor :talk_step                # ����X�e�b�v
  attr_accessor :tag                      # ��b�^�O(�V�`���G�[�V�����w��p)
  attr_accessor :t_enemy                  # ���ݒ����Ă��閲��
  attr_accessor :t_target                 # ����ΏۂɂȂ�A�N�^�[
  attr_accessor :t_partner                # �ΏۈȊO�̃A�N�^�[
  attr_accessor :age                      # ����ΏۂƂ̔N�(�����|����)
  attr_accessor :age2                     # ����Ώۂ̑����Ƃ̔N�(�����|����)
  attr_accessor :age3                     # �A�g���鑊��Ƃ̔N�(�����|����)
  attr_accessor :text1                    # ��������1
  attr_accessor :text2                    # ��������2
  attr_accessor :text3                    # ��������3
  attr_accessor :text4                    # ��������4
  attr_accessor :coop_enemy               # �A�g�U���Q���G�l�~�[
  attr_accessor :coop_leader              # �A�g���J�n��������
  attr_accessor :at_type                  # �U���^�C�v(�ǌ��X�L���I��p)
  attr_accessor :at_parts                 # �U������(�ǌ��X�L���I��p)
  attr_accessor :favorably                # �D���x�̉�b�e���x
  attr_accessor :resist_flag              # ���W�X�g�Q�[�������t���O
  attr_accessor :moody_flag               # ���[�h�ϓ��t���O
  attr_accessor :battlelogwindow_dispose  # �o�g�����O�E�B���h�E�̏���
  attr_accessor :stateswindow_refresh     # �X�e�[�^�X�E�B���h�E�̍X�V
  attr_accessor :skillwindow_change       # �X�L���E�B���h�E�̖��̕ύX
  attr_accessor :talk_command_type        # �g�[�N���
  attr_accessor :talking_ecstasy_flag     # �g�[�N���Ⓒ�t���O
  attr_accessor :hold_pops_refresh        # �g�[�N���z�[���h�󋵕ύX�t���O
  attr_accessor :hold_initiative_refresh  # �g�[�N���z�[���h�D�ʍX�V�t���O
  attr_accessor :befor_talk_action        # �g�[�N���̒��O�s���Ǘ�
  attr_accessor :weakpoints               # �g�[�N����_�˂��t���O
  attr_accessor :chain_attack             # �g�[�N�����ꕔ�ʘA���t���O
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  def initialize
    @callsign = 99
    @talk_step = 0 #��{��0�A�ǌ���Ⓒ�ȂǏ󋵂��ς��ꍇ�ɕϓ�����
    @tag = ""
    @t_enemy = nil
    @t_target = nil
    @t_partner = nil
    @coop_leader = nil
    @age = 0
    @age2 = 0
    @age3 = 0
    @text1 = ""
    @text2 = ""
    @text3 = ""
    @text4 = ""
    @coop_enemy = []
    @msg = Array.new(300)
    # �b�菈���i�R�����j
    for i in 0...@msg.size
      @msg[i] = Db_Lessersuccubus_A.new
    end
    @msg[5] = Db_Lessersuccubus_A.new
    @msg[6] = Db_Lessersuccubus_B.new
    @msg[10] = Db_Succubus_A.new
    @msg[11] = Db_Succubus_B.new
    @msg[21] = Db_Imp_A.new
    @msg[26] = Db_Devil_A.new
    @msg[37] = Db_Petitwitch_A.new
    @msg[38] = Db_Petitwitch_B.new
    @msg[42] = Db_Witch_A.new
    @msg[43] = Db_Witch_B.new
    @msg[53] = Db_Cast_A.new
    @msg[74] = Db_Nightmare_A.new
    @msg[80] = Db_Slime_A.new
    @msg[96] = Db_Familiar_A.new
    @msg[100] = Db_Werewolf_A.new
    @msg[253] = Db_Fulbeua.new
    #���i�Œǉ��Ԃ�

    
    @msg[15] = Db_Succubuslord_A.new
    @msg[16] = Db_Succubuslord_B.new
    @msg[22] = Db_Imp_B.new
    @msg[27] = Db_Devil_B.new
    @msg[31] = Db_Daemon_A.new
    @msg[32] = Db_Daemon_B.new
    @msg[54] = Db_Cast_B.new
    @msg[63] = Db_Slave_A.new
    @msg[75] = Db_Nightmare_B.new
    @msg[90] = Db_Goldslime_A.new
    @msg[97] = Db_Familiar_B.new
    @msg[101] = Db_Werewolf_B.new
    @msg[104] = Db_Werecat_A.new
    @msg[105] = Db_Werecat_B.new
    @msg[108] = Db_Goblin_A.new
    @msg[111] = Db_Gangcommander_A.new
    @msg[118] = Db_Priestess_A.new
    @msg[122] = Db_Cursemagus_A.new
    @msg[126] = Db_Alraune_A.new
    @msg[127] = Db_Alraune_B.new
    @msg[133] = Db_Matango_A.new
    @msg[137] = Db_Darkangel_A.new
    @msg[141] = Db_Gargoyle_A.new
    @msg[145] = Db_Mimic_A.new
    @msg[146] = Db_Mimic_B.new
    @msg[152] = Db_Tamamo_A.new
    @msg[156] = Db_Lilim_A.new
    
    @msg[251] = Db_Neijurange.new
    @msg[252] = Db_Rejeo.new
    @msg[254] = Db_Gilgoon.new
    @msg[255] = Db_Youganot.new
    @msg[256] = Db_Shilphe.new
    @msg[257] = Db_Rarmil.new
    @msg[258] = Db_Vermiena.new
    
    #���i�ł����܂�
    @at_type  = ""
    @at_parts = ""
    @favorably = 0
    @resist_flag = false
    @moody_flag = false
    @keep_flag = false
    @battlelogwindow_dispose = false
    @stateswindow_refresh = false
    @talk_command_type = ""
    @skillwindow_change = nil
    @talking_ecstasy_flag = nil
    @hold_pops_refresh = nil
    @hold_initiative_refresh = []
    @befor_talk_action = []
    @weakpoints = 0
    @chain_attack = false
  end
  #--------------------------------------------------------------------------
  # �� �Q�̖��O�̕��������v�l�ŉ��s���K�v����Ԃ�
  #--------------------------------------------------------------------------
  def two_names_line_break(two_names_size)
    text = ""
    text = "\n" if two_names_size / 3 > 12
    return text
  end
  #--------------------------------------------------------------------------
  # �� ���O�Z�k
  #--------------------------------------------------------------------------
  def short_name(battler)
    #��l��(�f�t�H���g��)�A���j�[�N�L�����N�^�[�͈��̂�Ԃ�
    case battler.name
    when "���E���b�g","���[�����X"
      return "���E"
    when "�l�C�W�������W"
      return "�l�C�W�["
    when "���W�F�I"
      return "���Y"
    when "�t���r���A"
      return "���r�B"
    when "���[�K�m�b�g"
      return "���[�m"
    when "�M���S�[��"
      return "�M��"
    when "�V���t�F"
      return "�V���t�F"
    when "���[�~��"
      return "���[�~��"
    when "���F���~�B�[�i"
      return "�~�B�[�i"
    end
    call_name = ""
    s_name = battler.name.split("")
    count = 0
    #�Q�����ڂ��u�~�v�ŁA�S�̂��S�������z����ꍇ���̉�����i�u���~�B�v�j
    if s_name[1] == "�~" and s_name.size > 4
      call_name = s_name[0] + "�~�B"
      return call_name
    end
    #���̖��O���S�����ȓ��Ȃ炻�̂܂ܕԂ�
    return battler.name if s_name.size < 5 
    for i in 0..s_name.size - 1
      if count >= 3
        if ("�@�B�D�F�H�������[��������������".include?(s_name[i]) == false)
          return call_name
        elsif ("�@�B�D�F�H�������[��������������".include?(s_name[i]) == true)
          call_name += s_name[i]
          return call_name
        end
      else
        call_name += s_name[i]
        if ("�@�B�D�F�H��������������������".include?(s_name[i]) == false)
          count += 1
          if count >= 3 and ("�b��".include?(s_name[i]) == true)
            count -= 1
          end
        end
      end
    end
    return call_name
  end
  #--------------------------------------------------------------------------
  # �� �}�b�v����؂�ւ�
  #--------------------------------------------------------------------------
  def mapchat_manage
    #�}�b�v�C�x���g��41�A�`���b�g��42
    if ($game_switches[85] == true or
      $game_switches[86] == true or
      $game_switches[87] == true or
      $game_switches[88] == true or
      @tag == "�����N�A�b�v")
      @callsign = 41
    #���̑�
    else
      @callsign = 42
    end    
  end
  #--------------------------------------------------------------------------
  # �� �N��E�푰����擾
  #--------------------------------------------------------------------------
  def age_check
    #�b����A�󂯎肪�����łȂ����Ƃ��őO��
    if @t_enemy != @t_target
      #�b�������ƁA�󂯎�̔N����擾����
#      p "@t_enemy�F#{@t_enemy.name}�^@t_target�F#{@t_target.name}"
      e_years = $data_SDB[@t_enemy.class_id].years_type
      t_years = $data_SDB[@t_target.class_id].years_type
      @age = (e_years - t_years)
    #����ȊO�̏ꍇ��Age��0�̃t���b�g��Ԃɖ߂�
    else
      @age = 0
    end
    #��b�̎傪��l���̏ꍇ�A�����Ŗ߂�
    return if @t_enemy == $game_actors[101]
    #���݂ȃp�[�g�i�[����ɂ���ꍇ
    n = 0
    for i in $game_party.actors
      if i.exist?
        n += 1
      end
    end
    if n == 2 and @t_partner != nil
      e_years = $data_SDB[@t_enemy.class_id].years_type
      t_years = $data_SDB[@t_partner.class_id].years_type
      @age2 = (e_years - t_years)
    #�p�[�g�i�[�����Ȃ��ꍇ�A���邢�͓|��Ă���ꍇ�͊֘A���ڂ����Z�b�g����
    else
      @age2 = 0
    end
    #�A�g���������Ă���ꍇ
    if @coop_leader != nil
      #��b�Ώۂƃ��[�_�[���ʂ̏ꍇ�A�N����擾����
      if @coop_leader != @t_enemy
        e_years = $data_SDB[@t_enemy.class_id].years_type
        t_years = $data_SDB[@coop_leader.class_id].years_type
        @age3 = (e_years - t_years)
      end
    else
      @age3 = 0
    end
  end
  #--------------------------------------------------------------------------
  # �� ����Ăяo���L�����N�^�[�I��
  #--------------------------------------------------------------------------
  def prepare
    #���I��ς݃X�e�b�v���ݒ肳��Ă���ꍇ�͔�΂�
    #==============================================================================#
    #  ��ɐ퓬���̓���(�s���Ώۂ����m�łȂ�)��}�b�v��̐��̌���œK�p�����
    if (@talk_step == 100 or
      @tag == "�퓬�J�n" or
      @tag == "�_��" or
      @tag == "��" or
      @tag == "���̌���" or
      @tag == "�����N�A�b�v" or
      (@coop_enemy != [] and @coop_enemy.size > 1)
      )
      #��t_target�At_enemy���ݒ肳��ĂȂ��ꍇ�͍Đݒ肷��
      #  t_enemy�Ɋւ���o�O�́A�����ʂ��Ƌt�ɍ���̂ŃX���[
      if @t_target == nil
        if $game_temp.in_battle
          #����{�ݒ�ǂݍ���
          active = $game_temp.battle_active_battler
          target = $game_temp.battle_target_battler[0]
          if active != nil and target != nil
            if active.is_a?(Game_Actor)
              @t_target = active
            elsif active.is_a?(Game_Enemy)
              @t_target = target
            end
          #�s���Ώۂ����m�łȂ��ꍇ�́A�^�[�Q�b�g����l����
          else
            @t_target = $game_actors[101]
          end
        #�}�b�v��̓^�[�Q�b�g����l����
        else
          @t_target = $game_actors[101]
        end
      end
      #����b����G�l�~�[�̍D���x���x�����Z�肵�Ă���߂�
      speak_favorably
      return
    end
    #==============================================================================#
    #���퓬���̃^�[�Q�b�g�F������
    if $game_temp.in_battle
      #����{�ݒ�ǂݍ���
      active = $game_temp.battle_active_battler
      target = $game_temp.battle_target_battler[0]
      #�_��t�F�C�Y�̏ꍇ�A�g�[�N���̏ꍇ�A�K����l����b�̎��ɂ���
      if @tag == "�_��" or $game_switches[79] == true
        if active.is_a?(Game_Actor)
          @t_enemy = target
          @t_target = $game_actors[101]
        elsif active.is_a?(Game_Enemy)
          @t_enemy = active
          @t_target = $game_actors[101]
        end
      # �������s�̏ꍇ�A��l����b�̎��ɂ��A��b�ł���G�l�~�[���烉���_���őI��
      elsif @tag == "�������s"
        talk = []
        for enemy in $game_troop.enemies
          if enemy.talkable?
            talk.push(enemy)
          end
        end
        @t_enemy = talk[rand(talk.size)]
        @t_target = $game_actors[101]
      else
        #�p�[�e�B�Ō��݂Ȃ̂���l���̂�(���邢�͍ŏ������l��)�̏ꍇ�A��l����b�̎��ɂ���
        ct = 0
        if $game_party.party_actors.size == 1
          ct = 0
        #�p�[�e�B�����݂���ꍇ
        else
          #�Ⓒ�C�x���g���͕K���Ō�܂ŃJ�E���g�𑶑�������(@0831)
          if $game_switches[77] == true
            ct = 1
          #�Ⓒ�C�x���g�Ŗ����ꍇ�́A��ɗ����Ă���L�������J�E���g
          else
            for i in $game_party.party_actors
              if i.exist? and i != $game_actors[101]
                ct += 1
              end
            end
          end
        end
        #��l���ȊO�Ƀp�[�g�i�[�����݂Ȃ�ʏ폈��
        if ct > 0
          if active.is_a?(Game_Actor)
            @t_enemy = target
            @t_target = active
          elsif active.is_a?(Game_Enemy)
            @t_enemy = active
            @t_target = target
          end
        else
          if active.is_a?(Game_Actor)
            @t_enemy = target
            @t_target = $game_actors[101]
          elsif active.is_a?(Game_Enemy)
            @t_enemy = active
            @t_target = $game_actors[101]
          end
        end
      end
      #�p�[�g�i�[����xnil�ɖ߂�
      @t_partner = nil
      if $game_party.actors.size == 2
        for i in $game_party.actors
          if i.exist? and not i == @t_target
            @t_partner = i
          end
        end
      end
#      p "@t_enemy�F#{@t_enemy.name}�^@t_target�F#{@t_target.name}"if $DEBUG
      #���������g��ΏۂɎ��X�L���̏ꍇ�A��b���鑊��������_���Ŏ擾
      if @t_enemy == @t_target
        #���s�������A�N�^�[�̏ꍇ�A���݂Ȗ������擾
        if @t_enemy.is_a?(Game_Actor)
          #���i�K�ŉ�b�\�Ȗ����������_���Ɏ擾
          talk = []
          for i in $game_troop.enemies
            if i.talkable? or i.berserk == true
              talk.push(i)
            end
          end
          #��b�\�Ȗ��������Ȃ������ꍇ�A�������Ăяo���ĕԂ�
          #�p�[�g�i�[�����̕Ԃ��͂�����l���邩��
          if talk == []
            @talk_step = 99 #��b�񐬗��X�e�b�v
            @text1 = @text2 = @text3 = @text4 = ""
            return @text1 = "�u�c�c�c�c�c�v"
          end
          #��b�\�Ȗ������g�[�N�G�l�~�[�ɐݒ�
          @t_enemy = talk[rand(talk.size)]
        #���s�������G�l�~�[�̏ꍇ�A���݂ȃA�N�^�[���擾
        elsif @t_target.is_a?(Game_Enemy)
          #��l����l���̏ꍇ�A�K����l����ݒ�
          if $game_party.party_actors.size == 1
            @t_target = $game_actors[101]
          #�p�[�g�i�[�����݂���ꍇ�A���݂ȃA�N�^�[���烉���_���őI��
          else
            talk = []
            for i in $game_party.actors
              talk.push(i) if i.exist?
            end
            @t_target = talk[rand(talk.size)]
          end
        end
      end
    #==============================================================================#
    #���}�b�v���̃^�[�Q�b�g�F������
    else
      #�}�b�v���Ɍ�����R�[�����ꂽ�ꍇ�A�}�b�v���p�R�[���T�C�����Ă�
      mapchat_manage
      #���p�[�g�i�[�������P�l�ȏ�p�[�e�B�ɋ���΃����_���Őݒ�
      #  ���E�N�͕K��������ɂȂ�
      if $game_party.party_actors.size != 1
        @talk_step = 0 #��b�񐬗��X�e�b�v��߂�
        @t_target = $game_actors[101]
        @t_enemy = ""
        loop do
          n = rand($game_party.party_actors.size)
          if $game_party.party_actors[n] != $game_actors[101]
            @t_enemy = $game_party.party_actors[n]
            break
          end
        end
      #�p�[�e�B���P�l�̏ꍇ�A���E�N�̖�����ݒ肵�ďI��
      else
        @talk_step = 99 #��b�񐬗��X�e�b�v
        @t_enemy = @t_target = $game_actors[101]
        @text1 = @text2 = @text3 = @text4 = ""
        return @text1 = "�u�c�c�c�c�c�v"
      end
    end
    #����b�G�l�~�[���m�肵����D���x���x�����Z�o���Ė߂�
    speak_favorably
  end
  #--------------------------------------------------------------------------
  # �� �Ⓒ���Q���L�����J�E���g(���łɃR�[���T�C�����ݒ�)
  #--------------------------------------------------------------------------
  def ecstasy_member_check
    #�A�N�^�[�̍U���ŃG�l�~�[���Ⓒ�����ꍇ
    if $game_temp.battle_active_battler.is_a?(Game_Actor)
      @t_enemy = $game_temp.battle_target_battler[0]
      @t_target = $game_temp.battle_active_battler
      #�R�[���T�C���ݒ�(�������Ⓒ�̂�)
      if @t_target == $game_actors[101]
        @callsign = 2
        @callsign = 12 if $game_switches[85]
      else
        @callsign = 22
        @callsign = 32 if $game_switches[85]
      end
    #�G�l�~�[�̍U���ŃA�N�^�[���Ⓒ�����ꍇ
    elsif $game_temp.battle_active_battler.is_a?(Game_Enemy)
      @t_enemy = $game_temp.battle_active_battler
      @t_target = $game_temp.battle_target_battler[0]
      #�p�[�g�i�[����xnil�ɖ߂�
      @t_partner = nil
      if $game_party.actors.size == 2
        for i in $game_party.actors
          if i.exist? and not i == @t_target
            @t_partner = i
          end
        end
      end
      #�ΏۂƗ�����ԁA���邢�͑Ώۂ��z�[���h�Ŏ����͔�z�[���h�̏ꍇ
      #�ʂ̃z�[���h��Ԃ̑Ώۂ���ˍ��݂�����
      #�ǂ��炩�𖞂����Ă���i�K�ŃG�l�~�[�͂Q�̈ȏ�Ȃ̂ŁA
      #�P�̂��ۂ��̃`�F�b�N�͓���Ȃ�
      if @t_target.dancing? or not @t_enemy.holding_now?
        count = []
        count.push(@t_target.hold.penis.battler) if @t_target.hold.penis.battler != nil
        count.push(@t_target.hold.mouth.battler) if @t_target.hold.mouth.battler != nil
        count.push(@t_target.hold.anal.battler) if @t_target.hold.anal.battler != nil
        count.push(@t_target.hold.tops.battler) if @t_target.hold.tops.battler != nil
        count.push(@t_target.hold.vagina.battler) if @t_target.hold.vagina.battler != nil
        count.push(@t_target.hold.tail.battler) if @t_target.hold.tail.battler != nil
        count.push(@t_target.hold.dildo.battler) if @t_target.hold.dildo.battler != nil
        count.push(@t_target.hold.tentacle.battler) if @t_target.hold.tentacle.battler != nil
        count.delete(@t_enemy) if count.include?(@t_enemy)
        #�A�g�������P�̈ȏ�Ȃ�A�z����V���b�t�����ēo�^����
        if count.size > 0
          #�J�n���̃G�l�~�[�����[�_�[�Ƃ��ēo�^����
          @coop_leader = @t_enemy
          count.shuffle!
          @coop_enemy.push(@t_enemy)
          for i in 0..count.size - 1
            @coop_enemy.push(count[i])
          end
        else
          @coop_leader = nil
          @coop_enemy = []
        end
      else
        @coop_leader = nil
        @coop_enemy = []
      end
      #�R�[���T�C���ݒ�(�z�[���h���ۂ����`�F�b�N)
      if @t_target == $game_actors[101]
        if @t_enemy.holding_now?
          @callsign = 0
          @callsign = 10 if $game_switches[85]
        else
          @callsign = 1
          @callsign = 11 if $game_switches[85]
        end
      else
        if @t_enemy.holding_now?
          @callsign = 20
          @callsign = 30 if $game_switches[85]
        else
          @callsign = 21
          @callsign = 31 if $game_switches[85]
        end
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �Ⓒ������
  #    ����F���}���锽���E�ǂ�����(���ʂ̔������܂�)
  #    ���{�F�����锽���E��������
  #--------------------------------------------------------------------------
  def ecstasy_emotion
    emotion = []
    #���i�Ńx�[�X�����ݒ�
    case @t_enemy.personality
    when "�z�C"
      emotion.push("��","��","��","�{")
    when "�Ӓn��"
      emotion.push("��","�{","�{","�{")
    when "�D�F"
      emotion.push("��","��","��","�{")
    when "�V�R"
      emotion.push("��","��","��","�{")
    when "���C"
      emotion.push("��","��","�{","�{")
    when "�s�v�c"
      emotion.push("��","��","��","�{")
    when "�����C"
      emotion.push("��","��","�{","�{")
    when "����"
      emotion.push("��","�{","�{","�{")
    when "��i"
      emotion.push("��","�{","�{","�{")
    when "�Â���"
      emotion.push("��","��","��","�{")
    when "�]��"
      emotion.push("��","��","��","�{")
    when "�W��"
      emotion.push("��","��","��","�{")
    when "�_�a"
      emotion.push("��","��","��","�{")
    when "����"
      emotion.push("��","�{","�{","�{")
    when "�|��"
      emotion.push("��","��","�{","�{")
    else
      emotion.push("��","��","�{","�{")
    end
    #�푰�Œǉ������ݒ�
    case $data_SDB[@t_enemy.class_id].name
    #��̂�
    when "�X���C��","�S�[���h�X���C��","�X���C��","�t�@�~���A"
      emotion.push("��","��","��","��","��","��")
    #�삪����
    when "�T�L���o�X���[�h","�^�}��","�~�~�b�N","�i�C�g���A"
      emotion.push("��","��","��","��","��","�{")
    #��̌X��
    when "�T�L���o�X","�f�[����","�E�B�b�`","�A�����E�l"
      emotion.push("��","��","��","��","�{","�{")
    #�{�̌X��
    when "�v�`�E�B�b�`","�S�u����","�K�[�S�C��"
      emotion.push("��","��","�{","�{","�{","�{")
    #�{������
    when "���[�E���t","�J�[�X���C�K�X"
      emotion.push("��","�{","�{","�{","�{","�{")
    #�{�̂�
    when "�v���[�X�e�X"
      emotion.push("�{","�{","�{","�{","�{","�{")
    #����ȊO(�������炢�̊��o)
    else
      emotion.push("��","��","��","�{","�{","�{")
    end
    #�o��
    @t_enemy.ecstasy_emotion = emotion[rand(emotion.size)]
    return
  end
  #============================================================================
  # ������̍D���x����
  #============================================================================
  def speak_favorably
    return if @t_target == nil or @t_enemy == nil
    if $game_temp.in_battle
      mood_rate = ecst_count = 0
      #���[�h�␳(�T���݂łP�㏸�A�ő�Q�O)
      if $mood.point > 0
        mood_rate += ($mood.point / 5).floor
      end
      #�Ⓒ�񐔕␳�F����(�P�񂲂ƂɂT�㏸�A�ő�P�T)
      if @t_target.ecstasy_count.size > 0
        ext = @t_target.ecstasy_count.size
        ecst_count += [(ext * 5), 15].min
      end
      #�Ⓒ�񐔕␳�F����(�P�񂲂ƂɂP�O�㏸�A�ő�R�O)
      if @t_enemy.ecstasy_count.size > 0
        ext2 = @t_enemy.ecstasy_count.size
        ecst_count += [(ext2 * 10), 30].min
      end
      #�����̍D���x�ɏ�L�␳�����Z�A70�Ŋ������l(�[���؂�グ)���D���x�����N�ƂȂ�
      #�����N�̗��_�ō��l�͂T�Ƃ���
      @favorably = @t_enemy.love + mood_rate + ecst_count
      @favorably = (@favorably / 70).ceil
      @favorably = [[@favorably, 1].max, 5].min
    else
      #�}�b�v���͖����̍D���x�݂̂���Ƃ��A50�Ŋ������l(�[���؎̂�)�{�P�������N�ƂȂ�
      #�����N�̍ō��l�͂T�Ƃ���
      @favorably = (@t_enemy.love / 50).floor + 1
      @favorably = [[@favorably, 1].max, 5].min
    end
  end
  #--------------------------------------------------------------------------
  # �� ���i�ʌ���̍ŏI����
  #--------------------------------------------------------------------------
  def adjust(ms)
    return if ms == []
    ms2 = ms.clone
    ct = ms.size - 1
#    p "ms2"
#    p ms2
    for i in 0..ct
#      if ms[i].values[0] == ""
      if ms[i]["tx1"] == "" or ms[i] == {} or (ms[i]["tx1"] == "�u�c�c�c�c\\H�v" and i > 0)
        ms2.delete(ms2[i])
      end
    end
    return if ms2 == []
    if ms2.size > 1 and $game_temp.in_battle #��b����ȊO�ɂP�ȏ�󔒂łȂ����オ�����Ă���ꍇ
      ms2[0] = nil 
      ms2.compact! 
#      ms2.delete(ms2[0]) if $game_temp.in_battle # �d�����Ă���ƑS��������
    end
    #���e�L�X�g�������_���Ɋi�[
    #  �L�[��"tx"�Ȃ�e�L�X�g�i�[�A"md"�Ȃ烀�[�h�A�b�v�p�^�[���ǂݏo��
    ms = ms2[rand(ms2.size)]
    last_number = 0
    for i in 0..(ms.size - 1)
      if ms.values[i] != nil
        case ms.keys[i]
        when "md"
          moody_count(ms.values[i])
          @moody_flag = true
        when "tx1"
          @text1 = ms.values[i]
          last_number = 1 if last_number < 1
        when "tx2"
          @text2 = ms.values[i]
          last_number = 2 if last_number < 2
        when "tx3"
          @text3 = ms.values[i]
          last_number = 3 if last_number < 3
        when "tx4"
          @text4 = ms.values[i]
          last_number = 4 if last_number < 4
        end
      end
    end
    if (["��l���E��","���ԒE��","�����E��","�z���E��","�z���E����","����"].include?($msg.tag) and $msg.talk_step == 1) or
    (["�����E�ʏ�","�����E����","����","��d"].include?($msg.tag) and $msg.talk_step >= 1 and $msg.talk_step <= 76)
      case last_number
      when 1; @text1 += "\\T" unless @text1.include?("\\T")
      when 2; @text2 += "\\T" unless @text2.include?("\\T") 
      when 3; @text3 += "\\T" unless @text3.include?("\\T")
      when 4; @text4 += "\\T" unless @text4.include?("\\T")
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� ��b�̃��[�h�E�F�D�x�㏸�^�C�v
  #    �ʏ펞��1�`6�̂U�^�C�v�B
  #    �Ⓒ���̊|�������ȂǗF�D�x�݂̂̕ϓ���10�`15
  #    �g�[�N���̏C����20�`
  #--------------------------------------------------------------------------
  def moody_count(type)
    # �퓬�����_��t�F�[�Y���͒ʂ��Ȃ�
    if $game_temp.in_battle and $scene.phase == 6
      return
    end
    case type.to_i
    #���ƂĂ��s���̎c�锽��������(���[�h�傫���_�E��) 
    when 1
      pt = -10 + rand(3) - rand(4)
      $mood.rise(pt)
    #���s���ŋ������킪�ꂽ(���[�h�኱�_�E��)
    when 2
      pt = -5 + rand(2) - rand(3)
      $mood.rise(pt)
    #�������ɋ�����������(�F�D�x�኱�㏸�A���[�h�㏸)
    when 3
      pt = 7 + rand(4) - rand(4)
      $mood.rise(pt)
      @t_enemy.like(3)
    #�������ɍD����������(�F�D�x�㏸�A���[�h�኱�㏸)
    when 4
      pt = 10 + rand(3) - rand(2)
      $mood.rise(pt)
      @t_enemy.like(5)
    #���ƂĂ������ł��锽��������(�F�D�x�A���[�h���ɏ㏸)
    when 5
      pt = 15 + rand(4) - rand(3)
      $mood.rise(pt)
      @t_enemy.like(8)
    #-------------------------------------------------
    #���������C�ɂȂ���(�F�D�x�F����)
    when 10
      @t_enemy.like(1)
    #�������ɍD����������(�F�D�x�F��)
    when 11
      @t_enemy.like(2)
    #�������Ƀh�L���Ƃ���(�F�D�x�F��)
    when 12
      @t_enemy.like(4)
    #�������������̍D�݂�����(�F�D�x�F��)
    when 13
      @t_enemy.like(10)
    #���S���D��ꂽ(�F�D�x�F����)
    when 14
      @t_enemy.like(30)
    #-------------------------------------------------
    #���g�[�N����(����)
    when 20
      pt = -5 - rand(5)
      $mood.rise(pt)
    #���g�[�N����(���f)
    when 21
      @t_enemy.like(3)
    #���g�[�N����(�O����)
    when 22
      pt = 5 + rand(5)
      $mood.rise(pt)
      @t_enemy.like(5)
    #���g�[�N����(�E��)
    when 23
      pt = 10 + rand(3) - rand(3)
      $mood.rise(pt)
      @t_enemy.like(5)
    #���g�[�N����(�����E��d�E����)
    when 24
      pt = 2 + rand(4) - rand(3)
      $mood.rise(pt)
      @t_enemy.like(3)
    #���g�[�N����(�z��)
    when 25
      pt = 8 + rand(3)
      $mood.rise(pt)
      @t_enemy.like(5)
    #���g�[�N����(����)
    when 26
      pt = 10 + rand(6)
      $mood.rise(pt)
      @t_enemy.like(15)
    #���g�[�N����(��d�����E���������E�D��)
    when 27
      pt = 5 + rand(5)
      $mood.rise(pt)
      @t_enemy.like(10)
    #���g�[�N����(�s�����E�Ⓒ��)
    when 28
      @t_enemy.like(10)
    #���g�[�N����(�s�����E�N���C�V�X)
    when 29
      @t_enemy.like(4)
    #���g�[�N����(�s�����E�X�e�[�g)
    when 30
      @t_enemy.like(2)
    end
  end
  #--------------------------------------------------------------------------
  # �� �f�t�H���g�l�[���ݒ�
  #--------------------------------------------------------------------------
  def defaultname_select(battler)
    #���O����System/talk/00_System�t�H���_�Őݒ�
  end
  #--------------------------------------------------------------------------
  # �� ���ۂ̌���Ăяo��
  #--------------------------------------------------------------------------
  def call(battler)
    @text1 = @text2 = @text3 = @text4 = ""
    #��l�����Ăяo���ꂽ�ꍇ�͖߂�
    if battler == $game_actors[101]
      return @text1 = "�u�c�c�c�c�c�v"
    end
    #�N����擾���Ă���
    age_check
    #�Ⓒ������Ăяo���̏ꍇ�A�t���e�L�X�g���ǂ�ł���
    if $game_switches[77] == true
      ecstasy_emotion
      make_text
    end
    if battler != nil and battler.class_id != nil and @talk_step != 99
      #p "#{battler.name}�^���i�F#{battler.personality}�^#{@tag}" if $DEBUG
      id = $data_personality.search(0, battler.personality)
      return @msg[battler.class_id].personality[id].manage
    else
      @text1 = @text2 = @text3 = @text4 = ""
      return @text1 = "�u�c�c�c�c�c�v"
    end
  end
end
