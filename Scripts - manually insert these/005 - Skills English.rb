module RPG
  class Skill
    attr_accessor :UK_name
    def UK_name
      
      case @id
#��Actor base skills

when 2   #����E����
   return "Strip "
when 4   #����E��
   return "Undress "
when 5   #�V�F���}�b�`
   return "Scissors"
when 6   #�C���T�[�g
   return "Insert"
when 7   #�I�[�����C���T�[�g
   return "Oral Insert "
when 8   #�o�b�N�C���T�[�g
   return "Backdoor insert "
when 9   #�g�[�N
   return "Talk"
when 10   #�g�[�N���W�X�g
   return "Sweet Talk"
when 13   #�A�N�Z�v�g
   return "Accept"
when 14   #�I�[�����A�N�Z�v�g
   return "Oral Accept "
when 15   #�o�b�N�A�N�Z�v�g
   return "Backdoor Accept "
when 16   #�h���E�l�N�^�[
   return "Dra�� Nectar "
when 17   #�G���u���C�X
   return "E��brace "
when 18   #�G�L�T�C�g�r���[
   return "Facesit "
when 20   #�f�B���h�C���T�[�g
   return "Dildo Insert"
when 21   #�f�B���h�C���}�E�X
   return "Dildo Gag "
when 22   #�f�B���h�C���o�b�N
   return "Dildo Backdoor"
when 25   #�f�����Y�A�u�\�[�u
   return "Feeler Suck-in"
when 26   #�f�����Y�h���E
   return "Feeler Insert "
when 28   #�C���^���v�g
   return "Interrupt "
when 29   #�����[�X
   return "Release "
when 30   #�X�g���O��
   return "Struggle"
   
   #����techniques
when 32   #�X�E�B���O
   return "Thrust"
when 33   #�w���B�X�E�B���O
   return "Piston"
when 34   #�f�B���h�X�E�B���O
   return "Strappon Thrust "
when 35   #���r���O�s�X�g��
   return "Chest Frottage"
when 37   #�I�[�����s�X�g��
   return "Oral Piston "
when 38   #�I�[�����f�B���h
   return "Oral Dildo"
when 41   #�o�b�N�s�X�g��
   return "Anal Thrust "
when 42   #�o�b�N�f�B���h
   return "Anal Dildo "

   #����techniques
when 47   #�O���C���h
   return "Grind"
when 48   #�n�[�h�O���C���h
   return "Wild Ride "
when 50   #�^�C�g�N���b�`
   return "Tighten "
when 52   #�X�N���b�`
   return "Tribadis�� "
when 53   #�n�[�h�X�N���b�`
   return "Rubdo��n "
when 55   #���C�f�B���O
   return "Facerub "
when 56   #�v�b�V���O
   return "Facepress "
   
   #��Oral techniques

when 58   #�X���[�g
   return "Blowjob "
when 59   #�f�B�[�v�X���[�g
   return "Deepthroat"
when 60   #�h���E�X���[�g
   return "Throat Dra�� "
when 61   #�T�b�N
   return "Lick"
   
   #��Anal techniques
   
when 64   #�X�N�C�[�Y
   return "S��ueeze "
when 67   #�^�C�g�z�[��
   return "Tighten "
   
   #��Hold counters
      
when 71   #���b�N
   return "Lick Pussy"
when 72   #���b�N
   return "Lick Ass"
when 73   #�~�X�`�[�t
   return "Tickle"
when 74   #���A�J���X
   return "Caress Back"
when 79   #���b�N���X
   return "S��uir��"
   
   #��Actor attacks

when 81   #�L�b�X
   return "Kiss"
when 82   #�o�X�g
   return "Chest "
when 83   #�q�b�v
   return "Hips"
when 84   #�N���b�`
   return "Crotch"
when 85   #�J���X
   return "Caress "
   
   #��Partner attacks

when 87   #�L�b�X
   return "Kiss"
when 91   #�c�[�p�t
   return "Chest Press "
when 101   #�e�B�[�Y
   return "Tease "
when 102   #�~�X�`�[�t�i�v�j
   return "Tease out "
when 103   #�t�@�X�g���C�h
   return "Quick Raid"
when 104   #�g���b�N���C�h
   return "Trick Raid"
when 106   #�f�B�o�E�A�[
   return "Devour "
when 111   #�v���W���[
   return "Self-pleasure "
   
   #��Actor support techniques

when 121   #�u���X
   return "Breath"
when 122   #�J�[���u���X
   return "Cal�� Breath "
when 123   #�E�F�C�g
   return "Wait"
when 124   #�C���g���X�g
   return "Entrust "
when 125   #���t���b�V��
   return "Refresh "
when 126   #�`�F�b�N
   return "Check "
when 127   #�A�i���C�Y
   return "Analyze "
when 135   #�X�g���b�v
   return "Strip Partner "
when 140   #�e���v�e�[�V����
   return "Te��ptation"
when 145   #�K�[�h
   return "Guard "
when 146   #�C���f���A
   return "Endure"
when 148   #�A�s�[��
   return "Appeal"
when 149   #�v�����H�[�N
   return "Provoke "

   #��Succubi common magic

when 161   #�C���X�V�[�h
   return "Iris Seed "
when 162   #�C���X�y�^��
   return "Iris Petal"
when 163   #�C���X�t���E
   return "Iris Aura "
when 164   #�C���X�R���i
   return "Iris Cro��n"
when 165   #�C���X�V�[�h�E�A���_
   return "Iris Seed - All "
when 166   #�C���X�y�^���E�A���_
   return "Iris Petal - All"
when 167   #�C���X�t���E�E�A���_
   return "Iris Aura - All "
when 171   #���i���u����
   return "Leanan Bloo��"
when 172   #���i���u�����E�A���_
   return "Leanan Bloo�� - All"
when 173   #���i���C�[�U
   return "Leanan Wither "
when 174   #���i���C�[�U�E�A���_
   return "Leanan Wither - All "
when 175   #�l���l�u����
   return "Nellin Bloo��"
when 176   #�l���l�u�����E�A���_
   return "Nellin Bloo�� - All"
when 177   #�l���l�C�[�U
   return "Nellin Wither "
when 178   #�l���l�C�[�U�E�A���_
   return "Nellin Wither - All "
when 179   #�G���_�u����
   return "Elda Bloo��"
when 180   #�G���_�u�����E�A���_
   return "Elda Bloo�� - All"
when 181   #�G���_�C�[�U
   return "Elda Wither "
when 182   #�G���_�C�[�U�E�A���_
   return "Elda Wither - All "
when 183   #�T�t���u����
   return "Saffron Bloo�� "
when 184   #�T�t���u�����E�A���_
   return "Saffron Bloo�� - All "
when 185   #�T�t���C�[�U
   return "Saffron Wither "
when 186   #�T�t���C�[�U�E�A���_
   return "Saffron Wither - All "
when 187   #�R���I�u����
   return "Kurio Bloo�� "
when 188   #�R���I�u�����E�A���_
   return "Kurio Bloo�� - All "
when 189   #�R���I�C�[�U
   return "Kurio Wither"
when 190   #�R���I�C�[�U�E�A���_
   return "Kurio Wither - All"
when 191   #�A�X�^�u����
   return "Alta Bloo��"
when 192   #�A�X�^�u�����E�A���_
   return "Alta Bloo�� - All"
when 193   #�A�X�^�C�[�U
   return "Alta Wither"
when 194   #�A�X�^�C�[�U�E�A���_
   return "Alta Wither - All"
when 195   #�X�g�����u����
   return "Stor�� Bloo�� "
when 196   #�X�g�����u�����E�A���_
   return "Stor�� Bloo�� - All "
when 197   #�X�g�����C�[�U
   return "Stor�� Wither"
when 198   #�X�g�����C�[�U�E�A���_
   return "Stor�� Wither - All"
when 200   #�`���[��
   return "Char�� "
when 201   #�y�C�h�E�`���[��
   return "Mass Char��"
when 202   #���X�g
   return "Lust"
when 203   #�y�C�h�E���X�g
   return "Mass Lust "
when 204   #�t�B���X
   return "Flirt "
when 205   #�y�C�h�E�t�B���X
   return "Mass Flirt"
when 206   #���U���W�B
   return "Resaraji"
when 207   #�y�C�h�E���U���W�B
   return "Mass Resaraji "
when 208   #�e���[
   return "Toll"
when 209   #�y�C�h�E�e���[
   return "Mass Toll "
when 210   #�p�����C�Y
   return "Paralyze"
when 211   #�y�C�h�E�p�����C�Y
   return "Mass Paralyze "
when 212   #���[�Y
   return "Sleep "
when 213   #�y�C�h�E���[�Y
   return "Mass Sleep"
when 215   #�g�������[�g
   return "Liliu�� Root "
when 216   #�g�����X�g�[�N
   return "Liliu�� Stalk"
when 217   #�g�������@�C��
   return "Liliu�� Ste�� "
when 219   #�u�����J�[��
   return "Bloo�� Call"
when 220   #�u�����J�[���E�A���_
   return "Bloo�� Call - All"
when 221   #�C�[�U�J�[��
   return "Wither Call"
when 222   #�C�[�U�J�[���E�A���_
   return "Wither Call - All"
when 224   #�E�H�b�V���t���[�h
   return "Cleansing Waters"
when 239   #�V���C�j���O���C�W
   return "Shining Rage"

   #�����l�`�o skills����
   
when 241   #�N�b�L���O
   return "Cooking "
when 248   #�T�[���@���g�R�[��
   return "Servant Talk"
when 249   #�����N�A�b�v
   return "Rank Up "
   
   #��Enemy basic techniques

when 251   #����E��
   return "Undress "
when 252   #�X�g���b�v
   return "Strip "
when 253   #�V���E�_�E��
   return "Sho��do��n"
when 257   #����E����
   return "Expose "
when 260   #�i���
   return "Check out "
when 261   #��قǂ�
   return "Setup "
when 262   #�Â₩��
   return "Indulge "
when 263   #�X�p���N
   return "Spank "
when 275   #�₯�����O�A��
   return "Desperation 3-ways"
when 276   #�q�[���[�L�����O
   return "Hero killer"
when 277   #���e�I�G�N���v�X
   return "Meteo rain "
when 278   #���[���h�u���C�J�[
   return "World Breaker "
when 279   #�X�L�����ߒ���
   return "Pick Again"
   
   #��Random basic attacks��

when 281   #�yRD�z�L�b�X
   return "Kiss"
when 282   #�yRD�z��U��
   return "Attack w/ hand"
when 283   #�yRD�z���U��
   return "Attack w/ Mouth"
when 284   #�yRD�z���U��
   return "Attack w/ chest"
when 285   #�yRD�z�A�\�R�U��
   return "Attack w/ pussy"
when 286   #�yRD�z���U��
   return "Attack w/ feet"
when 287   #�yRD�z����
   return "Caress "
when 288   #�yRD�z�K���U��
   return "Tail Attack"
when 289   #�yRD�z����U��
   return "Tool Attack"
when 290   #�yRD�z����g�̍U��
   return "Special Anato��y Attack"
when 292   #�yRD�z�z�[���h�Z
   return "Hold Attack"
when 293   #�yRD�z�����z�[���h���̍U��
   return "Attack while held"
when 294   #�yRD�z�����z�[���h���̉���
   return "Defend held friend"
when 296   #�yRD�z�R���t���[�Y
   return "Confused"
when 297   #�t�B�A�[
   return "Fear"
when 298   #�t���[�A�N�V����
   return "Free action"
when 299   #�G���[�V����
   return "E��otion"

###   
# note: from here onwards, only including skills with element 14 (name shows in battle)
###
   #��Special Handiworks��
   
when 359   #�Z�b�g�T�[�N��
   return "Set Circle"
when 360   #�R�[���h�^�b�`
   return "Cold Touch"
when 361   #�T�f�B�X�g�J���X
   return "Touch of Sadis��"
when 362   #�v���C�X�I�u�n����
   return "�gare�� Pleasure"
when 363   #�v���C�X�I�u�V�i�[
   return "Bushin Pleasure"
when 364   #�y���\�i�u���C�N
   return "Persona Break"
when 365   #�L���X�g�G���g���[
   return "Caster Gate"
   
   #��Special mouthworks��
   
when 415   #�n�E�����O
   return "Howling"
when 416   #�����̌��t��
   return "Devil's Kiss"
when 417   #�j���̌��t��
   return "Blessed Kiss"
when 418   #�X�C�[�g�E�B�X�p�[
   return "S��eet Whisper"
when 419   #�A�����b�L�[���A
   return "Dejected Love"
when 420   #�A�����b�L�[���A
   return "Dejected Love"
when 421   #�����Ȃ���
   return "Confess"
   
   #��special physicals��
   
when 586   #���X�g���[�V����
   return "Restoration"
when 587   #�X���C�~�[���L�b�h
   return "Sli��y Fluids"
when 588   #����
   return "Cheer"
when 589   #�o�b�h�X�|�A
   return "Noxious Spores"
when 590   #�X�|�A�N���E�h
   return "Spore Cloud"
when 591   #�A�C���B�N���[�Y
   return "Entangle"
when 592   #�f�����Y�N���[�Y
   return "De��on Wrap"
when 599   #�ő�
   return "�gaste "
when 600   #��S
   return "Concentration"
when 601   #�{�\�̌Ăъo�܂�
   return "Pri��al Instincts"
when 602   #���M�ߏ�
   return "Overconfidence"
   
   #��incenses��
   
when 611   #�����b�N�X�^�C��
   return "Relaxation Ti��e"
when 612   #�X�C�[�g�A���}
   return "S��eet Aro��a"
when 613   #�p�b�V�����r�[�g
   return "Passion Beats"
when 614   #�}�C���h�p�t���[��
   return "Mild Prefu��e"
when 615   #���b�h�J�[�y�b�g
   return "Red Carpet"
when 618   #�X�g�����W�X�|�A
   return "Strange Spores"
when 619   #�E�B�[�N�X�|�A
   return "Weakening Spores"
when 620   #�Д�
   return "Inti��idate"
when 621   #�S�͂�
   return "Heart Grasp"
when 622   #�S�Ă͌�
   return "One with the Flow"
when 625   #���u�t���O�����X
   return "Love Fragrance"
when 626   #�X���C���t�B�[���h
   return "Sli��e Field"
   
   #��Defensive skills��
   
when 631   #������󂯂�
   return "Cheer up"
   
   #��Holding skills - base��
   
when 682   #�A�N�Z�v�g
   return "Accept"
when 683   #�V�F���}�b�`
   return "Scissors"
when 684   #�G�L�T�C�g�r���[
   return "Facesit "
when 687   #�I�[�����A�N�Z�v�g
   return "Oral Insert "
when 688   #�h���E�l�N�^�[
   return "Oral Pin"
when 689   #�t���b�^�i�C�Y
   return "Lock lips"
when 691   #�o�b�N�A�N�Z�v�g
   return "Anal catch"
when 692   #�C���������r���[
   return "Dark Side "
when 695   #�G���u���C�X
   return "E��brace "
when 696   #�G�L�V�r�W���� / hold legs in place
   return "Spread 'e��" #"Exhibition"
when 697   #�y���X�R�[�v / Paizuri bearhold
   return "Paizuri Lock"#"Periscope"
when 698   #�w�u�����[�t�B�[�� / Puff-puff headhold
   return "Heaven's Feel "
when 700   #�C���T�[�g
   return "Insert"
when 701   #�I�[�����C���T�[�g
   return "Oral Insert "
when 702   #�o�b�N�C���T�[�g
   return "Backdoor Insert "
when 705   #�C���T�[�g�e�C��
   return "Tail Insert "
when 706   #�}�E�X�C���e�C��
   return "Oral Tail Insert"
when 707   #�o�b�N�C���e�C��
   return "Anal Tail Insert"
when 710   #�f�B���h�C���T�[�g
   return "Dildo Insert "
when 711   #�f�B���h�C���}�E�X
   return "Oral Dildo Insert "
when 712   #�f�B���h�C���o�b�N
   return "Anal Dildo Insert "
when 715   #�A�C���B�N���[�Y
   return "Entangle"
when 716   #�f�����Y�N���[�Y
   return "De��on Wrap"
when 717   #�f�����Y�A�u�\�[�u
   return "Feeler Suck-in"
when 718   #�f�����Y�h���E
   return "Feeler Insert "
when 719   #�C���T���g�c���[
   return "Tentacle Wrap "
when 772   #�G�i�W�[�h���C��
   return "Energy Drain"
when 773   #���x���h���C��
   return "Level Drain "
when 971   #������
   return "Struggle"
   
      end

      text = @name.split(/\//)[0] rescue text = "error: no valid skill name"
#      text += " *TODO*" if text != nil
      return text
    end
  end
end

