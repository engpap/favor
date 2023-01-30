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

