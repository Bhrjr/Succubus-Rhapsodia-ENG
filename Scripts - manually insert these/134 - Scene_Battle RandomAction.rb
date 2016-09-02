#==============================================================================
# �� Scene_Battle (������` 6)
#------------------------------------------------------------------------------
# �@�o�g����ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Battle
  #--------------------------------------------------------------------------
  # �� �K�����Ă���z�[���h�ȊO���O��
  #--------------------------------------------------------------------------
  def hold_action_select(action)
    action.delete(682) unless @active_battler.have_ability?("�A�N�Z�v�g")
    action.delete(683) unless @active_battler.have_ability?("�V�F���}�b�`")
    action.delete(684) unless @active_battler.have_ability?("�G�L�T�C�g�r���[")
    action.delete(687) unless @active_battler.have_ability?("�I�[�����Z�b�N�X")
    action.delete(688) unless @active_battler.have_ability?("�I�[�����Z�b�N�X")
    action.delete(689) unless @active_battler.have_ability?("�t���b�^�i�C�Y")
    action.delete(691) unless @active_battler.have_ability?("�g���C���h�z�[��")
    action.delete(692) unless @active_battler.have_ability?("�g���C���h�z�[��")
    action.delete(695) unless @active_battler.have_ability?("�G���u���C�X")
    action.delete(697) unless @active_battler.have_ability?("�y���X�R�[�v")
    action.delete(698) unless @active_battler.have_ability?("�w�u�����[�t�B�[��")
    action.delete(700) unless @active_battler.have_ability?("�A���h���M���k�X")
    action.delete(701) unless @active_battler.have_ability?("�A���h���M���k�X")
    action.delete(705) unless @active_battler.have_ability?("�e�C���}�X�^���[")
    action.delete(706) unless @active_battler.have_ability?("�e�C���}�X�^���[")
    action.delete(710) unless @active_battler.have_ability?("�C�N�C�b�v�f�B���h")
    action.delete(711) unless @active_battler.have_ability?("�C�N�C�b�v�f�B���h")
    action.delete(712) unless @active_battler.have_ability?("�C�N�C�b�v�f�B���h")
    action.delete(718) unless @active_battler.have_ability?("�e���^�N���}�X�^���[")
    action.delete(715) # �A�C���B�N���[�Y�i�z�[���h�j�i�v�j
    action.delete(716) # �f�����Y�N���[�Y�i�z�[���h�j�i�v�j
    action.delete(719) # �C���T���g�c���[�i�v�j
    unless @active_battler.have_ability?("�A�k�X�}�[�L���O")
      action.delete(702) unless @active_battler.have_ability?("�A���h���M���k�X")
      action.delete(707) unless @active_battler.have_ability?("�e�C���}�X�^���[")
    end
    unless @active_battler.have_ability?("�o�C���h�}�X�^���[")
      action.delete(696) unless @active_battler.have_ability?("�G���u���C�X")
    end
=begin
    # ����i�K���f���{�w�C�g�X�C�b�`�ŉ��ւ����j�����w�C�g���փI�t
    # �f�B���h�C���o�b�N
    unless @active_battler.have_ability?("�C�N�C�b�v�f�B���h") and (
    @active_battler.have_ability?("�A�k�X�}�[�L���O"))# or $game_switches[145])
      action.delete(712) 
    end
=end
    # �f�����Y�A�u�\�[�u
    unless @active_battler.have_ability?("�e���^�N���}�X�^���[")# and $game_switches[145]
      action.delete(717)
    end
    
    return action
  end
  #--------------------------------------------------------------------------
  # �� �����_���ȍU��
  #--------------------------------------------------------------------------
  def random_skill_action
#    p "�ǌ������^�A�N�V�����F#{@active_battler.name}�^�s���F#{$msg.at_type}�^�ΏہF#{$msg.at_parts}" if $game_switches[78] and $DEBUG
    action = []
    
    #�Q�Ƃ���X�L�������̋L�q���������ߎ��O�Ɋȗ���
#    random_skill = @active_battler.current_action.skill_id
    #�Ή����鑮��(�g�p��)
    #@71����  @72����  @73����  @74����  @75����  @76���K  @77����
    #@78���K��  @79���G��  @80�����g��  @81���f�B���h  @82������  @83����
    #@84���������  @85����  @86���ٔ�
    #�Ή����鑮��(�Ώۑ�)
    #@91����  @92����  @93���K  @94���`  @95����  @96����  
    #@97����  @98���j  @99�����g��  @100����  @101����
#    p @skill.id if $DEBUG
    #------------------------------------------------------------------------
    # ���ǌ�������
    # �X�C�b�`25(�ǌ�)�������Ă���ꍇ�A�ǌ��X�L�����I�������
    #------------------------------------------------------------------------
    if $game_switches[78] == true
      case $msg.at_type
      #��
      when "�L�X"
        #�L�X�̒ǌ��̓L�X�̂�
        action = [305]
      #��
      when "��"
        #���O�ɑΏۂ��U�߂����ʂ���ǌ��X�L��id��ݒ�
        case $msg.at_parts
        when "�ΏہF��"
          action = [332]
        when "�ΏہF�K"
          action = [354]
        when "�ΏہF�A�i��"
          if @target_battlers[0].have_ability?("�j")
            action = [355]
          else
            action = [356]
          end
        when "�ΏہF�y�j�X"
          action = [325]
        when "�ΏہF�Ί�"
          action = [326]
        when "�ΏہF�A�\�R"
          action = [341]
        when "�ΏہF�A�j"
          action = [342]
        end
      #��
      when "��"
        #���O�ɑΏۂ��U�߂����ʂ���ǌ��X�L��id��ݒ�
        case $msg.at_parts
        when "�ΏہF��"
          action = [388]
        when "�ΏہF�K"
          action = [410]
        when "�ΏہF�A�i��"
          if @target_battlers[0].have_ability?("�j")
            action = [411]
          else
            action = [412]
          end
        when "�ΏہF�y�j�X"
          action = [381]
        when "�ΏہF�Ί�"
          action = [382]
        when "�ΏہF�A�\�R"
          action = [397]
        when "�ΏہF�A�j"
          action = [398]
        end
      #��
      when "��"
        #���O�ɑΏۂ��U�߂����ʂ���ǌ��X�L��id��ݒ�(���T�C�Y�ŃX�L���ύX)
        case $msg.at_parts
        when "�ΏہF��"
          if $data_SDB[@active_battler.class_id].bust_size < 2
            action = [445]
          else
            action = [444]
          end
        when "�ΏہF��"
          if $data_SDB[@active_battler.class_id].bust_size < 2
            action = [454]
          else
            action = [453]
          end
        when "�ΏہF�y�j�X"
          if $data_SDB[@active_battler.class_id].bust_size < 2
            action = [437]
          else
            action = [436]
          end
        end
      #��
      when "��"
        #����őf�҂����Ȃ��̂�id�Œ�
        action = [477]
      #��
      when "��"
        case $msg.at_parts
        when "�ΏہF��"
          action = [494]
        when "�ΏہF�y�j�X"
          action = [489]
        when "�ΏہF�A�\�R"
          action = [499]
        end
      #��
      when "����"
        #�����ɂ͒ǌ��͔������Ȃ��̂ŁA�����������Ă��߂�
        return
      #��
      when "�K��"
        #���O�ɑΏۂ��U�߂����ʂ���ǌ��X�L��id��ݒ�
        case $msg.at_parts
        when "�ΏہF��"
          action = [526]
        when "�ΏہF�K"
          action = [543]
        when "�ΏہF�A�i��"
          if @target_battlers[0].have_ability?("�j")
            action = [544]
          else
            action = [545]
          end
        when "�ΏہF�y�j�X"
          action = [520]
        when "�ΏہF�Ί�"
          action = [521]
        when "�ΏہF�A�\�R"
          action = [533]
        when "�ΏہF�A�j"
          action = [534]
        end
      #��
      when "����"
        #���O�ɑΏۂ��U�߂����ʂ���ǌ��X�L��id��ݒ�
        case $msg.at_parts
        #�A�i�����^
        when "�ΏہF�A�i��"
          action = [621]
        #�A�\�R���^
        when "�ΏہF�A�\�R"
          action = [614]
        #��
        when "�g�p�F��"
          action = [557]
        #����
        when "�g�p�F�ٔ�"
          action = [572]
        end
      #��
      when "����g��"
        #������g�̍U���́A�U���ʂ��Ƃɐݒ肷��
        action = [305]
      #��
      when "�\���s��"
        #�\�����������Ă���(��ōĒ�`����)
        action = [982]
        #���\�����͍s���҂̃z�[���h�󋵂ɂ���Đݒ肷��
        if @active_battler.holding_now?
          # ���}���̏ꍇ
          if @active_battler.inserting_now?
            action = [984] if @active_battler.penis_insert? or @active_battler.dildo_insert? #��or�f�B���h
            action = [986] if @active_battler.vagina_insert? #��
          # ���}���̏ꍇ
          elsif @active_battler.oralsex_now?
            action = [984]
          # �K�}���̏ꍇ
          elsif @active_battler.analsex_now?
            action = [982] if @active_battler.dildo_anal_analsex? #�`�f�B���h�͔����ł��Ȃ����߈�����
            action = [984] if @active_battler.penis_analsex? or @active_battler.dildo_analsex? #��or�f�B���h
            action = [986] if @active_battler.anal_analsex? #�`
          # �L���킹�̏ꍇ
          elsif @active_battler.shellmatch_now?
            action = [986]
          # �R��̏ꍇ
          elsif @active_battler.riding_now?
            action = [982] if @active_battler.mouth_riding? #��
            action = [986] if @active_battler.vagina_riding? #��
          # �p�C�Y���̏ꍇ
          elsif @active_battler.paizuri_now?
            action = [982] if @active_battler.penis_paizuri? #���͔����ł��Ȃ����߈�����
            action = [986] if @active_battler.tops_paizuri? #��
          # �N���j�̏ꍇ
          elsif @active_battler.drawing_now?
            action = [982] if @active_battler.vagina_draw? or @active_battler.tentacle_vagina_draw? #���͔����ł��Ȃ����߈�����
            action = [984] if @active_battler.mouth_draw? or @active_battler.tentacle_draw? #��or�G��
          # �S���̏ꍇ
          elsif @active_battler.binding_now?
            action = [982]
          # �G��z���̏ꍇ
          elsif @active_battler.usetentacle_now?
            action = [982] if @active_battler.tentacle_penis_absorbing? #���͔����ł��Ȃ����߈�����
            action = [984] if @active_battler.tentacle_absorbing? #�G��
          else
            action = [982]
          end
        else
          action = [982]
        end
      #��
      when "�z�[���h�U��"
        #���O�ɑΏۂ��U�߂����ʂ���ǌ��X�L��id��ݒ�
        case $msg.at_parts
        when "���}���F�y�j�X��"
          action = [843] #�s�X�g��
        when "���}���F�A�\�R��"
          if @active_battler.initiative_now?
            action = [757] #�O���C���h
          else
            action = [758] #���߂�
          end
        when "���}���F�y�j�X��"
          action = [852] #�C���}�`�I
        when "���}���F����"
          if @active_battler.initiative_now?
            action = [794]
          else
            action = [795]
          end
        when "�K�}���F�y�j�X��"
          action = [857]
        when "�K�}���F�K��"
          action = [814]
        when "�L���킹"
          action = [764]
        when "�R��F�A�\�R��"
          action = [769]
        when "�R��F����"
          action = [936]
        when "�K�R��F�K��"
          action = [819]
        when "�K�R��F����"
          action = [927]
        when "�N���j"
          action = [801]
        when "�ςӂς�"
          action = [864]
        when "�L�b�X"
          action = [807]
        when "�w�ʍS��"
          action = [830]
        when "�J�r�S��"
          action = [834]
        when "�p�C�Y��"
          action = [840]
        when "�K�����}��"
          action = [869]
        when "�K�����}��"
          action = [874]
        when "�K���K�}��"
          action = [879]
        when "�f�B���h���}��"
          action = [891]
        when "�f�B���h���}��"
          action = [896]
        when "�f�B���h�K�}��"
          action = [901]
        when "�G�聊�}��"
          action = [913]
        when "�G����}��"
          action = [918]
        when "�G��K�}��"
          action = [923]
        when "�G��S��"
          action = [927]
        end
      #��
      when "�z�[���h����"
        action = [964]
      end
    else
      #-----------------------------------------------------------------------
      # ���ǌ��p�A�^�b�N�p�^�[�����Z�b�g
      #-----------------------------------------------------------------------
      $msg.at_type = $msg.at_parts = ""
      pc1 = $mood.point + (@active_battler.dex / 2) #���X�L���g�p�m��
      pc2 = ($mood.point / 2) + (@active_battler.dex / 3) #�K�E�X�L���g�p�m��
      pc3 = ($mood.point / 3) + (@active_battler.int / 3) #�A�u�m�[�}���n�X�L���g�p�m��
      pc3 -= 100 #��{�A�u�m�[�}���n�X�L���͎g��Ȃ����A�����ꕔ�̖����̂݃��[�h�������Ǝg���\��������
      #���i�P�ʂňꕔ�X�L���m�����ꕔ�ϓ�
      case @active_battler.personality
      when "�D�F","�����C","�_�a","�ƑP","���C"
        pc1 += $mood.point
      when "��i","���C","�z�C","�C��","���M","����"
        pc3 -= 100
      when "�|��","�Ӓn��","����","�A�C","�I����"
        pc3 += $mood.point
      end
      count = 0
      loop do
        #-----------------------------------------------------------------------
        # �������_���X�L����id����I��
        #-----------------------------------------------------------------------
        case @skill.id
        #======================================================================
        # ���L�b�X
        #======================================================================
        when 281
          $msg.at_type = "�L�X"
          action = [301,301,302,302,302]
          action.push(303) if rand(100) < pc1
          action.push(303,304) if rand(100) < pc2
        #======================================================================
        # ����U��
        #======================================================================
        when 282
          $msg.at_type = "��"
          #�΁��Ƒ΁��ƑΑo���ŃZ�b�g����X�L�����قȂ�
          if @target_battlers[0].boy?
            action = [319,319,320]
            if @target_battlers[0].nude?
              action.push(320,320,328,344)
              action.push(321,323,344) if rand(100) < pc1
              action.push(321,322,323,324) if rand(100) < pc2
              action.push(348,349,350) if rand(100) < pc3 #�O���B�h���͊m�����Ⴂ���ꉞ�s��
            end
          elsif @target_battlers[0].futanari?
            action = [319,319,320,328,328,329,334,334,335,344,344,345]
            if @target_battlers[0].nude?
              action.push(320,320,329,329,328,335,335,345,345)
              action.push(321,323,330,336,338,346) if rand(100) < pc1
              action.push(321,324,322,330,331,336,337,339,340,346,347,351) if rand(100) < pc2
              action.push(352,353) if rand(100) < pc3 #�A�i���h���͊m�����Ⴂ���ꉞ�s��
            end
          else
            action = [328,328,329,334,334,335,344,344,345]
            if @target_battlers[0].nude?
              action.push(329,329,328,335,335,345,345) if @target_battlers[0].nude?
              action.push(330,336,338,346) if rand(100) < pc1
              action.push(330,331,337,338,339,340,346,347,351) if rand(100) < pc2
              action.push(352,353) if rand(100) < pc3 #�A�i���h���͊m�����Ⴂ���ꉞ�s��
            end
          end
        #======================================================================
        # �����U��
        #======================================================================
        when 283
          $msg.at_type = "��"
          #�΁��Ƒ΁��ƑΑo���ŃZ�b�g����X�L�����قȂ�
          if @target_battlers[0].boy?
            action = [375,375,376]
            if @target_battlers[0].nude?
              action.push(376,376,384)
              action.push(377,379,400) if rand(100) < pc1
              action.push(377,378,380) if rand(100) < pc2
              action.push(404,405,406) if rand(100) < pc3 #�O���B�h���͊m�����Ⴂ���ꉞ�s��
            end
          elsif @target_battlers[0].futanari?
            action = [375,375,376,384,384,385,390,390,391,400,400,401]
            if @target_battlers[0].nude?
              action.push(376,376,385,385,391,391,394,401,401)
              action.push(377,379,386,392,394,395,402) if rand(100) < pc1
              action.push(378,380,387,393,396,403,407) if rand(100) < pc2
              action.push(408,409) if rand(100) < pc3 #�A�i���h���͊m�����Ⴂ���ꉞ�s��
            end
          else
            action = [384,384,385,390,390,391,400,400,401]
            if @target_battlers[0].nude?
              action.push(385,385,391,391,394,401,401)
              action.push(386,392,394,395,402) if rand(100) < pc1
              action.push(387,393,396,403,407) if rand(100) < pc2
              action.push(408,409) if rand(100) < pc3 #�A�i���h���͊m�����Ⴂ���ꉞ�s��
            end
          end
        #======================================================================
        # �����U��
        #======================================================================
        when 284
          $msg.at_type = "��"
          #�΁��Ƒ΁��ƑΑo���ŃZ�b�g����X�L�����قȂ�
          if @target_battlers[0].boy?
            #���̑傫���ŃZ�b�g����X�L�����قȂ�
            if $data_SDB[@active_battler.class_id].bust_size < 2
              action = [435,435,443,443]
            else
              action = [431,431,432,439,439,440]
              action.push(432,432,433,440,440,441) if rand(100) < pc1
              action.push(433,434,441,442) if rand(100) < pc2
            end
          elsif @target_battlers[0].futanari?
            #���̑傫���ŃZ�b�g����X�L�����قȂ�
            if $data_SDB[@active_battler.class_id].bust_size < 2
              action = [435,435,443,443,451,451]
              action.push(452) if rand(100) < pc2
            else
              action = [431,431,432,439,439,440,447,447,448]
              action.push(432,432,433,440,440,441,448,448,449) if rand(100) < pc1
              action.push(433,434,441,442,449,450) if rand(100) < pc2
            end
          else
            #���̑傫���ŃZ�b�g����X�L�����قȂ�
            if $data_SDB[@active_battler.class_id].bust_size < 2
              action = [443,443,451,451]
              action.push(452) if rand(100) < pc2
            else
              action = [439,439,440,447,447,448]
              action.push(440,440,441,448,448,449) if rand(100) < pc1
              action.push(441,442,449,450) if rand(100) < pc2
            end
          end
        #======================================================================
        # �����U��
        #======================================================================
        when 285
          $msg.at_type = "��"
          #���U���͗��җ��łȂ��ƍs��Ȃ��B�܂��f�҈ȊO�̓z�[���h�Ȃ��ߑ΁������Ȃ��B
          if @target_battlers[0].boy? or @target_battlers[0].futanari?
            action = [473,473,474,474,474]
            action.push(475) if rand(100) < pc1
            action.push(476) if rand(100) < pc2
          else
            #���̏ꍇ�̓G���[�Ȃ̂Ŏb��I�Ƀt���[�A�N�V�����ƃG���[�V�������g�p����
            action = [298,299]
          end
        #======================================================================
        # �����U��
        #======================================================================
        when 286
          $msg.at_type = "��"
          #�΁��Ƒ΁��ƑΑo���ŃZ�b�g����X�L�����قȂ�
          #���U�߂͔�s�n�Ȃ̂Ŏg�p��������⌵����
          if @target_battlers[0].boy?
            action = [486,486]
            if @target_battlers[0].nude?
              action.push(487,487,487,488) if rand(100) < pc2
            end
          elsif @target_battlers[0].futanari?
            action = [486,486,496,496]
            if @target_battlers[0].nude?
              action.push(487,487,487,491,491,492,492,497,497,497,488,493,498) if rand(100) < pc2
            end
          else
            action = [496,496]
            if @target_battlers[0].nude?
              action.push(491,491,492,492,493,498,497,497,497) if rand(100) < pc2
            end
          end
        #======================================================================
        # ������
        #======================================================================
        when 287
          $msg.at_type = "����"
          action = [508,509,510,511,512]
        #======================================================================
        # ���K���U��
        #======================================================================
        when 288
          $msg.at_type = "�K��"
          #�΁��Ƒ΁��ƑΑo���ŃZ�b�g����X�L�����قȂ�
          if @target_battlers[0].boy?
            action = [515,515]
#            if @target_battlers[0].nude?
#              action.push(516,516,516,523,536)
#              action.push(518,517) if rand(100) < pc1
#              action.push(519) if rand(100) < pc2
#              action.push(539,540) if rand(100) < pc3 #�O���B�h���͊m�����Ⴂ���ꉞ�s��
#            end
          elsif @target_battlers[0].futanari?
            action = [515,515,523,523,528,528,536,536]
#            if @target_battlers[0].nude?
#              action.push(516,516,516,523,523,524,524,524,529,529,529,537,537,537)
#              action.push(518,517,531) if rand(100) < pc1
#              action.push(519,525,530,531,532) if rand(100) < pc2
#              action.push(541,542) if rand(100) < pc3 #�A�i���h���͊m�����Ⴂ���ꉞ�s��
#            end
          else
            action = [523,523,528,528,536,536]
#            if @target_battlers[0].nude?
#              action.push(523,523,524,524,524,529,529,529,537,537,537)
#              action.push(531) if rand(100) < pc1
#              action.push(525,530,531,532) if rand(100) < pc2
#              action.push(541,542) if rand(100) < pc3 #�A�i���h���͊m�����Ⴂ���ꉞ�s��
#            end
          end
        #======================================================================
        # ������U��
        #======================================================================
        when 289
          $msg.at_type = "����"
        #======================================================================
        # ������g�̍U��
        #======================================================================
        when 290
          $msg.at_type = "����g��"
        #======================================================================
        # ���\��(�󋵂ɉ����ă����_���ŃX�L�����Z�b�g����)
        #======================================================================
        when 296
          $msg.at_type = "�\���s��"
          #--------------------------------------------------------------------
          # ���ʕ���
          #--------------------------------------------------------------------
          #���K����U����Q�g�A��З͂��Q�g�����
          action = [988,988,987,987]
          #��VP��������؂��Ă���ƔR���؂ꂪ���߂ɓ���
          action.push(987) if @active_battler.sp < (@active_battler.maxsp / 2)
          action.push(987,988) if @active_battler.sp < (@active_battler.maxsp / 3)
          action.push(987) if @active_battler.sp < (@active_battler.maxsp / 4)
          #���z�[���h��Ԃ̓���̓G�l�~�[�A�A�N�^�[���ʂƂȂ�
          if @active_battler.holding_now?
            #�R���؂�̏ꍇ
            if @active_battler.sp < 20
              action.push(987,987,987,987,987,987,987)
            # ���}���̏ꍇ
            elsif @active_battler.inserting_now?
              action.push(983,983,983,983,983,983) if @active_battler.penis_insert? or @active_battler.dildo_insert? #��or�f�B���h
              action.push(985,985,985,985,985,985) if @active_battler.vagina_insert? #��
            # ���}���̏ꍇ
            elsif @active_battler.oralsex_now?
              action.push(983,983,983,983,983,983)
            # �K�}���̏ꍇ
            elsif @active_battler.analsex_now?
              action.push(981,981,981,981,981,981) if @active_battler.dildo_anal_analsex? #�`�f�B���h�͔����ł��Ȃ����߈�����
              action.push(983,983,983,983,983,983) if @active_battler.penis_analsex? or @active_battler.dildo_analsex? #��or�f�B���h
              action.push(985,985,985,985,985,985) if @active_battler.anal_analsex? #�`
            # �L���킹�̏ꍇ
            elsif @active_battler.shellmatch_now?
              action.push(985,985,985,985,985,985)
            # �R��̏ꍇ
            elsif @active_battler.riding_now?
              action.push(981,981,981,981,981,981) if @active_battler.mouth_riding? #��
              action.push(985,985,985,985,985,985) if @active_battler.vagina_riding? #��
            # �p�C�Y���̏ꍇ
            elsif @active_battler.paizuri_now?
              action.push(981,981,981,981,981,981) if @active_battler.penis_paizuri? #���͔����ł��Ȃ����߈�����
              action.push(985,985,985,985,985,985) if @active_battler.tops_paizuri? #��
            # �N���j�̏ꍇ
            elsif @active_battler.drawing_now?
              action.push(981,981,981,981,981,981) if @active_battler.vagina_draw? or @active_battler.tentacle_vagina_draw? #���͔����ł��Ȃ����߈�����
              action.push(983,983,983,983,983,983) if @active_battler.mouth_draw? or @active_battler.tentacle_draw? #��or�G��
            # �S���̏ꍇ
            elsif @active_battler.binding_now?
              action.push(981,981,981,981,981,981)
            # �G��z���̏ꍇ
            elsif @active_battler.usetentacle_now?
              action.push(981,981,981,981,981,981) if @active_battler.tentacle_penis_absorbing? #���͔����ł��Ȃ����߈�����
              action.push(983,983,983,983,983,983) if @active_battler.tentacle_absorbing? #�G��
            #����ȊO�̃z�[���h�̏ꍇ
            else
              action.push(981,981,981,981,981,981)
            end
          end
          #--------------------------------------------------------------------
          # �A�N�^�[���\����Ԃ̏ꍇ(��z�[���h���)
          #--------------------------------------------------------------------
          if @active_battler.is_a?(Game_Actor)
            #����z�[���h���
            unless @active_battler.holding?
              #�����E�߂́A�����z�[���h���s��
              unless @active_battler.nude?
                action.push(4,4) unless @active_battler.holding?
              end
              #�ΏےE�߂́A�Ώۃz�[���h���s��
              unless @target_battlers[0].full_nude?
                action.push(2,2) unless @target_battlers[0].holding?
              end
              #�R���؂�̏ꍇ
              if @active_battler.sp < 20
                action.push(987,987,987,987,987,987,987)
              #�ʏ펞
              else
                action.push(981,981,981,981,981,981,981)
                #���}��
                if @active_battler.boy? or @active_battler.futanari?
                  #�Ώۂ́����󂢂Ă���Ȃ�C���T�[�g
                  action.push(6,6,6,6,6) if @target_battlers[0].hold.vagina.battler == nil and @target_battlers[0].insertable_nude?
                end
                #�f�B���h�}��
                if @active_battler.equip_dildo?
                  #�Ώۂ́����󂢂Ă���Ȃ�C���T�[�g
                  action.push(20,20,20,20,20) if @target_battlers[0].hold.vagina.battler == nil and @target_battlers[0].insertable_nude?
                  #�Ώۂ̌����󂢂Ă���Ȃ�f�B���h�}�E�X
                  action.push(21,21,21,21,21) if @target_battlers[0].hold.mouth.battler == nil
                end
                #���̑��z�[���h(���E�N�łȂ��Ȃ�)
                unless @active_battler.boy?
                  #�V�F���}�b�`
                  if @active_battler.have_ability?("�V�F���}�b�`")
                    action.push(5,5,5,5,5) if @target_battlers[0].hold.vagina.battler == nil and @target_battlers[0].insertable_nude?
                  end
                  #�G���u���C�X
                  if @active_battler.have_ability?("�G���u���C�X")
                    action.push(17,17,17,17,17) if @target_battlers[0].hold.tops.battler == nil
                  end
                  #�G�L�T�C�g�r���[
                  if @active_battler.have_ability?("�G�L�T�C�g�r���[")
                    action.push(18,18,18,18,18) if @target_battlers[0].hold.mouth.battler == nil
                  end
                  #�h���E�l�N�^�[
                  if @active_battler.have_ability?("�I�[�����Z�b�N�X")
                    action.push(16,16,16,16,16) if @target_battlers[0].hold.vagina.battler == nil and @target_battlers[0].insertable_nude?
                  end
                  #�f�����Y�h���E
                  if @active_battler.have_ability?("�e���^�N���}�X�^���[")
                    #�Ώۂ́����󂢂Ă���Ȃ�f�����Y�h���E
                    action.push(26,26,26,26,26) if @target_battlers[0].hold.vagina.battler == nil and @target_battlers[0].insertable_nude?
                  end
                end
              end
            end
          #--------------------------------------------------------------------
          # �G�l�~�[���\����Ԃ̏ꍇ
          #--------------------------------------------------------------------
          elsif @active_battler.is_a?(Game_Enemy)
            #����z�[���h���
            unless @active_battler.holding?
              #�����E�߂́A�����z�[���h���s��
              unless @active_battler.nude?
                action.push(251,251) unless @active_battler.holding?
              end
              #�ΏےE�߂́A�Ώۃz�[���h���s��
              unless @target_battlers[0].full_nude?
                action.push(257,257) unless @target_battlers[0].holding?
              end
              #�R���؂�̏ꍇ
              if @active_battler.sp < 20
                action.push(987,987,987,987,987,987,987)
              #�ʏ펞
              else
                action.push(981,981,981,981,981,981,981)
                # �Ύ�l����p�s��
                if @target_battlers[0].boy?
                  #�A�N�Z�v�g
                  if @active_battler.have_ability?("�A�N�Z�v�g")
                    #�Ώۂ́����󂢂Ă���Ȃ�A�N�Z�v�g
                    action.push(682,682,682,682,682) if @target_battlers[0].hold.penis.battler == nil and @target_battlers[0].insertable_nude?
                  end
                  #�I�[�����A�N�Z�v�g
                  if @active_battler.have_ability?("�I�[�����Z�b�N�X")
                    action.push(687,687,687,687,687) if @target_battlers[0].hold.penis.battler == nil and @target_battlers[0].insertable_nude?
                  end
                  #�y���X�R�[�v
                  if @active_battler.have_ability?("�y���X�R�[�v")
                    action.push(697,697,697,697,697) if @target_battlers[0].hold.penis.battler == nil and @target_battlers[0].insertable_nude?
                  end
                  #�f�B���h�C���o�b�N
                  if @active_battler.have_ability?("�C�N�C�b�v�f�B���h")
                    #�Ώۂ̐K���󂢂Ă���Ȃ�f�B���h�C���o�b�N
                    action.push(712,712,712,712,712) if @target_battlers[0].hold.anal.battler == nil and @target_battlers[0].insertable_nude?
                  end
                  #�f�����Y�A�u�\�[�u
                  if @active_battler.have_ability?("�e���^�N���}�X�^���[")
                    #�Ώۂ́����󂢂Ă���Ȃ�f�����Y�A�u�\�[�u
                    action.push(717,717,717,717,717) if @target_battlers[0].hold.penis.battler == nil and @target_battlers[0].insertable_nude?
                  end
                end
                # �΃p�[�g�i�[��p�s��
                unless @target_battlers[0].boy?
                  #�V�F���}�b�`
                  if @active_battler.have_ability?("�V�F���}�b�`")
                    #�Ώۂ́����󂢂Ă���Ȃ�V�F���}�b�`
                    action.push(683,683,683,683,683) if @target_battlers[0].hold.vagina.battler == nil and @target_battlers[0].insertable_nude?
                  end
                  #�f�B���h
                  if @active_battler.have_ability?("�C�N�C�b�v�f�B���h")
                    #�Ώۂ́����󂢂Ă���Ȃ�f�B���h�C���T�[�g
                    action.push(710,710,710,710,710) if @target_battlers[0].hold.vagina.battler == nil and @target_battlers[0].insertable_nude?
                    #�Ώۂ̌����󂢂Ă���Ȃ�f�B���h�C���}�E�X
                    action.push(711,711,711,711,711) if @target_battlers[0].hold.mouth.battler == nil
                  end
                  #�h���E�l�N�^�[
                  if @active_battler.have_ability?("�I�[�����Z�b�N�X")
                    action.push(688,688,688,688,688) if @target_battlers[0].hold.vagina.battler == nil and @target_battlers[0].insertable_nude?
                  end
                  #�f�����Y�h���E
                  if @active_battler.have_ability?("�e���^�N���}�X�^���[")
                    #�Ώۂ́����󂢂Ă���Ȃ�f�����Y�h���E
                    action.push(718,718,718,718,718) if @target_battlers[0].hold.vagina.battler == nil and @target_battlers[0].insertable_nude?
                  end
                end
                #���̑��z�[���h(���E�N�łȂ��Ȃ�)
                #�G���u���C�X
                if @active_battler.have_ability?("�G���u���C�X")
                  action.push(695,695,695,695,695) if @target_battlers[0].hold.tops.battler == nil
                end
                #�G�L�T�C�g�r���[
                if @active_battler.have_ability?("�G�L�T�C�g�r���[")
                  action.push(684,684,684,684,684) if @target_battlers[0].hold.mouth.battler == nil
                end
                # �K�����Ă��Ȃ��z�[���h�͍폜
                action = hold_action_select(action)
              end
            end
          end
        #======================================================================
        # ���z�[���h
        #(�����̕ʂɃX�L�����Z�b�g[$data_SDB]�A���i�ʂɎQ��[$data_personality])
        #======================================================================
        when 292
          rate = $data_SDB[@active_battler.class_id].hold_rate
          sp = $data_personality[@active_battler.personality].special_attack
          if 15 <= $mood.point
            action.push(*rate[0])
          end
          if sp[0] <= $mood.point
            action.push(*rate[1]) if rate[1] != nil
          end
          if sp[1] <= $mood.point
            action.push(*rate[2]) if rate[2] != nil
          end
          if sp[2] <= $mood.point
            action.push(*rate[3]) if rate[3] != nil
          end
#          if 100 <= $mood.point
#            action.push(*rate[4]) if rate[4] != nil
#          end
          n = 0
          for i in $game_troop.enemies
            if i.exist?
              n += 1
            end
          end
          if n < 2 and action.include?(695)
            action.delete(695)
            action.delete(696)
          end
          if action == []
#            action.push(251) unless @active_battler.nude?
            action.push(257) unless @target_battlers[0].nude?
            action.push(298) if action == []
          end
          # �K�����Ă��Ȃ��z�[���h�͍폜
                action = hold_action_select(action)
=begin
          action.delete(682) unless @active_battler.have_ability?("�A�N�Z�v�g")
          action.delete(683) unless @active_battler.have_ability?("�V�F���}�b�`")
          action.delete(684) unless @active_battler.have_ability?("�G�L�T�C�g�r���[")
          action.delete(687) unless @active_battler.have_ability?("�I�[�����Z�b�N�X")
          action.delete(688) unless @active_battler.have_ability?("�I�[�����Z�b�N�X")
          action.delete(689) unless @active_battler.have_ability?("�t���b�^�i�C�Y")
          action.delete(691) unless @active_battler.have_ability?("�g���C���h�z�[��")
          action.delete(692) unless @active_battler.have_ability?("�g���C���h�z�[��")
          action.delete(695) unless @active_battler.have_ability?("�G���u���C�X")
          action.delete(697) unless @active_battler.have_ability?("�y���X�R�[�v")
          action.delete(698) unless @active_battler.have_ability?("�w�u�����[�t�B�[��")
          action.delete(700) unless @active_battler.have_ability?("�A���h���M���k�X")
          action.delete(701) unless @active_battler.have_ability?("�A���h���M���k�X")
          action.delete(705) unless @active_battler.have_ability?("�e�C���}�X�^���[")
          action.delete(706) unless @active_battler.have_ability?("�e�C���}�X�^���[")
          
          action.delete(710) unless @active_battler.have_ability?("�C�N�C�b�v�f�B���h")
          action.delete(711) unless @active_battler.have_ability?("�C�N�C�b�v�f�B���h")
          action.delete(718) unless @active_battler.have_ability?("�e���^�N���}�X�^���[")
          unless @active_battler.have_ability?("�A�k�X�}�[�L���O")
            action.delete(702) unless @active_battler.have_ability?("�A���h���M���k�X")
            action.delete(707) unless @active_battler.have_ability?("�e�C���}�X�^���[")
            action.delete(712) unless @active_battler.have_ability?("�C�N�C�b�v�f�B���h")
#            action.delete(717) unless @active_battler.have_ability?("�e���^�N���}�X�^���[")
          end
          unless @active_battler.have_ability?("�o�C���h�}�X�^���[")
            action.delete(696) unless @active_battler.have_ability?("�G���u���C�X")
#            action.delete(719) unless @active_battler.have_ability?("�e���^�N���}�X�^���[")
          end
=end
        #======================================================================
        # �������z�[���h���̍U��(�������z�[���h����Ă���ꍇ���������đS�ď������m�F����)
        #======================================================================
        when 293
          if @active_battler.holding?
            $msg.at_type = "�z�[���h�U��"
            action = []
            #�A�\�R�ŃC���T�[�g���(�O���C���h�n) �Y
            if @active_battler.vagina_insert? and @target_battlers[0].penis_insert?
              if @target_battlers[0].hold.initiative_level < 3
                action.push(751,751,752,752,752)
                action.push(753) if rand(100) < pc1
                action.push(753,754) if rand(100) < pc2
                # �C�j�V�A�`�u�ő劎�y�z���z�����̏ꍇ�A�G�i�W�[�h���C�����g�p
                if @active_battler.hold.initiative_level == 3 and
                 @active_battler.have_ability?("�z��")
                  action.push(772,772,772,772,772)
                  # �w�C�g�B�����̓��x���h���C�����g�p
                  if $game_switches[145]
                    action.push(773,773,773,773,773)
                  end
                end
              else
                action.push(755,755,755)
                action.push(755,756) if rand(100) < pc1
                action.push(756) if rand(100) < pc2
              end
            end
            #�V�F���}�b�`���(�X�N���b�`�n) �Y
            if @active_battler.shellmatch? and @target_battlers[0].shellmatch?
              if @active_battler.initiative?
                action.push(760,760,761,761,761)
                action.push(762) if rand(100) < pc1
                action.push(762,763) if rand(100) < pc2
              else
                action.push(760,760,760)
                action.push(761,761) if rand(100) < pc1
                action.push(762) if rand(100) < pc2
              end
            end
            #�R����(���C�f�B���O�n) �Y
            if @active_battler.vagina_riding? and @target_battlers[0].mouth_riding?
              #�A�\�R�R���Ԃ͗L���ȏꍇ�������݂��Ȃ�
              action.push(766,766,766,767,767)
              action.push(767,767,768) if rand(100) < pc1
              action.push(768) if rand(100) < pc2
            end
            #��R����(���C�f�B���O�n���g��ꂽ�ꍇ) �Y
            if @active_battler.mouth_riding? and @target_battlers[0].vagina_riding?
              #��R���Ԃ͕s���ȏꍇ�������݂��Ȃ�
              action.push(942,942,942)
              #�����݁A�K���݂͏㔼�g���󂳂�ĂȂ���Ύg��
#���́u�C���T�[�g�A�V�F���}�b�`��ԈȊO�͊�{�����n�X�L����S�������v�ɒǉ�
#              action.push(944,944,945) unless @active_battler.tops_binding?
            end
            #�t�F���`�I���(�t�F���`�I�n)
            if @active_battler.mouth_oralsex? and @target_battlers[0].penis_oralsex?
              if @active_battler.initiative?
                action.push(788,788,789,789,789)
                action.push(790) if rand(100) < pc1
                action.push(790,791) if rand(100) < pc2
              else
                action.push(792,792,792)
                action.push(792,793) if rand(100) < pc1
                action.push(793) if rand(100) < pc2
              end
            end
            #�N���j��� �Y
            if @active_battler.mouth_draw? and @target_battlers[0].vagina_draw?
              #�N���j��Ԃ͗L���ȏꍇ�������݂��Ȃ�
              action.push(797,797,797,798,798)
              action.push(798,798,799) if rand(100) < pc1
              action.push(799,800) if rand(100) < pc2
            end
            #��N���j��� �Y
            if @active_battler.vagina_draw? and @target_battlers[0].mouth_draw?
              #��N���j��Ԃ͗L���ȏꍇ�������݂��Ȃ�
              action.push(948,948,948,948,948)
            end
            #�L�b�X���
            if @active_battler.deepkiss? and @target_battlers[0].deepkiss?
              action.push(803,803,803,804,804)
              action.push(804,805,805) if rand(100) < pc1
              action.push(805,806) if rand(100) < pc2
            end
            #�A�i���Z�b�N�X���(�X�N�C�[�Y�n)
            if @active_battler.anal_analsex? and @target_battlers[0].penis_analsex?
              if @active_battler.initiative?
                action.push(810,810,811,811,811)
                action.push(812) if rand(100) < pc1
                action.push(812,813) if rand(100) < pc2
              else
                action.push(810,810,810)
                action.push(811,811) if rand(100) < pc1
                action.push(812) if rand(100) < pc2
              end
            end
            #�S�����
            if @active_battler.tops_binder? and @target_battlers[0].tops_binding?
              #�S����Ԃ͗L���ȏꍇ�������݂��Ȃ�
              action.push(828,828,828)
              action.push(828,829,829) if rand(100) < pc1
            end
            #��S�����
            if @active_battler.tops_binding? and @target_battlers[0].tops_binder?
              #�S����Ԃ͗L���ȏꍇ�������݂��Ȃ�
              action.push(828,828,828)
              action.push(828,829,829) if rand(100) < pc1
            end
            #�p�C�Y�����
            if @active_battler.tops_paizuri? and @target_battlers[0].penis_paizuri?
              #�p�C�Y����Ԃ͗L���ȏꍇ�������݂��Ȃ�
              action.push(836,836,836,837,837)
              action.push(837,838) if rand(100) < pc1
              action.push(838,839) if rand(100) < pc2
            end
            #�ςӂςӏ��
            if @active_battler.tops_pahupahu? and @target_battlers[0].mouth_pahupahu?
              #�ςӂςӏ�Ԃ͗L���ȏꍇ�������݂��Ȃ�
              action.push(842,842,842,843,843)
              action.push(843,844) if rand(100) < pc1
              action.push(844,845) if rand(100) < pc2
            end
            #�f�B���h�C���T�[�g���
            if @active_battler.dildo_insert? and @target_battlers[0].dildo_vagina_insert?
              action.push(891,891,891,892,892)
              action.push(892,892) if rand(100) < pc1
              action.push(892,893) if rand(100) < pc2
            end
            #�f�B���h�C���}�E�X���
            if @active_battler.dildo_oralsex? and @target_battlers[0].dildo_mouth_oralsex?
              action.push(896,896,896,897,897)
              action.push(897,897) if rand(100) < pc1
              action.push(897,898) if rand(100) < pc2
            end
            #�f�B���h�C���o�b�N���
            if @active_battler.dildo_analsex? and @target_battlers[0].dildo_anal_analsex?
              action.push(901,901,901,902,902)
              action.push(902,902) if rand(100) < pc1
              action.push(902,903) if rand(100) < pc2
            end
            #�f�����Y�A�u�\�[�u���
            if @active_battler.tentacle_absorbing? and @target_battlers[0].tentacle_penis_absorbing?
              action.push(733,733,733,734,734)
              action.push(734,735) if rand(100) < pc1
              action.push(735,736) if rand(100) < pc2
            end
            #�f�����Y�h���E���
            if @active_battler.tentacle_draw? and @target_battlers[0].tentacle_vagina_draw?
              action.push(738,738,738,739,739)
              action.push(739,740) if rand(100) < pc1
              action.push(740,741) if rand(100) < pc2
            end
            # �C���T�[�g�A�V�F���}�b�`��ԈȊO�͊�{�����n�X�L����S�������
            # ���]�����n�͂�����������
            if @active_battler.can_struggle? and @active_battler.target_hold?(@target_battlers[0])
                action.push(947) #�L�X����
              # ���Ɏ肪�͂�����
              if @active_battler.can_reach_bust?(@target_battlers[0])
                action.push(944) #������
              end
              # �镔�Ɏ肪�͂�����
              if @active_battler.can_reach_secret?(@target_battlers[0])
                action.push(949) #�A�\�R�U�ߔ���
                action.push(950) #�A�j�U�ߔ���
                action.push(951) #�y�j�X�U�ߔ���
                action.push(952) #�ΊۍU�ߔ���
              end
              # �K�Ɏ肪�͂�����
              if @active_battler.can_reach_hip?(@target_battlers[0])
                action.push(945) #�K����
              end
              #action.push(953,954) #�C��t���n�B�Ή��z�[���h���������ߖv
              action.push(971) # ������
            end
#            if action == []
#              #�G���[�Ή����͊ώ@�ɂȂ�
#              action = [968]
#            end
#          else
#            #�G���[�Ή����͊ώ@�ɂȂ�
#            action = [968]
          end
        #======================================================================
        # �����������������z�[���h���̍s��
        #======================================================================
        when 294
          $msg.at_type = "�z�[���h����"
          #���i�P�ʂŃZ�b�g����ID���ύX�����ꍇ������
          #at:�z�[���h���̖������U�߂č��g������  on�F���Ԃ��n�߂�
          at = on = 0
          case @active_battler.personality
          when "�D�F","�z�C"
            at += $mood.point
            on += ($mood.point / 2)
          when "��i","�_�a","����","�W��"
            at += ($mood.point / 2) if $mood.point > 49
            on += ($mood.point / 2) if @active_battler.excited?
          when "�����C","�Ӓn��","�Â���"
            at += $mood.point
            on += $mood.point if @active_battler.excited?
          when "���C"
            at += $mood.point if @active_battler.excited? and $mood.point > 49
            on += $mood.point if @active_battler.excited? or $mood.point > 49
          when "�V�R"
            at += $mood.point
            on += $mood.point
          when "�]��"
            at += $mood.point
            at += $mood.point if @active_battler.excited? and $mood.point > 49
          when "����"
            at += $mood.point if $mood.point < 50
            on += $mood.point if @active_battler.excited?
          when "�|��"
            at += $mood.point * 2
            on += $mood.point * 2
          when "�s�v�c"
            at += rand($mood.point)
            on += rand($mood.point)
          #�{�X�ȂǗ�O�̐��i
          else
            at += $mood.point if @active_battler.excited?
            on += $mood.point if @active_battler.excited?
          end
          #�������z�[���h���̏ꍇ�͍s��Ȃ�
          unless @active_battler.holding?
            #�^�[�Q�b�g���z�[���h��ԂȂ�z�[���h��p�̍U�߂��s��
            if @target_battlers[0].holding?
              action = [956,956,968]
              if @target_battlers[0].boy? or @target_battlers[0].futanari?
                action.push(962,962,963) if @target_battlers[0].hold.penis.battler == nil
                action.push(963,958) if @target_battlers[0].hold.penis.type == "���}��"
              end
              if @target_battlers[0].girl?
                action.push(957,957) if @target_battlers[0].hold.tops.battler == nil
                action.push(958,958) if @target_battlers[0].hold.anal.battler == nil
                action.push(959) if rand(100) < pc3 and @target_battlers[0].hold.anal.battler == nil
                action.push(960,960) if @target_battlers[0].hold.vagina.battler == nil
                action.push(961) if @target_battlers[0].nude?
              end
              action.push(967)if at > rand(100)
              action.push(969)if on > rand(100)
            #�^�[�Q�b�g���z�[���h��ԂłȂ�(�����Ƌ��Ɋϋq���)�Ȃ�󋵂ɂ���ă����_���ɍs�������
            else
              action = [968,968,968] #�ώ@
#              action.push(251,251,251) unless @active_battler.nude? #�����E��
              action.push(257,257,257) unless @target_battlers[0].nude? #����E��
              action.push(967)if at > rand(100) #�����U��
              action.push(969)if on > rand(100) #����
            end
          end
        end
        if count >= 1
          if action != []
            for i in action.clone
              if not @active_battler.skill_can_use?(i)
                action -= [i]
              end
            end
          end
          # �J�E���g���P�ȏ㊎�A�A�N�V�����������ꍇ�A
          # ����͗����̃A�N�^�[�Ɏg�p�ł��Ȃ����̂ł���B
          # ���̂��߁A�g�p�����̖����ʂ̃A�N�V����������B
          if action == []
            # �Q���Ŗ��Q�A�N�V����
            if 20 > rand(100)
              # �G���[�V����
              action = [299]
              # �^�[�Q�b�g���z�[���h���͌��w�E����
              action = [968] if @target_battlers[0].holding?
              # �������z�[���h�����A���[�h�����Ŏ���
              action = [969] if @active_battler.holding? and $mood.point < rand(120)
              # �������㔼�g�S���A�G��S�����󂯂Ă���ꍇ�͌��w�E����
              action = [968] if @active_battler.tops_binding? or @active_battler.tentacle_binding?
              #�s���G�l�~�[��VP���������ꍇ�A�񕜂�����
              action = [970] if @active_battler.holding? and @active_battler.sp < (@active_battler.maxsp / 5).floor
            else
              # ���ߒ����w��
              action = [279]
            end
          end
          break
        elsif count == 0
          if action != []
            for i in action.clone
              if not @active_battler.skill_can_use?(i)
                action -= [i]
              end
            end
          end
          # �J�E���g���O���A�A�N�V�����������ꍇ�A
          # �ʂ̃A�N�^�[���^�[�Q�b�g�ɂ��Ċm�F����B
          if action == []
            count += 1
            if @target_battlers[0] == $game_actors[101]
              for actor in $game_party.actors
                if actor.exist? and actor != $game_actors[101]
                  @target_battlers[0] = actor
                  $game_temp.battle_target_battler[0] = actor
                end
              end
            else
              @target_battlers[0] = $game_actors[101]
              $game_temp.battle_target_battler[0] = $game_actors[101]
            end
            next
          else
            break
          end
        end
      end
    end
    # �S�A�N�V�������m�F���A�g�p�ł��Ȃ����̂����ׂĊO��
    for i in action
      action.delete(i) unless @active_battler.skill_can_use?(i)
    end
    

    # �A�N�V�����������ꍇ�A�G���[�V������
    if action == []
      # �G���[�V����
      action = [299]
    end
   
    
    @active_battler.current_action.skill_id = action[rand(action.size)]
    attack_element_check
    # ���X�L���g�p
    @skill = $data_skills[@active_battler.current_action.skill_id]
    @active_battler.current_action.kind = 1
    if @skill.scope == 7 #�����ɍs������
      $game_temp.attack_combo_target = @active_battler
      @target_battlers = []
      @target_battlers.push($game_temp.attack_combo_target)
      # ���^�[�Q�b�g�o�g���[�̏����L��
      $game_temp.battle_target_battler = @target_battlers
    elsif @skill.scope == 3 #�����P�̂ɍs������
      if @skill.id == 967
        bx = []
        for enemy in $game_troop.enemies
          if enemy.exist? and enemy != @active_battler and enemy.holding?
            bx.push(enemy)
          end
        end
        $game_temp.attack_combo_target = bx[rand(bx.size)] if bx != []
      else
        bx = []
        for enemy in $game_troop.enemies
          if enemy.exist? and enemy != @active_battler
            bx.push(enemy)
          end
        end
        $game_temp.attack_combo_target = bx[rand(bx.size)] if bx != []
      end
      @target_battlers = []
      @target_battlers.push($game_temp.attack_combo_target)
      # ���^�[�Q�b�g�o�g���[�̏����L��
      $game_temp.battle_target_battler = @target_battlers
    end
    if @active_battler.is_a?(Game_Enemy)
      @active_battler.current_action.decide_random_target_for_enemy
    elsif  @active_battler.is_a?(Game_Actor)
      @active_battler.current_action.decide_random_target_for_actor
    end
    $game_temp.battle_target_battler = @target_battlers
    # ���L�������X�L��������
    $game_temp.skill_selection = nil
  end
  #--------------------------------------------------------------------------
  # �� �U���X�L���̑����`�F�b�N(�ǌ��A�Ⓒ���㐧��Ɏg�p)
  #--------------------------------------------------------------------------
  def attack_element_check
    #�G���[�����΍�(@0830)
    return if @active_battler == nil
    return if $data_skills[@active_battler.current_action.skill_id].name == ""
#    p "#{@active_battler.name}�^#{@active_battler.current_action.skill_id}" if $DEBUG
    # ���ǌ��p�ɁA�X�L��id����U�����ʂ��m�F
    sid = $data_skills[@active_battler.current_action.skill_id]
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #�A�N�^�[���̓����_���X�L���I�莞��type�w������Ă��Ȃ��̂ł����Őݒ�
    if @active_battler.is_a?(Game_Actor)
      $msg.at_type = sid.name
    end
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #���}���U���F�y�j�X��
    if sid.element_set.include?(142)
      $msg.at_parts = "���}���F�y�j�X��"
    #���}���U���F�y�j�X��
    elsif sid.element_set.include?(143)
      $msg.at_parts = "���}���F�y�j�X��"
    #�K�}���U���F�y�j�X��
    elsif sid.element_set.include?(144)
      $msg.at_parts = "�K�}���F�y�j�X��"
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #���}���U���F����
    elsif sid.element_set.include?(148)
      $msg.at_parts = "���}���F����"
    #��ʋR��U���F����
    elsif sid.element_set.include?(149)
      $msg.at_parts = "�R��F����"
    #�K�R��U���F����
    elsif sid.element_set.include?(145)
      $msg.at_parts = "�K�R��F����"
    #�N���j�U���F����
    elsif sid.element_set.include?(150)
      $msg.at_parts = "�N���j"
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #�K�}���U���F�K��
    elsif sid.element_set.include?(153)
      $msg.at_parts = "�K�}���F�K��"
    #�K�R��U���F�K��
    elsif sid.element_set.include?(154)
      $msg.at_parts = "�K�R��F�K��"
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #���}���U���F����
    elsif sid.element_set.include?(157)
      $msg.at_parts = "���}���F�A�\�R��"
    #��ʋR��U���F����
    elsif sid.element_set.include?(158)
      $msg.at_parts = "�R��F�A�\�R��"
    #�L���킹�U��
    elsif sid.element_set.include?(159)
      $msg.at_parts = "�L���킹"
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #�p�C�Y���U��
    elsif sid.element_set.include?(160)
      $msg.at_parts = "�p�C�Y��"
    #�w�ʍS�����U��
    elsif sid.element_set.include?(163)
      $msg.at_parts = "�w�ʍS��"
    #�J�r�S�����U��
    elsif sid.element_set.include?(164)
      $msg.at_parts = "�J�r�S��"
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #�K�����}���U��
    elsif sid.element_set.include?(167)
      $msg.at_parts = "�K�����}��"
    #�K�����}���U��
    elsif sid.element_set.include?(168)
      $msg.at_parts = "�K�����}��"
    #�K���K�}���U��
    elsif sid.element_set.include?(169)
      $msg.at_parts = "�K���K�}��"
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #�G�聊�}���U��
    elsif sid.element_set.include?(172)
      $msg.at_parts = "�G�聊�}��"
    #�G����}���U��
    elsif sid.element_set.include?(173)
      $msg.at_parts = "�G����}��"
    #�G��K�}���U��
    elsif sid.element_set.include?(174)
      $msg.at_parts = "�G��K�}��"
    #�G��S�����U��
    elsif sid.element_set.include?(175)
      $msg.at_parts = "�G��S��"
    #�G��S�����U��
    elsif sid.element_set.include?(176)
      $msg.at_parts = "�G��J�r�S��"
    #�f�B���h���}���U��
    elsif sid.element_set.include?(183)
      $msg.at_parts = "�f�B���h���}��"
    #�f�B���h���}���U��
    elsif sid.element_set.include?(184)
      $msg.at_parts = "�f�B���h���}��"
    #�f�B���h�K�}���U��
    elsif sid.element_set.include?(185)
      $msg.at_parts = "�f�B���h�K�}��"
    #�G�聉�z���U��
    elsif sid.element_set.include?(186)
      $msg.at_parts = "�G�聉�z��"
    #�G�聊�N���j�U��
    elsif sid.element_set.include?(187)
      $msg.at_parts = "�G�聊�z��"
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #�ڎg�p�̍U��
    elsif sid.element_set.include?(85)
      $msg.at_parts = "�g�p�F��"
    #����g�p�̍U��
    elsif sid.element_set.include?(86)
      $msg.at_parts = "�g�p�F�ٔ�"
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #���Ώۂ̍U��
    elsif sid.element_set.include?(91)
      $msg.at_parts = "�ΏہF��"
    #���A����Ώۂ̍U��
    elsif sid.element_set.include?(92)
      $msg.at_parts = "�ΏہF��"
    #�K�Ώۂ̍U��
    elsif sid.element_set.include?(93)
      $msg.at_parts = "�ΏہF�K"
    #�A�i���Ώۂ̍U��
    elsif sid.element_set.include?(94)
      $msg.at_parts = "�ΏہF�A�i��"
    #�y�j�X�Ώۂ̍U��
    elsif sid.element_set.include?(95)
      $msg.at_parts = "�ΏہF�y�j�X"
    #�ΊۑΏۂ̍U��
    elsif sid.element_set.include?(96)
      $msg.at_parts = "�ΏہF�Ί�"
    #�A�\�R�Ώۂ̍U��
    elsif sid.element_set.include?(97)
      $msg.at_parts = "�ΏہF�A�\�R"
    #�A�j�Ώۂ̍U��
    elsif sid.element_set.include?(98)
      $msg.at_parts = "�ΏہF�A�j"
    #���̑����ʂ��Ώۂ̍U��
    elsif sid.element_set.include?(99)
      $msg.at_parts = "�ΏہF���̑��g��"
    #���o�Ώۂ̍U��
    elsif sid.element_set.include?(100)
      $msg.at_parts = "�ΏہF���o"
    #���o�Ώۂ̍U��
    elsif sid.element_set.include?(101)
      $msg.at_parts = "�ΏہF���o"
    end
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    #�\���s�����͕K���u���̑��g�́v�ɑΏۂ��Z�b�g����邽�߁A
    #�����t�^���܂߂čđ��U����
    sid.element_set.delete(99) if sid.element_set.include?(99)#�g��
    if $msg.at_type == "�\���s��"
      case sid.id
      #�\������(VP�؂ꎞ���܂�)
      when 981,982,987
        parts = []
        if @target_battlers[0].hold.mouth.battler == nil or @target_battlers[0].hold.mouth.battler == @active_battler
          parts.push("�ΏہF��","�ΏہF��")
        end
        if @target_battlers[0].hold.tops.battler == nil or @target_battlers[0].hold.tops.battler == @active_battler
          parts.push("�ΏہF��","�ΏہF��")
        end
        if @target_battlers[0].hold.anal.battler == nil or @target_battlers[0].hold.anal.battler == @active_battler
          parts.push("�ΏہF�K","�ΏہF�K")
        end
        if @target_battlers[0].girl? or @target_battlers[0].futanari?
          if @target_battlers[0].hold.vagina.battler == nil or @target_battlers[0].hold.vagina.battler == @active_battler
            parts.push("�ΏہF�A�\�R","�ΏہF�A�\�R")
          end
        end
        if @target_battlers[0].boy? or @target_battlers[0].futanari?
          if @target_battlers[0].hold.penis.battler == nil or @target_battlers[0].hold.penis.battler == @active_battler
            parts.push("�ΏہF�y�j�X","�ΏہF�y�j�X")
          end
        end
        #�U�����ʌ���
        if parts == []
          $msg.at_parts = "�ΏہF���̑��g��"
        else
          parts = parts[rand(parts.size)]
        end
        #�������U(���Ɍ��肳��Ă���ꍇ�͕�)
        unless $msg.at_parts == "�ΏہF���̑��g��"
          $msg.at_parts = parts
          case parts
          when "�ΏہF��"
            sid.element_set.push(91)
          when "�ΏہF��"
            sid.element_set.push(92)
          when "�ΏہF�K"
            sid.element_set.push(93)
          when "�ΏہF�A�\�R"
            sid.element_set.push(97)
          when "�ΏہF�y�j�X"
            sid.element_set.push(95)
          end
        end
      #�\���s�X�g���E�O���C���h
      when 983,984,985,986
        sid.element_set.delete(80) if sid.element_set.include?(80)#�g�̎g�p
        #�y�j�X�n
        if @active_battler.penis_insert?
          $msg.at_parts = "���}���F�y�j�X��"
          sid.element_set.push(74,97)
        elsif @active_battler.penis_oralsex?
          $msg.at_parts = "���}���F�y�j�X��"
          sid.element_set.push(74,91)
        elsif @active_battler.mouth_oralsex?
          $msg.at_parts = "���}���F����"
          sid.element_set.push(72,91)
        elsif @active_battler.penis_analsex?
          $msg.at_parts = "�K�}���F�y�j�X��"
          sid.element_set.push(74,94)
        #�K���n
        elsif @active_battler.tail_insert?
          $msg.at_parts = "�K�����}��"
          sid.element_set.push(78,97)
        elsif @active_battler.tail_oralsex?
          $msg.at_parts = "�K�����}��"
          sid.element_set.push(78,91)
        elsif @active_battler.tail_analsex?
          $msg.at_parts = "�K���K�}��"
          sid.element_set.push(78,94)
        #�G��n
        elsif @active_battler.tentacle_insert?
          $msg.at_parts = "�G�聊�}��"
          sid.element_set.push(79,97)
        elsif @active_battler.tentacle_oralsex?
          $msg.at_parts = "�G����}��"
          sid.element_set.push(79,91)
        elsif @active_battler.tentacle_analsex?
          $msg.at_parts = "�G��K�}��"
          sid.element_set.push(79,94)
        #�f�B���h�n
        elsif @active_battler.dildo_insert?
          $msg.at_parts = "�f�B���h���}��"
          sid.element_set.push(81,97)
        elsif @active_battler.dildo_oralsex?
          $msg.at_parts = "�f�B���h���}��"
          sid.element_set.push(81,91)
        elsif @active_battler.dildo_analsex?
          $msg.at_parts = "�f�B���h�K�}��"
          sid.element_set.push(81,94)
        #���̑�
        elsif @active_battler.mouth_draw?
          $msg.at_parts = "�N���j"
          sid.element_set.push(72,97,98)
        elsif @active_battler.mouth_riding?
          $msg.at_parts = "�R��F����"
          sid.element_set.push(75,91)
        elsif @active_battler.mouth_hipriding?
          $msg.at_parts = "�K�R��F����"
          sid.element_set.push(76,91)
        elsif @active_battler.tops_paizuri?
          $msg.at_parts = "�p�C�Y��"
          sid.element_set.push(73,95)
        elsif @active_battler.tentacle_absorb?
          $msg.at_parts = "�G�聉�z��"
          sid.element_set.push(79,95)
        elsif @active_battler.tentacle_draw?
          $msg.at_parts = "�G�聊�z��"
          sid.element_set.push(79,97,98)
        elsif @active_battler.vagina_insert?
          $msg.at_parts = "���}���F�A�\�R��"
          sid.element_set.push(75,95)
        elsif @active_battler.vagina_riding?
          $msg.at_parts = "�R��F�A�\�R��"
          sid.element_set.push(75,91)
        elsif @active_battler.shellmatch?
          $msg.at_parts = "�L���킹"
          sid.element_set.push(75,97)
        elsif @active_battler.anal_analsex?
          $msg.at_parts = "�K�}���F�K��"
          sid.element_set.push(76,95)
        elsif @active_battler.anal_hipriding?
          $msg.at_parts = "�K�R��F�K��"
          sid.element_set.push(76,91)
        end
      end
    end
  end
  
  
end