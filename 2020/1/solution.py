

file = open("input2", "r")

entries = []
for line in file.readlines():
    entries.append(int(line))

entries.sort()

for entry in entries:
    for entry2 in entries:
        for entry3 in entries:
            if entry + entry2 + entry3 == 2020:
                print("entry1: {} entry2: {} entry3: {}", entry, entry2, entry3)


# print(entries)