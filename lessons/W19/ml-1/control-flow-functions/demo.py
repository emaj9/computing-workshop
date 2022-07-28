# branching is achieved with the if-else syntax

if condition:
    # block 1
    pass
else:
    # block 2
    pass

# Python runs the condition to see if it's True or False.
# If it's True, then it runs block 1, skipping block 2.
# If it's False, then it runs block 2, skipping block 1.

# For example.
age = 24
print("You arrive in front of a bar. The bouncer looks at your ID.")
# Check if the person is (legally) an adult
if age >= 18:
    print("He hands it back to you, and waves you in.")
else:
    print("'Sorry, come back when you're older,' he says")

## Testing multiple conditions

# We can test multiple conditions in succession using 'elif'

if age >= 65:
    print("Sorry, we don't let in seniors.")
elif age >= 18:
    print("Right this way.")
else:
    print("Sorry, we don't let in kids.")

# We can write this without elif, but the indentation gets deeper.

if age >= 65:
    pass
else:
    if age >= 18:
        pass
    else:
        pass

