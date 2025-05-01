import 'package:flagquizgame/data/models/flag_model.dart';

// Kıta ve bölgelere göre bayrakları organize etmek için sınıf
class FlagCategories {
  // Kıtalara göre ülke grupları
  static const Map<String, List<String>> continentCountries = {
    'Avrupa': [
      'Türkiye', 'Almanya', 'Fransa', 'İtalya', 'İspanya', 'İngiltere', 
      'Yunanistan', 'Portekiz', 'Belçika', 'İsveç', 'Danimarka',
      'Norveç', 'İsviçre', 'Polonya', 'Ukrayna', 'Finlandiya', 'İrlanda',
      'Hollanda', 'Avusturya', 'Macaristan', 'Çekya', 'Slovakya', 'Bulgaristan',
      'Romanya', 'Hırvatistan', 'Sırbistan', 'Bosna Hersek', 'Kuzey Makedonya',
      'Arnavutluk', 'Litvanya', 'Letonya', 'Estonya', 'Moldova', 'Beyaz Rusya',
      'Slovenya', 'Lüksemburg', 'Malta', 'Kıbrıs', 'İzlanda', 'Karadağ',
      'Vatikan', 'Lihtenştayn', 'Andorra', 'Monako', 'San Marino'
    ],
    'Asya': [
      'Japonya', 'Çin', 'Hindistan', 'Endonezya', 'Filipinler', 
      'Güney Kore', 'Pakistan', 'Tayland', 'Vietnam', 'Malezya',
      'Singapur', 'Kamboçya', 'Lao', 'Nepal', 'Bangladeş', 'Myanmar',
      'Afganistan', 'Irak', 'İran', 'Suriye', 'Özbekistan', 'Türkmenistan',
      'Kazakistan', 'Gürcistan', 'Bhutan', 'Sri Lanka', 'Moğolistan', 
      'Kuzey Kore', 'Azerbeycan', 'Ermenistan', 'Kırgızistan', 'Tacikistan',
      'Brunei', 'Maldivler', 'Timor-Leste',
      // Orta Doğu ülkeleri Asya'ya eklendi
      'Suudi Arabistan', 'Birleşik Arap Emirlikleri', 'Katar', 'Lübnan',
      'Umman', 'Bahreyn', 'Kuveyt', 'Ürdün', 'Yemen',
      // Okyanusya'dan bazı ülkeler Asya'ya eklendi (coğrafi olarak daha yakın olanlar)
      'Papua Yeni Gine', 'Solomon Adaları'
    ],
    'Amerika': [
      'ABD', 'Kanada', 'Meksika', 'Brezilya', 'Arjantin', 'Şili',
      'Kolombiya', 'Peru', 'Ekvador', 'Bolivya', 'Paraguay', 'Uruguay',
      'Venezuela', 'Küba', 'Jamaika', 'Haiti', 'Dominik Cumhuriyeti',
      'Honduras', 'El Salvador', 'Guatemala', 'Nicaragua', 'Panama',
      'Kosta Rika', 'Belize', 'Surinam', 'Guyana', 'Dominika', 'Barbados',
      'Grenada', 'Bahamalar', 'Trinidad ve Tobago', 'Antigua ve Barbuda',
      'Saint Kitts ve Nevis', 'Saint Lucia', 'Saint Vincent ve Grenadinler'
    ],
    'Afrika': [
      'Mısır', 'Güney Afrika', 'Tunus', 'Gana', 'Kenya', 'Senegal',
      'Zambiya', 'Zimbabve', 'Madagaskar', 'Botsvana', 'Malavi',
      'Mozambik', 'Sudan', 'Eritre', 'Eswatini', 'Fas', 'Cezayir', 'Libya',
      'Nijerya', 'Etiyopya', 'Somali', 'Uganda', 'Tanzanya', 'Ruanda',
      'Burundi', 'Kongo', 'Demokratik Kongo Cumhuriyeti', 'Angola', 'Namibya',
      'Mali', 'Nijer', 'Çad', 'Orta Afrika Cumhuriyeti', 'Kamerun', 'Gabon',
      'Ekvator Ginesi', 'Gine', 'Gine-Bissau', 'Liberya', 'Fildişi Sahili',
      'Burkina Faso', 'Togo', 'Benin', 'Sierra Leone', 'Gambiya', 'Mauritanya',
      'Morityus', 'Komor', 'Seyşeller', 'Cabo Verde', 'Sao Tome ve Principe',
      'Lesotho', 'Djibouti'
    ],
    'Avustralya ve Pasifik': [
      'Avustralya', 'Yeni Zelanda', 'Fiji', 'Vanuatu', 'Tonga',
      'Kiribati', 'Samoa', 'Mikronezya', 'Marshall Adaları', 'Palau', 'Nauru', 'Tuvalu'
    ]
  };

  // Zorluk seviyelerine göre bayraklar
  static const Map<String, List<String>> difficultyLevels = {
    'Kolay': [
      'Türkiye', 'ABD', 'İngiltere', 'Fransa', 'Almanya', 'İtalya', 
      'Japonya', 'Çin', 'Brezilya', 'Kanada', 'Avustralya', 'İspanya',
      'Meksika', 'Hindistan', 'Rusya', 'Güney Afrika', 'Suudi Arabistan', 
      'Mısır', 'Katar', 'İsveç', 'Norveç', 'Belçika', 'Yunanistan', 'Polonya',
      'Ukrayna', 'Güney Kore'
    ],
    'Orta': [
      'Portekiz', 'İsviçre', 'Arjantin', 'Şili', 'Pakistan', 
      'Hollanda', 'Kolombiya', 'Peru', 'Finlandiya', 'İrlanda', 'Danimarka',
      'Avusturya', 'Macaristan', 'Endonezya', 'Vietnam', 'Singapur', 'Tayland',
      'Yeni Zelanda', 'Birleşik Arap Emirlikleri', 'İran', 'Fas', 'Nijerya', 
      'Kenya', 'Cezayir', 'Libya', 'Küba', 'Venezuela', 'İsrail', 'Kazakistan',
      'Filipinler', 'Malezya', 'Çekya', 'Slovakya', 'Romanya', 'Bulgaristan'
    ],
    'Zor': [
      'Hırvatistan', 'Sırbistan', 'Bolivya', 'Paraguay', 'Uruguay', 'Gana', 'Senegal', 
      'Zambiya', 'Zimbabve', 'Madagaskar', 'Nepal', 'Özbekistan',
      'Türkmenistan', 'Bhutan', 'Eswatini', 'Sudan', 'Fiji', 'Vanuatu',
      'Surinam', 'Guyana', 'Dominika', 'Barbados', 'Grenada', 'Bahamalar',
      'Honduras', 'El Salvador', 'Guatemala', 'Nicaragua', 'Panama',
      'Kosta Rika', 'Moğolistan', 'Sri Lanka', 'Bangladeş', 'Myanmar', 
      'Etiyopya', 'Uganda', 'Tanzanya', 'Angola', 'Mali', 'Gabon',
      'Sierra Leone', 'Namibya', 'Kamerun', 'Gürcistan', 'Ermenistan', 'Azerbeycan',
      'Umman', 'Bahreyn', 'Kuveyt', 'Ürdün', 'Yemen', 'Papua Yeni Gine', 
      'Solomon Adaları', 'Samoa', 'Mikronezya', 'Marshall Adaları', 'Palau', 
      'Nauru', 'Tuvalu', 'Kiribati', 'Tonga'
    ],
    'Uzman': [
      // Tüm bayraklar burada olacak - getFilteredFlags metodunda tüm bayraklar döndürülecek
    ]
  };

  // Ana bayrak listesinden belirli bir kategoriye ait bayrakları filtreleme
  static List<FlagModel> getFilteredFlags(List<FlagModel> allFlags, String category) {
    List<String> categoryCountries = [];
    
    // Kıta bazlı filtreleme
    if (continentCountries.containsKey(category)) {
      categoryCountries = continentCountries[category]!;
    } 
    // Zorluk bazlı filtreleme
    else if (difficultyLevels.containsKey(category)) {
      categoryCountries = difficultyLevels[category]!;
    }
    
    // Eğer geçerli bir kategori değilse veya 'Tümü' seçildiyse, tüm bayrakları döndür
    if (categoryCountries.isEmpty || category == 'Tümü') {
      return allFlags;
    }
    
    // Filtreleme işlemi
    return allFlags.where((flag) => categoryCountries.contains(flag.name)).toList();
  }
}