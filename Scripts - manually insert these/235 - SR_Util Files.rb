#==============================================================================
# �� SR_Util�@�F�@�t�@�C���֌W
#------------------------------------------------------------------------------
#==============================================================================
module SR_Util

  #--------------------------------------------------------------------------
  # �� �Q�[���g���[�v�̉���
  #--------------------------------------------------------------------------
  def self.game_troop_alter
    for i in 354..386
      for member in $data_troops[i].members
        case $data_enemies[member.enemy_id].name.split(/\//)[1].to_i
        # ���b�T�[�T�L���o�X
        when 5;   member.enemy_id = 196
        when 6;   member.enemy_id = 136
        # �T�L���o�X
        when 10;  member.enemy_id = 195
        when 11;  member.enemy_id = 167
        # �T�L���o�X���[�h
        when 15;  member.enemy_id = 1
        when 16;  member.enemy_id = 1
        # �C���v
        when 21;  member.enemy_id = 154
        when 22;  member.enemy_id = 1
        # �f�r��
        when 26;  member.enemy_id = 155
        when 27;  member.enemy_id = 1
        # �f�[����
        when 31;  member.enemy_id = 1
        when 32;  member.enemy_id = 1
        # �v�`�E�B�b�`
        when 37;  member.enemy_id = 193
        when 38;  member.enemy_id = 201
        # �E�B�b�`
        when 42;  member.enemy_id = 194
        when 43;  member.enemy_id = 202
        # �L���X�g
        when 53;  member.enemy_id = 121
        # �X���C��
        when 63;  member.enemy_id = 199
        # �i�C�g���A
        when 74;  member.enemy_id = 156
        when 75;  member.enemy_id = 156
        # �X���C��
        when 80;  member.enemy_id = 174
        # �S�[���h�X���C��
        when 90;  member.enemy_id = 1
        # �t�@�~���A
        when 96;  member.enemy_id = 198
        when 97;  member.enemy_id = 1
        # ���[�E���t
        when 100; member.enemy_id = 1
        when 101; member.enemy_id = 1
        # ���[�L���b�g
        when 104; member.enemy_id = 1
        when 105; member.enemy_id = 1
        # �S�u����
        when 108; member.enemy_id = 152
        # �M�����O�R�}���_�[
        when 111; member.enemy_id = 153
        # �v���[�X�e�X
        when 118; member.enemy_id = 120
        # �J�[�X���C�K�X
        when 122; member.enemy_id = 197
        # �A�����E�l
        when 126; member.enemy_id = 172
        when 127; member.enemy_id = 1
        # �}�^���S
        when 133; member.enemy_id = 173
        # �_�[�N�G���W�F��
        when 137; member.enemy_id = 1
        # �K�[�S�C��
        when 141; member.enemy_id = 1
        # �~�~�b�N
        when 145; member.enemy_id = 200
        when 146; member.enemy_id = 1
        # �^�}��
        when 152; member.enemy_id = 1
        # ������
        when 156; member.enemy_id = 1
        end
      end
    end
    # �Z�[�u
    save_data($data_troops, "Data/Troops.rxdata") 
    
    
    
  end

  #--------------------------------------------------------------------------
  # �� ����f�[�^�̈Í����Z�[�u
  #--------------------------------------------------------------------------
  def self.msgdata_save
    save_data($msg, "Data/Talk.rxdata") 
  end

  #--------------------------------------------------------------------------
  # �� �N���A�f�[�^�̈Í����Z�[�u
  #--------------------------------------------------------------------------
  def self.trial_cleardata_save
    data = []
    for actor in $game_actors.data
      if actor != nil and actor.class_id != 1 and actor != $game_actors[101]
        data.push(actor)
      end
    end
    $takeover_actors = data
    save_data($takeover_actors, "Savedata/trial_cleardata.rxdata") 
  end
  #--------------------------------------------------------------------------
  # �� �Í������ꂽ�N���A�f�[�^�̃��[�h
  #--------------------------------------------------------------------------
  def self.trial_cleardata_load
    
    f_name = "../Succubus Rhapsodia Trial/Savedata/trial_cleardata.rxdata"
    
    return false unless FileTest.exist?(f_name)
    
    # �Z�[�u�f�[�^�̓ǂݍ���
    file = File.open(f_name, "rb")
    $takeover_actors = Marshal.load(file)
    file.close
    # $game_system�ɕۑ�
    box = []
    for actor in $takeover_actors
      # �o�O�����̃f�r���̐��i��ύX
      if actor.class_name == "Devil " and
       not (actor.personality == "�����C" or actor.personality == "����")
        actor.personality = "�����C"
      end
      box.push(actor)
    end
    $game_system.takeover_actors = box
    return true
  end
  #--------------------------------------------------------------------------
  # �� �����p���Ō_�񂵂������̏���
  #--------------------------------------------------------------------------
  def self.takeover_contract

    # �����p���A�N�^�[���������
    for actor in $game_temp.vs_actors
      $game_system.takeover_actors.delete(actor) 
    end
  end
  
  #--------------------------------------------------------------------------
  # �� �}�b�v�f�[�^�̉���
  #--------------------------------------------------------------------------
  def self.map_alter(map_id)
    
    map = load_data(sprintf("Data/Map%03d.rxdata", map_id))
    #--------------------------------------------------------------------------
    # �z�u���Ă���C�x���g�ʒu�����E���]������
    #--------------------------------------------------------------------------
    for i in map.events.keys
#      map.events[i].page = 
      for page in map.events[i].pages
        if page.graphic.character_name == "185-Light02"
          page.step_anime = false
        end
      end
    end
    #--------------------------------------------------------------------------
    # �㏑������
    save_data(map, sprintf("Data/Map%03d.rxdata", map_id))
    maplist  = load_data("Data/MapInfos.rxdata")
=begin    
    # �~���[�}�b�v�ɕʖ��ۑ�����
    mapinfo = RPG::MapInfo.new
    mapinfo.name = sprintf("�~���[�}�b�v", maplist[map_id].name)
    mapinfo.parent_id = 0
    mapinfo.order = 998
    mapinfo.expanded = true
    mapinfo.scroll_x = 0
    mapinfo.scroll_y = 0
    
    maplist[998]=mapinfo
    save_data(maplist,"Data/MapInfos.rxdata")
=end
  end
  #--------------------------------------------------------------------------
  # �� �}�b�v�f�[�^�̔��]
  #--------------------------------------------------------------------------
  def self.map_mirror_save(map_id)
    
    map = load_data(sprintf("Data/Map%03d.rxdata", map_id))
    #--------------------------------------------------------------------------
    # �z�u���Ă���^�C���ʒu�����E���]������
    #--------------------------------------------------------------------------
    # �^�C���p�e�[�u�������
    tile_table = Table.new(map.width, map.height, 3)
    
    # ����p�݂̂̑Ή��B�ǂƖ��̂݁B
    # �����炭�I�[�g�^�C����380���炢�܂ł����āA��������ʏ�^�C�����o�Ă���B
=begin    
    # �^�C���ԍ��o�͗p
    p ["����",map.data[39,6,0]]
    p ["����",map.data[39,7,0]]
    p ["����",map.data[39,8,0]]
    p ["�E��",map.data[41,6,0]]
    p ["�E��",map.data[41,7,0]]
    p ["�E��",map.data[41,8,0]]
    p ["��",map.data[7,9,1]]
    p ["�E",map.data[7,8,1]]
    p ["��",map.data[15,13,1]]
    p ["��",map.data[29,14,1]]
    exit
=end    
    for x in 0...map.width
      for y in 0...map.height
        for z in 0..2
          tile_table[x,y,z] = 
           case map.data[map.width - x - 1,y,z]
           # ��󍶉E
           when 389;391
           when 391;389
           # �V��p���E
           when 403;404
           when 404;403
           when 411;412
           when 412;411
           # �ǌn�����E
           when 400,408,416,424,432,440
             map.data[map.width - x - 1,y,z] + 2
           # �ǌn�E����
           when 402,410,418,426,434,442
             map.data[map.width - x - 1,y,z] - 2
           else
             map.data[map.width - x - 1,y,z]
           end
        end
      end
    end
    # ���������}�b�v�f�[�^���ڂ�
    map.data = tile_table
    #--------------------------------------------------------------------------
    # �z�u���Ă���C�x���g�ʒu�����E���]������
    #--------------------------------------------------------------------------
    for i in map.events.keys
      map.events[i].x = map.width - map.events[i].x - 1
      # ���ֈړ����E�ֈړ��ɁA�E�ֈړ������ֈړ���
      for page in map.events[i].pages
        for list in page.list
          # �ړ����[�g�̐ݒ�̏ꍇ
          if list.code == 209
            for move_list in list.parameters[1].list
              case move_list.code
              when 2; move_list.code = 3
              when 3; move_list.code = 2
              end
            end
          end
        end
      end
    end
    #--------------------------------------------------------------------------
    save_data(map, sprintf("Data/Map%03d.rxdata", 998))
    maplist  = load_data("Data/MapInfos.rxdata")
    
    mapinfo = RPG::MapInfo.new
    mapinfo.name = sprintf("�~���[�}�b�v", maplist[map_id].name)
    mapinfo.parent_id = 0
    mapinfo.order = 998
    mapinfo.expanded = true
    mapinfo.scroll_x = 0
    mapinfo.scroll_y = 0
    
    maplist[998]=mapinfo
    save_data(maplist,"Data/MapInfos.rxdata")
  end
  
  

  
  
end

