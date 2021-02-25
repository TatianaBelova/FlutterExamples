import 'package:flutter/material.dart';
import 'package:my_flutter_note/lesson%203/flight.dart';

class FlightsWidget extends StatelessWidget {
  String textFieldValue;
  final flights = List.generate(
      5,
      (index) =>
          Flight.now(index + 1, 'Ульяновск', 'Москва', FlightStatus.boarding));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(onChanged: setTextFieldValue),
          _getFlights(),
          Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: flights[0].status == FlightStatus.boarding
                  ? Text(
                      'Пожалуйста, пройдите на борт пассажиры рейса ${flights[0].number}')
                  : Container()),
        ],
      ),
    );
  }

  void setTextFieldValue(String value) {
    textFieldValue = value;
    print(textFieldValue);
  }

  ListView _getFlights() {
    flights.last.status = FlightStatus.takeoff;
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          FlightWidget(flights: flights, index: index),
      itemCount: 5,
    );
  }
}

class FlightWidget extends StatelessWidget {
  List<Flight> flights;
  int index;

  FlightWidget({this.flights, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Из ${flights[index].departureFrom} в ${flights[index].arrivalTo}'),
          Text('Статус: ${flights[index].status.getString()}')
        ],
      ),
    );
  }
}
