#==============================================================================
# �� RPG::Class
#------------------------------------------------------------------------------
# �@���̂̔��ʗp�B
#==============================================================================
module RPG
  class Class
    #--------------------------------------------------------------------------
    # �� �K���X�L��
    #--------------------------------------------------------------------------
    def learnings
      #------------------------------------------------------------------------
      # �����@�T�v
      #  �K�����x��, �^�C�v, ID]      #  �^�C�v�F0:�X�L��, 1:�f��
      #  �u���v���t���Ă�����̂̓J���[�Ǝ��ŏK���������Ȃ��́B
      #------------------------------------------------------------------------
      # �����X�L��
      group = [
      [1, 0, 2],    # Lv1.����E����
      [1, 0, 4],    # Lv1.����E��
      [1, 0, 81],   # Lv1.�L�b�X
      [1, 0, 82],   # Lv1.�o�X�g
      [1, 0, 83],   # Lv1.�q�b�v
      [1, 0, 84],   # Lv1.�N���b�`
      [1, 0, 121],   # Lv1.�u���X
      [1, 0, 123],   # Lv1.�E�F�C�g
      ]
      # �N���XID����j���p�����X�L����ǉ�
      case @id
      when 2 # ��l��
        group += [
        [1, 1, 0],    # Lv1.�y�j�z
        [1, 0, 9],    # Lv1.�g�[�N
        [1, 0, 6],    # Lv1.�C���T�[�g
#        [1, 0, 32]    # Lv1.�X�E�B���O      
        ]
      else
        group += [
        [1, 1, 1],    # Lv1.�y���z
        [1, 0, 5],   # Lv1.�V�F���}�b�`
#        [1, 0, 52],   # Lv1.�X�N���b�`
        [1, 1, 302],    # Lv1.�y�A�N�Z�v�g�z
        ]
      end
      # �N���XID����ʏK���X�L����ǉ�
      case name
      #------------------------------------------------------------------------
      # �����l��
      #------------------------------------------------------------------------
      when "Hu��an" # ��l��
        # Lv1.�y��S�z
        group.push([1, 1, 113])
        # Lv2. �`�F�b�N
        group.push([2, 0, 126])  
        # Lv4.�K�[�h
        group.push([4, 0, 145])  
        # Lv7.�y��ۂ悢�̎�z
        group.push([7, 1, 240]) unless $PRODUCT_VERSION 
        # Lv7.�f�B�o�E�A�[
        group.push([7, 0, 106]) if $PRODUCT_VERSION
        # Lv10.�w���B�X�E�B���O
        group.push([10, 0, 33])
        # Lv13 .�y�񕜗́z
        group.push([13, 1, 212])  
        # Lv16.���t���b�V��
        group.push([16, 0, 125]) 
        # Lv20.�ő�
        group.push([20, 0, 599]) 
        # Lv20.��S
        group.push([20, 0, 600])
        # Lv24.�y���䖲���z
        group.push([24, 1, 150])
        # Lv24.�y�����́z
        group.push([24, 1, 213]) 
        # Lv24.�v���C�X�I�u�n����
        group.push([24, 0, 362])
        # Lv28.�J�[���u���X
        group.push([28, 0, 122])
        # Lv33.�y���\���z
        group.push([33, 1, 154]) 
        # Lv37.�y�΍R�S�z
        group.push([37, 1, 151])
        # Lv42.�y�J���X�}�z
        group.push([42, 1, 73]) 
        # Lv47.�y�_�́z
        group.push([47, 1, 110]) 
      #------------------------------------------------------------------------
      # �����T�L���o�X��
      #------------------------------------------------------------------------
      when "Lesser Succubus ","Succubus","Succubus Lord "
        # Lv1.�c�[�p�t
        group.push([1, 0, 91])   
        # Lv1.�y���g�z(��)
        group.push([1, 1, 120]) if self.color == "��" 
        # Lv4.�e�B�[�Y
        group.push([4, 0, 101])  
        # Lv8.�G�L�T�C�g�r���[
        group.push([8, 0, 18])   
        # Lv12.�y�z���z
        group.push([12, 1, 70])  
        # Lv12.�����N�A�b�v�i���b�T�[�T�L���o�X�j
        group.push([12, 0, 249]) if self.name == "Lesser Succubus "
        # Lv15.���i���u����
        group.push([15, 0, 171]) 
        # Lv15.�h���E�l�N�^�[
        group.push([15, 0, 16])  if $PRODUCT_VERSION 
        # Lv15.�y�y���X�R�[�v�z
        group.push([15, 1, 307]) if $PRODUCT_VERSION 
        # Lv20.�C���X�V�[�h�i��j
        group.push([20, 0, 161]) if self.color == "��" 
        # Lv24.�X�C�[�g�E�B�X�p�[
        group.push([24, 0, 418])
        # Lv30.�e���v�e�[�V����
        group.push([30, 0, 140]) 
        # Lv34.�y�n���z
        group.push([34, 1, 124]) 
        # Lv34.�����N�A�b�v�i�T�L���o�X�j
        group.push([34, 0, 249]) if self.name == "Succubus" 
      #------------------------------------------------------------------------
      # �����f�r����
      #------------------------------------------------------------------------
      when "I��p","Devil ","De��on"
        # Lv1.�l���l�C�[�U
        group.push([1, 0, 177])  
        # Lv6.�e���[
        group.push([6, 0, 208])  
        # Lv9.�G�L�T�C�g�r���[
        group.push([9, 0, 18])  
        # Lv12.�R���I�C�[�U
        group.push([12, 0, 189]) 
        # Lv12.�����N�A�b�v�i�C���v�j
        group.push([12, 0, 249]) if self.name == "I��p" 
        # Lv16.�T�t���C�[�U
        group.push([16, 0, 185]) 
        # Lv18.�y�_�́z�i�f�r���ȍ~�j
        group.push([18, 1, 110]) if self.name == "Devil " or self.name == "De��on"
        # Lv20.�y�񕜗́z
        group.push([20, 1, 212]) 
        # Lv26.�h���E�l�N�^�[
        group.push([26, 0, 16])  if $PRODUCT_VERSION 
        # Lv26.�y�y���X�R�[�v�z�i�f�r���ȍ~�j
        group.push([26, 1, 307]) if $PRODUCT_VERSION and (self.name == "Devil " or self.name == "De��on") 
        # Lv27.�Д��i�f�r���ȍ~�j
        group.push([27, 0, 620]) if self.name == "Devil " or self.name == "De��on"
        # Lv30.�y����񕜗́z�i�΁j
        group.push([30, 1, 213]) if self.color == "��" 
        # Lv30.�R���I�C�[�U�E�A���_�i���j
        group.push([30, 0, 190]) if self.color == "��"
        # Lv34.�����N�A�b�v�i�f�r���j
        group.push([34, 0, 249]) if self.name == "Devil "
        # Lv34.�y�΍R�S�z
        group.push([34, 1, 151])  
        # Lv37.�A�X�^�C�[�U�E�A���_
        group.push([37, 0, 194]) 
      #------------------------------------------------------------------------
      # �����E�B�b�`��
      #------------------------------------------------------------------------
      when "Little Witch","Witch "
        # Lv1.�`�F�b�N
        group.push([1, 0, 126])
        # Lv1.�y��ۗǂ��̎�z�i�΁j
        group.push([1, 1, 240]) if self.color == "��"
        # Lv1.�y�L�X�X�C�b�`�z(��)
#        group.push([1, 1, 160]) if self.color == "��" and $DEBUG
        # Lv2.�C���X�V�[�h
        group.push([2, 0, 161]) 
        # Lv5.���i���u����
        group.push([5, 0, 171]) 
        # Lv8.�A�X�^�u����
        group.push([8, 0, 191]) 
        # Lv10.�C�[�U�J�[��
        group.push([10, 0, 221]) 
        # Lv12.�y�N�W�z�i�΁j
        group.push([12, 1, 221]) if self.color == "��" 
        # Lv12.�T�t���u�����E�A���_�i���j
        group.push([12, 0, 184]) if self.color == "��" 
        # Lv12.�����N�A�b�v�i�v�`�E�B�b�`�j
        group.push([12, 0, 249]) if self.name == "Little Witch"
        # Lv14.�p�����C�Y
        group.push([14, 0, 210]) 
        # Lv17.�G���_�u����
        group.push([17, 0, 179]) 
        # Lv20.�C���X�y�^��
        group.push([20, 0, 162]) 
        # Lv25.�C���X�V�[�h�E�A���_�i�΁j
        group.push([25, 0, 165]) if self.color == "��"
        # Lv25.�R���I�u�����E�A���_�i���j
        group.push([25, 0, 188]) if self.color == "��" 
        # Lv30.�Z�b�g�T�[�N��
        group.push([30, 0, 359])
        # Lv30.�y���@�́z�i�΁j
        group.push([30, 1, 130]) if self.color == "��" 
        # Lv30.�G���_�u�����E�A���_�i���j
        group.push([30, 0, 180]) if self.color == "��" 
        # Lv36.���i���u�����E�A���_
        group.push([36, 0, 172]) 
        # Lv40.���`���A���T�[�N��
#��        group.push([40, 0, 126]) 
      #------------------------------------------------------------------------
      # �����L���X�g��
      #------------------------------------------------------------------------
      when "Caster"
        # Lv1.�y�T���`�F�b�N�z
        group.push([1, 1, 134]) if self.color == "��" 
        # Lv1.�y��ۗǂ��̎�z
        group.push([1, 1, 240])
        # Lv1.�y�d�o�q�[�����O�z
        group.push([1, 1, 210]) 
        # Lv5.�l���l�u����
        group.push([5, 0, 175]) 
        # Lv8.�y�ڑ����̎�z
        group.push([8, 1, 241]) 
        # Lv10.�`�F�b�N
        group.push([10, 0, 126]) 
        # Lv14.�C���X�V�[�h
        group.push([14, 0, 161]) 
        # Lv19.�y�u�o�q�[�����O�z
        group.push([19, 1, 211]) 
        # Lv23.�C�[�U�J�[��
        group.push([23, 0, 221]) 
        # Lv30.�����b�N�X�^�C��
        group.push([30, 0, 611]) 
        # Lv40.�A�i���C�Y
        group.push([40, 0, 127])     
        # Lv50.�l���l�u�����E�A���_
        group.push([50, 0, 176]) 
      #------------------------------------------------------------------------
      # �����X���C����
      #------------------------------------------------------------------------
      when "Slave "
        # ���V�F���}�b�`�A�X�N���b�`�A�y�A�N�Z�v�g�z�͏K�����Ȃ�
        group.delete([1, 0, 5])
        group.delete([1, 0, 52])
        group.delete([1, 1, 302])
        # Lv1.�y�ŗ~�z
        group.push([1, 1, 126])
        # Lv1.�K�[�h
        group.push([4, 0, 145])
        # Lv1.�y�x���̔����z
        group.push([1, 1, 228])
        # Lv1.�y�d�o�q�[�����O�z
        group.push([1, 1, 210]) 
        # Lv20.�y�u�o�q�[�����O�z
        group.push([19, 1, 211]) 
        # Lv30.�C���f���A
        group.push([30, 0, 146])
        # Lv30.�A�s�[��
        group.push([30, 0, 148])
      #------------------------------------------------------------------------
      # �����i�C�g���A��
      #------------------------------------------------------------------------
      when "Night��are"
        # Lv1.�e���[
        group.push([1, 0, 208])
        # Lv1.�y�_�́z
        group.push([1, 1, 110])
        # Lv3.�A�X�^�C�[�U
        group.push([3, 0, 193])
        # Lv6.�p�����C�Y
        group.push([6, 0, 210])
        # Lv10.�u�����J�[��
        group.push([10, 0, 219])
        # Lv13.�g�������[�g
        group.push([13, 0, 215])
        # Lv16.���U���W�B�i���j
        group.push([16, 0, 206]) if self.color == "��"
        # Lv16.�����̌��t���i���j
        group.push([16, 0, 416]) if self.color == "��"
        # Lv20.���[�Y
        group.push([20, 0, 212])
        # Lv24.�T�f�B�X�g�J���X
        group.push([34, 0, 361])
        # Lv24.��ɂ�
#��        group.push([24, 0, 127])
        # Lv30.�y�C�h�E�e���[
        group.push([30, 0, 209])
        # Lv34.�y�C�h�E���U���W�B�i���j
        group.push([34, 0, 207]) if self.color == "��"
        # Lv34.�y�o�b�h�`�F�C���z�i���j
        group.push([34, 1, 136]) if self.color == "��"
        # Lv38.�y�C�h�E���[�Y
        group.push([38, 0, 213])
      #------------------------------------------------------------------------
      # �����X���C����
      #------------------------------------------------------------------------
      when "Sli��e","Gold Sli��e "
        # Lv1.�y�_��z
        group.push([1, 1, 112])
        # Lv1.�y�S�́z
        group.push([1, 1, 114])
        # Lv1.�y�v���e�N�V�����z
        group.push([1, 1, 115]) if self.name == "Gold Sli��e "
        # Lv1.�y���^�z
        group.push([1, 1, 222]) if self.name == "Gold Sli��e "
        # Lv3.�X���C�~�[���L�b�h
        group.push([3, 0, 587])
        # Lv7.�c�[�p�t
        group.push([7, 0, 91])
        # Lv7.���X�g���[�V����
        group.push([7, 0, 586])
        # Lv10.�R�[���h�^�b�`
        group.push([10, 0, 360])
        # Lv13.�y�񕜗́z
        group.push([13, 1, 212]) if self.name == "Sli��e"
        # Lv16.�G���u���C�X
        group.push([16, 0, 17])
        # Lv20.���t���b�V��
        group.push([20, 0, 125])
        # Lv23.�h���E�l�N�^�[
        group.push([25, 0, 16])
        # Lv23.�y�y���X�R�[�v�z
        group.push([25, 1, 307])
        # Lv27.�A�s�[��
        group.push([27, 0, 148])
        # Lv30.�X���C���t�B�[���h
        group.push([30, 0, 626])
        # Lv36.�J�[���u���X
        group.push([36, 0, 122]) if self.name == "Sli��e"
      #------------------------------------------------------------------------
      # �����t�@�~���A��
      #------------------------------------------------------------------------
      when "Fa��iliar "
        # Lv1.�y��ۗǂ��̎�z�i�j
        group.push([1, 1, 240]) if self.color == "��"
        # Lv1.�f�B���h�C���T�[�g�i�΁j
        group.push([1, 0, 20]) if self.color == "��"
        # Lv1.�f�B���h�C���}�E�X�i�΁j
        group.push([1, 0, 21]) if self.color == "��"
        # Lv3.�y�ڑ����̎�z�i�j
        group.push([3, 1, 241]) if self.color == "��"
        # Lv3.�y���g�z�i�΁j
        group.push([3, 1, 120]) if self.color == "��"
        # Lv4.�`�F�b�N
        group.push([4, 0, 126])
        # Lv4.�N�b�L���O�i�j
        group.push([4, 0, 241]) if self.color == "��"
        # Lv8.�R���I�C�[�U
        group.push([8, 0, 189])
        # Lv10.�G���_�u����
        group.push([10, 0, 179])
        # Lv14.�y�N�W�z�i�j
        group.push([14, 1, 221]) if self.color == "��"
        # Lv14.�p�b�V�����r�[�g
        group.push([14, 0, 613]) if self.color == "��"   
        # Lv18.�g�����X�g�[�N
        group.push([18, 0, 216])
        # Lv20.�y�����m���z�i�j
        group.push([20, 1, 104]) if self.color == "��"
        # Lv20.�G���u���C�X
        group.push([20, 0, 17])
        # Lv24.��S
        group.push([24, 0, 600]) if self.color == "��"
        # Lv24.�ő�
        group.push([24, 0, 599]) if self.color == "��"
        # Lv28.�y��S�z�i�j
        group.push([28, 1, 113]) if self.color == "��"
        # Lv28.�y�_�́z�i�΁j
        group.push([28, 1, 120]) if self.color == "��"
        # Lv36.�y���Áz�i�j
        group.push([36, 1, 108]) if self.color == "��"
        # Lv36.�y�n���z�i�΁j
        group.push([36, 1, 124]) if self.color == "��"
      #------------------------------------------------------------------------
      # �������[�E���t��
      #------------------------------------------------------------------------
      when "Were��olf "
        # Lv1.�n�E�����O
        group.push([1, 0, 415])
        # Lv1.�y�ڑ����̎�z�i���j
        group.push([1, 1, 240]) if self.color == "��"
        # Lv1.�y���\���z�i�ԁj
        group.push([4, 1, 154]) if self.color == "��"
        # Lv3 �G�L�T�C�g�r���[
        group.push([3, 0, 18])
        # Lv6.�y�񕜗́z
        group.push([6, 1, 212])
        # Lv9.�y�_�E�g�z
        group.push([9, 1, 226])
        # Lv12.�{�\�̌Ăъo�܂�
        group.push([12, 0, 601])
        # Lv14.�h���E�l�N�^�[
        group.push([16, 0, 16]) if $PRODUCT_VERSION
        # Lv20.�Д�
        group.push([20, 0, 620])   
        # Lv24.�y�x���̔����z�i���j
        group.push([24, 1, 228]) if self.color == "��"
        # Lv24.�y���C�z�i�ԁj
        group.push([24, 1, 109]) if self.color == "��"
        # Lv27.�p�b�V�����r�[�g
        group.push([27, 0, 613])   
        # Lv30.�y�����́z
        group.push([30, 1, 214]) 
        # Lv36.�y�΍R�S�z
        group.push([36, 1, 151])  
      #------------------------------------------------------------------------
      # �������[�L���b�g��
      #------------------------------------------------------------------------
      when "Werecat "
        # Lv1.�y�_��z
        group.push([1, 1, 112])
        # Lv1.�y���^�z(��)
        group.push([1, 1, 222]) if self.color == "��"
        # Lv1.�A�����b�L�[���A(��)
        group.push([1, 0, 420]) if self.color == "��"
        # Lv3.�`���[��
        group.push([3, 0, 200])
        # Lv7.���i���u����
        group.push([7, 0, 171]) 
        # Lv10.���[�Y
        group.push([10, 0, 212])
        # Lv13.�g���b�N���C�h
        group.push([13, 0, 104])
        # Lv18.�C���X�V�[�h
        group.push([18, 0, 161]) 
        # Lv20.�T�t���C�[�U
        group.push([20, 0, 185])
        # Lv24.�G���_�u����
        group.push([24, 0, 179])
        # Lv28.�h���E�l�N�^�[
        group.push([28, 0, 16])
        # Lv30.�{�\�̌Ăъo�܂�
        group.push([30, 0, 601])
        # Lv35.�y�C�h�E���[�Y
        group.push([35, 0, 212])
      #------------------------------------------------------------------------
      # �����S�u������
      #------------------------------------------------------------------------
      when "Goblin","Goblin Leader "
        # Lv1.�y�������̘A�g�z
        group.push([1, 1, 81]) if self.name == "Goblin"
        # Lv1.�y�������̓����z
        group.push([1, 1, 82]) if self.name == "Goblin Leader "
        # Lv1.�y��P�̔����z
        group.push([1, 1, 227])
        # Lv4.�G�L�T�C�g�r���[
        group.push([4, 0, 18])
        # Lv9.�G���_�u����
        group.push([9, 0, 179]) 
        # Lv13.�h���E�l�N�^�[
        group.push([13, 0, 16])  
        # Lv17.�R���I�u����
        group.push([17, 0, 187]) 
        # Lv20.�ő�
        group.push([20, 0, 599]) 
        # Lv23.�p�b�V�����r�[�g
        group.push([23, 0, 613])   
        # Lv26.�����N�A�b�v�i�S�u�����j
        group.push([26, 0, 249]) if self.name == "Goblin"
        # Lv26.����
        group.push([26, 0, 588]) if self.name == "Goblin Leader "
        # Lv29.�K�[�h
        group.push([29, 0, 145]) if self.name == "Goblin Leader "
        # Lv29.�p�����C�Y
        group.push([29, 0, 210]) if self.name == "Goblin Leader "
        # Lv35.�y�΍R�S�z
        group.push([35, 1, 151]) 
        # Lv40.�v�����H�[�N
        group.push([40, 0, 149])
      #------------------------------------------------------------------------
      # �����v���[�X�e�X��
      #------------------------------------------------------------------------
      when "Priestess "
        # ���V�F���}�b�`�A�X�N���b�`�A�y�A�N�Z�v�g�z�͏K�����Ȃ�
        group.delete([1, 0, 5])   
        group.delete([1, 0, 52])
        group.delete([1, 1, 302])
        # Lv1.�y�����̕ۏ؁z
        group.push([1, 1, 135])
        # Lv1.�C���X�V�[�h
        group.push([1, 0, 161]) 
        # Lv1.�����Ȃ���
        group.push([1, 0, 421]) 
        # Lv4.�l���l�u����
        group.push([4, 0, 175]) 
        # Lv7.�C�[�U�J�[��
        group.push([7, 0, 221]) 
        # Lv10.�A�X�^�u����
        group.push([10, 0, 191]) 
        # Lv17.�C���X�y�^��
        group.push([17, 0, 162]) 
        # Lv21.�C���X�V�[�h�E�A���_
        group.push([21, 0, 165]) 
        # Lv25.�E�H�b�V���t���[�h
        group.push([25, 0, 224])   
        # Lv30.�C���X�t���E
        group.push([30, 0, 163]) 
        # Lv36.�C���X�y�^���E�A���_
        group.push([36, 0, 166]) 
        # Lv40.�C���X�R���i
        group.push([50, 0, 164]) 
        # Lv55.�C���X�t���E�E�A���_
        group.push([60, 0, 167]) 
      #------------------------------------------------------------------------
      # �����J�[�X���C�K�X��
      #------------------------------------------------------------------------
      when "Cursed Magus"
        # Lv1.�e���[
        group.push([1, 0, 208])  
        # Lv1.�y�}�]�q�X�g�z
        group.push([1, 1, 72])
        # Lv1.���X�g
        group.push([1, 0, 202])
        # Lv4.�T�t���C�[�U
        group.push([4, 0, 185])
        # Lv7.�G���_�C�[�U
        group.push([7, 0, 181])
        # Lv11.�R���I�C�[�U
        group.push([11, 0, 189])
        # Lv16.���U���W�B
        group.push([16, 0, 206])
        # Lv20.�G���u���C�X
        group.push([20, 0, 17])
        # Lv20.�y�y���X�R�[�v�z
        group.push([20, 1, 307])
        # Lv24.�T�f�B�X�g�J���X
        group.push([24, 0, 361])
        # Lv30.�y�C�h�E���X�g
        group.push([30, 0, 203])
        # Lv35.�T�t���C�[�U�E�A���_
        group.push([35, 0, 186])
        # Lv40.�y�d��z
        group.push([40, 1, 83])
        # Lv50.�G���_�C�[�U�E�A���_
        group.push([50, 0, 182])
      #------------------------------------------------------------------------
      # �����A�����E�l��
      #------------------------------------------------------------------------
      when "Alraune "
        # Lv1.�y�_�E�g�z
        group.push([1, 1, 226])
        # Lv1.�y�Ɖu�́z
        group.push([1, 1, 118])
        # Lv1.�y���}���`�X�g�z
        group.push([1, 1, 123])
        # Lv1.�y�z���z
        group.push([1, 1, 70]) if self.color == "��"
        # Lv1.�X�C�[�g�E�B�X�p�[
        group.push([1, 0, 418])
        # Lv1.���u�t���O�����X
        group.push([1, 0, 625])
        # Lv7.�y�񕜗́z
        group.push([7, 1, 212])
        # Lv12.�G���u���C�X
        group.push([12, 0, 17])
        # Lv15.�X�C�[�g�A���}
        group.push([15, 0, 612])
        # Lv20.�A�C���B�N���[�Y
        group.push([20, 0, 591])
        # Lv23.�h���E�l�N�^�[
        group.push([23, 0, 16]) 
        # Lv23.�y�y���X�R�[�v�z
        group.push([23, 1, 307]) 
        # Lv26.�y�����́z
        group.push([26, 1, 213]) 
        # Lv30.�j���̌��t��
        group.push([30, 0, 417]) if self.color == "��"
        # Lv30.�����̌��t��
        group.push([30, 0, 416]) if self.color == "��"
        # Lv34.�y��S�z
        group.push([34, 1, 113]) if self.color == "��"
        # Lv34.�y�_�́z
        group.push([34, 1, 110]) if self.color == "��"
        # Lv40.���t���b�V��
        group.push([40, 0, 125]) if self.color == "��"
      #------------------------------------------------------------------------
      # �����}�^���S��
      #------------------------------------------------------------------------
      when "Matango "
        # Lv1.�y�_�E�g�z
        group.push([1, 1, 226])
        # Lv1.�y�Ɖu�́z
        group.push([1, 1, 118])
        # Lv1.���t���b�V��
        group.push([1, 0, 125])
        # Lv4.�o�b�h�X�|�A
        group.push([4, 0, 589])
        # Lv8.�y�񕜗́z
        group.push([8, 1, 212])
        # Lv15.�X�|�A�N���E�h
        group.push([15, 0, 590])
        # Lv19.�y�����́z
        group.push([19, 1, 213]) 
        # Lv23.�C���X�V�[�h
        group.push([23, 0, 161]) 
        # Lv26.�y��P�̔����z
        group.push([26, 1, 227])
        # Lv30.�X�g�����W�X�|�A
        group.push([30, 0, 618])
        # Lv35.�C���X�y�^��
        group.push([35, 0, 162]) 
        # Lv40.�E�B�[�N�X�|�A
        group.push([40, 0, 619])
      #------------------------------------------------------------------------
      # �����G���W�F����
      #------------------------------------------------------------------------
      when "Dark Angel"
        # Lv1.�����̌��t��
        group.push([1, 0, 416])
        # Lv1.�j���̌��t��
        group.push([1, 0, 417])
        # Lv1.�C���X�V�[�h
        group.push([1, 0, 161]) 
        # Lv4.�e�B�[�Y
        group.push([4, 0, 101])  
        # Lv10.�G���_�u����
        group.push([10, 0, 179])
        # Lv14.�T�t���C�[�U
        group.push([14, 0, 185])
        # Lv20.�C���X�y�^��
        group.push([20, 0, 162]) 
        # Lv24.�C���X�V�[�h�E�A���_
        group.push([24, 0, 165]) 
        # Lv28.�G���u���C�X
        group.push([28, 0, 17])
        # Lv28.�y�y���X�R�[�v�z
        group.push([28, 1, 307]) 
        # Lv32.�����b�N�X�^�C��
        group.push([32, 0, 611]) 
        # Lv38.�G�L�T�C�g�r���[
        group.push([38, 0, 18])   
        # Lv40.�E�H�b�V���t���[�h
        group.push([40, 0, 224])   
        # Lv45.�C���X�t���E
        group.push([45, 0, 163]) 
      #------------------------------------------------------------------------
      # �����K�[�S�C����
      #------------------------------------------------------------------------
      when "Gargoyle"
        # Lv1.�y�_�E�g�z
        group.push([1, 1, 226])
        # Lv1.�y�u���b�L���O�z
        group.push([1, 1, 116])
        # Lv1.�K�[�h
        group.push([1, 0, 145])  
        # Lv1.�y��P�̔����z
        group.push([1, 1, 227])
        # Lv1.�y�x���̔����z
        group.push([1, 1, 228])
        # Lv1.�v�����H�[�N
        group.push([1, 0, 149])
        # Lv36.�J�[���u���X
        group.push([36, 0, 122])
        # Lv40.�Д�
        group.push([8, 0, 620])   
        # Lv42.�C���f���A
        group.push([1, 0, 146])
        # Lv45.���t���b�V��
        group.push([1, 0, 125])
      #------------------------------------------------------------------------
      # �����~�~�b�N��
      #------------------------------------------------------------------------
      when "Mi��ic"
        # Lv1.�y�_�E�g�z
        group.push([1, 1, 226]) if self.color == "��"
        # Lv1.�p�b�V�����r�[�g
        group.push([8, 0, 613]) if self.color == "��"
        # Lv1.�y�ŗ~�z
        group.push([1, 1, 126]) if self.color == "��"
        # Lv1.�y�G�N�X�^�V�[�{���z
        group.push([1, 1, 170]) if self.color == "��"
        # Lv1.�A�s�[��
        group.push([1, 0, 148]) if self.color == "��"
        # Lv1.�v�����H�[�N
        group.push([1, 0, 149]) if self.color == "��"
        # Lv1.�y�N�W�z
        group.push([1, 1, 221])
        # Lv1.�y���^�z
        group.push([1, 1, 222])
        # Lv1.�y��P�̔����z
        group.push([1, 1, 227])
        # Lv1.�`���[��
        group.push([1, 0, 200])
        # Lv10.�l���l�u����
        group.push([25, 0, 175])
        # Lv15.�h���E�l�N�^�[
        group.push([15, 0, 16]) 
        # Lv18.���i���u����
        group.push([18, 0, 171]) 
        # Lv22.�g���b�N���C�h
        group.push([22, 0, 104])
        # Lv25.�t�@�X�g���C�h
        group.push([22, 0, 103])
        # Lv30.�K�[�h
        group.push([30, 0, 145])  
        # Lv40.�C���f���A
        group.push([40, 0, 146])
      #------------------------------------------------------------------------
      # �����^�}����
      #------------------------------------------------------------------------
      when "Ta��a��o"
        # Lv1.�y�����z
        group.push([1, 1, 117]) 
        # Lv1.�y�u���b�L���O�z
        group.push([1, 1, 116])
        # Lv1.�c�[�p�t
        group.push([1, 0, 91])   
        # Lv4.�e�B�[�Y
        group.push([4, 0, 101])  
        # Lv8.�T�t���u����
        group.push([8, 0, 183])
        # Lv15.�h���E�l�N�^�[
        group.push([15, 0, 16]) 
        # Lv15.�y�y���X�R�[�v�z
        group.push([15, 1, 307])
        # Lv30.�e���v�e�[�V����
        group.push([30, 0, 140]) 
        # Lv25.�G�L�T�C�g�r���[
        group.push([8, 0, 18])   
        # Lv30.�y�n���z
        group.push([30, 1, 124]) 
        # Lv40.�y�����́z
        group.push([40, 1, 213]) 
        # Lv50.�{�\�̌Ăъo�܂�
        group.push([12, 0, 601])
      #------------------------------------------------------------------------
      # ������������
      #------------------------------------------------------------------------
      when "Lili��"
        # Lv1.�y�ŗ~�z
        group.push([1, 1, 126])
        # Lv1.�y�z���z
        group.push([1, 1, 70])  
        # Lv1.�`���[��
        group.push([1, 0, 200])
        # Lv1.���X�g
        group.push([1, 0, 202])
        # Lv1.�G�L�T�C�g�r���[
        group.push([1, 0, 18])
        # Lv7.�l���l�C�[�U
        group.push([7, 0, 177])  
        # Lv12.�c�[�p�t
        group.push([12, 0, 91])   
        # Lv20.�h���E�l�N�^�[
        group.push([20, 0, 16]) 
        # Lv20.�G���u���C�X
        group.push([20, 0, 17])
        # Lv20.�y�y���X�R�[�v�z
        group.push([20, 1, 307])
        # Lv25.�A�X�^�C�[�U
        group.push([25, 0, 193])
        # Lv30.�y�n���z
        group.push([30, 1, 124]) 
        # Lv40.�y���\���z
        group.push([40, 1, 154]) 
        # Lv50.�y���X�ȍU�߁z
        group.push([40, 1, 127]) 
      #------------------------------------------------------------------------
      # �������j�[�N�T�L���o�X��
      #------------------------------------------------------------------------
      when "Unique Succubus ","Unique Tycoon ","Unique Witch"
        case self.color
        #----------------------------------------------------------------------
        # �����l�C�W�������W
        #----------------------------------------------------------------------
        when "Neijorage "
          # Lv1.�y���������сz
          group.push([1, 1, 21])
          # Lv1.�y�ł̑̉t�z
          group.push([1, 1, 91])
          # Lv1.�y�Ɖu�́z
          group.push([1, 1, 118])
          # Lv1.�y�G��₷���z
          group.push([1, 1, 106])
          # Lv1.�X�g�����W�X�|�A
          group.push([1, 0, 618])
          # Lv1.�E�B�[�N�X�|�A
          group.push([1, 0, 619])
          # Lv1.�c�[�p�t
          group.push([1, 0, 91])   
          # Lv1.�G�L�T�C�g�r���[
          group.push([1, 0, 18])
          # Lv1.�h���E�l�N�^�[
          group.push([1, 0, 16]) 
          # Lv1.�y�y���X�R�[�v�z
          group.push([1, 1, 307])
          # Lv42.�v�����H�[�N
          group.push([42, 0, 149])
        #----------------------------------------------------------------------
        # �������W�F�I
        #----------------------------------------------------------------------
        when "Rejeo "
          # Lv1.�y���������сz
          group.push([1, 1, 19])
          # Lv1.�y���䖲���z
          group.push([1, 1, 150])
          # Lv5.�T�t���u����
          group.push([5, 0, 183])
          # Lv5.�Z�b�g�T�[�N��
          group.push([5, 0, 359])
          # Lv10.�h���E�l�N�^�[
          group.push([10, 0, 16])
          # Lv10.�C�[�U�J�[��
          group.push([10, 0, 221]) 
          # Lv15.�y�x���̔����z
          group.push([15, 1, 228])
          # Lv15.�y���������@�z
          group.push([15, 1, 229])
          # Lv15.�y�����̋ɈӁz
          group.push([15, 1, 230])
          # Lv20.�p�����C�Y
          group.push([20, 0, 210])
          # Lv25.���i���u����
          group.push([25, 0, 171]) 
          # Lv30.�g�������[�g
          group.push([30, 0, 215])
          # Lv30.�G���u���C�X
          group.push([30, 0, 17])
          # Lv40.�T�t���u�����E�A���_
          group.push([40, 0, 184])
        #----------------------------------------------------------------------
        # �����t���r���A
        #----------------------------------------------------------------------
        when "Fulbeua "
          # Lv1.�y�m�ł��鎩���S�z
          group.push([1, 1, 93]) if $PRODUCT_VERSION
          # Lv1.�y�A�j�������сz
          group.push([1, 1, 27])
          # Lv1.�G�L�T�C�g�r���[
          group.push([1, 0, 18])
          # Lv1.�e���v�e�[�V����
          group.push([1, 0, 140]) 
          # Lv1.�c�[�p�t
          group.push([1, 0, 91])   
          # Lv1.�e�B�[�Y
          group.push([1, 0, 101])  
          # Lv1.�y�z���z
          group.push([1, 1, 70])  
          # Lv25.�y�n���z
          group.push([25, 1, 124])  
          # Lv25.�y�΍R�S�z
          group.push([25, 1, 151])  
          # Lv25.���M�ߏ�
          group.push([25, 0, 602])  
          # Lv25.�h���E�l�N�^�[
          group.push([25, 0, 16]) 
          # Lv25.�y�y���X�R�[�v�z
          group.push([25, 1, 307])
          # Lv25.�v���C�X�I�u�V�i�[
          group.push([25, 0, 363])
          # Lv25.�p�b�V�����r�[�g
          group.push([25, 0, 613])
          # Lv50.�y�J���X�}�z
          group.push([50, 1, 73]) 
        #----------------------------------------------------------------------
        # �����M���S�[��
        #----------------------------------------------------------------------
        when "Gilgoon "
          # ���V�F���}�b�`�A�X�N���b�`�A�y�A�N�Z�v�g�z�͏K�����Ȃ�
          group.delete([1, 0, 5])   
          group.delete([1, 0, 52])
          group.delete([1, 1, 302])
          # Lv1.�y���������сz
          group.push([1, 1, 21])
          # Lv1.�y�ߕq�Ȑg�́z
          group.push([1, 1, 94])
          # Lv1.�y�������s�z
          group.push([1, 1, 332])
          # Lv1.�y�_�E�g�z
          group.push([1, 1, 213])
          # Lv1.�K�[�h
          group.push([1, 0, 145])
          # Lv1.�G���_�C�[�U�E�A���_
          group.push([1, 0, 182])
          # Lv1.�T�t���C�[�U�E�A���_
          group.push([1, 0, 186])
          # Lv1.�R���I�C�[�U�E�A���_
          group.push([1, 0, 190])
          # Lv1.�A�X�^�C�[�U�E�A���_
          group.push([1, 0, 194])
          # Lv1.�y�C�h�E���U���W�B
          group.push([1, 0, 207])
          # Lv1.�y�C�h�E�e���[
          group.push([1, 0, 209])
          # Lv1.�y�C�h�E�p�����C�Y
          group.push([1, 0, 211])
          # Lv1.�y�C�h�E���[�Y
          group.push([1, 0, 213])
          # Lv1.�X�g�����C�[�U
          group.push([1, 0, 197])
          # Lv1.����
          group.push([1, 0, 588])
          # Lv1.�u�����J�[���E�A���_
          group.push([1, 0, 220])
          # Lv45.�C���f���A
          group.push([45, 0, 146])
        #----------------------------------------------------------------------
        # �������[�K�m�b�g
        #----------------------------------------------------------------------
        when "Yuganaught"
          # Lv1.�y���K�������сz
          group.push([1, 1, 23])
          # Lv1.�y�T���`�F�b�N�z
          group.push([1, 1, 134])
          # Lv1.�y�_�́z
          group.push([1, 1, 110])
          # Lv1.�y�}�]�q�X�g�z
          group.push([1, 1, 72])
          # Lv1.�f�����Y�h���E
          group.push([1, 0, 26])
          # Lv1.�y�z���z
          group.push([1, 1, 70])  
          # Lv1.�A�X�^�u����
          group.push([1, 0, 191]) 
          # Lv1.�l���l�C�[�U
          group.push([1, 0, 177])  
          # Lv1.�R�[���h�^�b�`
          group.push([1, 0, 360])
          # Lv8.�Д�
          group.push([8, 0, 620])   
          # Lv16.���U���W�B
          group.push([16, 0, 206])
          # Lv20.���[�Y
          group.push([20, 0, 212])
          # Lv24.�T�f�B�X�g�J���X
          group.push([24, 0, 361])
        #----------------------------------------------------------------------
        # �����V���t�F
        #----------------------------------------------------------------------
        when "Sylphe"
          # Lv1.�y���������сz
          group.push([1, 1, 19])
          # Lv1.�y���}���`�X�g�z
          group.push([1, 1, 123])  
          # Lv1.�y��ǂ݁z
          group.push([1, 1, 96])  
          # Lv1.�y�������s�z
          group.push([1, 1, 332])
          # Lv1.�T�[���@���g�R�[��
          group.push([1, 0, 248])  
          # Lv1.�h���E�l�N�^�[
          group.push([1, 0, 16]) 
          # Lv1.�y�y���X�R�[�v�z
          group.push([1, 1, 307])
          # Lv1.�G���u���C�X
          group.push([1, 0, 17])
          # Lv1.�X�C�[�g�E�B�X�p�[
          group.push([1, 0, 418])
          # Lv1.�e���v�e�[�V����
          group.push([1, 0, 140]) 
          # Lv1.���u�t���O�����X
          group.push([1, 0, 625])
          # Lv1.�A�X�^�u����
          group.push([1, 0, 191]) 
          # Lv1.�j���̌��t��
          group.push([1, 0, 417])
          # Lv1.�c�[�p�t
          group.push([1, 0, 91])   
          # Lv1.�e�B�[�Y
          group.push([1, 0, 101])  
          # Lv45.�A�X�^�u�����E�A���_
          group.push([45, 0, 192]) 
        #----------------------------------------------------------------------
        # �������[�~��
        #----------------------------------------------------------------------
        when "Ra��ile "
          # Lv1.�y���������сz
          group.push([1, 1, 21])
          # Lv1.�y���\���z
          group.push([1, 1, 154])
          # Lv1.�y���䖲���z
          group.push([1, 1, 150])
          # Lv15.�y�x���̔����z
          group.push([15, 1, 228])
          # Lv15.�y�����̋ɈӁz
          group.push([15, 1, 230])
          # Lv1.�h���E�l�N�^�[
          group.push([1, 0, 16]) 
          # Lv1.�X�g�����u����
          group.push([1, 0, 195])
          # Lv1.�Z�b�g�T�[�N��
          group.push([1, 0, 359])
          # Lv5.�l���l�u����
          group.push([5, 0, 175]) 
          # Lv5.�R���I�u����
          group.push([5, 0, 187]) 
          # Lv38.�y�C�h�E�`���[��
          group.push([38, 0, 201])
          # Lv38.�y�C�h�E�p�����C�Y
          group.push([38, 0, 211])
          # Lv56.�y�y���X�R�[�v�z
          group.push([56, 1, 307])
          # Lv60.�E�H�b�V���t���[�h
          group.push([60, 0, 224]) 
        #----------------------------------------------------------------------
        # �������F���~�B�[�i
        #----------------------------------------------------------------------
        when "Ver��iena "
          # Lv1.�y���A�������сz
          group.push([1, 1, 29])
          # Lv1.�y�z���z
          group.push([1, 1, 70])  
          # Lv1.�c�[�p�t
          group.push([1, 0, 91])   
          # Lv1.�e�B�[�Y
          group.push([1, 0, 101])  
          # Lv1.�G�L�T�C�g�r���[
          group.push([1, 0, 18])
          # Lv1.�h���E�l�N�^�[
          group.push([1, 0, 16]) 
          # Lv1.�y�y���X�R�[�v�z
          group.push([1, 1, 307])
          # Lv1.�y�n���z
          group.push([1, 1, 124]) 
          # Lv1.�y���X�ȍU�߁z
          group.push([1, 1, 127]) 
          # Lv1.�y�G�N�X�^�V�[�{���z
          group.push([1, 1, 170]) 
          # Lv1.�v���C�X�I�u�V�i�[
          group.push([1, 0, 363])
          # Lv1.�S�Ă͌�
          group.push([1, 0, 622])
          # Lv1.�y���\�i�u���C�N
          group.push([1, 0, 364])
          # Lv1.�l���l�C�[�U
          group.push([1, 0, 177])  
          # Lv1.�A�X�^�C�[�U
          group.push([1, 0, 193]) 
          # Lv1.�X�C�[�g�E�B�X�p�[
          group.push([1, 0, 418])
          # Lv1.�����̌��t��
          group.push([1, 0, 416])
          # Lv65.�G���u���C�X
          group.push([65, 0, 17])
        end
      end  

      #------------------------------------------------------------------------
      # �� �z�[���h�X�L�����������ꍇ�A�����œ����B
      # ���A�N�Z�v�g�A�y���X�R�[�v�͖������ł͎g�p�ł��Ȃ��̂ŏ�Ɏ蓮�œ����B
      #------------------------------------------------------------------------
      for learn in group
        if learn[1] == 0
          case learn[2]
          when 5  # �V�F���}�b�`
            group += [[learn[0], 1, 303]]
          when 6  # �C���T�[�g 
            group += [[learn[0], 1, 301]]
          when 16 # �h���E�l�N�^�[
            group += [[learn[0], 1, 306]]
          when 17 # �G���u���C�X
            group += [[learn[0], 1, 305]]
          when 18 # �G�L�T�C�g�r���[
            group += [[learn[0], 1, 304]]
          when 20 # �C�N�C�b�v�f�B���h
            group += [[learn[0], 1, 314]]
          when 26 # �e���^�N���}�X�^���[
            group += [[learn[0], 1, 313]]
          end
        end
      end
      
      

      
      
      
      return group
    end
    #--------------------------------------------------------------------------
    # �� ���O�擾
    #--------------------------------------------------------------------------
    def name
      n = @name.split(/\//)[0]
      n = @name if n == nil
      return n
    end
    #--------------------------------------------------------------------------
    # �� �F�擾
    #--------------------------------------------------------------------------
    def color
      n = @name.split(/\//)[1]
      n = "���ݒ�" if n == nil
      return n
    end
    #--------------------------------------------------------------------------
    # �� ���J�C���X�^���X�ϐ�
    #--------------------------------------------------------------------------
    def original_name
      return @name      
    end
  end
end