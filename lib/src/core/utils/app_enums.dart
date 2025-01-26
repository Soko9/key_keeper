import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:key_keeper/src/core/utils/utils.dart';

enum PlatformIcon {
  google,
  facebook,
  twitter,
  instagram,
  dropbox,
  apple,
  linkedin,
  discord,
  microsoft,
  pinterest,
  youtube,
  medium,
  yandex,
  slack,
  github,
  upwork,
  spotify,
  payPal,
  figma,
  amazon,
  dribbble,
  masterCard,
  visa,
  airbnb,
  soundCloud,
  playstation,
  yelp,
  xbox,
  uber,
  steam,
  snapChat,
  reddit,
  qq,
  patreon,
  imdb,
  itchio,
  goodReads,
  eBay,
  deezer,
  weChat,
  other;

  static List<PlatformIcon> get sortedValues {
    List<PlatformIcon> list = [
      ...PlatformIcon.values.where((p) => p != PlatformIcon.other)
    ];
    list.sort((prev, next) =>
        prev.name.toLowerCase().compareTo(next.name.toLowerCase()));
    return list..add(PlatformIcon.other);
  }

  String get name => switch (this) {
        PlatformIcon.google => 'Google',
        PlatformIcon.facebook => 'Facebook',
        PlatformIcon.twitter => 'X / Twitter',
        PlatformIcon.instagram => 'Instagram',
        PlatformIcon.dropbox => 'Drop Box',
        PlatformIcon.apple => 'Apple',
        PlatformIcon.linkedin => 'LinkedIn',
        PlatformIcon.discord => 'Discord',
        PlatformIcon.microsoft => 'Microsoft',
        PlatformIcon.pinterest => 'Pinterest',
        PlatformIcon.youtube => 'Youtube',
        PlatformIcon.medium => 'Medium',
        PlatformIcon.yandex => 'Yandex',
        PlatformIcon.slack => 'Slack',
        PlatformIcon.github => 'Github',
        PlatformIcon.other => 'Other',
        PlatformIcon.upwork => 'Upwork',
        PlatformIcon.spotify => 'Spotify',
        PlatformIcon.payPal => 'PayPal',
        PlatformIcon.figma => 'Figma',
        PlatformIcon.amazon => 'Amazon',
        PlatformIcon.dribbble => 'Dribbble',
        PlatformIcon.masterCard => 'Master Card',
        PlatformIcon.visa => 'Visa',
        PlatformIcon.airbnb => 'AirBnB',
        PlatformIcon.soundCloud => 'Sound Cloud',
        PlatformIcon.playstation => 'Playstation',
        PlatformIcon.yelp => 'Yelp',
        PlatformIcon.xbox => 'Xbox',
        PlatformIcon.uber => 'Uber',
        PlatformIcon.steam => 'Steam',
        PlatformIcon.snapChat => 'Snapchat',
        PlatformIcon.reddit => 'Reddit',
        PlatformIcon.qq => 'QQ',
        PlatformIcon.patreon => 'Patreon',
        PlatformIcon.imdb => 'IMDB',
        PlatformIcon.itchio => 'Itch.io',
        PlatformIcon.goodReads => 'Goodreads',
        PlatformIcon.eBay => 'eBay',
        PlatformIcon.deezer => 'Deezer',
        PlatformIcon.weChat => 'WeChat',
      };

  IconData get icon => switch (this) {
        PlatformIcon.google => FontAwesomeIcons.google,
        PlatformIcon.facebook => FontAwesomeIcons.facebookF,
        PlatformIcon.twitter => FontAwesomeIcons.xTwitter,
        PlatformIcon.instagram => FontAwesomeIcons.instagram,
        PlatformIcon.dropbox => FontAwesomeIcons.dropbox,
        PlatformIcon.apple => FontAwesomeIcons.apple,
        PlatformIcon.linkedin => FontAwesomeIcons.linkedinIn,
        PlatformIcon.discord => FontAwesomeIcons.discord,
        PlatformIcon.microsoft => FontAwesomeIcons.microsoft,
        PlatformIcon.pinterest => FontAwesomeIcons.pinterest,
        PlatformIcon.youtube => FontAwesomeIcons.youtube,
        PlatformIcon.medium => FontAwesomeIcons.medium,
        PlatformIcon.yandex => FontAwesomeIcons.yandex,
        PlatformIcon.slack => FontAwesomeIcons.slack,
        PlatformIcon.github => FontAwesomeIcons.github,
        PlatformIcon.other => FontAwesomeIcons.cube,
        PlatformIcon.upwork => FontAwesomeIcons.upwork,
        PlatformIcon.spotify => FontAwesomeIcons.spotify,
        PlatformIcon.payPal => FontAwesomeIcons.paypal,
        PlatformIcon.figma => FontAwesomeIcons.figma,
        PlatformIcon.amazon => FontAwesomeIcons.amazon,
        PlatformIcon.dribbble => FontAwesomeIcons.dribbble,
        PlatformIcon.masterCard => FontAwesomeIcons.ccMastercard,
        PlatformIcon.visa => FontAwesomeIcons.ccVisa,
        PlatformIcon.airbnb => FontAwesomeIcons.airbnb,
        PlatformIcon.soundCloud => FontAwesomeIcons.soundcloud,
        PlatformIcon.playstation => FontAwesomeIcons.playstation,
        PlatformIcon.yelp => FontAwesomeIcons.yelp,
        PlatformIcon.xbox => FontAwesomeIcons.xbox,
        PlatformIcon.uber => FontAwesomeIcons.uber,
        PlatformIcon.steam => FontAwesomeIcons.steam,
        PlatformIcon.snapChat => FontAwesomeIcons.snapchat,
        PlatformIcon.reddit => FontAwesomeIcons.reddit,
        PlatformIcon.qq => FontAwesomeIcons.qq,
        PlatformIcon.patreon => FontAwesomeIcons.patreon,
        PlatformIcon.imdb => FontAwesomeIcons.imdb,
        PlatformIcon.itchio => FontAwesomeIcons.itchIo,
        PlatformIcon.goodReads => FontAwesomeIcons.goodreads,
        PlatformIcon.eBay => FontAwesomeIcons.ebay,
        PlatformIcon.deezer => FontAwesomeIcons.deezer,
        PlatformIcon.weChat => FontAwesomeIcons.weixin,
      };

  static PlatformIcon getIcon(String platform) => PlatformIcon.values
      .singleWhere((p) => p.name.toLowerCase() == platform.toLowerCase(),
          orElse: () => PlatformIcon.other);
}

enum DeadlineDuration {
  thirty,
  sixty,
  ninety;

  int get duration => switch (this) {
        DeadlineDuration.thirty => 30,
        DeadlineDuration.sixty => 60,
        DeadlineDuration.ninety => 90,
      };

  static DeadlineDuration getDuration(int duration) =>
      DeadlineDuration.values.singleWhere((d) => d.duration == duration,
          orElse: () => DeadlineDuration.ninety);
}

enum AuthFactorQuestion {
  nickname,
  sport,
  movie,
  book,
  birth;

  String get question => switch (this) {
        AuthFactorQuestion.nickname => 'What was your childhood nickname?',
        AuthFactorQuestion.sport => 'What is your favorite soccer team?',
        AuthFactorQuestion.movie => 'How was your favorite movie character?',
        AuthFactorQuestion.book => 'What is the title of your favorite book?',
        AuthFactorQuestion.birth => 'What city were you born in?',
      };
}

enum EDrawerMenuItem {
  passwords,
  genaratePasswords,
  notes,
  settings,
  terms,
  logout;

  String get title => switch (this) {
        EDrawerMenuItem.passwords => 'Passwords',
        EDrawerMenuItem.genaratePasswords => 'Generate Password',
        EDrawerMenuItem.notes => 'Notes',
        EDrawerMenuItem.settings => 'Settings',
        EDrawerMenuItem.terms => 'Terms & Conditions',
        EDrawerMenuItem.logout => 'Logout',
      };

  IconData get icon => switch (this) {
        EDrawerMenuItem.passwords => FontAwesomeIcons.lock,
        EDrawerMenuItem.genaratePasswords => FontAwesomeIcons.arrowsRotate,
        EDrawerMenuItem.notes => FontAwesomeIcons.solidNoteSticky,
        EDrawerMenuItem.settings => FontAwesomeIcons.sliders,
        EDrawerMenuItem.terms => FontAwesomeIcons.solidCircleQuestion,
        EDrawerMenuItem.logout => FontAwesomeIcons.rightFromBracket,
      };
}

enum PasswordElement {
  lowerCase,
  upperCase,
  digits,
  symbols;

  String get name => switch (this) {
        PasswordElement.lowerCase => 'Lower Case',
        PasswordElement.upperCase => 'Upper Case',
        PasswordElement.digits => 'Digits',
        PasswordElement.symbols => 'Special Characters',
      };
}

enum PasswordStrength {
  weak,
  fair,
  good,
  strong;

  IconData get icon => switch (this) {
        PasswordStrength.weak => FontAwesomeIcons.x,
        PasswordStrength.fair => FontAwesomeIcons.unlockKeyhole,
        PasswordStrength.good => FontAwesomeIcons.check,
        PasswordStrength.strong => FontAwesomeIcons.shield,
      };

  String get label => switch (this) {
        PasswordStrength.weak => 'Weak',
        PasswordStrength.fair => 'Fair',
        PasswordStrength.good => 'Good',
        PasswordStrength.strong => 'Strong',
      };

  Color get color => switch (this) {
        PasswordStrength.weak => AppColors.weakColor,
        PasswordStrength.fair => AppColors.fairColor,
        PasswordStrength.good => AppColors.goodColor,
        PasswordStrength.strong => AppColors.strongColor,
      };

  static PasswordStrength strength(String value) {
    final st = PasswordHelper.validateStrength(value);
    if (st < 0.2) {
      return PasswordStrength.weak;
    } else if (st < 0.5) {
      return PasswordStrength.fair;
    } else if (st < 0.9) {
      return PasswordStrength.good;
    } else {
      return PasswordStrength.strong;
    }
  }
}
