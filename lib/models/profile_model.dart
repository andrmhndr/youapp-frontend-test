import 'package:equatable/equatable.dart';
import 'package:youapp_test/helper/api_helper.dart';
import 'package:youapp_test/helper/converter_helper.dart';

enum Gender { male, female }

enum Zodiac {
  capricorn,
  aquarius,
  pisces,
  aries,
  taurus,
  gemini,
  cancer,
  leo,
  virgo,
  libra,
  scorpio,
  sagittarius
}

class Profile extends Equatable {
  final String? username;
  final String? image;
  final Gender? gender;
  final DateTime? birthday;
  final int? height;
  final int? weight;
  final List<String>? interests;

  factory Profile.empty() {
    return const Profile(
      username: null,
      image: null,
      gender: null,
      birthday: null,
      height: null,
      weight: null,
      interests: [],
    );
  }

  String get horoscope {
    if (birthday != null) {
      var days = birthday!.day;
      var months = birthday!.month;
      if (months == 1) {
        if (days >= 21) {
          return "Aquarius";
        } else {
          return "Capricorn";
        }
      } else if (months == 2) {
        if (days >= 20) {
          return "Picis";
        } else {
          return "Aquarius";
        }
      } else if (months == 3) {
        if (days >= 21) {
          return "Aries";
        } else {
          return "Pisces";
        }
      } else if (months == 4) {
        if (days >= 21) {
          return "Taurus";
        } else {
          return "Aries";
        }
      } else if (months == 5) {
        if (days >= 22) {
          return "Gemini";
        } else {
          return "Taurus";
        }
      } else if (months == 6) {
        if (days >= 22) {
          return "Cancer";
        } else {
          return "Gemini";
        }
      } else if (months == 7) {
        if (days >= 23) {
          return "Leo";
        } else {
          return "Cancer";
        }
      } else if (months == 8) {
        if (days >= 23) {
          return "Virgo";
        } else {
          return "Leo";
        }
      } else if (months == 9) {
        if (days >= 24) {
          return "Libra";
        } else {
          return "Virgo";
        }
      } else if (months == 10) {
        if (days >= 24) {
          return "Scorpio";
        } else {
          return "Libra";
        }
      } else if (months == 11) {
        if (days >= 23) {
          return "Sagittarius";
        } else {
          return "Scorpio";
        }
      } else {
        if (days >= 22) {
          return "Capricorn";
        } else {
          return "Sagittarius";
        }
      }
    } else {
      return '-';
    }
  }

  String get zodiac {
    if (birthday != null) {
      var days = birthday!.day;
      var months = birthday!.month;
      if (months == 1) {
        if (days >= 21) {
          return "Aquarius";
        } else {
          return "Capricorn";
        }
      } else if (months == 2) {
        if (days >= 20) {
          return "Picis";
        } else {
          return "Aquarius";
        }
      } else if (months == 3) {
        if (days >= 21) {
          return "Aries";
        } else {
          return "Pisces";
        }
      } else if (months == 4) {
        if (days >= 21) {
          return "Taurus";
        } else {
          return "Aries";
        }
      } else if (months == 5) {
        if (days >= 22) {
          return "Gemini";
        } else {
          return "Taurus";
        }
      } else if (months == 6) {
        if (days >= 22) {
          return "Cancer";
        } else {
          return "Gemini";
        }
      } else if (months == 7) {
        if (days >= 23) {
          return "Leo";
        } else {
          return "Cancer";
        }
      } else if (months == 8) {
        if (days >= 23) {
          return "Virgo";
        } else {
          return "Leo";
        }
      } else if (months == 9) {
        if (days >= 24) {
          return "Libra";
        } else {
          return "Virgo";
        }
      } else if (months == 10) {
        if (days >= 24) {
          return "Scorpio";
        } else {
          return "Libra";
        }
      } else if (months == 11) {
        if (days >= 23) {
          return "Sagittarius";
        } else {
          return "Scorpio";
        }
      } else {
        if (days >= 22) {
          return "Capricorn";
        } else {
          return "Sagittarius";
        }
      }
    } else {
      return '-';
    }
  }

  factory Profile.fromJson(json) {
    return Profile(
      username: json[ApiHelper.username],
      image: json[ApiHelper.image],
      gender: json[ApiHelper.gender] == null
          ? null
          : Gender.values.firstWhere((element) {
              return element.name.toString() == json[ApiHelper.gender];
            }),
      birthday: json[ApiHelper.birthday] == null
          ? null
          : ConverterHelper.dateFromJson(json[ApiHelper.birthday]),
      height: json[ApiHelper.height],
      weight: json[ApiHelper.weight],
      interests: json[ApiHelper.interests] == null
          ? []
          : (json[ApiHelper.interests] as List)
              .map((data) => data.toString())
              .toList(),
    );
  }

  toJson() {
    return ({
      ApiHelper.username: username,
      ApiHelper.image: '$image',
      ApiHelper.gender: gender == null ? null : gender!.name.toString(),
      ApiHelper.birthday: birthday == null ? null : birthday!.toIso8601String(),
      ApiHelper.height: height.toString(),
      ApiHelper.weight: weight.toString(),
      ApiHelper.interests: interests,
    });
  }

  const Profile({
    this.username,
    this.image,
    this.gender,
    this.birthday,
    this.height,
    this.weight,
    this.interests,
  });

  @override
  List<Object?> get props => [
        username,
        image,
        gender,
        birthday,
        height,
        weight,
        interests,
      ];

  Profile copyWith({
    String? username,
    String? image,
    Gender? gender,
    DateTime? birthday,
    int? height,
    int? weight,
    List<String>? interests,
  }) {
    return Profile(
      username: username ?? this.username,
      image: image ?? this.image,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      interests: interests ?? this.interests,
    );
  }
}
