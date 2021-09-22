# Prompt user for file to read
inp_file=open(input('Enter filename:\n'))
out_file = inp_file

#Parser
#Remove white space and commenting
parsed = []
lines=inp_file.readlines()
for line in lines:
    if line.startswith('//') :
        continue
    elif line.startswith('\n') :
        continue
    line = line.lstrip()
    line = line.split()
    line = line[0]
    parsed.append(line)
inp_file.close()

#Build address table, convert parsed data to raw instructions
def table(zork):

    addrtable = {"@SP": "@0", "@LCL": "@1", "@ARG": "@2", "@THIS": "@3", "@THAT": "@4",
    "@R0": "@0", "@R1": "@1", "@R2": "@2", "@R3": "@3", "@R4": "@4", "@R5": "@5", "@R6": "@6",
    "@R7": "@7", "@R8": "@8", "@R9": "@9", "@R10": "@10", "@R11": "@11", "@R12": "@12",
    "@R13": "@13", "@R14": "@14", "@R15": "@15", "@SCREEN": "@16384", "@KBD": "@24576"}
    counter = 16
    linecount = 0
    parsednolabel = []

    for instruction in zork :
        linecount = linecount + 1
        if instruction.startswith('(') :
            instruction = instruction.strip("(")
            instruction = instruction.strip(")")
            print(instruction)
            instruction = "@" + instruction
            linecount = linecount - 1
            addrtable[instruction] = "@" + str(linecount)

    for instruction in zork :
        if instruction.startswith('@') :
            if instruction[1] > '9' :

                if instruction not in addrtable:
                    addrtable[instruction] = "@" + str(counter)
                    counter = counter + 1
                    parsednolabel.append(addrtable[instruction])
                    instruction = addrtable[instruction]
                else:
                    parsednolabel.append(addrtable[instruction])
                    instruction = addrtable[instruction]

            else:
                parsednolabel.append(instruction)

        elif instruction.startswith('('):
            continue

        else:
            parsednolabel.append(instruction)

    return parsednolabel

#Translator
#a instruction
#convert to binary value and return
def ainst(aopcode):
    abinary = aopcode.lstrip('@')
    abinary = int(abinary)
    abinary = bin(abinary)
    abinary = str(abinary)
    abinary = abinary.lstrip('0b')
    abinary = abinary.zfill(16)
    return abinary

#c instruction
#convert to binary value and return
def cinst(copcode):
    cbinary = copcode

    complist = {'0': '0101010', '1': '0111111', '-1': '0111010', 'D': '0001100',
    'A': '0110000', 'M': '1110000', '!D': '0001101', '!A': '0110001', '!M': '1110001',
    '-A': '0110011', '-M': '1110011', 'D+1': '0011111', 'A+1': '0110111',
    'M+1': '1110111', 'D-1': '0001110', 'A-1': '0110010', 'M-1': '1110010',
    'D+A': '0000010', 'D+M': '1000010', 'D-A': '0010011', 'D-M': '1010011',
    'A-D': '0000111', 'M-D': '1000111', 'D&A': '0000000', 'D&M': '1000000',
    'D|A': '0010101', 'D|M': '1010101'}

    destlist = {'M': '001', 'D': '010', 'MD': '011', 'A': '100', 'AM': '101', 'AD': '110', 'AMD': '111'}

    jumplist = {'JGT': '001', 'JEQ': '010', 'JGE': '011', 'JLT': '100', 'JNE': '101', 'JLE': '110', 'JMP': '111'}

#check if jump instruction and select corresponding bits
    if (cbinary.find(';') > 0 ) :
        jump = cbinary[(cbinary.find(';') + 1) :]
        jump = jump.strip('\n')
        jump = jumplist[jump]
        dest = '000'
        comp = cbinary[: (cbinary.find(';'))]
        comp = complist[comp]
#not a jump instruction
    else :
        jump = '000'
        dest = cbinary[: (cbinary.find('='))]
        dest = destlist[dest]
#comp
        comp = cbinary[(cbinary.find('=') + 1) :]
        comp = comp.strip('\n')
        comp = complist[comp]

#combine binary strings and return
    cbinary = ('111' + comp + dest + jump)
    return cbinary

#create new file
out_file = str(out_file)
out_file = out_file.replace('asm', 'hack')
out_file = out_file.split('\'')
out_file = out_file[1]
print(out_file)
outhandle=open(out_file, 'w')

#write binary strings to new file
parsednolabel = table(parsed)
for instruction in parsednolabel :
    if instruction.startswith('@') :
        instruction = (ainst(instruction) + '\n')
        outhandle.write(instruction)
        print(instruction)
        continue
    else:
        instruction = (cinst(instruction) + '\n')
        outhandle.write(instruction)
        print(instruction)

print('Assembly completed successfully')
outhandle.close()
