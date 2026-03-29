abstract class LocaleEvent {}

class ChangeLocaleEvent extends LocaleEvent {
  final String langCode;
  ChangeLocaleEvent(this.langCode);
}