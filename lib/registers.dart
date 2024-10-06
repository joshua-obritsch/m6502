import 'dart:typed_data';

mixin Registers {
  /// Represents the 8-bit instruction register (IR).
  final ByteData _ir = ByteData(1);

  /// Represents the 8-bit accumulator register (A).
  final ByteData _a = ByteData(1);

  /// Represents the 8-bit index register (X).
  final ByteData _x = ByteData(1);

  /// Represents the 8-bit index register (Y).
  final ByteData _y = ByteData(1);

  /// Represents the 8-bit processor status register (P).
  final ByteData _p = ByteData(1)..setUint8(0, 0x20);

  /// Represents the 16-bit program counter register (PC).
  final ByteData _pc = ByteData(2);

  /// Represents the 8-bit stack pointer register (S).
  final ByteData _s = ByteData(1);

  // Getters

  /// Gets the instruction register (IR).
  int get ir => _ir.getUint8(0);

  /// Gets the accumulator register (A).
  int get a => _a.getUint8(0);

  /// Gets the index register (X).
  int get x => _x.getUint8(0);

  /// Gets the index register (Y).
  int get y => _y.getUint8(0);

  /// Gets the processor status register (P).
  int get p => _p.getUint8(0);

  /// Gets the program counter register (PC).
  int get pc => _pc.getUint16(0);

  /// Gets the high byte of the program counter register (PCH).
  int get pch => _pc.getUint8(0);

  /// Gets the low byte of the program counter register (PCL).
  int get pcl => _pc.getUint8(1);

  /// Gets the stack pointer register (S).
  int get s => _s.getUint8(0);

  // Setters

  /// Sets the instruction register (IR).
  set ir(int value) => _ir.setUint8(0, value);

  /// Sets the accumulator register (A).
  set a(int value) => _a.setUint8(0, value);

  /// Sets the index register (X).
  set x(int value) => _x.setUint8(0, value);

  /// Sets the index register (Y).
  set y(int value) => _y.setUint8(0, value);

  /// Sets the processor status register (P).
  set p(int value) => _p.setUint8(0, value);

  /// Sets the program counter register (PC).
  set pc(int value) => _pc.setUint16(0, value);

  /// Sets the high byte of the program counter register (PCH).
  set pch(int value) => _pc.setUint8(0, value);

  /// Sets the low byte of the program counter register (PCL).
  set pcl(int value) => _pc.setUint8(1, value);

  /// Sets the stack pointer register (S).
  set s(int value) => _s.setUint8(0, value);
}
