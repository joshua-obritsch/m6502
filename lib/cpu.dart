import 'dart:typed_data';

import 'op_codes.dart';
import 'registers.dart';

part 'flags.dart';
part 'instructions.dart';
part 'memory.dart';
part 'timing.dart';

class Cpu with Flags, Instructions, Memory, Registers, Timing {
  Cpu({ByteData? memory}) {
    this.memory = memory ?? ByteData(65536);
    stack = ByteData.sublistView(this.memory, 0x0100, 0x0200);
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
        _compare(a, _immediate);
      case OpCode.cmpZeroPage:
        _compare(a, _zeroPage);
      case OpCode.cmpZeroPageX:
        _compare(a, _zeroPageX);
      case OpCode.cmpAbsolute:
        _compare(a, _absolute);
      case OpCode.cmpAbsoluteX:
        _compare(a, _absoluteX);
      case OpCode.cmpAbsoluteY:
        _compare(a, _absoluteY);
      case OpCode.cmpIndirectX:
        _compare(a, _indirectX);
      case OpCode.cmpIndirectY:
        _compare(a, _indirectY);
      // CPX
      case OpCode.cpxImmediate:
        _compare(x, _immediate);
      case OpCode.cpxZeroPage:
        _compare(x, _zeroPage);
      case OpCode.cpxAbsolute:
        _compare(x, _absolute);
      // CPY
      case OpCode.cpyImmediate:
        _compare(y, _immediate);
      case OpCode.cpyZeroPage:
        _compare(y, _zeroPage);
      case OpCode.cpyAbsolute:
        _compare(y, _absolute);
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
      // INC
      case OpCode.incZeroPage:
        _inc(_zeroPage);
      case OpCode.incZeroPageX:
        _inc(_zeroPageX);
      case OpCode.incAbsolute:
        _inc(_absolute);
      case OpCode.incAbsoluteX:
        _inc(_absoluteX);
      // INX
      case OpCode.inxImplied:
        _inx();
      // INY
      case OpCode.inyImplied:
        _iny();
      // JMP
      case OpCode.jmpAbsolute:
        _jmp(_absolute);
      case OpCode.jmpIndirect:
        _jmp(_indirect);
      // JSR
      case OpCode.jsrAbsolute:
        _jsr(_absolute);
      // LDA
      case OpCode.ldaImmediate:
        _lda(_immediate);
      case OpCode.ldaZeroPage:
        _lda(_zeroPage);
      case OpCode.ldaZeroPageX:
        _lda(_zeroPageX);
      case OpCode.ldaAbsolute:
        _lda(_absolute);
      case OpCode.ldaAbsoluteX:
        _lda(_absoluteX);
      case OpCode.ldaAbsoluteY:
        _lda(_absoluteY);
      case OpCode.ldaIndirectX:
        _lda(_indirectX);
      case OpCode.ldaIndirectY:
        _lda(_indirectY);
      // LDX
      case OpCode.ldxImmediate:
        _ldx(_immediate);
      case OpCode.ldxZeroPage:
        _ldx(_zeroPage);
      case OpCode.ldxZeroPageY:
        _ldx(_zeroPageY);
      case OpCode.ldxAbsolute:
        _ldx(_absolute);
      case OpCode.ldxAbsoluteY:
        _ldx(_absoluteY);
      // LDY
      case OpCode.ldyImmediate:
        _ldy(_immediate);
      case OpCode.ldyZeroPage:
        _ldy(_zeroPage);
      case OpCode.ldyZeroPageX:
        _ldy(_zeroPageX);
      case OpCode.ldyAbsolute:
        _ldy(_absolute);
      case OpCode.ldyAbsoluteX:
        _ldy(_absoluteX);
      // LSR
      case OpCode.lsrAccumulator:
        _lsrAccumulator();
      case OpCode.lsrZeroPage:
        _lsr(_zeroPage);
      case OpCode.lsrZeroPageX:
        _lsr(_zeroPageX);
      case OpCode.lsrAbsolute:
        _lsr(_absolute);
      case OpCode.lsrAbsoluteX:
        _lsr(_absoluteX);
      // NOP
      case OpCode.nopImplied:
        break;
      // ORA
      case OpCode.oraImmediate:
        _ora(_immediate);
      case OpCode.oraZeroPage:
        _ora(_zeroPage);
      case OpCode.oraZeroPageX:
        _ora(_zeroPageX);
      case OpCode.oraAbsolute:
        _ora(_absolute);
      case OpCode.oraAbsoluteX:
        _ora(_absoluteX);
      case OpCode.oraAbsoluteY:
        _ora(_absoluteY);
      case OpCode.oraIndirectX:
        _ora(_indirectX);
      case OpCode.oraIndirectY:
        _ora(_indirectY);
      // PHA
      case OpCode.phaImplied:
        _pha();
      // PHP
      case OpCode.phpImplied:
        _php();
      // PLA
      case OpCode.plaImplied:
        _pla();
      // PLP
      case OpCode.plpImplied:
        _plp();
      // ROL
      case OpCode.rolAccumulator:
        _rolAccumulator();
      case OpCode.rolZeroPage:
        _rol(_zeroPage);
      case OpCode.rolZeroPageX:
        _rol(_zeroPageX);
      case OpCode.rolAbsolute:
        _rol(_absolute);
      case OpCode.rolAbsoluteX:
        _rol(_absoluteX);
      // ROR
      case OpCode.rorAccumulator:
        _rorAccumulator();
      case OpCode.rorZeroPage:
        _ror(_zeroPage);
      case OpCode.rorZeroPageX:
        _ror(_zeroPageX);
      case OpCode.rorAbsolute:
        _ror(_absolute);
      case OpCode.rorAbsoluteX:
        _ror(_absoluteX);
      // RTI
      case OpCode.rtiImplied:
        _rti();
      // RTS
      case OpCode.rtsImplied:
        _rts();
      // SBC
      case OpCode.sbcImmediate:
        _sbc(_immediate);
      case OpCode.sbcZeroPage:
        _sbc(_zeroPage);
      case OpCode.sbcZeroPageX:
        _sbc(_zeroPageX);
      case OpCode.sbcAbsolute:
        _sbc(_absolute);
      case OpCode.sbcAbsoluteX:
        _sbc(_absoluteX);
      case OpCode.sbcAbsoluteY:
        _sbc(_absoluteY);
      case OpCode.sbcIndirectX:
        _sbc(_indirectX);
      case OpCode.sbcIndirectY:
        _sbc(_indirectY);
      // SEC
      case OpCode.secImplied:
        c = true;
      // SED
      case OpCode.sedImplied:
        d = true;
      // SEI
      case OpCode.seiImplied:
        i = true;
      // STA
      case OpCode.staZeroPage:
        _sta(_zeroPage);
      case OpCode.staZeroPageX:
        _sta(_zeroPageX);
      case OpCode.staAbsolute:
        _sta(_absolute);
      case OpCode.staAbsoluteX:
        _sta(_absoluteX);
      case OpCode.staAbsoluteY:
        _sta(_absoluteY);
      case OpCode.staIndirectX:
        _sta(_indirectX);
      case OpCode.staIndirectY:
        _sta(_indirectY);
      // STX
      case OpCode.stxZeroPage:
        _stx(_zeroPage);
      case OpCode.stxZeroPageY:
        _stx(_zeroPageY);
      case OpCode.stxAbsolute:
        _stx(_absolute);
      // STY
      case OpCode.styZeroPage:
        _sty(_zeroPage);
      case OpCode.styZeroPageX:
        _sty(_zeroPageX);
      case OpCode.styAbsolute:
        _sty(_absolute);
      // TAX
      case OpCode.taxImplied:
        x = a;
      // TAY
      case OpCode.tayImplied:
        y = a;
      // TSX
      case OpCode.tsxImplied:
        x = s;
      // TXA
      case OpCode.txaImplied:
        a = x;
      // TXS
      case OpCode.txsImplied:
        s = x;
      // TYA
      case OpCode.tyaImplied:
        a = y;
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
