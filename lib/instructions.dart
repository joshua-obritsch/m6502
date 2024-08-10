part of 'cpu.dart';

mixin Instructions implements Registers, Flags, Memory {
  /// Executes the ADC instruction.
  void _adc((int, int) operands) {
    final (address, byteLength) = operands;

    final augend = a;
    final addend = memory[address];
    final sum = augend + addend;

    _c = sum;
    _z = sum;
    _v = (augend, addend, sum);
    _n = sum;

    a = sum;

    pc += byteLength;
  }

  /// Executes the AND instruction.
  void _and((int, int) operands) {
    final (address, byteLength) = operands;

    final result = a & memory[address];

    _z = result;
    _n = result;

    a = result;

    pc += byteLength;
  }

  /// Executes the ASL instruction on memory.
  void _asl((int, int) operands) {
    final (address, byteLength) = operands;

    final result = memory[address] << 1;

    _c = result;
    _z = result;
    _n = result;

    memory[address] = result;

    pc += byteLength;
  }

  /// Executes the ASL instruction on the accumulator.
  void _aslAccumulator() {
    final result = a << 1;

    _c = result;
    _z = result;
    _n = result;

    a = result;
  }

  /// Executes the BIT instruction.
  void _bit((int, int) operands) {
    final (address, byteLength) = operands;

    final operand = memory[address];

    _z = a & operand;
    v = operand & 0x40 == 0x40;
    n = operand & 0x80 == 0x80;

    pc += byteLength;
  }

  /// Executes a branch instruction (BCC, BCS, BEQ, BMI, BNE, BPL, BVC, BVS).
  void _branch(bool condition) {
    final (address, byteLength) = _relative;

    pc = (condition ? address : pc) + byteLength;
  }

  /// Executes the BRK instruction.
  void _brk() {
    pc++;
    b = true;
    memory[0x0100 + s] = pch;
    s--;
    memory[0x0100 + s] = pcl;
    s--;
    memory[0x0100 + s] = p;
    s--;
    pc = memory.getUint16(0xFFFC, Endian.little);
  }

  /// Executes the CMP instruction.
  void _cmp((int, int) operands) {
    final (address, byteLength) = operands;

    final minuend = a;
    final subtrahend = memory[address];
    final difference = minuend - subtrahend;

    _c = difference;
    _z = difference;
    _n = difference;

    pc += byteLength;
  }

  /// Executes the CPX instruction.
  void _cpx((int, int) operands) {
    final (address, byteLength) = operands;

    final minuend = x;
    final subtrahend = memory[address];
    final difference = minuend - subtrahend;

    _c = difference;
    _z = difference;
    _n = difference;

    pc += byteLength;
  }

  /// Executes the CPY instruction.
  void _cpy((int, int) operands) {
    final (address, byteLength) = operands;

    final minuend = y;
    final subtrahend = memory[address];
    final difference = minuend - subtrahend;

    _c = difference;
    _z = difference;
    _n = difference;

    pc += byteLength;
  }

  /// Executes the DEC instruction.
  void _dec((int, int) operands) {
    final (address, byteLength) = operands;

    final difference = memory[address] - 1;

    _c = difference;
    _z = difference;
    _n = difference;

    memory[address] = difference;

    pc += byteLength;
  }
}
