import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_fit_test_signal/data/http_client/http_client.dart';
import 'package:smart_fit_test_signal/data/unities_data_source/unities_data_source.dart';
import 'package:smart_fit_test_signal/data/unities_data_source/unities_web_source.dart';
import 'package:smart_fit_test_signal/domain/entities/unity_entity.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  final HttpClient client = MockHttpClient();
  final UnitiesDataSource dataSource = UnitiesWebSource(client);

  final exampleJson = {
    "current_country_id": 1,
    "locations": [
      {
        "id": 10998878976097,
        "title": "Dom Severino",
        "content":
            "\n<p>Av. Dom Severino, 1733 &#8211; Fátima<br>Teresina, PI</p>\n",
        "opened": true,
        "mask": "required",
        "towel": "required",
        "fountain": "partial",
        "locker_room": "allowed",
        "schedules": [
          {"weekdays": "Seg. à Sex.", "hour": "06h às 22h"},
          {"weekdays": "Sáb.", "hour": "Fechada"},
          {"weekdays": "Dom.", "hour": "Fechada"}
        ]
      },
      {
        "id": 10998878976096,
        "title": "Teresina Shopping",
        "content":
            "\n<p>Av. Raul Lopes, 1000 &#8211; Noivos<br>Teresina, PI</p>\n",
        "opened": true,
        "mask": "required",
        "towel": "required",
        "fountain": "partial",
        "locker_room": "allowed",
        "schedules": [
          {"weekdays": "Seg. à Sex.", "hour": "06h às 22h"},
          {"weekdays": "Sáb.", "hour": "Fechada"},
          {"weekdays": "Dom.", "hour": "Fechada"}
        ]
      },
    ],
  };

  test('Test for success parse', () async {
    when(
      () => client.get(
          'https://test-frontend-developer.s3.amazonaws.com/data/locations.json'),
    ).thenAnswer(
      (_) async => HttpResponse(statusCode: 200, data: exampleJson),
    );
    final result = await dataSource.getUnities();
    expect(
      result,
      const TypeMatcher<List<UnityEntity>>(),
    );
  });
}
