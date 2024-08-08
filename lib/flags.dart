part of 'cpu.dart';

mixin Flags implements Registers {
  /// Gets the carry (C) processor status flag (bit 0).
  bool get c => p & 0x01 == 0x01;

  /// Gets the zero (Z) processor status flag (bit 1).
  bool get z => p & 0x02 == 0x02;

  /// Gets the interrupt disable (I) processor status flag (bit 2).
  bool get i => p & 0x04 == 0x04;

  /// Gets the decimal mode (D) processor status flag (bit 3).
  bool get d => p & 0x08 == 0x08;

  /// Gets the break (B) processor status flag (bit 4).
  bool get b => p & 0x10 == 0x10;

  /// Gets the overflow (V) processor status flag (bit 6).
  bool get v => p & 0x40 == 0x40;

  /// Gets the negative (N) processor status flag (bit 7).
  bool get n => p & 0x80 == 0x80;

  /// Sets the carry (C) processor status flag (bit 0).
  set c(bool value) => p = p & 0xFE | (value ? 0x01 : 0x00);

  /// Sets the zero (Z) processor status flag (bit 1).
  set z(bool value) => p = p & 0xFD | (value ? 0x02 : 0x00);

  /// Sets the interrupt disable (I) processor status flag (bit 2).
  set i(bool value) => p = p & 0xFB | (value ? 0x04 : 0x00);

  /// Sets the decimal mode (D) processor status flag (bit 3).
  set d(bool value) => p = p & 0xF7 | (value ? 0x08 : 0x00);

  /// Sets the break (B) processor status flag (bit 4).
  set b(bool value) => p = p & 0xEF | (value ? 0x10 : 0x00);

  /// Sets the overflow (V) processor status flag (bit 6).
  set v(bool value) => p = p & 0xBF | (value ? 0x40 : 0x00);

  /// Sets the negative (N) processor status flag (bit 7).
  set n(bool value) => p = p & 0x7F | (value ? 0x80 : 0x00);

  /// Sets the carry (C) processor status flag (bit 0) arithmetically.
  set _c(int value) => c = value > 0xFF;

  /// Sets the zero (Z) processor status flag (bit 1) arithmetically.
  set _z(int value) => z = value & 0xFF == 0;

  /// Sets the overflow (V) processor status flag (bit 6) arithmetically.
  set _v((int, int, int) value) =>
      v = (value.$1 ^ value.$3) & (value.$2 ^ value.$3) & 0x80 == 0x80;

  /// Sets the negative (N) processor status flag (bit 7) arithmetically.
  set _n(int value) => n = value & 0x80 == 0x80;
}
