### Questions for colour dataset workbook:

1. Can you write a function **pick_common_colors** that takes a dataframe and a column from the dataframe that looks for common colour names and groups them?

- For example: 'light green', 'dark green' and 'Green' would all be renamed to 'green'
- Try modifiying the dataframe inplace.

2. Do you think this function would properly classify colours? Would this allow us to apporach a solution algorithmically?

```
def classify_color(r, g, b):
    if pd.isna(r) or pd.isna(g) or pd.isna(b):
        return 'unknown'

    # Convert to int if needed
    r, g, b = int(r), int(g), int(b)

    if r > 200 and g < 50 and b < 50:
        return 'red'
    elif r < 50 and g > 200 and b < 50:
        return 'green'
    elif r < 50 and g < 50 and b > 200:
        return 'blue'
    elif r > 200 and g > 200 and b < 50:
        return 'yellow'
    elif r > 200 and g < 100 and b > 200:
        return 'pink'
    elif r < 50 and g < 50 and b < 50:
        return 'black'
    elif r > 200 and g > 200 and b > 200:
        return 'white'
    elif abs(r - g) < 20 and abs(r - b) < 20 and r < 150:
        return 'gray'
    elif r > 100 and b > 100 and g < 100:
        return 'purple'
    elif r > 200 and g > 100 and b < 100:
        return 'orange'
    else:
        return 'other'

def classify_colors(df):
    df['selected_color'] = df.apply(lambda row: classify_color(row['r'], row['g'], row['b']), axis=1)
    return df

dataframe_colours = classify_colors(clean_df)

print(dataframe_colours.to_string())
```

### Answers for colour dataset workbook:

```
def pick_common_colors(df, color_col='name'):
    # List of common color keywords (expand as you like)
    common_colors = [
        'red', 'blue', 'green', 'pink', 'black', 'white', 'yellow',
        'orange', 'purple', 'gray', 'grey', 'brown', 'lemon', 'sky'
    ]

    # Lowercase the color names for case-insensitive matching
    df[color_col] = df[color_col].str.lower()

    # Loop through each color and assign it if matched
    for color in common_colors:
        mask = df[color_col].str.contains(rf'\b{color}\b', regex=True)
        df.loc[mask, color_col] = color
```

2. Well the result shows that its not great at doing that, but still roughly half are 'unknown'.
   Maybe even the words we use to describe colours is not specific enough?
