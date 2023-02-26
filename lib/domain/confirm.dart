class Confirm{
  Confirm();

  //when

  String? isSelectedCalendar = "HistoricalYears";
  int year = 0;
  int? date = 0;
  String? dateLocal = "";

  //what
  String name = "";

  //where
  String country = "";
  String? place = "";
  double? latitude = 0.0;
  double? longitude = 0.0;
  String? countryAtThatTime = "";
  String? placeAtThatTime = "";
  double? x = 0.0;
  double? y = 0.0;
  double? z = 0.0;

  //pay involved
  List<String> selectedPays = [];
  List<String> selectedPaysId = [];

  //who
  List<String> selectedWho = [];
  List<String> selectedWhoId = [];

  //terms
  List<String> selectedTerm = [];
  List<String> selectedTermId = [];

  final int confirmId = 0;

}
