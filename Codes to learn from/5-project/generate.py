# %%

N = 7

with open('input.txt', 'w') as file:
    file.writelines(f'{bin(i)[2:]:>0{N}}\n' for i in range(2**N))


# %%
from random import shuffle

N = 7

data = list(range(2**N))

shuffle(data)

with open('input.txt', 'w') as file:
    file.writelines(f'{bin(i)[2:]:>0{N}}\n' for i in data)



# %%
