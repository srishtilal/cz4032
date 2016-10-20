import random

with open("dataa.csv") as data:
    with open("test1.csv", 'w') as test:
        with open("train1.csv", 'w') as train:
            header = next(data)
            test.write(header)
            train.write(header)
            for line in data:
                if random.random() > 0.70:
                    train.write(line)
                else:
                    test.write(line)