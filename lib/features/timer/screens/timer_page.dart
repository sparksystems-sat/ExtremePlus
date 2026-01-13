import 'package:exam_practice_app/features/timer/services/study_timer_service.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'countdown_progress_bar.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final _service = StudyTimerService.instance;

  late final TextEditingController _hoursController;
  late final TextEditingController _minutesController;
  late final TextEditingController _secondsController;

  Duration _draftDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    _hoursController = TextEditingController();
    _minutesController = TextEditingController();
    _secondsController = TextEditingController();
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  bool _isEmpty(TextEditingController c) => c.text.trim().isEmpty;

  static int _clampInt(int v, int min, int max) {
    if (v < min) return min;
    if (v > max) return max;
    return v;
  }

  int _parseController(TextEditingController c) {
    return int.tryParse(c.text.trim()) ?? 0;
  }

  void _setController(TextEditingController c, int v, {int pad = 2}) {
    c.text = v.toString().padLeft(pad, '0');
  }

  void _setControllerEmpty(
    TextEditingController c,
    int v, {
    required bool keepEmpty,
    int pad = 2,
  }) {
    if (keepEmpty && v == 0) {
      c.text = '';
    } else {
      _setController(c, v, pad: pad);
    }
  }

  void _sanitizeInputs() {
    final hoursEmpty = _isEmpty(_hoursController);
    final minutesEmpty = _isEmpty(_minutesController);
    final secondsEmpty = _isEmpty(_secondsController);

    final h = _clampInt(_parseController(_hoursController), 0, 99);
    final m = _clampInt(_parseController(_minutesController), 0, 59);
    final s = _clampInt(_parseController(_secondsController), 0, 59);

    _setControllerEmpty(_hoursController, h, keepEmpty: hoursEmpty);
    _setControllerEmpty(_minutesController, m, keepEmpty: minutesEmpty);
    _setControllerEmpty(_secondsController, s, keepEmpty: secondsEmpty);

    _draftDuration = Duration(hours: h, minutes: m, seconds: s);
  }

  void _updateDraftDuration() {
    _draftDuration = _parseDuration();
  }

  Duration _parseDuration() {
    final h = _clampInt(_parseController(_hoursController), 0, 99);
    final m = _clampInt(_parseController(_minutesController), 0, 59);
    final s = _clampInt(_parseController(_secondsController), 0, 59);
    return Duration(hours: h, minutes: m, seconds: s);
  }

  String _format(Duration d) {
    final total = d.inSeconds;
    final h = (total ~/ 3600).toString().padLeft(2, '0');
    final m = ((total % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (total % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _timeBox(
    TextEditingController controller,
    String hint, {
    required bool enabled,
    required int max,
  }) {
    return SizedBox(
      width: 64,
      height: 40,
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
        onChanged: (v) {
          if (!enabled) return;
          final parsed = int.tryParse(v) ?? 0;
          if (parsed > max) {
            _setController(controller, max);
          }
          setState(_updateDraftDuration);
        },
        onEditingComplete: () {
          if (!enabled) return;
          setState(_sanitizeInputs);
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
        ),
      ),
    );
  }

  Widget _actionButton(String label, VoidCallback? onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                onPressed == null
                    ? Colors.grey.shade300
                    : AppColors.button3Color,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleReset() async {
    setState(() {
      _hoursController.text = '';
      _minutesController.text = '';
      _secondsController.text = '';
      _draftDuration = Duration.zero;
    });

    await _service.reset();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _service,
      builder: (context, _) {
        final status = _service.status;
        final remaining = _service.remaining;

        final configuring =
            status == StudyTimerStatus.idle ||
            status == StudyTimerStatus.finished;

        final bool hasSetTime =
            configuring
                ? _draftDuration.inSeconds > 0
                : _service.lastDuration.inSeconds > 0;

        final displayDuration =
            configuring && _draftDuration.inSeconds > 0
                ? _draftDuration
                : remaining;

        final totalForProgress =
            (status == StudyTimerStatus.running ||
                    status == StudyTimerStatus.paused)
                ? _service.lastDuration
                : _draftDuration;

        final double progress;
        if (totalForProgress.inSeconds <= 0) {
          progress = 0;
        } else if (configuring) {
          progress = _draftDuration.inSeconds > 0 ? 1.0 : 0.0;
        } else {
          progress = (remaining.inSeconds / totalForProgress.inSeconds).clamp(
            0.0,
            1.0,
          );
        }

        final canStart = configuring;
        final canPause = status == StudyTimerStatus.running;
        final canResume = status == StudyTimerStatus.paused;
        final inputsEnabled = configuring;
        final canReset =
            status == StudyTimerStatus.running ||
            status == StudyTimerStatus.paused ||
            (configuring && _draftDuration.inSeconds > 0);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Study Timer',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 28,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            backgroundColor: AppColors.main_background_color,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade100,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.yellow.shade700, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _format(displayDuration),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _timeBox(
                      _hoursController,
                      'HH',
                      enabled: inputsEnabled,
                      max: 99,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(':', style: TextStyle(fontSize: 18)),
                    ),
                    _timeBox(
                      _minutesController,
                      'MM',
                      enabled: inputsEnabled,
                      max: 59,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(':', style: TextStyle(fontSize: 18)),
                    ),
                    _timeBox(
                      _secondsController,
                      'SS',
                      enabled: inputsEnabled,
                      max: 59,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CountdownProgressBar(
                        progress: progress,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints(maxHeight: 60),
                  child: Row(
                    children: [
                      _actionButton(
                        'Start',
                        (canStart && hasSetTime)
                            ? () async {
                              final d = _parseDuration();
                              if (d.inSeconds <= 0) return;

                              setState(() {
                                _draftDuration = d;
                                _hoursController.text = '';
                                _minutesController.text = '';
                                _secondsController.text = '';
                              });

                              await _service.start(d);

                              if (!mounted) return;
                              setState(() {
                                _draftDuration = Duration.zero;
                              });
                            }
                            : null,
                      ),
                      _actionButton(
                        'Pause',
                        canPause ? () => _service.pause() : null,
                      ),
                      _actionButton(
                        'Resume',
                        canResume ? () => _service.resume() : null,
                      ),
                      _actionButton('Reset', canReset ? _handleReset : null),
                    ],
                  ),
                ),
                if (status == StudyTimerStatus.finished) ...[
                  const SizedBox(height: 28),
                  Container(
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
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
