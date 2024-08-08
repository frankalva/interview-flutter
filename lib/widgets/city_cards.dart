import 'package:flutter/material.dart';
import '../models/city.dart';

class CityCard extends StatelessWidget {
  final City city;

  const CityCard({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Funcion para extraer la hora y ver si esta en PM o AM
    String extractTime(String dateTime) {
      try {
        final timePart = dateTime.split('T')[1];  // Separar la parte de la hora
        final time = timePart.split(':');
        final hourMinute = '${time[0]}:${time[1]}';
        final amPm = int.parse(time[0]) >= 12 ? 'PM' : 'AM';
        return '$hourMinute $amPm';
      } catch (e) {
        return 'N/A';
      }
    }
    //Widget Card
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.transparent,
      margin: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city.localizedName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    city.description ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            color: Colors.black,
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  city.weatherIcon != null
                      ? Image.network(
                          'https://developer.accuweather.com/sites/default/files/${city.weatherIcon!.toString().padLeft(2, '0')}-s.png',
                          width: 70,
                          height: 70,
                        )
                      : const SizedBox.shrink(),
                  Text(
                    city.localObservationDateTime != null
                        ? extractTime(city.localObservationDateTime!)
                        : 'N/A',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}