#==============================================================================
# �� Scene_Menu
#------------------------------------------------------------------------------
# �@���j���[��ʂ̏������s���N���X�ł��B
#==============================================================================

class Scene_Menu
  #--------------------------------------------------------------------------
  # �� �t���[���X�V�i�A�C�e���j
  #--------------------------------------------------------------------------
  def update_item
    # �E�B���h�E���X�V
    @help_window.update
    @item_window.update
    @target_window.update
    # �A�C�e���E�B���h�E���A�N�e�B�u�̏ꍇ: update_item ���Ă�
    if @item_window.active
      update_item_active
      return
    end
    # �^�[�Q�b�g�E�B���h�E���A�N�e�B�u�̏ꍇ: update_target ���Ă�
    if @target_window.active
      update_target_active
      return
    end
        
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�A�C�e���E�B���h�E���A�N�e�B�u�̏ꍇ)
  #--------------------------------------------------------------------------
  def update_item_active

    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �㕔�e�L�X�g��߂�
      @overF_text = $game_party.gold.to_s + "�@" + $data_system.words.gold
      @help_window.visible = false
      @help_window.window.visible = false
      @item_window.visible = false
      @window[0].visible = false
      @target_window.visible = false
      # ���j���[�ɖ߂�
      @command = 0
      @fade_flag = 5
      return
    end

    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # �A�C�e���E�B���h�E�Ō��ݑI������Ă���f�[�^���擾
      @item = @item_window.item
      # �g�p�A�C�e���ł͂Ȃ��ꍇ
      unless @item.is_a?(RPG::Item)
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      # �g�p�ł��Ȃ��ꍇ
      unless $game_party.item_can_use?(@item.id)
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        # ���G���[���b�Z�[�W��\��
        $game_temp.message_text = $game_temp.error_message if $game_temp.error_message != ""
        $game_temp.error_message = ""
        return
      end
      # ���� SE �����t
      $game_system.se_play($data_system.decision_se)
      # ���ʔ͈͂������̏ꍇ
      if @item.scope >= 3
        # �^�[�Q�b�g�E�B���h�E���A�N�e�B�u��
        @item_window.visible = false
        @item_window.active = false
        @target_window.y = 40
        @target_window.visible = true
        @target_window.active = true
        @target_window.icon = @item.icon_name
        @target_window.name = @item.name
        @target_window.refresh

        # ���ʔ͈� (�P��/�S��) �ɉ����ăJ�[�\���ʒu��ݒ�
        if @item.scope == 4 || @item.scope == 6
          @target_window.index = -1
        else
          @target_window.index = 0
        end
      # ���ʔ͈͂������ȊO�̏ꍇ
      else
        # �R�����C�x���g ID ���L���̏ꍇ
        if @item.common_event_id > 0
          # �R�����C�x���g�Ăяo���\��
          $game_temp.common_event_id = @item.common_event_id
          # �A�C�e���̎g�p�� SE �����t
          $game_system.se_play(@item.menu_se)
          # ���Օi�̏ꍇ
          if @item.consumable
            # �g�p�����A�C�e���� 1 ���炷
            $game_party.lose_item(@item.id, 1)
            # �A�C�e���E�B���h�E�̍��ڂ��ĕ`��
            @item_window.draw_item(@item_window.index)
          end
          @item_window.visible = false
          # �}�b�v��ʂɐ؂�ւ�
          @fade_flag = 6
          return
        end
      end
      return
    end
  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V (�^�[�Q�b�g�E�B���h�E���A�N�e�B�u�̏ꍇ)
  #--------------------------------------------------------------------------
  def update_target_active
    # B �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::B)
      # �L�����Z�� SE �����t
      $game_system.se_play($data_system.cancel_se)
      # �A�C�e���؂�ȂǂŎg�p�ł��Ȃ��Ȃ����ꍇ
      unless $game_party.item_can_use?(@item.id)
        # �A�C�e���E�B���h�E�̓��e���č쐬
        @item_window.refresh
      end
      # �^�[�Q�b�g�E�B���h�E������
      @item_window.active = true
      @item_window.visible = true
      @target_window.visible = false
      @target_window.active = false
      return
    end
    # C �{�^���������ꂽ�ꍇ
    if Input.trigger?(Input::C)
      # �A�C�e�����g���؂����ꍇ
      if $game_party.item_number(@item.id) == 0
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      # �����p�H���̏ꍇ
      if $data_items[@item.id].element_set.include?(127)
        # �^�[�Q�b�g�擾
        target = $game_party.actors[@target_window.index]
        # �Ώۂ���l���̏ꍇ�͎g�p�s��
        if target == $game_actors[101]
          $game_temp.error_message = "#{$game_actors[101].name} cannot use this item."
          # �u�U�[ SE �����t
          $game_system.se_play($data_system.buzzer_se)
          # ���G���[���b�Z�[�W��\��
          $game_temp.message_text = $game_temp.error_message if $game_temp.error_message != ""
          $game_temp.error_message = ""
          return
        elsif target.fed == 100
          $game_temp.error_message = "#{target.name} cannot use this item on a full stomach."
          # �u�U�[ SE �����t
          $game_system.se_play($data_system.buzzer_se)
          # ���G���[���b�Z�[�W��\��
          $game_temp.message_text = $game_temp.error_message if $game_temp.error_message != ""
          $game_temp.error_message = ""
          return
        end
      end
      # ���x���A�b�v�A�C�e���̏ꍇ
      if $data_items[@item.id].element_set.include?(201)
        # �^�[�Q�b�g�擾
        target = $game_party.actors[@target_window.index]
        # ���x�����ő傾�Ǝg�p�s��
        if target.level >= $MAX_LEVEL
          $game_temp.error_message = "#{target.name} cannot level any further."
          # �u�U�[ SE �����t
          $game_system.se_play($data_system.buzzer_se)
          # ���G���[���b�Z�[�W��\��
          $game_temp.message_text = $game_temp.error_message if $game_temp.error_message != ""
          $game_temp.error_message = ""
          return
        end
      end
      # �^�[�Q�b�g���S�̂̏ꍇ
      if @target_window.index == -1
        # �p�[�e�B�S�̂ɃA�C�e���̎g�p���ʂ�K�p
        used = false
        for i in $game_party.actors
          used |= i.item_effect(@item)
        end
      end
      # �^�[�Q�b�g���P�̂̏ꍇ
      if @target_window.index >= 0
        # �^�[�Q�b�g�̃A�N�^�[�ɃA�C�e���̎g�p���ʂ�K�p
        target = $game_party.party_actors[@target_window.index]
        used = target.item_effect(@item)
      end
      # �A�C�e�����g�����ꍇ
      if used
        # �A�C�e���̎g�p�� SE �����t
        $game_system.se_play(@item.menu_se)
        # ���Օi�̏ꍇ
        if @item.consumable
          # �g�p�����A�C�e���� 1 ���炷
          $game_party.lose_item(@item.id, 1)
          # �A�C�e���E�B���h�E�̍��ڂ��ĕ`��
          @item_window.draw_item(@item_window.index)
        end
        # �^�[�Q�b�g�E�B���h�E�̓��e���č쐬
        @target_window.refresh
        center_refresh
        # �S�ł̏ꍇ
        if $game_party.all_dead?
          # �Q�[���I�[�o�[��ʂɐ؂�ւ�
          $scene = Scene_Gameover.new
          return
        end
        # �R�����C�x���g ID ���L���̏ꍇ
        if @item.common_event_id > 0
          # �R�����C�x���g�Ăяo���\��
          $game_temp.common_event_id = @item.common_event_id
          @item_window.visible = false
          # �}�b�v��ʂɐ؂�ւ�
          @fade_flag = 6
          return
        end
      end
      # �A�C�e�����g��Ȃ������ꍇ
      unless used
        # �u�U�[ SE �����t
        $game_system.se_play($data_system.buzzer_se)
      end
      return
    end
  end
end