def dumb(a, b):
    if a == 0:
        return b + 1
    elif b == 0:
        return a
    else:
        return a + a + b + dumb(a - 1, b - 1)
    
print(dumb(3, 5))