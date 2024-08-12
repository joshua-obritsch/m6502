part of 'cpu.dart';

mixin Instructions implements Registers, Flags, Memory {
  /// Executes the ADC instruction.
  void _adc((int, int) operand) {
    final (address, byteLength) = operand;

    final augend = a;
    final addend = memory[address];
    final sum = augend + addend + (c ? 1 : 0);

    _c = sum;
    _z = sum;
    _v = (augend, addend, sum);
    _n = sum;

    a = sum;

    pc += byteLength;
  }

  /// Executes the AND instruction.
  void _and((int, int) operand) {
    final (address, byteLength) = operand;

    final result = a & memory[address];

    _z = result;
    _n = result;

    a = result;

    pc += byteLength;
  }

  /// Executes the ASL instruction on memory.
  void _asl((int, int) operand) {
    final (address, byteLength) = operand;

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
  void _bit((int, int) operand) {
    final (address, byteLength) = operand;

    final value = memory[address];

    _z = a & value;
    v = value & 0x40 == 0x40;
    n = value & 0x80 == 0x80;

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
    stack[s--] = pch;
    stack[s--] = pcl;
    stack[s--] = p;
    pc = memory.getUint16(0xFFFC, Endian.little);
  }

  /// Executes a compare instruction (CMP, CPX, CPY).
  void _compare(int minuend, (int, int) operand) {
    final (address, byteLength) = operand;

    final subtrahend = memory[address];
    final difference = minuend - subtrahend;

    c = minuend >= subtrahend;
    z = minuend == subtrahend;
    _n = difference;

    pc += byteLength;
  }

  /// Executes the DEC instruction.
  void _dec((int, int) operand) {
    final (address, byteLength) = operand;

    final difference = memory[address] - 1;

    _z = difference;
    _n = difference;

    memory[address] = difference;

    pc += byteLength;
  }

  /// Executes the DEX instruction.
  void _dex() {
    x--;

    _z = x;
    _n = x;
  }

  /// Executes the DEY instruction.
  void _dey() {
    y--;

    _z = y;
    _n = y;
  }

  /// Executes the EOR instruction.
  void _eor((int, int) operand) {
    final (address, byteLength) = operand;

    final result = a ^ memory[address];

    _z = result;
    _n = result;

    a = result;

    pc += byteLength;
  }

  /// Executes the INC instruction.
  void _inc((int, int) operand) {
    final (address, byteLength) = operand;

    final sum = memory[address] + 1;

    _z = sum;
    _n = sum;

    memory[address] = sum;

    pc += byteLength;
  }

  /// Executes the INX instruction.
  void _inx() {
    x++;

    _z = x;
    _n = x;
  }

  /// Executes the INY instruction.
  void _iny() {
    y++;

    _z = y;
    _n = y;
  }

  /// Executes the JMP instruction.
  void _jmp((int, int) operand) {
    final (address, _) = operand;

    pc = memory.getUint16(address, Endian.little);
  }

  /// Executes the JSR instruction.
  void _jsr((int, int) operand) {
    final (address, _) = operand;

    final returnAddress = pc + 1;

    stack[s--] = returnAddress >>> 8;
    stack[s--] = returnAddress & 0xFF;

    pc = address;
  }

  /// Executes the LDA instruction.
  void _lda((int, int) operand) {
    final (address, byteLength) = operand;

    final value = memory[address];

    _z = value;
    _n = value;

    a = value;

    pc += byteLength;
  }

  /// Executes the LDX instruction.
  void _ldx((int, int) operand) {
    final (address, byteLength) = operand;

    final value = memory[address];

    _z = value;
    _n = value;

    x = value;

    pc += byteLength;
  }

  /// Executes the LDY instruction.
  void _ldy((int, int) operand) {
    final (address, byteLength) = operand;

    final value = memory[address];

    _z = value;
    _n = value;

    y = value;

    pc += byteLength;
  }

  /// Executes the LSR instruction on memory.
  void _lsr((int, int) operand) {
    final (address, byteLength) = operand;

    final value = memory[address];
    final result = memory[address] >>> 1;

    c = value & 0x01 == 0x01;
    _z = result;
    n = false;

    memory[address] = result;

    pc += byteLength;
  }

  /// Executes the LSR instruction on the accumulator.
  void _lsrAccumulator() {
    final result = a >>> 1;

    c = a & 0x01 == 0x01;
    _z = result;
    n = false;

    a = result;
  }

  /// Executes the ORA instruction.
  void _ora((int, int) operand) {
    final (address, byteLength) = operand;

    final result = a | memory[address];

    _z = result;
    _n = result;

    a = result;

    pc += byteLength;
  }

  /// Executes the PHA instruction.
  void _pha() {
    stack[s--] = a;
  }

  /// Executes the PHP instruction.
  void _php() {
    stack[s--] = p;
  }

  /// Executes the PLA instruction.
  void _pla() {
    final result = stack[++s];

    _z = result;
    _n = result;

    a = result;
  }

  /// Executes the PLP instruction.
  void _plp() {
    p = stack[++s];
  }

  /// Executes the ROL instruction on memory.
  void _rol((int, int) operand) {
    final (address, byteLength) = operand;

    final result = (memory[address] << 1) + (c ? 1 : 0);

    _c = result;
    _z = result;
    _n = result;

    memory[address] = result;

    pc += byteLength;
  }

  /// Executes the ROL instruction on the accumulator.
  void _rolAccumulator() {
    final result = (a << 1) + (c ? 1 : 0);

    _c = result;
    _z = result;
    _n = result;

    a = result;
  }
}
