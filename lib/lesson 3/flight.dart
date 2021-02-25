class Flight {
  int _number;
  String _departureFrom;
  String _arrivalTo;
  DateTime _departureDate;
  FlightStatus _status;

  int get number => _number;

  String get departureFrom => _departureFrom;

  String get arrivalTo => _arrivalTo;

  DateTime get departureDate => _departureDate;

  FlightStatus get status => _status;

  set number(int number) {
    _number = number;
  }

  set departureFrom(String departureFrom) {
    _departureFrom = departureFrom;
  }

  set arrivalTo(String arrivalTo) {
    _arrivalTo = arrivalTo;
  }

  set departureDate(DateTime departureDate) {
    _departureDate = departureDate;
  }

  set status(FlightStatus status) {
    _status = status;
  }

  Flight(this._number, this._departureFrom, this._arrivalTo, this._departureDate, this._status);

  Flight.now(this._number, this._departureFrom, this._arrivalTo, this._status) {
    this._departureDate = DateTime.now();
  }
}

enum FlightStatus { boarding, takeoff, landing }

extension FlightStatusString on FlightStatus {
  String getString() {
    switch (this) {
      case FlightStatus.boarding:
        return 'Посадка людей на борт';
      case FlightStatus.takeoff:
        return 'Взлет';
      case FlightStatus.landing:
        return 'Посадка';
      default:
        return 'Статус рейса неизвестен';
    }
  }
}
