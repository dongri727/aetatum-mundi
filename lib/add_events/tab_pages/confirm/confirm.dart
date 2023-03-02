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
  String? att = "";
  double? x = 0.0;
  double? y = 0.0;
  double? z = 0.0;

  //pays involved
  List<String> selectedPays = [];
  List<String> selectedPaysId = [];

  //pays involved at that time
  List<String> selectedATT = [];
  List<String> selectedATTId = [];

  //Org involved
  List<String> selectedOrg = [];
  List<String> selectedOrgId = [];

  //who
  List<String> selectedWho = [];
  List<String> selectedWhoId = [];

  //terms
  List<String> selectedTerm = [];
  List<String> selectedTermId = [];

  //categories
  List<String> selectedCategory = [];
  List<String> selectedCategoryId = [];

  final int confirmId = 0;

}
