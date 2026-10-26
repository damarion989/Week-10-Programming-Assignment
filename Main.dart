import 'dart:async';

// Phase 1:  information
Future<String> fetchSensorMetadata() async {
  await Future.delayed(Duration(seconds: 2));

  return 'Sensor ID: 402 | Location: Warehouse-A';
}

// Phase 2:  readings
Stream<double> temperatureStream() async* {
  List<double> temperatures = [22.0, 30.0, 38.0, 41.0, 36.0];

  for (double temperature in temperatures) {
    await Future.delayed(Duration(seconds: 1));
    yield temperature;
  }
}

Future<void> main() async {
  print('Connecting to sensor...');

  String metadata = await fetchSensorMetadata();
  print(metadata);

  // Phase 3: central pipeline
  final controller = StreamController<double>();

 
  controller.stream.listen(
    (reading) {
      if (reading > 35.0) {
        double fahrenheit = reading * 1.8 + 32;

        print(
          'WARNING: $reading°C / ${fahrenheit.toStringAsFixed(1)}°F',
        );
      } else {
        print('Normal temperature: $reading°C');
      }
    },

    // Phase 4:  errors
    onError: (error) {
      print('ALERT: $error');
    },

    onDone: () {
      print('Sensor pipeline closed.');
    },

    cancelOnError: false,
  );

  int count = 0;

  
  await for (double reading in temperatureStream()) {
    count++;

    if (count == 4) {
      controller.addError(
        Exception('Sensor Malfunction: Signal Lost'),
      );
    } else {
      controller.add(reading);
    }
  }

  
  await controller.close();
}
