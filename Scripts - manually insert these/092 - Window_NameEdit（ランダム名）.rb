#==============================================================================
# �� Window_NameEdit
#------------------------------------------------------------------------------
# �@�����_�����i�[�B
#==============================================================================

class Window_NameEdit < Window_Base
  #--------------------------------------------------------------------------
  # �� �����_����
  #�@�@type 0:�ۂ��Ǝ擾 1:��p���̂ݎ擾
  #--------------------------------------------------------------------------
  def random_name(type)
    common_name_list = []
    special_name_list = []
    # ���ʂ̖��O���擾(��l���͏Ȃ�)
    if @actor != $game_actors[101]
      common_name_list = [
      "Luna",
      "Paprika",
      "Cocoa",
      "Melfeina",
      "Fiorel",
      "Meine",
      "Rendra",
      "Yutona",
      "Eriju",
      "Braveru",
      "Ralai",
      "Vanilla",
      "Oiuri",
      "Ofura",
      "Reine",
      "Torulte",
      "Chunia",
      "Rufurde",
      "Ashley",
      "Ashby",
      "Hyusure",
      "Myu",
      "Sophie",
      "Sorunia",
      "Kaloris",
      "Delweiss",
      "Kalmiria",
      "Carane",
      "Tau",
      "Buracche",
      "Zateibi",
      "Emily",
      "Renenge",
      "Fenichi",
      "Kamira",
      "Mireyu",
      "Krisena",
      "Zarea",
      "Terapalm",
      "Lure",
      "Snipe",
      "Neuru",
      "Bianca",
      "Hayuz",
      "Carlen",
      "Lindeia",
      "Finis",
      "Feruve",
      "Luraver",
      "Atoris",
      "Angie",
      "Femibelle",
      "Hayonehayona",
      "Equipme",
      "New",
      "Holy",
      "Marika",
      "Safonse",
      "Fufululu",
      "Mintoa",
      "Shia",
      "Ryueru",
      "Torikushi",
      ]
    else
      common_name_list = [
      "Laurat"
      ]
    end
    # �푰���̖��O��ǉ�
    case $data_classes[@actor.class_id].name
    #------------------------------------------------------------------------
    # �����l��
    #------------------------------------------------------------------------
    when "Hu��an"
      special_name_list = [
      "Laurat",
      "Laurence",
      "Lauren"
      ]
    #------------------------------------------------------------------------
    # �����T�L���o�X��
    #------------------------------------------------------------------------
    when "Lesser Succubus"
      special_name_list = [
      "Reki",
      "Dea",
      "Cherito",
      "Nancy",
      "Mystoria",
      "Sue",
      "Ravi",
      "Amore",
      "Aini",
      "Reeve",
      "Shita",
      "Polkel",
      "Belura",
      "Nue"
      ]
    when "Succubus"
      special_name_list = [
      "Leone",
      "Fise",
      "Frau",
      "Elise",
      "Promethe",
      "Luka",
      "Meria",
      "Litoria",
      "Lulu",
      "Korapto",
      "Misty",
      "Carla",
      "Eraste"
      ]
    when "Succubus Lord"
      special_name_list = [
      "Estella",
      "Benevian",
      "Rocca-Voke",
      "Maya",
      "Ashiera",
      "Voluvue",
      "Anu",
      "Vivio",
      "Moria",
      "Teia",
      "Cetar"
      ]
    #------------------------------------------------------------------------
    # �����f�r����
    #------------------------------------------------------------------------
    when "I��p"
      special_name_list = [
      "Mini",
      "Murin",
      "Plum",
      "Naughty",
      "Al",
      "Petit",
      "Meme",
      "Pickle",
      "Fay",
      "Le Roux"
      ]
    when "Devil"
      special_name_list = [
      "Ain",
      "Carol",
      "Marla",
      "Sione",
      "Reiger",
      "Folse",
      "Amy",
      "Andrea",
      "Levianne",
      "Laura"
      ]
    when "De��on"
      special_name_list = [
      "Griselle",
      "Zapito",
      "Zasrida",
      "Nicceres",
      "Graafa",
      "Leien",
      "Labiella",
      "Noralas",
      "Aster",
      "Verio"
      ]
    #------------------------------------------------------------------------
    # �����E�B�b�`��
    #------------------------------------------------------------------------
    when "Little Witch"
      special_name_list = [
      "Petronia",
      "Sarii",
      "Kiki",
      "Theodora",
      "Isabeau",
      "Curio",
      "Genius",
      "Ceres",
      "Paletta",
      "Teira",
      "Little Mouse",
      "Ariel"
      ]
    when "Witch"
      special_name_list = [
      "Leffi",
      "Vanessa",
      "Wikka",
      "Eva",
      "Glende",
      "Benneta",
      "Marie",
      "Pachie",
      "Margott",
      "Deiretta",
      "Cantante",
      "Learese"
      ]
    #------------------------------------------------------------------------
    # �����L���X�g��
    #------------------------------------------------------------------------
    when "Caster"
      special_name_list = [
      "Ann",
      "Laura",
      "Margaret",
      "Sarah",
      "Wendy",
      "Flone",
      "Coco",
      "Cathy",
      "Iria",
      "Rebecca",
      "Francois",
      "Mary",
      "Chris",
      "Sea",
      "Jane"
      ]
    #------------------------------------------------------------------------
    # �����X���C����
    #------------------------------------------------------------------------
    when "Slave"
      special_name_list = [
      "Kashieu",
      "Ouida",
      "Santomue",
      "Elminae",
      "Tanjea",
      "Sofar",
      "Zera",
      "Malkara",
      "Canon",
      ]
    #------------------------------------------------------------------------
    # �����i�C�g���A��
    #------------------------------------------------------------------------
    when "Night��are"
      special_name_list = [
      "Hypnox",
      "Mesmerique",
      "Isles",
      "Kasume",
      "Mabelle",
      "Teita",
      "Cthulhu",
      "Remme",
      "Mary",
      "Mea",
      "Meniki",
      "Flo"
      ]
    #------------------------------------------------------------------------
    # �����X���C����
    #------------------------------------------------------------------------
    when "Sli��e"
      special_name_list = [
      "Jelly",
      "Paroa",
      "Pudding",
      "Mousse",
      "Lathe",
      "Sue",
      "Panna",
      "Sumli",
      "Beth",
      "Bubble",
      "Jiggly",
      "Lime"
      ]
    when "Gold Slime"
      special_name_list = [
      "Aiyu",
      "Rochuon",
      "Midasa",
      "Paqua",
      "Hanaki",
      "Leidei",
      "Yellow",
      "Tiara",
      "Nanajik",
      "Eoroyo"
      ]
    #------------------------------------------------------------------------
    # �����t�@�~���A��
    #------------------------------------------------------------------------
    when "Familiar"
      special_name_list = [
      "Lotta",
      "Challise",
      "Viola",
      "Emilia",
      "Peria",
      "Kimora",
      "Silk",
      "Rumba",
      "Fami"
      ]
    #------------------------------------------------------------------------
    # �������[�E���t��
    #------------------------------------------------------------------------
    when "Werewolf"
      special_name_list = [
      "Kerube",
      "Orotoro",
      "Enrir",
      "Leica",
      "Peria",
      "Lugaru",
      "Hattei",
      "Skorr",
      "Hachiko"
      ]
    #------------------------------------------------------------------------
    # �������[�L���b�g��
    #------------------------------------------------------------------------
    when "Werecat"
      special_name_list = [
      "Tama",
      "Bastetta",
      "Kay",
      "Sekette",
      "Kitei",
      "Shuridan",
      "Butter-bun",
      "Nyaami",
      "Nameless",
      ]
    #------------------------------------------------------------------------
    # �����S�u������
    #------------------------------------------------------------------------
    when "Goblin"
      special_name_list = [
      "Pyrderi",
      "Mogfana",
      "Gabrude",
      "Granada",
      "Kukuri",
      "Frela",
      "Ningusta",
      "Nakuru",
      "Mortara",
      "Diana",
      ]
    when "Goblin Leader"
      special_name_list = [
      "Rinri",
      "Chieftain",
      "Akaboosh",
      "Heartmen",
      "Taboo",
      "Bodua",
      "Naoe",
      "Kanshin",
      "Zappi",
      ]
    #------------------------------------------------------------------------
    # �����v���[�X�e�X��
    #------------------------------------------------------------------------
    when "Priestess"
      special_name_list = [
      "Marielle",
      "Ursula",
      "Catalina",
      "Anastasia",
      "Anna",
      "Veronica",
      "Polonia",
      "Julia",
      "Eularia",
      ]
    #------------------------------------------------------------------------
    # �����J�[�X���C�K�X��
    #------------------------------------------------------------------------
    when "Cursed Magus"
      special_name_list = [
      "Marefy",
      "Godelle",
      "Asura",
      "Ravena",
      "Grimhild",
      "Warp",
      "Salem",
      "Bellatrix",
      "Tsusuruk",
      ]
    #------------------------------------------------------------------------
    # �����A�����E�l��
    #------------------------------------------------------------------------
    when "Alraune"
      special_name_list = [
      "Namizuki",
      "Dizzy",
      "Asia",
      "Churada",
      "Jikidari",
      "Clover",
      "Dalli",
      "Haidoreji",
      "Hozuki",
      ]
    #------------------------------------------------------------------------
    # �����}�^���S��
    #------------------------------------------------------------------------
    when "Matango"
      special_name_list = [
      "Quenne",
      "Sasako",
      "Tsukiyo",
      "Dokutsuru",
      "Benny",
      "Shagma",
      "Saura",
      "Warai",
      "Majru",
      "Etori",
      "Wannape",
      ]
    #------------------------------------------------------------------------
    # �����G���W�F����
    #------------------------------------------------------------------------
    when "Dark Angel"
      special_name_list = [
      "Aster",
      "Moann",
      "Zazeru",
      "Belia",
      "Masty",
      "Meriku",
      "Fleur",
      "Shame",
      "Shyton",
      "Israph"
      ]
    #------------------------------------------------------------------------
    # �����K�[�S�C����
    #------------------------------------------------------------------------
    when "Gargoyle"
      special_name_list = [
      "Grisaiyu",
      "Deanne",
      "Esu",
      "Pelide",
      "Amuto",
      "Nelly",
      "Konia",
      "Azure"
      ]
    #------------------------------------------------------------------------
    # �����~�~�b�N��
    #------------------------------------------------------------------------
    when "Mi��ic"
      special_name_list = [
      "Pandora",
      "Kyabii",
      "Trappe",
      "Brudan",
      "Kottori",
      "Kofin",
      "Hanmakido",
      "Dorosera",
      "Nepentus",
      "Fultora"
      ]
    #------------------------------------------------------------------------
    # �����^�}����
    #------------------------------------------------------------------------
    when "Ta��a��o"
      special_name_list = [
      "Inari",
      "Ducky",
      "Ninetails",
      "Yako",
      "Tsune",
      "Myobu",
      "Kasama",
      "Fushimi",
      "Mikuzu",
      "Kuzuno",
      "Shino",
      "Ushiuka"
      ]
    #------------------------------------------------------------------------
    # ������������
    #------------------------------------------------------------------------
    when "Lili��"
      special_name_list = [
      "Rias",
      "Grette",
      "Dorthea",
      "Lize",
      "Cindy",
      "Carlain",
      "Taria",
      "Rapshia",
      "Redfuda",
      ]
    end
    
    name_list = special_name_list
    name_list += common_name_list if name_list == []
    name_list += common_name_list if type == 0
    # ���t���Ă��閼�O������ꍇ�͏Ȃ�
    name_list.delete(@name)
    return name_list
  end
end
