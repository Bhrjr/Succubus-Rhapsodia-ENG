#==============================================================================
# �� RPG::Ability
#------------------------------------------------------------------------------
# �@�f���̏��B$data_ability[id]����Q�Ɖ\�B
#==============================================================================
module RPG
  #--------------------------------------------------------------------------
  # �� �f���̓o�^
  #--------------------------------------------------------------------------
  class Ability_registration
    #--------------------------------------------------------------------------
    # �� ���J�C���X�^���X�ϐ�
    #--------------------------------------------------------------------------
    attr_accessor :id            # id
    attr_accessor :name          # ���O
    attr_accessor :UK_name       # Engrish, go!
    attr_accessor :description   # ����
    attr_accessor :icon_name   # ����
    attr_accessor :hidden      # ��\���f��
    #--------------------------------------------------------------------------
    # �� �I�u�W�F�N�g������
    #--------------------------------------------------------------------------
    def initialize(ability_id)
      @id = ability_id
      @name = ""
      @UK_name = ""
      @description = ""
      @icon_name = "acce_003"
      @hidden = false
      setup(ability_id)
    end
    #--------------------------------------------------------------------------
    # �� �Z�b�g�A�b�v
    #--------------------------------------------------------------------------
    def setup(ability_id)
      
      # �K���f����id���ŕ��Ԃ��߁A�������l�����邱�ƁB
      
      case ability_id
      
      # �� id [0..9] ���ʁA���̑��ŗD��f��
      
      when 0
        @name = "�j" # �Y
        @UK_name = "Male" # �Y
        @description = "A man. ��ith a �� attached." #�j���B���ʁA��������B"      
      when 1
        @name = "��" # �Y
        @UK_name = "Female" 
        @description = "A woman. ��ith a ��. And all." #�����B���ʁA��������B"
       
      # �� id [10..29] �e���_(�ǌ��������ɉe��)
      #    10�`17�͒j���p(�n�D)�A19�`30�͏����p(������)�ƂȂ�
      when 10
        @name = "���U�߂Ɏア" # �Y
        @UK_name = "Mouth Fetish" 
        @description = "Oral and tongue techniques have a higher chance of doing critical damage to you."
      when 11
        @name = "��U�߂Ɏア" # �Y
        @UK_name = "Hand Fetish" 
        @description = "Hand and finger techniques have a higher chance of doing critical damage to you."
      when 12
        @name = "���U�߂Ɏア" # �Y
        @UK_name = "Breast Fetish" 
        @description = "Breast and nipple techniques have a higher chance of doing critical damage to you."
      when 13
        @name = "���A�U�߂Ɏア" # �Y
        @UK_name = "Pussy Fetish" 
        @description = "Vaginal techniques have a higher chance of doing critical damage to you."
      when 14
        @name = "�n�s�U�߂Ɏア"
        @UK_name = "S Fetish" 
        @description = "Sadistic attacks, such as foot techniques, have a higher chance of doing critical damage to you."
      when 15
        @name = "�ٌ`�U�߂Ɏア"
        @UK_name = "Monmusu Fetish" 
        @description = "Unconventional techniques have a higher chance of doing critical damage to you."
        # ����v���C�ɂĉ���
      when 16
        @name = "�����Ɏア"
        @UK_name = "Weak to Intercourse" 
        @description = "When Inserted, you have a higher chance of suffering critical damage."
      when 17
        @name = "��s�Ɏア"
        @UK_name = "Ass Fetish" 
        @description = "Ass techniques have a higher chance of doing critical damage to you."
        # ����v���C�ɂĉ���
      
      when 19
        @name = "����������"
        @UK_name = "Weak Mouth" 
        @description = "Attacks to your mouth have a higher chance of doing critical damage."
      when 20
        @name = "���O"
        @UK_name = "Lewd Mouth" 
        @description = "Attacks to your mouth have a very high chance of doing critical damage."
      when 21
        @name = "����������"
        @UK_name = "Weak Chest" 
        @description = "Attacks to your breasts have a higher chance of doing critical damage."
      when 22
        @name = "����"
        @UK_name = "Lewd Chest" 
        @description = "Attacks to your breasts have a very high chance of doing critical damage."
      when 23
        @name = "���K��������"
        @UK_name = "Weak Ass" 
        @description = "Attacks to your backside have a higher chance of doing critical damage."
      when 24
        @name = "���K"
        @UK_name = "Lewd Ass" 
        @description = "Attacks to your backside have a very high chance of doing critical damage."
      when 25
        @name = "�e����������"
        @UK_name = "Weak Rosette" 
        @description = "When anally Inserted, you have a higher chance of suffering critical damage."
        # ����v���C�ɂĉ���
      when 26
        @name = "����"
        @UK_name = "Lewd Rosette" 
        @description = "When anally Inserted, you have a very high chance of suffering critical damage."
        # ����v���C�ɂĉ���
      when 27
        @name = "�A�j��������"
        @UK_name = "Weak Clit" 
        @description = "Attacks to your crotch have a higher chance of doing critical damage."
      when 28
        @name = "���j"
        @UK_name = "Lewd Clit" 
        @description = "Attacks to your crotch have a very high chance of doing critical damage."
      when 29
        @name = "���A��������"
        @UK_name = "Weak Pussy" 
        @description = "When vaginally Inserted, you have a higher chance of suffering critical damage."
      when 30
        @name = "����"
        @UK_name = "Lewd Pussy" 
        @description = "When vaginally Inserted, you have a very high chance of suffering critical damage."
        
      
      # �� id [31..49] �U�������f�� / attack damage bonuses
      #    31�`37�̓A�N�^�[�̒ǌ����㏸ / multiple attack trigger
      #    40�`46�͒ǉ��X�L���擾�����ƂȂ� / new skill get
      when 31
        @name = "�L�b�X�n��"
        @UK_name = "Kiss Mastery" 
        @description = "�wKiss�x attack deals more damage and has a higher chance of dealing critical damage."
      when 32
        @name = "�o�X�g�n��"
        @UK_name = "Breast Mastery" 
        @description = "�wChest�x attack deals more damage and has a higher chance of dealing critical damage."
      when 33
        @name = "�q�b�v�n��"
        @UK_name = "Ass Mastery"
        @description = "�wHips�x attack deals more damage and has a higher chance of dealing critical damage."
      when 34
        @name = "�N���b�`�n��"
        @UK_name = "Crotch Mastery" 
        @description = "�wCrotch�x attack deals more damage and has a higher chance of deadling critical damage."
      when 35
        @name = "�C���T�[�g�n��"
        @UK_name = "Insert Mastery" 
        @description = "Insert-exclusive skills are more powerful and have a higher chance of dealing critical damage."
        # ����v���C�ɂĉ���
      when 36
        @name = "�z�[���h�n��"
        @UK_name = "Bondage Mastery" 
        @description = "When using restrictive skills, the RESIST gauge difficulty is easier."
        # ����v���C�ɂĉ���

      when 40
        @name = "��Z�̐S��"
        @UK_name = "Hand Arts" 
        @description = "You can now make full use of your hands through experience."
      when 41
        @name = "��Z�̐S��"
        @UK_name = "Tongue Arts" 
        @description = "You're able to learn how to make good use of your tongue through experience."
      when 42
        @name = "���Z�̐S��"
        @UK_name = "Chest Arts" 
        @description = "Through experience, you can now make full use of chest techniques."
      when 43
        @name = "�����̐S��"
        @UK_name = "Caress Arts" 
        @description = "Through practice, you're now able to obtain mastery of caressing."
      when 44
        @name = "���s�̐S��"
        @UK_name = "Domme Arts" 
        @description = "You can now master S skills."
        # ����v���C�ɂĉ���
      when 45
        @name = "��s�̐S��"
        @UK_name = "Sub Arts" 
        @description = "You can now master M skills."
        # ����v���C�ɂĉ���
      when 46
        @name = "�����̐S��"
        @UK_name = "Sex Arts" 
        @description = "You've learned to master the art of insertion through experience."
      when 47
        @name = "�ċz�̐S��"
        @UK_name = "Breath Mastery" 
        @description = "Mastery of medication can now be obtained."
      
      
      # �� id [50..99] �D��\���f��
      
      when 50
        @name = "�ō��̎p"
        @UK_name = "The Highest Form" 
        @description = "This succubus is as strong as its fully evolved form."
        # �����N�A�b�v�O�̖����ł��A
        # �ő僉���N���̏�Ԃ̃X�e�[�^�X�Ƃ��Čv�Z�����B
      when 51
        @name = "����"
        @UK_name = "Virgin" 
        @description = "Still knows nothing of the taste of a woman."
        # ����v���C�ɂĉ���
      when 52
        @name = "���߂Ă�D����"
        @UK_name = "Ravished" 
        @description = "You took the virginity of this succubus."
      when 53
        @name = "����"
        @UK_name = "Maiden" 
        @description = "Has yet to become a woman."
      when 54
        @name = "���߂Ă�D��ꂽ"
        @UK_name = "Virginity Taken" 
        @description = "You gave your virginity to this succubus."
        # ����v���C�ɂĉ���
      when 55
        @name = "�V���̏���"
        @UK_name = "Heavenly Maiden" 
        @description = "An eternal virgin."
        # �t�[���[�̑f��
        
      when 56
        @name = "������L"
        @UK_name = "Futanari" 
        @description = "A female that has �� parts."
        # ����v���C�ɂĉ���
      when 57
        @name = "����̎�"
        @UK_name = "Motherly Bounty" 
        @description = "Milk is flowing out of her breasts."
        # ����v���C�ɂĉ���
      
        
      when 60
        @name = "����"
        @UK_name = "Loving" 
        @description = "This succubus really likes you..."
      when 61
        @name = "��؂Ȑl"
        @UK_name = "Trusting" 
        @description = "There feels like something special between you and this succubus."

      when 70
        @name = "�z��" # �Y
        @UK_name = "Soul-sucking" 
        @description = "When allowed to be on top, a small amount of hunger is satiated."
      when 71
        @name = "�T�f�B�X�g"
        @UK_name = "Sadist" 
        @description = "Effects of S-attribute skills are increased."
      when 72
        @name = "�}�]�q�X�g" # �Y
        @UK_name = "Masochist" 
        @description = "Converts effects of incoming S-attribute skills to different effects."
      when 73
        @name = "�J���X�}" # �Y
        @UK_name = "Charismatic" 
        @description = "Have increased chances of being offered a contract after battle."
      when 74
        @name = "�V���[�X�g���b�v"
        @UK_name = "Stripteaser" 
        @description = "When removing one's own clothes while the Mood is high, all enemies are rendered Horny."

        
      when 80
        @name = "���^�����t�H�[�["
        @UK_name = "Shapeshifter" 
        @description = "Appears in battle disguised as a different succubus. Returns to original form when in CRISIS."
        # �����_�[�C���v�̑f���B�����̏ꍇ�A��Ԍ��̖����̎p�ɂȂ�B
      when 81
        @name = "�������̘A�g" # �Y
        @UK_name = "Goblin Teamwork" 
        @description = "During battle, can use �yGoblin Leadership�z ��ith an ally."
      when 82
        @name = "�������̓���" # �Y
        @UK_name = "Goblin Leadership" 
        @description = "During battle, can use �yGoblin Teamwork�z ��ith an ally ��ith the same skill."
      when 83
        @name = "�d��" # �Y
        @UK_name = "Keen Eyes" 
        @description = "Checks all enemies upon entering combat."
        
        
      when 91
        @name = "�ł̑̉t" # �Y
        @UK_name = "Poisonous Fluids" 
        @description = "Contact ��ith this succubus' fluids will produce an\n abnor��al status effect."
        # �l�C�W�������W����f���B
      when 92
        @name = "" 
        @description = ""
        # ���W�F�I����f���B        
      when 93
        @name = "�m�ł��鎩���S" # �Y
        @UK_name = "Unshakable Pride" 
        @description = "Immune to status abnormalities."
        # �t���r���A����f���B        
      when 94
        @name = "�ߕq�Ȑg��" # �Y
        @UK_name = "Hypersensitive Body" 
        @description = "Has become hypersensitive to pleasures of the flesh."
        # �M���S�[������f���B        
      when 95
        @name = "" 
        @description = ""
        # ���[�K�m�b�g����f���B        
      when 96
        @name = "��ǂ�" 
        @UK_name = "Forereading" 
        @description = "When having not yet acted yet this turn, become resistant to SS attacks."
        # �V���t�F����f���B
      when 97
        @name = "�ώ�" # �Y
        @UK_name = "Obsession" 
        @description = "This girl keeps looking at you..."
        # ���[�~������f��
        
        
        
      # �� id [100..199] �퓬�n�f��
      
      when 103
        @name = "�X�^�~�i"
        @UK_name = "Stamina" 
        @description = "The Weakened phase after climaxing is shorter."
      when 104
        @name = "�����m��" # �Y
        @UK_name = "Cooking Knowledge" 
        @description = "Can cook ingredients."
      when 105
        @name = "���@�m��"
        @UK_name = "Magic Knowledge" 
        @description = "Magic consu��es less VP."

      when 106
        @name = "�G��₷��" # �Y
        @UK_name = "Wet" 
        @description = "Crotch gets wet easily. Increased lubrication rate."
      when 107
        @name = "�G��ɂ���" # �Y
        @UK_name = "Prudish" 
        @description = "Crotch lubrication rises slowly."
        
      when 108
        @name = "����" # �Y
        @UK_name = "Calm Mind" 
        @description = "Doesn't go Berserk easily."
      when 109
        @name = "���C" # �Y
        @UK_name = "Vigorous" 
        @description = "Doesn't beco��e Lethargic easily."
      when 110
        @name = "�_��" # �Y
        @UK_name = "Courage" 
        @description = "Doesn't beco��e in A��e easily."
      when 111 # ���Ԉʒu
        @name = ""
        @description = ""
      when 112
        @name = "�_��" # �Y
        @UK_name = "Flexible" 
        @description = "Doesn't get Paralyzed easily."
      when 113
        @name = "��S" # �Y
        @UK_name = "Deter��ined" 
        @description = "Doesn't become in Awe easily."
      when 114
        @name = "�S��" # �Y
        @UK_name = "Slimy Body" 
        @description = "Well lubricated from the start of battle. Also easy to raise target's lubrication."
        # �X���C���n�̑f���B
      when 115
        @name = "�v���e�N�V����" # �Y
        @UK_name = "Magic Ward" 
        @description = "I����une to ��agical effects."
        # �S�[���h�X���C���̑f���B
      when 116
        @name = "�u���b�L���O" # �Y
        @UK_name = "Blocking" 
        @description = "When having not acted during turn, incoming pleasure is reduced."
        # �K�[�S�C���̑f���B
      when 117
        @name = "����" # �Y
        @UK_name = "Thick Clothing" 
        @description = "When still clothed, Agility falls but Endurance rises."
        # �^�}���̑f���B
      when 118
        @name = "�Ɖu��" # �Y
        @UK_name = "Immunity" 
        @description = "Immune to spore effects, and resistance to poison."

        
      when 120
        @name = "���g" # �Y
        @UK_name = "Excited" 
        @description = "Beco��es Excited upon entering co��bat."
      when 121
        @name = "����" # �Y
        @UK_name = "Co��posed" 
        @description = "Beco��es Co��posed when entering co��bat."
      when 122
        @name = "���y��`"
        @UK_name = "Epicurian" 
        @description = "Mood rises when attacked."
      when 123
        @name = "���}���`�X�g" # �Y
        @UK_name = "Romantic" 
        @description = "Deals even more damage when mood is high."
      when 124
        @name = "�n��" # �Y
        @UK_name = "Technique Mastery" 
        @description = "Has a higher Sensual Stroke rate."
      when 125
        @name = "���M�ߏ�"
        @UK_name = "Superiority" 
        @description = "Recovers from status abnormalities when this succubus makes the opposition climax."
      when 126
        @name = "�ŗ~" # �Y
        @UK_name = "Greedy" 
        @description = "When ally other than oneself climaxes, Charm and Vitality increase by 1 stage."
      when 127
        @name = "���X�ȍU��" # �Y
        @UK_name = "Relentless" 
        @description = "Pleasure is not reduced as much from repeated use of the same skills."
=begin
      when 128
        @name = "�b�|"
        @description = "�g�[�N�̐��������オ��B"
      when 129
        @name = "�ۋC"
        @description = "���܂ɑҋ@�^�[���ɂȂ�B"
=end
        
      when 130
        @name = "���@��" # �Y
        @UK_name = "Insight" 
        @description = "Checks the target that one attacks."
      when 131
        @name = "�����I"
        @UK_name = "Provocative" 
        @description = "Upon entering co��bat, 20 VP is consu��ed to snatch the ene��ies' attention."
      when 132
        @name = "�{�f�B�A���}"
        @UK_name = "S��eet Aro��a" 
        @description = "Upon entering co��bat, 8 VP is consu��ed, raising the ��ood by a little."
      when 133
        @name = "���f�I"
        @UK_name = "Fascinating" 
        @description = "When entering co��bat, 40 VP is consu��ed for a s��all chance of rendering ene��ies Horny."
      when 134
        @name = "�T���`�F�b�N" # �Y
        @UK_name = "Aweso��e Presence" 
        @description = "When entering co��bat, 100 VP is consumed, rendering ene��ies in a Panicked state."
      when 135
        @name = "�����̕ۏ�" # �Y
        @UK_name = "Peacekeeper" 
        @description = "Recovery magic is more effective."
      when 136
        @name = "�o�b�h�`�F�C��" # �Y
        @UK_name = "Trick Chain" 
        @description = "Lands attacks easier on targets ��ith 2 or more status abnor��alities."

      when 140
        @name = "���ԕ�"
        @UK_name = "Masturbator" 
        @description = "Has a habit of masturbating a lot."
      when 141
        @name = "���t����"
        @UK_name = "Cum addict" 
        @description = "Has a co��pulsive habit of consu��ing semen."
        
      when 150
        @name = "���䖲��" # �Y
        @UK_name = "Desperado" 
        @description = "Vitality rises when in CRISIS."
      when 151
        @name = "�΍R�S" # �Y
        @UK_name = "Co��petitive" #rivalry?
        @description = "When there are less allies than ene��ies at the time of an ally's cli��ax, Vitality and Agility increases."
      when 152
        @name = "�����S"
        @UK_name = "Self-control" 
        @description = "Consumes 50 VP when made Horny - increasing Willpower adn removing the Horniness."
      when 153
        @name = "�����̑̎�"
        @UK_name = "Body of a Sex De��on" 
        @description = "When Horny, recovers VP auto��atically at the end of each turn."
      when 154
        @name = "���\��" # �Y
        @UK_name = "Berserker" 
        @description = "When Berserk, Control and Spirit fall even ��ore, but Vitality rises substantially."
      
      when 160
        @name = "�L�X�X�C�b�`" # �Y
        @UK_name = "Kiss S��itch" 
        @description = "Gets turned on when kissed."
      when 161
        @name = "�}�]�X�C�b�`"
        @UK_name = "Masochist S��itch" 
        @description = "Gets turned on when do��inated."
        
      when 170
        @name = "�G�N�X�^�V�[�{��" # �Y
        @UK_name = "Ecstasy Bo��b" 
        @description = "When cli��axing, render all allies except oneself into a Berserk state."
      when 171
        @name = "����̎�"
        @UK_name = "Sealed" 
        @description = "Cannot ��ove until pleasure is received, and is sealed again shortly afterwards even if seal was broken."
        # �V�[���f�[�����̑f���B
        
        
      # �� id [100..199] �T���n�f��
      when 210
        @name = "�d�o�q�[�����O" # �Y
        @UK_name = "EP Recovery" 
        @description = "Restores a s��all amount of EP to the party after a victorious battle."
      when 211
        @name = "�u�o�q�[�����O" # �Y
        @UK_name = "VP Recovery" 
        @description = "Restores all VP to the party after a victorious battle."
        
      when 212
        @name = "�񕜗�" # �Y
        @UK_name = "Resilient" 
        @description = "EP Auto-regeneration is slightly increased."
      when 213
        @name = "����񕜗�" # �Y
        @UK_name = "Overflo��ing Resilience" 
        @description = "EP Auto-regeneration is slightly increased for the whole party."
      when 214
        @name = "������" # �Y
        @UK_name = "Energetic" 
        @description = "VP Auto-regeneration is slightly increased."
      when 215
        @name = "���鐶����" # �Y
        @UK_name = "Overflowing Energy" 
        @description = "VP Auto-regeneration is slightly increased for the whole party."
        
      when 220
        @name = "�o�����p��" # �Y
        @UK_name = "Quick Learner" 
        @description = "EXP gains are increased."
      when 221
        @name = "�N�W" # �Y
        @UK_name = "Collector" 
        @description = "Item Drop chance is increased."
      when 222
        @name = "���^" # �Y
        @UK_name = "Gold Digger" 
        @description = "Increased Lps gains after battle."
      when 223
        @name = "�����ւ̗�����"
        @UK_name = "Wind whispers" 
        @description = "A dim marker is placed near hidden passages."
      when 224
        @name = "�_�E�W���O"
        @UK_name = "Dowser" 
        @description = "A marker appears on the map when you step over a hidden item."
      when 225
        @name = "�V�[���X�^���v"
        @UK_name = "Sealer" 
        @description = "Reduces damage dealt to party from floor traps."
      when 226
        @name = "�_�E�g"
        @UK_name = "Doubtful" 
        @description = "Can detect Mimics beforehand."
      when 227
        @name = "��P�̔���" # �Y
        @UK_name = "Ambusher" 
        @description = "Increases chance of pree��ptive engagements when making\n contact ��ith an ene��y sprite."
      when 228
        @name = "�x���̔���" # �Y
        @UK_name = "Sentry" 
        @description = "Reduces the chance of the enemy getting a preemptive engagement on you."
      when 229
        @name = "���������@" # �Y
        @UK_name = "Dasher" 
        @description = "Reduces chance of being pree��ptively engaged when\n contacting an ene��y while dashing."
      when 230
        @name = "�����̋Ɉ�" # �Y
        @UK_name = "Escapist" 
        @description = "Increased success rate of escape attempts."
      
        
        
      when 240
        @name = "��ۗǂ��̎�" # �Y
        @UK_name = "Scavenger" 
        @description = "Decreases the time it takes for collection."
      when 241
        @name = "�ڑ����̎�" # �Y
        @UK_name = "Meticulous" 
        @description = "Increases chance of rare items from collecting."
        
      when 300
        @name = "��\���f���e�X�g"
        @UK_name = "Headhunter" 
        @description = "��\���f���e�X�g�ł��Bhidden���^�̑f���͕\������܂���"
        @hidden = true

      when 301
        @name = "�C���T�[�g" # �Y
        @UK_name = "Insert" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 302
        @name = "�A�N�Z�v�g" # �Y
        @UK_name = "Accept" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 303
        @name = "�V�F���}�b�`" # �Y
        @UK_name = "Tribadism" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 304
        @name = "�G�L�T�C�g�r���[" # �Y
        @UK_name = "Facesit" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 305
        @name = "�G���u���C�X" # �Y /�����z�[���h(�J�r�͏���)
        @UK_name = "Embrace" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 306
        @name = "�I�[�����Z�b�N�X" # �Y /�t�F���{�N���j���p
        @UK_name = "Oral sex" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 307
        @name = "�y���X�R�[�v" # �Y /�p�C�Y���z�[���h
        @UK_name = "Breast sex" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 308
        @name = "�w�u�����[�t�B�[��" # �Y /�ςӂςӃz�[���h
        @UK_name = "Heaven's feel" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 309
        @name = "�t���b�^�i�C�Y" # �Y /�L�b�X�z�[���h
        @UK_name = "Lock lips" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 310
        @name = "�g���C���h�z�[��" # �Y /���K�g�p�n
        @UK_name = "Valley of the Gange" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 311
        @name = "�A���h���M���k�X" # �Y /�y�j�X�g�p�n
        @UK_name = "Androgynous" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 312
        @name = "�e�C���}�X�^���[" # �Y /�K���g�p�n
        @UK_name = "Tail Mastery" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 313
        @name = "�e���^�N���}�X�^���[" # �Y /�G��g�p�n
        @UK_name = "Feeler Mastery" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 314
        @name = "�C�N�C�b�v�f�B���h" # �Y /�f�B���h�����n
        @UK_name = "Strapon Mastery" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 315
        @name = "�A�C���B�}�X�^���[" # �Y /�ӎg�p�n
        @UK_name = "Vine Mastery" 
        @description = "�z�[���h�K���ς݊m�F�p"
        @hidden = true
      when 320
        @name = "�A�k�X�}�[�L���O" # �Y /�K�_������
        @UK_name = "Anal Marking" 
        @description = "Can aim for the anus through Insertion hold."
        @hidden = true
      when 321
        @name = "�o�C���h�}�X�^���[" # �Y /�S���Z����
        @UK_name = "Restraint Mastery" 
        @description = "�S���z�[���h����������"
        @hidden = true

        
        
      when 332
        @name = "�������s" # �Y /
        @UK_name = "Awful Cook" 
        @description = "���̖����͗������ł��Ȃ��B"
        @hidden = true
        
      end
    end
  end
  #--------------------------------------------------------------------------
  # �� �f�����܂Ƃ�
  #--------------------------------------------------------------------------
  class Ability
    #--------------------------------------------------------------------------
    # �� ���J�C���X�^���X�ϐ�
    #--------------------------------------------------------------------------
    attr_accessor :data
    #--------------------------------------------------------------------------
    # �� �I�u�W�F�N�g������
    #--------------------------------------------------------------------------
    def initialize
      @data = []
      @max = 400 #�f���̓o�^�����
      for i in 0..@max
        @data[i] = Ability_registration.new(i)
      end
    end
    #--------------------------------------------------------------------------
    # �� �f���̎擾
    #--------------------------------------------------------------------------
    def [](ability_id)
      return @data[ability_id]
    end
    #--------------------------------------------------------------------------
    # �� �f���̌���
    #    type : �����w��   variable : ������
    #--------------------------------------------------------------------------
    def search(type, variable)
      
      case type
      when 0 # ���O�łh�c����������
        for data in @data
          if data.name == variable
            n = data.id
            break
          end
        end
      end
      
      if n == nil
        text = "�Ή������h�c����������܂���ł����B"
        text += "\n�ȉ��̂��Ƃ��m�F���Ă������B"
        text += "\n�E�뎚�E���i�X�N���v�g�G�f�B�^���S�����j"
        text += "\n�E�y�z��t���Č������Ă��Ȃ���"
        text += "\n�E�f���̏�����������������f��ID�̐����ȉ��łȂ���"
        text += "\n�������[�h�F#{variable}"
        print text
      end
      
      return n
    end

  end
end