import 'dart:typed_data';

import 'op_codes.dart';
import 'registers.dart';

part 'flags.dart';
part 'memory.dart';

class Cpu with Registers, Flags, Memory {
  Cpu();

  /// Gets the next operation code from memory.
  void fetch() => ir = memory[pc++];

  /// Executes the next instruction.
  void execute() {
    switch (ir) {
      // ADC
      case OpCode.adcImmediate:
        _add(_immediate);
      case OpCode.adcZeroPage:
        _add(_zeroPage);
      case OpCode.adcZeroPageX:
        _add(_zeroPageX);
      case OpCode.adcAbsolute:
        _add(_absolute);
      case OpCode.adcAbsoluteX:
        _add(_absoluteX);
      case OpCode.adcAbsoluteY:
        _add(_absoluteY);
      case OpCode.adcIndirectX:
        _add(_indirectX);
      case OpCode.adcIndirectY:
        _add(_indirectY);
      // AND
      case OpCode.andImmediate:
        _and(_immediate);
      case OpCode.andZeroPage:
        _and(_zeroPage);
      case OpCode.andZeroPageX:
        _and(_zeroPageX);
      case OpCode.andAbsolute:
        _and(_absolute);
      case OpCode.andAbsoluteX:
        _and(_absoluteX);
      case OpCode.andAbsoluteY:
        _and(_absoluteY);
      case OpCode.andIndirectX:
        _and(_indirectX);
      case OpCode.andIndirectY:
        _and(_indirectY);
      // ASL
      case OpCode.aslAccumulator:
        _aslAccumulator();
      case OpCode.aslZeroPage:
        _asl(_zeroPage);
      case OpCode.aslZeroPageX:
        _asl(_zeroPageX);
      case OpCode.aslAbsolute:
        _asl(_absolute);
      case OpCode.aslAbsoluteX:
        _asl(_absoluteX);
      // BCC
      case OpCode.bccRelative:
        _branch(!c);
      // BCS
      case OpCode.bcsRelative:
        _branch(c);
      // BEQ
      case OpCode.beqRelative:
        _branch(z);
      // BIT
      case OpCode.bitZeroPage:
        _bit(_zeroPage);
      case OpCode.bitAbsolute:
        _bit(_absolute);
      // BMI
      case OpCode.bmiRelative:
        _branch(n);
      // BNE
      case OpCode.bneRelative:
        _branch(!z);
      // BPL
      case OpCode.bplRelative:
        _branch(!n);
      // BRK
      case OpCode.brkImplied:
        // TODO
        return;
      // BVC
      case OpCode.bvcRelative:
        _branch(!v);
      // BVS
      case OpCode.bvsRelative:
        _branch(v);
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
      // CMP
      case OpCode.cmpImmediate:
        _cmp(_immediate);
      case OpCode.cmpZeroPage:
        _cmp(_zeroPage);
      case OpCode.cmpZeroPageX:
        _cmp(_zeroPageX);
      case OpCode.cmpAbsolute:
        _cmp(_absolute);
      case OpCode.cmpAbsoluteX:
        _cmp(_absoluteX);
      case OpCode.cmpAbsoluteY:
        _cmp(_absoluteY);
      case OpCode.cmpIndirectX:
        _cmp(_indirectX);
      case OpCode.cmpIndirectY:
        _cmp(_indirectY);
      // CPX
      case OpCode.cpxImmediate:
        _cpx(_immediate);
      case OpCode.cpxZeroPage:
        _cpx(_zeroPage);
      case OpCode.cpxAbsolute:
        _cpx(_zeroPageX);
      // CPY
      case OpCode.cpyImmediate:
        _cpy(_immediate);
      case OpCode.cpyZeroPage:
        _cpy(_zeroPage);
      case OpCode.cpyAbsolute:
        _cpy(_zeroPageX);
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
        OpCode.bccRelative => 2 + _relativePageBoundary(!c),
        // BCS
        OpCode.bcsRelative => 2 + _relativePageBoundary(c),
        // BEQ
        OpCode.beqRelative => 2 + _relativePageBoundary(z),
        // BIT
        OpCode.bitZeroPage => 3,
        OpCode.bitAbsolute => 4,
        // BMI
        OpCode.bmiRelative => 2 + _relativePageBoundary(n),
        // BNE
        OpCode.bneRelative => 2 + _relativePageBoundary(!z),
        // BPL
        OpCode.bplRelative => 2 + _relativePageBoundary(!n),
        // BRK
        OpCode.brkImplied => 7,
        // BVC
        OpCode.bvcRelative => 2 + _relativePageBoundary(!v),
        // BVS
        OpCode.bvsRelative => 2 + _relativePageBoundary(v),
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

  /// Clears all the registers and memory.
  void reset() {
    ir = 0;
    a = 0;
    x = 0;
    y = 0;
    p = 0;
    pc = 0;
    s = 0;

    for (var index = 0; index < memory.lengthInBytes; index++) {
      memory[index] = 0;
    }
  }

  void _add((int, int) operands) {
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

  void _and((int, int) operands) {
    final (address, byteLength) = operands;

    final result = a & memory[address];

    _z = result;
    _n = result;

    a = result;

    pc += byteLength;
  }

  void _asl((int, int) operands) {
    final (address, byteLength) = operands;

    final result = memory[address] << 1;

    _c = result;
    _z = result;
    _n = result;

    memory[address] = result;

    pc += byteLength;
  }

  void _aslAccumulator() {
    final result = a << 1;

    _c = result;
    _z = result;
    _n = result;

    a = result;
  }

  void _bit((int, int) operands) {
    final (address, byteLength) = operands;

    final operand = memory[address];

    _z = a & operand;
    v = operand & 0x40 == 0x40;
    n = operand & 0x80 == 0x80;

    pc += byteLength;
  }

  void _branch(bool condition) {
    final (address, byteLength) = _relative;

    pc = (condition ? memory[address] + pc : pc) + byteLength;
  }

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
