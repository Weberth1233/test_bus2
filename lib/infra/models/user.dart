// Este 'part' é obrigatório para o Hive gerar o adapter
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0) // O tipo principal
class User extends HiveObject {
  @HiveField(0)
  final String gender;
  @HiveField(1)
  final Name name;
  @HiveField(2)
  final Location location;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final Login login;
  @HiveField(5)
  final Dob dob;
  @HiveField(6)
  final Registered registered;
  @HiveField(7)
  final String phone;
  @HiveField(8)
  final String cell;
  @HiveField(9)
  final UserId id;
  @HiveField(10)
  final Picture picture;
  @HiveField(11)
  final String nat;

  // Propriedade "computed" para fácil acesso ao UUID
  // que será usado como chave no Hive.
  String get uuid => login.uuid;

  User({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      gender: json['gender'] ?? '',
      name: Name.fromJson(json['name'] ?? {}),
      location: Location.fromJson(json['location'] ?? {}),
      email: json['email'] ?? '',
      login: Login.fromJson(json['login'] ?? {}),
      dob: Dob.fromJson(json['dob'] ?? {}),
      registered: Registered.fromJson(json['registered'] ?? {}),
      phone: json['phone'] ?? '',
      cell: json['cell'] ?? '',
      id: UserId.fromJson(json['id'] ?? {}),
      picture: Picture.fromJson(json['picture'] ?? {}),
      nat: json['nat'] ?? '',
    );
  }
}

@HiveType(typeId: 1)
class Name {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String first;
  @HiveField(2)
  final String last;

  // Propriedade "computed" para nome completo
  String get fullName => '$first $last';

  Name({required this.title, required this.first, required this.last});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'] ?? '',
      first: json['first'] ?? '',
      last: json['last'] ?? '',
    );
  }
}

@HiveType(typeId: 2)
class Location {
  @HiveField(0)
  final Street street;
  @HiveField(1)
  final String city;
  @HiveField(2)
  final String state;
  @HiveField(3)
  final String country;
  @HiveField(4)
  final String postcode;
  @HiveField(5)
  final Coordinates coordinates;
  @HiveField(6)
  final Timezone timezone;

  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: Street.fromJson(json['street'] ?? {}),
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      // Postcode às vezes é int, às vezes string. Converter para String garante.
      postcode: json['postcode']?.toString() ?? '',
      coordinates: Coordinates.fromJson(json['coordinates'] ?? {}),
      timezone: Timezone.fromJson(json['timezone'] ?? {}),
    );
  }
}

@HiveType(typeId: 3)
class Street {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String name;

  Street({required this.number, required this.name});

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(number: json['number'] ?? 0, name: json['name'] ?? '');
  }
}

@HiveType(typeId: 4)
class Coordinates {
  @HiveField(0)
  final String latitude;
  @HiveField(1)
  final String longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }
}

@HiveType(typeId: 5)
class Timezone {
  @HiveField(0)
  final String offset;
  @HiveField(1)
  final String description;

  Timezone({required this.offset, required this.description});

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      offset: json['offset'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

@HiveType(typeId: 6)
class Login {
  @HiveField(0)
  final String uuid;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String salt;
  @HiveField(4)
  final String md5;
  @HiveField(5)
  final String sha1;
  @HiveField(6)
  final String sha256;

  Login({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      uuid: json['uuid'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      salt: json['salt'] ?? '',
      md5: json['md5'] ?? '',
      sha1: json['sha1'] ?? '',
      sha256: json['sha256'] ?? '',
    );
  }
}

@HiveType(typeId: 7)
class Dob {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final int age;

  Dob({required this.date, required this.age});

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(date: json['date'] ?? '', age: json['age'] ?? 0);
  }
}

@HiveType(typeId: 8)
class Registered {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final int age;

  Registered({required this.date, required this.age});

  factory Registered.fromJson(Map<String, dynamic> json) {
    return Registered(date: json['date'] ?? '', age: json['age'] ?? 0);
  }
}

@HiveType(typeId: 9)
class UserId {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String value;

  UserId({required this.name, required this.value});

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(name: json['name'] ?? '', value: json['value'] ?? '');
  }
}

@HiveType(typeId: 10)
class Picture {
  @HiveField(0)
  final String large;
  @HiveField(1)
  final String medium;
  @HiveField(2)
  final String thumbnail;

  Picture({required this.large, required this.medium, required this.thumbnail});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'] ?? '',
      medium: json['medium'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}
