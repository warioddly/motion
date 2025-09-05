import 'dart:async';
import 'package:flutter/material.dart';

final class PreviewOverlay<T> {

  Timer? _timer;
  OverlayEntry? _overlayEntry;
  bool _isVisible = false;

  // void update(BuildContext context, T data) {
  //   // show(context);
  //   this.data = data;
  //   _marksNeedsBuild();
  // }

  void show(BuildContext context, Widget child) {
    // _timer?.cancel();
    // _timer = Timer(Duration(milliseconds: 2000), hide);
    //
    // if (_isVisible) return;
    // _isVisible = true;

    _createOverlay(context, child);
  }

  void hide() {
    if (!_isVisible) return;
    _isVisible = false;
    _overlayEntry?.remove();
  }

  void _createOverlay(BuildContext context, Widget child) {
    _overlayEntry = OverlayEntry(builder: (_) => child);
    if (_overlayEntry == null) return;
    Overlay.of(context).insert(_overlayEntry!);
  }

  // void _marksNeedsBuild() {
  //   _overlayEntry?.markNeedsBuild();
  // }

  void dispose() {
    try {
      _isVisible = false;
      _timer?.cancel();
      _timer = null;
      if (_overlayEntry != null) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    } catch (_) {}

  }
}