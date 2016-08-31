#==============================================================================
# �� Resist_Game
#------------------------------------------------------------------------------
# �����W�X�g�Q�[��(��󉟂��Q�[��)���s��
#==============================================================================
class Resist_Game < Window_Base
  #--------------------------------------------------------------------------
  # �� ���J�C���X�^���X�ϐ�
  #--------------------------------------------------------------------------
    attr_accessor   :win                    # �Q�[���E�B���h�E
    attr_accessor   :text                   # �e�L�X�g�`��p
    attr_accessor   :test_i                 # �Ȃ�ł��ϐ�(�e�X�g�p)
    attr_accessor   :test_y                 # �Ȃ�ł��ϐ�(�e�X�g�p)
    
    attr_accessor   :max                    # ���� �ő��
    attr_accessor   :target                 # ���� ���ݑ��쒆�̔ԍ�
    attr_accessor   :yajirusi_bitmap        # ���� �摜(�z��)
    attr_accessor   :yajirusi_sprite        # ���� �`��p(�z��)
    attr_accessor   :yajirusi_list          # ���� ����(�z��)
    attr_accessor   :set_x                  # �\���ʒu�w���W
    attr_accessor   :set_y                  # �\���ʒu�x���W
    attr_accessor   :bar_bitmap             # �������ԃo�[�`��p
    attr_accessor   :bar_sprite             # �������ԃo�[�`��p
    attr_accessor   :success_bitmap         # ��������`��p
    
    attr_accessor   :wait_count             # �E�F�C�g�J�E���g
    attr_accessor   :time_count             # �^�C���J�E���g
    attr_accessor   :limit_count            # ���~�b�g(��������)�J�E���g
    attr_accessor   :limit_count_max        # ���~�b�g(��������)�ő�l
  #--------------------------------------------------------------------------
  # �� �I�u�W�F�N�g������
  #--------------------------------------------------------------------------
  #  �E���̌�����0~3�̐��l�ŕ\���B(0�� 1�� 2�� 3��)
  #  �E����\������z��̕ϐ���1����n�܂�B(���𕪂���₷�����邽��)
  #--------------------------------------------------------------------------
  def initialize(yajirusi_max = 10, type = 1, time = 4, impossible = false)

    # �ϐ��̏�����
    @wait_count = 0
    @time_count = 0
    
    case time
    when 0 #�P�\�Ȃ�
      n = 48
    when 1 #�W��
      n = 60
    when 2 #�P�\����
      n = 88
    when 3 #�ڑ҃��[�h
      n = 144
    else
      n = 72
    end
    if $game_temp.resistgame_timer != nil
      @limit_count_max = $game_temp.resistgame_timer
      #�P��K�p���邲�ƂɕK������������
      $game_temp.resistgame_timer = nil
    else
      @limit_count_max = n
    end
    @limit_count = @limit_count_max
    @impossible = impossible
    @impossible = $game_switches[182]
    @max = yajirusi_max # �����l��10�B�ĂԎ��ɔC�ӂ̐��ɂł���(1�ȏ�)
    @target = 1
    @set_x = 0          # �E�B���h�E�Ɩ��̍��W��A��������p
    @set_y = -30
    @yajirusi_bitmap = []
    @yajirusi_sprite = []
    #@yajirusi_list = []

    #������
    @text = Sprite.new
    @text.bitmap = Bitmap.new(640,480)
    
    @test_i = 0
    @test_y = 0

    # �r�b�g�}�b�v�̏��� (�摜��ǂݍ���)
    # �������ߖ�̂��߁A��U�uRPG::Cache�v�����܂��ăZ�b�g����
    # ��2��ڈȍ~�ĂԎ��͉摜�t�@�C�����Q�Ƃ��Ȃ��̂Ōy���Ȃ�(�ō����Ă�H)
    @yajirusi_bitmap[1] = RPG::Cache.picture("yajirusi_black")
    @yajirusi_bitmap[2] = RPG::Cache.picture("yajirusi_blue")
    @yajirusi_bitmap[3] = RPG::Cache.picture("yajirusi_red") # ����ɍ����
    @yajirusi_bitmap[4] = RPG::Cache.picture("yajirusi_white")
    # �o�b�N�E�B���h�E
    @yajirusi_bitmap[5] = RPG::Cache.picture("window_resist")
    @yajirusi_bitmap[6] = RPG::Cache.picture("window_attack")
    
    # �X�v���C�g�̏�����
    # �z���0�Ԗڂ����������Ȃ��̂Ńo�b�N�E�B���h�E���Z�b�g����
    @yajirusi_sprite[0] = Sprite.new
    @yajirusi_sprite[0].x = @set_x 
    @yajirusi_sprite[0].y = @set_y
    @yajirusi_sprite[0].z = 1
    # �o�b�N�E�B���h�E�̎�ޑI�� [5]��[6]
    if type == 0 
      back_window = yajirusi_bitmap[5]
    else
      back_window = yajirusi_bitmap[6]
    end
    @yajirusi_sprite[0].bitmap = back_window
    @yajirusi_sprite[0].visible = true
    @yajirusi_sprite[0].opacity = 0
    
    # ���̍ő吔�܂ŃZ�b�g����(max)
    for i in 1..max
      @yajirusi_sprite[i] = Sprite.new
      @yajirusi_sprite[i].x = @set_x + 117 + (45 * (i - 1)) # ���ׂĔz�u
      @yajirusi_sprite[i].y = @set_y + 264
      @yajirusi_sprite[i].z = 1
      @yajirusi_sprite[i].ox = 22   # x���̒��S�_���Z�b�g(44 * 44)
      @yajirusi_sprite[i].oy = 22   # y���̒��S�_���Z�b�g(44 * 44)
      @yajirusi_sprite[i].angle = (rand(4) * 90)  # 0~3�̒l(���̌���)���擾
      @yajirusi_sprite[i].bitmap = yajirusi_bitmap[1] # ���̏������(��)
      @yajirusi_sprite[i].visible = true
      @yajirusi_sprite[i].opacity = 0
    end
    
    unless @impossible
      @yajirusi_sprite[1].bitmap = yajirusi_bitmap[4] # 1�ڂ̖��̐F��ς���
    end
    
    # �������ԃo�[���Z�b�g
    @bar_bitmap = Bitmap.new(200,5)
    # �X�v���C�g
    @bar_sprite = Sprite.new
    @bar_sprite.bitmap = @bar_bitmap
    @bar_sprite.x = @set_x + 220
    @bar_sprite.y = @set_y + 300
    @bar_sprite.z = 1
    @bar_sprite.visible = true

    @success_bitmap = []
    
    # ���۔�����Z�b�g
    for i in 0..3
      @success_bitmap[i] = Sprite.new
      @success_bitmap[i].x = @set_x + 220
      @success_bitmap[i].y = @set_y + 218
      @success_bitmap[i].z = 1
      @success_bitmap[i].bitmap = Bitmap.new(200,64)
      @success_bitmap[i].visible = true
      @success_bitmap[i].opacity = 0
      @success_bitmap[i].bitmap.font.name = ["���˖��� Pro B", "HGP�s����", "���C���I"]
      @success_bitmap[i].bitmap.font.size = 28
    end
    
    @success_bitmap[0].bitmap.draw_text(0, 0, 200, 30, "Success!", 1)
    @success_bitmap[1].bitmap.draw_text(0, 0, 200, 30, "failure...", 1)
    @success_bitmap[2].bitmap.draw_text(0, 0, 200, 30, "Acceptance�I", 1)
    @success_bitmap[3].bitmap.draw_text(0, 0, 200, 30, "Dissuade...�I", 1)
    
  end
  #--------------------------------------------------------------------------
  # �� �ꎞ�B��/�o��
  #--------------------------------------------------------------------------  
  def hide
    @bar_sprite.visible = false
    @text.visible = false
    for i in 0..max
      @yajirusi_sprite[i].visible = false
    end
    for i in 0..3
      @success_bitmap[i].visible = false
    end
  end
  def appear
    @bar_sprite.visible = true
    @text.visible = true
    for i in 0..max
      @yajirusi_sprite[i].visible = true
    end
    for i in 0..3
      @success_bitmap[i].visible = true
    end
  end
  #--------------------------------------------------------------------------
  # �� �{��
  #--------------------------------------------------------------------------
  def game_start
    unless $game_temp.resistgame_flag >= 3
      # �t�F�[�h�C������
      for i in 0..@yajirusi_sprite.size - 1
        if @yajirusi_sprite[i].opacity < 255
          @yajirusi_sprite[i].opacity += 70
          return
        end
      end

      # �N���A�����𖞂������A���Ԑ؂�ŏI���
      if $game_temp.resistgame_clear == true # �N���A����
        # SE �����t
        Audio.se_play("Audio/SE/055-Right01", 80, 100)
        $game_temp.resistgame_flag = 3
    
      elsif @limit_count <= 0 #���s����(���Ԑ؂�)
        if $game_switches[89] == true
          # SE �����t
          Audio.se_play("Audio/SE/AC_Heal7", 80, 70)
          $game_temp.resistgame_flag = 3
        else
          # SE �����t
          Audio.se_play("Audio/SE/058-Wrong02", 80, 100)
          $game_temp.resistgame_flag = 3
        end
        
      else
        # ��R�s�ȊO�̏ꍇ�̓��C������
        unless @impossible
          
          if @wait_count <= 0
            #�y�i���e�B�̉����������̐F��߂�
            @yajirusi_sprite[@target].bitmap = yajirusi_bitmap[4] #��
          end
    
          # angle�̊p�x�Ō����𔻒f����(0�x�� 90�x�� 180�x�� 270�x��)
          dir = 0
          case @yajirusi_sprite[@target].angle
          when 0 then   #��
            dir = Input::DOWN
          when 90 then  #��
            dir = Input::RIGHT
          when 180 then #��
            dir = Input::UP
          when 270 then #��
            dir = Input::LEFT
          end
        
          # �������� (target�Ԗڂ̖��L�[����������)
          # �����L�[�����������ɂ������肷��
          # ���A�~�X�y�i���e�B���͑�����󂯕t���Ȃ�
          if (Input.trigger?(Input::DOWN)   \
            || Input.trigger?(Input::RIGHT) \
            || Input.trigger?(Input::UP)    \
            || Input.trigger?(Input::LEFT)) \
            && @wait_count <= 0
           
            if Input.trigger?(dir)
              # ����
              # �����������̐F��ς���
              @yajirusi_sprite[@target].bitmap = yajirusi_bitmap[3] #��
              # SE �����t
              Audio.se_play("Audio/SE/002-System02", 80, 100)
              # ���̖��ɐi��
              @target += 1
              #�Ō�܂ŉ�����������Q�[���N���A
              if @target > max
                $game_temp.resistgame_clear = true
              else
                #�܂��c���Ă���ΑΏۂ̖��̐F��ς���
                @yajirusi_sprite[@target].bitmap = yajirusi_bitmap[4] #��
              end
            else
            #�~�X
            # SE �����t
            Audio.se_play("Audio/SE/057-Wrong01", 80, 100)
            # ����s�\���Ԃ�ݒ�
            @wait_count = 10
            @limit_count -= 0
            # ��莞�� ���̐F��ς���
            @yajirusi_sprite[@target].bitmap = yajirusi_bitmap[2] #��
            end
          end
          # �L�����Z���L�[�������ƒ�R���Ȃ�
          if Input.trigger?(Input::B)
            # SE �����t
            Audio.se_play("Audio/SE/004-System04", 80, 100)
            @wait_count = 10
            @limit_count -= 200
            $game_switches[89] = true if $game_switches[89] == false
          end
        else
          if Input.trigger?(Input::DOWN)   \
            || Input.trigger?(Input::RIGHT) \
            || Input.trigger?(Input::UP)    \
            || Input.trigger?(Input::LEFT) \
            && @wait_count <= 0
            # SE �����t
            Audio.se_play("Audio/SE/004-System04", 80, 100)
          end
          # �L�����Z���L�[�������ƒ�R���Ȃ�
          if Input.trigger?(Input::B)
            # SE �����t
            Audio.se_play("Audio/SE/004-System04", 80, 100)
            @wait_count = 10
            @limit_count -= 100
            $game_switches[89] = true if $game_switches[89] == false
          end

        end
      end
      
    
      @bar_bitmap.clear
      #���~�b�g(��������)�o�[��`��
      @bar_bitmap.fill_rect(0,0,@limit_count * @bar_sprite.bitmap.width / @limit_count_max,5, \
                          Color.new(255,255,255,255))
      @bar_sprite.bitmap = @bar_bitmap

      #--�f�o�b�O�p�����u����----------------------------------------
      
      #�t���[���m�F�p
      #@text.bitmap.clear
      #@text.bitmap.draw_text(10, 450, 640, 30, @limit_count.to_s)

      #�L�[�擾����
      #Input.trigger?(Input::UP)
      
      for i in 1..max
        #@yajirusi_sprite[i].visible = true
      end
    
      #@yajirusi_sprite[1].angle = @test_i
      @test_i += 3
      if @test_i > 360
        @test_i = 0
      end
      #---------------------------------------------------------------
    
      #�J�E���g�A�b�v��_�E��
      @time_count += 1
      @limit_count -= 1

    end

  
    # ���۔���`��
    
    if $game_temp.resistgame_flag == 3
      if $game_temp.resistgame_clear == true
        if @success_bitmap[0].opacity < 255
          @success_bitmap[0].opacity += 30
        end
        if @success_bitmap[0].y > @set_y + 210
          @success_bitmap[0].y -= 1
          return
        end
      else
        #�L�����Z�������ꍇ
        if $game_switches[89] == true
          #�A�N�^�[����d�|���ăL�����Z�������ꍇ
          if $game_temp.battle_active_battler.is_a?(Game_Actor) and
            not $game_switches[79] == true #�g�[�N���͎��_���t�ɂȂ�
            if @success_bitmap[3].opacity < 255
              @success_bitmap[3].opacity += 30
            end
            if @success_bitmap[3].y > @set_y + 210
              @success_bitmap[3].y -= 1
              return
            end
          #�G�l�~�[����d�|�����Ď󂯓��ꂽ�ꍇ
          else
            if @success_bitmap[2].opacity < 255
              @success_bitmap[2].opacity += 30
            end
            if @success_bitmap[2].y > @set_y + 210
              @success_bitmap[2].y -= 1
              return
            end
          end
#          $game_switches[89] = false
        else
          if @success_bitmap[1].opacity < 255
            @success_bitmap[1].opacity += 30
          end
          if @success_bitmap[1].y > @set_y + 210
            @success_bitmap[1].y -= 1
            return
          end
        end
      end
      @wait_count = 20
      $game_temp.resistgame_flag = 4
    end
    
    
    # �t�F�[�h�A�E�g����
    if $game_temp.resistgame_flag == 4 and @wait_count == 0
      yazirusi_max = @yajirusi_sprite.size - 1
      for i in 0..max
        if @yajirusi_sprite[i].opacity > 0
          @yajirusi_sprite[i].opacity -= 51
        end
      end
      if $game_temp.resistgame_clear == true
        if @success_bitmap[0].opacity > 0
          @success_bitmap[0].opacity -= 51
        end
      else
        if @success_bitmap[1].opacity > 0
          @success_bitmap[1].opacity -= 51
        end
        if @success_bitmap[2].opacity > 0
          @success_bitmap[2].opacity -= 51
        end
      end
      
      if @yajirusi_sprite[yazirusi_max].opacity == 0
        $game_temp.resistgame_flag = -1
      else
        return
      end
    end

  

    @wait_count -= 1

  end
  #--------------------------------------------------------------------------
  # �� �t���[���X�V
  #--------------------------------------------------------------------------
  def update
    
  end
  #--------------------------------------------------------------------------
  # �� ���
  #--------------------------------------------------------------------------
  def dispose
    for i in 0..max #�z��̍Ō�܂Ń��[�v
      @yajirusi_sprite[i].dispose
    end
    for i in 0..3 #�z��̍Ō�܂Ń��[�v
      @success_bitmap[i].dispose
    end
    @text.dispose
    @bar_bitmap.dispose
  end
end