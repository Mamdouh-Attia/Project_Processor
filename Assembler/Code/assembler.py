
from ast import literal_eval


register = {
    "R1": "000",
    "R2": "001",
    "R3": "010",
    "R4": "011",
    "R5": "100",
    "R6": "101",
    "R7": "110",
    "R8": "111",

}
opcodes = {
    "NOP":  '00101',
    "SETC": '00000',
    "CLRC": '00110',
    "NOT":  '00100',
    "INC":  '00111',
    "DEC": '01000',
    "OUT": '01001',
    "IN": '01010',
    "MOV": '01011',
    "ADD": '00011',
    "SUB": '01100',
    "AND": '01101',
    "OR": '01110',
    "SHL": '01111',
    "SHR": '10000',
    "PUSH": '10001',
    "POP": '10010',
    "LDM": '00001',
    "LDD": '10011',
    "STD": '00010',
    "JZ": '10100',
    "JN": '10101',
    "JC": '10110',
    "JMP": '10111',
    "CALL": '11000',
    "RET": '11001',
    "RTI": '11010'
}
immediateValue = bin(0)[15:]


def isImmediate(dst):
    return False if dst in register else True


def getInstructionCode(instructionType, data):
    Instruction = ""
    opcode = opcodes[instructionType]
    src = "000"   # initial value
    immediateValue = "0000000000000000"  # initial value
    if (register[data[0]] != None):
        src = register[data[0]]
        dst = "000"

        if (len(data) > 1):
            dst = register[data[1]] if data[1] in register else "00000"
            if (isImmediate(data[1])):
                dst = src
                src = "000"
        # if STD, reverse the sources
        # if (instructionType == "STD"):
            # src, dst = dst, src
        # the final instruction
        Instruction = opcode + src + dst + "00000" + immediateValue

        return Instruction
    else:
        raise ("Unknown Instruction")


def incrementHexa(hexadecimal):

    table = {'0': 0, '1': 1, '2': 2, '3': 3,
             '4': 4, '5': 5, '6': 6, '7': 7,
             '8': 8, '9': 9, 'A': 10, 'B': 11,
             'C': 12, 'D': 13, 'E': 14, 'F': 15,
             'a': 10, 'b': 11, 'c': 12, 'd': 13,
             'e': 14, 'f': 15}

    res = 0

    # computing max power value
    size = len(hexadecimal) - 1

    for num in hexadecimal:
        res = res + table[num]*16**size
        size = size - 1

    return res


def assembler(files):

    input_file_path = files[0]
    output_file_path = files[1]
    finalInstruction = None
    print(files)
    # Using readlines()
    assembly_file = open(input_file_path, "r")
    Lines = assembly_file.readlines()
    assembly_file.close()

    count = 0
    result = []
    data_to_be_written = {}

    # initialization
    for iterator in range(1000000):
        hexa = hex(iterator)
        data_to_be_written[hexa[2:len(hexa)]] = ": xxxxxxxxxxxxxxxx" + "\n"

    result.append(
        "// memory data file (do not edit the following line - required for mem load use)" + "\n")
    result.append("// instance=/testFetch/f/instructionMemory/Memo" + "\n")
    result.append(
        "// format=mti addressradix=h dataradix=s version=1.0 wordsperline=1" + "\n")

    # Strips the newline character
    i = 0
    position = 20
    for line in Lines:
        finalInstruction = "xxxxxxxxxxxxxxxx"
        # if comment
        if (line[0] == '#'):
            continue
        first_split = line.split()
        i += 1
        second_split = first_split[1].split(",")
        # if it is ORG
        if (first_split[0] == ".ORG"):
            position = second_split[0]
            continue

        finalInstruction = getInstructionCode(first_split[0], second_split)
        data_to_be_written[position] = ": " + finalInstruction[0:16] + "\n"
        position_int = incrementHexa(position)
        position_int = position_int + 1
        position = hex(position_int)
        position = position[2:len(hexa)]
        data_to_be_written[position] = ": " + finalInstruction[16:32] + "\n"
        position_int = incrementHexa(position)
        position_int = position_int + 1
        position = hex(position_int)
        position = position[2:len(hexa)]

    # final data to be written
    for iterator in range(1000000):
        hexa = hex(iterator)
        result.append(hexa[2:len(hexa)] +
                      data_to_be_written[hexa[2:len(hexa)]])

    # writing to file
    outputFile = open(output_file_path, 'w')
    outputFile.writelines(result)
    outputFile.close()
    print('finished writing')
    return
