
class DropDownController {

  late String? _value;
  late int indexValue;
  late DropItems items;

  DropDownController({DropItems? items, String? value}){
    this.value = value;
    this.items = items ?? DropItems([]);
  }

  String? get value => _value;

  set value(String? value) {
    _value = value;
    if(value != null) {
      for (var i = 0; i < items.transform.length; i++) {
        final item = items.transform[i];
        if(item['key'] == value) {
          indexValue = i;
          i = items.transform.length;
        }
      }
    }
  }
}

class DropItems {

  List<dynamic> items;
  String? keyInput;
  String? valueInput;

  DropItems(this.items, {this.keyInput, this.valueInput});

  List<Map<String, String>> get transform {
    return this.items.map((e) => {
      "key": '${keyInput == null ? e : e[keyInput]}',
      "value": '${valueInput == null ? e : e[valueInput]}',
    }).toList();
  }
  
}