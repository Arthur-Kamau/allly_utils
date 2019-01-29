class GroupInterestModel{
  int id;

  String interestCategory;
  String interestName;

  DateTime createdAt;
  DateTime updatedAt;



GroupInterestModel({
  this.interestCategory,
  this.interestName,
});

}

var dummyData = [
GroupInterestModel(
  interestCategory: "Sport",
  interestName: "Manu"
),
GroupInterestModel(
  interestCategory: "Technology",
  interestName: "Tensorflow"
)
];