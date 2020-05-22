class ScrappyContstants {

  static const String port = "8000";
  static const String ip = "2.226.200.208";
  static const String url = "http://" + ip + ":" + port+'/';

  //Connessioni
  static const String url2 = "https://";

  //networkContexts
  static const String networkContextCashier = "cashier";
  static const String networkContextWaiter = "waiter";
  static const String networkContextGuest = "guest";
  static const String networkContextPublic = "public";

  //networkFunctions
  static const String networkFunctionProductOrders = "product_orders";
  static const String networkFunctionWorkingDays = "working_days";
  static const String networkFunctionProducts = "products";
  static const String networkFunctionSettings = "settings";
  static const String networkFunctionLicense = "licenses";
  static const String networkFunctionMenu = "menu";

  //networkProperties
  static const String networkPropertyTable = "table";
  static const String networkPropertyDelivery = "delivery";

  //statusCode
  static const int successConnection = 200;
  static const int invalidToken = 401;
  static const int noConnection = 404;
  static const int serverProblems = 504;
  static const int warningConnection = 1;

  //token
  static const String baseAudienceUrl = "https://infinite-wave-94271.herokuapp.com/scrappy/";
  static const String newTokenUrl = "https://scrappy.eu.auth0.com/oauth/token";


  static const String clientIDWaiter = "CcNKxm2XQOyy2CHFRUkIHpp15UVCz35e";
  static const String clientSecretWaiter = "UAaIXqbj9VxREtaH6E50GVU6KOWT1WONEI3eF_3tKbkOBz8Lpbn8rrCJopXY4mfS";
  static const String clientAudienceWaiter = baseAudienceUrl + "waiter";

  static const String clientIDCashier = "ADUMXSMt07LNNw0aRXSKkHOK3hGhqawP";
  static const String clientSecretCashier = "OOE4blqWIx_LXAPzHlhA97e-OX13zt11_QOB01n0C2fZR22vFbi_1gGmTtxfAVoi";
  static const String clientAudienceCashier = baseAudienceUrl + "cashier";

  //Generic Buttons
  static const String buttonMenu = "Menù";
  static const String buttonSend = "Conferma";
  static const String buttonCancel = "Chiudi";
  static const String buttonAdd = "Aggiungi";
  static const String buttonNext = "Avanti";
  static const String buttonUpdate = "Aggiorna";
  static const String buttonBack = "Home";

  //Cart Screen
  static const String titleCart = "Carrello";
  static const String titleNoteofOrder = "Note dell'ordine";
  static const String hintTextNote = "Inserisci note";
  static const String buttonBackToOrders = "Ordini";

  //Catalog Screen
  static const String titleOrder = "Ordine: ";
  static const String titleNoteofProduct = "Inserisci le modifiche della portata";

  //Login Screen
  static const String loadingMessage = "Sto connettendo";
  static const String errorLoadingMessage = "Errore";
  static const String titleLogin = "Home";
  static const String titleInsertName = "Inserisci il tuo nome";
  static const String hintTextName = "es: Mario Rossi";
  static const String errorTextEmpty = "Non lasciare il campo vuoto";

  //Tables Screen
  static const String titleTables = "Ordini correnti";
  static const String titleNewOrder = "Inserisci un nuovo tavolo";
  static const String hintTextNewOrder = "es: tavolo 11";

  //Message for errors
  static const String messageNoConnectionTryAgain = "Connessione assente riprovare";

  //Change Menu screens

  //Map of Order
  static const String tablesConfirmed = "tablesConfirmed";
  static const String deliveryConfirmed = "deliveryConfirmed";
  static const String takeAwayConfirmed = "takeAwayConfirmed";
  static const String delivery = "delivery";
  static const String takeAway = "takeAway";

  //titles
  static const String titleSettings = "Settings";
  static const String titleTotalOrders = "Totale Ordini";

  //default strings
  static const String loading = "loading";
  static const String complete = "complete";
  static const String error = "error";
  static const String timeNotDefined = "N/D";

  //STORAGE
  static const String boxUsername = "usernameBox";
  static const String boxRememberUsername = "rememberUsernameBox";
  static const String boxRefreshOrderTime = "refreshOrderTimeBox";
  static const String boxLicense = "licenseBox";

}