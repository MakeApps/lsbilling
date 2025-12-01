import 'package:flutter/material.dart';
import 'custom_progress_indicator.dart';

class CenterLoader extends StatelessWidget {
  static OverlayEntry? _currentLoader;
  static OverlayState? _overlayState;
  static bool _insertScheduled = false;

  const CenterLoader({Key? key}) : super(key: key);

  static bool get isShowing => _currentLoader != null;

  /// Show loader
  static void show(BuildContext context, {Color? overlayColor}) {
    _overlayState = Overlay.of(context);

    if (_currentLoader != null || _insertScheduled) return;

    _insertScheduled = true;

    _currentLoader = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: overlayColor ?? const Color(0x99ffffff),
              ),
            ),
            const Center(child: CustomProgressIndicator()),
          ],
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentLoader != null && _overlayState != null) {
        try {
          _overlayState!.insert(_currentLoader!);
        } catch (e) {
          debugPrint("CenterLoader insert error: $e");
          _currentLoader = null;
        }
      }
      _insertScheduled = false;
    });
  }

  /// Hide loader
  static void hide() {
    if (_currentLoader != null) {
      try {
        _currentLoader?.remove();
      } catch (e) {
        debugPrint("CenterLoader hide error: $e");
      } finally {
        _currentLoader = null;
        _insertScheduled = false;
      }
    }
  }

  /// Cancel pending insert if navigation happens before insert
  static void cancelPending() {
    if (_insertScheduled) {
      _insertScheduled = false;
      _currentLoader = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CustomProgressIndicator();
  }
}
