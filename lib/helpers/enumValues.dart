
class EnumValues<T> {
  
    Map<dynamic, EnumValue> map;
    Map<T, dynamic>? reverseMap;
    Map<T, dynamic>? nameMap;

    EnumValues(this.map);

    Map<T, dynamic> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v.value, k));
        }
        return reverseMap!;
    }

    List<dynamic> get toList{
      return map.entries.map( (entry) => {"key": entry.key, "value": entry.value.name}).toList();
    }

    String reverseName(T value) {
      return map.entries.firstWhere((entry) => entry.value.value == value).value.name;
    }
}

class EnumValue {
  final dynamic value;
  final String name;
  EnumValue(this.value, this.name);
}