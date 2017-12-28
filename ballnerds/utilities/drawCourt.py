from matplotlib.patches import Circle, Rectangle, Arc
import matplotlib.pyplot as plt
import matplotlib.cm as cm

'''
Draws the court.
'''
# Shamelessly adapted from http://savvastjortjoglou.com/nba-shot-sharts.html (and rotated to landscape...)

def draw_court(ax=None, color='black', lw=2, outer_lines=False):
    # If an axes object isn't provided to plot onto, just get current one
    if ax is None:
        ax = plt.gca()

    outer_box = Rectangle((-470, -80), 190, 160, linewidth=lw, color=color, fill=False)

    # Restricted Zone, it is an arc with 4ft radius from center of the hoop
    restricted = Arc((-417.5, 0), 80, 80, theta1=270, theta2=90, linewidth=lw, color=color)

    # Three point line
    # Create the side 3pt lines, they are 14ft long before they begin to arc
    corner_three_a = Rectangle((-470, 220), 140, 0, linewidth=lw, color=color)
    corner_three_b = Rectangle((-470, -220), 140, 0, linewidth=lw, color=color)
    # 3pt arc - center of arc will be the hoop, arc is 23'9" away from hoop
    # I just played around with the theta values until they lined up with the threes
    three_arc = Arc((-417.5, 0), 475, 475, theta1=292, theta2=68, linewidth=lw, color=color)

    # List of the court elements to be plotted onto the axes
    court_elements = [outer_box, restricted, corner_three_a, corner_three_b, three_arc]

    if outer_lines:
        # Draw the half court line, baseline and side out bound lines
        outer_lines = Rectangle((-250, -47.5), 500, 470, linewidth=lw,
                                color=color, fill=False)
        court_elements.append(outer_lines)

    # Add the court elements onto the axes
    for element in court_elements:
        ax.add_patch(element)

    return ax