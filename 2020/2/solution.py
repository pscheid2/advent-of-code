
class Password:
    def __init__(self, first, second, letter, password):
        self.first = first
        self.second = second
        self.letter = letter
        self.password = password
        
    def __repr__(self):
        return "first: {} second: {} letter {} password {} is_valid: {}".format(self.first, self.second, self.letter, self.password, self.is_valid())

    def is_valid(self):
        return (self.password[self.first] == self.letter) != (self.password[self.second] == self.letter)


file = open("input2", "r")

passwords = []
for line in file.readlines():
    tokens = line.split(" ")
    first = int(tokens[0].split("-")[0]) - 1
    second = int(tokens[0].split("-")[1]) - 1
    letter = tokens[1].strip(":")
    password = tokens[2]
    passwords.append(Password(first, second, letter, password))


print(passwords)

valid_passwords = 0
for password in passwords:
    if password.is_valid():
        valid_passwords += 1

print(valid_passwords)