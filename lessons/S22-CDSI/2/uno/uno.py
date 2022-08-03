import random

# A player and a hand are the same thing.
# A hand is a list of cards.
# A card is a color together with a value.

RED, GREEN, YELLOW, BLUE, BLACK = "red", "green", "yellow", "blue", "black"
PLUS2, REVERSE, SKIP, PLUS4, WILD = "+2", "reverse", "skip", "+4", "wild"

deck = [
    (color, value)
    for color in [RED, GREEN, YELLOW, BLUE]
    for value in [PLUS2, REVERSE, SKIP] + list(range(10))
] * 2 + [(BLACK, PLUS4)] * 4 + [(BLACK, WILD)] * 4
# ^ The pile from which cards are drawn.
# The top of the deck is the last element of the list.

# Here are some example cards:
# - ("blue", "+2")
# - ("black", "wild")
# - ("yellow", 0)
# - ("red", "reverse")
# Notice that numeric values are actually represented as integers, whereas any
# special values are represented as strings!

discard = []
# The pile into which cards are played face-up.
# The top of the discard pile is the last element of the list.

players = [[], [], [], []]
# ^ A list of hands. Each hand is itself a list of cards.
# So `players` is a list of lists of cards.

current_player_i = 0 # index into the 'players' list

current_direction = "forward" # or "backward"
# ^ In uno, the flow of who plays next can switch due to the "reverse" card.
# We choose to represent the direction using the strings "forward" and
# "backward" for clockwise and counter-clockwise respectively.
# Concretely, "forward" means that the next player is the _subsequent_ player in
# the `players` list; "backward" means that the next player is the _previous_
# player in the list.

last_black_color = None
# After playing a black card (either Wild or Wild+4) the player chooses a color
# for the game to continue with.
# Normally, when deciding what cards can be played next, we just compare the
# last card played (top of discard) with the card to be played. However, if the
# last card played is a black card, then we need to know what color was chosen
# by the player who played that black card.
# This variable represents that choice.
# A consequence is that `can_follow` is now asymmetrical: a black card can
# follow any card, but for a card C to follow a black card, the color of C must
# match the color indicated in this variable.

def flip_direction():
    global current_direction
    if current_direction == "forward":
        current_direction = "backward"
    else:
        current_direction = "forward"

def go_to_next_player():
    global current_player_i
    current_player_i = next_player_i()

def next_player_i():
    global current_player_i, current_direction
    if current_direction == "forward":
        return (current_player_i + 1) % len(players)
    elif current_direction == "backward":
        return (current_player_i - 1) % len(players)
    else:
        raise RuntimeError("impossible direction")

def deal():
    """Deals seven cards to each player from the deck, and one card to the
    discard pile.
    Preconditions:
    - the deck is already shuffled.
    - the player hands are empty.
    - the deck has at least N*7+1 cards in it.
    Postconditions:
    - The deck has exactly N*7+1 fewer cards in it where N is the number of
      players.
    - Each player hand has exactly seven cards in it.
    - The discard pile has one more card in it.
    """
    global deck, players, discard
    for player in players:
        player.extend(deck[-7:])
        deck = deck[:-7]
    discard.append(deck.pop())

def color_of(card):
    return card[0]

def value_of(card):
    return card[1]

# EXERCISE: return a nice string representation of the card
# e.g. ("blue", "+2") --> "blue +2"
# ("blue", 4) --> "blue 4"
def card_str(card):
    # Difficulty: this would be the most obvious implementation:
    # return color_of(card) + " " + value_of(card)
    # but it's slightly incorrect because of cards with integer values.
    # Those need to be converted to strings.
    return color_of(card) + " " + str(value_of(card))

# EXERCISE:
def can_follow(card1, card2):
    """Decides whether `card1` may be played on top of `card2`."""
    return any([
        BLACK == color_of(card1),
        color_of(card2) == BLACK and last_black_color == color_of(card1),
        value_of(card1) == value_of(card2),
        color_of(card1) == color_of(card2),
    ])

def interpret_card(card):
    """Performs the effect of a given card."""
    global last_black_color

    v = value_of(card)
    if type(v) == int:
        pass # Numeric cards have no effect.
    elif v == "skip":
        go_to_next_player()
    elif v == "reverse":
        flip_direction()
    elif v == "+2":
        players[next_player_i()].extend([draw(), draw()])
    elif v == "+4":
        players[next_player_i()].extend([draw(), draw(), draw(), draw()])
        last_black_color = input("What color goes next? ")
    elif v == "wild":
        last_black_color = input("What color goes next? ")
    else:
        raise RuntimeError("impossible card value: " + v)

# EXCERCISE:
def winner():
    """Decides if anybody won the game, i.e. their hand is empty. Returns the
    index of the winner player if any, or None."""
    global players
    for i, player in enumerate(players):
        if len(player) == 0:
            return i
    return None

# EXERCISE:
# Find a way to shuffle the deck using the docs for the random module
# or by looking at stackoverflow and _understanding_ what is written there.
def shuffle():
    global deck
    deck = random.choices(deck, k=len(deck))

def draw():
    """Draws a card from the deck and returns it."""
    global deck, discard
    # Trying to draw from an empty deck would produce an error.
    # When the deck is empty, we shuffle _all but the last_ discarded card to produce a new deck.
    if len(deck) == 0:
        deck = discard[:-1]
        discard = [discard[-1]]
        shuffle()
    return deck.pop()

def game():
    global discard

    shuffle()
    deal()

    while winner() == None:
        current_player = players[current_player_i]
        print("---- It's the turn of player", current_player_i + 1, '----')
        print("The next player is", next_player_i() + 1)
        print("You have the following cards:")
        for i, c in enumerate(current_player):
            print(i + 1, "-", card_str(c))

        last_discard = discard[-1]
        print("The last card played is a", card_str(last_discard))
        if BLACK == color_of(last_discard):
            print("    and the color", last_black_color, "was chosen.")

        playable_cards = [(j, c) for j, c in enumerate(current_player) if can_follow(c, last_discard)]
        if len(playable_cards) == 0:
            print("No cards in hand can follow the last card. You must pick up.")
            i = -1
        else:
            print("So of your cards, the following can be played:")
            for i, (j, c) in enumerate(playable_cards):
                print(i + 1, "-", card_str(c))
            i = -1 + int(input("Which # card will you play? (Choose 0 to pick up.) "))

        # This block will give a value to `selected_card`
        if i == -1: # the player is deciding to pick up.
            drawn_card = draw()
            print("You pick up a", card_str(drawn_card))
            if can_follow(drawn_card, last_discard):
                choice = input("Do you want to play this card? (y/n) ")
                if choice == "y":
                    selected_card = drawn_card
                else:
                    current_player.append(drawn_card)
                    selected_card = None
            else:
                selected_card = None
        else: # player is playing from their hand
            j, c = playable_cards[i]
            selected_card = current_player.pop(j)

        if selected_card is not None:
            discard.append(selected_card)
            interpret_card(selected_card)

        go_to_next_player()

    print("Player", winner() + 1, "wins!")
