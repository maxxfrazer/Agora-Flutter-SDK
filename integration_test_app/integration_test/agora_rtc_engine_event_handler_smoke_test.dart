import 'package:agora_rtc_engine/media_recorder.dart';
import 'package:integration_test/integration_test.dart';

import 'dart:io';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'onWarning',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');

      MediaRecorder.getMediaRecorder(rtcEngine,
          callback: MediaRecorderObserver(
            onRecorderStateChanged: (state, error) {},
          ));

      fakeIrisEngine.fireRtcEngineEvent('onRecorderStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      // expect(warningCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );
}
