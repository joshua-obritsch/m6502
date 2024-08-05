import 'dart:typed_data';

import 'memory.dart';
import 'op_codes.dart';

class Cpu {
  /// Represents the 8-bit instruction register (IR).
  final ByteData _ir;

  /// Represents the 8-bit accumulator register (A).
  final ByteData _a;

  /// Represents the 8-bit index register (X).
  final ByteData _x;

  /// Represents the 8-bit index register (Y).
  final ByteData _y;

  /// Represents the 8-bit processor status register (P).
  final ByteData _p;

  /// Represents the 16-bit program counter register (PC).
  final ByteData _pc;

  /// Represents the 8-bit stack pointer register (S).
  final ByteData _s;

  /// Represents the 16-bit addressable memory.
  final Memory memory;

  Cpu({required this.memory})
      : _ir = ByteData(1),
        _a = ByteData(1),
        _x = ByteData(1),
        _y = ByteData(1),
        _p = ByteData(1),
        _pc = ByteData(2),
        _s = ByteData(1);

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

  /// Sets the instruction register (IR).
  void set ir(int value) => _ir.setUint8(0, value);

  /// Sets the accumulator register (A).
  void set a(int value) {
    _a.setUint8(0, value);
    _setZeroFlag(a);
    _setNegativeFlag(a);
  }

  /// Sets the index register (X).
  void set x(int value) {
    _x.setUint8(0, value);
    _setZeroFlag(x);
    _setNegativeFlag(x);
  }

  /// Sets the index register (Y).
  void set y(int value) {
    _y.setUint8(0, value);
    _setZeroFlag(y);
    _setNegativeFlag(y);
  }

  /// Sets the processor status register (P).
  void set p(int value) => _p.setUint8(0, value);

  /// Sets the program counter register (PC).
  void set pc(int value) => _pc.setUint16(0, value);

  /// Sets the high byte of the program counter register (PCH).
  void set pch(int value) => _pc.setUint8(0, value);

  /// Sets the low byte of the program counter register (PCL).
  void set pcl(int value) => _pc.setUint8(1, value);

  /// Sets the stack pointer register (S).
  void set s(int value) => _s.setUint8(0, value);

  /// Gets the carry (C) processor status flag (bit 0).
  bool get c => p & 0x01 == 0x01;

  /// Gets the zero (Z) processor status flag (bit 1).
  bool get z => p & 0x02 == 0x02;

  /// Gets the IRQ disable (I) processor status flag (bit 2).
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
  void set c(bool value) => p = p & 0xFE | (value ? 0x01 : 0x00);

  /// Sets the zero (Z) processor status flag (bit 1).
  void set z(bool value) => p = p & 0xFD | (value ? 0x02 : 0x00);

  /// Sets the IRQ disable (I) processor status flag (bit 2).
  void set i(bool value) => p = p & 0xFB | (value ? 0x04 : 0x00);

  /// Sets the decimal mode (D) processor status flag (bit 3).
  void set d(bool value) => p = p & 0xF7 | (value ? 0x08 : 0x00);

  /// Sets the break (B) processor status flag (bit 4).
  void set b(bool value) => p = p & 0xEF | (value ? 0x10 : 0x00);

  /// Sets the overflow (V) processor status flag (bit 6).
  void set v(bool value) => p = p & 0xBF | (value ? 0x40 : 0x00);

  /// Sets the negative (N) processor status flag (bit 7).
  void set n(bool value) => p = p & 0x7F | (value ? 0x80 : 0x00);

  /// Sets the carry (C) processor status flag (bit 0) arithmetically.
  void _setCarryFlag(int value) => c = value > 0xFF;

  /// Sets the zero (Z) processor status flag (bit 1) arithmetically.
  void _setZeroFlag(int value) => z = value == 0;

  /// Sets the overflow (V) processor status flag (bit 6) arithmetically.
  void _setOverflowFlag(int a, int b, int c) =>
      v = (a ^ c) & (b ^ c) & 0x80 == 0x80;

  /// Sets the negative (N) processor status flag (bit 7) arithmetically.
  void _setNegativeFlag(int value) => n = value & 0x80 == 0x80;

  /// Clears all the registers.
  void clear() {
    ir = 0;
    a = 0;
    x = 0;
    y = 0;
    p = 0;
    pc = 0;
    s = 0;
  }

  /// Gets the next operation code from memory.
  void fetchOpCode() => ir = memory[pc++];

  /// Gets the address from memory via absolute addressing.
  int _fetchAbsolute() => memory[pc++] | memory[pc++] << 8;

  /// Gets the address from memory via absolute x addressing.
  int _fetchAbsoluteX() => (memory[pc++] | memory[pc++] << 8) + x;

  /// Gets the address from memory via absolute y addressing.
  int _fetchAbsoluteY() => (memory[pc++] | memory[pc++] << 8) + y;

  /// Gets the address from memory via indirect addressing.
  int _fetchIndirect() =>
      memory.getUint16(memory[memory[pc++] | memory[pc++] << 8]);

  /// Gets the operand from memory via immediate addressing.
  int _fetchImmediate() => memory[pc++];

  /// Gets the address from memory via relative addressing.
  int _fetchRelative() => memory.getUint16(pc + memory.getInt8(pc++));

  /// Gets the address from memory via zero-page addressing.
  int _fetchZeroPage() => memory[pc++];

  /// Gets the address from memory via zero-page x addressing.
  int _fetchZeroPageX() => (memory[pc++] + x) & 0xFF;

  /// Gets the address from memory via zero-page y addressing.
  int _fetchZeroPageY() => (memory[pc++] + y) & 0xFF;

  /// Gets the address from memory via indirect x addressing.
  int _fetchIndirectX() => memory.getUint16((memory[pc++] + x) & 0xFF);

  /// Gets the address from memory via indirect y addressing.
  int _fetchIndirectY() => (memory.getUint16(memory[pc++]) + y) & 0xFFFF;

  int get _absoluteXPageBoundary => memory[pc] + x > 0xFF ? 1 : 0;

  int get _absoluteYPageBoundary => memory[pc] + y > 0xFF ? 1 : 0;

  int get _indirectYPageBoundary => memory[memory[pc]] + y > 0xFF ? 1 : 0;

  int _branchPageBoundary(bool condition) {
    if (condition) {
      final address = pcl + memory.getInt8(pc) + 1;

      if (address < 0x00 || address > 0xFF) {
        return 2;
      } else {
        return 1;
      }
    } else {
      return 0;
    }
  }

  /// Gets the cycle count of the next instruction.
  int tick() => switch (ir) {
        // ADC
        OpCode.adcImmediate => 2,
        OpCode.adcZeroPage => 3,
        OpCode.adcZeroPageX => 4,
        OpCode.adcAbsolute => 4,
        OpCode.adcAbsoluteX => 4 + _absoluteXPageBoundary,
        OpCode.adcAbsoluteY => 4 + _absoluteYPageBoundary,
        OpCode.adcIndirectX => 6,
        OpCode.adcIndirectY => 5 + _indirectYPageBoundary,
        // AND
        OpCode.andImmediate => 2,
        OpCode.andZeroPage => 3,
        OpCode.andZeroPageX => 4,
        OpCode.andAbsolute => 4,
        OpCode.andAbsoluteX => 4 + _absoluteXPageBoundary,
        OpCode.andAbsoluteY => 4 + _absoluteYPageBoundary,
        OpCode.andIndirectX => 6,
        OpCode.andIndirectY => 5 + _indirectYPageBoundary,
        // ASL
        OpCode.aslAccumulator => 2,
        OpCode.aslZeroPage => 5,
        OpCode.aslZeroPageX => 6,
        OpCode.aslAbsolute => 6,
        OpCode.aslAbsoluteX => 7,
        // BCC
        OpCode.bccRelative => 2 + _branchPageBoundary(c == false),
        // BCS
        OpCode.bcsRelative => 2 + _branchPageBoundary(c == true),
        // BEQ
        OpCode.beqRelative => 2 + _branchPageBoundary(z == true),
        // BIT
        OpCode.bitZeroPage => 3,
        OpCode.bitAbsolute => 4,
        // BMI
        OpCode.bmiRelative => 2 + _branchPageBoundary(n == true),
        // BNE
        OpCode.bneRelative => 2 + _branchPageBoundary(z == false),
        // BPL
        OpCode.bplRelative => 2 + _branchPageBoundary(n == false),
        // BRK
        OpCode.brkImplied => 7,
        // BVC
        OpCode.bvcRelative => 2 + _branchPageBoundary(v == false),
        // BVS
        OpCode.bvsRelative => 2 + _branchPageBoundary(v == true),
        // CLC
        OpCode.clcImplied => 2,
        // CLD
        OpCode.cldImplied => 2,
        // CLI
        OpCode.cliImplied => 2,
        // CLV
        OpCode.clvImplied => 2,
        // CMP
        OpCode.cmpImmediate => 2,
        OpCode.cmpZeroPage => 3,
        OpCode.cmpZeroPageX => 4,
        OpCode.cmpAbsolute => 4,
        OpCode.cmpAbsoluteX => 4 + _absoluteXPageBoundary,
        OpCode.cmpAbsoluteY => 4 + _absoluteYPageBoundary,
        OpCode.cmpIndirectX => 6,
        OpCode.cmpIndirectY => 5 + _indirectYPageBoundary,
        // CPX
        OpCode.cpxImmediate => 2,
        OpCode.cpxZeroPage => 3,
        OpCode.cpxAbsolute => 4,
        // CPY
        OpCode.cpyImmediate => 2,
        OpCode.cpyZeroPage => 3,
        OpCode.cpyAbsolute => 4,
        // DEC
        OpCode.decZeroPage => 5,
        OpCode.decZeroPageX => 6,
        OpCode.decAbsolute => 6,
        OpCode.decAbsoluteX => 7,
        // DEX
        OpCode.dexImplied => 2,
        // DEY
        OpCode.deyImplied => 2,
        // EOR
        OpCode.eorImmediate => 2,
        OpCode.eorZeroPage => 3,
        OpCode.eorZeroPageX => 4,
        OpCode.eorAbsolute => 4,
        OpCode.eorAbsoluteX => 4 + _absoluteXPageBoundary,
        OpCode.eorAbsoluteY => 4 + _absoluteYPageBoundary,
        OpCode.eorIndirectX => 6,
        OpCode.eorIndirectY => 5 + _indirectYPageBoundary,
        // INC
        OpCode.incZeroPage => 5,
        OpCode.incZeroPageX => 6,
        OpCode.incAbsolute => 6,
        OpCode.incAbsoluteX => 7,
        // INX
        OpCode.inxImplied => 2,
        // INY
        OpCode.inyImplied => 2,
        // JMP
        OpCode.jmpAbsolute => 3,
        OpCode.jmpIndirect => 5,
        // JSR
        OpCode.jsrAbsolute => 6,
        // LDA
        OpCode.ldaImmediate => 2,
        OpCode.ldaZeroPage => 3,
        OpCode.ldaZeroPageX => 4,
        OpCode.ldaAbsolute => 4,
        OpCode.ldaAbsoluteX => 4 + _absoluteXPageBoundary,
        OpCode.ldaAbsoluteY => 4 + _absoluteYPageBoundary,
        OpCode.ldaIndirectX => 6,
        OpCode.ldaIndirectY => 5 + _indirectYPageBoundary,
        // LDX
        OpCode.ldxImmediate => 2,
        OpCode.ldxZeroPage => 3,
        OpCode.ldxZeroPageY => 4,
        OpCode.ldxAbsolute => 4,
        OpCode.ldxAbsoluteY => 4 + _absoluteYPageBoundary,
        // LDY
        OpCode.ldyImmediate => 2,
        OpCode.ldyZeroPage => 3,
        OpCode.ldyZeroPageX => 4,
        OpCode.ldyAbsolute => 4,
        OpCode.ldyAbsoluteX => 4 + _absoluteXPageBoundary,
        // LSR
        OpCode.lsrAccumulator => 2,
        OpCode.lsrZeroPage => 5,
        OpCode.lsrZeroPageX => 6,
        OpCode.lsrAbsolute => 6,
        OpCode.lsrAbsoluteX => 7,
        // NOP
        OpCode.nopImplied => 2,
        // ORA
        OpCode.oraImmediate => 2,
        OpCode.oraZeroPage => 3,
        OpCode.oraZeroPageX => 4,
        OpCode.oraAbsolute => 4,
        OpCode.oraAbsoluteX => 4 + _absoluteXPageBoundary,
        OpCode.oraAbsoluteY => 4 + _absoluteYPageBoundary,
        OpCode.oraIndirectX => 6,
        OpCode.oraIndirectY => 5 + _indirectYPageBoundary,
        // PHA
        OpCode.phaImplied => 3,
        // PHP
        OpCode.phpImplied => 3,
        // PLA
        OpCode.plaImplied => 4,
        // PLP
        OpCode.plpImplied => 4,
        // ROL
        OpCode.rolAccumulator => 2,
        OpCode.rolZeroPage => 5,
        OpCode.rolZeroPageX => 6,
        OpCode.rolAbsolute => 6,
        OpCode.rolAbsoluteX => 7,
        // ROR
        OpCode.rorAccumulator => 2,
        OpCode.rorZeroPage => 5,
        OpCode.rorZeroPageX => 6,
        OpCode.rorAbsolute => 6,
        OpCode.rorAbsoluteX => 7,
        // RTI
        OpCode.rtiImplied => 6,
        // RTS
        OpCode.rtsImplied => 6,
        // SBC
        OpCode.sbcImmediate => 2,
        OpCode.sbcZeroPage => 3,
        OpCode.sbcZeroPageX => 4,
        OpCode.sbcAbsolute => 4,
        OpCode.sbcAbsoluteX => 4 + _absoluteXPageBoundary,
        OpCode.sbcAbsoluteY => 4 + _absoluteYPageBoundary,
        OpCode.sbcIndirectX => 6,
        OpCode.sbcIndirectY => 5 + _indirectYPageBoundary,
        // SEC
        OpCode.secImplied => 2,
        // SED
        OpCode.sedImplied => 2,
        // SEI
        OpCode.seiImplied => 2,
        // STA
        OpCode.staZeroPage => 3,
        OpCode.staZeroPageX => 4,
        OpCode.staAbsolute => 4,
        OpCode.staAbsoluteX => 5,
        OpCode.staAbsoluteY => 5,
        OpCode.staIndirectX => 6,
        OpCode.staIndirectY => 6,
        // STX
        OpCode.stxZeroPage => 3,
        OpCode.stxZeroPageY => 4,
        OpCode.stxAbsolute => 4,
        // STY
        OpCode.styZeroPage => 3,
        OpCode.styZeroPageX => 4,
        OpCode.styAbsolute => 4,
        // TAX
        OpCode.taxImplied => 2,
        // TAY
        OpCode.tayImplied => 2,
        // TSX
        OpCode.tsxImplied => 2,
        // TXA
        OpCode.txaImplied => 2,
        // TXS
        OpCode.txsImplied => 2,
        // TYA
        OpCode.tyaImplied => 2,
        _ => 0,
      };

  void _add(int address) {
    final initialValue = a;
    final operand = memory[address];
    final result = initialValue + operand;

    a = result;
    _setCarryFlag(result);
    _setOverflowFlag(initialValue, operand, a);
  }

  void _shiftAccumulatorLeft() {
    final value = a << 1;

    a = value;
    _setCarryFlag(value);
  }

  void _shiftMemoryLeft(int address) {
    final value = memory[address] << 1;
    final result = value & 0xFF;

    memory[address] = result;
    _setCarryFlag(value);
    _setZeroFlag(result);
    _setNegativeFlag(result);
  }

  void _bit(int address) {
    final operand = memory[address];

    _setZeroFlag(a & operand);
    v = operand & 0x40 == 0x40;
    n = operand & 0x80 == 0x80;
  }

  void _branch(bool condition, int address) =>
      pc = condition ? memory[address] : pc + 1;

  /// Executes the next instruction.
  void execute() {
    switch (ir) {
      // ADC
      case OpCode.adcImmediate:
        _add(_fetchImmediate());
      case OpCode.adcZeroPage:
        _add(_fetchZeroPage());
      case OpCode.adcZeroPageX:
        _add(_fetchZeroPageX());
      case OpCode.adcAbsolute:
        _add(_fetchAbsolute());
      case OpCode.adcAbsoluteX:
        _add(_fetchAbsoluteX());
      case OpCode.adcAbsoluteY:
        _add(_fetchAbsoluteY());
      case OpCode.adcIndirectX:
        _add(_fetchIndirectX());
      case OpCode.adcIndirectY:
        _add(_fetchIndirectY());
      // AND
      case OpCode.andImmediate:
        a = a & _fetchImmediate();
      case OpCode.andZeroPage:
        a = a & memory[_fetchZeroPage()];
      case OpCode.andZeroPageX:
        a = a & memory[_fetchZeroPageX()];
      case OpCode.andAbsolute:
        a = a & memory[_fetchAbsolute()];
      case OpCode.andAbsoluteX:
        a = a & memory[_fetchAbsoluteX()];
      case OpCode.andAbsoluteY:
        a = a & memory[_fetchAbsoluteY()];
      case OpCode.andIndirectX:
        a = a & memory[_fetchIndirectX()];
      case OpCode.andIndirectY:
        a = a & memory[_fetchIndirectY()];
      // ASL
      case OpCode.aslAccumulator:
        _shiftAccumulatorLeft();
      case OpCode.aslZeroPage:
        _shiftMemoryLeft(_fetchZeroPage());
      case OpCode.aslZeroPageX:
        _shiftMemoryLeft(_fetchZeroPageX());
      case OpCode.aslAbsolute:
        _shiftMemoryLeft(_fetchAbsolute());
      case OpCode.aslAbsoluteX:
        _shiftMemoryLeft(_fetchAbsoluteX());
      // BCC
      case OpCode.bccRelative:
        _branch(c == false, _fetchRelative());
      // BCS
      case OpCode.bcsRelative:
        _branch(c == true, _fetchRelative());
      // BEQ
      case OpCode.beqRelative:
        _branch(z == true, _fetchRelative());
      // BIT
      case OpCode.bitZeroPage:
        _bit(_fetchZeroPage());
      case OpCode.bitAbsolute:
        _bit(_fetchAbsolute());
      // BMI
      case OpCode.bmiRelative:
        _branch(n == true, _fetchRelative());
      // BNE
      case OpCode.bneRelative:
        _branch(z == false, _fetchRelative());
      // BPL
      case OpCode.bplRelative:
        _branch(n == false, _fetchRelative());
      // BRK
      case OpCode.brkImplied:
        // TODO
        return;
      // BVC
      case OpCode.bvcRelative:
        _branch(v == false, _fetchRelative());
      // BVS
      case OpCode.bvsRelative:
        _branch(v == true, _fetchRelative());
      // CLC
      case OpCode.clcImplied:
        c = false;
      // CLD
      case OpCode.cldImplied:
        d = false;
      // CLI
      case OpCode.cliImplied:
        i = false;
      // CLV
      case OpCode.clvImplied:
        v = false;
    }
  }
}
