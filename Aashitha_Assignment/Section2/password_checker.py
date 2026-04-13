import re

password = input("Enter password: ")

score = 0

# Length check
if len(password) >= 8:
    score += 1
else:
    print("Password should be at least 8 characters")

# Uppercase check
if re.search(r"[A-Z]", password):
    score += 1
else:
    print("Add uppercase letters")

# Lowercase check
if re.search(r"[a-z]", password):
    score += 1
else:
    print("Add lowercase letters")

# Number check
if re.search(r"[0-9]", password):
    score += 1
else:
    print("Add numbers")

# Special character check
if re.search(r"[!@#$%^&*(),.?\":{}|<>]", password):
    score += 1
else:
    print("Add special characters")

# Strength result
if score <= 2:
    print("Strength: Weak")
elif score <= 4:
    print("Strength: Medium")
else:
    print("Strength: Strong")