import 'dart:async';

import 'package:flutter/material.dart';

class TimerOverlay {
  const TimerOverlay._();

  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static BuildContext? get context => key.currentContext;

  static OverlayEntry? _entry;
  static Timer? _auto;

  static void showTimerFinishedNotice() {
    final overlay = key.currentState?.overlay;
    if (overlay == null) return;

    void remove() {
      _auto?.cancel();
      _auto = null;
      _entry?.remove();
      _entry = null;
    }

    remove();

    _entry = OverlayEntry(
      builder: (context) {
        final topPadding = MediaQuery.of(overlay.context).padding.top;

        return Positioned(
          top: topPadding + 12,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Dismissible(
              key: const ValueKey('timer_finished_notice'),
              direction: DismissDirection.up,
              onDismissed: (_) => remove(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Timer finished!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_entry!);
    _auto = Timer(const Duration(seconds: 5), remove);
  }
}
