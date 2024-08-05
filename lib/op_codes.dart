sealed class OpCode {
  /// # ADC Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: ADC #oper
  /// Operation Code:     69
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int adcImmediate = 0x69;

  /// # ADC Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: ADC oper
  /// Operation Code:     65
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int adcZeroPage = 0x65;

  /// # ADC Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: ADC oper,X
  /// Operation Code:     75
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int adcZeroPageX = 0x75;

  /// # ADC Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: ADC oper
  /// Operation Code:     6D
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int adcAbsolute = 0x6D;

  /// # ADC Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: ADC oper,X
  /// Operation Code:     7D
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int adcAbsoluteX = 0x7D;

  /// # ADC Absolute Y
  ///
  /// Addressing Mode:    Absolute Y
  /// Instruction Syntax: ADC oper,Y
  /// Operation Code:     79
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int adcAbsoluteY = 0x79;

  /// # ADC Indirect X
  ///
  /// Addressing Mode:    Indirect X
  /// Instruction Syntax: ADC (oper,X)
  /// Operation Code:     61
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int adcIndirectX = 0x61;

  /// # ADC Indirect Y
  ///
  /// Addressing Mode:    Indirect Y
  /// Instruction Syntax: ADC (oper),Y
  /// Operation Code:     71
  /// Byte Count:         2
  /// Cycle Count:        5*
  static const int adcIndirectY = 0x71;

  /// # AND Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: AND #oper
  /// Operation Code:     29
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int andImmediate = 0x29;

  /// # AND Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: AND oper
  /// Operation Code:     25
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int andZeroPage = 0x25;

  /// # AND Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: AND oper,X
  /// Operation Code:     35
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int andZeroPageX = 0x35;

  /// # AND Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: AND oper
  /// Operation Code:     2D
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int andAbsolute = 0x2D;

  /// # AND Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: AND oper,X
  /// Operation Code:     3D
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int andAbsoluteX = 0x3D;

  /// # AND Absolute Y
  ///
  /// Addressing Mode:    Absolute Y
  /// Instruction Syntax: AND oper,Y
  /// Operation Code:     39
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int andAbsoluteY = 0x39;

  /// # AND Indirect X
  ///
  /// Addressing Mode:    Indirect X
  /// Instruction Syntax: AND (oper,X)
  /// Operation Code:     21
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int andIndirectX = 0x21;

  /// # AND Indirect Y
  ///
  /// Addressing Mode:    Indirect Y
  /// Instruction Syntax: AND (oper,Y)
  /// Operation Code:     31
  /// Byte Count:         2
  /// Cycle Count:        5*
  static const int andIndirectY = 0x31;

  /// # ASL Accumulator
  ///
  /// Addressing Mode:    Accumulator
  /// Instruction Syntax: ASL
  /// Operation Code:     0A
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int aslAccumulator = 0x0A;

  /// # ASL Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: ASL oper
  /// Operation Code:     06
  /// Byte Count:         2
  /// Cycle Count:        5
  static const int aslZeroPage = 0x06;

  /// # ASL Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: ASL oper,X
  /// Operation Code:     16
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int aslZeroPageX = 0x16;

  /// # ASL Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: ASL oper
  /// Operation Code:     0E
  /// Byte Count:         3
  /// Cycle Count:        6
  static const int aslAbsolute = 0x0E;

  /// # ASL Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: ASL oper,X
  /// Operation Code:     1E
  /// Byte Count:         3
  /// Cycle Count:        7
  static const int aslAbsoluteX = 0x1E;

  /// # BCC Relative
  ///
  /// Addressing Mode:    Relative
  /// Instruction Syntax: BCC oper
  /// Operation Code:     90
  /// Byte Count:         2
  /// Cycle Count:        2**
  static const int bccRelative = 0x90;

  /// # BCS Relative
  ///
  /// Addressing Mode:    Relative
  /// Instruction Syntax: BCS oper
  /// Operation Code:     B0
  /// Byte Count:         2
  /// Cycle Count:        2**
  static const int bcsRelative = 0xB0;

  /// # BEQ Relative
  ///
  /// Addressing Mode:    Relative
  /// Instruction Syntax: BEQ oper
  /// Operation Code:     F0
  /// Byte Count:         2
  /// Cycle Count:        2**
  static const int beqRelative = 0xF0;

  /// # BIT Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: BIT oper
  /// Operation Code:     24
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int bitZeroPage = 0x24;

  /// # BIT Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: BIT oper
  /// Operation Code:     2C
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int bitAbsolute = 0x2C;

  /// # BMI Relative
  ///
  /// Addressing Mode:    Relative
  /// Instruction Syntax: BMI oper
  /// Operation Code:     30
  /// Byte Count:         2
  /// Cycle Count:        2**
  static const int bmiRelative = 0x30;

  /// # BNE Relative
  ///
  /// Addressing Mode:    Relative
  /// Instruction Syntax: BNE oper
  /// Operation Code:     D0
  /// Byte Count:         2
  /// Cycle Count:        2**
  static const int bneRelative = 0xD0;

  /// # BPL Relative
  ///
  /// Addressing Mode:    Relative
  /// Instruction Syntax: BPL oper
  /// Operation Code:     10
  /// Byte Count:         2
  /// Cycle Count:        2**
  static const int bplRelative = 0x10;

  /// # BRK Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: BRK
  /// Operation Code:     00
  /// Byte Count:         1
  /// Cycle Count:        7
  static const int brkImplied = 0x00;

  /// # BVC Relative
  ///
  /// Addressing Mode:    Relative
  /// Instruction Syntax: BVC oper
  /// Operation Code:     50
  /// Byte Count:         2
  /// Cycle Count:        2**
  static const int bvcRelative = 0x50;

  /// # BVS Relative
  ///
  /// Addressing Mode:    Relative
  /// Instruction Syntax: BVS oper
  /// Operation Code:     70
  /// Byte Count:         2
  /// Cycle Count:        2**
  static const int bvsRelative = 0x70;

  /// # CLC Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: CLC
  /// Operation Code:     18
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int clcImplied = 0x18;

  /// # CLD Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: CLD
  /// Operation Code:     D8
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int cldImplied = 0xD8;

  /// # CLI Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: CLI
  /// Operation Code:     58
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int cliImplied = 0x58;

  /// # CLV Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: CLV
  /// Operation Code:     B8
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int clvImplied = 0xB8;

  /// # CMP Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: CMP #oper
  /// Operation Code:     C9
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int cmpImmediate = 0xC9;

  /// # CMP Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: CMP oper
  /// Operation Code:     C5
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int cmpZeroPage = 0xC5;

  /// # CMP Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: CMP oper,X
  /// Operation Code:     D5
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int cmpZeroPageX = 0xD5;

  /// # CMP Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: CMP oper
  /// Operation Code:     CD
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int cmpAbsolute = 0xCD;

  /// # CMP Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: CMP oper,X
  /// Operation Code:     DD
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int cmpAbsoluteX = 0xDD;

  /// # CMP Absolute Y
  ///
  /// Addressing Mode:    Absolute Y
  /// Instruction Syntax: CMP oper,Y
  /// Operation Code:     D9
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int cmpAbsoluteY = 0xD9;

  /// # CMP Indirect X
  ///
  /// Addressing Mode:    Indirect X
  /// Instruction Syntax: CMP (oper,X)
  /// Operation Code:     C1
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int cmpIndirectX = 0xC1;

  /// # CMP Indirect Y
  ///
  /// Addressing Mode:    Indirect Y
  /// Instruction Syntax: CMP (oper),Y
  /// Operation Code:     D1
  /// Byte Count:         2
  /// Cycle Count:        5*
  static const int cmpIndirectY = 0xD1;

  /// # CPX Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: CPX #oper
  /// Operation Code:     E0
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int cpxImmediate = 0xE0;

  /// # CPX Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: CPX oper
  /// Operation Code:     E4
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int cpxZeroPage = 0xE4;

  /// # CPX Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: CPX oper
  /// Operation Code:     EC
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int cpxAbsolute = 0xEC;

  /// # CPY Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: CPY #oper
  /// Operation Code:     C0
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int cpyImmediate = 0xC0;

  /// # CPY Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: CPY oper
  /// Operation Code:     C4
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int cpyZeroPage = 0xC4;

  /// # CPY Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: CPY oper
  /// Operation Code:     CC
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int cpyAbsolute = 0xCC;

  /// # DEC Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: DEC oper
  /// Operation Code:     C6
  /// Byte Count:         2
  /// Cycle Count:        5
  static const int decZeroPage = 0xC6;

  /// # DEC Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: DEC oper,X
  /// Operation Code:     D6
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int decZeroPageX = 0xD6;

  /// # DEC Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: DEC oper
  /// Operation Code:     CE
  /// Byte Count:         3
  /// Cycle Count:        6
  static const int decAbsolute = 0xCE;

  /// # DEC Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: DEC oper,X
  /// Operation Code:     DE
  /// Byte Count:         3
  /// Cycle Count:        7
  static const int decAbsoluteX = 0xDE;

  /// # DEX Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: DEX
  /// Operation Code:     CA
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int dexImplied = 0xCA;

  /// # DEY Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: DEY
  /// Operation Code:     88
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int deyImplied = 0x88;

  /// # EOR Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: EOR #oper
  /// Operation Code:     49
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int eorImmediate = 0x49;

  /// # EOR Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: EOR oper
  /// Operation Code:     45
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int eorZeroPage = 0x45;

  /// # EOR Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: EOR oper,X
  /// Operation Code:     55
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int eorZeroPageX = 0x55;

  /// # EOR Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: EOR oper
  /// Operation Code:     4D
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int eorAbsolute = 0x4D;

  /// # EOR Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: EOR oper,X
  /// Operation Code:     5D
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int eorAbsoluteX = 0x5D;

  /// # EOR Absolute Y
  ///
  /// Addressing Mode:    Absolute Y
  /// Instruction Syntax: EOR oper,Y
  /// Operation Code:     59
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int eorAbsoluteY = 0x59;

  /// # EOR Indirect X
  ///
  /// Addressing Mode:    Indirect X
  /// Instruction Syntax: EOR (oper,X)
  /// Operation Code:     41
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int eorIndirectX = 0x41;

  /// # EOR Indirect Y
  ///
  /// Addressing Mode:    Indirect Y
  /// Instruction Syntax: EOR (oper),Y
  /// Operation Code:     51
  /// Byte Count:         2
  /// Cycle Count:        5*
  static const int eorIndirectY = 0x51;

  /// # INC Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: INC oper
  /// Operation Code:     E6
  /// Byte Count:         2
  /// Cycle Count:        5
  static const int incZeroPage = 0xE6;

  /// # INC Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: INC oper,X
  /// Operation Code:     F6
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int incZeroPageX = 0xF6;

  /// # INC Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: INC oper
  /// Operation Code:     EE
  /// Byte Count:         3
  /// Cycle Count:        6
  static const int incAbsolute = 0xEE;

  /// # INC Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: INC oper,X
  /// Operation Code:     FE
  /// Byte Count:         3
  /// Cycle Count:        7
  static const int incAbsoluteX = 0xFE;

  /// # INX Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: INX
  /// Operation Code:     E8
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int inxImplied = 0xE8;

  /// # INY Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: INY
  /// Operation Code:     C8
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int inyImplied = 0xC8;

  /// # JMP Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: JMP oper
  /// Operation Code:     4C
  /// Byte Count:         3
  /// Cycle Count:        3
  static const int jmpAbsolute = 0x4C;

  /// # JMP Indirect
  ///
  /// Addressing Mode:    Indirect
  /// Instruction Syntax: JMP (oper)
  /// Operation Code:     6C
  /// Byte Count:         3
  /// Cycle Count:        5
  static const int jmpIndirect = 0x6C;

  /// # JSR Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: JSR oper
  /// Operation Code:     20
  /// Byte Count:         3
  /// Cycle Count:        6
  static const int jsrAbsolute = 0x20;

  /// # LDA Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: LDA #oper
  /// Operation Code:     A9
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int ldaImmediate = 0xA9;

  /// # LDA Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: LDA oper
  /// Operation Code:     A5
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int ldaZeroPage = 0xA5;

  /// # LDA Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: LDA oper,X
  /// Operation Code:     B5
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int ldaZeroPageX = 0xB5;

  /// # LDA Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: LDA oper
  /// Operation Code:     AD
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int ldaAbsolute = 0xAD;

  /// # LDA Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: LDA oper,X
  /// Operation Code:     BD
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int ldaAbsoluteX = 0xBD;

  /// # LDA Absolute Y
  ///
  /// Addressing Mode:    Absolute Y
  /// Instruction Syntax: LDA oper,Y
  /// Operation Code:     B9
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int ldaAbsoluteY = 0xB9;

  /// # LDA Indirect X
  ///
  /// Addressing Mode:    Indirect X
  /// Instruction Syntax: LDA (oper,X)
  /// Operation Code:     A1
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int ldaIndirectX = 0xA1;

  /// # LDA Indirect Y
  ///
  /// Addressing Mode:    Indirect Y
  /// Instruction Syntax: LDA (oper),Y
  /// Operation Code:     B1
  /// Byte Count:         2
  /// Cycle Count:        5*
  static const int ldaIndirectY = 0xB1;

  /// # LDX Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: LDX #oper
  /// Operation Code:     A2
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int ldxImmediate = 0xA2;

  /// # LDX Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: LDX oper
  /// Operation Code:     A6
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int ldxZeroPage = 0xA6;

  /// # LDX Zero Page Y
  ///
  /// Addressing Mode:    Zero Page Y
  /// Instruction Syntax: LDX oper,Y
  /// Operation Code:     B6
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int ldxZeroPageY = 0xB6;

  /// # LDX Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: LDX oper
  /// Operation Code:     AE
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int ldxAbsolute = 0xAE;

  /// # LDX Absolute Y
  ///
  /// Addressing Mode:    Absolute Y
  /// Instruction Syntax: LDX oper,Y
  /// Operation Code:     BE
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int ldxAbsoluteY = 0xBE;

  /// # LDY Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: LDY #oper
  /// Operation Code:     A0
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int ldyImmediate = 0xA0;

  /// # LDY Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: LDY oper
  /// Operation Code:     A4
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int ldyZeroPage = 0xA4;

  /// # LDY Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: LDY oper,X
  /// Operation Code:     B4
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int ldyZeroPageX = 0xB4;

  /// # LDY Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: LDY oper
  /// Operation Code:     AC
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int ldyAbsolute = 0xAC;

  /// # LDY Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: LDY oper,X
  /// Operation Code:     BC
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int ldyAbsoluteX = 0xBC;

  /// # LSR Accumulator
  ///
  /// Addressing Mode:    Accumulator
  /// Instruction Syntax: LSR
  /// Operation Code:     4A
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int lsrAccumulator = 0x4A;

  /// # LSR Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: LSR oper
  /// Operation Code:     46
  /// Byte Count:         2
  /// Cycle Count:        5
  static const int lsrZeroPage = 0x46;

  /// # LSR Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: LSR oper,X
  /// Operation Code:     56
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int lsrZeroPageX = 0x56;

  /// # LSR Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: LSR oper
  /// Operation Code:     4E
  /// Byte Count:         3
  /// Cycle Count:        6
  static const int lsrAbsolute = 0x4E;

  /// # LSR Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: LSR oper,X
  /// Operation Code:     5E
  /// Byte Count:         3
  /// Cycle Count:        7
  static const int lsrAbsoluteX = 0x5E;

  /// # NOP Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: NOP
  /// Operation Code:     EA
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int nopImplied = 0xEA;

  /// # ORA Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: ORA #oper
  /// Operation Code:     09
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int oraImmediate = 0x09;

  /// # ORA Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: ORA oper
  /// Operation Code:     05
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int oraZeroPage = 0x05;

  /// # ORA Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: ORA oper,X
  /// Operation Code:     15
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int oraZeroPageX = 0x15;

  /// # ORA Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: ORA oper
  /// Operation Code:     0D
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int oraAbsolute = 0x0D;

  /// # ORA Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: ORA oper,X
  /// Operation Code:     1D
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int oraAbsoluteX = 0x1D;

  /// # ORA Absolute Y
  ///
  /// Addressing Mode:    Absolute Y
  /// Instruction Syntax: ORA oper,Y
  /// Operation Code:     19
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int oraAbsoluteY = 0x19;

  /// # ORA Indirect X
  ///
  /// Addressing Mode:    Indirect X
  /// Instruction Syntax: ORA (oper,X)
  /// Operation Code:     01
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int oraIndirectX = 0x01;

  /// # ORA Indirect Y
  ///
  /// Addressing Mode:    Indirect Y
  /// Instruction Syntax: ORA (oper),Y
  /// Operation Code:     11
  /// Byte Count:         2
  /// Cycle Count:        5*
  static const int oraIndirectY = 0x11;

  /// # PHA Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: PHA
  /// Operation Code:     48
  /// Byte Count:         1
  /// Cycle Count:        3
  static const int phaImplied = 0x48;

  /// # PHP Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: PHP
  /// Operation Code:     08
  /// Byte Count:         1
  /// Cycle Count:        3
  static const int phpImplied = 0x08;

  /// # PLA Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: PLA
  /// Operation Code:     68
  /// Byte Count:         1
  /// Cycle Count:        4
  static const int plaImplied = 0x68;

  /// # PLP Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: PLP
  /// Operation Code:     28
  /// Byte Count:         1
  /// Cycle Count:        4
  static const int plpImplied = 0x28;

  /// # ROL Accumulator
  ///
  /// Addressing Mode:    Accumulator
  /// Instruction Syntax: ROL
  /// Operation Code:     2A
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int rolAccumulator = 0x2A;

  /// # ROL Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: ROL oper
  /// Operation Code:     26
  /// Byte Count:         2
  /// Cycle Count:        5
  static const int rolZeroPage = 0x26;

  /// # ROL Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: ROL oper,X
  /// Operation Code:     36
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int rolZeroPageX = 0x36;

  /// # ROL Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: ROL oper
  /// Operation Code:     2E
  /// Byte Count:         3
  /// Cycle Count:        6
  static const int rolAbsolute = 0x2E;

  /// # ROL Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: ROL oper,X
  /// Operation Code:     3E
  /// Byte Count:         3
  /// Cycle Count:        7
  static const int rolAbsoluteX = 0x3E;

  /// # ROR Accumulator
  ///
  /// Addressing Mode:    Accumulator
  /// Instruction Syntax: ROR
  /// Operation Code:     6A
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int rorAccumulator = 0x6A;

  /// # ROR Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: ROR oper
  /// Operation Code:     66
  /// Byte Count:         2
  /// Cycle Count:        5
  static const int rorZeroPage = 0x66;

  /// # ROR Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: ROR oper,X
  /// Operation Code:     76
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int rorZeroPageX = 0x76;

  /// # ROR Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: ROR oper
  /// Operation Code:     6E
  /// Byte Count:         3
  /// Cycle Count:        6
  static const int rorAbsolute = 0x6E;

  /// # ROR Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: ROR oper,X
  /// Operation Code:     7E
  /// Byte Count:         3
  /// Cycle Count:        7
  static const int rorAbsoluteX = 0x7E;

  /// # RTI Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: RTI
  /// Operation Code:     40
  /// Byte Count:         1
  /// Cycle Count:        6
  static const int rtiImplied = 0x40;

  /// # RTS Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: RTS
  /// Operation Code:     60
  /// Byte Count:         1
  /// Cycle Count:        6
  static const int rtsImplied = 0x60;

  /// # SBC Immediate
  ///
  /// Addressing Mode:    Immediate
  /// Instruction Syntax: SBC #oper
  /// Operation Code:     E9
  /// Byte Count:         2
  /// Cycle Count:        2
  static const int sbcImmediate = 0xE9;

  /// # SBC Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: SBC oper
  /// Operation Code:     E5
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int sbcZeroPage = 0xE5;

  /// # SBC Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: SBC oper,X
  /// Operation Code:     F5
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int sbcZeroPageX = 0xF5;

  /// # SBC Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: SBC oper
  /// Operation Code:     ED
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int sbcAbsolute = 0xED;

  /// # SBC Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: SBC oper,X
  /// Operation Code:     FD
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int sbcAbsoluteX = 0xFD;

  /// # SBC Absolute Y
  ///
  /// Addressing Mode:    Absolute Y
  /// Instruction Syntax: SBC oper,Y
  /// Operation Code:     F9
  /// Byte Count:         3
  /// Cycle Count:        4*
  static const int sbcAbsoluteY = 0xF9;

  /// # SBC Indirect X
  ///
  /// Addressing Mode:    Indirect X
  /// Instruction Syntax: SBC (oper,X)
  /// Operation Code:     E1
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int sbcIndirectX = 0xE1;

  /// # SBC Indirect Y
  ///
  /// Addressing Mode:    Indirect Y
  /// Instruction Syntax: SBC (oper),Y
  /// Operation Code:     F1
  /// Byte Count:         2
  /// Cycle Count:        5*
  static const int sbcIndirectY = 0xF1;

  /// # SEC Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: SEC
  /// Operation Code:     38
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int secImplied = 0x38;

  /// # SED Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: SED
  /// Operation Code:     F8
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int sedImplied = 0xF8;

  /// # SEI Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: SEI
  /// Operation Code:     78
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int seiImplied = 0x78;

  /// # STA Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: STA oper
  /// Operation Code:     85
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int staZeroPage = 0x85;

  /// # STA Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: STA oper,X
  /// Operation Code:     95
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int staZeroPageX = 0x95;

  /// # STA Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: STA oper
  /// Operation Code:     8D
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int staAbsolute = 0x8D;

  /// # STA Absolute X
  ///
  /// Addressing Mode:    Absolute X
  /// Instruction Syntax: STA oper,X
  /// Operation Code:     9D
  /// Byte Count:         3
  /// Cycle Count:        5
  static const int staAbsoluteX = 0x9D;

  /// # STA Absolute Y
  ///
  /// Addressing Mode:    Absolute Y
  /// Instruction Syntax: STA oper,Y
  /// Operation Code:     99
  /// Byte Count:         3
  /// Cycle Count:        5
  static const int staAbsoluteY = 0x99;

  /// # STA Indirect X
  ///
  /// Addressing Mode:    Indirect X
  /// Instruction Syntax: STA (oper,X)
  /// Operation Code:     81
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int staIndirectX = 0x81;

  /// # STA Indirect Y
  ///
  /// Addressing Mode:    Indirect Y
  /// Instruction Syntax: STA (oper),Y
  /// Operation Code:     91
  /// Byte Count:         2
  /// Cycle Count:        6
  static const int staIndirectY = 0x91;

  /// # STX Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: STX oper
  /// Operation Code:     86
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int stxZeroPage = 0x86;

  /// # STX Zero Page Y
  ///
  /// Addressing Mode:    Zero Page Y
  /// Instruction Syntax: STX oper,Y
  /// Operation Code:     96
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int stxZeroPageY = 0x96;

  /// # STX Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: STX oper
  /// Operation Code:     8E
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int stxAbsolute = 0x8E;

  /// # STY Zero Page
  ///
  /// Addressing Mode:    Zero Page
  /// Instruction Syntax: STY oper
  /// Operation Code:     84
  /// Byte Count:         2
  /// Cycle Count:        3
  static const int styZeroPage = 0x84;

  /// # STY Zero Page X
  ///
  /// Addressing Mode:    Zero Page X
  /// Instruction Syntax: STY oper,X
  /// Operation Code:     94
  /// Byte Count:         2
  /// Cycle Count:        4
  static const int styZeroPageX = 0x94;

  /// # STY Absolute
  ///
  /// Addressing Mode:    Absolute
  /// Instruction Syntax: STY oper
  /// Operation Code:     8C
  /// Byte Count:         3
  /// Cycle Count:        4
  static const int styAbsolute = 0x8C;

  /// # TAX Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: TAX
  /// Operation Code:     AA
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int taxImplied = 0xAA;

  /// # TAY Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: TAY
  /// Operation Code:     A8
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int tayImplied = 0xA8;

  /// # TSX Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: TSX
  /// Operation Code:     BA
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int tsxImplied = 0xBA;

  /// # TXA Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: TXA
  /// Operation Code:     8A
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int txaImplied = 0x8A;

  /// # TXS Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: TXS
  /// Operation Code:     9A
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int txsImplied = 0x9A;

  /// # TYA Implied
  ///
  /// Addressing Mode:    Implied
  /// Instruction Syntax: TYA
  /// Operation Code:     98
  /// Byte Count:         1
  /// Cycle Count:        2
  static const int tyaImplied = 0x98;
}
