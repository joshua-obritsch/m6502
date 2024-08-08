part of 'cpu.dart';

mixin Memory implements Registers {
  /// Represents the 16-bit addressable memory.
  final ByteData memory = ByteData(65536);

  /// Gets the operands from memory via absolute addressing.
  (int, int) get _absolute => (memory.getUint16(pc, Endian.little), 2);

  /// Gets the operands from memory via absolute x addressing.
  (int, int) get _absoluteX =>
      ((memory.getUint16(pc, Endian.little) + x) & 0xFFFF, 2);

  /// Gets the operands from memory via absolute y addressing.
  (int, int) get _absoluteY =>
      ((memory.getUint16(pc, Endian.little) + y) & 0xFFFF, 2);

  /// Gets the operands from memory via immediate addressing.
  (int, int) get _immediate => (pc, 1);

  /// Gets the operands from memory via indirect addressing.
  (int, int) get _indirect =>
      (memory.getUint16(memory.getUint16(pc, Endian.little), Endian.little), 2);

  /// Gets the operands from memory via indirect x addressing.
  (int, int) get _indirectX =>
      (memory.getUint16((memory.getUint8(pc) + x) & 0xFF, Endian.little), 1);

  /// Gets the operands from memory via indirect y addressing.
  (int, int) get _indirectY =>
      ((memory.getUint16(memory.getUint8(pc), Endian.little) + y) & 0xFFFF, 1);

  /// Gets the operands from memory via relative addressing.
  (int, int) get _relative => ((memory.getInt8(pc) + pc + 1) & 0xFFFF, 1);

  /// Gets the operands from memory via zero-page addressing.
  (int, int) get _zeroPage => (memory.getUint8(pc), 1);

  /// Gets the operands from memory via zero-page x addressing.
  (int, int) get _zeroPageX => ((memory.getUint8(pc) + x) & 0xFF, 1);

  /// Gets the operands from memory via zero-page y addressing.
  (int, int) get _zeroPageY => ((memory.getUint8(pc) + y) & 0xFF, 1);

  /// Gets the cycle count for page boundary crossing via absolute x addressing.
  int get _absoluteXPageBoundary => memory.getUint8(pc) + x >>> 8;

  /// Gets the cycle count for page boundary crossing via absolute y addressing.
  int get _absoluteYPageBoundary => memory.getUint8(pc) + y >>> 8;

  /// Gets the cycle count for page boundary crossing via indirect y addressing.
  int get _indirectYPageBoundary =>
      memory.getUint8(memory.getUint8(pc)) + y >>> 8;

  int _relativePageBoundary(bool condition) =>
      condition ? (pch == memory.getInt8(pc) + pc + 1 >>> 8 ? 1 : 2) : 0;
}

extension ByteDataExt on ByteData {
  /// Gets the unsigned 8-bit integer located at the given memory position.
  int operator [](int byteOffset) => getUint8(byteOffset);

  /// Sets the unsigned 8-bit integer located at the given memory position.
  void operator []=(int byteOffset, int value) => setUint8(byteOffset, value);
}
