def convertolist(flist):
    stripped = flist.rstrip('\n')
    split = stripped.split(',')
    tape = [int(split[x])  for x in range(len(split))]
    return tape

def IntCode(memoryinput):
    memory = memoryinput
    pointer = 0
    while True :
       
        if memory[pointer] == 1 :
            memory[memory[pointer+3]] = memory[memory[pointer+1]] + memory[memory[pointer+2]]
            pointer+=4
              
        elif memory[pointer] == 2:
            memory[memory[pointer+3]] = memory[memory[pointer+1]] * memory[memory[pointer+2]]
            pointer+=4

        elif memory[pointer] == 99:
            break
        
        else:
            print("FUCK")

    return memory[0]

def verbnounfinder():
    init_memory = convertolist(readfile)
    trymemory = init_memory[0:149]
    for x in range(100):
        trymemory[1] = x
        for y in range(100):
            trymemory[2] = y
            if IntCode(trymemory) == 19690720:
                print(trymemory[0:3])
                break
            trymemory = init_memory[0:149]
            trymemory[1] = x
        trymemory = init_memory[0:149]

with open('test', 'r') as inpfile:
    readfile = inpfile.read()
verbnounfinder()
