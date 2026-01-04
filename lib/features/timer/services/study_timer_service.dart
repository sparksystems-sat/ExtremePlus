import 'dart:async';

import 'package:exam_practice_app/features/timer/timer_overlay.dart';
import 'package:exam_practice_app/services/local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StudyTimerStatus { idle, running, paused, finished }

class StudyTimerService extends ChangeNotifier {
  StudyTimerService._();

  static final StudyTimerService instance = StudyTimerService._();

  static const _kStatus = 'study_timer_status';
  static const _kEndAtMs = 'study_timer_end_at_ms';
  static const _kPausedRemainingMs = 'study_timer_paused_remaining_ms';
  static const _kLastDurationMs = 'study_timer_last_duration_ms';

  Timer? _ticker;
  SharedPreferences? _prefs;

  StudyTimerStatus _status = StudyTimerStatus.idle;
  DateTime? _endAt;
  Duration _pausedRemaining = Duration.zero;
  Duration _lastDuration = const Duration(minutes: 30);

  StudyTimerStatus get status => _status;
  DateTime? get endAt => _endAt;
  Duration get lastDuration => _lastDuration;

  Duration get remaining {
    switch (_status) {
      case StudyTimerStatus.running:
        final end = _endAt;
        if (end == null) return Duration.zero;
        final diff = end.difference(DateTime.now());
        return diff.isNegative ? Duration.zero : diff;
      case StudyTimerStatus.paused:
        return _pausedRemaining;
      case StudyTimerStatus.finished:
        return Duration.zero;
      case StudyTimerStatus.idle:
        return Duration.zero;
    }
  }

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();

    final statusRaw = _prefs!.getString(_kStatus);
    _status = StudyTimerStatus.values.firstWhere(
      (e) => e.name == statusRaw,
      orElse: () => StudyTimerStatus.idle,
    );

    final endAtMs = _prefs!.getInt(_kEndAtMs);
    _endAt =
        endAtMs == null ? null : DateTime.fromMillisecondsSinceEpoch(endAtMs);

    _pausedRemaining = Duration(
      milliseconds: _prefs!.getInt(_kPausedRemainingMs) ?? 0,
    );

    _lastDuration = Duration(
      milliseconds: _prefs!.getInt(_kLastDurationMs) ?? 30 * 60 * 1000,
    );

    if (_status == StudyTimerStatus.running) {
      final end = _endAt;
      if (end == null) {
        await reset();
      } else if (DateTime.now().isAfter(end)) {
        _status = StudyTimerStatus.finished;
        _endAt = null;
        await _persist();
        await LocalNotifications.cancelTimerFinished();
      } else {
        _startTicker();
      }
    }

    notifyListeners();
  }

  Future<void> start(Duration duration) async {
    await init();

    _lastDuration = duration;
    _pausedRemaining = Duration.zero;
    _status = StudyTimerStatus.running;
    _endAt = DateTime.now().add(duration);

    await _persist();
    await LocalNotifications.cancelTimerFinished();
    await LocalNotifications.scheduleTimerFinished(_endAt!);

    _startTicker();
    notifyListeners();
  }

  Future<void> pause() async {
    if (_status != StudyTimerStatus.running) return;

    final end = _endAt;
    if (end == null) return;

    _pausedRemaining = remaining;
    _endAt = null;
    _status = StudyTimerStatus.paused;

    _stopTicker();
    await _persist();
    await LocalNotifications.cancelTimerFinished();

    notifyListeners();
  }

  Future<void> resume() async {
    if (_status != StudyTimerStatus.paused) return;

    _status = StudyTimerStatus.running;
    _endAt = DateTime.now().add(_pausedRemaining);
    _pausedRemaining = Duration.zero;

    await _persist();
    await LocalNotifications.cancelTimerFinished();
    await LocalNotifications.scheduleTimerFinished(_endAt!);

    _startTicker();
    notifyListeners();
  }

  Future<void> reset({Duration? duration}) async {
    await init();

    _status = StudyTimerStatus.idle;
    _endAt = null;
    _pausedRemaining = Duration.zero;
    _lastDuration = duration ?? Duration.zero;

    _stopTicker();
    await _persist();
    await LocalNotifications.cancelTimerFinished();

    notifyListeners();
  }

  void _startTicker() {
    _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) {
      if (_status != StudyTimerStatus.running) return;

      if (remaining == Duration.zero) {
        _handleFinished();
      } else {
        notifyListeners();
      }
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  Future<void> _handleFinished() async {
    _stopTicker();

    if (_status != StudyTimerStatus.running) return;

    _status = StudyTimerStatus.finished;
    _endAt = null;
    _pausedRemaining = Duration.zero;

    await _persist();

    TimerOverlay.showTimerFinishedNotice();

    notifyListeners();
  }

  Future<void> _persist() async {
    _prefs ??= await SharedPreferences.getInstance();

    await _prefs!.setString(_kStatus, _status.name);
    if (_endAt == null) {
      await _prefs!.remove(_kEndAtMs);
    } else {
      await _prefs!.setInt(_kEndAtMs, _endAt!.millisecondsSinceEpoch);
    }
    await _prefs!.setInt(_kPausedRemainingMs, _pausedRemaining.inMilliseconds);
    await _prefs!.setInt(_kLastDurationMs, _lastDuration.inMilliseconds);
  }
}
