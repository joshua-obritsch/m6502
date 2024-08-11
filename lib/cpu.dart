import 'dart:typed_data';

import 'op_codes.dart';
import 'registers.dart';

part 'flags.dart';
part 'instructions.dart';
part 'memory.dart';
part 'timing.dart';

class Cpu with Flags, Instructions, Memory, Registers, Timing {
  Cpu() {
    p = 0x20;
  }

  /// Gets the next operation code from memory and calculates the cycle count.
  void fetch() {
    ir = memory[pc++];
    tcu = _tick();
  }

  /// Executes the next instruction.
  void execute() {
    switch (ir) {
      // ADC
      case OpCode.adcImmediate:
        _adc(_immediate);
      case OpCode.adcZeroPage:
        _adc(_zeroPage);
      case OpCode.adcZeroPageX:
        _adc(_zeroPageX);
      case OpCode.adcAbsolute:
        _adc(_absolute);
      case OpCode.adcAbsoluteX:
        _adc(_absoluteX);
      case OpCode.adcAbsoluteY:
        _adc(_absoluteY);
      case OpCode.adcIndirectX:
        _adc(_indirectX);
      case OpCode.adcIndirectY:
        _adc(_indirectY);
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
        _brk();
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
        _cpx(_absolute);
      // CPY
      case OpCode.cpyImmediate:
        _cpy(_immediate);
      case OpCode.cpyZeroPage:
        _cpy(_zeroPage);
      case OpCode.cpyAbsolute:
        _cpy(_absolute);
      // DEC
      case OpCode.decZeroPage:
        _dec(_zeroPage);
      case OpCode.decZeroPageX:
        _dec(_zeroPageX);
      case OpCode.decAbsolute:
        _dec(_absolute);
      case OpCode.decAbsoluteX:
        _dec(_absoluteX);
      // DEX
      case OpCode.dexImplied:
        _dex();
      // DEY
      case OpCode.deyImplied:
        _dey();
      // EOR
      case OpCode.eorImmediate:
        _eor(_immediate);
      case OpCode.eorZeroPage:
        _eor(_zeroPage);
      case OpCode.eorZeroPageX:
        _eor(_zeroPageX);
      case OpCode.eorAbsolute:
        _eor(_absolute);
      case OpCode.eorAbsoluteX:
        _eor(_absoluteX);
      case OpCode.eorAbsoluteY:
        _eor(_absoluteY);
      case OpCode.eorIndirectX:
        _eor(_indirectX);
      case OpCode.eorIndirectY:
        _eor(_indirectY);
    }
  }

  /// Resets all the registers and gets the reset vector.
  void reset() {
    ir = 0;
    tcu = 0;
    a = 0;
    x = 0;
    y = 0;
    p = 0x20;
    pc = memory.getUint16(0xFFFC, Endian.little);
    s = 0;
  }

  /// Clears a region of memory.
  void clear([int? start, int? end]) {
    for (var i = start ?? 0; i < (end ?? memory.lengthInBytes); i++) {
      memory.setUint8(i, 0);
    }
  }
}
