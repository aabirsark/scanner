/// Going to return the time formate, i.e `27/01/2022`,
/// with the help of datetime
String formDateFromDateTime({required DateTime time}) =>
    "${time.day}/${time.month}/${time.year}";
