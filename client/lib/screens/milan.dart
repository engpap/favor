import 'package:google_maps_flutter/google_maps_flutter.dart';

class District {
  String name;
  double lat;
  double lng;
  double zoom;
  late CameraPosition cameraPos =
      CameraPosition(target: LatLng(lat, lng), zoom: zoom);
  District(this.name, this.lat, this.lng, this.zoom);
}

District Duomo = District("Duomo", 45.464211, 9.191383, 12);
District Citta_Studi =
    District("Citta Studi", 45.47815936226321, 9.225742177836649, 15);
District Lambrate =
    District("Lambrate", 45.485014696249756, 9.238284715958756, 15);
District Dergano =
    District("Dergano", 45.50477773344957, 9.180029355586573, 15);
District Loreto = District("Loreto", 45.486237157819296, 9.21685883291871, 15);
District Brera = District("Brera", 45.4742521036288, 9.18815684296889, 12);
District Parco_sempione = District("Parco Sempione", 45.4741307597238, 9.17625108249191, 12);
District Bicocca = District("Bicocca", 45.5189786893546, 9.21281209486847, 12);
District Lodi = District("Lodi", 45.4364835142404, 9.22844566030333, 12);
District Porta_genova = District("Porta Genova", 45.4539667385633, 9.16188540813703, 12);


final Set<District> setDistricts = {
  Duomo,
  Citta_Studi,
  Lambrate,
  Dergano,
  Loreto,
  Brera,
  Parco_sempione,
  Bicocca,
  Lodi,
  Porta_genova
};

// Take a String
// Return it's District, or a null if doesn't found
District? getDistrictFromName(String location) {
  for (District district in setDistricts) {
    if (equalsIgnoreCase(district.name, location) == true) {
      return district;
    }
  }
  return null;
}

bool equalsIgnoreCase(String string1, String string2) {
  return string1.toLowerCase() == string2.toLowerCase();
}

//  District Duomo = District("Duomo", 45.464211, 9.191383, 15);
//District Brera = District("Brera", 45.4757, 9.1894, 15);
//District Porta_Venezia = District("Porta Venezia", 45.4747, 9.2108, 15);
//District Ticinese = District("Ticinese", 45.4697, 9.1583, 15);
//District Magenta = District("Magenta", 45.5382, 9.1300, 15);
//District Sempione = District("Sempione", 45.4733, 9.1600, 15);
//District Garibaldi = District("Garibaldi", 45.4851, 9.1954, 15);
//District Stazione_Centrale = District("Stazione Centrale", 45.4681, 9.1799, 15);
//District Isola = District("Isola", 45.5266, 9.1370, 15);
//District Greco = District("Greco", 45.5134, 9.1354, 15);
//District Bicocca = District("Bicocca", 45.5192, 9.1813, 15);
//District Turro = District("Turro", 45.4970, 9.1533, 15);
//  District Citta_Studi = District("Città Studi", 45.4967, 9.2034, 15);
//  District Lambrate = District("Lambrate", 45.5456, 9.2069, 15);
//District Barona = District("Barona", 45.5016, 9.1147, 15);
//District Giambellino = District("Giambellino", 45.5057, 9.2000, 15);
//District Lorenteggio = District("Lorenteggio", 45.5023, 9.1535, 15);
//District Baggio = District("Baggio", 45.4975, 9.1388, 15);
//District San_Siro = District("San Siro", 45.4987, 9.1652, 15);
//District San_Leonardo = District("San Leonardo", 45.5299, 9.1879, 15);
//District Vialba = District("Vialba", 45.5068, 9.1598, 15);
//District Bovisa = District("Bovisa", 45.5159, 9.1265, 15);
//  District Dergano = District("Dergano", 45.5347, 9.1239, 15);
//District Affori = District("Affori", 45.5282, 9.1657, 15);
//District Navigli = District("Navigli", 45.4536, 9.1775, 15);
//District Corso_Buenos_Aires = District("Corso Buenos Aires", 45.4913, 9.2030, 15);

/** 
District Cenisio = District("Cenisio", 45.4549, 9.1371, 15);
District Moscova = District("Moscova", 45.4839, 9.1791, 15);
District Triennale = District("Triennale", 45.4685, 9.1936, 15);
District San_Sperate = District("San Sperate", 45.4866, 9.1058, 15);
District Romolo = District("Romolo", 45.4964, 9.1367, 15);
*/

/**
  01. Duomo
  02. Brera
03. Giardini Porta Venezia
04. Guastalla
05. Porta Vigentina - Porta Lodovica
    06. Porta Ticinese - Conca del Naviglio
  07. Magenta - San Vittore
  08. Parco Sempione
  09. Porta Garibaldi - Porta Nuova
  10. Stazione Centrale - Ponte Seveso
  11. Isola
12. Maciachini-Maggiolina
  13. Greco - Segnano
14. Niguarda - Ca’ Granda - Prato Centenaro - Q.re Fulvio Testi
  15. Bicocca
16. Gorla - Precotto
17. Adriano
18. Cimiano - Rottole - Q.re Feltre
  19. Padova - Turro - Crescenzago
20. Loreto - Casoretto - NoLo
    21. Buenos Aires - Porta Venezia - Porta Monforte
  22. Città studi
  23. Lambrate - Ortica
24. Parco Forlanini - Cavriano
25. Corsica
26. XXII Marzo
27. Porta Romana
28. Umbria - Molise - Calvairate
29. Ortomercato
30. Taliedo - Morsenchio - Q.re Forlanini
31. Monluè - Ponte Lambro
32. Triulzo Superiore
33. Rogoredo - Santa Giulia
34. Chiaravalle
35. Lodi-Corvetto
36. Scalo Romana
37. Morivione
38. Vigentino - Q.re Fatima
39. Quintosole
40. Ronchetto delle Rane
41. Gratosoglio - Q.re Missaglia - Q.re Terrazze
42. Stadera - Chiesa Rossa - Q.re Torretta - Conca Fallata
43. Tibaldi
  ?44. Porta Ticinese - Conchetta
45. Moncucco - San Cristoforo
  46. Barona
47. Cantalupa
48. Ronchetto sul Naviglio - Q.re Lodovico il Moro
  49. Giambellino
50. Porta Genova
51. Porta Magenta
52. Bande Nere
  53. Lorenteggio
54. Muggiano
  55. Baggio - Q.re degli Olmi - Q.re Valsesia
56. Forze Armate
  57. San Siro
58. De Angeli-Monte Rosa
59. Tre Torri
60. Stadio - Ippodromi
61. Quarto Cagnino
62. Quinto Romano
63. Figino
64. Trenno
  65. Q.re Gallaratese - Q.re San Leonardo - Lampugnano
66. QT8
67. Portello
68. Pagano
69. Sarpi
70. Ghisolfa
71. Villapizzone - Cagnola - Boldinasco
72. Maggiore - Musocco - Certosa
73. MIND - Cascina Triulza
74. Roserio
75. Stephenson
76. Quarto Oggiaro - Vialba - Musocco
  77. Bovisa
78. Farini
  79. Dergano
  80. Affori
81. Bovisasca
82. Comasina
83. Bruzzano
84. Parco Nord
85. Parco delle Abbazie
86. Parco dei Navigli
87. Assiano
88. Parco Bosco in città
 */

/*
* FATTI BENE

District Duomo = District ("Duomo", 45.4637071790056, 9.18694829227998, 12);
District brera = District("Brera", 45.4742521036288, 9.18815684296889, 12);
District giardini_p_ta_venezia = District("Giardini P.Ta Venezia", 45.4745637403773, 9.20023093081574, 12);
District guastalla = District("Guastalla", 45.4632189878796, 9.20189141897755, 12);
District porta_vigentina_porta_lodovica = District("Porta Vigentina - Porta Lodovica", 45.4509500236955, 9.19244574588716, 12);
District porta_ticinese_conca_del_naviglio = District("Porta Ticinese - Conca Del Naviglio", lat, lng, 12);
District magenta_s_vittore = District("Magenta S. Vittore", lat, lng, 12);
District parco_sempione = District("Parco Sempione", lat, lng, 12);
District porta_garibaldi_porta_nuova = District("Porta Garibaldi - Porta Nuova", lat, lng, 12);
District stazione_centrale_ponte_seveso = District("Stazione Centrale - Ponte - Seveso", lat, lng, 12);
District isola = District("Isola", lat, lng, 12);
District maciachini_maggiolina = District("Maciachini - Maggiolina", lat, lng, 12);
District greco_segnano = District("Greco - Segnano", lat, lng, 12);
District niguarda_ca_granda_prato_centenario_q_re_fulvio_testi = District("Niguarda - Ca' Granda - Prato Centenario - Q.Re Fulvio Testi", lat, lng, 12);
District bicocca = District("Bicocca", lat, lng, 12);
District gorla_precotto = District("Gorla - Precotto", lat, lng, 12);
District adriano = District("Adriano", lat, lng, 12);
District cimiano_rottole_q_re_feltre = District("Cimiano - Rottole - Q.Re Feltre", lat, lng, 12);
District padova_turro_crescenzago = District("Padova - Turro - Crescenzago", lat, lng, 12);
District loreto_casoretto_nolo = District("Loreto - Casoretto - Nolo", lat, lng, 12);
District buenos_aires_porta_venezia_porta_monforte = District("Buenos Aires - Porta Venezia - Porta Monforte", lat, lng, 12);
District citta_studi = District("Citta Studi", lat, lng, 12);
District lambrate_ortica = District("Lambrate - Ortica", lat, lng, 12);
District parco_forlanini_cavriano = District("Parco Forlanini - Cavriano", lat, lng, 12);
District corsica = District("Corsica", lat, lng, 12);
District xxii_marzo = District("XXII Marzo", lat, lng, 12);
District pta_romana = District("Pta Romana", lat, lng, 12);
District umbria_molise_calvairate = District("Umbria - Molise - Calvairate", lat, lng, 12);
District ortomercato = District("Ortomercato", lat, lng, 12);
District taliedo_morsenchio_q_re_forlanini = District("Taliedo - Morsenchio - Q.Re Forlanini", lat, lng, 12);
District monlue_ponte_lambro = District("Monlue' - Ponte Lambro", lat, lng, 12);
District triulzo_superiore = District("Triulzo Superiore", lat, lng, 12);
District rogoredo_santa_giulia = District("Rogoredo - Santa Giulia", lat, lng, 12);
District chiaravalle = District("Chiaravalle", lat, lng, 12);
District lodi_corvetto = District("Lodi - Corvetto", lat, lng, 12);
District scalo_romana = District("Scalo Romana", lat, lng, 12);
District morivione = District("Morivione", lat, lng, 12);
District vigentino_q_re_fatima = District("Vigentino - Q.Re Fatima", lat, lng, 12);
District quintosole = District("Quintosole", lat, lng, 12);
District ronchetto_delle_rane = District("Ronchetto Delle Rane", lat, lng, 12);
District gratosoglio_q_re_missaglia_q_re_terrazze = District("Gratosoglio - Q.Re Missaglia - Q.Re Terrazze", lat, lng, 12);
District stadera_chiesa_rossa_q_re_torretta_conca_fallata = District("Stadera - Chiesa Rossa - Q.Re Torretta - Conca Fallata", lat, lng, 12);
District tibaldi = District("Tibaldi", lat, lng, 12);
District porta_ticinese_conchetta = District("Porta Ticinese - Conchetta", lat, lng, 12);
District moncucco_san_cristoforo = District("Moncucco - San Cristoforo", lat, lng, 12);
District barona = District("Barona", lat, lng, 12);
District cantalupa = District("Cantalupa", lat, lng, 12);
District ronchetto_sul_naviglio_q_re_lodovico_il_moro = District("Ronchetto Sul Naviglio - Q.Re Lodovico Il Moro", lat, lng, 12);
District giambellino = District("Giambellino", lat, lng, 12);
District porta_genova = District("Porta Genova", lat, lng, 12);
District porta_magenta = District("Porta Magenta", lat, lng, 12);
District bande_nere = District("Bande Nere", lat, lng, 12);
District lorenteggio = District("Lorenteggio", lat, lng, 12);
District mugiano = District("Muggiano", lat, lng, 12);
District baggio_q_re_degli_olmi_q_re_valsesia = District("Baggio - Q.Re Degli Olmi - Q.Re Valsesia", lat, lng, 12);
District forze_armate = District("Forze Armate", lat, lng, 12);
District san_siro = District("San Siro", lat, lng, 12);
District de_angeli_monte_rosa = District("De Angeli - Monte Rosa", lat, lng, 12);
District tre_torri = District("Tre Torri", lat, lng, 12);
District stadio_ippodromi = District("Stadio - Ippodromi", lat, lng, 12);
District quarto_cagnino = District("Quarto Cagnino", lat, lng, 12);
District quinto_romano = District("Quinto Romano", lat, lng, 12);
District figino = District("Figino", lat, lng, 12);
District trenno = District("Trenno", lat, lng, 12);
District q_re_gallaratese_q_re_san_leonardo_lampugnano = District("Q.Re Gallaratese - Q.Re San Leonardo - Lampugnano", lat, lng, 12);
District qt_8 = District("Qt 8", lat, lng, 12);
District portello = District("Portello", lat, lng, 12);
District pagano = District("Pagano", lat, lng, 12);
District sarca = District("Sarca", lat, lng, 12);
District ghisolfa = District("Ghisolfa", lat, lng, 12);
District villapizzone_cagnola_boldinasco = District("Villapizzone - Cagnola - Boldinasco", lat, lng, 12);
District maggiore_musocco_certosa = District("Maggiore - Musocco - Certosa", lat, lng, 12);
District cascina_merlata = District("Cascina Merlata", lat, lng, 12);
District roserio = District("Roserio", lat, lng, 12);
District stephenson = District("Stephenson", lat, lng, 12);
District quarto_oggiaro_vialba_musocco = District("Quarto Oggiaro - Vialba - Musocco", lat, lng, 12);
District bovisa = District("Bovisa", lat, lng, 12);
District farini = District("Farini", lat, lng, 12);
District dergano = District("Dergano", lat, lng, 12);
District affori = District("Affori", lat, lng, 12);
District bovisca = District("Bovisca", lat, lng, 12);
District comasina = District("Comasina", lat, lng, 12);
District bruzzano = District("Bruzzano", lat, lng, 12);
District parco_nord = District("Parco Nord", lat, lng, 12);
District parco_delle_abbazie = District("Parco Delle Abbazie", lat, lng, 12);
District parco_dei_navigli = District("Parco Dei Navigli", lat, lng, 12);
District assiano = District("Assiano", lat, lng, 12);
District parco_bosco_in_citta = District("Parco Bosco In Citta'", lat, lng, 12);
*/



String mapStyle2 =
    '[{"featureType": "all","stylers": [{ "color": "#C0C0C0" }]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{ "color": "#CCFFFF" }]},{"featureType": "landscape","elementType": "labels","stylers": [{ "visibility": "off" }]}]';

String mapStyle =
    "[{\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#f5f5f5\"}]},{\"elementType\":\"labels.icon\",\"stylers\":[{\"visibility\":\"off\"}]},{\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#616161\"}]},{\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#f5f5f5\"}]},{\"featureType\":\"administrative.land_parcel\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#bdbdbd\"}]},{\"featureType\":\"poi\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#eeeeee\"}]},{\"featureType\":\"poi\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#757575\"}]},{\"featureType\":\"poi.park\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#e5e5e5\"}]},{\"featureType\":\"poi.park\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#9e9e9e\"}]},{\"featureType\":\"road\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#ffffff\"}]},{\"featureType\":\"road.arterial\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#757575\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#dadada\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#616161\"}]},{\"featureType\":\"road.local\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#9e9e9e\"}]},{\"featureType\":\"transit.line\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#e5e5e5\"}]},{\"featureType\":\"transit.station\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#eeeeee\"}]},{\"featureType\":\"water\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#c9c9c9\"}]},{\"featureType\":\"water\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#9e9e9e\"}]}]";

